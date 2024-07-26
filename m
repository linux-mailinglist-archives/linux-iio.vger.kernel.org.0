Return-Path: <linux-iio+bounces-7928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A41893CF92
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF78282E79
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5C1178371;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8UEHU3y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB19177982;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=XxqZ274+TQ2fJGyTm8lTzhyFE7CzQMYRmAUTMiDeQy7+br3Z8k5DP2/Zy80FEuD+PMinX0OdjFeTfqPIWOH15Vye5BlC1RD4Og76hkbC7h0+S3NJcgC3+sicK53rqkomiCoZqPVMQ05/v8kGw3t7MbGBH/D7oyn0riNJUW1asaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=TDgN44IgZI0RwUH7i/HAFVQMVhgZp3akiVjvMGhwalc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mo1Ju++eIKXavlY3fiGq3uMFRXtip2Os24PWQGSpPd6C0q2s2oyuwQURK+S57nYlRHFnikE70p6tk70KLJrw/jnEW0xsvHzVqOJEfQI+hKqYvsQE/ndK/1/mRiNw3DIgzFOzFwNCvp8DRWPFsyc1P5OF37QDlUBmg85DQHMH6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8UEHU3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C1EFC32782;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=TDgN44IgZI0RwUH7i/HAFVQMVhgZp3akiVjvMGhwalc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p8UEHU3yXtYwgypz4M4XO9vIxESfTTl3XQRK0b1mfyTQGpSHEiEGI3SXavX3LiETS
	 iAEFqL/mpw1/g3TVol905K5bpw0YgS5K6q4yV3zZjZET6nxE90o+BPJpXbHPFTWcCF
	 v4PJWdqP06wOcsN0da9jq10Azb/mMwEyNY+y7prt0XsUQ2F3sg1Di3m4D/NI4g0J7B
	 xOuxm0t2lb6bsxzsUvzxJXL31Dg/GDoNDcG4eRz2ZYN2y8+NHOc/7W95OhTID8fhES
	 OdI7s2tTYxiU2sULjPo7fGAe+S/9mQ4jOVTXduT07/O5d/aWKT4EVxrO4yzqCnWUAQ
	 UdYmkqx8KDsgg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E9CC52CDA;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:12 +0200
Subject: [PATCH 20/23] iio: adc: xilinx-xadc-core: use new '.masklength'
 accessors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-20-82913fc0fb87@analog.com>
References: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
In-Reply-To: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
To: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Kent Gustavsson <kent@minoris.se>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Michal Simek <michal.simek@amd.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=1223;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=scLE0UCeIsTTRIkD5FhFjjiMruTUs4kHDToEaMN+2fA=;
 b=fPUYTrXv9f+DbYcT3DuLtq1kkiqy0vvvUX2/HLQS7pe71YnjlgXn/aXKkrDQj0QtC4Y1KNlrc
 JJBBK+55QndChONkflxjKr/JbhgcUSRJIzOJYlFQT6YpbaelHO2Qo5X
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Make use of iio_get_masklength) and iio_for_each_active_channel() to
access '.masklength' so it can be annotated as __private when there
are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 564c0cad0fc79..cfbfcaefec0fc 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -628,7 +628,7 @@ static int xadc_update_scan_mode(struct iio_dev *indio_dev,
 	size_t n;
 	void *data;
 
-	n = bitmap_weight(mask, indio_dev->masklength);
+	n = bitmap_weight(mask, iio_get_masklength(indio_dev));
 
 	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data,
 				   n, sizeof(*xadc->data), GFP_KERNEL);
@@ -681,8 +681,7 @@ static irqreturn_t xadc_trigger_handler(int irq, void *p)
 		goto out;
 
 	j = 0;
-	for_each_set_bit(i, indio_dev->active_scan_mask,
-		indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, i) {
 		chan = xadc_scan_index_to_channel(i);
 		xadc_read_adc_reg(xadc, chan, &xadc->data[j]);
 		j++;

-- 
2.45.2



