Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E623F7911
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbhHYPfr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:35:47 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:41343 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbhHYPfl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:35:41 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id E62E9CE0E2;
        Wed, 25 Aug 2021 15:26:58 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 748B0C000C;
        Wed, 25 Aug 2021 15:26:34 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 36/40] iio: adc: ti_am335x_adc: Add the scale information
Date:   Wed, 25 Aug 2021 17:25:14 +0200
Message-Id: <20210825152518.379386-37-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Without the scale, the values returned to the user are just a picture of
the input voltage against the full scale range of the ADC. We need to
provide the actual conversion factor to get milli-Volts values.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index d4619fd6fd54..f644898b47dd 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -417,6 +417,7 @@ static int tiadc_channel_init(struct device *dev, struct iio_dev *indio_dev,
 		chan->indexed = 1;
 		chan->channel = adc_dev->channel_line[i];
 		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+		chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
 		chan->datasheet_name = chan_name_ain[chan->channel];
 		chan->scan_index = i;
 		chan->scan_type.sign = 'u';
@@ -441,6 +442,23 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	unsigned long timeout;
 	int ret;
 
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = 1800;
+			*val2 = chan->scan_type.realbits;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (iio_buffer_enabled(indio_dev))
 		return -EBUSY;
 
-- 
2.27.0

