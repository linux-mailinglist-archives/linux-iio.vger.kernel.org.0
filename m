Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB463547D56
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 03:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiFMBRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jun 2022 21:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiFMBRj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 21:17:39 -0400
Received: from sonic309-26.consmr.mail.ir2.yahoo.com (sonic309-26.consmr.mail.ir2.yahoo.com [77.238.179.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4851E2F646
        for <linux-iio@vger.kernel.org>; Sun, 12 Jun 2022 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655083056; bh=Oy+2Rh6qp6A6u+U0hZbSnk/Susg0ogMovS55aFUE2Rs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EoWteCLvGGRZsLEnwoS0mx0BcPzaT/wmHtNIWoVQ4W8+ECPHr7yABkwVtiiuLvR9h+ndqPhLJgzCkIlK3xZNGFW77wpX1tl60nYwRMowt02DwjEEcwT0E27m36rr1bk1ySkBVvT+PY8lgyFPuA3oGkfpz2BZhwqEk6LAIUhhtZP4islgsTjqkYDYMXl9QQrgS/pWKVnr7NSwkXRE2/uChhCRihUh08CYWtlPagnAREtW4TNVU7x+Nfkw+CLWa9Mli/OekqQBLy7VAi1e5zMoBHze0eyxJPb4cPVGEykfiLKU6Nk7fts1EXGJk+IJU/gqkTdpHeiNmddPh/IO/eting==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655083056; bh=e3yXvsqIFqA91T/9a2ztqe65MxsVQyq2ISwDk9ZE6QQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=M4ppwguxCXqT7mNPciqh7qWRrvjxcAKcpn0XuwriMwg4MpXqd8+jeQb8Ru9oa09acMhtLu/AFwc5shgRADQz1nJ1acCyuqcoO3hYqg9QmWoD/VGXeIKbFQoMsQ8ezFCBe27ed+d/uuTq5XK3TqCExv/Lzg8cG19Ccpb51hHBwcNED1sg13L5GUZ0a1hwfmSakCIxa1fwpghQaLgnv/80/ytXNXOhmZzIhni9Y/0FflJZ0zgkdozv09PCadRs6Ah8+SafQj3J019sV7pOzxSUKOjD3QY+zG28aPPOFt3gOeALySI9tvVEQpFXS6tQndDG7B+P4QAIWY49KqQ7S8Du3A==
X-YMail-OSG: yJG04jwVM1lPlt5Ry19ml1uQMuEr.rDjY0nk_JYoXgSGY_eJnZlxfaAFrUSKUOz
 5si49AjEJp7biDjqY_ISwY6J6Z9M5e__xFbLEs6XxRmdQhDNLBsFg28KwmLsBBhoUffwYfGLXnkk
 C0RKe5F9WLDZzbxmRtwG0jyDsY94g23CouN4vMiIxHymimw5UqUDoxdFAUO2zSiqteAYDlDXL2Ut
 yEylStM67YjaFktJuyiA0WlvhiBP5qkoWP_3Yh0eQhnH8FquxiUoC6R6J8XPjivE8TXWQAMCdLRP
 Y2YZ0.c_eehxbu8GHtKz2_HWwyWY1zIxWZ8hhBaoYpICv4mt2TjODQAC32wf6eLKlGyj1.fNBFBK
 4f6Wp7nlhD9pRa5zU4dyYploJWVNtHsArY5ROgIcEpJowkeLBNFUuDe4owucE0j.NjNfNxmwdpLu
 lupnFvT6snpjJT5EQpLWgHnlqb.t02WitPpbdPz2_CEeUpGo.z6W5vKHrywv14YcKGwSI5jMPuye
 .wz8bEQCKjHBRMshZoMe.X1erlG6Yrny0twv3cyxGrPZQ.poFKSTOKiP1kz8Gt4tZvQfD.6dxoYu
 Q.aFBR3o8PTtSg_X2MmoO7962aJGr7MspxGxyK9ahXk0A5SQdr_.armp6EMcSnUr3Vh38e1C.Ekc
 fXOBYZjqeWiN8IE7HyHqEfjaGv0KO4GfKjZKBaSQJqvmIXnG8pM1_G4r4P8RRgmtEm0dve11M86O
 Un6PPPp4nXJQdedNwFQlaxvU2T8PKaKyfHyf22N8WpAma8jbsiX86ioUKf5Pi6Jw1UgNKBLbcqp8
 t0RtUu9tVnsb3e2VxSqRIO3LTvi_ud_5ky4Xoor0F5iOAAkVvWZX__X.AljpS4iDcTzMxcFatakh
 _mgIsitDMm_.kq8vkZwPqGvrE3slzqY7HB5AzUQgOltMJbRVSyyZGW460isyijLui.7TSbACnpLF
 Vdw9a_iJEHhaveZygxdjF4UbrIHaA28htqjUolZAjMj00kktrb6WKoMffVwAw75y9k9CSZdttRPk
 p7XnsG_j2Mm2eCflcYs2sib7KfmUM8MIXg3KfwNN_6dk5_gvacVroY6oT9OT3t6FfaiLQeVrGFFH
 f64s3mafH9lv_MGogdwx6lgdD0OJuWEW9YCcDQkb0hHvFkQQnqodfe66UOWmeCcz8aJZu47G1XbP
 RYHZ4jxIIhRGKrisQmb3r2QwveUrrhGLKbPwTmzwVpFTCKBwpBZDjtvOgxO.EYwMADDj5fs1wIMq
 u9eCUTCS3j5JuK81n2erjZrESHAR4rOHxoH.kGplXvx4UVj47PGC6_8.r85wA1RcyRjHAw9QMNsd
 6eLx6KHLTo0JvPKmWhTDv23oChuD3QG3bnd1Mn3AFumcN.Un0GH.Se74Zh9kcwcOblLU5Kdy39sp
 V..dkpjk5bGo_WKNOJ8SfXkZwG90Hko1rAfhYowgOxoQ1h62u8doQjvZEPxyfJXonKi673HQ9Rlx
 8V4LWx83hK6vSlZavm32HgBehTAWPKNN.JonTQJbKbhH3pVzfojv0SvBDnU4Al3JdpD_Xs5GAzAN
 zzjaJ3Idqmi3wKH.2FmozYFWfbpcya5skZttTMS6mu2pJrsH40T3so8ifEye6_E5KZGKNO_Ng7kh
 6n860wTU9y9T9AR2joUJqHaqqgzZ3bb0y3LssH94LT.l7i74mLVb91AsiulJE19IRjDhPUCQ5wdz
 V5Js7HuH5hwWu0J3EtPif8krE0dYySat_XP8u1dB474RPT71f.CzpuH9tS2yFxdMlhUXvbuaWoi7
 WIkUjwNlauLJv52NOo.CzjtcJfVOEvnTZWEH93AmJ.V9d2C2nUhT_OkQyoVQYwBzNcYVMI3PFCMF
 _GQ3FtHpnuxemH0a65rMHAjJZDJauwVcw.HSqFmchFF0YGiCJVWPFG7bdOaE8omzRxHmt39T1dMA
 ._JPG9EcoIbTfWuEgqBK6z7caTa1Z7cHaWqxCJlj9sOdvRxz5joIvaIIPtjBUaNym694DEKAO0kL
 vWXANnAlEATn0KnZ62q7a7Jc5i5OIeRm.iTIr8_tgP.7WVeRwAt5W4jApFG2NNCjflAmAs0b3ZJ1
 cDJnrV_A1vuUUAJaB0RUsRsTkhlZBmIwnQRswgfcl1B8NJL9DA_FMcRef2nVqIj4ukOBYbA0n5fG
 Poi3Bv4ljtwfySI1yGvei5axSu_9YZ7KavNweHPUgdGpJ.Gs81mQiNA9oJRg9sXPWwoMf2eNT6gs
 ILzgcgZwX.DmQ1emv_8gO8QSc8lkNuD0gl5fl5eS7jNgfwquf7tZxyGOmgCi3J38rJVwl7AhoSWd
 ZZafApYHC7Q--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Mon, 13 Jun 2022 01:17:36 +0000
Received: by hermes--canary-production-ir2-6c7595c778-c54g9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4419c1e75f73c3038b6a16962b132f56;
          Mon, 13 Jun 2022 01:17:32 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 1/7] iio: magnetometer: yas530: Change data type of hard_offsets to signed
Date:   Mon, 13 Jun 2022 03:17:08 +0200
Message-Id: <b9948169abc991e37f9afb3ca251a151b15d8881.1655081082.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655081082.git.jahau@rocketmail.com>
References: <cover.1655081082.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The "hard_offsets" are currently unsigned u8 but they should be signed as they
can get negative. They are signed in function yas5xx_meaure_offsets() and in the
Yamaha drivers [1][2].

[1] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-12.1/drivers/sensor/compass/yas.h#L156
[2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L91

Fixes: de8860b1ed47 ("iio: magnetometer: Add driver for Yamaha YAS530")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 9ff7b0e56cf6..b58a9c51e9ff 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -132,7 +132,7 @@ struct yas5xx {
 	unsigned int version;
 	char name[16];
 	struct yas5xx_calibration calibration;
-	u8 hard_offsets[3];
+	s8 hard_offsets[3];
 	struct iio_mount_matrix orientation;
 	struct regmap *map;
 	struct regulator_bulk_data regs[2];
-- 
2.35.1

