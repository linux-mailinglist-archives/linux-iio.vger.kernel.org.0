Return-Path: <linux-iio+bounces-4373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FBB8AB21D
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 17:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681211F213D1
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003F81304AF;
	Fri, 19 Apr 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1xQPa/T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA997134CF2;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541012; cv=none; b=i6FgjH5BzKQWfrtYKGrkb27+xnQsGC9jAURRN9OVQU4w44AWwMGNBhcmxym/I8JuCMExnK73WH1HAM4ShJmi5Lmgdo+mzNPEYocDYUU2Sznv30A90OBGtcV61IOqP8n1MQ/BYnPRj6CtCopuXLFCo7ZTwf5JpO7kgtrAV7mkxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541012; c=relaxed/simple;
	bh=dKV+SJmNkbkvGbVwkoyrsBMcN+5DjDPpWTYe8E+QALc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BkLxDyKzPr32M8sAmo/sLKeVHRi6r1nmlkqmTa+E4bWeSV0VZmeZznghQXVEG15Rk45gHLA/yi9ErBVlDJBiZ5170Ptg5w3PimhotpItn4b72OY0fRDQaQmkTMldj8+sdlfoW3KIx3bDG0D2VXgFkVaCh+xo5aPLOGfzIWpGrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1xQPa/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67243C4AF17;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713541012;
	bh=dKV+SJmNkbkvGbVwkoyrsBMcN+5DjDPpWTYe8E+QALc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b1xQPa/TGyFQn+w6bpYbEHBEN8FyNc49y8ZSVcKZ8STCMlHv/IPhkX9ps3zg8Mw15
	 eO2zG+f+n9UywE1ZFG6pB9z/FQCCH9cBRM+3LuJ2Ao8s9FMuTY+6KpCW9tykC/xcIm
	 +/uOX5Q4wo41LMdUTCgiJmSJZqsBWtezpU0HReSgB9xUv4l5Yb7ztXOPduCqR9NN2/
	 eq/e9YUcsPxCZtUTDk/vpQTYBWFufOTGmGHrI5c6a+XjTKcwR4DAY2tAiU/qV4ubt8
	 2A7d5P5e42AAxeevBOk39wWwXUICcs0uREZe14AK3oX8l++R3h254vEt7FtqlKMMOh
	 faeabr3oJWRAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D783C04FF6;
	Fri, 19 Apr 2024 15:36:52 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 17:36:50 +0200
Subject: [PATCH 7/8] iio: adc: ad9467: cache the sample rate
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-ad9467-new-features-v1-7-3e7628ff6d5e@analog.com>
References: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
In-Reply-To: <20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713541010; l=1935;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=AVSjsumjo5TvKypskYPgN6fw3oHyN2j1uJ4FVRsJVt0=;
 b=M4HAt4TIvHefbkd2brW+3zFwv2Kv4zsyeem0qB7NE9I8pHZpgGeL+OOsjoUSvjFppixAuGByn
 qO9kYTydOw3DcqbxGs+JYFXrNh44kRoNQYC16xDcrQbD6IiiAVOtKnr
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Since we allow to change the sampling frequency and do it with
clk_round_rate(), we can cache it and use on the read_raw() interface.
This will also be useful in a following patch supporting interface
calibration.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 7475ec2a56c72..7db87ccc1ea4b 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -117,6 +117,7 @@ struct ad9467_state {
 	struct iio_backend		*back;
 	struct spi_device		*spi;
 	struct clk			*clk;
+	unsigned long			sample_rate;
 	unsigned int			output_mode;
 	unsigned int                    (*scales)[2];
 
@@ -331,7 +332,7 @@ static int ad9467_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		return ad9467_get_scale(st, val, val2);
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = clk_get_rate(st->clk);
+		*val = st->sample_rate;
 
 		return IIO_VAL_INT;
 	default:
@@ -346,6 +347,7 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
 	struct ad9467_state *st = iio_priv(indio_dev);
 	const struct ad9467_chip_info *info = st->info;
 	long r_clk;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
@@ -358,7 +360,12 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 
-		return clk_set_rate(st->clk, r_clk);
+		ret = clk_set_rate(st->clk, r_clk);
+		if (ret)
+			return ret;
+
+		st->sample_rate = r_clk;
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -543,6 +550,8 @@ static int ad9467_probe(struct spi_device *spi)
 	if (IS_ERR(st->clk))
 		return PTR_ERR(st->clk);
 
+	st->sample_rate = clk_get_rate(st->clk);
+
 	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
 						   GPIOD_OUT_LOW);
 	if (IS_ERR(st->pwrdown_gpio))

-- 
2.44.0



