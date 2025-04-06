Return-Path: <linux-iio+bounces-17701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D1EA7CF26
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C1A188D5D8
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D5E18BB8E;
	Sun,  6 Apr 2025 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GviZu8I7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599931487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960055; cv=none; b=QhEeZD3/aPQlFAAH91qmkfl6Owfc1fv0b669mlpBpE/l+p9YEsNLfXzEh3rW4E/RkacqYCjwWjCMc5QWXRHePu8xzVTwlNzynWgoPMOV6y6BofxJcBwk+ZmHF3h+y6PtNgi0ccqTaV62nKy/9xOmWmspUObvPblNe4k8AeA90LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960055; c=relaxed/simple;
	bh=9uy1gDWjKJ2sFZwUHmxI8KKbNHVtzGcCIRyEpJTX0Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qisheIvGH1UFKeFbBzxzmuttXgedCIiAEXGA2wMKzsejS4OrvAkFahtMR98NGJFFehScDDoGPuhELxt24yM5k3VUdgcRpEJHQq0yFeq6O0Z7p4gFg1azUKMa1qnjFd/LQYz/SRUXbrocsuy5+9fKz+Pd1Mc2Te0rirwewTXG6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GviZu8I7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02D3C4CEE3;
	Sun,  6 Apr 2025 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960055;
	bh=9uy1gDWjKJ2sFZwUHmxI8KKbNHVtzGcCIRyEpJTX0Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GviZu8I7RAEO7rj5yNvruclX5icAt17Tl/uprFSluuyBqpohOWLkAVvkB3+LBjuDQ
	 n4gib2qES2++2BbWGbf9+8OGCCBB25E4rDmE6omZTBMouzbIxA9z1GEtbEdwNg2oQj
	 qzeOT/FRlkFidHjT7fujh+V9f2TB8r8QNpGhmRNxn+Cyn53Rj/ZeBOG1FPeSUCzoHK
	 o3xtErq1UZGZhRtKZHx/QEhTLqutTesEwtTVM8o5niQJ9Jx7UWubVGsGVBZj5+i8aJ
	 U7YMq2qBGVS3a+xcl1TxW85f1zst1WbZRLFxAHwtdXF0RGBLmaPBKf35G7sERqhTjs
	 01Fm2sSmI+9lA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 13/20] iio: temp: maxim-thermocouple: Fix potential lack of DMA safe buffer.
Date: Sun,  6 Apr 2025 18:19:54 +0100
Message-ID: <20250406172001.2167607-14-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406172001.2167607-1-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The trick of using __aligned(IIO_DMA_MINALIGN) ensures that there is
no overlap between buffers used for DMA and those used for driver
state storage that are before the marking. It doesn't ensure
anything above state variables found after the marking. Hence
move this particular bit of state earlier in the structure.

Fixes: 10897f34309b ("iio: temp: maxim_thermocouple: Fix alignment for DMA safety")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index a13efde76397..db2149d5f78c 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -120,9 +120,9 @@ static const struct maxim_thermocouple_chip maxim_thermocouple_chips[] = {
 struct maxim_thermocouple_data {
 	struct spi_device *spi;
 	const struct maxim_thermocouple_chip *chip;
+	char tc_type;
 
 	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
-	char tc_type;
 };
 
 static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
-- 
2.49.0


