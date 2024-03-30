Return-Path: <linux-iio+bounces-3947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB6892CAB
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39261C212B4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 18:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110723BBDD;
	Sat, 30 Mar 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFXZ7mPn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D272E3E5
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824832; cv=none; b=Wbfag9K274hiV/Oh+wpxKpnOvqglgmIxVeLwJrJE7FAoANyxTVmrvRKj+WyZtYZuWKwjeV7f9eyRpP+j08PKCedp5reN8PoZ/yxib1S+CmxvJ2Qs3ZE4cGabAeMrLR9KtBunNkUvfE25TBJIlfRcNHpKXkdV9+dwcDliqKro6b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824832; c=relaxed/simple;
	bh=7C5/bV8FIlY7Lha11lXdJR+AQbt/4ZZdKI46DPQNgkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAMkRJ8ZbYz+5WsTXes6dIJb2w/SxcGIPvhgc7DEtu5xm+D1icRmyFDfhyjUUCfOVFTAmY5pWjXjypYYvTyWq9E1l0doGwQxr+XL4llUA6OQKhWxYyAICKAzJhnMy4nowhkAUby+v9Csm4JBnqnbIOCx8i5FPTCwZoIYEYW85+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFXZ7mPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB952C43390;
	Sat, 30 Mar 2024 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711824832;
	bh=7C5/bV8FIlY7Lha11lXdJR+AQbt/4ZZdKI46DPQNgkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFXZ7mPnE9+zInmeW5/h1D1oYZsXsMQ2aSWlaEVI5eMiDRDHzjjevzVRPenONO3Ra
	 RePlYPzKZnt3y+J5daHzW6l5kuC/GzJVzkfD+mLyZvG4DH/X3+j26MZpjRs0YYELXz
	 DWe966QlPvL4JjMkphcN3dSwf8tR2NA33ajWehSHxIerXQPhdSE8FOlBbHnC2YTwdD
	 BL4F/mHloTMs74GMsvPtdY03/Swy1T4mkoWz205vNlSnTkGzzWZNTHmI4X81fb4GLV
	 cXl3hQj7X3C9JQh2rvD+wF5ryFCRVrr90RzqIvq4besP4j/uzj26kbyAIX5A+aRpxU
	 jtvfibGmtIKSw==
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
Subject: [PATCH v6 6/8] iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped()
Date: Sat, 30 Mar 2024 18:53:03 +0000
Message-ID: <20240330185305.1319844-7-jic23@kernel.org>
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
2.44.0


