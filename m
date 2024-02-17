Return-Path: <linux-iio+bounces-2711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2645285911B
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A3E2823C5
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4C7D3F1;
	Sat, 17 Feb 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYctr/8o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C773F7D402;
	Sat, 17 Feb 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188252; cv=none; b=Q4Hz2RvVAyyvqZL226tCUxVtXg7bRxUCqN+9q5fHy+3lMArcX6KdYTq8aD0k5e8M5MlZvr9b/SBIFmBtGUUYIaYM/ELwesgYP+LHUGMIknUPoKBK1jef/7T/e6mpNlAh+MPaty2M/o4EZyXBLPgqHlXYhQL296GTRnqUMdfprCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188252; c=relaxed/simple;
	bh=Nl9qYxjXOLsowWrciGmKveA07CHxDugmQszc3tjdG3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzE4P8vo3wg52c7viy7ZwVxgc8j48dUMsd84aiwiN5JbkRFuxWrr8kfcVisSm0lyI01Wy/eEbtI6+y/yW/TJvscio/u3hg7jdoCmKbAbghi3k7RHy65Sh0tueGBov57lw2xGxmBy3S9pUituEs1OBcaYSifcBDOYE+blcC4AZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYctr/8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16F7C43399;
	Sat, 17 Feb 2024 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708188251;
	bh=Nl9qYxjXOLsowWrciGmKveA07CHxDugmQszc3tjdG3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AYctr/8oA3qLGO8TJuzzwXVBOvh2W6MzSttM4W1awpEuemzgZ0RhhxXA43RTFoghl
	 L0tkNSYRvLcuBm7OyNpU95blNJZegPqvHunoLkg7qlzV7pvviBTY1zlXx96di4SM8T
	 83zjUIbj+wZrKxCDJudtmFaM+g5zVIvkRCMtIEQ2gbfXlSjTZveZnMPkqrL4XQmZTr
	 NleA2Un/MgSV/+SdZn4b2vL3KlfKZkjh/jQL+zDh5+HI47yWOZt4Kp5uK+Ebb9uQtG
	 HKiBPW7QvI0Ekf7BZqN0u9Dei0qM+azKEV73vClKeIq9tA4YOkZ8vCr9AqnmQj1JuR
	 +dEQJzJUrH51g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>
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
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 11/15] iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped()
Date: Sat, 17 Feb 2024 16:42:45 +0000
Message-ID: <20240217164249.921878-12-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217164249.921878-1-jic23@kernel.org>
References: <20240217164249.921878-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Switching to the _scoped() version removes the need for manual
calling of fwnode_handle_put() in the paths where the code
exits the loop early. In this case that's all in error paths.

Cc: Tomislav Denis <tomislav.denis@avl.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads131e08.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index fcfc46254313..f653654f7c5d 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -694,7 +694,6 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 	struct ads131e08_channel_config *channel_config;
 	struct device *dev = &st->spi->dev;
 	struct iio_chan_spec *channels;
-	struct fwnode_handle *node;
 	unsigned int channel, tmp;
 	int num_channels, i, ret;
 
@@ -736,10 +735,10 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	i = 0;
-	device_for_each_child_node(dev, node) {
+	device_for_each_child_node_scoped(dev, node) {
 		ret = fwnode_property_read_u32(node, "reg", &channel);
 		if (ret)
-			goto err_child_out;
+			return ret;
 
 		ret = fwnode_property_read_u32(node, "ti,gain", &tmp);
 		if (ret) {
@@ -747,7 +746,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 		} else {
 			ret = ads131e08_pga_gain_to_field_value(st, tmp);
 			if (ret < 0)
-				goto err_child_out;
+				return ret;
 
 			channel_config[i].pga_gain = tmp;
 		}
@@ -758,7 +757,7 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 		} else {
 			ret = ads131e08_validate_channel_mux(st, tmp);
 			if (ret)
-				goto err_child_out;
+				return ret;
 
 			channel_config[i].mux = tmp;
 		}
@@ -784,10 +783,6 @@ static int ads131e08_alloc_channels(struct iio_dev *indio_dev)
 	st->channel_config = channel_config;
 
 	return 0;
-
-err_child_out:
-	fwnode_handle_put(node);
-	return ret;
 }
 
 static void ads131e08_regulator_disable(void *data)
-- 
2.43.2


