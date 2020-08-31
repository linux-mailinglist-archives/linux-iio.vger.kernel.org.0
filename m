Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A122257605
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgHaJIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:08:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:5851 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbgHaJIZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:08:25 -0400
IronPort-SDR: TXNiQmrdoNu2PXPiw8/IF76NwkvPZlGcVDxeH/F7i0iiGFkcaZNlH9zs7MEebMAjV1VpeU2Wjs
 zBn8r6NJ2Ibw==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144613469"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="144613469"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 02:08:16 -0700
IronPort-SDR: J1yGO5KGKxnFLP90RxRhZ4S6EZ/UWhEdxEfMb7aQwQcdaHnNT+Ucm5f8ePCCpT/CeloIrTGGjG
 b5+QxGUNLgww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="476649702"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2020 02:08:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3F76A165; Mon, 31 Aug 2020 12:08:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/8] iio: accel: bma220: Convert to use ->read_avail()
Date:   Mon, 31 Aug 2020 12:08:07 +0300
Message-Id: <20200831090813.78841-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert to use ->read_avail() instead of open-coded attribute handling.

While here, fix the typo in array definition and append comma in case of
the future extension.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/bma220_spi.c | 36 ++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 3247b9c8abcb..cb634a3a995d 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -30,7 +30,6 @@
 #define BMA220_SUSPEND_WAKE			0x00
 
 #define BMA220_DEVICE_NAME			"bma220"
-#define BMA220_SCALE_AVAILABLE			"0.623 1.248 2.491 4.983"
 
 #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
 	.type = IIO_ACCEL,						\
@@ -55,19 +54,8 @@ enum bma220_axis {
 	AXIS_Z,
 };
 
-static IIO_CONST_ATTR(in_accel_scale_available, BMA220_SCALE_AVAILABLE);
-
-static struct attribute *bma220_attributes[] = {
-	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group bma220_attribute_group = {
-	.attrs = bma220_attributes,
-};
-
-static const int bma220_scale_table[][4] = {
-	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000}
+static const int bma220_scale_table[][2] = {
+	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000},
 };
 
 struct bma220_data {
@@ -182,10 +170,28 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int bma220_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)bma220_scale_table;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(bma220_scale_table) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info bma220_info = {
 	.read_raw		= bma220_read_raw,
 	.write_raw		= bma220_write_raw,
-	.attrs			= &bma220_attribute_group,
+	.read_avail		= bma220_read_avail,
 };
 
 static int bma220_init(struct spi_device *spi)
-- 
2.28.0

