Return-Path: <linux-iio+bounces-6389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B02790B2A7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBC3282E12
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB923200105;
	Mon, 17 Jun 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dy12cCfk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106551D0524
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632266; cv=none; b=k4BbRCtqTTLIezxX6ifVkGVMIDPIw8aN97BJvRNjhXGC7htGuVvD8sKcLT8t8u8LFvRwovhfEQ6vaSxc4v2i0pRYCcUzt4Lwfd++28Ls4UtPSWajOquvkv/Z8OIBhavlXSXH6SYywP5OBEyQ1PHpp3l+PxjdU75LuzpR7ulv5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632266; c=relaxed/simple;
	bh=z9RyjZU19LnLgrucgjYl1CZ1GaGyJEE70HiZ5+JD4QI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEy+EBLp4KTPFSSIGBXykRkqTlviF/RtNCdkKsE5t6iKAOLsLnB9xjX53V7yosZywCMSJDee+3D05MFdpUIKw78AhFDUMI1qElKXhnUtrb8rmXuEquOlbvi5k6Q5b/a6iJGV9zcjEAJGnKXdksiE0QHsdzsFs8RDaWQ+/FuVhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dy12cCfk; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5babfde1c04so2020404eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632264; x=1719237064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWd9RIrs8wL0I/TcIsG/QAgGB9T5+fxOkhv6E/dAdZI=;
        b=Dy12cCfkpW3OL89p6eIQO5WH1yQEQIxtUbBpYOr0DMQTPPo2oXcQGurmwSGRjj7iko
         Qt8uKZNgcRkyqr/auHF/DgUXYo49cEyrkZj991EgIMWdQYkEIvdw2pBnTyh2TQdJDEC8
         DGKl5W/D9hUO67mvJQs/MI9R1r8m0p81LgeV331z10yvMT0/snQcTMzizP37itnr4egl
         VsZsgIJGopyWyJD1i1YVDAo+9VZzywCHDHqOpdymBoZv8OqQB1lRWz0eQ2g2lCFUWW7K
         Of9OC0bdaI4zv3KSiTwDdqXos9QlxGIxqhFP3ygpVP6ZK/cG7i3BammmgPAQGZsHVexq
         Wsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632264; x=1719237064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWd9RIrs8wL0I/TcIsG/QAgGB9T5+fxOkhv6E/dAdZI=;
        b=g7JrHDIXEsm8H28zMrP0o1YTTfk1MTJbjL+Fwu4Hgg6o1ORSnb6dOtZqPd0OTUy49W
         rumgQfDqMtAkAEn/OwLwch4i+J3hkkewBkpqiTmrRhtv06oV2p2uhTKi8Yu1Qm8JG+TB
         BK3r24Jyk2DNrouAylnL5V/QYNArsXbIo+ea4hJpKrS1LyOpMg7pLVjwbNxJky50F4aF
         CG0jTU9a2Xe7Vdevcp0/ThoawslZPI6bi/58Fx9vaoeQSasZbA2LS7RzhZc0ZV1jf3iR
         CpD/RF7n5cpoWItSiN66kgxIp+L7kS0JhchDIw1l1eEJGCdtrpLQV+yqB0NO9rYC3N7V
         fGwg==
X-Gm-Message-State: AOJu0YzFIWb40MGLVeldKvp4+8whSQRAUP/26X6uqIE12Y6TWExNnAw3
	lwX029e+tpbs08TI8T8m5+zwSevcvIjMJNQwF6AqVrjrj72sUmJ0W6fwkZ1RnDI=
X-Google-Smtp-Source: AGHT+IH8uTWV+X4VQg+Hvv7+Ss0V04PvnK1VdmrqhUaV/+VFOL4UdwUlA2xHiJMwUxJKiw4xuPCudA==
X-Received: by 2002:a05:6870:15d5:b0:254:8bb9:d0bf with SMTP id 586e51a60fabf-2584298505cmr11157462fac.32.1718632264185;
        Mon, 17 Jun 2024 06:51:04 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:51:03 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 17 Jun 2024 09:50:17 -0400
Subject: [PATCH v3 37/41] iio: proximity: sx9360: make use of
 regmap_set_bits()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-review-v3-37-88d1338c4cca@baylibre.com>
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.13.0

Instead of using regmap_update_bits() and passing the mask twice, use
regmap_set_bits().

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/proximity/sx9360.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index 75a1c29f14eb..2b90bf45a201 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -672,9 +672,8 @@ static int sx9360_init_compensation(struct iio_dev *indio_dev)
 	int ret;
 
 	/* run the compensation phase on all channels */
-	ret = regmap_update_bits(data->regmap, SX9360_REG_STAT,
-				 SX9360_REG_STAT_COMPSTAT_MASK,
-				 SX9360_REG_STAT_COMPSTAT_MASK);
+	ret = regmap_set_bits(data->regmap, SX9360_REG_STAT,
+			      SX9360_REG_STAT_COMPSTAT_MASK);
 	if (ret)
 		return ret;
 

-- 
2.45.2


