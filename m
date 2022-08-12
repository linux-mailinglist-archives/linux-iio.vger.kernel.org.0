Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF95E591718
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 00:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiHLWFY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Aug 2022 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiHLWFX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2022 18:05:23 -0400
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF94C622
        for <linux-iio@vger.kernel.org>; Fri, 12 Aug 2022 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1660341921; bh=PYe43HwPKQzTRJjNn52n7gP1CuESppOZLfs+lpCD3KA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=IFKaUkFGeLCvYPu5vzbCjjmgJvWVbzr9LdJez8xdsIHD2Y/DVzHpX4LN30ww3Gop+kt+1d5RUoyxfarDV2Qm4yK2o6IjjH88rHVrRwUUBGOE89jOrGlZnuQywsKal+Dey78Z7cqbKIlspkLBAi3gDrZOyCcKhkyoCdQtuC4rzk5S2nRfb6Xu7qmf3s6dJNFAfnD88Uu9MGwyRI7nWa5Z0Y86oTuSpUof6bPz3+e0xAuBExyzrLh2jgib27ikCN14iyyjYAav7r+nDLJfnZhFLF56UwdwaOh9p6/7J1ALZKYSc0V0pFsz15Qq7M3pm8VaXb4wcmkZXnKA66r5EdfR2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1660341921; bh=Ug3RcSye99YjCtsKm5jteuI8mquFfcXpY+z9mqeyYQX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cp0auMe4gpq92spQpKoXOLGvN/RjgknZCZ/cztBlUzk1OJGrOqip3y8HfTB09iQP8vw+QR9NLJq+fw1Fy9mKvTPkdHRvAhl4vGi3z59UI8NSa95C4oH68UhOgNikDnFzMXW8qO2lwVOkYFOqP/ne7YRLVksGvJN/vjRuJO/RBtcF1g7oz2wqKmiyanIUCtZBW1bcSM5JPtvmX+6nUW6BQi3MQxd6k7zHPYtOkfG8JcrJsvmPVc2rgfPMEx9Q78+4/iym/jtxQMNkYr9s5zy84KDPw2FaofBZgzDvMDdCk9xfNR9vJu5RibLMqNt4WW6npswvKNzK04zLs4IhxtzEzA==
X-YMail-OSG: FNUoAkYVM1laBS01NJCKE7M5jf69qU6ciT04GnBpN6Y4sos2CGzl7ZFgdDd0vwI
 Ga7ogzm20DgTkIyAcL3vS3iQJ7nb2W3PsuaJl8eh0ojkNu8Ibe2GLuEJKYaEp90W.lef8GGGd2j1
 xdLVaxrzcdQq4H0FrNXlFTb.EIQt3PfDBynWZmIOmRDuC4u65oeT7eso5_gnM5Pw2GAx4FTNjhzM
 tCvjjnOKilFm1On8LMtZLsp6B.XwWjdM5iNLuSsUWHYClY9RP.qFoxHdqV5c3Zi.mLj5w.7OmGkM
 E4tz6JvmVqc_qm7y73NAGXwS0SxUwul1D0__2SraTVHXdtYPxYT8wheI3oIONmBkN90dksH17NMj
 S7vWRDKbZpnc5dkZPpj1fHFI_MpcO2Xeobu3g_0.UPvtZ_NLMUB_PZMoC6pjBXjWFzJPzPzyCCFa
 U90LD4wpJbH4ZhU8okvZzwoLeORSH8GZuceCEmS7oL5DLunNwuzQESNP.nGFcpeRqHR6tJKZzqwo
 6zLJscI47tQA9crtUylXPVPctcHCgTLOalZLeYgTL90xwMRUlMkr2K.J4GcZVPwCwXRaNBT_H_HU
 LGuIavS_DqQ.8UKh4_lCq..kfGQslQA.DbAzOq7iElmjJKfr_n5ci71Iail1eZ5msBC8yGk2v4Hx
 FgFfT5C.VxFXONHZMMoCfXmwCWlS.V88hHotxpskZvq0RfzyKgxzbVzFD6cijrMkmGae02XE2yEJ
 7LfWLEkYs9JnZCDr5onwyywQ5Cn.iqQ4u_I2w15sys2sdOEasyaR.V0fpk84iYZhK_kZalg.SBYF
 PLl.eZaStJqFL76JNi7ina75c0.dZxTwcQxl8hUUMiAOfRNDi1YCS58zJnggNURWUyRBupp8OlmU
 mR.jTLlNmk9zv0hj0cROrFxjR6eXd99qay3lvbvWLtWLJK0QrpF6zUZeQNYSCH1ZYuMscjjLvQE8
 UCdERuRXYK7Er68QwnSt84aqshRSvzIAVECcnuSMVsvn3E_5jLXvHwRiVLzFpaWEOszktdKSHzMZ
 0iRZIn.xXDc8SW0Tp7wC6bLYccNaiWV6fktpjTFiPMG3H85Y8n4Zji5AQ3JnFqG81JYGeJIp0zIe
 SPdbCvmMy6OsxeqPmQj3uvVEWAZ9bfdP9OpMaBl3Duex8DLnOG.8mlCgUpMMrnwqNdiIS3ctTxba
 vpYWF1mnjIaoLI2GLX9dE5.pGjdHQ8vrLc67XneEd1aItjo_HB469nCcXmftYQR_sA8nEIkmITiK
 FoG6cufyIT05FFv.6MfeD8yqa4PxirASGIGnkFhUZqy_qKMFPMSJB_SXzcu6i4D0cl0fRBVw9.fT
 UdbXN_p7UgBhujuCLkzAUkFWUQ.TJpKNB5E3K8P4SiAC5OwSEuQb_Ivt9wjjpCcgFO6YJqFQgDCW
 icqUE_toG_FpeXdYzh_9Z_2pf1nxKpNKJMmdfeCtJccq3JJDpflEhG8qY.BMMHunGtKn3sK7AyVt
 sVPhsSSWZ92o.vHprPgxdJLkuu.0Vt5pk.rGIQ38fEskoT2AyuBz0PcBW3WDwuVJ5oJu4bQZJE5M
 FF_pVqSSKViWk68hGjIxK9YbT7NAn1Tk6nmyO7Ei8DAH4ixq6d8grmdI3Kp1nXh65a.KsuZyI5xP
 E6mBotIwNCCStil5_ITklkQcWRZ8wHllZiAs27aPEOy_BXJu1I3g5YHz_FMpLeT6RGhrfJ443hXg
 p.nXSBLROUiSm_pPUyrCuAJOXJVceERw1Ll7aoc5eM6eGEptQamO3.3BQoas3KAkZzCdU7yTCbSs
 36gWYNdu0bKb57VfZCBD0rWMkf49dhalx4FU0Ktu6JVD.g_ssfQ4eEELzmh4nStGePf9a8iaLB21
 eiRk_tl7AdCQnFkFX7D1TuKy5c8g6dRYJnGD6NjJOI6j8K_oOxk23Xfx7Gu1Oc8zf6lGVr_e7dLn
 G9.tQxNposF73syoZz8YssbVYr4.FczRIFZXIxqkIYcjy.JthVT1pzSomrvTnLsgY4OxEenr1qcv
 Ki5fDHSzy_Z_2vMSOlJ.o3bIbCwrCgL0.UDXlhv3Y4FoiGR_uThmA5t.TWvAy7qeVffuMrI11lYG
 KTgjbKpyEx4Hrr9ROIqaqm_vsvBhbN8BEyYqKljSuxhvuSL8CE8uk6abpnEH4P8GE9CXiQpyGrTI
 IQm.IrBwXeig7Luplj2gu0u_5b810CJRAA8aXOUMUQM5aUnm8UmXhC0fEzsrH0yhqdyULOBzR8_N
 8iO_421DSNQXzucxTy2ptqeUL.ERdz22cmtBi_vKynAIVh5NylJJs6zXymhVOeQS7s..y8OKC7Ta
 1ObcENuV0MRZca6pHXSLc
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Fri, 12 Aug 2022 22:05:21 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-48gl8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c89c964524cd385a78dd9672c65b4e57;
          Fri, 12 Aug 2022 22:05:16 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 11/14] iio: magnetometer: yas530: Add IIO scaling to "chip_info"
