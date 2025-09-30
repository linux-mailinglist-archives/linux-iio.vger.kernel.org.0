Return-Path: <linux-iio+bounces-24589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5025BADEA3
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651177AC41B
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 15:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C599F308F24;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEN1pGRY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D23081AE
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246363; cv=none; b=NeDskJA9D1YwnE9h6citS0w42vPtQpTjkryeAbkQqeWOORLzuK956B1ummz+Cc3F8pVUYPBK20IGDJFEscT+y1CCd5l8uMi3377Cm1RPB8GiseV3SKYms7CQ2YuWJX+BLwXi//fdN8ObH5x9SW3YUYKEa+2wEXCp8vYtjYsXiIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246363; c=relaxed/simple;
	bh=2R8ct2CIzDNl/WBKNmSNMtlvamsOPTT7vnMG3Fdcvg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bo8PPFRnr6kWyPZ6eAkp9XNfefWm2TfmLBss7SE5gGtSM/AQSmsTXJYOpt71Cm/Kk27DCdgF3PN6dhrkO7RZYuYToXaXdAEu7BJbolzoTr3EX04GwsbHaOb0Ue95gxkckLW5Oi8dzf5ef+isOO8euxbOuPCjhB+bSeZWOd3IkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEN1pGRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55BB7C19423;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246363;
	bh=2R8ct2CIzDNl/WBKNmSNMtlvamsOPTT7vnMG3Fdcvg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YEN1pGRYxsEXii3Jke/tUX7aPpf/oCD8CckZXHCdWTVR99D5E+6O056XC92G3GPlU
	 UVR27SBsJEO1BWdwIXROxab2FHZcLVqDPZGTSM7b4SyA7T0u6LpmcUCVlJZ2MzwDhy
	 ZoFs9Xk5Tq3W7pKxQrEvfAGB4BzThAzFu1xxjiSfe2L622m4LwrzvY6AemUiBe4sF0
	 Il3Q3CxcC4G09Thh4buNf8zinGpEkaQzDgOQtg6CcUNmx9E0Aty98yht74+OzYQB1S
	 DTQjknHdxUm2azqFuhj714mctuwj5vxBNjBryJtUsc7oFnYrWz5CL8nx/dGlDeiipb
	 HTOy27z5kbkrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93FCAC5B8;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 30 Sep 2025 16:33:14 +0100
Subject: [PATCH 5/9] iio: adc: mt6360-adc: replace snprintf() with
 sysfs_emit()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-dev-sprintf-cleanup-v1-5-5d65d096a952@analog.com>
References: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
In-Reply-To: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759246391; l=910;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3f+W95hXwHL+jJYIyyCbGXqeeocZadZ1pyBxrDdqaHo=;
 b=8aP4W/p5srujnnNMnnPeKKFdtx8Tg/Gk/cxjEf0uazyj+bbAs5UmxKbFFfZk4rRfpY6eWLdrT
 bmfWmx7C/kBDiNSBA04XAST79B4jYbQzprH4UoB4Sp+0iH1a47lrOsH
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Update the mt6360_adc_read_label() function to use sysfs_emit() for
generating labels.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/mt6360-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index 69b3569c90e5b665e1d2c59621df00d6142fbe9c..e0e4df418612469bb11a88bdbeb77aeb7cb833eb 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -216,7 +216,7 @@ static const char *mt6360_channel_labels[MT6360_CHAN_MAX] = {
 static int mt6360_adc_read_label(struct iio_dev *iio_dev, const struct iio_chan_spec *chan,
 				 char *label)
 {
-	return snprintf(label, PAGE_SIZE, "%s\n", mt6360_channel_labels[chan->channel]);
+	return sysfs_emit(label, "%s\n", mt6360_channel_labels[chan->channel]);
 }
 
 static const struct iio_info mt6360_adc_iio_info = {

-- 
2.51.0



