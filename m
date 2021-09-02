Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB403FF56A
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 23:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhIBVPk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Sep 2021 17:15:40 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47071 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346531AbhIBVPk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 17:15:40 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 211EB240009;
        Thu,  2 Sep 2021 21:14:40 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 02/16] iio: adc: max1027: Drop extra warning message
Date:   Thu,  2 Sep 2021 23:14:23 +0200
Message-Id: <20210902211437.503623-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902211437.503623-1-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Memory allocation errors automatically trigger the right logs, no need
to have our own.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/max1027.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 5c4633a54b30..3994d3566f05 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -445,10 +445,8 @@ static int max1027_probe(struct spi_device *spi)
 	st->buffer = devm_kmalloc_array(&indio_dev->dev,
 					indio_dev->num_channels, 2,
 					GFP_KERNEL);
-	if (!st->buffer) {
-		dev_err(&indio_dev->dev, "Can't allocate buffer\n");
+	if (!st->buffer)
 		return -ENOMEM;
-	}
 
 	if (spi->irq) {
 		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-- 
2.27.0

