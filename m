Return-Path: <linux-iio+bounces-1377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB668214B0
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 18:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9F01F21540
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DBF8C05;
	Mon,  1 Jan 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9P4U4Sn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC978BEA;
	Mon,  1 Jan 2024 17:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4D2C433CC;
	Mon,  1 Jan 2024 17:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704130047;
	bh=7/zi23CJfGpbi1J0CbGJ5wZcilJ4HNwCb9MhJ/UyG+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9P4U4Sng4+Y9BQvauM8pjlHhKxKw3QyqRjy/qvO9Is27KJvHVZC87GUyRjy+yqP+
	 hM2TCKJkuXWJEmz4GUfj+LttDlind32Cm+eEUxqSckjtGrXE5tR5MF3xbG3AY0accQ
	 61sdh5/AzBB4U/d1ug8qYmSCiHH/U2SKBzdyG7M1TUEKk7bUnPxDI3e4aJOqhOIMc6
	 dTtXUCCzY69bybWzHOkD39basDEP58zbPSAQbJf84QLOetdrNB58WwInnEw4mm/ORR
	 JtxJR3sYSZdRSntXKCG4dWnC/2OhPN7k8ZijzrjicYQedI0fefXiwcWF4ClnWf6P+4
	 nm8NnbJzsboeg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 08/13] iio: adc: ti-ads131e08: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Mon,  1 Jan 2024 17:26:06 +0000
Message-ID: <20240101172611.694830-9-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240101172611.694830-1-jic23@kernel.org>
References: <20240101172611.694830-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This use of the new cleanup.h scope based freeing infrastructure allows
us to exit directly from error conditions within the
device_for_each_child_node(dev, child) loop. On normal exit from that
loop no fwnode_handle reference will be held and the child pointer
will be NULL thus making the automatically run fwnode_handle_put() a
noop.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomislav Denis <tomislav.denis@avl.com>
---
 drivers/iio/adc/ti-ads131e08.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index fcfc46254313..fb1ab0b9a9db 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -694,7 +694,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 	struct ads131e08_channel_config *channel_config;
 	struct device *dev = &st->spi->dev;
 	struct iio_chan_spec *channels;
-	struct fwnode_handle *node;
+	struct fwnode_handle *node __free(fwnode_handle) = NULL;
 	unsigned int channel, tmp;
 	int num_channels, i, ret;
 
@@ -739,7 +739,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 	device_for_each_child_node(dev, node) {
 		ret = fwnode_property_read_u32(node, "reg", &channel);
 		if (ret)
-			goto err_child_out;
+			return ret;
 
 		ret = fwnode_property_read_u32(node, "ti,gain", &tmp);
 		if (ret) {
@@ -747,7 +747,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 		} else {
 			ret = ads131e08_pga_gain_to_field_value(st, tmp);
 			if (ret < 0)
-				goto err_child_out;
+				return ret;
 
 			channel_config[i].pga_gain = tmp;
 		}
@@ -758,7 +758,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 		} else {
 			ret = ads131e08_validate_channel_mux(st, tmp);
 			if (ret)
-				goto err_child_out;
+				return ret;
 
 			channel_config[i].mux = tmp;
 		}
@@ -784,10 +784,6 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 	st->channel_config = channel_config;
 
 	return 0;
-
-err_child_out:
-	fwnode_handle_put(node);
-	return ret;
 }
 
 static void ads131e08_regulator_disable(void *data)
-- 
2.43.0


