class BaseModel {
  verify(variable, [int? index]) {
    if (variable is! bool) {
      if (index != null && variable != null) return variable[index].toString();
      return variable;
    }
    return null;
  }
}
