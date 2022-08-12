Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7397F5916EE
	for <lists+linux-iio@lfdr.de>; Fri, 12 Aug 2022 23:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbiHLVzB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiHLVyq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 17:54:46 -0400
Received: from sonic311-31.consmr.mail.ir2.yahoo.com (sonic311-31.consmr.mail.ir2.yahoo.com [77.238.176.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E507B5143
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341284; bh=znEE+x4/fs8ErVXvNtdEaKwQbVEdxjLwO/9+DaBezGM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OZEC0TXwd/FgiPQ96ZTR/uEXRzCc2W6L0oAMxrJEGdZUcfFbcz8u7GHxjNnRl9HGwX6jDg4qtdKXwleMNHltG09McQAwFup4Qh5NuZTFU0q/iixIuK5yd/9mW+7v4BkE2KziO4jm2eSNF6VLtsGukFlt5oTl94iDxj3LaXNeopR3oBd7jlH+DtSTQZMdNMsWrKiuDwI4Uq356pIEiVUqf8A/m3pz440rO2AFOUX1kZBp7uEC95qogBhng1IqWGyi9A6/4yyv7OOSKalnmAPnAOx7iwKpvWbRbrihf7/lxS6I3OIyTWfC3Pu8hV0CFbYnbut+1GhgULpoSB+xEQCSew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341284; bh=YiQ5izLVCi5X5plK+UxqefN164ywxzhPcImpky0vVl3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PeMjo2cp4wXnbwhaLVcR8pqSTHhKiaLkPnZG/ALmbMSPzXsqd2em4e6qkMdMSgl6BXcSsIq3Wd0zNRLOwW5GsnHb2tuipPVJHa+Y7Ung8+tYEiRsBrRPE0PL1MA9NT+EBCq3QwZfbFTy7PBgVnzEicEbwboGk+00mFgjhUqWtA0n/iI+7KZpc8HZ7dxVPmTRqORcBfMxRj0yompyZY21Z1LOpRBrFJ/11FZWhTMWcHFNno9Pxwqvexzn2kjWpzthXN+nyWxHzPLo0wHBWaM4e/ICgztut9C7D38OFQEwsuPW8kY5l8VIC0emB4e4nAeR3ngUCBPRxOFbuZzoITYEgg==
X-YMail-OSG: 5wQgejMVM1nezeNgP.ulYGJutEp246Hm0X_MWNMeNVqk9JWNw7xUGdDLGRKTTcs
 gPFtGnsy1InJY5.ankLpC9COTNmB4q6IfZhXRFnY.QjcBuYuYAJ9gZLm4CecCK_3OvR2vtTl21Cz
 MYCHGOGYezFChPlVH9x_gL_PyR.bBNbCmFABlbqFSd48BEWTEX_bwF7DkhgAF_4V7TdA6uxcA.P1
 DCDxiODPQNiVAohbCPZxQpheokxRQSOs1ai3M.YIliG5NQ2_69dG0VvPUDO8WLkMyz0dNty1diXY
 x_wpTgGm1Qe7.wUi9BxZHJk6WT0KCgmNyfSgTgHxJb3LBH3.JdbWdhLlq2xcUz9tP.nHoiajYDT_
 RdoiZf3k32W8kriXEVPhx8R_3VKUlohPkxLxOv9nt_LNYhaMXM5Y3nLVJKYxzATk11Veo1O9VKGU
 5YDt6E_H9ejLLzUb54f7BMmk0iCi26LZbhOymWMRxHrdoFN.MYFygRMkbRICNfF5FtuneuCN2PIR
 3QJsF6h3Ny_4mmdtZS9ACwXLnjfPWPYqr4dyFwRSvC._mvu_yaBOpXC.niYJOugkmof.svVuZN3T
 68mn1bv3wPbObEhfvd.zZba6XtZsC447ow8LRv4lHWdWd6r2o7Z.oU9RKB6XZe3DNfwZu2GRCn40
 LLNyYJyiHb_RCxm7zL8mB_03PmjaIKbD7E7Xugdyc.l1o1v5yoSXSS_t.PXM6BJEGIePipSDuwob
 e67Vekif228iNtv1H3KZU4gEyLAvMEtXYTUwc1.ZYL5jRLttjzX2GXJM3U0dAqqY5o5TkVwn1AHr
 t6aZaHTgMTgEzXWRmm9V_mYJxLmHP1cSgMThpNq1qtH5Aow8ab1H3kx_1wZkd4bZJ1MfLa5vi5UL
 SLM3E1r8svIY7IwvDjjvg_oEf5Ng0M050m9kRRY4Nc_Ng_VPy3XRV0F6VSapz11rRxFUSbbAjTmD
 I_LC05YS80SgBf5755W8xEII8tZK.OcxHn8Uf2XZ7eJHsTAXQVxgVmiPY0osz3tlYaugxPcWgFO6
 bEzR5o48IOTJz0u0A4XruOqat2KP5CERfgKwnE2XbhaTY5AHhnjApc4l0WzLWQfFI7Q__4YGKbD3
 AVJcyJ67UUQTldj9OfK0xg33w905wgAoQI7a1zf06Fp9secz1kg4uIQSxo5UBrxQvlFmsUn3GqH9
 3LuzqLg6GGXNEY0L9yG2Ohm3wasWtQxwLbkaeHrcn1SE5VKyGbqOZ.3KbGO83hXVRZUh1OV4cAXc
 SxgJ50wTQOhFvB1wM4LyvHfCqE.ZKQzmYS_UD4.96wSVNDGzSfEArsy2dBukyXVsF8pz5WK7EfoM
 Ncl10MIm8l3UoycNcYY3xbdL7s4gsK6q0n90uXhB80CnGGvcskwGXgYb9otLai.A804EObPao3CK
 uyeaAhlzBrM19kY9v61Cx27JkKZfvJ68CCy0kzwgJUh_PLXDLUFYZyaUpXVG09LrIZrR2Evfs0fR
 4uUq.U3wyDoRJQ7PO1kCApsh7kt.znaqr06Ueew517Et_iIz908YFpnmUQTZYxWuOgk9einn2JjD
 WxkMCyHBJuDGJxrvdQGUc99gP70KcinPSUfykVqaLct0cJ2Txf8tkaW2DdDtGPo0432Z6nL4lVr9
 3lvqUnIIgoD9G3cXkaSdZiAdwYSwWbA90kWie5xhoEf9lnge06CI..p7skXObmAkhPVwbl6mASX_
 0_EO4BDzpyu6DIJwj9CFG374JkWyircDLCW8LWz5GZHnNDIB4BhhNXVCCKRNleRuvcfrQIvD.df3
 M2oP39dXJme1_R5jT2XmyijF2f2ZK5v6Y00sdUYLwACXU2fCKdBa2BvR9B0jv2OIbpYrhCp69OrR
 sk1lCac.qFwlEt.Hq3_bL0qTFN6w0KK97gtjUX6W3DNqcDRQkYTTcmgO8LOeBFNsH9bziX0dU6qv
 zy6wMz07_LrVDSa.CRgIAmd6ZsfYZcruCzuny25guupRBQw0CqRd4bbPHSNSq8dyAOulRCKPtOS8
 AJrbIxjfdmRPKbyJ3emrfnypJGiYx_UWXW.ffPh00Jm5pIlMA5yKyO7N.tuFagkGZbfkM6ReTLrH
 MJc6jYdlI.wl4IU8pJeKF1HvI0t0YJHwfqOpwDPb0qUI4bC16ipf2xlxh8tlphqkepVF.twMu_5R
 mlMTSrElgrZ.ANOI2h3CVAH8LCNdiR9Ey2CsxQviRElqEppPZIAKNUCTocq4eB3okSG.Cwu0PUZI
 B1W4TX8SifNF8qDeVnBZS8o_0T6AEfQWx2M5ONCkpSDa26lzzn53YYQAoOozH97lU9HuSrilThx3
 B6G90EvWrDmVRGD4-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 21:54:44 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-sqjll (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4374eb8c565a32f837f1ffd0e5de4e7d;
          Fri, 12 Aug 2022 21:54:40 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 03/14] iio: magnetometer: yas530: Correct scaling of magnetic axes
Date:   Fri, 12 Aug 2022 23:54:08 +0200
Message-Id: <053ab05cb9a0f6b0536ab5e0de57009f513c6f81.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Looks like YAS530 raw values return picotesla and YAS532 nanotesla. Adapt
comments and scaling.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 31 ++++++++++++++++--------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 76bff4818461..199d83013e6f 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -310,8 +310,6 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u16 val, int axis)
  * @yo: Y axis out
  * @zo: Z axis out
  * @return: 0 on success or error code
- *
- * Returned values are in nanotesla according to some code.
  */
 static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s32 *yo, s32 *zo)
 {
@@ -417,14 +415,27 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 			*val = 1;
 			return IIO_VAL_INT;
 		}
-		/*
-		 * The axis values are in nanotesla according to the vendor
-		 * drivers, but is clearly in microtesla according to
-		 * experiments. Since 1 uT = 0.01 Gauss, we need to divide
-		 * by 100000000 (10^8) to get to Gauss from the raw value.
-		 */
-		*val = 1;
-		*val2 = 100000000;
+		switch (yas5xx->devid) {
+		case YAS530_DEVICE_ID:
+			/*
+			 * Raw values of YAS530 are in picotesla. Divide by
+			 * 100000000 (10^8) to get Gauss.
+			 */
+			*val = 1;
+			*val2 = 100000000;
+			break;
+		case YAS532_DEVICE_ID:
+			/*
+			 * Raw values of YAS532 are in nanotesla. Divide by
+			 * 100000 (10^5) to get Gauss.
+			 */
+			*val = 1;
+			*val2 = 100000;
+			break;
+		default:
+			dev_err(yas5xx->dev, "unknown device type\n");
+			return -EINVAL;
+		}
 		return IIO_VAL_FRACTIONAL;
 	default:
 		/* Unknown request */
-- 
2.35.1

