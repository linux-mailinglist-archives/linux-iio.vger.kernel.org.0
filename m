Return-Path: <linux-iio+bounces-18057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC6A87196
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A021890D7B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCFA19F464;
	Sun, 13 Apr 2025 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucDGDryT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B59219D880
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540530; cv=none; b=KH9oBRVbIXONZOsORRm9Av6Zfg4j3v0bUG65RxpSXKrXWySDPvdfiAtzchb6haWcNcM9DOeS1j6aDban/BbxWtpgbGzwMdkRmeR/iKKQ5gl/wF/EaaDQkx7Xk57AVXN9lKG/2KAe0nFZ0J+ZU85Ac/SeIo0ZxmD9ZkoLyfCp1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540530; c=relaxed/simple;
	bh=1yHXZPOOOC+AMQuIpGmwDyJaFHNGjwT63nwpTRIDlEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EiuvfI2hyjosRlywofUoTF1bjvBGfLxQk8J0Wyu0AAviyEhLFJb+Js3Oe0PN6J3HpcLg8y53kKqJcdfZt6AeZ+47ytLeUX/G0GXod/hJL7goZuOsOht8J9pBv6lJh87a1h+Osbj1sXqQi7UgYemp+bC3H6aOgIboWElLdvKedn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucDGDryT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284ADC4CEEA;
	Sun, 13 Apr 2025 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540530;
	bh=1yHXZPOOOC+AMQuIpGmwDyJaFHNGjwT63nwpTRIDlEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucDGDryTp0i/EYJVmqn+mHlTd6rcdWjVXDeJDPrdfjRzwnLQIzOxaxtY2/RPqyUBl
	 CWJKKFua6FcQ6+fJjLjQTogVM0srJScYxl4JoBaSlBCbha7X6Q84pAv3/uqTWl2YIo
	 yBf9h3HJtjqRTYLmJpB8clY6EsbE4+DpGgs5Q+E5/etlu872J+Dh8Uo6F80BELsQra
	 8M4h96gxAzUxRXkzgRZiHg4Vq7v1IpHExt47TNuVBEN8D6gJzCtuEczPdNN+aKGEUb
	 O6Q93aWToJhP6h4gEvazhGEcrWyy6Ame2CQyDDAXRxsmJuyO7d3bacQWK6AjVPXwog
	 qxfPeWcnFZvLA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 13/20] iio: temp: maxim-thermocouple: Fix potential lack of DMA safe buffer.
Date: Sun, 13 Apr 2025 11:34:36 +0100
Message-ID: <20250413103443.2420727-14-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
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
index 0bbbadeed940..dcfcbc434a90 100644
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


