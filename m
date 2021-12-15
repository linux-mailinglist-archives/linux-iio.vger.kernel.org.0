Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A63475B97
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhLOPNt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:13:49 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:60965 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbhLOPNt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:13:49 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 13A3A20000B;
        Wed, 15 Dec 2021 15:13:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 04/10] iio: adc: stm32-dfsdm: Avoid dereferencing ->currentmode
Date:   Wed, 15 Dec 2021 16:13:38 +0100
Message-Id: <20211215151344.163036-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211215151344.163036-1-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
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

