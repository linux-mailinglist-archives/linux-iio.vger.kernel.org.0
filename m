Return-Path: <linux-iio+bounces-23122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5F0B30CF1
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93BC1CE4598
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 03:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3339E2253FD;
	Fri, 22 Aug 2025 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFMur94L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67763221739;
	Fri, 22 Aug 2025 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834659; cv=none; b=SKFM+h20jjrM66U1uPqb/Ju0B9VTYFliY7iaL6Rh7WNS4ud4JLYz4F4NeZo+G7zKz/6QS83gsfAENSaSZcBxD9AdjGMcT3LfkLdWWy6wwiwA13dkybwy5PqDK4bqTnhetlKc+xAswtHCgd9WaB/oCOn91oKdueGUeKvoAkqVLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834659; c=relaxed/simple;
	bh=rO9VuR/oVVGoakCjeEjj+XT6+ebILUa0tyZFOkIL2Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YGoeMe+Xfre8hZVhvHx9g7tRAmOdXjYl7aIgd8vGliIlXvfeAFIZ5pfkQoJVaeoRhwK8L60jcX06ZTyNG06zsJ2eg8kcd/f5LnoxYzdRQjmGC5p0LTZdmAqudSLBVysUJSTq6gm2CDTwnZe5HRKFdNNyk69KtwKjOtPhXsXzGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFMur94L; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2eb9ae80so1765531b3a.3;
        Thu, 21 Aug 2025 20:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834657; x=1756439457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPzGBFBfr9XUbrPfoGwRs/BjXqUrZ2N1GqqaLsSssIw=;
        b=hFMur94LhULZb+gyWUHFHvzi3vKws/HNVQTIArmcgvVBJbOWto0VZQMDh5eQdxoyfg
         DBqf6UdSjgMh7xjitKNNAoLYX9cR0i+56T7Lvmmi7rn4HxGoaQS4RdWleWZYXrCNos2g
         5sePYuy2798/1Z8diaWmMBm/nfgIip3S7P/scxS8N2VFKyky6BYsduE4eOQEC1F6IXaf
         6+4P/e44PR1fUdrBpwD9iRFkz4QSVMONsrS/+Zdww9CNemsPCr/QwU85xqZTITEJDw0x
         fFxKltZJfNCgBCswbdxcqrOgPKqM3bQLWNZnBd1Lax6KnxtqBWjrAgUoae45fwJ8VaTV
         Zf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834657; x=1756439457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPzGBFBfr9XUbrPfoGwRs/BjXqUrZ2N1GqqaLsSssIw=;
        b=VXiYzmwBfMdEyGiKanv+vfqoWQKq2+rRpaU/iY/NQGKWsXagZxJGLO1SC6iiApyGB+
         bfywyHnqy2+pJRa7OYo4lWcj4oXQNkW3ifDj2I5NE24oJCwffFLKWJ6rCDm2BW6b7J8B
         rYl2XJMfbuoCdevjQoDh+m8znL3Hccv9RUrPuuXuiFCnwjaW6l0G1YSkbUCPL8HJeV9Q
         K4tg+FTv7V7+W3c0HrMwfrDwSakq2LzqMN6SXJRYwCKMueqaGlhFPY6beoNtOjOJM/B0
         AD4EtYpCW2tMAQDEDP2jzpIeW5/oWcv6ryZuFJX2zwgYf97thua1ybyeS7Vl/SUR/diD
         Ekng==
X-Forwarded-Encrypted: i=1; AJvYcCW7upXBfdj3W6uTFVSMQ/B7gV8eThXJCMStCulHNPIraZNl5MXbpS/OU9Cstby0OSC4++JaYPQXOW/L3SU=@vger.kernel.org, AJvYcCWz8m0Z7Y2odlUfuDzOxhPfvdqo11cAco9iSZGG+FBl1QH5a/XXkVWerZCPVGUiTKNs8WgCPmIpjK3gRXn0NutxaLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWbwkHsvtG9r6rZq1Hs9A48buMoQZIICeKyhO3+rYAQMiDI9V
	iebCq9vsiI6B/m0WtQk6MKpN0WzS6SKtS9RggHurLlPBj+7VCoOl8tLp
X-Gm-Gg: ASbGncsjXWlJGodrbB1Osr2GARQ3nHvGjDA5fCQJxHJaCFwulGHrsNaFBGQW2HtKl5n
	TtpkCvPEcCFG/0mai6kv7MFHqZenQrtBDEzZeARhmHxeSq6M1YhfVx4XlsvkqyqLI+Xxfr+oJNZ
	mibob7SXytFeE1mMyQElDAygfBPZ+OaYSXnNOMhFLj0ua8FfoiGBopdFW3sw3t4zMEu0Ke3kENF
	3JtwVbaF6JEhiCPUVY8iknf5pVsguJREYGL33oTuoPwhVwDEq4NO3xRCTSoR1wInWlU+Z9HOc7g
	0nnTv/InIWg9xfK8oF1LniBwsKBgGm+OMm9YcUAqcjgbk+qv3zLxk6Lxoe8kJ5wb2V9Z4zsJzd3
	85o0aByVQGgzAKkLZ8rvpAGX9lqZm
X-Google-Smtp-Source: AGHT+IEDplbG/6XF12lPxx9itIgjz12WwucZKRq9+cOsqGQDlvGhf+WNacIYrhLVVvaG53XeD5NjCg==
X-Received: by 2002:a05:6a00:8d4:b0:76e:7aee:35f3 with SMTP id d2e1a72fcca58-7702fc182a8mr2167240b3a.31.1755834656645;
        Thu, 21 Aug 2025 20:50:56 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdb1sm9449656b3a.27.2025.08.21.20.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:50:56 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 09:19:52 +0530
Subject: [PATCH 04/10] iio: health: Drop unnecessary -ENOMEM messages
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-enomam_logs-v1-4-db87f2974552@gmail.com>
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
In-Reply-To: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andreas Klinger <ak@it-klinger.de>, Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
 Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755834598; l=1430;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=rO9VuR/oVVGoakCjeEjj+XT6+ebILUa0tyZFOkIL2Qo=;
 b=4b2jPbSe8j92/XCjL6XXtT4A9XSafT+S4e6mVe2Kd2YIm/HD9yFiVI1p7o9NlKstS6ok8mzyx
 C9ICz5YdiGjAlatKIORLRTH1V1wdnZKz0xgwurThCEbeEno2qe589S6
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The drivers do not require their own error messages for error
-ENOMEM, memory allocation failures. So remove the dev_err
messages from the probe().

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/health/afe4403.c | 4 +---
 drivers/iio/health/afe4404.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 1582cfc03579..8e5db2235de0 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -531,10 +531,8 @@ static int afe4403_probe(struct spi_device *spi)
 						   "%s-dev%d",
 						   indio_dev->name,
 						   iio_device_id(indio_dev));
-		if (!afe->trig) {
-			dev_err(afe->dev, "Unable to allocate IIO trigger\n");
+		if (!afe->trig)
 			return -ENOMEM;
-		}
 
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 99ff68aed27c..11a0f465fd68 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -538,10 +538,8 @@ static int afe4404_probe(struct i2c_client *client)
 						   "%s-dev%d",
 						   indio_dev->name,
 						   iio_device_id(indio_dev));
-		if (!afe->trig) {
-			dev_err(afe->dev, "Unable to allocate IIO trigger\n");
+		if (!afe->trig)
 			return -ENOMEM;
-		}
 
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 

-- 
2.43.0


