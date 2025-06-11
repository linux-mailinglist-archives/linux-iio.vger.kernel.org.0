Return-Path: <linux-iio+bounces-20495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822BAD62C0
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094F017191A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEB0255E40;
	Wed, 11 Jun 2025 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T9n+jTXc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C8253B7B
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681746; cv=none; b=AlMXhDRxcFGeteYBjB0Qrjbwax2I3Y0v5r3LtnzA5HW9etHwbnUwxlTEsXownMfxvncaXdyKZlFk23t3lwp4XQnoFASca1EQa//a/ubMTjZDC12bsKbzgfy7+h0Dp4/8oY1se1Fz//6jk+zY4rvnYyIN5F2oj50SC3rU9N/BM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681746; c=relaxed/simple;
	bh=16CSBjTW3ADRr7MOYui8jO+Mhn4wtu5HebYIEym4zkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+vCv0hBS6Au1Ujzuo+aPTk21Iw9mIRPhsR+tYc/lFTOgVTUbuSTWmjggOdwe6cBxRkOI9DZgWHqmjbM9QcTqldT1sabTKkQF0lA4y+Q/OnLcfCa7WzyvH7C3OcXtz+CtaXC32vGtE+DTwcM2irDBvqSzy6JbNNkwMqiS3zjQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T9n+jTXc; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7353779b10dso197380a34.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681744; x=1750286544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2fS10WGm/NgAzKDhSHbfRTkjHM/qI8657OmZeiqRck=;
        b=T9n+jTXcEsbIbxrgNXAgQAan91lWehGN8Ly7GaU/44Jx1avduZhbWuiLXr3BQZ8Gsu
         QWjVvfM6On/3XcMhKnUkwmjVvDLA7A3aGy6VMHG1ljydZkljjXkF8E+fHit9fmGxHMvM
         ZNj7DfU7NMdFqMrSOMedX6AeXJAJ/BG5u990ihME4kjoPnD3Ar0RqI9sI3MZm8hujgsS
         EurNtTk8F15dNZQB9fNAiLzcv3P3JJNbYD15BTo9einOQclkNzS+AK8FkIuoqELQMd1+
         L22DzuEdMp2aG8evpKmxoznc7bZU9WZl9M/YRnN7Eq6U4AUFz1J2jX3c7Y6jHpH0kij8
         9Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681744; x=1750286544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2fS10WGm/NgAzKDhSHbfRTkjHM/qI8657OmZeiqRck=;
        b=YA4B8Tg8lbffI9Wa9Y9zexDgZP9oGsFcPwv/yswKL3dMpJtRlQqToVTF1uG08Nlxcc
         ZO7XdOZN7pVBvX7yoHcSqO7hkIDEWSW44KxZnokOQ43OhauA9zdotj4WtnddLRkQnq0/
         TJFHQsFmRH3ETLZcaNzt7PnwwYVXlIe5rDEK7+qxAi1gwppqy+w0ZxMPn2ScfINNLYVR
         jvMvXIdhpx2DPXje4KG3MaDJk1BNdNF9fDdkn4Tx5TEOVDo6LmCcBnG5fouESsp0Ws4o
         MktQFivVUzWYI4l6n3JtWuBM2ALwkJeMkt42YbQ4PsmXy9dsmbqryEqRBFOKamEVmvIk
         4ugg==
X-Gm-Message-State: AOJu0Yzc5jmfXIeFGj1+sM3DBPQ5akDSke7mCAWE1hahWrwzTIgmOIU9
	aMefH0wkHw78xfQSJ0fpajY7Cm/t+2ScXG/Ls6JiEFBIgZ29MILQyN6Yg+UgYh7hk3E=
X-Gm-Gg: ASbGnctTHCPvtCLAda0jf4LbVej4wdqiG2bZZ9bRzcaAkQvPp4mM4ODEi9IEw9fORik
	W1h/4nmOj49X+mvluwwxNGiNGMcHujwYj+09B3Q82d+Z3Z14hwmo1KW8vUDyhg8+G4xPYZnumDP
	2wDHEpBrIfgr5ZhkkxEz9OQL/8ouppILUaxug+sf2z9Gpw/byKCjNZZ0fp1NR9Feb0ezWPUyCQm
	jZ0QjgSWBGZFa5bzrehaOnmt6ZgrjGgFrjePFl27RJZ2LoGM4sD5O5mYf+mdtEEu8lRefD1wPRU
	Iq620Mbth72p8dt6PGkJoiC79PZFeqzd3wqy+Pt6Q4FnBCD5PxvxLUgHImPz1lX4QQHW
X-Google-Smtp-Source: AGHT+IFjlERueVRup/Jao17hhnugkq7j+GiRg2h8bJth2v9G/6rcI2wGbyBF567ki5XFEPby/lqVcQ==
X-Received: by 2002:a05:6808:1782:b0:40a:54f8:2cac with SMTP id 5614622812f47-40a5d171b8fmr3897834b6e.37.1749681743953;
        Wed, 11 Jun 2025 15:42:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:38:56 -0500
Subject: [PATCH 04/28] iio: adc: mt6360-adc: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-4-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=16CSBjTW3ADRr7MOYui8jO+Mhn4wtu5HebYIEym4zkw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgWdyp6TsgG9grzVt7c+wkMZGk5rY+tH83VPR
 hAY0b/nO7aJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoFnQAKCRDCzCAB/wGP
 wAQzB/9cinMYWAun9atmE8CTlRWjiF0B5MbkKSL06PlW5jHOfBbJnzoPpdU6t7b9ozExAUWagaM
 8JTlmB5ashMocc15UKPD4atXkaW+KR5WfIj1opieHDVgHgx5tmd+cF37qZ/nJC5bxm35Lt9TO9w
 SohEdmnhmSCLTGxX7ALcqjT+7vJ4mo1HUfReJvrXjzj1tz2LJzp5fNpa87BbHN8CzI4Xr7C2l86
 5jlpdI0UeHhGJxVurKzbrYb5jJijAbCw9gASQDR1HQ1jLcq7YXokcMk1qBSn3TLhRCg/3PlePTR
 TZtSE5eAx5o9+zFV8pz3++L/hWjP87mrPrk4KNrXiw1r2Lln
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/mt6360-adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index f8e98b6fa7e923c6b73bedf9ca1c466e7a9c3c47..69b3569c90e5b665e1d2c59621df00d6142fbe9c 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -264,10 +264,9 @@ static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
 	struct {
 		u16 values[MT6360_CHAN_MAX];
 		aligned_s64 timestamp;
-	} data;
+	} data = { };
 	int i = 0, bit, val, ret;
 
-	memset(&data, 0, sizeof(data));
 	iio_for_each_active_channel(indio_dev, bit) {
 		ret = mt6360_adc_read_channel(mad, bit, &val);
 		if (ret < 0) {

-- 
2.43.0


