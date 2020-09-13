Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A3267FA9
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgIMNX0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 09:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIMNXW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 09:23:22 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0BC221974;
        Sun, 13 Sep 2020 13:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600003401;
        bh=cQSegIGnq/fGyRw7bxvadcK0q+DtJP5n+d3spObLNK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnGbm/Tjz44TN9sjhyWBhMfNmSUGaXtqZeKRvMZYLeCPDJNXWTL+5PsBf61d4Ut/U
         TEoB9lKAFioCQm7NOznbYvu7iNcQNLnkjaKbVgVZsGWypG1YOQznirp76f7P7xJqIn
         y0V95kGoUX1QKMZNgQnSgISJfV3cvBAHCltJyEbU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/3] iio: Add __printf() attributes to various allocation functions
Date:   Sun, 13 Sep 2020 14:21:14 +0100
Message-Id: <20200913132115.800131-3-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913132115.800131-1-jic23@kernel.org>
References: <20200913132115.800131-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A partial set of these was added to IIO a long time back.
This fills in some gaps in coverage highlighted by building
with W=1

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-trigger.c   | 2 +-
 include/linux/iio/iio.h              | 4 ++--
 include/linux/iio/trigger_consumer.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 6f16357fd732..adfe023cad48 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -516,7 +516,7 @@ static void iio_trig_subirqunmask(struct irq_data *d)
 	trig->subirqs[d->irq - trig->subirq_base].enabled = true;
 }
 
-static struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
+__printf(1, 0) static struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
 {
 	struct iio_trigger *trig;
 	int i;
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index e2df67a3b9ab..a02a3efad794 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -691,8 +691,8 @@ static inline void *iio_priv(const struct iio_dev *indio_dev)
 
 void iio_device_free(struct iio_dev *indio_dev);
 struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv);
-struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
-						const char *fmt, ...);
+__printf(2, 3) struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
+							  const char *fmt, ...);
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
  * @indio_dev:		IIO device structure for device
diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index 3aa2f132dd67..2c05dfad88d7 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -38,7 +38,7 @@ struct iio_poll_func {
 };
 
 
-struct iio_poll_func
+__printf(5, 6) struct iio_poll_func
 *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
 		    irqreturn_t (*thread)(int irq, void *p),
 		    int type,
-- 
2.28.0

