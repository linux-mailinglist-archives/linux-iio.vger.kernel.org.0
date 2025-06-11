Return-Path: <linux-iio+bounces-20515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8660AAD62EB
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADEF18914A2
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9792BDC25;
	Wed, 11 Jun 2025 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UvUOcD69"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CAF293B55
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681785; cv=none; b=QtsI7r/Ntws6/FeIGlrJeaYqMF8B5xnLl2W0sjz9k57lEJunN44VV9mq+5iIPg32Qaqlhqw6xskcpUDkFjPJ/HESuuho1jLqit64APUReUX+qMBzQ1Q5RPmIOMY1rlEwry7pfbcnQ5wZxxwUxS4ahY5F+tFO1uk0lhGEv0LICwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681785; c=relaxed/simple;
	bh=F7t+iKhqynKqsGA0Dj6cleYDfnxlvUihp6+d7Cd3LFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HniUyg+Kwk5wDveFCwiCKWu/IpVgLEgTCrkIvS6t6/AuPQB/n4FhCtnVsyjAUsfsFCdzj9P+0x9nJEFKcZC0rH+Hcyz+/BlV5dpqAgFEs+Ar676cPF4/d73JrlNTnFKBrRTSsbVd7JX8ZYzUHL5pKQPWe8tJqLq4/oLuvq6C27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UvUOcD69; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c13802133so140816a34.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681783; x=1750286583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlnZuUqEMiDPyoPu1uidt8DikGLHmN/8IAgm5AlJwiI=;
        b=UvUOcD69NPbfH6ApLSbku8H4buZa7u6LA8axCA8cvz+QXN+/E/zRSRhj88zHvTQvSj
         aj8VAZhDAcRCT60Rgcl1ruOA0U9gnhL/HFGaWqX1LOF8ZJcEVDdw29M6zZGvMxEEe9iB
         hc2oFKf2eacGpYcT/1nr3S45/x8aGwGru0T7V34hNELhAyjQRl8nos9koBcdXtNH/MFU
         EQcd1EL+yy8pX/ABpmoyB8Z51i7/K46RlLFzV6usTF6b7ESk7jEcU37O61nKp77TDxVr
         mONCP/puB+zp0mYd4qpEqQEnb6hRwIdc1pZOO180z92LNy0783/O1Hc7ddxZLRhVQyzg
         QUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681783; x=1750286583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlnZuUqEMiDPyoPu1uidt8DikGLHmN/8IAgm5AlJwiI=;
        b=b/km3eqcACYLUTO//MHpjIaosbumPzJlBsn09qDuzPWXGUOkZ1tb8kVV5xbWf8I6WR
         UY63JJMzwcL2HszsZ5IcHxKw9Ww4IQ9+JOtxJ0qvuUfrWSL4Kvdp6UI42hNmbVOxUQiZ
         rTflmZTa9PcUOpLiNemPbWEYQ77IJEtTpQgwjEqj1xhjv2f3Tv4FdqxDfzN3KlOE1TNI
         jlHg1DyFS9NU/L+VlPR+vMQBM3NJi1WR250lKN/NkHXjhT25MWdvPPyfbyNMQEjbsonn
         7p+Re6MWvyIwcNeWNXMbVNj/hwjFBQmMMQu2JK/qGG37sErDcpKlVBevCCYT3FQ3pbff
         tmuA==
X-Gm-Message-State: AOJu0YwsmuJqngDGEcaVUk7/GXYwD4LkdqikOKb4NFYLC1WpRvli/jYo
	8fqwmIoflJpXS0nTkMvZZN29niKAadPxpk3VwfLpS9q1m5FVm+cDS4CGiBUFgzJyIzY=
X-Gm-Gg: ASbGncuCTso5eWDYna+bKk2od6SNVab1Wy6zJi9neb8FTRRsYk6ZVxeDUFoujusOxNI
	PoF8jGbY/7hpTAvvhNXq6bFbGFaLTz1UBxKrxh2CQaorytbYDBWTy4fqyGeu2S/oG3TAqXSHMdc
	t3t8weNJ/1IUoU1vzIMiKf7FzStTEDZFDDAvRboLr4MbiV61XP0/bMM4rmcY9BurS0eRVdid2s6
	i2oRhCArfdhdGhLzZ8gXhTwSaA2YoWELlFzjDqG1dLiau4P+9oQfN1Im7XAknssmSkyUg9Qcrrh
	Tau1K82Nb9rMYV55xMDgJ8BSZrt10cV8gE8GED5+98nmynk0cMTphiHXu8FDYBr+retm789/57x
	Oogc=
X-Google-Smtp-Source: AGHT+IHanymhU6haQwMX08UaVWjgDuhrBJkJnuAw0FtFP5FomR3rskOHKaWp159bL/od+P/uW3UjAQ==
X-Received: by 2002:a05:6808:2388:b0:3f9:4f55:a002 with SMTP id 5614622812f47-40a65fd343amr919002b6e.12.1749681782819;
        Wed, 11 Jun 2025 15:43:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:43:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:16 -0500
Subject: [PATCH 24/28] iio: pressure: mpl3115: use = { } instead of
 memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-24-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=F7t+iKhqynKqsGA0Dj6cleYDfnxlvUihp6+d7Cd3LFc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgYkRI+gTkzxZcqPjcDI24PviRY3280AM10XW
 Soj9nQ54b+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoGJAAKCRDCzCAB/wGP
 wJavB/49bwHnqdL6jGGKc0R+tNBC8oWNqAgzFcpqGTNVFp+z2yNK0M3aP1hqPHGL2QBr2TA2lr3
 eaNmz5m1EZlIb1/czf8EL21m6pLnB/38XHfTEkuUfIR69m6fw3BS3Fc7dMyIcsr8vdRdjMxUgEx
 amFPpQ4mKamDXx1TLLaF0FtED8EH22FcU0HwsL98z1KR/0+4fZ6CTqvl2MRVikEAFvjbQdfenTc
 pegbUCdP51Apv3/KFpJJk3XTP46eI1vJ9vHFWabzWZyk42ooaanCWQC61vYb2d1I3+Qq7771tUx
 7nB5lSZddiuam+AwBUXxlh+iq8FqViKV9rtz43g/ULV3QsZ0
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/mpl3115.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index d6715997f13727e22346a76819cb7dc58a96614e..579da60ef441482a82f3bdf4f67436a13ab3e09d 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -160,7 +160,7 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	 * of the buffer may be either 16 or 32-bits.  As such we cannot
 	 * use a simple structure definition to express this data layout.
 	 */
-	u8 buffer[16] __aligned(8);
+	u8 buffer[16] __aligned(8) = { };
 	int ret, pos = 0;
 
 	mutex_lock(&data->lock);
@@ -170,7 +170,6 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 		goto done;
 	}
 
-	memset(buffer, 0, sizeof(buffer));
 	if (test_bit(0, indio_dev->active_scan_mask)) {
 		ret = i2c_smbus_read_i2c_block_data(data->client,
 			MPL3115_OUT_PRESS, 3, &buffer[pos]);

-- 
2.43.0


