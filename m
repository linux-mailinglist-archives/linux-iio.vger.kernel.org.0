Return-Path: <linux-iio+bounces-22512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50128B1F9F5
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 14:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 492227A2E82
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506B92566F5;
	Sun, 10 Aug 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZYXEJBSq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3624DD0E
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754829219; cv=none; b=paFFgyGYkpXd4TPTU2hTkiqbnpdBbAYE3AZqOaeDsfdi9gLAEWlrsFYxGFwsbOtxJQlbs2fqeD8gsRUv9X2joCs+wtMkSPIjxfJOnQ0jqp+laaHRu98m4rs5CeKQbAo7KuGPn1xsJ7nc+kW4Knpj0zWgVWoTQ7ZJlvxCNDqN824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754829219; c=relaxed/simple;
	bh=71Zw6M2jWdmfIYc6s1O6BKdyVGRBVJ0JuCrqDmGLOrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCbA7f4bkW2iSqs3Ojvig6yA8gv0803vQsq7C6PhhXewc+SNspZQ1btAdv+D3+s4jvvFl0hSiyGZi5LEmAl4qFYMKHR/noIATiHX76LGkCPZEouiFpksbsu41WlXTj3lHHZ3qhPxSGUgVLkTHJrpgePcPezEm4k1OHJ6LNiYkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZYXEJBSq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af66f444488so506633766b.0
        for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754829216; x=1755434016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV/TDtPSqEo+5cYQ2J1jzlBNpBRLHkqgnRcU52xQyv4=;
        b=ZYXEJBSqA80sslOIrXCOU+y1HCZUKmtuhLBBHIAId4Ir1YtgwkbD1a6EODY+RRMxoQ
         YJL5FvLMC6faUauyIzTXdHqXAStRs/hn2x5WA6W1ssFBj6dMutleEa3eV78tAPr5KFA0
         Y7LK5VqjEM6MGeCkR1ThujRVS1TGmLSGPr7TTaioKnqdCtMBYtAddrsXjcpjD0JTvZ0G
         Rqu1ocd1b2IQqGKD+jtr2Eexqi+XZNL6LmbRmVlCwz1WpfZUInbsPK2FQA77F/RYPE1Z
         kk8W6gi+UChMISJdeHYgPYrWUO9qe5zpDTCAAf9sIxlNqaZAkjgmWp8D3iKdo2N3akno
         cMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754829216; x=1755434016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV/TDtPSqEo+5cYQ2J1jzlBNpBRLHkqgnRcU52xQyv4=;
        b=uux5nduofd24hio3xYX9OSl+RDdMdsnetRRxtpSj6VCBdFR5GjhPS5Nrzm927QeMBb
         Be/C22W5ZWrdmrQINH98aJAYcBSba+JfmMdkkNyCvDHYTnUWmCPAMBCk1a2f9X8Xg4P/
         EJLcg4v+rksC3dl5R0MmvWcduSRy12JCfT/oZr/CmgnZt8AmzufLCwyz73i2oKy4iPuw
         84m4jC/bCyWnh8MyyzQGXGrkWM4ZQctJqC0ACSOfKhnJrxvvpIpRb8wIZTz8bwCy/kTK
         ZZvOh0AdHNCv8sm7Wl/OJAIOkjSf4gsxwJliA1V0l4wAne9nilJ4kUg02xSLb2IAvcRe
         Ui/A==
X-Forwarded-Encrypted: i=1; AJvYcCVc/OpvjL5Qx+5PXERvgFzQDBBOC5xyFn4xwwNWmUmQrkxNEIXBgfLfxVAZQJPY05Do0lla6kyLliM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr975YP0s87EdHcn1G6oXMDV/S9RTfiEbk1PE55abQaym9sdYl
	Ork58daGnIsvNrIXzfy+IdBHFfr6MDZ7SPP644naANGrqQBkO+0asqKn/chn/4Pgav6wdF/KlKJ
	CGw69
X-Gm-Gg: ASbGncvbWRZfKnZ5Nt0r52AWkVX8/cu1H0KHkAi8V2KceFfKUbbW+DHo1D/YNz0RymI
	38Iy1qVaDmqNwHjJ1DzyI+wQ7jS1oqbGVEUyzYxHB0/7U2Zc0DfS1axiBvWQDNLtcWIz9XreSAS
	Z1ndjQ52x3eCBe6evix0HnoBIV83gwQhhB+rjAncrqE0wEuabNowP55vLCmptLAou4DCEkfSE7T
	94tttRmf75DEEge4zpYqMXfpZ1hbsesFEICT8DFX7j0JhZhWb7EDfyj0BzcU3FwkHSu3llSsCsB
	WYB/AhsQ+mVy/mowInOqbm58Y3JURRz4uKu4Ja9kYkDShttZXjSs4Sjww+7beA349IjGvkZqrlb
	+oQpphlrZmBxBCN0CP2KI2J7l8xqfUrYteFxO3IRV8p77UEg8RQMP9rxZJaWlFww=
X-Google-Smtp-Source: AGHT+IHQAKMYrFI+05pz7SbKlvMrNUdxOuLAR74amCZyX1EGKun0OSM/Q4gjT8wSLWIIGGUnBnwFMg==
X-Received: by 2002:a17:906:d542:b0:af9:1ee4:a30c with SMTP id a640c23a62f3a-af9c64d3cfbmr922368866b.36.1754829215779;
        Sun, 10 Aug 2025 05:33:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2437desm1852203366b.127.2025.08.10.05.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:33:35 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 2/2] iio: adc: rzg2l_adc: Set driver data before enabling runtime PM
Date: Sun, 10 Aug 2025 15:33:28 +0300
Message-ID: <20250810123328.800104-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

When stress-testing the system by repeatedly unbinding and binding the ADC
device in a loop, and the ADC is a supplier for another device (e.g., a
thermal hardware block that reads temperature through the ADC), it may
happen that the ADC device is runtime-resumed immediately after runtime PM
is enabled, triggered by its consumer. At this point, since drvdata is not
yet set and the driver's runtime PM callbacks rely on it, a crash can
occur. To avoid this, set drvdata just after it was allocated.

Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none; this patch is new

 drivers/iio/adc/rzg2l_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 0cb5a67fd497..cadb0446bc29 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -427,6 +427,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, indio_dev);
+
 	adc = iio_priv(indio_dev);
 
 	adc->hw_params = device_get_match_data(dev);
@@ -459,8 +461,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-- 
2.43.0


