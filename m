Return-Path: <linux-iio+bounces-11048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3CB9AD8D4
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 01:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8381C20FC3
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B7C208993;
	Wed, 23 Oct 2024 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EAjHzBmK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAD207A26
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727708; cv=none; b=YCuzcOEojVrYuhHS4x1xUqaYXcmL2qwkUrroa/K/zjHCcpldciCpaTuT9sV9iC3e/YKdWpuIYIHrGt6oIT9nPdOJZQXeZADUCx+qjWKw4yV23A48I+wq+HtDUM9yCehLjIqbFw7U6ZvcJSCUferHFpDkNUhjU6qVIo2sNFGiDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727708; c=relaxed/simple;
	bh=7NlO7cRYdSF3gG8gA/man+tCA4mOxbqbKKfGxWwRT8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JADExKYJA2ERksxr5jXUkc7qJHc2xa50uT/AW+MvR6uG7lihq3XqhxAoyOVrDLecbxQCcMD4UFsMT1HHgANECkZ3lToekQmA/omHI11PukI+/rTUQnCqli+oipfuN7rfARH8+Ck+4ShZF/sTfv4lTeYAW3akB/CQvLTYjbJxSGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EAjHzBmK; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7181b86a749so211248a34.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727706; x=1730332506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwdVzGcaQF7+SOsHpL7ftp3FlbFCZlW7or80O3tjS30=;
        b=EAjHzBmKfRNvKxkR7j4ajPcrpsrmP7EyDPxXiEudP3EoWd59EHq9pG9NlaLF9jh1lZ
         LKm9oHwLajAtdQqsiUJvHKplM/l1Vf/SkJ0MFCbXnqkH0NOhIoJ72+9Q9fq4ziX/nfOF
         BoRkz+SCgbbSUBCrNRYx3m8r/19IbDVHLVWxa3wlrv6vjxn8oS3qIkKNZoLH/r1kRB06
         rTYUTKwyTi91usAWuuRrQArwL2UzDQq1piD7jFC57CSLDrjE3Ohmte/yh/dUjPo5Kkg8
         qmQMulE7EtKjBBZBatMiYekVl+KuLzhUVaGfSYhN/Et146wg2PXOwPchc8Rb8nVOrp4s
         dd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727706; x=1730332506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwdVzGcaQF7+SOsHpL7ftp3FlbFCZlW7or80O3tjS30=;
        b=XKE6oEUshcYciwvzsZd0FNHkW5HzLFd1/odlAXnfZ5zb3x60FzLZ0M3jWDse6b2JvV
         1KscHbCzWBGHOAK2gry6VezgX/Lrk6+TsBLC3Lrk1W1nKU+b1oAboPv34Qa7KkZ0AF70
         kUhO6/reO54AEskoBYUdXxsKbYTzb2AZZ4/eHTOVVcOySalivMrm8zw/sSJZwznkWBge
         kgc9RbTDWZdcJEKgrByV+V1RRlRGuZ/B7hf17+qgz9el+PNPK3DH4Gd0l7P/FrcKgAsa
         aiOK+EWyN2znaGm3NVmkgbR7l99AmWywJzf3IbDE8HV4WAZOF1+matdUQWL9j1qO1Ns0
         nmBg==
X-Forwarded-Encrypted: i=1; AJvYcCU0xTwzDFQrwMNC4t/LjUZA34xOYDaE7sTCaTghgAgwveDoTXo3/EIUw3IE38JzvYmLkoqBhJVVU9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpC+fXyibfq4CafDHjboFBF2ZmqjBLApXf3ysqvfILB4iKH8d
	QcfOF1Ca3nMSWhiKqhz1htGgXQ9iNNCNQUH/iHoQMtjuUujKXFwCbDVpkFBlgvw=
X-Google-Smtp-Source: AGHT+IFFf5uOVklZ3NWR8b1RT59iDDEKxLvxl1mNoMhioyb2CzYSMhqTdom4ES3ddDpjGH7DrlUq6g==
X-Received: by 2002:a05:6830:43a7:b0:718:196a:c749 with SMTP id 46e09a7af769-7184b44d2b3mr4807921a34.27.1729727705886;
        Wed, 23 Oct 2024 16:55:05 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:55:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:15 -0500
Subject: [PATCH 11/11] iio: dac: ad5770r: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-11-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5770r.c | 41 +++++------------------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index 7d7f5110d66a..25cf11d0471b 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -122,7 +122,6 @@ struct ad5770r_out_range {
  * struct ad5770r_state - driver instance specific data
  * @spi:		spi_device
  * @regmap:		regmap
- * @vref_reg:		fixed regulator for reference configuration
  * @gpio_reset:		gpio descriptor
  * @output_mode:	array contains channels output ranges
  * @vref:		reference value
@@ -134,7 +133,6 @@ struct ad5770r_out_range {
 struct ad5770r_state {
 	struct spi_device		*spi;
 	struct regmap			*regmap;
-	struct regulator		*vref_reg;
 	struct gpio_desc		*gpio_reset;
 	struct ad5770r_out_range	output_mode[AD5770R_MAX_CHANNELS];
 	int				vref;
@@ -591,13 +589,6 @@ static int ad5770r_init(struct ad5770r_state *st)
 	return ret;
 }
 
-static void ad5770r_disable_regulator(void *data)
-{
-	struct ad5770r_state *st = data;
-
-	regulator_disable(st->vref_reg);
-}
-
 static int ad5770r_probe(struct spi_device *spi)
 {
 	struct ad5770r_state *st;
@@ -622,34 +613,12 @@ static int ad5770r_probe(struct spi_device *spi)
 	}
 	st->regmap = regmap;
 
-	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
-	if (!IS_ERR(st->vref_reg)) {
-		ret = regulator_enable(st->vref_reg);
-		if (ret) {
-			dev_err(&spi->dev,
-				"Failed to enable vref regulators: %d\n", ret);
-			return ret;
-		}
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret, "Failed to get vref voltage\n");
 
-		ret = devm_add_action_or_reset(&spi->dev,
-					       ad5770r_disable_regulator,
-					       st);
-		if (ret < 0)
-			return ret;
-
-		ret = regulator_get_voltage(st->vref_reg);
-		if (ret < 0)
-			return ret;
-
-		st->vref = ret / 1000;
-	} else {
-		if (PTR_ERR(st->vref_reg) == -ENODEV) {
-			st->vref = AD5770R_LOW_VREF_mV;
-			st->internal_ref = true;
-		} else {
-			return PTR_ERR(st->vref_reg);
-		}
-	}
+	st->internal_ref = ret == -ENODEV;
+	st->vref = st->internal_ref ? AD5770R_LOW_VREF_mV : ret / 1000;
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5770r_info;

-- 
2.43.0


