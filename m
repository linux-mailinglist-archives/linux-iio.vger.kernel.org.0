Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABDB187E0B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 11:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgCQKSS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 06:18:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:56031 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgCQKSR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Mar 2020 06:18:17 -0400
IronPort-SDR: 8TCz4BEIZMVu9zfrh7E5Y/+YI38DwXU9Do6tbU0MNuUpQBExtG25ilE8QKDvl60nPIYLrMIORl
 WGzVpXqwABJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 03:18:17 -0700
IronPort-SDR: iGA+AU52bFjNzZi0cH7RK62xXGF0vEBoo6o/abuGFgpStg986lOix6a3OadsRJXiYrcGI7LgUy
 hDyDpNyZ4hdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="323785167"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2020 03:18:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3F62578; Tue, 17 Mar 2020 12:18:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] iio: pressure: bmp280: Use IIO_DEVICE_ATTR_RO macro
Date:   Tue, 17 Mar 2020 12:18:10 +0200
Message-Id: <20200317101813.30829-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the IIO_DEVICE_ATTR_RO macro to create the device attributes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/bmp280-core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 5e229b95308e..25be3ff1a6ab 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -588,7 +588,7 @@ static ssize_t bmp280_show_avail(char *buf, const int *vals, const int n)
 	return len;
 }
 
-static ssize_t bmp280_show_temp_oversampling_avail(struct device *dev,
+static ssize_t in_temp_oversampling_ratio_available_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct bmp280_data *data = iio_priv(dev_to_iio_dev(dev));
@@ -596,8 +596,9 @@ static ssize_t bmp280_show_temp_oversampling_avail(struct device *dev,
 	return bmp280_show_avail(buf, data->chip_info->oversampling_temp_avail,
 				 data->chip_info->num_oversampling_temp_avail);
 }
+static IIO_DEVICE_ATTR_RO(in_temp_oversampling_ratio_available, 0);
 
-static ssize_t bmp280_show_press_oversampling_avail(struct device *dev,
+static ssize_t in_pressure_oversampling_ratio_available_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct bmp280_data *data = iio_priv(dev_to_iio_dev(dev));
@@ -605,17 +606,12 @@ static ssize_t bmp280_show_press_oversampling_avail(struct device *dev,
 	return bmp280_show_avail(buf, data->chip_info->oversampling_press_avail,
 				 data->chip_info->num_oversampling_press_avail);
 }
-
-static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available,
-	S_IRUGO, bmp280_show_temp_oversampling_avail, NULL, 0);
-
-static IIO_DEVICE_ATTR(in_pressure_oversampling_ratio_available,
-	S_IRUGO, bmp280_show_press_oversampling_avail, NULL, 0);
+static IIO_DEVICE_ATTR_RO(in_pressure_oversampling_ratio_available, 0);
 
 static struct attribute *bmp280_attributes[] = {
 	&iio_dev_attr_in_temp_oversampling_ratio_available.dev_attr.attr,
 	&iio_dev_attr_in_pressure_oversampling_ratio_available.dev_attr.attr,
-	NULL,
+	NULL
 };
 
 static const struct attribute_group bmp280_attrs_group = {
-- 
2.25.1

