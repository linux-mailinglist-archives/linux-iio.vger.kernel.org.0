Return-Path: <linux-iio+bounces-3946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DB8892CAA
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B211C20EA9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE2E3BBDD;
	Sat, 30 Mar 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIfRsIHG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8A92E3E5
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824826; cv=none; b=m6qhQQVc/jNoXcxdZTzdiKXiLsP2+Hoau5+tLW3sT6/KOO3L7ge2B3f1bp1/4WXZ7SxAWRyaPk5aGyz4+BldjNXdaaG8uSkSR2Rz6gMVc/wwWzktUAet+OChM1kolHRDK5+4aAivlqY8z6bf2MwTgg7yF3nQRrGBqzbyXE0M4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824826; c=relaxed/simple;
	bh=ruJKwM0lQj1GeEvjHu7rz30w3dvlpzqaiQm4QjXLSRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asNrYIz2ic2XCfpkONdkdzaZiT32LAJlttkhB7XlVziBb5boJlov7pKRJKXAgI8Z3i23Wn0I4MbSxI6th3e/dwst3nNkA3OzO32BgXLZuv4ew5XENeshzGg9WisJGIYQF0h7u5wu260sRewyBqLIPO0M4rL05xE3VIW6CIOQFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIfRsIHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F18C43399;
	Sat, 30 Mar 2024 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711824826;
	bh=ruJKwM0lQj1GeEvjHu7rz30w3dvlpzqaiQm4QjXLSRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIfRsIHGRUveOz2y1fL7MpofW7mdoXO4G8u4KrOiZzoNTGOgna37NRM4Oinuzh70g
	 T7fFW/hAMIwMSQEUVWNbgC8wDkijh7yEl2JctNoP+8CHaMFgMWw0xccZgZ1bXamIk9
	 iGcyjiaBsIlsBQg5ARjLVMgPHRBtwtDxwEqx5Glymgs2HtoIUUxJEIr6gtJplZkRHy
	 fhe5l5WbnuY8zKw6iOlPxXvgi+c3CiJaEcjJbnt+TbgvhPzoEan7OKExakWi++zN1w
	 MOFiKVHtV3mJ2nSOmxyKpE9x2s3CodFxP5SQ3MHbyiXbm+n1nBlWmGufffwLDMNimp
	 IEyxs24Rj+SWA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
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
Subject: [PATCH v6 5/8] iio: adc: ti-ads1015: Use device_for_each_child_node_scoped()
Date: Sat, 30 Mar 2024 18:53:02 +0000
Message-ID: <20240330185305.1319844-6-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330185305.1319844-1-jic23@kernel.org>
References: <20240330185305.1319844-1-jic23@kernel.org>
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
2.44.0


