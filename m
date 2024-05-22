Return-Path: <linux-iio+bounces-5173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DD88CC1A1
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 14:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0EA2834F6
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 12:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554F82490;
	Wed, 22 May 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWHL+3As"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E981848
	for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382447; cv=none; b=QGnaNv9sisntFgrcRk2t4Y+evtos5BHi/sSawJgjVKnGNA56M8ESQNu7b6ij4qfqBYB6zr2CwwOslLoVYzVf2Wa4p/HMjB1eE0eMpJD5K4zGU/L1To8hRIMbEp1OBw7wAyaHZdCXICTuxg83aBoOuOeJZOgnpVkb0PKMjjxKnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382447; c=relaxed/simple;
	bh=aSrCIkCGiu6tTQg0GYwKrxclRIWuTz5/VFiuhESD3Po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P77q4QhHfFWi553FSzczX4l5RMqerHLAsndzu9d0GtkiL8ZfsfNNvEJLBSeBc/YWN3DksK2I6FZEl6WQIyDuXe/dwwN0gbdoD9A3ynx4IaDN3SfbFESP3ckwi7Azm0w2BizyFvcgx55qPpbZxQ1ZnmDtcQPd0TBqebcNjTitPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWHL+3As; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F280C32782;
	Wed, 22 May 2024 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716382447;
	bh=aSrCIkCGiu6tTQg0GYwKrxclRIWuTz5/VFiuhESD3Po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GWHL+3AsOe1qDVqYGRPDWomDIWYBAqi0YSB0xqFXNCtzHYX4vbgevV2f/tkJuNoAR
	 99NdKBFlcZNe3mAOebuQ3+CkWpA2M1LQUzB9ZuMtb1JL661Tjpc/U0w35ZBmhsX6pO
	 E7XpxlhDltSIDXzQY0VJYCEJFTpA5EvlZewZ5fuDd7UjWt9GRWzxdPISbU866Nm1vk
	 mQK7Fk6f85EqXaK8yIaPkPyJQpes8ghyGZuVivCFU895WDUyQnhSKxBTdwUAL2EdUd
	 A+HgU29ulAHb1/AFG/jIX7fL5pPk4Q1BwafXWU1uGIVXTIFlr87+4UOrOydZdgd8gk
	 OLxL4yWdb99MQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A6AC25B7E;
	Wed, 22 May 2024 12:54:07 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 22 May 2024 14:54:06 +0200
Subject: [PATCH v2 2/2] iio: adc: ad9467: change struct members padding
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-dev-ad9467-dma-v2-2-a37bec463632@analog.com>
References: <20240522-dev-ad9467-dma-v2-0-a37bec463632@analog.com>
In-Reply-To: <20240522-dev-ad9467-dma-v2-0-a37bec463632@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716382445; l=2382;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KRf601UhH6cUyFxH9p8cxQJJFXZVEBFnvvguvfjDdPM=;
 b=GZQZBeGHXM+p4BKmPqY+cqZ4ADeNUriVSfpnwCF3qY2DjHTOMk4D0+Ks+oXyX7P++UEzSGd2F
 BGRXi8UwtN/DOnoxE3fUv2+aftC3XoUwQ9fjlcWbq9hurq33cvprYgt
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Using tabs and maintaining the start of the variables aligned is a pain and
may lead to lot's of unrelated changes when adding new members. Hence,
let's change things now and just have a simple space.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 3571cfe0f9cc2..ec11437cac7e0 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -107,27 +107,27 @@
 #define AD9647_MAX_TEST_POINTS		32
 
 struct ad9467_chip_info {
-	const char		*name;
-	unsigned int		id;
-	const struct		iio_chan_spec *channels;
-	unsigned int		num_channels;
-	const unsigned int	(*scale_table)[2];
-	int			num_scales;
-	unsigned long		max_rate;
-	unsigned int		default_output_mode;
-	unsigned int		vref_mask;
-	unsigned int		num_lanes;
+	const char *name;
+	unsigned int id;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+	const unsigned int (*scale_table)[2];
+	int num_scales;
+	unsigned long max_rate;
+	unsigned int default_output_mode;
+	unsigned int vref_mask;
+	unsigned int num_lanes;
 	/* data clock output */
-	bool			has_dco;
+	bool has_dco;
 };
 
 struct ad9467_state {
-	const struct ad9467_chip_info	*info;
-	struct iio_backend		*back;
-	struct spi_device		*spi;
-	struct clk			*clk;
-	unsigned int			output_mode;
-	unsigned int                    (*scales)[2];
+	const struct ad9467_chip_info *info;
+	struct iio_backend *back;
+	struct spi_device *spi;
+	struct clk *clk;
+	unsigned int output_mode;
+	unsigned int (*scales)[2];
 	/*
 	 * Times 2 because we may also invert the signal polarity and run the
 	 * calibration again. For some reference on the test points (ad9265) see:
@@ -138,10 +138,10 @@ struct ad9467_state {
 	 * at the io delay control section.
 	 */
 	DECLARE_BITMAP(calib_map, AD9647_MAX_TEST_POINTS * 2);
-	struct gpio_desc		*pwrdown_gpio;
+	struct gpio_desc *pwrdown_gpio;
 	/* ensure consistent state obtained on multiple related accesses */
-	struct mutex			lock;
-	u8				buf[3] __aligned(IIO_DMA_MINALIGN);
+	struct mutex lock;
+	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
 };
 
 static int ad9467_spi_read(struct ad9467_state *st, unsigned int reg)

-- 
2.44.0



