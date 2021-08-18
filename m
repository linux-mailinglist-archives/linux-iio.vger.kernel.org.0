Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE933F0254
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 13:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhHRLMZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 07:12:25 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50709 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbhHRLMT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 07:12:19 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0091660005;
        Wed, 18 Aug 2021 11:11:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 06/16] iio: adc: max1027: Rename a helper
Date:   Wed, 18 Aug 2021 13:11:29 +0200
Message-Id: <20210818111139.330636-7-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210818111139.330636-1-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make it clear that the *_set_trigger_state() hook is responsible for
cnvst based conversions by renaming the helper. This may avoid
confusions with software trigger support that is going to be
introduced.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/adc/max1027.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index ac603b4ca787..a6ebc951c09a 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -354,7 +354,7 @@ static int max1027_validate_trigger(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
+static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct max1027_state *st = iio_priv(indio_dev);
@@ -423,7 +423,7 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
 
 static const struct iio_trigger_ops max1027_trigger_ops = {
 	.validate_device = &iio_trigger_validate_own_device,
-	.set_trigger_state = &max1027_set_trigger_state,
+	.set_trigger_state = &max1027_set_cnvst_trigger_state,
 };
 
 static const struct iio_info max1027_info = {
-- 
2.27.0

