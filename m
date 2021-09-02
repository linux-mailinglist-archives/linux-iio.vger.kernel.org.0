Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3BD3FF68F
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347820AbhIBVyT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:54:19 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33777 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347861AbhIBVyJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:54:09 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 29207240008;
        Thu,  2 Sep 2021 21:53:08 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 42/46] iio: adc: ti_am335x_adc: Add the scale information
Date:   Thu,  2 Sep 2021 23:51:40 +0200
Message-Id: <20210902215144.507243-43-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902215144.507243-1-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 72b11d7118aa..751ca70442ba 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -425,6 +425,7 @@ static int tiadc_channel_init(struct device *dev, struct iio_dev *indio_dev,
 		chan->indexed = 1;
 		chan->channel = adc_dev->channel_line[i];
 		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+		chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
 		chan->datasheet_name = chan_name_ain[chan->channel];
 		chan->scan_index = i;
 		chan->scan_type.sign = 'u';
@@ -449,6 +450,23 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
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

