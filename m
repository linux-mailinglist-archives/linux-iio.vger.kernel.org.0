Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077AA550122
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 02:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbiFRAPD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 20:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbiFRAPD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 20:15:03 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com (sonic304-23.consmr.mail.ir2.yahoo.com [77.238.179.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022DB15829
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 17:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1655511300; bh=pWKwob//oMrCGdu8osqOK8fSSKjG7fXLFNCSSjKHJOY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RLkbMJFCN4DTt1mf1AcvyEjPUEE/4fko1m/nWuyrBEXICb/DHAA26olHEA1r1/U+5+y3ZLZAePUXHutOJpAD3bNYs/dTV6sj76NG0GjJePxSbBejhcfYA84I/3H4LzA201iRdGg/sNBgqBWURAub8GHBm0Oj2jtpQXHqcphr0w4BDPN9W5Pva4khsUghRvH1diLL2UDdhwLaXlFjirI67X5JmNB1eecsLcrC3m4OYI3pOoviV7j6MA0Kg8HuBkVNH5RT3lnNo7HhxPx7AYiLrDDW/7IPQ/59Ku0MTzJJfTFAVK3DAqoDXvMjbKXygKbLJKkkjHI0ql+YRM3qUPJ1hA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655511300; bh=wWBUCkaGkSwAwYDl83FbXZkCbxpmT4wi9iRMF104Xc6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Mo9X6pbCI7zBX/l+Ip4skO3+MbWQGIV1nNUcQp3TKVLhGeuobXs71mlpniRHSU/VCKcuA03feKvtrtwQFOiyQ8hyBRixAc43kvHpsQxcfPncem2YY6PmZSil/46Vi5LKWkV29KZLkq8ZSyo2z2bAv0kXMtk9x2ibaI2kVOK24gSXdjKdHaZu+yS2Njqtqzf74CDgjAsJwZARTe7UesiBM7lfHQ/Ofiqerb+S8jJR5UkgNPEoy6s3D+VOxFte9IQWvX5ei33FvTNKFFtQG9WcCkIvN6sYCHZsg2jLK55/cFezIwXtwDIQjU/qSLLWriwIUv93YG/rcHN3yv8XhE/nSQ==
X-YMail-OSG: QCFFV.gVM1m25cgayU7RJHrqUDTdfVNUKwKiVFzJ9y.EjM_BlT99jwyUaFBx9x5
 Ga7jiTDnCZuHOrjWMIb4snT0J4HFJXkH8W4y0gCSwyhVqlIykuVTO5ebW5QrwX_Qzsn4FUkh2Bti
 RBawHzyIgGrNvQ5dKbPb_RJhW_f8E1Y2CKVTlcSKf7TcRd9IpWMHCsHldV0zZu3BiG6xCYQqkQK_
 a_IzW57.qQV9dX.CwmJswj.uVH4WdNF7cV6q6PHo9N6aNY1S8Lr0O9ebYoak1ygf3ORBWqtY9WiO
 NU2vFAfUv0VsNedUVokW2tpsUU5aN_8PDtahZBPhiMBB3oSF6WXPxaIgqosogpPWEj68Jabjm7zS
 3LzBzfzS_NvrIxMRDTAO2L6lQ3qedF86DTx3aLUBNvESXD_A2xmIVXJ_LEZKfV_qXeSxloZvdgS8
 qFE2dWJyIdpVGFWznAdFIWS8Ip_mxTz2IW_Z9rxqMaWH8iMqs2UkVDWcPNEymsqsKuWjY79mYawX
 i03BI3tZ7c_F2NiGyUiUWPdjZ3d7FD3u_V3.3sCNY6JgGWQgVW4SQ3PnaRr9RrmH6sM6xF2aHMv8
 n2rbV3wyXLufygpf3PBtlt_MTU.xFvOZq1o8s9dObW3ByTR1K4sZ9Xo9uKzeEDUXMb6lNIW5LMf_
 WjAKX.v9GlUwrPdEIcLDgFy4nMe8HQfhD5Lyh2Qeboia8mea9auef2vrHeav5vAKtmHTkaBqKz3y
 cr7k76gDNEAVf9c9Bn8OzD90LfJYQHKlylDPkU8l0DpHql2B2Z1V7CL3NOkqaZVnJl9dtFpwfie9
 f8KnyFfzUIen1q0Vnss_qPMR31H4KvcUzSkZR2Oj7Ez3SqfwSioDgo8UkydGf9b0fbu3eA8qy5On
 Ft6StTbrInq1OhDZlnSsq3iKZur9OC5WTMWYTGC8PViLE.FiZ6r8c4GH5fsGZv7m6LdQSmc48phv
 9Ii111Ub9UAgfULDfGHCgKX6dPJ9p4VHgas.LtenulPvgm2bmG6aV5JEkYGeIjUDZGWI1C_gRpcS
 28BMvCH6w8TO2kR4PKoS_Q_7ufR12Ut49bqvoTfn_LhC0A7NJ4ZgQfsccw53ZoZt6ryEeUiim5H1
 TTaPlDy2qm4WYjuKglFsu5G10AeTV.OMsG6loJeMZk3ZG0RByJwUBnCt.BPNbzYs8L4R3K91yqiO
 crVSDxJ7TMmVrmXO5dhpySAB_0oKJ.UFKfelKDXm1Lf0XyF0Tkb2sWWYb5KLdX7BRBpSA5fPZoW5
 dm3zMvbQdwslb8Y5InSQnFazd_uDZq_.JhakwMF_6enSAzNsb6_QVKTPlhmwaHitQsEyHQVH8sBD
 rS9TckMTMJO3p3K0tylI8Hg39Ndc_uh1AC_p4e9.9qYKqi8FqCyTxP4lRibrO2nMwAPo8_8_SJX7
 ww2MJtAW7bvlAMpw57hOZbTe9uHLffHCclEKNvYlHLZbGDNQMwxvDrSbRqbYI8xb4oDDLvT1ufMp
 YVEZ83FlNTd_L58B5otZFO1oSvJjYPmEoxu6hVZy8ij881BtcuVVLw7evMjvvhaVW0.rOZ9NcIzN
 TysoLombwfRcezjklqCwGkY4Goqq2wYighJXK2xBkcLR4EnWMDhrnSLjsLnd.mi9jjvf7e0Wm2PB
 .cPxU6CApl00gHyuHfrPBWjQOQAql4LThdK_x8bNSmY7GneziWbGuTONS6NxkQ6jk0vNxJkVqJuK
 lvhyNV00QZyjGPFImxI16wI8nG0TpUaTcad_nuE6M7RmbHMIagXaGaLxRxZ.zFXqtq5fvGVh6qCS
 N3ZVv2dwzgaHRyIQKa0EA1DMNgokKLUGb6.w5YBI1zKNlafb1cvI5i0DCM7luadvm_iTXiaMY_80
 OlkgkRJTxQhonmVJ4gIWwcSp2ydbzGm9ikPpqBnSBUVI6he5ZcqL3AxJNAv_V9jralM77ekpDg..
 HfrqdVkxMw9lbfUP5XwuqZ4yqKCZ1vu8jkqwNcn25n9TJ.zhTm0Lwk0DCH7kSU4nlf8tDgUZ0UOs
 ta7mpKylSDzfMSOK5IGBuy8Rl4XTjhv2GcazZw.ZGlA.f5HwL6xQgw5apDxIgsudjpNygzGkZ3SA
 nhDfPw1zH9w_9FacPcuDvDK6Cr7sT6Q2ihHMCbzLmywAgfAqaQm6yzX9VHh8QGru4o_G.531sSUy
 uatQuY2iA2iuTl7yDANEiZWdeFvpT.EqckENlnQsfmkakVdLgZQusuR2lqDutV7O.IgUabqVbfQH
 Jvt4cn4_IiK8hXKSUwc7uKLH_hVf8Ajc1hdmUKN7VGXVBS6RLCCY4HAMGUDkRhJItyn1NuxkkUj4
 ODdJESHe6fDnCTILcuQ--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sat, 18 Jun 2022 00:15:00 +0000
Received: by hermes--canary-production-ir2-c9bf9d9bc-74fwm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b08f14069c990c2ed22165f3e3da032;
          Sat, 18 Jun 2022 00:14:57 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 3/8] iio: magnetometer: yas530: Correct scaling of magnetic axes
Date:   Sat, 18 Jun 2022 02:13:11 +0200
Message-Id: <b9f9a78b8f9e35711591d624bbbcd7757056f959.1655509425.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
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

Looks like YAS530 raw values return picotesla and YAS532 nanotesla. Adapt
comments and scaling.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 28 +++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 2799ae0784fd..bd43b2555b73 100644
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
@@ -417,14 +415,24 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
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
+		}
 		return IIO_VAL_FRACTIONAL;
 	default:
 		/* Unknown request */
-- 
2.35.1

