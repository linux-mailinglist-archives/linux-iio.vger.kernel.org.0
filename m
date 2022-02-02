Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3934A7284
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiBBOCM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:12 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:45313 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBBOCM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:12 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id ACC64200009;
        Wed,  2 Feb 2022 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TawdqjX7BEkznrUMkUPTanTqZyIkwauouY0To3CdU2s=;
        b=jdGBfTlDPoQ9AEvAaZbELs+FKIZHiNzavI8beVQibN7nWUg0EwFeFKMHCPkfnCARzKHeOr
        jF9H2XjIp5yuOFz0RMnz7z8XlULsI0Ysdj4H2Y+sr9PrzP8OpP4fjx4g6nfAnZrKUSZtA1
        9CztP8Rtv5Hg5RlhNZWiWmcymYgqIEn5QNH4I+T2AV/R79YYRRChEfvlfbmx5V134juueu
        H9HSZuBqgfmEd541qUZYAoxqvteh/1oUpaU9/ZBbgZ2tuv+VmRecqutBZOrxe7UxJvFSeY
        W7+pGv81W0P/zSdPxy7o3RkfPXuk/JjQpUvSED3y7/vfiGb+KzZH+u+bAwaUjw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v2 02/12] iio: magnetometer: rm3100: Stop abusing the ->currentmode
Date:   Wed,  2 Feb 2022 15:01:58 +0100
Message-Id: <20220202140208.391394-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202140208.391394-1-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
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

Cc: Song Qiang <songqiang1304521@gmail.com>
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

