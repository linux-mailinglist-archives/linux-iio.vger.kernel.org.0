Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2F58BE30
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 01:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiHGXDu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 19:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiHGXDr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 19:03:47 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937092BD1
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1659913424; bh=EuFGkupLjx9zPeG1GfBnRcBvJL6CsBo11j9xvtKmu7w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=r10zRAa1E7+U+H3e+xn3yYVp/HhRH0Oq3RjXv6xENVoMJaLWVsCHEQrR0bZLvY8NTmQATq/Ky6psZI1xwD8WxM0oJd39Mmsek6tckiVCSlQZuuceYgtCT11zatrhVWDvSgTJr2EtXBK8eRDMtPvVoIXiUpUsk8dpk1jjeMpACVV6C7/44psaJiIEn1xz6jhpCVkmOrYJ3WYlUNBl9CzY7pDI/TMceyqQJXDWZbamrecaD5DArXC+kdpB0o90ZtFD97iFhPOcdlvwZZIJJRTLuG13dU/43iplMfa23B4w9qzJo+ATHUfLdQlJ7hLMS266mNTWxDYYyWnrxyVeJ7O+KQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1659913424; bh=MJx5cxsV7ELbkysUhaWazzJOoZLHteyrA68/h46TzPJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jNZm0Ra9kwqEH4kjwXx60U6Z5tm6cFiv5ev3IqajKdee2w5unFzIgBUJCKaTuqWk3cj8K8Sind0PoFj1TcjkDgXXm0Ym2zF6Ow820KiuNRaK2rmqIWC9ahDs13VmFShUKIBfdGYqhIiv/xNplAIrRf+Ch7sguA7FuXgwvw0RG6jlOTIQXfy278W7W8xepw+DSlnwQ3tdchD6iFcWki+egWnaXl7aXSDu0pVKIfPpjHS9GIrrBOZJfVNNo491OB8a4j1BluJZVo6I1eG2/ElwsX235bSE8bN/cOmK5hW1U/HBzm11AsC2pvppGPLroHMi1amOLrpOWj8MtoUh0LM80A==
X-YMail-OSG: Wl1IYUwVM1nFqfwwcWjP_jLpO4ICeZwCwANq7vdJYRU.XYkJD3cSxNWXPPL3Mz0
 8CAWLyfRl0TsT4sPiWEdnQxUVuAZIM9GzeWJ.GPr6jQ6K0D9_KYg1impF7.vOwTpLmf1rg.yQ.Yu
 NQj60nGcWMEinZOqZe8U8rpGpf7IhN7x0kT_VgIp4B_kuqDpETqzrA5xUwQ.L3hc7yAiWLGBSKMz
 _SurRb5lJhK8kBmwtiDnnh.qrD3fUb3KVfm9zGvoPcn9sWigaB8te_dOtMv6g08O_UYsRRUgQXmX
 Mh2BjTldgVk3Y.pGpSzJ_iQC1u0d90.YM2EAGHaYVQ5aSA2SHar0MSCbF0rpPrTS7FwnHSUlb4aV
 19AV_gLD9MLUhnlQCPBusu8zwaOf2H8TCA_8kq2Ge4WjzTAnVe_beDaUtmBQKJa0ICYe8fsHY29P
 HVdw_Hi8fYFbqeLZggzWxc_fAOU24USCWY5BRzu3u1WvPcTGByrP24oPUE94N5JDxxX6KjVuMr68
 sCpxXMgeUQfO6DZZgHtb.cbgdVa_FEJWKHqPILZZ4LrUiHszOCI6KHWLr6kchMrkhh8n_3wP30qu
 FjcQ2J6UM9vf2h6dcxaqvKpXBuxwNhEzs5zFIpO2EGE95dH2qMrlXe16_lHoJryOPSNBBshAjjFA
 HfBpII7bS8hGhRNah0FDa_KtB0btAPyoHUpHkq90h5KVFTmFSHBauFWFJAFn3e9my3uD9XFccSBq
 WJd.5tOfPgyQWJ4Pi6zWPDVAmC4zWTCKC.sEXERMy7ZGm96oCwL8JO037whtXzxOsxqW40OvlcYq
 FRUK5Lv0xqzMJV.ImuU7h_RAzyHSyPIY6nEX9et7y5a_3VpNgrgnfnwu6KcoLZsXHbWIkvhvCrwG
 owZnkKvy0hlrlM3.tTGtJ3gKVBgsNbFqnVnKtawJ_lofEX5LL18sXnLFoTBduw6pGUAW4lxoK4au
 7DAdjtkJeZd132ah5U_KsfZen830r8X.mScxnPpv6scT1v39GLKAA8jsXewlMdBJlAxopg4ddobU
 3641Q0Tlpi2kLhf4tXjWfJkhcHUlFZPCt9Ntoh7gxSV6JjR2IcHQRxc24c8U0US_sCSRWsmzb5Qj
 xdAt6fAy3uAL4FZNRcpBwedRo1ant52f5.5VQBZahKBluGBgRBH.nt3xD7Zc3ppz7lBN_G5BGkjc
 yZBUWRV6N5SSYZiMGRPsdgO.8oP.sd9FxjsjFdb.e7Gay7pgvLogopnlJSs_OOSNdxd22ojsOZmt
 RcrMu7J9PHni3x3CN66E.rlaul5uc6TIL3SaFtIA1BxTAyNUnVRHJ0RwX0ubZ7uszZONxRAOe4nV
 6wYGcN4xFAL_95wW47WoB9bIg_IGfXvEIbnT5pnbkJ5B0Va4Re10OXTFegZlYRHYIFtBJNhSCLtg
 newngDc.Yp0bfbOVRJ0j6f8X4zcg4pFv3j68rww7hwAaq7W3Cvx71x2eoajGmhXySjT_7Qx439XE
 .l5ZMgd54T8BCC1lnRrXPcg7esuYUaWAN7k4XJagVXbD7UUZhawv8aX6qxGjUaJh1dFavtHhSur0
 U37gGv.HcVYZSW12lYKXQ1RAuIOL_fLz.LvSw38p.cGLyBBzKnb0j3vh5xYC_x87kQnYShOpQMRK
 Yjrtk67IUhjYVpda.e4QNy38uodFNIwVv.gdlVXVdgp7ajSQbtrAzLtMDITJqSibW3mvnJ5kpfRl
 IMEWqqixtk6Pu0xEpzdXXjvRRh0IL_4lOsIlg8E7KYQ.8M2OXTL4A_iRVq_JVHFVkqP6tDdR9y52
 Y7uEHk2MYNLQ2KcayqzbtFDae0KYxP9RrryFkOetjgHkhnVYTcpFBBh4outpR_xiRW8vdziIdsMk
 vPHA1paRlOnqlhVeb2TgSCfQ183obTuXbV7wC54Zl.tE3BecsKQIaCiBqMcXpm4wdFQj6MRG9v.x
 RhmTjML_bOZHEp5RivKciI1HOh8TRS05hwZbXvck1.skK4G7knSvZwXtLLaErncBCHAEqX569S45
 k.IobEAkyb56NntLSa2puJHmd.ooAC8ffMwHUQrwlNdOuzft61HScMFlMyrYEh_RHn68LsWRjXtg
 vmp7K0TFTZymbZ6BUlpkTrc3h0rV7V01ypBUma2jrDxUWn2QhCzEWz0hCqAntSZFcxFae6rNnItc
 iIBPRpJas8EcpGw1mB_bE_jUGDOFK0OvQQf7B6npjSPwiP47YpS4qVFEQtTD6s7Qscgh66jvP_N9
 2Z3Yyy.kg06AdFbZWYzCMsyXq7sCCT5zachsXWNR1kPjpmdJQ6Sh2q9pPu_QvcEueLpkhV_jX_AW
 7EWpFVCqfMwU634VeFTg-
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 7 Aug 2022 23:03:44 +0000
Received: by hermes--canary-production-ir2-f74ffc99c-r76pr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12b0bfa600682cb6edf92800aaf76d46;
          Sun, 07 Aug 2022 23:03:42 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v5 03/14] iio: magnetometer: yas530: Correct scaling of magnetic axes
Date:   Mon,  8 Aug 2022 01:02:08 +0200
Message-Id: <ac47901be69a5da59e06c913ee4dfc9be9eb3d36.1659909060.git.jahau@rocketmail.com>
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

