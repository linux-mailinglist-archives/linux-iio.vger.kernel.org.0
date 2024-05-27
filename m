Return-Path: <linux-iio+bounces-5358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C12EA8D0910
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 19:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95052B23CAE
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E9315F3F4;
	Mon, 27 May 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiPBrewd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066915EFC1;
	Mon, 27 May 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829361; cv=none; b=goO7VehsJ7JCGeegBCbWioOSUEPUz3e4JbVmAxixiaIUY8AZm9CshTKe2EDULkqJLYJ6QIQJeGk/XBQKqR/mJhbE/DAOT4wH3iRvZ2thfWfb4K+ztG7PCuGnU8HAS+aiF1BQUIQayetYk9NdbpGzrnfAUtlpG9i9jxYE+jLbyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829361; c=relaxed/simple;
	bh=mnTuVxNr0E3ciZMolDdevZD+FZjwWFUCdR5eEp6BP5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irpFjhnHTNWbj1WbKOGNho8fmnn3EbBvWnL5wBHpCX1x1IeALMWnz3CxGgkWErTtF3injvy95BCVbBrQ+qI4D69fzvrfzOHMLQ3WKPdwNTIb91lihBaqHCw1KHOPcDlAYwI23eHpxLcF3Rj5UFNB9U7XAxw8HQF9HGMOHaz+sU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiPBrewd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C07F8C2BBFC;
	Mon, 27 May 2024 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716829360;
	bh=mnTuVxNr0E3ciZMolDdevZD+FZjwWFUCdR5eEp6BP5w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WiPBrewdBFtnVBf8s4gMXzUiHA/YL8i6mhKaM+B/SJtdgZFs814suIQlQ3KiTwNlR
	 pDlZH9zVw9gdFWi0vUknjXd0HJak2mtwCkTAIpZgUw5M2XqtsPfv+Bk8NaVfXzKJ4a
	 I3MMAoLLP4o1mqcmuaSfnJvBrSx8uLVXXkS9Mn7btVHqqgCg/mBa12KT4AlipPerbz
	 fpgWMwBEJIBfuG9srRACi8U9CfDs6dlulSbPhTi2iAh9MrL1VpSjh5RFjs4bHnDlbr
	 VDXnRq+vgCvEB+hXULwML7v2cYcB3Z+5UMmDSgSMHq4vve07M0jx5mO4NUDDhdPZEK
	 HUIyO4R9mT8uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB63CC27C43;
	Mon, 27 May 2024 17:02:40 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 27 May 2024 20:02:35 +0300
Subject: [PATCH v3 2/6] iio: adc: ad7173: refactor channel configuration
 parsing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-ad4111-v3-2-7e9eddbbd3eb@analog.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
In-Reply-To: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716829358; l=2347;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=3czhFBTraxeF02Od1vA/Atq2gjpymKxEOKbv8x/yVgQ=;
 b=lsx5ZffZx+8QSMMmyNhexpASH4X/d9nzpYidIgw1x5GZaJIkg0WZjEdx4eZyCsKKh7OtbjOo0
 Q51u+EkyBkIAN+hSzdNugEW/FDCqEjhpFklZa4hjtgp7Lygyxa7f2q7
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Move configurations regarding number of channels from
*_fw_parse_device_config to *_fw_parse_channel_config.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/all/20240303162148.3ad91aa2@jic23-huawei/
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index ebacdacf64b9..9e507e2c66f0 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -913,7 +913,23 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_chan_spec *chan_arr, *chan;
 	unsigned int ain[2], chan_index = 0;
-	int ref_sel, ret;
+	int ref_sel, ret, num_channels;
+
+	num_channels = device_get_child_node_count(dev);
+
+	if (st->info->has_temp)
+		num_channels++;
+
+	if (num_channels == 0)
+		return dev_err_probe(dev, -ENODATA, "No channels specified\n");
+
+	if (num_channels > st->info->num_channels)
+		return dev_err_probe(dev, -EINVAL,
+			"Too many channels specified. Maximum is %d, not including temperature channel if supported.\n",
+			st->info->num_channels);
+
+	indio_dev->num_channels = num_channels;
+	st->num_channels = num_channels;
 
 	chan_arr = devm_kcalloc(dev, sizeof(*indio_dev->channels),
 				st->num_channels, GFP_KERNEL);
@@ -1008,7 +1024,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
-	unsigned int num_channels;
 	int ret;
 
 	st->regulators[0].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
@@ -1067,16 +1082,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 
 	ad7173_sigma_delta_info.irq_line = ret;
 
-	num_channels = device_get_child_node_count(dev);
-
-	if (st->info->has_temp)
-		num_channels++;
-
-	if (num_channels == 0)
-		return dev_err_probe(dev, -ENODATA, "No channels specified\n");
-	indio_dev->num_channels = num_channels;
-	st->num_channels = num_channels;
-
 	return ad7173_fw_parse_channel_config(indio_dev);
 }
 

-- 
2.43.0



