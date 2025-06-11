Return-Path: <linux-iio+bounces-20500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B69AD62CB
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2BD1729DF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2291525B692;
	Wed, 11 Jun 2025 22:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1c5DQq1t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4E25B301
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681759; cv=none; b=mLh+PYjhmfl0FJNWxl6/Tcw+h+MeYROTh1MJjPoiNtQCMOZehNMRhVWPIWMRW2AxuxlH7dqaSMaufMfR1TogHeMO0qiJ7gNRVATbSQYh6mGZRru11cEsPShVemXm6cGE9xaj9wlNVbKdk2BOXoRLgse4cb0CZA0yGq4QRRUXDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681759; c=relaxed/simple;
	bh=H2qSnwk5w335N1zWnLuUuRDW3evPi/7hcB/vx7gI2r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lztAIIwtkT8KBxzIfaoZACybz2A3rom70NhBgX/GA3WH5sh7rM23W760FK6bNG0ZiUEAMfQMLt84VzaDnZrGR9s2MDdlbP1zYpKX2A7XmmR69cOwdsLcQ6TntmM0HoKj2dIs3lngSlu3Z8PX+glADITuiR4NkrNaH9eyIIK+h7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1c5DQq1t; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40791b696a2so98850b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681757; x=1750286557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WO1R3xWDaYXIM2zvzfZtCHLOSbM0nDuxCxYsdjOhuqU=;
        b=1c5DQq1t86v9RC79DVSTuOi0nGRnYU5lFDOjmPwj8/pkxwLp7v2l0duAIupxLYF0Lv
         Jms92khW/DzuGb51Jl8f1kjF801tyNq/G2g71wwG7E2eTNBTM9NIO83FfQ1z6+M2BLG1
         4f80YhqIhAhy3s3wdyYzZl0HKB2jEzMvRvJMnu2haPOsKgo2NGr6hb+MkuTFB39NG/uh
         8/B7/YsgKTepTZzv9m7kK4plTYqYkNSJFDJ6cyZrXrUkWGpoStoO7rGxaUbxRzNhKA7B
         pJJ7+Wn3l+RpFhR4Rb+ANDYmTsZ7KZ25Kaq3R9zW4blK1pYnkcsfQY+GCUejpbavHqr1
         LTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681757; x=1750286557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WO1R3xWDaYXIM2zvzfZtCHLOSbM0nDuxCxYsdjOhuqU=;
        b=kPjEXwJBysnTScYKzR6CU91SkDfVE0cp2kzYGd0dUo94MmSidNBOZSCqmblYDtLIQ2
         ONvfRCmXESYJyLf1uzwkRBmQRmW2Dx9sEd96t3CPBMb38QvJap+VRelQkPiX8lEM4b+g
         uy4pgtV5r4h8b1IWzqhlBl7i38gmDGvzgepuJoHa1wMrKibav7LwCUgGaLJA4Jmj3hge
         bNTJY7DqbArsVq/BxDt02QM4XiyTDYLgIFGrQcKZ5y1ENQvqgqNXCq0ycaIRrZA4A7X1
         BmWE+wcSBNq70z8tTeX0jqcJdjqn7tg4QcoGB0imZLR7sIUnV2HBwUTr8cf2hoeuR2sL
         8X1g==
X-Gm-Message-State: AOJu0YyE2UNaJf4FWjc6hEK1f5t83kt8DRdrDuolxgFU5D6XRtJOWk4u
	+4ISPhEobZcMvf0Sa/dlvZEfwfHDRv+sNhHX9uD1mtLdRyn+ok1uZy62zaGsnK5f/ZQ=
X-Gm-Gg: ASbGncscXiiBGHl8LH/ItLc8mEEis2KSUR4CBrTkuj6h/K00r+ERIDXQu/UL6BV34DV
	Vkmz5uqIWlBQUF2bWxX3oCsPXBL7M8bUb66LoOsKMdGVKM+FtAcdea5etJC66W2fQCK0+lwpQhc
	SlQFV0341BsajA8Ik3SxPoQxfKSTBHPHBrINnAR2qj8n3Je7EmR54OiJsvId0blD1yBuw4G2QbS
	HW4c8FdPBNeJLn0GiGByCnDCEqkjTcU2VwdCtg+pJTZw0gCunFbH+Gd0LWJ0ME9I4qfs7Lj2m6n
	CfhIo707OzTn4XyphznDHyv2KepMsCwDtr438Wx/90o3ArBEBAGHbG2/cDjpQOmlLc8r
X-Google-Smtp-Source: AGHT+IFExQxTK2nqz9eZvqFA01OLk3tdW0HRirCOET6sNhsVUFcwPfvM5Peex5ov7to5WvXVcBavAw==
X-Received: by 2002:a05:6808:218f:b0:409:f8e:7273 with SMTP id 5614622812f47-40a660deb1fmr937185b6e.4.1749681757305;
        Wed, 11 Jun 2025 15:42:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:02 -0500
Subject: [PATCH 10/28] iio: adc: ti-lmp92064: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-10-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=796; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=H2qSnwk5w335N1zWnLuUuRDW3evPi/7hcB/vx7gI2r0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgXGMQtBWy5ZBcGQvb7srptCW55i3K59YMUWH
 K/p9lukFTSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoFxgAKCRDCzCAB/wGP
 wMdrB/4wnul03c3MOAO6mWCe18RIhEvueAt8702Bg9iNqcJOIXzAq60UtlsL8lL9KfJBeyTWIE8
 Kn1YcuPT6kG/NM23xq9DfwqkwmJRaqql/t9NtrWj3fcDZ9hisOphYqKQTG/igEAW5g6Nfcz+8bW
 0MGHwVhT0gE2vhbfXW9+hFrHBHtmM7Ha9P5rGLa3H6cx2R2thSNCpjzS3ShjNnVhoTjLv0YbNk7
 cVrheUS1e/VAQdCaGjeafb/wfh7v0zxFJ8ugIGJ3AvK2hD9WEUPNck1toBMCR/UjT3Eb3fKsEzp
 LKfypHeHbcCyjL/xNms+MxWA4JU4Wp6gW8jxoF72I9jj7qfq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-lmp92064.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
index 3f375c1f586c4153caf9b47c34a0dcf6d5c48266..7e57006a8a1268cdda3a31d7c0366f72e1b11ea7 100644
--- a/drivers/iio/adc/ti-lmp92064.c
+++ b/drivers/iio/adc/ti-lmp92064.c
@@ -200,11 +200,9 @@ static irqreturn_t lmp92064_trigger_handler(int irq, void *p)
 	struct {
 		u16 values[2];
 		aligned_s64 timestamp;
-	} data;
+	} data = { };
 	int ret;
 
-	memset(&data, 0, sizeof(data));
-
 	ret = lmp92064_read_meas(priv, data.values);
 	if (ret)
 		goto err;

-- 
2.43.0


