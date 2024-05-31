Return-Path: <linux-iio+bounces-5558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3851C8D69F5
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 21:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649D11C256B6
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E7317D8B0;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhzkntFP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAD17C223;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184571; cv=none; b=tRmi+FxPNbkS2fzs8cEwW+fyL4C4HpFlPx81S5QHKwOIV4/GtZQNrtfAbbqAXzRjJmedVHbUuGSZk70nzqcPaaKDPjbznU8MFbcp8GoQpYklzX8KGUGc7FpwF0uFvRZIfnyhU1VlnEgqQfTI70+NuKCDQ7tBXrEJNImo07D0gok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184571; c=relaxed/simple;
	bh=sLlNh5KM9caSYG90x2iutDPvdP6uUJqRbn814aBoYIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dcUFBx6ujXUe6hCJKTFudoR6GvRzsltxcjgY4G6z51sZ8kW8mk4NosoztE2GREq5PlQafYq5m/1FeLVTmiJ8UqnRJWrYvj8nKyNSKbt5WEXzhV49ksCxWDKq1VIbG9uFZARBc9glleH4qE8UrVOu8IU3esqSsaEaC/jdUMGXtTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhzkntFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C246C4AF0B;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717184571;
	bh=sLlNh5KM9caSYG90x2iutDPvdP6uUJqRbn814aBoYIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mhzkntFP1mcEZ1D0J+hIEC2PpjFdQrYvZozm33tPdlxZrQNTjD+rZPCj+XNy+0XwA
	 jlmbQqwbNmYCk62FvvPP17sUPaFIwKm3AnA1WAwqZ2UJo/MWGa5wsQZgYR4vItjfiU
	 S7lXZKc8lJJhzJQiXY3EM5Rw0JLnXccOCy7k0lkS5kbrMVuPXMaaMFrDUGA7w8JgoK
	 rGgxExlfkkbSWNvB9inTIDNFhivYdAl6hJI2bJgbxlWXQTv/AHWbaaIH69FZI8YRs4
	 0Ep6FCasPZI8/eCIj1ohPJP4a9aBt2vJ2SlD1+yCVY/+k9BFH52uZ7zpZW/KsWB771
	 bUn7etG72ddvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F891C25B7C;
	Fri, 31 May 2024 19:42:51 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Fri, 31 May 2024 22:42:28 +0300
Subject: [PATCH v4 2/6] iio: adc: ad7173: refactor channel configuration
 parsing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-ad4111-v4-2-64607301c057@analog.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
In-Reply-To: <20240531-ad4111-v4-0-64607301c057@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717184569; l=2390;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=tyfIBjq9+3kqvLQ3iYrfTDEdse1O9TimBWVFOmM0qog=;
 b=DTeTcfTX5k8OZQ8f3AaMWc5IifhiebXkxIwsMzcSHA4ddZchb5XI0DLAlSwkAD0LyjeiBUbfj
 5Ly49LIRkrEAqDUjwvn2wCJDyP4Oaa9F82xwpoWLSIo09YbRUT66myh
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
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 638e2468efbf..6e249628bc64 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -912,7 +912,23 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
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
@@ -1007,7 +1023,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 	struct device *dev = indio_dev->dev.parent;
-	unsigned int num_channels;
 	int ret;
 
 	st->regulators[0].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
@@ -1066,16 +1081,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
 
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



