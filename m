Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE91E3FF573
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347108AbhIBVPs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:15:48 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34289 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346987AbhIBVPq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:46 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C159B24000F;
        Thu,  2 Sep 2021 21:14:45 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 09/16] iio: adc: max1027: Ensure a default cnvst trigger configuration
Date:   Thu,  2 Sep 2021 23:14:30 +0200
Message-Id: <20210902211437.503623-10-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

We don't expect the (hardware) cnvst trigger to be enabled at boot time,
this is a user choice made in sysfs and there is a dedicated callback to
enable/disable this trigger. Hence, we can just ensure it is disabled in
the probe at initialization time and then assume that whenever a
->read_raw() call happens, the trigger has been disabled and conversions
will start on register write.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 9269931ca09d..476b90f12330 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -288,10 +288,6 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
 		return -EBUSY;
 	}
 
-	ret = max1027_enable_trigger(indio_dev, false);
-	if (ret)
-		return ret;
-
 	/* Configure conversion register with the requested chan */
 	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
 		  MAX1027_NOSCAN;
@@ -541,6 +537,11 @@ static int max1027_probe(struct spi_device *spi)
 		goto free_buffer;
 	}
 
+	/* Assume conversion on register write for now */
+	ret = max1027_enable_trigger(indio_dev, false);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 
 free_buffer:
-- 
2.27.0

