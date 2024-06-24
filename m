Return-Path: <linux-iio+bounces-6850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1498915839
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 22:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CCB281584
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 20:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C01A08C4;
	Mon, 24 Jun 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n6qn97SK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817449643
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261996; cv=none; b=Yxwncz8tNK43f/5gr8OYo6KcPJTtvaS0o2DUxdHE+HgQsz5HX0KfsWD7/MOzoLTilxqic87Gi0kKAOki/1pmpKGgCReVL02Gjv1CiY6Sz9B4VB77z9tKPdw39927644BnijGjPKPS8Pqs7qtw+8sX0xx28JLrKU0r2RElzRRnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261996; c=relaxed/simple;
	bh=upztjv25Pksc3Dz/iEL/7RhD28y3vLRW3nFh17Sqo3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqG9fBaa4uI6+c+dNN1nEUKbw4E3MmZdbZIoRlGoPkS/fKLBNUj9aJ3CqxMnxCUWuruiMM7YSMyJ0Vwa95ZN1qiwg5j6ZV5atAEITeLXpEgJ4vK/cX+bUkJ/aMDRNyeIGAnwLt/+SGZNez1pASWtz0/i/usF+0ZdTJ1scVxLIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n6qn97SK; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6fa0d077694so2269816a34.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719261993; x=1719866793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSBK3Ki9ZCk+SLUNlkl3PuQfRvemuJmKwUzbo0kI5l0=;
        b=n6qn97SKTihk2e7+h5ujpxfMJqsR5ZZVt04xjmnotua/Bn1POAKVOqw2dhQxeXMAfI
         xEDo1ZAt5DKD3VUIKfrfO1FWDEqSHfwRNmc8xSy6W8ZwE0BClqJMYTg+HKrDO2KQiyCR
         jbkM9CvxDC0GvMX7AGuCQvrR9XBmt8kkUfUtLxI7OA0DRWSaWen45gQTe7dJmV8U6RLe
         2VoQP5A/j3kb8I4N7WlHinuWzTvPaTLUt1Eu07UBgj2+PamCbFU/TwPDHvkyc4IIbTCJ
         SPpqQWL3jSt4VBPS+wLDTvrB8dqvv0bXZp7Lh11pzXx084jb8z/EdWzkRP8HVrdJ9TVK
         T4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261993; x=1719866793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSBK3Ki9ZCk+SLUNlkl3PuQfRvemuJmKwUzbo0kI5l0=;
        b=h8rPRX7Ayy8V9gxgCuPtF0tjHlAsX/e/4M6EMB7xstYEXQn9kWqG+5g+inuwDqROKr
         /IjB1fsF70kN8sDDFLZXiZp/YPhRimSlWQ6uZaKQtzuCXmKnBaQH1WYYmAJJECs1i9ih
         WU4NmUrtf76HmoO5HM6kCqfL0LkiPcEohaPeSG5ptVpYvUSxoxYWo/4jW5DP2WwlTCFT
         k/ZekjhwPIJ7KpsVpkiiSISWcPzSCLdJkYS22RpBeAL3sLEOEXZADfg7InG0iPPpMnmI
         HUDbjEMRe8s6EYKFKsuFgGpYNPCS97f2lvx95saOoSWrui/WUA0sFO0I/HRFPZMtE06n
         aTYA==
X-Forwarded-Encrypted: i=1; AJvYcCVdow1NBiovHgfGxmawoI4ULgLGS7Buhllpe6NRlTwARX68ulrocUsfmN/hgzuVErkZDy38LVBwSJUJ6qMsb5l1o1Sxlx0bmLuU
X-Gm-Message-State: AOJu0YxxTHjgq8j34oqM+rJvE3usLzgap65iJpVxZM6H65VvDvT/OZQK
	A8vA+zw2IX5uoyr2oQR1FMkuADl9Y8AoSlikbTREEimgUIzXAMEhN6qiLHDrl/Y=
X-Google-Smtp-Source: AGHT+IEwgOwFrf9DOHaWD2v90KNE+gUgBapBNCTryATgRwothFHnMrTK/MjIW3m5Lu9aBAxgAfhr3A==
X-Received: by 2002:a05:6870:2d5:b0:259:8321:243b with SMTP id 586e51a60fabf-25d06cc56aemr6137152fac.24.1719261993625;
        Mon, 24 Jun 2024 13:46:33 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4c106dbsm2092849fac.58.2024.06.24.13.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:46:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 1/2] spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
Date: Mon, 24 Jun 2024 15:46:07 -0500
Message-ID: <20240624-devm_spi_optimize_message-v3-1-912138c27b66@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com>
References: <20240624-devm_spi_optimize_message-v3-0-912138c27b66@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

devm_spi_optimize_message() is a public function and needs
EXPORT_SYMBOL_GPL.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/linux-iio/20240624204424.6a91a5e4@jic23-huawei/
Fixes: d4a0055fdc22 ("spi: add devm_spi_optimize_message() helper")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3f953504244b..814d66fc9753 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4384,6 +4384,7 @@ int devm_spi_optimize_message(struct device *dev, struct spi_device *spi,
 
 	return devm_add_action_or_reset(dev, devm_spi_unoptimize_message, msg);
 }
+EXPORT_SYMBOL_GPL(devm_spi_optimize_message);
 
 /**
  * spi_async - asynchronous SPI transfer

-- 
2.45.2


