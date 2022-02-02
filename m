Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAFB4A7285
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344262AbiBBOCO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:14 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:46195 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBBOCN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:13 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 926E8200014;
        Wed,  2 Feb 2022 14:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WciQsWVrW+ryuSY52BUG5SUQM8FfGRtZr2q/qvY+RvA=;
        b=gr8b3GD52GjM0g67aCrr5+xDUGSvtLDaOE6dKHa8SVQ2D2zmlqvKwPytqzjljLHfoOdAVl
        CY0Ne1AfN86Z2OkePMJOa3CXv+HVg6uECJck+zqDZEcr5bctS90Srkr0EOJnxZ61VCzuWW
        eg/zb3y127h8OCAo7UwkvMIlfmL5pIan/RTidQNO5EbeV2FFySFZSf2x40NCEQ7Dq7k0UC
        8TSQm9npfEG+CVorRKKxJevHRTnIjiyU1lv2FKYQ49t7/p32RIVZX31Cw8z72x/ktTmCDc
        jC1bldsTYAEK49Rh45upFI+3mg/1T9+NeLA4NAgd/DGRCbsjpLFfbyJWpP3xYg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 03/12] iio: adc: stm32-dfsdm: Avoid dereferencing ->currentmode
Date:   Wed,  2 Feb 2022 15:01:59 +0100
Message-Id: <20220202140208.391394-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202140208.391394-1-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is an internal variable of the core, let's use the
iio_buffer_enabled() helper which is exported for the following purpose:
telling if the current mode is a buffered mode, which is precisely what
this driver looks for.

Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 1cfefb3b5e56..a3b8827d3bbf 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -466,8 +466,7 @@ static int stm32_dfsdm_channels_configure(struct iio_dev *indio_dev,
 	 * In continuous mode, use fast mode configuration,
 	 * if it provides a better resolution.
 	 */
-	if (adc->nconv == 1 && !trig &&
-	    (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)) {
+	if (adc->nconv == 1 && !trig && iio_buffer_enabled(indio_dev)) {
 		if (fl->flo[1].res >= fl->flo[0].res) {
 			fl->fast = 1;
 			flo = &fl->flo[1];
@@ -562,7 +561,7 @@ static int stm32_dfsdm_filter_configure(struct iio_dev *indio_dev,
 		cr1 = DFSDM_CR1_RCH(chan->channel);
 
 		/* Continuous conversions triggered by SPI clk in buffer mode */
-		if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
+		if (iio_buffer_enabled(indio_dev))
 			cr1 |= DFSDM_CR1_RCONT(1);
 
 		cr1 |= DFSDM_CR1_RSYNC(fl->sync_mode);
-- 
2.27.0

