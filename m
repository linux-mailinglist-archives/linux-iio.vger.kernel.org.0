Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206623F0252
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhHRLMV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:21 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43365 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhHRLMS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:18 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id A0CA560006;
        Wed, 18 Aug 2021 11:11:42 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 04/16] iio: adc: max1027: Lower conversion time
Date:   Wed, 18 Aug 2021 13:11:27 +0200
Message-Id: <20210818111139.330636-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When only a few channels are requested, the core will request all of
them as long as ->available_scan_masks is present, thus reducing the
impact of any driver side optimization to avoid converting the unneeded
channels.

Do not share this bitmap with the core, which is optional anyway.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 8ab660f596b5..d79dabf20567 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -457,7 +457,6 @@ static int max1027_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
-	indio_dev->available_scan_masks = st->info->available_scan_masks;
 
 	st->buffer = devm_kmalloc_array(&indio_dev->dev,
 				  indio_dev->num_channels, 2,
-- 
2.27.0

