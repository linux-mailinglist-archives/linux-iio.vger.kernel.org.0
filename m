Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC311352EB7
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 19:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhDBRtE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 13:49:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:17691 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235836AbhDBRtC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 13:49:02 -0400
IronPort-SDR: 3Ioe8XTko4Lnm3kgz5QttT6PRNroz/RlxbD3y9FiFwIdFyjWhqZimvcGq5K9Fx1J7e1uUhxvP4
 mgwzVm8p+hxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="190278005"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="190278005"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:49:01 -0700
IronPort-SDR: j5s1BPlZdyePNVg2hcTS5FTsJBRILEsx1hDEf/0tZ4uXMSFEiYbIu9RAzLwa4YPHfV/MPmnmog
 /CvlIJ1GCTiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="439702772"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2021 10:48:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 04EF12E4; Fri,  2 Apr 2021 20:49:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] iio: trigger: Fix strange (ladder-type) indentation
Date:   Fri,  2 Apr 2021 20:49:11 +0300
Message-Id: <20210402174911.44408-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402174911.44408-1-andriy.shevchenko@linux.intel.com>
References: <20210402174911.44408-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In some cases indentation looks a bit weird with starting from = sign
and being in a ladder-type style. Unify it across the module.

While at it, add blank line after definition block where it needed,

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo in the commit message (tupe->type)
 drivers/iio/industrialio-trigger.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 78e30f0f915c..ec72ff04b38d 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -211,6 +211,7 @@ EXPORT_SYMBOL(iio_trigger_notify_done);
 static int iio_trigger_get_irq(struct iio_trigger *trig)
 {
 	int ret;
+
 	mutex_lock(&trig->pool_lock);
 	ret = bitmap_find_free_region(trig->pool,
 				      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
@@ -239,9 +240,9 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 				 struct iio_poll_func *pf)
 {
+	bool notinuse =
+		bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 	int ret = 0;
-	bool notinuse
-		= bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 
 	/* Prevent the module from being removed whilst attached to a trigger */
 	__module_get(pf->indio_dev->driver_module);
@@ -290,11 +291,10 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 				 struct iio_poll_func *pf)
 {
+	bool no_other_users =
+		bitmap_weight(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER) == 1;
 	int ret = 0;
-	bool no_other_users
-		= (bitmap_weight(trig->pool,
-				 CONFIG_IIO_CONSUMERS_PER_TRIGGER)
-		   == 1);
+
 	if (trig->ops && trig->ops->set_trigger_state && no_other_users) {
 		ret = trig->ops->set_trigger_state(trig, false);
 		if (ret)
@@ -312,6 +312,7 @@ int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 irqreturn_t iio_pollfunc_store_time(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
+
 	pf->timestamp = iio_get_time_ns(pf->indio_dev);
 	return IRQ_WAKE_THREAD;
 }
@@ -498,18 +499,16 @@ static const struct device_type iio_trig_type = {
 static void iio_trig_subirqmask(struct irq_data *d)
 {
 	struct irq_chip *chip = irq_data_get_irq_chip(d);
-	struct iio_trigger *trig
-		= container_of(chip,
-			       struct iio_trigger, subirq_chip);
+	struct iio_trigger *trig = container_of(chip, struct iio_trigger, subirq_chip);
+
 	trig->subirqs[d->irq - trig->subirq_base].enabled = false;
 }
 
 static void iio_trig_subirqunmask(struct irq_data *d)
 {
 	struct irq_chip *chip = irq_data_get_irq_chip(d);
-	struct iio_trigger *trig
-		= container_of(chip,
-			       struct iio_trigger, subirq_chip);
+	struct iio_trigger *trig = container_of(chip, struct iio_trigger, subirq_chip);
+
 	trig->subirqs[d->irq - trig->subirq_base].enabled = true;
 }
 
@@ -695,7 +694,7 @@ EXPORT_SYMBOL(iio_trigger_using_own);
  * device, -EINVAL otherwise.
  */
 int iio_trigger_validate_own_device(struct iio_trigger *trig,
-	struct iio_dev *indio_dev)
+				    struct iio_dev *indio_dev)
 {
 	if (indio_dev->dev.parent != trig->dev.parent)
 		return -EINVAL;
-- 
2.30.2

