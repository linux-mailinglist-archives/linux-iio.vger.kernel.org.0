Return-Path: <linux-iio+bounces-4601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA198B4D4B
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 19:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E6D1F21457
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212873510;
	Sun, 28 Apr 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p07Y9pEB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D0F9D9
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714326036; cv=none; b=G57Y50VN3xNeuol3Z4mNriQ8SL5AmA0CHLSf3/Ql1HAIzhxn2BoLWjcSKVxO5s8Eh3p7YVvqRkQcd7/Vlu+RaNotkSWtKKq/0erT3XdhoYL33ydvkRYoQhbIJAanF4w7fyDZjb0uqsBfAMR818YBjasySPSN17gyIMlxaiTA1eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714326036; c=relaxed/simple;
	bh=t+c4BrYzejAt75RJ2Qxn/cvI2ZbHxIHAKbFEFaGQriQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHQ4R8TaY3uz1wLag3IqFJB/F/D9VzOYmFXvZBAV+BbOROomjsWZXVMYePo9Ntb6hh0hr+HZ4CRk7Opw7MbliwS7Ni8vxPkPl0p0l+/RyHCSNaQBViHBgtFoH82D9iiD3TGHjUkQVOjpnjn5J+756SuYbA5y4sUYg6+sB61o7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p07Y9pEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544B1C116B1;
	Sun, 28 Apr 2024 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714326036;
	bh=t+c4BrYzejAt75RJ2Qxn/cvI2ZbHxIHAKbFEFaGQriQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p07Y9pEBiblOcWsRBSIt7Plc+vbZrV+ZWpFhIWVttFwjnsUX5UZ3Wg33wTrTpO8mx
	 YAddpeHgUg3breGLd9OJw+FKyZYosFyWD4vLm8H8lgBgPCZgK4IYU1s5R4chRHLoS2
	 iT3Nx+E0eGP4AxdDCaIl1Q+rLMyQFrfERpZjHONIOJwPiBlf13eoeXMFuJI3DScq9S
	 Z/+W6VtOtw8004UJYuxjk6ZrwH8GUJsvEcbi22OYJTGn7eyp2OojT9kDxIMEh0wlsG
	 IWawWwZsOUWZnMuQ/STdKOrJTbZQDFkl6di13Tz+7MatuIA7mvPSS9SvaIq97Xr/pQ
	 JGA2lBv/qEtiA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Marius Cristea <marius.cristea@microchip.com>,
	Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 1/2] iio: adc: mcp3564: Use device_for_each_child_node_scoped()
Date: Sun, 28 Apr 2024 18:40:19 +0100
Message-ID: <20240428174020.1832825-2-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240428174020.1832825-1-jic23@kernel.org>
References: <20240428174020.1832825-1-jic23@kernel.org>
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

Cc: Marius Cristea <marius.cristea@microchip.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/mcp3564.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 311b613b6057..e2ae13f1e842 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -998,7 +998,6 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 	struct mcp3564_state *adc = iio_priv(indio_dev);
 	struct device *dev = &adc->spi->dev;
 	struct iio_chan_spec *channels;
-	struct fwnode_handle *child;
 	struct iio_chan_spec chanspec = mcp3564_channel_template;
 	struct iio_chan_spec temp_chanspec = mcp3564_temp_channel_template;
 	struct iio_chan_spec burnout_chanspec = mcp3564_burnout_channel_template;
@@ -1025,7 +1024,7 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 	if (!channels)
 		return dev_err_probe(dev, -ENOMEM, "Can't allocate memory\n");
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		node_name = fwnode_get_name(child);
 
 		if (fwnode_property_present(child, "diff-channels")) {
@@ -1033,26 +1032,25 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 							     "diff-channels",
 							     inputs,
 							     ARRAY_SIZE(inputs));
+			if (ret)
+				return ret;
+
 			chanspec.differential = 1;
 		} else {
 			ret = fwnode_property_read_u32(child, "reg", &inputs[0]);
+			if (ret)
+				return ret;
 
 			chanspec.differential = 0;
 			inputs[1] = MCP3564_AGND;
 		}
-		if (ret) {
-			fwnode_handle_put(child);
-			return ret;
-		}
 
 		if (inputs[0] > MCP3564_INTERNAL_VCM ||
-		    inputs[1] > MCP3564_INTERNAL_VCM) {
-			fwnode_handle_put(child);
+		    inputs[1] > MCP3564_INTERNAL_VCM)
 			return dev_err_probe(&indio_dev->dev, -EINVAL,
 					     "Channel index > %d, for %s\n",
 					     MCP3564_INTERNAL_VCM + 1,
 					     node_name);
-		}
 
 		chanspec.address = (inputs[0] << 4) | inputs[1];
 		chanspec.channel = inputs[0];
-- 
2.44.0


