Return-Path: <linux-iio+bounces-2710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B21859119
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7862827AB
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141B7D3F4;
	Sat, 17 Feb 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhZrY0Yp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4DF7D3EC;
	Sat, 17 Feb 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188247; cv=none; b=j7dR8RIZI+eCIDqlOwOftzZC8G0R2rG/mj/DUzdCrfwFJTTYABn0jfbpTNiOsSRVIbkiJiidrfxAZWcZxgfQAVcpVnQl/zGp7a5pda/G3EXwn8Ab5FSbuD9+eGzxtvgURZdNQ0y5by8dy16SwC3yxZl2iWaONEd7z4WQrsP3GdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188247; c=relaxed/simple;
	bh=Ds74Qrbcn3I42aYg16TeBAqLINL89sm7BvmJAC5S5nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncHJ1dz/g5WcYndEPqD8uPgYQNZHa9rnWQEKmnR2fv6glg826GdJub22CnlZWd7g9cH+1EU+7vpewBk2FHa4JaJ5Ajh0WEDmoAzJbK4Nu2CEkWz/vSeJDnP4OkWSLDEk7n/BEWYRvPv+qez7lDulaU3Uvr3ithecf4l6E/jTy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhZrY0Yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505A9C433F1;
	Sat, 17 Feb 2024 16:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708188246;
	bh=Ds74Qrbcn3I42aYg16TeBAqLINL89sm7BvmJAC5S5nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhZrY0YphxOePIFolDO2R/9Qr7oV6yp/hdN5OLaYrG/aMQLYdWuENssQlLQ+ejzQd
	 Sjg3xRN1IZU1RFmqKleX/YfDBYBXqeoqguWxEwDARMFGKUa6MqG6PTYtmarfCDEG73
	 ZKc6qNJ7rpL3lqp5u65OjgbFFJhk07lOH89GvZdkFfigbFsuheuZfvNSa/N5hC17WT
	 P0uuDjy9IEtLArQQI14kvpXeHglHmg94kVEyAwU420bScq6agqYN3tUnwScwEYuF7e
	 oaIPB4vnEGr18pgIrfLCtEmSYTCpNBUHBNv2oLX1/KBGVa9KOsj2z2dnr6xjiQiAWc
	 fipNvri1SBFcA==
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
Subject: [PATCH v4 10/15] iio: adc: ti-ads1015: Use device_for_each_child_node_scoped()
Date: Sat, 17 Feb 2024 16:42:44 +0000
Message-ID: <20240217164249.921878-11-jic23@kernel.org>
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

Cc: Marek Vasut <marex@denx.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1015.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 6ae967e4d8fa..d3363d02f292 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -902,10 +902,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ads1015_data *data = iio_priv(indio_dev);
 	struct device *dev = &client->dev;
-	struct fwnode_handle *node;
 	int i = -1;
 
-	device_for_each_child_node(dev, node) {
+	device_for_each_child_node_scoped(dev, node) {
 		u32 pval;
 		unsigned int channel;
 		unsigned int pga = ADS1015_DEFAULT_PGA;
@@ -927,7 +926,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			pga = pval;
 			if (pga > 5) {
 				dev_err(dev, "invalid gain on %pfw\n", node);
-				fwnode_handle_put(node);
 				return -EINVAL;
 			}
 		}
@@ -936,7 +934,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			data_rate = pval;
 			if (data_rate > 7) {
 				dev_err(dev, "invalid data_rate on %pfw\n", node);
-				fwnode_handle_put(node);
 				return -EINVAL;
 			}
 		}
-- 
2.43.2


