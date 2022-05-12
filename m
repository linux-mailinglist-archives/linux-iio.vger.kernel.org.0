Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1782F52401C
	for <lists+linux-iio@lfdr.de>; Thu, 12 May 2022 00:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbiEKWN5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 May 2022 18:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiEKWN4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 May 2022 18:13:56 -0400
X-Greylist: delayed 456 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 May 2022 15:13:55 PDT
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7928D21B150
        for <linux-iio@vger.kernel.org>; Wed, 11 May 2022 15:13:55 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 621FF2085B;
        Thu, 12 May 2022 00:06:17 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] iio: adc: qcom-spmi-adc5: Add missing VCOIN/AMUX_THM3/GPIO# channels
Date:   Thu, 12 May 2022 00:06:10 +0200
Message-Id: <20220511220613.1015472-5-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511220613.1015472-1-marijn.suijten@somainline.org>
References: <20220511220613.1015472-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These channels are specified in downstream kernels [1] and actively used
by ie. the Sony Seine platform on the SM6125 SoC.

[1]: https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/iio/adc/qcom-spmi-adc5.c?h=LA.UM.7.11.r1-05200-NICOBAR.0#n688

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 87438d1e5c0b..69c7fd44d34c 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -526,6 +526,8 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_VBAT_SNS]		= ADC5_CHAN_VOLT("vbat_sns", 1,
 					SCALE_HW_CALIB_DEFAULT)
+	[ADC5_VCOIN]		= ADC5_CHAN_VOLT("vcoin", 1,
+					SCALE_HW_CALIB_DEFAULT)
 	[ADC5_DIE_TEMP]		= ADC5_CHAN_TEMP("die_temp", 0,
 					SCALE_HW_CALIB_PMIC_THERM)
 	[ADC5_USB_IN_I]		= ADC5_CHAN_VOLT("usb_in_i_uv", 0,
@@ -549,6 +551,16 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_AMUX_THM2]	= ADC5_CHAN_TEMP("amux_thm2", 0,
 					SCALE_HW_CALIB_PM5_SMB_TEMP)
+	[ADC5_AMUX_THM3]	= ADC5_CHAN_TEMP("amux_thm3", 0,
+					SCALE_HW_CALIB_PM5_SMB_TEMP)
+	[ADC5_GPIO1_100K_PU]	= ADC5_CHAN_TEMP("gpio1_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
+	[ADC5_GPIO2_100K_PU]	= ADC5_CHAN_TEMP("gpio2_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
+	[ADC5_GPIO3_100K_PU]	= ADC5_CHAN_TEMP("gpio3_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
+	[ADC5_GPIO4_100K_PU]	= ADC5_CHAN_TEMP("gpio4_100k_pu", 0,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
 };
 
 static const struct adc5_channels adc7_chans_pmic[ADC5_MAX_CHANNEL] = {
-- 
2.36.1

