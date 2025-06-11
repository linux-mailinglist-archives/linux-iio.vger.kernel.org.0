Return-Path: <linux-iio+bounces-20498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F17AAD62C7
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CC73A989C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26525487A;
	Wed, 11 Jun 2025 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r3/L42ZP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FA25A2CF
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681753; cv=none; b=EwPpkUyouyY0KiyQL8jOLoqbXq9m5p3rY6Ue7YHjcmr8h4V/MJXPtU4ZunkPnCCsxGxEaF2JMOSsrVe0Hv5c6ArY4o0Z8jySWFe8aWd6FoNfQy3PO5Lqe0I3BNsTS1cCMlJ6Al5UqOnoy9pyEvPfb/8qEFQR+a4+7ToUEV990yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681753; c=relaxed/simple;
	bh=+7ef0opXHNBN2h0b3NWv84zYFhgTKH377f2j3if5pfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eg6jZHjplvHrQRWwQnXWveEuyJG15YUW1OSU3q36truSt3Jk2zNRs7n3HVCb69dghfl/NsqZ2HivdXXN9L9sSR+IitOVLBy1JHpG7XqHZtf04pplXmAU4mhxJ4nBPJbV+gU9oADLJa+cAYalB0jWQk933lRWCwVss8YH+WC98Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r3/L42ZP; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-408d7e2b040so190007b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681751; x=1750286551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPyCAeDwGaZFGchY0PBly99ut+lLVqj8mqClvHcxWU8=;
        b=r3/L42ZPdZz7qIpwDBSYgyZejpKfKSwmaeWq7TZUt7RW8IlBAbHRp0Erf06/C9iV9l
         ZxZilq6zlPIaIL54AjACXImYwmQfuBSOTkIn4gn4Ej16TK9iR1A9e1BMebAQn6mqeHu7
         yjEjKJt93u1VFxgAUpzxJHfN6pckZFIVp2p4BbdqNEe/7XVqow30LyjSCvSVqNxG02Mz
         ZqJe24SsEqz2NYwIpg13gBCqTtUFvohSmV0DPpo+OHrIDsHSBCtVy/UNCGSTPtvb0Gg7
         tvcHW0J8WqMVQXu5HTA6jkqtqlptQmeGC5gvCXsEcgwVO9n7vPcxpCYoPjYBQq/9fvTd
         5RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681751; x=1750286551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPyCAeDwGaZFGchY0PBly99ut+lLVqj8mqClvHcxWU8=;
        b=M7EL/Bj2epseAy8nPrpzW3nuqzp1VN+asOwyXYMVRripUMNTCHPjR/lKTVwujFC5OX
         6x7T0G8/nhB9bV5bcux0y2QZcfdkbI8xV43oIQZbBn98OXZW6ncq38Nq1Y6NWKnoM5no
         SyVrPbgPhKwloS1ViAOXbu4hOn0LQIidOCDZaXx3aBmZG7VAnZ5uyicWQYcg/X+cbEr1
         HnffSy3ieyzteSMYHwAyy2bh8rW6l+S8btKgd0PH+mkG1itSAu+H2GWC03y1n49izBVu
         EeKTmk2nnvozr3oBP4RdgEqM59uqOugHXplJ/U/JaPnc7XTRwfrmw445oxKi+zaTaGYP
         t4CQ==
X-Gm-Message-State: AOJu0YzOshrmxQRbCs1VHpyO0CAkT70zahNR+XRTTB0nwrQcw8POuVkG
	+4JMC3dvpjQPkQ+xty2I2UgBm2K4z4Mj+xifAihYOBjDZCfxXm3Y74g0UYpK8uo1PhQ=
X-Gm-Gg: ASbGnct0OqoyIO1ir5NDWa/7R7NKjFd1Q6Ak6ew3LIuY8I4CBRnAN5XgJHILBwpINya
	vQwt8mV9F8DqN4lEzqtQ2jru4Xs0R3JXwa2PLqDLfr+C14AvH4wkkfnfftdeaby3eV8dAg5JjVF
	r8MH6VJn7Y4VuQ+W4mTbV8F1XaHKfmTxrvu/TTU7ZSOdhKe8LEZJ23xN6QaGJVNqMuEGdiUf/Oc
	q4HGtlzNWYZIKd/3xWF5Ifjxvr6mqTwC+nX8tNeTL34CMa9yLaM0zRIPLeYBgzug/eW42p31qrO
	n+KF0DYeX/D/7Ciej4MKHWqPcC4u5rPedbxieUCvYmZ1a8zhYcbgVb71jJ8vvQOzU0yD
X-Google-Smtp-Source: AGHT+IGnJ7SCSrcoLGGDHLkeFWZl+xwmv56WaGassXNMfNwjd3I20gGItGHx1iX1x1Me2SDAPUpVcQ==
X-Received: by 2002:a05:6808:178d:b0:403:3370:4768 with SMTP id 5614622812f47-40a5d05539amr3930457b6e.5.1749681750679;
        Wed, 11 Jun 2025 15:42:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:38:59 -0500
Subject: [PATCH 07/28] iio: adc: stm32-adc: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-7-ebb2d0a24302@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=+7ef0opXHNBN2h0b3NWv84zYFhgTKH377f2j3if5pfQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgWyAR0/NtALS5gQgsb6D+CiSxnqwsX+WEtuq
 AOohtpPO9eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoFsgAKCRDCzCAB/wGP
 wDuGB/sHqLC2qkSS1PGNPlHGddzhPG/h6E+AJRBdBcDq5LES75oaDoNUp8YYjpUZ8xdWx6xXph9
 6s27b8H4wFgEqsmBhgTYtnLCeP9M5musN7+TAkf6nypK2UmTcK9fbVKTFJjTfgqDI2SlJXIgEQF
 9wZZHbHDOUxdLYBXmkPZKrjV+dIg1MvgLe+f0trGAuiVHPzEXT+jESYp6Bg8UvB9t0QQkNYXnP3
 hOfcMmO/eFMS/iKbzKKpfSQde3C42a5c/GPyzIqCLxiEhPIjQobMVq3UgCav5l44eRb1PJ9V2KC
 m6/9HkniYjZKtQ4qPcJc73pexbQoq3dz03m+kTljc/9Bt9Mw
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/stm32-adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index e84babf433853977b77aa283025f446353510a21..588c69e175f5129030eef9ebfe0eabb6412b1893 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2470,7 +2470,7 @@ static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
 static int stm32_adc_dma_request(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
-	struct dma_slave_config config;
+	struct dma_slave_config config = { };
 	int ret;
 
 	adc->dma_chan = dma_request_chan(dev, "rx");
@@ -2494,7 +2494,6 @@ static int stm32_adc_dma_request(struct device *dev, struct iio_dev *indio_dev)
 	}
 
 	/* Configure DMA channel to read data register */
-	memset(&config, 0, sizeof(config));
 	config.src_addr = (dma_addr_t)adc->common->phys_base;
 	config.src_addr += adc->offset + adc->cfg->regs->dr;
 	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;

-- 
2.43.0