Date:   Sat, 13 Aug 2022 00:05:00 +0200
Message-Id: <a12f892633bbee13a8856c231dc793ebbc5d3a03.1660337264.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add IIO scaling to the "chip_info" structure to ease the handling to
different YAS variants.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 28 ++++++------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index fa317b975f8f..af5c090098fb 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -130,6 +130,7 @@ struct yas5xx;
  * @version_names: version letters or namings
  * @volatile_reg: device-specific volatile registers
  * @volatile_reg_qty: quantity of device-specific volatile registers
+ * @scaling_val2: scaling value for IIO_CHAN_INFO_SCALE
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
@@ -137,6 +138,7 @@ struct yas5xx_chip_info {
 	char *version_names[2];
 	const int *volatile_reg;
 	int volatile_reg_qty;
+	u32 scaling_val2;
 };
 
 /**
@@ -504,27 +506,8 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		switch (ci->devid) {
-		case YAS530_DEVICE_ID:
-			/*
-			 * Raw values of YAS530 are in picotesla. Divide by
-			 * 100000000 (10^8) to get Gauss.
-			 */
-			*val = 1;
-			*val2 = 100000000;
-			break;
-		case YAS532_DEVICE_ID:
-			/*
-			 * Raw values of YAS532 are in nanotesla. Divide by
-			 * 100000 (10^5) to get Gauss.
-			 */
-			*val = 1;
-			*val2 = 100000;
-			break;
-		default:
-			dev_err(yas5xx->dev, "unknown device type\n");
-			return -EINVAL;
-		}
+		*val = 1;
+		*val2 = ci->scaling_val2;
 		return IIO_VAL_FRACTIONAL;
 	default:
 		/* Unknown request */
@@ -951,6 +934,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.version_names = { "A", "B" },
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+		.scaling_val2 = 100000000, /* picotesla to Gauss */
 	},
 	[yas532] = {
 		.devid = YAS532_DEVICE_ID,
@@ -958,6 +942,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.version_names = { "AB", "AC" },
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+		.scaling_val2 = 100000, /* nanotesla to Gauss */
 	},
 	[yas533] = {
 		.devid = YAS532_DEVICE_ID,
@@ -965,6 +950,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.version_names = { "AB", "AC" },
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+		.scaling_val2 = 100000, /* nanotesla to Gauss */
 	},
 };
 
-- 
2.35.1

