Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB914132E1
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhIULzl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 07:55:41 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37491 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhIULzk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 07:55:40 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5C8AD24001B;
        Tue, 21 Sep 2021 11:54:10 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v4 02/16] iio: adc: max1027: Drop extra warning message
Date:   Tue, 21 Sep 2021 13:53:54 +0200
Message-Id: <20210921115408.66711-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210921115408.66711-1-miquel.raynal@bootlin.com>
References: <20210921115408.66711-1-miquel.raynal@bootlin.com>
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

