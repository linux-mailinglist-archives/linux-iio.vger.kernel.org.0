Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763FA2C1D30
	for <lists+linux-iio@lfdr.de>; Tue, 24 Nov 2020 06:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgKXFAZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Nov 2020 00:00:25 -0500
Received: from anchovy2.45ru.net.au ([203.30.46.146]:45424 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgKXFAY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Nov 2020 00:00:24 -0500
Received: (qmail 2156 invoked by uid 5089); 24 Nov 2020 05:00:22 -0000
Received: by simscan 1.2.0 ppid: 2134, pid: 2135, t: 0.0542s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
X-RBL:  $rbltext
Received: from unknown (HELO preid-c8.electromag.com.au) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 24 Nov 2020 05:00:22 -0000
Received: by preid-c8.localdomain (Postfix, from userid 1000)
        id 76257163BB9; Tue, 24 Nov 2020 13:00:17 +0800 (AWST)
From:   Phil Reid <preid@electromag.com.au>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, preid@electromag.com.au,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/1] iio: potentiometer: ad5272: Correct polarity of reset
Date:   Tue, 24 Nov 2020 13:00:14 +0800
Message-Id: <20201124050014.4453-1-preid@electromag.com.au>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver should assert reset by setting the gpio high, and
then release it by setting it the gpio low. This allows the
device tree (or other hardware definition) to specify how the
gpio is configured.

For example as open drain or push-pull depending on the
connected hardware.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/iio/potentiometer/ad5272.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
index 70c45d346df0..d8cbd170262f 100644
--- a/drivers/iio/potentiometer/ad5272.c
+++ b/drivers/iio/potentiometer/ad5272.c
@@ -143,13 +143,13 @@ static int ad5272_reset(struct ad5272_data *data)
 	struct gpio_desc *reset_gpio;
 
 	reset_gpio = devm_gpiod_get_optional(&data->client->dev, "reset",
-		GPIOD_OUT_LOW);
+		GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio))
 		return PTR_ERR(reset_gpio);
 
 	if (reset_gpio) {
 		udelay(1);
-		gpiod_set_value(reset_gpio, 1);
+		gpiod_set_value(reset_gpio, 0);
 	} else {
 		ad5272_write(data, AD5272_RESET, 0);
 	}
-- 
2.18.4

