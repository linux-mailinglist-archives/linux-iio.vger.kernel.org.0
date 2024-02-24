Return-Path: <linux-iio+bounces-2995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7E78624FB
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 13:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2109282B2F
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A0A3D99B;
	Sat, 24 Feb 2024 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNvZSFxQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEDA32C8B
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708777983; cv=none; b=FrSWmratK/UtPQeOg2HaftwWFpIlngneyLFcnGfccnB45qdeNPtLqKLljT1QE2sHHulx8vUMW4iwRl+jHpds+/ooES0biiqR5Zx/tioRN8Ik1yHY9OjRNyHbM1dEbjN9XkWpmLBnATwMxwBeLkSXVfxaU/kypb+pOFLPRU7LWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708777983; c=relaxed/simple;
	bh=ruJKwM0lQj1GeEvjHu7rz30w3dvlpzqaiQm4QjXLSRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAimkQeZdWHwe35aORSBAJHALd5XluuIPRi7wyr2XZpjRxweBSvHJYIsso9IdUZHi11ycZDLyGx8vyTRo3ddLvoe6hXRAPDwEBzWF8hQaMxfT+22Cr1t4giHHvYsrEi/irdTdAzIEhWuzJ70pQupj56lFcTGklpKMpzNfFEOUUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNvZSFxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139C9C43394;
	Sat, 24 Feb 2024 12:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708777983;
	bh=ruJKwM0lQj1GeEvjHu7rz30w3dvlpzqaiQm4QjXLSRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNvZSFxQ57z8qwv42y5bR8MHGIpfqJwITmR0dM6QOrvkAdvsniVfSQBzmIkYcgorg
	 k51ieQs1Q/B5vYoUy4gRuyImerCNCm3koaGdp+mKNojsX/1cCcqPY/pp9dUWuftm/a
	 LrazDP5s1ZyrojbWXgduQU7+VC6tiwwUlWowYcuYXod3tcxCenqYVKfQhElFdt4Ib/
	 7KGktbDCx/RCiEyq4PnfaIYtLCJq8ONZiQIc0nji39bXRcUeG7D/TUdRItKW0NJ5mn
	 ztmWVEqLm4BADCkdF08Z7td02z4ABjSPYV24HlkMaEAaric6vhRHuP0xVvttGPT2Ts
	 U1/piFX2wGFeA==
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
Subject: [PATCH v5 6/9] iio: adc: ti-ads1015: Use device_for_each_child_node_scoped()
Date: Sat, 24 Feb 2024 12:32:12 +0000
Message-ID: <20240224123215.161469-7-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224123215.161469-1-jic23@kernel.org>
References: <20240224123215.161469-1-jic23@kernel.org>
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


