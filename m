Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8D13C1C6
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 05:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbfFKD4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 23:56:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34011 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390985AbfFKD4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jun 2019 23:56:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id p10so298242pgn.1;
        Mon, 10 Jun 2019 20:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mTzRo3n3K2VxjjsiqqmtCWCsBKqmuZ3UyS2JxCpDSv4=;
        b=lPhGLVG6/t2L9QQBAK9Cv2PvZwTk/cMgQFiBtEC835tN1PRPoW6pDYFxSz17YVhDFD
         HFiQ4a57yAFxr1Jsqxr/Oq8S4c8TKWN1vAn7fx9hqP9JGEj42dlkzNfstvVpAcA08DNe
         92hTkaCEiKz1Kfz1qtAFkEp+lk7nj7VUo+Nn3ATK/GVIexF0xKjX+LLgPPzumEEXDPVU
         vziTHwfs0P48fc3Iae0mXw5f1WJYTsVpSiwN4JgDnOg/uJHuy7nx3tgXWOTvbJxsQLuu
         CUeVL2t5DIsgqbZQjk91EAapzzQx06lGSciY3F7NDoIWohoVg+m4Lx56XQHr6gYIf3kw
         98LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mTzRo3n3K2VxjjsiqqmtCWCsBKqmuZ3UyS2JxCpDSv4=;
        b=jTdBqXcfFklFPmcOkdkCDte9uN7u2EPrgbQ3KzuRitVVlGAaLc1DGBijmVPo0PVS0h
         8Hgnp6WrFnAWJRTR8PMt8hec+xrwZOrPhmV77/IfXvwGPl48yBeitLZJr1ESEP9U2wA7
         n8DuopVGzQBcrzqCZKmWkAhEizUrMuAdWWqDkXFmbsaPjVdWorMsDNf4hXXrpsHpUqGt
         gnURa66lCTuoFeHMhheBOhYxykK1/jIwFQcgwKxKQGbxjxCNxYpkj2N5cTVFiQXyynpj
         OWdyubxkLCQTmQepmLeMyFLqoVjiACDwzgFHXbGXq7HptmLULmMiy3jzUUYKCA6TVUuI
         /Vsw==
X-Gm-Message-State: APjAAAU6u+8BS9EEDjC5pU2t9drdwhyTOPsSLzQyBNsAvSArAnc7kZc0
        h3dqZm5nbiVYpUCWlactV6c=
X-Google-Smtp-Source: APXvYqz+Xnt2HUGrc/sBTFjjjGMlEt3VpJVIlOjLqvkF+0LD1W8Kaa5018BLm5rwMMVp9SZFsXxHpA==
X-Received: by 2002:a65:5684:: with SMTP id v4mr18784442pgs.160.1560225361285;
        Mon, 10 Jun 2019 20:56:01 -0700 (PDT)
Received: from t-1000 (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id 5sm11939074pfh.109.2019.06.10.20.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 20:56:00 -0700 (PDT)
Date:   Mon, 10 Jun 2019 20:55:57 -0700
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        harald@ccbib.org
Cc:     shobhitkukreti@gmail.com
Subject: [PATCH] iio: humidity: Replace older GPIO APIs with GPIO Consumer
 APIs for the dht11 sensor
Message-ID: <20190611035554.GA20589@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The dht11 driver uses a single gpio to make measurements. It was
using the older global gpio numberspace. The patch replaces the
old gpio api with the new gpio descriptor based api.

Removed header files "linux/gpio.h" and "linux/of_gpio.h"

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/iio/humidity/dht11.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index c815920..f5128d8 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -22,8 +22,7 @@
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/timekeeping.h>
 
 #include <linux/iio/iio.h>
@@ -72,7 +71,7 @@
 struct dht11 {
 	struct device			*dev;
 
-	int				gpio;
+	struct gpio_desc		*gpiod;
 	int				irq;
 
 	struct completion		completion;
@@ -179,7 +178,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
 	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
 		dht11->edges[dht11->num_edges].ts = ktime_get_boot_ns();
 		dht11->edges[dht11->num_edges++].value =
-						gpio_get_value(dht11->gpio);
+						gpiod_get_value(dht11->gpiod);
 
 		if (dht11->num_edges >= DHT11_EDGES_PER_READ)
 			complete(&dht11->completion);
@@ -217,12 +216,12 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 		reinit_completion(&dht11->completion);
 
 		dht11->num_edges = 0;
-		ret = gpio_direction_output(dht11->gpio, 0);
+		ret = gpiod_direction_output(dht11->gpiod, 0);
 		if (ret)
 			goto err;
 		usleep_range(DHT11_START_TRANSMISSION_MIN,
 			     DHT11_START_TRANSMISSION_MAX);
-		ret = gpio_direction_input(dht11->gpio);
+		ret = gpiod_direction_input(dht11->gpiod);
 		if (ret)
 			goto err;
 
@@ -294,10 +293,8 @@ MODULE_DEVICE_TABLE(of, dht11_dt_ids);
 static int dht11_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
 	struct dht11 *dht11;
 	struct iio_dev *iio;
-	int ret;
 
 	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
 	if (!iio) {
@@ -307,18 +304,13 @@ static int dht11_probe(struct platform_device *pdev)
 
 	dht11 = iio_priv(iio);
 	dht11->dev = dev;
+	dht11->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
+	if (IS_ERR(dht11->gpiod))
+		return PTR_ERR(dht11->gpiod);
 
-	ret = of_get_gpio(node, 0);
-	if (ret < 0)
-		return ret;
-	dht11->gpio = ret;
-	ret = devm_gpio_request_one(dev, dht11->gpio, GPIOF_IN, pdev->name);
-	if (ret)
-		return ret;
-
-	dht11->irq = gpio_to_irq(dht11->gpio);
+	dht11->irq = gpiod_to_irq(dht11->gpiod);
 	if (dht11->irq < 0) {
-		dev_err(dev, "GPIO %d has no interrupt\n", dht11->gpio);
+		dev_err(dev, "GPIO %d has no interrupt\n", desc_to_gpio(dht11->gpiod));
 		return -EINVAL;
 	}
 
-- 
2.7.4

