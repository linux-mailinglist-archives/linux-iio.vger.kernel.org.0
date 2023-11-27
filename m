Return-Path: <linux-iio+bounces-430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD527FA55C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 16:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FC0B210EC
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA434CDE;
	Mon, 27 Nov 2023 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA+5cpyl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290DC3457D;
	Mon, 27 Nov 2023 15:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA65CC433C9;
	Mon, 27 Nov 2023 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701100540;
	bh=nr6I60+Ybh8j/RB6wm/XTGHNHpMDeabpoOKt6I7wF7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KA+5cpylVtTlBKIh3V5XrNh9rCKCF05gT6AAArCWB6Mv53p8ljrLahI3LRYGcuIh8
	 Acp+AGaY6gVnhHHJtH75W6FIFCpA4k3YaMdbrOkntbA/NUFy1VoJYajW+X0/sowBc7
	 3O9c+pbrco6+9pX8euep1ALceik/o/OfL9qd1mz7UIOzgPyy1XWK8tIk1SNK7snTfV
	 ONpGIQ2UEdDf9199xGe327DOyk+3qMUI9mk4PpuyKZcOQKyDBbLJmjqgEncYI/k8WN
	 aGe32dxhRiwI5foVjoMcGmZ66YLEWqak+mKLnaQhIADIJmPYA6AfcB+XXbee6VMrvp
	 9gEp7ahbb0t7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3330C07E97;
	Mon, 27 Nov 2023 15:55:40 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 27 Nov 2023 16:55:35 +0100
Subject: [PATCH 2/2] iio: dac: ad5791: Add support for controlling RBUF via
 devicetree
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-ad5791-michael-stuff-v1-2-04167b3edc56@analog.com>
References: <20231127-ad5791-michael-stuff-v1-0-04167b3edc56@analog.com>
In-Reply-To: <20231127-ad5791-michael-stuff-v1-0-04167b3edc56@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701100539; l=1575;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=V60ayX58Xp4oAs8NlC1uKeQ7LGPvuaHa+/Zm9B0Kn5A=;
 b=+lvFhDi3dz4Zjoy+gfF6jAx15RVdJzTmTyoGM4/y+g47gGI4uQXyrrSVhfUD63LCuoXgeevMI
 Peh1v1bDO7WCOtxCMMJgMDLviDkccef5D+7VQcpinEe2h62xBE1hTSf
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


