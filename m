Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7812442EBBA
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 10:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbhJOITP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 04:19:15 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33027 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbhJOISK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 04:18:10 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 96D732001D;
        Fri, 15 Oct 2021 08:16:01 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 41/48] iio: adc: ti_am335x_adc: Get rid of useless gotos
Date:   Fri, 15 Oct 2021 10:14:59 +0200
Message-Id: <20211015081506.933180-42-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015081506.933180-1-miquel.raynal@bootlin.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Gotos jumping to a return statement are not really useful, drop them.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 496603ab7841..aa151d702a14 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -636,11 +636,11 @@ static int tiadc_probe(struct platform_device *pdev)
 						IRQF_SHARED,
 						&tiadc_buffer_setup_ops);
 	if (err)
-		goto err_free_channels;
+		return err;
 
 	err = iio_device_register(indio_dev);
 	if (err)
-		goto err_buffer_unregister;
+		return err;
 
 	platform_set_drvdata(pdev, indio_dev);
 
@@ -652,8 +652,7 @@ static int tiadc_probe(struct platform_device *pdev)
 
 err_dma:
 	iio_device_unregister(indio_dev);
-err_buffer_unregister:
-err_free_channels:
+
 	return err;
 }
 
-- 
2.27.0

