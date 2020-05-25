Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEEB1E1344
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391305AbgEYRJZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391301AbgEYRJZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:25 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4B4120878;
        Mon, 25 May 2020 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426564;
        bh=j5orTSX/27oQbVPk5oYRFnnZSh0KwF86SEvaraRl1TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1eWOV8hNQt1cVwkAn6S8nbpMZt4SnfhDYL01vLC3hhAfumXQIuNmBwdjFR+khLGyW
         WAUwbB6cJfhmf3vL3d9HbeFU/AnfhnsTpMumpwn7rvUxkPEtazzv40AYDUKlq1uXCn
         UK8vZnv6+HsKr3KwBkvsohEOupZdWK4rE5LBnmo4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 20/25] iio:adc:ti-ads124s08 Fix alignment and data leak issues.
Date:   Mon, 25 May 2020 18:06:23 +0100
Message-Id: <20200525170628.503283-21-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525170628.503283-1-jic23@kernel.org>
References: <20200525170628.503283-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses an array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak apart from previous readings.

Fixes: e717f8c6dfec ("iio: adc: Add the TI ads124s08 ADC code")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Murphy <dmurphy@ti.com>
---
 drivers/iio/adc/ti-ads124s08.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index f1ee3b1e2827..fb0da62b09f5 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -99,6 +99,11 @@ struct ads124s_private {
 	struct gpio_desc *reset_gpio;
 	struct spi_device *spi;
 	struct mutex lock;
+	/*
+	 * Used to correctly align data.
+	 * Ensure timestamp is naturally aligned.
+	 */
+	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);
 	u8 data[5] ____cacheline_aligned;
 };
 
@@ -269,7 +274,6 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ads124s_private *priv = iio_priv(indio_dev);
-	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
 	int scan_index, j = 0;
 	int ret;
 
@@ -284,7 +288,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		if (ret)
 			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
 
-		buffer[j] = ads124s_read(indio_dev, scan_index);
+		priv->buffer[j] = ads124s_read(indio_dev, scan_index);
 		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
 		if (ret)
 			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");
@@ -292,7 +296,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer,
 			pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.26.2

