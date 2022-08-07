Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D52858BE40
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiHGXHo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiHGXHn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:07:43 -0400
Received: from sonic307-7.consmr.mail.ir2.yahoo.com (sonic307-7.consmr.mail.ir2.yahoo.com [87.248.110.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4791338B2
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913660; bh=aLBvqvlMffaphGatiwiH6+pKyFPvdxoXclSc3Df1NaY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=juifEGL53PssbMiauLN61yoQiz9A70TKlvnBuyhbdQ+M9dHA/zTUjwejrYlWcFZ8rdhrq03ri/ZB5xNSQUix7lQyVJnRlTLO6Op2Gk/BfwasxhwCr92O+XggI5T6PPpj9OsnIYaKVIEpz/9V/AflImlzZmWvaJByx/dSjns4mr2ZIuuZDn+ojEdiwgjF6YrE5w13kf/EBXrJQIhaUGg/n93Fwx2I8p6vh3KCuPjqvqqJe5y/K5Z3dFX0SGeRZAfwoFh77rGHtY20Y5hwS5Zna+XJu76hD8P+ZuQkDMLGgHAozl2YOiEUmTAoQ4LPrNRzsWidRQqnfz+5vPlX8zG/CQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913660; bh=OkHEtKKqK24JcXIavsLVFvhPNKEUl1HZmzXTGXcHOoR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YrrOaC0yDDT06mzu1dtopPfE0vvV61InhYOskbPWyW57MdetSwqsl6AihbWWrxRhznLGSZLrigf6E4cw9WTZBJ56ds4tggz+8vW2FdsbcPn2TL3sn/onj+FIczQOETknGVuo69xB9t+q+WntCEJxAd6gIKIvFpid39gmRrmeEguHXTuAYFnDn1WDZoKFQC2QMKpr1rRYIXiIEYVsn0i164gu483iQ7iPcXgHOorYXcbFBhc8MA203EWojDXK6bNKGFtqlI7m7KT8pmNOv4muk34scMW8up6uZMe55/SbfQDhW1rtbBqH29trodLr514SwQE2+L2ZvAwz8AQtUm2ZXw==
X-YMail-OSG: Mc.6A9IVM1lzG8t3S1Gp3iyo22bHFSyzJ.ASmWPyDbsm4Hd6SDpLjx_sCF8wDP.
 9lp7u2eJqOpCw5aQ9OpXrS9hQ1B89CCbtHARmKvQfEV0Oh93a0TEW_QEWi8YyZRlIvFOflA3ptfr
 bFO1aJ.rUvKYArNqEsxpK_ushF.MK7u5fCW4S34i8mOrGxAS_X6CWzx5jo6cgKH.h_DvVe57n6SQ
 4YLynBw6AG5n_uQw8rzSSmHycgkIKJG2CuzzlkkzKSRbq3IYl1yWNfvuzF3rkjzIjwGRDLWGaQ7.
 az.USnLjCWqC1mQrrkLFxXH9hLvacxCxYwZteawX7DXI8RCw_CMr21zfhxmv7wkSLB5twFdTow15
 lJhw.HaNRrlM9TWk1mk5V3D5KPs2odHr0g1uQyXSSZftPg2JMwgsOa9SZwUqnbVjTpzJhZtcx3HG
 44JzPTF.BpJ2w2I..ZHHONe2iAyPnJ6ANEdLPyKMwwDEWmvCVu_j5Mg0lomJfekHbmjzzyThrN.a
 d6vGG.GJA8YKbdSxQIoJQxeEE41pKJbt7_8FxKBzrgnTo2UpYTb4did7.3mDdhzBi1aq3nNkDH.q
 NQunpVTc3Es.xA1sUplCSRAWMFAZ0WLs3N0sFHhaHcOVHBGOM4la0JaEMRItR0keRCn322KtWH8l
 .ueJGaF9tMiny6v0ITSuXVBCEtfS2ZaTRmMwfKko2xsFUDiiQlubf8CaSfAgyul3i9MZ_FlL6X5c
 9Z4RafVpN.4Fl6dcdquqc5q6R.8SP_QrFT1b9iwaUa.zTpmtx.LYSoqfetKYTd0uhOQYb9AuA3dZ
 kEayd8nqBs8K.drHZJJnZS8lP18trCF_ZD8mIcBAKveYgwAPI1rQNF_B99Eo8AcwwXQdCY78GH0D
 ZheRA5eX7cn5lGELt82gg9S9CHleibRwCLdi9h4hR42TFIm1pDtnWuDd9kFIX8El5mXPXfxhi0W1
 Bj5v5xDTIeWeFdiqV2WpPAdlBebVYWTQ2nz70FO.B9Tsd.TAPEisVUz5qsgqBmkJxjYoeKBqTYP9
 VUTOtKw1AhQvNw1rMfyyobc.mTx0LRJgp7iuibwzvt_2Pb492xC8o3.ElFjwnsjeBYiekN1Z3nw4
 UxUrUq9kFvcCvUeD52GDg901OlAziX5SbfFRvcBVTIQpafqYI6iOx8ajveFsOv7JwjHHgDYnIU37
 3RxRYR2SWe5mM9pp4foBWk.pEaVOp7mfee9HBJY8verTlI1s00PRhcYDzCteXQObw3TIsPh5NLur
 5IgcCW0VHDfnONxW8N8pKvsxOeZZJS_yKpUFm34ITgE.ie3MY3IJLx0_kh693TgfNgkvqTE9SgjE
 LnEogSHIdVWqSoMLcMupfIzX5YOtNftfJ1oFSNZ7nH2tlVXsiJr1HwV9BCERYYrBKTPvH_aUKFzW
 4meSC557415D3vxFYsyOUq_9e3s.CIv1_eQGVIRUJErmHAu9o57JXsAwYSz9nCOwsQc4CFPROEHK
 _29YR2vrZa15OXzqZEAlV1oq6vewda8Iu2yI4t1jt.41ZPIFI4RhLBBG5zZbaqMtRY5fwwqLE0MJ
 TQKauffoyCUgSr_zOQ2bHt8TwvPjqtNnDPwTTVkGeddSXetgXLK9t_njfsw0Xo196GkJ9JvUlFrG
 rnMYxGWNGOGtKknxiuWw.5W1unTnXar0Kt30Fnk7n2BdOOJZL461f_P2.5RK43n4JARDWzSgOPKu
 T8Ucw.EZlPW6LI9LL0iYrwpz7R.OMFdaX5WS4_Mxvymy3gTsDB362AXoV8lciyT14fYeeT4FS4rS
 qpcqKWNqrDWA1pa97xi35iL9UtzIy0XPF7.IAfY4sz4tYriEU56wrD.Lb_56p4Lv8jk75wbbcDu.
 sO8nh5JkVBi3TgVrC8.52HeuyUViVe2yWqcCDods3YleW_wmdLS2WStSf5LiI7kGA1NunUYkZ0gH
 AM9EREtDeAVz.Fm2q8J729kXbsqKLh9O3xWq2pvuNCq9bLH.QNGdFinrlw2yCcbP8JUD0iLp9ARt
 J_7uJB0Zh0heNOv5PAcwP5lol2FfFvdpHY5dvavjF2oXJ1LNt9KDtfutCdTL0NP4IbivxbRBEAiw
 CkmkuZV55ojlOrMZsGFPZqbD.9m86b7BM6rPk0HJX7YWMs3.WM5dpGwkg9uu2QH.jDUqdXlvi4E2
 xW00kE6ZYGbnci5IKrCvhvw0RI6q4bQrwlGFOG.vQjQjrtzYXMw.t5jztqGbrrL0unbJbOel33Y_
 YsGZqQwsrtJe5M5h0IoqavZI6s3NI7.B.fzWxyq9iTA2c7cKTp_CWO4cpV7gVfv0qbiZQmExnKII
 N_93TxacelwjP0wg-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:07:40 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-2vqg6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dc92a55cf24372a35650a28a19dee6ae;
          Sun, 07 Aug 2022 23:07:35 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 11/14] iio: magnetometer: yas530: Add IIO scaling to "chip_info"
Date:   Mon,  8 Aug 2022 01:06:50 +0200
Message-Id: <1e1555dd2aee1636f4657899c20a9a92b4fe2d80.1659909060.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659909060.git.jahau@rocketmail.com>
References: <cover.1659909060.git.jahau@rocketmail.com>
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

Add IIO scaling to the "chip_info" structure to ease the handling to
different YAS variants.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 28 ++++++------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 914f7f0a243e..262a36c31616 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -142,6 +142,7 @@ struct yas5xx;
  * @version_name: version letter or naming
  * @volatile_reg: device-specific volatile registers
  * @volatile_reg_qty: quantity of device-specific volatile registers
+ * @scaling_val2: scaling value for IIO_CHAN_INFO_SCALE
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
@@ -149,6 +150,7 @@ struct yas5xx_chip_info {
 	const char * const *version_name;
 	const int *volatile_reg;
 	int volatile_reg_qty;
+	u32 scaling_val2;
 };
 
 /**
@@ -514,27 +516,8 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
 		}
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		switch (yas5xx->chip_info->devid) {
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
+		*val2 = yas5xx->chip_info->scaling_val2;
 		return IIO_VAL_FRACTIONAL;
 	default:
 		/* Unknown request */
@@ -959,6 +942,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.version_name = yas5xx_version_names[yas530],
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+		.scaling_val2 = 100000000, /* picotesla to Gauss */
 	},
 	[yas532] = {
 		.devid = YAS532_DEVICE_ID,
@@ -966,6 +950,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.version_name = yas5xx_version_names[yas532],
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+		.scaling_val2 = 100000, /* nanotesla to Gauss */
 	},
 	[yas533] = {
 		.devid = YAS532_DEVICE_ID,
@@ -973,6 +958,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 		.version_name = yas5xx_version_names[yas533],
 		.volatile_reg = yas530_volatile_reg,
 		.volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
+		.scaling_val2 = 100000, /* nanotesla to Gauss */
 	},
 };
 
-- 
2.35.1

