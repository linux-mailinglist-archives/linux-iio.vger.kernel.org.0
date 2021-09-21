Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740834132EF
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhIULzx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 07:55:53 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41555 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbhIULzt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 07:55:49 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id CF964240012;
        Tue, 21 Sep 2021 11:54:19 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 13/16] iio: adc: max1027: Stop requesting a threaded IRQ
Date:   Tue, 21 Sep 2021 13:54:05 +0200
Message-Id: <20210921115408.66711-14-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210921115408.66711-1-miquel.raynal@bootlin.com>
References: <20210921115408.66711-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The threaded handler is not populated, this means there is nothing
running in process context so let's switch to the regular
devm_request_irq() call instead.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index e0175448c899..84217e18ef70 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -560,12 +560,10 @@ static int max1027_probe(struct spi_device *spi)
 			return ret;
 		}
 
-		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
-						iio_trigger_generic_data_rdy_poll,
-						NULL,
-						IRQF_TRIGGER_FALLING,
-						spi->dev.driver->name,
-						st->trig);
+		ret = devm_request_irq(&spi->dev, spi->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_TRIGGER_FALLING,
+				       spi->dev.driver->name, st->trig);
 		if (ret < 0) {
 			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
 			return ret;
-- 
2.27.0

