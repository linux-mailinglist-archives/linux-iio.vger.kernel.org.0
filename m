Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022686F5BD8
	for <lists+linux-iio@lfdr.de>; Wed,  3 May 2023 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjECQUx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 May 2023 12:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjECQUw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 May 2023 12:20:52 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A266E90
        for <linux-iio@vger.kernel.org>; Wed,  3 May 2023 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=1GoopODsvTgG4yhK/ErXIIHntPk72a3taRR/Ug0RtmE=; b=veq33OwustGPuqcUUQQ7jm2eeK
        VPnwBoCBOXoiWFcQ3qnZ9NWh0w9i8blpPtLw2rl17B8EZbcgZy4jTk/Fk0sFO1UQtWoKXsIsZPMTs
        r32VuNwMRXsML2sEaq+usgngL+nDPz6wul/S33HSq2Qe1t9InfmcpYKVSOFzG4H9D5oPXtKYg5waL
        jroOFPZk+2sOO/tr2oCrD0sUzsTP/KsN8hp1IUnHqAGte83nY7BlZLjTJStz2OZHqWWjHyuZqxrev
        SBzZVfqopD7huXuAjo9XznaoExUF3HRz6Hn1F7lXkWU4cLuls0L/l/e3S8jUc8ZEMIE0WV744U9LR
        ZkA7/lsQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1puFDf-000MMN-9B; Wed, 03 May 2023 18:20:43 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1puFDe-000QMl-TC; Wed, 03 May 2023 18:20:42 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, olivier.moysan@foss.st.com,
        alexandre.torgue@foss.st.com, nuno.sa@analog.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 2/2] iio: adc: stm32-adc: skip adc-channels setup if none is present
Date:   Wed,  3 May 2023 18:20:29 +0200
Message-Id: <20230503162029.3654093-2-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503162029.3654093-1-sean@geanix.com>
References: <20230503162029.3654093-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26895/Wed May  3 09:23:02 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If only adc differential channels are defined driver will fail with
stm32-adc: probe of 48003000.adc:adc@0 failed with error -22

Fix this by skipping the initialization if no channels are defined.

This applies only to the legacy way of initializing adc channels.

Fixes: d7705f35448a ("iio: adc: stm32-adc: convert to device properties")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes since v1:
- Ignore extra channel for timestamps in PIO mode
- Use single ended count in channel creation (Thanks Olivier Moysan)

Changes since v2:
- Avoid calling device_property_read_u32_array with num_se 0 (Thanks Olivier Moysan)

 drivers/iio/adc/stm32-adc.c | 42 ++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 14524c1b5583..f7613efb870d 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2038,6 +2038,7 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 	struct stm32_adc_diff_channel diff[STM32_ADC_CH_MAX];
 	struct device *dev = &indio_dev->dev;
 	u32 num_diff = adc->num_diff;
+	int num_se = nchans - num_diff;
 	int size = num_diff * sizeof(*diff) / sizeof(u32);
 	int scan_index = 0, ret, i, c;
 	u32 smp = 0, smps[STM32_ADC_CH_MAX], chans[STM32_ADC_CH_MAX];
@@ -2064,29 +2065,32 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 			scan_index++;
 		}
 	}
-
-	ret = device_property_read_u32_array(dev, "st,adc-channels", chans,
-					     nchans);
-	if (ret)
-		return ret;
-
-	for (c = 0; c < nchans; c++) {
-		if (chans[c] >= adc_info->max_channels) {
-			dev_err(&indio_dev->dev, "Invalid channel %d\n",
-				chans[c]);
-			return -EINVAL;
+	if (num_se > 0) {
+		ret = device_property_read_u32_array(dev, "st,adc-channels", chans, num_se);
+		if (ret) {
+			dev_err(&indio_dev->dev, "Failed to get st,adc-channels %d\n", ret);
+			return ret;
 		}
 
-		/* Channel can't be configured both as single-ended & diff */
-		for (i = 0; i < num_diff; i++) {
-			if (chans[c] == diff[i].vinp) {
-				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[c]);
+		for (c = 0; c < num_se; c++) {
+			if (chans[c] >= adc_info->max_channels) {
+				dev_err(&indio_dev->dev, "Invalid channel %d\n",
+					chans[c]);
 				return -EINVAL;
 			}
+
+			/* Channel can't be configured both as single-ended & diff */
+			for (i = 0; i < num_diff; i++) {
+				if (chans[c] == diff[i].vinp) {
+					dev_err(&indio_dev->dev, "channel %d misconfigured\n",
+						chans[c]);
+					return -EINVAL;
+				}
+			}
+			stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
+						chans[c], 0, scan_index, false);
+			scan_index++;
 		}
-		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
-					chans[c], 0, scan_index, false);
-		scan_index++;
 	}
 
 	if (adc->nsmps > 0) {
@@ -2307,7 +2311,7 @@ static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
 
 	if (legacy)
 		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels,
-						 num_channels);
+						 timestamping ? num_channels - 1 : num_channels);
 	else
 		ret = stm32_adc_generic_chan_init(indio_dev, adc, channels);
 	if (ret < 0)
-- 
2.40.0

