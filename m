Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A4820CC
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfHEPyE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:54:04 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51777 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHEPyE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 11:54:04 -0400
Received: from uno.homenet.telecomitalia.it (host150-24-dynamic.51-79-r.retail.telecomitalia.it [79.51.24.150])
        (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B217B240009;
        Mon,  5 Aug 2019 15:54:00 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: max9611: Fix temperature reading in probe
Date:   Mon,  5 Aug 2019 17:55:15 +0200
Message-Id: <20190805155515.22621-1-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The max9611 driver reads the die temperature at probe time to validate
the communication channel. Use the actual read value to perform the test
instead of the read function return value, which was mistakenly used so
far.

The temperature reading test was only successful because the 0 return
value is in the range of supported temperatures.

Fixes: 69780a3bbc0b ("iio: adc: Add Maxim max9611 ADC driver")
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/iio/adc/max9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 917223d5ff5b..e9f6b1da1b94 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -480,7 +480,7 @@ static int max9611_init(struct max9611_dev *max9611)
 	if (ret)
 		return ret;

-	regval = ret & MAX9611_TEMP_MASK;
+	regval &= MAX9611_TEMP_MASK;

 	if ((regval > MAX9611_TEMP_MAX_POS &&
 	     regval < MAX9611_TEMP_MIN_NEG) ||
--
2.22.0

