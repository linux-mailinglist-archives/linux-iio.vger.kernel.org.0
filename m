Return-Path: <linux-iio+bounces-27426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0736CEA9F6
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 21:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A429B303A005
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 20:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B128853A;
	Tue, 30 Dec 2025 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVQFTFOH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421C274643
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767126936; cv=none; b=bNhIx/1Og1v9eQ4PAMms8ANn30H29cMUf+CnCxAZrzZxSpbtTto7Nj4RRSKVAvdBdzI6XRe5m5rgI9pJpesOm1m1fAgtBTCLmYVG3+XVRH5ZHU/sbHiQJG8dqnhMwPl9GI2/pwTTWyhuAW5is5qi3+0mQ7WrBzvp5KXL7LO+J9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767126936; c=relaxed/simple;
	bh=vESSaFIFVODvDAYauywzLFHfGN0Mc3h70ZxlmCWHsa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4p+C+3I11nCOXWBYefIPvqmkqHobrTlzGvQhrMDuA+tdbFRkJgK0OmI71/mdpFmV1T+Y2X5KLpd4SHN5GrujbjGmZlYd+MOLG39cBXTXWEAdWJ6itzXIXmEMIjWJMybTgr3jReZo5R3clRqNQDkiCJ0yow82PALCqCj3neBbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVQFTFOH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so6974373a12.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 12:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767126934; x=1767731734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axPCG5191y85EuHI3q1Bwt62R50lYejVjnZraRFrpsg=;
        b=DVQFTFOHdeJvLrY9oYczzjGGGezJxT4esEm8jKp4EBIg3KtzBRBVb3FwrrLJkPtFk7
         ntW5QaBAqY2xDZSuLgEfKUyswfmH9W6pBecSAEQiDhfL5x0qXfe0iUW8+u/wZ5+7A73u
         unsco1rGkOUKzbIFWkBZHmXxz720f8oRsjJZ1ukmIquifUQP0c84D1RfSmNME2bd+7xr
         6+e6phC5/U3l/CtXCUvA68eIgXH1mAReezNzszcE1hVfM2Y9IUrGRulIo+TuaeEopdDE
         FlHVQjK1fffzKGfymU9cEobd+1iPQBQMiOq/Xn+H7Xt2XTXy1p84fvvULX6u6F/OXXID
         sILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767126934; x=1767731734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=axPCG5191y85EuHI3q1Bwt62R50lYejVjnZraRFrpsg=;
        b=tB0rMmduuON5XfzlSO175RtUCqJ+9azDALNTE/8f8yCNO0QVfTxjR/+ZsVbhmAAzOj
         I+ZUJf/TVaQDMGkIaLGiyYAk9f3Qsbk80yh8chZhGbh3K/nInYD53px2saTcleel17SI
         Vr0kj0uNpUS5WM/bVW2zzL2nw5PqKZRtUdAUD8Je1VG2vHU8ISskNMSElxe+TkYB+m/Q
         MpdLhYkZMDDGlSVEIzC4Oi0ngrFkQCFRsi4QhsHRshaUT6D2MJ3FR1u/sgeSH/2rRLU+
         1KBhtsukmsq9sCZudnWdoDzT4oOKDI7P+aaUOvisHlBoOqhflZFzPnU9J+b++HYzB6HU
         OiCw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Y9gqksJOa3LlWe/drnOFVpi0YAk5B4b3YMR+esm450DCM1p4tdhPllsIpGf/QIT7G/4QYdxMU6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UjOGrhTecCDf4lq2fqekBJDsx1qEea8DvrT/LFnKTgTMKcZG
	Fj6HnFZeC2c2ZnHAncPeb5jaMH0Z/U1uacpczM8X9Sus4q3maj+479J7
X-Gm-Gg: AY/fxX5iVlaEOUjIle/jn3bCEKFpH8cHfAtt58EcKEaE1cUC5ZFE8ndXMDoc0DtOPVl
	szd15TFV8PnCCZG4d2bKupX9kzOtupq/x5RdBglsoEUxZNbS/SkzMAlSjYqMCRkUZ5YQ95tQOLQ
	bT8BLaNQmib40uh4mVABNV+ByAZaKmfspG6PmSaBHINLEtEcsyYhGuwum4TMFKEEdk3wUAlosCb
	6kbzLiEW1Cn5Xl65WnkXNhuxGCaDWO6Iya0kbuP1jUB3Po1nRLo7qGBtWoRLNIMROIdOcsoHXln
	HG4vV4blRiCAKBAYBsh6sqsFWg1VLD9vQd6Q0gLrq8gnwBkTc6+nh0Kn70+NJ/sMMyD31lCG2C0
	ZK492ytjHiAHbCUqXDss/AdVm3N8dtlrJCBv/59uSQKWCitTdfJ3vjIZI/yqYnSSX4u/36Rc5X2
	T4lWziupKULyhc/V2nPYZV5HFxO4SfA2BgmcdebtGDpFLxDlafB9rYi6/MzgBrS7X+6X8IaORv2
	cTxa+XNRhZ9u5EVPbrmw1KX2BYbGYG49nZl5/DDNVtxK50aOzA01uXpjX16v67rF+rEvAuH
X-Google-Smtp-Source: AGHT+IEjynbnbNOs0GxvG1NZrDdhGId8lCBPq2Ib/COi11IyOlDHpfQ3hve0iMX2aPrHetQoG3h2YA==
X-Received: by 2002:a05:7022:220b:b0:11a:61ef:8491 with SMTP id a92af1059eb24-121722a9744mr39338291c88.3.1767126934007;
        Tue, 30 Dec 2025 12:35:34 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.75])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c23csm128074981c88.9.2025.12.30.12.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 12:35:33 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [PATCH v2 3/6] staging: iio: ad9832: convert to devm_mutex_init()
Date: Tue, 30 Dec 2025 17:34:56 -0300
Message-ID: <20251230203459.28935-4-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230203459.28935-1-tomasborquez13@gmail.com>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() for automatic resource cleanup when the device
is removed or probe fails.

Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 35d8d51d5c2b..4bb203a67046 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -310,7 +310,9 @@ static int ad9832_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->mclk), "failed to enable MCLK\n");
 
 	st->spi = spi;
-	mutex_init(&st->lock);
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to initialize mutex\n");
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad9832_info;
-- 
2.43.0


