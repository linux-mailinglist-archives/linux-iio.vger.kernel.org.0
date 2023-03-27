Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF06C9EE7
	for <lists+linux-iio@lfdr.de>; Mon, 27 Mar 2023 11:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjC0JGl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Mar 2023 05:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjC0JFp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2023 05:05:45 -0400
X-Greylist: delayed 1806 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Mar 2023 02:05:18 PDT
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8DB2D57
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 02:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=L5Dqgb+CDPVOE1GUe8LDUQNM6b2zd6pn+JZmdwO8gaA=; b=HrCrlkpRM9PuBtY1323BsaO2eq
        mGuKU/45rnf9nCVCzdG2meds+MjBcZvUf7+1IwpnOrlatZPP3bQ/oaJgUcUqlEkrdQsmcxG+XTH+s
        HlPu7vrttnBXUOi+1rvSx9yWWLHbGRY0GPUOmZUEpIo0AtUUoP5kOnVd52xpl3SO1GUMfTRUd+pA6
        HOHBlfVDZJvXcby3c/Kfm3PZPNPslGX/pt8U8OlkZ4oBHiNRn9QssmOAjN9Alo3t64tHihPwx4Mrc
        6Mwcjvznn1XjDO1FPDIesQTyNzC6G+QHSX8VUfyB0hFYb+EAljX1WHPzvm7tPt+Bp82/f1SbbwMoS
        YVIQxQRg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1pgiJo-000Pcb-Nk; Mon, 27 Mar 2023 10:35:08 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1pgiJo-000H3h-De; Mon, 27 Mar 2023 10:35:08 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, lars@metafoo.de, alexandre.torgue@foss.st.com,
        nuno.sa@analog.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/3] iio: adc: stm32-adc: skip adc-channels setup if none is present
Date:   Mon, 27 Mar 2023 10:34:49 +0200
Message-Id: <20230327083449.1098174-3-sean@geanix.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230327083449.1098174-1-sean@geanix.com>
References: <20230327083449.1098174-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26856/Mon Mar 27 09:24:05 2023)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/iio/adc/stm32-adc.c | 38 +++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index a04fcb2dc80a..6d87cfaadb5d 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2065,28 +2065,30 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
 		}
 	}
 
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
-		}
+	if (nchans - num_diff > 0) {
+		ret = device_property_read_u32_array(dev, "st,adc-channels", chans,
+				nchans);
+		if (ret)
+			return ret;
 
-		/* Channel can't be configured both as single-ended & diff */
-		for (i = 0; i < num_diff; i++) {
-			if (chans[c] == diff[i].vinp) {
-				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[c]);
+		for (c = 0; c < nchans; c++) {
+			if (chans[c] >= adc_info->max_channels) {
+				dev_err(&indio_dev->dev, "Invalid channel %d\n",
+						chans[c]);
 				return -EINVAL;
 			}
-		}
-		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
+
+			/* Channel can't be configured both as single-ended & diff */
+			for (i = 0; i < num_diff; i++) {
+				if (chans[c] == diff[i].vinp) {
+					dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[c]);
+					return -EINVAL;
+				}
+			}
+			stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
 					chans[c], 0, scan_index, false);
-		scan_index++;
+			scan_index++;
+		}
 	}
 
 	if (adc->nsmps > 0) {
-- 
2.39.1

