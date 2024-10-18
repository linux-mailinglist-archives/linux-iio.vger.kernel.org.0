Return-Path: <linux-iio+bounces-10749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2136F9A4914
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 23:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236F31C21B53
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 21:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D6418FC9F;
	Fri, 18 Oct 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q50Sb5CG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79918C332
	for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287895; cv=none; b=iPNxpC58cZSgWkefj/eXbsnB0voKpQWD5qvcOvVQTqh9hB6E/uG86H+wjm33o76ZhJOLbNBZfkhJJV+CZAgF5wAIo5nklRkUvbVaLe3QsNBbFlBX0WC86DiT9OydhW0wBTo23+ui1MvtW8qn5IGPAftK5franKwDq7CCvfoVQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287895; c=relaxed/simple;
	bh=jyy7JLmQxl6wTRjl8UqryYDQaj/jxSGqUmhT8PipY8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JqE6OR9yvyp4glHQjHLafxTk38t72Rs4kjd12bgYTNt8dOEGLg9fBqsOkYASFcyMgsI4lHManJTo1HbXWndJO1gF8LAVUUY7+cRT9qgZAT5ZIptkMtzTL/Tx6cmNf7M9wds3LcJiMcummvbUjIjHOeZVVdujrJh2z02rWtuWoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q50Sb5CG; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2891055c448so1146372fac.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729287891; x=1729892691; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMqjAyuym8kO0S6P2ejY/kfmYTx2+tMdub+GPF3mz6k=;
        b=Q50Sb5CGl3ra0YsHbSTYgNxcEqQQxxS473+lpJuZN5D+cWhNdckHAOi+8aN5Z3GWZv
         4W4cY7wCKqGrLeMgm3FbGoMGBWoKVSQt4VKgdymScJrLEp46AxtQaczK5cEtE6A6fUrm
         jfEOkgYoHalQrE1vyZwfVsj0CsWxfHrj+HbJRJSTlrLPV6hnkGMlD2Jvss3XC3FhQ09A
         M1QSn9d3C7KBg97R1IMAHGcFtQ+nnmU7jJxrR6GksekDvEjjbAFouB2/201sOkIHXHxY
         +3bj+rpyqolHuahU7+xAiPFqmLIqbs8xKnuk7oBVkGBRJq4OQ0WQxDoxxtQAp/S6pfas
         UfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287891; x=1729892691;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FMqjAyuym8kO0S6P2ejY/kfmYTx2+tMdub+GPF3mz6k=;
        b=Qc/NLxcEDroKOodQvu1lcANWa4NMnqMO+K0NXccz+FjRos0d+CU2bHoGazhq3qtgfd
         lcR0J9b5TK1eA6HTiFez8W5RyNz8kB7oZpwSQ4TadLx39OMMLg/NyHIfNGxZ5OUwvZdw
         KN0vPsve+6H1btcRs7slHFG/AJb/gWR4aEsMjopUg3QVcWuoaHffwUTMLVkOsLFYoQ4M
         QolZ2glddPNXo9NsrxZes4Kq5bdmV+JSed/AzTX71oCDg1sQUfPTRoSFK2JgVZpDc2s1
         Ck5znzGWj7EGcT4qAqrplCidsYJhTBmgORcTJ+ZYuvBxelf92ZdOmJrTdq19ENayVPCa
         hPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYpIhLOuzdPnPRiQisCHTxkSjnU0nO6Yq89aGqQTBd0j3genK+CXJ1E02yO1Hz1NeD/9Yra/Uhj6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzysjxTM20UWmuSRNORxa+VdcfmowFNimQMQU26/piQ5yUqaM2y
	GxALY0EOWMN7OKNNiCM5vlodcKGRSQALkVrGxBiD+mV1b6+CkEdD2hSQzQdE90w=
X-Google-Smtp-Source: AGHT+IFdjwx8P1K2RS/2aLojqgswehswGxjnO25URnODR+tpiphndgig0nezfBUqe5Ek19Hf1Azm9g==
X-Received: by 2002:a05:6870:b487:b0:288:33d1:a95e with SMTP id 586e51a60fabf-2892c528028mr3869783fac.30.1729287890836;
        Fri, 18 Oct 2024 14:44:50 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2892ad2e6e8sm691388fac.18.2024.10.18.14.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:44:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Oct 2024 16:44:48 -0500
Subject: [PATCH] iio: dac: ad8460: add SPI device match table
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-iio-dac-ad8460-add-spi-match-table-v1-1-84a5f903bf50@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAM/WEmcC/x2NQQqEMAwAvyI5G0itFNeviIfYxDWwq9KKLIh/3
 +JpmMvMBVmTaYa+uiDpadm2tYirK4gLr29Fk+LQUNM6ch2abSgckaVrAxUI5t3wy0dc8ODpo/i
 iIOJDnMh7KKE96Wy/ZzKM9/0HkmvVZXQAAAA=
To: Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add SPI device match table for ADI AD8460 DAC. As described in [1], this
is required for the module to automatically load, even when using DT.

[1]: https://lore.kernel.org/all/20210921192149.50740-1-broonie@kernel.org/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad8460.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
index dc8c76ba573d..ded442d4060d 100644
--- a/drivers/iio/dac/ad8460.c
+++ b/drivers/iio/dac/ad8460.c
@@ -929,12 +929,19 @@ static const struct of_device_id ad8460_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ad8460_of_match);
 
+static const struct spi_device_id ad8460_spi_match[] = {
+	{ .name = "ad8460" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad8460_spi_match);
+
 static struct spi_driver ad8460_driver = {
 	.driver = {
 		.name = "ad8460",
 		.of_match_table = ad8460_of_match,
 	},
 	.probe = ad8460_probe,
+	.id_table = ad8460_spi_match,
 };
 module_spi_driver(ad8460_driver);
 

---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241018-iio-dac-ad8460-add-spi-match-table-906dd36cb033

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


