Return-Path: <linux-iio+bounces-1380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0398214B6
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 18:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5061C20D27
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195588F58;
	Mon,  1 Jan 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmECiTQj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F38F56;
	Mon,  1 Jan 2024 17:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CA9C433C7;
	Mon,  1 Jan 2024 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704130070;
	bh=CxVQu8EKddDGgMrYeXfzJdX0C16MaLOn9FNsZw4Cjnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmECiTQjzqxs80I4rk8v6UMMCTZ+WTgt9rxHOvyAvNcQbpFlZxXSv3SW0OtFtlXmU
	 ZrV+DdNCp1qjSY+c+cgXa5NU4IXt3B/6aH1CN0q5GpQ3eZ7wGFwDlxGBHMcKcdiIsc
	 gUHKBWqujdWGMZkyyeP5HSVTK+xJbFXhPaGIpDX3RVIpCmz8AOdvIEg7uI522Sa6TG
	 U5P3wE4/C4cySXwezS8HY/GrjhweYhWcJK7/B0XS0y9bjDvYU5/Q//KBW8F7tDod1T
	 5ZYMELI6h2Aa0hobZQYe52Q81m0dWrSCRAa6Jn+JXZOlVhsiRsf12ErN4tx9908ADG
	 BsiZtMNi4gxjg==
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
Subject: [RFC PATCH 11/13] iio: dac: ad5770r: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Mon,  1 Jan 2024 17:26:09 +0000
Message-ID: <20240101172611.694830-12-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240101172611.694830-1-jic23@kernel.org>
References: <20240101172611.694830-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This use of the new cleanup.h scope based freeing infrastructure allows
us to exit directly from error conditions within the
device_for_each_child_node(dev, child) loop. On normal exit from that
loop no fwnode_handle reference will be held and the child pointer
will be NULL thus making the automatically run fwnode_handle_put() a
noop.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5770r.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index f66d67402e43..782a04406576 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -515,7 +515,7 @@ static int ad5770r_channel_config(struct ad5770r_state *st)
 {
 	int ret, tmp[2], min, max;
 	unsigned int num;
-	struct fwnode_handle *child;
+	struct fwnode_handle *child __free(fwnode_handle) = NULL;
 
 	num = device_get_child_node_count(&st->spi->dev);
 	if (num != AD5770R_MAX_CHANNELS)
@@ -524,30 +524,24 @@ static int ad5770r_channel_config(struct ad5770r_state *st)
 	device_for_each_child_node(&st->spi->dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &num);
 		if (ret)
-			goto err_child_out;
-		if (num >= AD5770R_MAX_CHANNELS) {
-			ret = -EINVAL;
-			goto err_child_out;
-		}
+			return ret;
+		if (num >= AD5770R_MAX_CHANNELS)
+			return -EINVAL;
 
 		ret = fwnode_property_read_u32_array(child,
 						     "adi,range-microamp",
 						     tmp, 2);
 		if (ret)
-			goto err_child_out;
+			return ret;
 
 		min = tmp[0] / 1000;
 		max = tmp[1] / 1000;
 		ret = ad5770r_store_output_range(st, min, max, num);
 		if (ret)
-			goto err_child_out;
+			return ret;
 	}
 
 	return 0;
-
-err_child_out:
-	fwnode_handle_put(child);
-	return ret;
 }
 
 static int ad5770r_init(struct ad5770r_state *st)
-- 
2.43.0


