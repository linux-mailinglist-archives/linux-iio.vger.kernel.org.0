Return-Path: <linux-iio+bounces-19273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD74AAED41
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 22:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305E41B65617
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A977290BD1;
	Wed,  7 May 2025 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RVftG6V1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799E8290BB3
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650638; cv=none; b=r3VWdPsKpB3AD+2xw0vMJ4D3CjwsAZxYH82IGyeCLWVQGA8CJ1NYT4wfySSAvBV7Cmxc3Fz2lgWcnhK/x3Qhu6+d1El3oq5Eqp6cvmbh49w267uLGwUepmVHmGcPko3LNtQ2FyNC8NnH5nQGMfstlnbzneVnbnaJuj4tp7Ob/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650638; c=relaxed/simple;
	bh=FKpB3dJAiexqEBZWnTYr74fw3YEDDpNI+Is7oC3Guzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WiTfJEcsMgGJiSVzsZ5RIhKGqaOPOH//K1WsXPSSUXiQXwkSh5k4KiF1NkDHY/2/lVVQEAUtvGQ16ATOBXV5vP8HW1KzpkvffTdmXOMNC7ajcTzh/IKTAkl0o7cUzhoMLlROzKPDOIyBnzf8uZYKezEgU1GzMrMb5BUrZtVhEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RVftG6V1; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-86135ae2a29so15210139f.2
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746650635; x=1747255435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2eAy2RW5hS2l6KPQzT1N6BY4unTaPpEg4WKTF1g7HU=;
        b=RVftG6V1Lhufs1DG0u12iTwU0jKh8gUGI0m/6Krxuw4w1MkgUU5aC4JzYJxrZMRVTX
         ck0KcrlEQ4MgvTUXNiNmfLQJ57DrDqYO9oLgFm3YfEwRxLcU/pyLTgmXWVsClKyAkfr1
         UGpWBLqA1QN7qFmi4lvFA2Wa4Oa+eTkI79nPJMYpEMXtDb8gh4+LdURZEUw/HLU2x4Ed
         MXtVE0QmJX6tbva3zG4LARMj6jOTjSdtVEyRJCUK71PSS/nL+HOQfMXglaroyBfPpqBH
         OVm3hBGA0i1Fmc2RzQ0Ef/qMCPsxg8LaUlviGzOlP77WiItZI3A6tzMY/E10mphtk3oc
         iHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650635; x=1747255435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2eAy2RW5hS2l6KPQzT1N6BY4unTaPpEg4WKTF1g7HU=;
        b=OEiXDrjgjtNr0JmwbIffG4sMcjgrAIe47LBNSUci12XY0AY/Luu0pbLiTAB6De1aT9
         NHPVz5kQ1fpFJh91c6vFTdOnhOSwFPpS4upjYIQmquGAm5j70/MhrdsQ2PuTtiVIRkZy
         Gp6X+v2yBgXrOzMdUcrlBlSW4GQB2qICY9gnl4hKCN8ND5ADMDOxdL2rXLP/Jlvu9lij
         mvvjop7Vdp/8wEABRnrxlZpizOec2By877gT5R3LpkY1xX+8aTBzSdnUeOzzWa8/oeCb
         JLuySWci4bDV2Vm8XPI7FHBrqmemPGC3p7gxjfYDSvgrRllsV/0iFeuh8IwceVZrBMKW
         c1uQ==
X-Gm-Message-State: AOJu0YxiEmsHGU7UWaCygLdGq2hOdZs72avkhKTpZYZEcUlYgl4N9qCX
	Mf60j+X5Np34uK7gtYww9GNlx0Vh/EPHFODOWEFCZ2azwZ4ZgEd0rWoTsADxatzFlTGN7GqdtDf
	P
X-Gm-Gg: ASbGncsiuZfJyyhK1EU77T6sB4KO8/VCW8/A/8RTHBGVfPdVwQwKC1zelO/NBR7rgWD
	YDkvmMRyp7GCVMgBcjZkfoD7tR1/QIfYX5stq8MUaSy2hv7389i9KIDjIozvvS0FJhLR/tYPMqH
	aoVlizy7kaduDafVCORWglKjUinw9M47+fmG3Gj7DhnEQMj2x5P99oW4tYJyMk791w5LfoPoaZJ
	p2pjUpAGXE1Y9LcTC/YfbvpSxDEAi7j5fyhT123hnVvCUCkwbO9vxOa5ygkI7efUD7KQTMdh6z1
	BdQpvRANU6dTz/mt2oEaFVqLsSEVHQO0oc9K2ImZJQirPA==
X-Google-Smtp-Source: AGHT+IHzAHhf7adgAgCwkuC/t79NMGTnVH1TVIxPBrVXd3EvJcltzOzimp3xX9uDQtvTagqhfmWlkA==
X-Received: by 2002:a05:6870:9a17:b0:2d6:241:aed5 with SMTP id 586e51a60fabf-2db5c084b8bmr3450729fac.26.1746650624758;
        Wed, 07 May 2025 13:43:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5cd716d3sm898642fac.21.2025.05.07.13.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 May 2025 15:42:42 -0500
Subject: [PATCH v6 3/7] iio: adc: ad4695: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-3-4aee1b9f1b89@baylibre.com>
References: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
In-Reply-To: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=FKpB3dJAiexqEBZWnTYr74fw3YEDDpNI+Is7oC3Guzk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoG8XYJuOU1coFxNGXKJ8ETwdyznURBIo5GKTW0
 fBmAN0sBOKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBvF2AAKCRDCzCAB/wGP
 wNwqB/43rBhN0ftZxpOAJIUlM+JDMGXM3Gn1VMlrXdmDKN5av4LjjrP7qsqMeRZtKu6gtCeGuVm
 uTcKbDXFWKlXySdMtaKESE05oUfYN9sxjSyl+8XDHIzIdzt/X0zePBoCPD0UTi4BMiPxp05uh18
 A4ltomln1OzMmicJ5HhtVRH6q8Hd3aa701di+9Y6P1dcJT35pCV3t8QsT+rzhD9Pga/0+sgWc2m
 JlEl7QrVVWti4trSwEpjkrtjDr08ohggzW3i7oPd/fSjhybXBV7C+gelbR2Jbg+gn8edn8Eb2Sh
 OwWo6ZofWr+dNGQjVAemLQAFKR8ZKYcS0UzWuEzSsfuz9cgt
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer that gets
used with iio_push_to_buffers_with_ts(). This makes the code a bit
easier to read and understand.

Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 0c633d43e480d5404074e9fa35f1d330b448f0a2..992abf6c63b51dee222caf624e172455fb9b9900 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -160,8 +160,7 @@ struct ad4695_state {
 	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
 	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
-	u16 buf[ALIGN((AD4695_MAX_CHANNELS + 1) * sizeof(u16),
-		      sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(u16, buf, AD4695_MAX_CHANNELS + 1);
 	u16 raw_data;
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;

-- 
2.43.0


