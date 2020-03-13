Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E29184538
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 11:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCMKuA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 06:50:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:41875 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgCMKuA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 06:50:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 03:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="442379992"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Mar 2020 03:49:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CB374339; Fri, 13 Mar 2020 12:49:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/8] iio: st_sensors: Join string literals back
Date:   Fri, 13 Mar 2020 12:49:52 +0200
Message-Id: <20200313104955.30423-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For easy grepping on debug purposes join string literals back in
the messages.

No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no change
 drivers/iio/common/st_sensors/st_sensors_core.c    |  3 +--
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 13 ++++---------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 804a9068e687..2e42838ca4f4 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -277,8 +277,7 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 	    !sdata->sensor_settings->drdy_irq.int2.addr) {
 		if (pdata->drdy_int_pin)
 			dev_info(&indio_dev->dev,
-				 "DRDY on pin INT%d specified, but sensor "
-				 "does not support interrupts\n",
+				 "DRDY on pin INT%d specified, but sensor does not support interrupts\n",
 				 pdata->drdy_int_pin);
 		return 0;
 	}
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index e817537cdfb5..0507283bd4c1 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -44,8 +44,7 @@ static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
 			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
 			  &status);
 	if (ret < 0) {
-		dev_err(sdata->dev,
-			"error checking samples available\n");
+		dev_err(sdata->dev, "error checking samples available\n");
 		return ret;
 	}
 
@@ -148,9 +147,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	case IRQF_TRIGGER_LOW:
 		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
 			dev_err(&indio_dev->dev,
-				"falling/low specified for IRQ "
-				"but hardware supports only rising/high: "
-				"will request rising/high\n");
+				"falling/low specified for IRQ but hardware supports only rising/high: will request rising/high\n");
 			if (irq_trig == IRQF_TRIGGER_FALLING)
 				irq_trig = IRQF_TRIGGER_RISING;
 			if (irq_trig == IRQF_TRIGGER_LOW)
@@ -163,8 +160,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 			if (err < 0)
 				goto iio_trigger_free;
 			dev_info(&indio_dev->dev,
-				 "interrupts on the falling edge or "
-				 "active low level\n");
+				 "interrupts on the falling edge or active low level\n");
 		}
 		break;
 	case IRQF_TRIGGER_RISING:
@@ -178,8 +174,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	default:
 		/* This is the most preferred mode, if possible */
 		dev_err(&indio_dev->dev,
-			"unsupported IRQ trigger specified (%lx), enforce "
-			"rising edge\n", irq_trig);
+			"unsupported IRQ trigger specified (%lx), enforce rising edge\n", irq_trig);
 		irq_trig = IRQF_TRIGGER_RISING;
 	}
 
-- 
2.25.1

