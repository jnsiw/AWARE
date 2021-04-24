.class final Lcom/lody/whale/xposed/XC_MethodReplacement$1;
.super Lcom/lody/whale/xposed/XC_MethodReplacement;
.source "XC_MethodReplacement.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/lody/whale/xposed/XC_MethodReplacement;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>(I)V
    .locals 0
    .param p1, "priority"    # I

    .line 58
    invoke-direct {p0, p1}, Lcom/lody/whale/xposed/XC_MethodReplacement;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected replaceHookedMethod(Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;)Ljava/lang/Object;
    .locals 1
    .param p1, "param"    # Lcom/lody/whale/xposed/XC_MethodHook$MethodHookParam;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 61
    const/4 v0, 0x0

    return-object v0
.end method
