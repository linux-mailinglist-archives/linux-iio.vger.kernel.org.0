Return-Path: <linux-iio+bounces-5031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7CD8C4CD2
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 09:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE41F21818
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 07:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548042BB0D;
	Tue, 14 May 2024 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPWbEGHy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F135820DD3;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671399; cv=none; b=ONr/mnZ07AgSYSGuQCsnfD6eZagpdEmsvRBdLBa2TTGgEHqdoe7HdrDY7EqZyYF4Rtw7Jr2eI3aFApcWX4i95uFJpU/O5a8SJBCZPSGO5yXcuoCzz/oSUFbAzkJ3MSUGW2HVPVcQz+l3eXBwoSgB6qq0bXdWQmUC3gvzOgC9QfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671399; c=relaxed/simple;
	bh=fijWPI5Ec9mEIeEHh6gbcrhWz9IcjE4n8o8vNnEa8uM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDPrMBSWsXaRLB/jnBlWAErJLFQDY8l0cafWVAiWgFYP/u41hzvtROnffwnZQNmw0xF0vzVUF088UvBjXS/pjurIQRI/CI79tvHyyz5+Qpm+qmC0sjaXJZb1Z0spmcjLcQ6lciNGl50VJ6DAKCxPUmLGN9rComIy212w1tBYU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPWbEGHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CBBCC4AF12;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715671398;
	bh=fijWPI5Ec9mEIeEHh6gbcrhWz9IcjE4n8o8vNnEa8uM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oPWbEGHyoeP73p0zqQ755sVGAjS+QMEh3EczsCgUZ67D65CkSD1ujiFawo495BlId
	 UFjfv57/PL51MYQiB10gRE4sBWFgkS3msMimaB1+iokNIrqX6a1V2IMsgEbjgH4imf
	 dWBC3eKAmg7zzhD0K1//YwLoxtGbVFmrxWKHQNeDZ38TB09jwtztjXnvLhTIhYqNdX
	 sk3SMtqNbU3mA58wXcuTFbJWydLdoKRgdhEnIL90jPa9n200ZU0AVPu8mOBJNf4T67
	 vpngU6EONr3X0OccFP11Hpe9zvWYy1OUSk2WiLMZSGGOpdJHtYcIW60WMUv70jtKt2
	 hyBDTqluc7iGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495CCC25B78;
	Tue, 14 May 2024 07:23:18 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 14 May 2024 10:22:48 +0300
Subject: [PATCH v2 3/9] iio: adc: ad7173: refactor channel configuration
 parsing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-ad4111-v2-3-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715671396; l=2349;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=NkOJfDpfW75y+yj/rbukNrI85PrmYYK7YW9pUZT9xYs=;
 b=1QSxLACQYvSmI8UU/HN9sUKQoXeoAz1ee8CiXOpj8RlV25aQV31ZkXXmhUaf3ToUv+Sj8bl96
 krrGPH2nXvGDIPl5vzWnxO1AJvV9aDD9ZsPmsl59Z0VgrPD9KsVcNw7
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
index 850574437bda..d5ad3f01dec7 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -918,7 +918,23 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
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
@@ -1013,7 +1029,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
-	unsigned int num_channels;
 	int ret;
 
 	st->regulators[0].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
@@ -1072,16 +1087,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 
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



