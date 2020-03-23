Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B536218F304
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 11:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCWKld (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 06:41:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:8223 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgCWKld (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 06:41:33 -0400
IronPort-SDR: YExoHcQjT7le7l9xrUR9Xgpi7/2ETNxl2yASpxs5dD9ka4cAqioXJfyFfmSgNgLSb21bfczwU+
 +QajwGxAFeyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 03:41:32 -0700
IronPort-SDR: GcwrfrAQgmA4L7/QN9kaClKjO5i1igP1TNErMLME1Jz+0UoxrcDornaRCfOMCD64boIasKmA2m
 HuZbpb/Zvf8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="445769724"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2020 03:41:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6371F11D; Mon, 23 Mar 2020 12:41:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] iio: pressure: bmp280: Convert to use ->read_avail()
Date:   Mon, 23 Mar 2020 12:41:26 +0200
Message-Id: <20200323104129.60466-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323104129.60466-1-andriy.shevchenko@linux.intel.com>
References: <20200323104129.60466-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert to use ->read_avail() instead of open-coded attribute handling.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch, which replaces previous attribute macro conversion
 drivers/iio/pressure/bmp280-core.c | 69 +++++++++++-------------------
 1 file changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 2540e7c2358c..ce0c1962d9f8 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -575,57 +575,38 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static ssize_t bmp280_show_avail(char *buf, const int *vals, const int n)
+static int bmp280_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
 {
-	size_t len = 0;
-	int i;
-
-	for (i = 0; i < n; i++)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", vals[i]);
-
-	buf[len - 1] = '\n';
-
-	return len;
-}
-
-static ssize_t bmp280_show_temp_oversampling_avail(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct bmp280_data *data = iio_priv(dev_to_iio_dev(dev));
-
-	return bmp280_show_avail(buf, data->chip_info->oversampling_temp_avail,
-				 data->chip_info->num_oversampling_temp_avail);
-}
-
-static ssize_t bmp280_show_press_oversampling_avail(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct bmp280_data *data = iio_priv(dev_to_iio_dev(dev));
+	struct bmp280_data *data = iio_priv(indio_dev);
 
-	return bmp280_show_avail(buf, data->chip_info->oversampling_press_avail,
-				 data->chip_info->num_oversampling_press_avail);
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			*vals = data->chip_info->oversampling_press_avail;
+			*length = data->chip_info->num_oversampling_press_avail;
+			break;
+		case IIO_TEMP:
+			*vals = data->chip_info->oversampling_temp_avail;
+			*length = data->chip_info->num_oversampling_temp_avail;
+			break;
+		default:
+			return -EINVAL;
+		}
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
 }
 
-static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available,
-	S_IRUGO, bmp280_show_temp_oversampling_avail, NULL, 0);
-
-static IIO_DEVICE_ATTR(in_pressure_oversampling_ratio_available,
-	S_IRUGO, bmp280_show_press_oversampling_avail, NULL, 0);
-
-static struct attribute *bmp280_attributes[] = {
-	&iio_dev_attr_in_temp_oversampling_ratio_available.dev_attr.attr,
-	&iio_dev_attr_in_pressure_oversampling_ratio_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group bmp280_attrs_group = {
-	.attrs = bmp280_attributes,
-};
-
 static const struct iio_info bmp280_info = {
 	.read_raw = &bmp280_read_raw,
+	.read_avail = &bmp280_read_avail,
 	.write_raw = &bmp280_write_raw,
-	.attrs = &bmp280_attrs_group,
 };
 
 static int bmp280_chip_config(struct bmp280_data *data)
-- 
2.25.1

