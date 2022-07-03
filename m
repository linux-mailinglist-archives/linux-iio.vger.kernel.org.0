Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44000564A2B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Jul 2022 00:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiGCWDS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Jul 2022 18:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiGCWDR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2022 18:03:17 -0400
Received: from sonic305-21.consmr.mail.ir2.yahoo.com (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E075060C7
        for <linux-iio@vger.kernel.org>; Sun,  3 Jul 2022 15:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1656885794; bh=EuFGkupLjx9zPeG1GfBnRcBvJL6CsBo11j9xvtKmu7w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=odlyzq1zKjKmhZiNRTJzvGdsVVz41Qywa4VK40KFymFdk9cjehizd6JoOXIIZaVTWgmPU5ZVFEPS4ho4GoDFAX2zfXxPcRgwte/VnAqaUJ+aKehC1lsk0yyX9mmtiswMQ9mTL9alTeIXwPM22V4nYXS6+U5n16vogt9llchhu3jl976RxfjnPPFKpO3tZ8QO5dQ9M2YP+zsz6g3+zpNNzwqjXet8s8rQKX0xm1l8aBY6XRoVKpSmqE2Q178FYcL8iFPt2JnTjfGWS4i00k4MGkzHXmbisIJu0WV7SzAKs/bcKcw0loeu/Hvs004hmm3itcEAkxLiH2a7FY6gvNi5VQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656885794; bh=NjqdnLHQWyVeQvaUbsqOeVzNc1MvOT6xjm/rrD2B7vz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oXW6pq3RE78tozBOCl92yedajgULz6Ok1RMfAJjfGaFB8M1fG2u13T3d8r5H1EHSrSZQNWNDB+14vYa7BzqON58CUnCmnBXRzp+4zn0nS1vvQpSlynuATDU0KplRTOYowR46BOjL0DxmUWD6t7yf7DLt3CYzS8lOl11TVcK8p2VVdMAf1DBvL7FVvGWsfvC8rYiGn1yZNEma9PSZZgYoUlta74Z8ICLHOlHfZOhROpYZ13Rih64HNPoLQx3uFrWUesVQ2kocGxERIg05yAw2mgX4kZJeBduNkdmz1JJvHy/8qffZgAa7FQcXwX96gIljGIrXCDAI92EhuevJiptlsg==
X-YMail-OSG: dT3Hi8sVM1nspGrICPu.zGj9.HBUKYOTzoospPzpw9a2NpNBZaltNc.3Hyv5Bwn
 tX4ONGHfb1iSvRKYxSBt3sPbSmK1sC0A5uxqNGj7CD0OzWivoUGPyzKlQMR2xwXD1xCkI_ZFp._y
 i1jhVIG04BKaX5xx6NYprjUwBuZ3ki.TJWvHgcQg_m8kRuMQ__vgsrY_MRfO3eJtfvpL8vzb_kGx
 zlw7bsG11BiLU7mqC7Vfng0HYdzgWojiS0aWIXw_5j6Lk4ZM4Uk9YTdl3kUbvCOkBwzIV.2_RGxD
 K8WxyPTCger3imc8W5GD4NkAmKOzxtkqh2UWiO6Cj4u2EpYN8ozPVqL13PAomwKsqk6hp8.dXEey
 9DmwMEHCEuNeWo1dqyE5pWOhfvRrJsbC0TIvK.8meoAJypydKMixJzY8iIMmtOshLL0H8RlIpizd
 oXz8sWYG8bmd_64RFIrSaeQFC2AB5DTHXOBNBk41kcNU73e1pU8LGxNYKYv6BveBOFfIarK3Ypu4
 ruSXPNt4ECyo1rWdPiUXPPtn2hCj074XcW_PhRHsoR_89i7uk.zbe7NZQNlxWMoh5Kw9kDtyKT6L
 5Nyl1DFoDBSZPVooPRayCyi1UT1KxQGDWZ9zcGKx16ewOHmaDfj7_Xh40WJfu8Fq10Gdbpcj70u_
 1fSfG.C1gmVTapIe2eEgBojspL0f73ISzrXwit5mY9pRecYKu54HXlZjk_B7wE2cs.RcBvSMaTqB
 O9QbQdHR3jUP1hTsFMuQZl87EVDQw3Sogf9d6ATFFyT2qjB4mJ.ZYIjcxc4ZDc527HqP95MHokjc
 pj3Ym.IQa2pAl0McqYGDzSz..Ob5cTbrhgbzeuQ9QYY5XL6EQL6eRHSHB950UW8cpTsiNTZmROyR
 HgSVFWl6yYRlICRmhMBssI8ZKo2wLnlK1XLbG3pTjaPLpXmn8Mx6dNtzB09Psh3ThITsahLYSA1I
 7D5FluvGF1g33hTAxXVdz4ajSX_k1oxoikDPC4C.YOQKyFjLDC2iyfwn_vvMixtF_VAzP.A1r1aF
 KQpZ2dfI0rg1AK3hZnfUhl7Zzi60c5ZT16NUmWkrI3vNU51Ragfq1iFCeZJIVdB0JZKyJS1gQIoh
 EHa4WSBipxMvNIPkrUOhVT_nJ2pgYzW7rmL6JtGZn4bq4_FrKGiPjU5puikm.Q9RoQVo1H6sbQqH
 azKnJ3oelu..dUWYM1v9F3XhoJSWvhKsemjy8ImscHsabwRA1azH57UgYLg8xohA5I9LRKdIULhO
 TZ2QCtnq.Qiw0pvUwmYwCtxF6lVPGbYz8TLnEMzTYoOxnmWK1rYryX6FqcW_B7BmAMGXb3EL7NsM
 HMhudEWEAgUylJIoUY4Paq6KsU7.6XajOJRHDP_v0LU7IZB8T..P_iund_fM9JHCP2PquJZRFWYt
 adI8SoLS1qYuowrgqVzo0NmV7E1jacbG9C7j6qzZPvLBedEDmbMRajJeOOpVNjxN95x1mluEt9Y8
 CWQ1uMHHz4q2q5CGDPM7FdbCapdGWhwEsJ.VlJt_.aE3ukzNpEAIRAsoTaUf_sBPOTXIv37Fs4ih
 OZ6MEprslWtoZXvmQgJJVnqPWjJZfu4.Ak7nriJh22ZA9jIt4Qj3YUyvEuJw3ujF2zBrJZXlSw4Y
 yItNLP58vN1maHzmwjPlmd6aHkY3vqTr2CBdGK7ltimTVp.RdMWY4g1q6rPaYvd4Pbg9AftfTon6
 M1LoGrCC3opgbfIt4o7aPdOxI7eLRRRLv7Nic7r8lfdWY__hUkebvUpreIzd5nNmrYF4sUpJVK0g
 aEqMHecTbVLZ4L2vAOnfE_dobHD1TYziPeB3b7zr2pIBj.zb7.GZLayM07TuUnqE8Y7v_.5mpSvk
 eJLfDmjvarNZwPKcmwHJSK4cRU3YviTu9BoyP.oUjKjYZUDAy1.YIC.IPv9gGVldCmbQAersANLF
 jzkuOdYH0BePKMwox8iZrfYkdjyO9ghu1FgHx03rLbH8LkxzF4CV7N5bXINmZU0CDB.9.wjGaa8Q
 2FUqp5Qm01CVzD9wuqz1fzwzaflWlYIhr.sK2wg40vxLY9XB8IKpdOzRiR.NOKO2IXAbdYKCM.kA
 0xJhJAQfEktVp_VcoB.QXOawoDF7HFBD41ZFu4DH23VpBtWe5kP7MnPwi6wjCxmeeXioZlzG5xdp
 ZbIA2pWJFWdO3IL8xwyXsZxDfiEoACQqkillKB.8LzK3EkFXjXElOZDuiSuL_KsMSVBsgoUUA.w3
 ws5cdr2ibB3eHQElPkAfKblNNidZFBQt8PFY95AVkTmXLAuxIUrf1LhHQdpOAew9DVN2uPecxHWH
 VpsGhgMd27BxvQ21f
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Jul 2022 22:03:14 +0000
Received: by hermes--canary-production-ir2-74b4d6d794-tv8mb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0849bd8970b52a790a5a1bb96f2e336c;
          Sun, 03 Jul 2022 22:03:12 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v4 03/10] iio: magnetometer: yas530: Correct scaling of magnetic axes
Date:   Mon,  4 Jul 2022 00:02:37 +0200
Message-Id: <3e43975412539f6af6b6a479bcd222741f9f8b28.1656883851.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1656883851.git.jahau@rocketmail.com>
References: <cover.1656883851.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 6fa29b96c013..8cad724fb328 100644
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

