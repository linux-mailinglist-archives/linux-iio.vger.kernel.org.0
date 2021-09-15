Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE6F40C8E6
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbhIOPxF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 11:53:05 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:46133 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbhIOPwm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 11:52:42 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id AFC47200016;
        Wed, 15 Sep 2021 15:51:21 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v3 05/14] iio: adc: max1027: Rename a helper
Date:   Wed, 15 Sep 2021 17:51:08 +0200
Message-Id: <20210915155117.475962-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155117.475962-1-miquel.raynal@bootlin.com>
References: <20210915155117.475962-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/max1027.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 7c1c76673be2..e84f49f21778 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -389,7 +389,7 @@ static int max1027_validate_trigger(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int max1027_set_trigger_state(struct iio_trigger *trig, bool state)
+static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct max1027_state *st = iio_priv(indio_dev);
@@ -450,7 +450,7 @@ static irqreturn_t max1027_trigger_handler(int irq, void *private)
 
 static const struct iio_trigger_ops max1027_trigger_ops = {
 	.validate_device = &iio_trigger_validate_own_device,
-	.set_trigger_state = &max1027_set_trigger_state,
+	.set_trigger_state = &max1027_set_cnvst_trigger_state,
 };
 
 static const struct iio_info max1027_info = {
-- 
2.27.0

