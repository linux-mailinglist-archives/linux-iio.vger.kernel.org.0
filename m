Return-Path: <linux-iio+bounces-488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0B57FD777
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 14:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294F01C20C17
	for <lists+linux-iio@lfdr.de>; Wed, 29 Nov 2023 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AABE1E502;
	Wed, 29 Nov 2023 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLu42g5S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76DC1DFE9;
	Wed, 29 Nov 2023 13:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C358C433CA;
	Wed, 29 Nov 2023 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701263128;
	bh=nr6I60+Ybh8j/RB6wm/XTGHNHpMDeabpoOKt6I7wF7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kLu42g5SOSuJnnT2wBr+E4ov2dyAzoe5BgvcxowGhZ2qoE8Ja7JuY3xdAR+dkHj97
	 FCA7DsoYIn7QazBENctWp6ky9hjW5XjCI9t5cllz/96pu9hdAugFei/RSFSX9W3EF6
	 OLoprml8NwrqnTi5+GiCX3wlwz9ywjf/RofJoS1UJSskKFPb2GcSIOgDZ73EEbDTOX
	 NGHsI5SI7RRQoYMN1AoBYLsNzJqpRq6yy0stdhJLx2gQUQPwari60JV9/AQUrSj+Py
	 lqBTHMsR39gCAUUL3+6j7d0dJ88NlM/XvvD4rsl8ZPKFTvicME0UQ9BmLU9R+kp6eJ
	 VWyJ0dxTGQksw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C885C07E98;
	Wed, 29 Nov 2023 13:05:28 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 29 Nov 2023 14:03:53 +0100
Subject: [PATCH v3 2/2] iio: dac: ad5791: Add support for controlling RBUF
 via devicetree
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-ad5791-michael-stuff-v3-2-48e192b00909@analog.com>
References: <20231129-ad5791-michael-stuff-v3-0-48e192b00909@analog.com>
In-Reply-To: <20231129-ad5791-michael-stuff-v3-0-48e192b00909@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701263126; l=1575;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=V60ayX58Xp4oAs8NlC1uKeQ7LGPvuaHa+/Zm9B0Kn5A=;
 b=ufZVj/adYMkr7AgruJ5YgTvck+QD00d9QfRjuhHhfDzBIF3EzzsE/Q0GpfDhWfggsEQIQ12G0
 leoyFyCzUbOBYdiQhIbD04300vJxGGRObSWrdpCXCkkmpoBLDw16O2m
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds support for an external amplifier to be connected in a
gain of two configuration.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5791.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index a4167454da81..75b549827e15 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -345,6 +345,7 @@ static int ad5791_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct ad5791_state *st;
 	int ret, pos_voltage_uv = 0, neg_voltage_uv = 0;
+	bool use_rbuf_gain2;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -379,6 +380,12 @@ static int ad5791_probe(struct spi_device *spi)
 	st->pwr_down = true;
 	st->spi = spi;
 
+	if (pdata)
+		use_rbuf_gain2 = pdata->use_rbuf_gain2;
+	else
+		use_rbuf_gain2 = device_property_read_bool(&spi->dev,
+							   "adi,rbuf-gain2-en");
+
 	if (!IS_ERR(st->reg_vss) && !IS_ERR(st->reg_vdd)) {
 		st->vref_mv = (pos_voltage_uv + neg_voltage_uv) / 1000;
 		st->vref_neg_mv = neg_voltage_uv / 1000;
@@ -398,7 +405,7 @@ static int ad5791_probe(struct spi_device *spi)
 
 
 	st->ctrl = AD5761_CTRL_LINCOMP(st->chip_info->get_lin_comp(st->vref_mv))
-		  | ((pdata && pdata->use_rbuf_gain2) ? 0 : AD5791_CTRL_RBUF) |
+		  | (use_rbuf_gain2 ? 0 : AD5791_CTRL_RBUF) |
 		  AD5791_CTRL_BIN2SC;
 
 	ret = ad5791_spi_write(st, AD5791_ADDR_CTRL, st->ctrl |

-- 
2.43.0


