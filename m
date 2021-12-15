Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF70F475B96
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbhLOPNt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:13:49 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:34045 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbhLOPNs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:13:48 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 632C3200011;
        Wed, 15 Dec 2021 15:13:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 03/10] iio: magnetometer: rm3100: Stop abusing the ->currentmode
Date:   Wed, 15 Dec 2021 16:13:37 +0100
Message-Id: <20211215151344.163036-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211215151344.163036-1-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is an internal variable for the core, here it is set to a "default"
value by the driver in order to later be able to perform checks against
it. None of this is needed because this check actually cares about the
buffers being enabled or not. So it is an unproper side-channel access
to the information "are the buffers enabled?", returned officially by
the iio_buffer_enabled() helper. Use this helper instead.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 13914273c999..be0057f82218 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -141,18 +141,10 @@ static irqreturn_t rm3100_irq_handler(int irq, void *d)
 	struct iio_dev *indio_dev = d;
 	struct rm3100_data *data = iio_priv(indio_dev);
 
-	switch (indio_dev->currentmode) {
-	case INDIO_DIRECT_MODE:
+	if (!iio_buffer_enabled(indio_dev))
 		complete(&data->measuring_done);
-		break;
-	case INDIO_BUFFER_TRIGGERED:
+	else
 		iio_trigger_poll(data->drdy_trig);
-		break;
-	default:
-		dev_err(indio_dev->dev.parent,
-			"device mode out of control, current mode: %d",
-			indio_dev->currentmode);
-	}
 
 	return IRQ_WAKE_THREAD;
 }
@@ -377,7 +369,7 @@ static int rm3100_set_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 			goto unlock_return;
 	}
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_buffer_enabled(indio_dev)) {
 		/* Writing TMRC registers requires CMM reset. */
 		ret = regmap_write(regmap, RM3100_REG_CMM, 0);
 		if (ret < 0)
@@ -553,7 +545,6 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	indio_dev->channels = rm3100_channels;
 	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
-	indio_dev->currentmode = INDIO_DIRECT_MODE;
 
 	if (!irq)
 		data->use_interrupt = false;
-- 
2.27.0

