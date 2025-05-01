Return-Path: <linux-iio+bounces-18928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF70AA5CEE
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 12:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7904A5CB8
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992E222D4F3;
	Thu,  1 May 2025 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqm3t0lT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D1A22D4E5;
	Thu,  1 May 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093708; cv=none; b=kkI0k0NqZHzJWIQu9H3jlMEa8DY8k2vIUepwUOGISfUI8y8koNZaBLCwFyY9EXMF0PN4wj6WZLKf5Emysiwooy7sRl6FPAHTEvgQXQ0aSQej+PMoFey0Dvf4jCsnSM6PuUDkMS5mU2DwQXjyDvEjqm74Jja5VTUjN8dHVWnFqHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093708; c=relaxed/simple;
	bh=fnjJRK7dKGNHwa+6im6+vrEvIGPmCZaYX5I73+ZQbYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UsQ1PSO4gf+Jg+nggddxy26rdnmJFjaSdRWBB/a6NdkQw+RQKAmgMxE8DTqAguw427ERt+WIZNH238QU9poSzijJeZcPvwvJv5U+K4FcmfEsWDQWVzsUUAiD8Isr9bMXyfrvkhw1bb081diXmanZF8iAAdVEPDLYlff/oA7skQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqm3t0lT; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b170c99aa49so481355a12.1;
        Thu, 01 May 2025 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746093706; x=1746698506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64OaKxqowdBU6Fw377DtS5LOQKwZbC0Ed3tdK/AAu2g=;
        b=Kqm3t0lTyOrHH2hmrxvjRdjPGWHISa3AqNZkK7/phCB1NJcRGr684qqqtnaRgvw68a
         LQAxsM8BprtrwikxjAEEaST5fzL8y7DjZIyUN18pUA2aq4cLkhBn11gbCq09S/WACGgi
         5buiN50U1sqzJqHlkSzpAztGMazrwIAJ/bqHxLprKH5iDoHKuSpQVP0sWZW33Xqwihwa
         okkIcNMm8zohPYCL9fz+Kh5hF8H3eOuAfO7J0+uBfGp6lPTgnTll8zPbPqvczBt1PST7
         iacJz9kx6KbL0bmDhehubBPype0QmNb59uj7RcpCBDM3y1UHhU1M4JV9qgYxXmYci8e+
         J9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746093706; x=1746698506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64OaKxqowdBU6Fw377DtS5LOQKwZbC0Ed3tdK/AAu2g=;
        b=mNdfNBnZkI+9xo4srlTeVMKe5ng+ZcHDUvhfyT+0yz+JqTiecW/bPToxVSHGsH2qAJ
         +NBBdEpbdBeWRFoB045863i5mjsp22aObWTb8SJp1cGs/9CdOxLdg+LIEp2nD8tZxmT0
         cXuHgxLCwrZ9tA6fxa5pgyG16J5m0QTy4fGycgicn+8kCUowIJ0SdHPcbhzlZstzIXSC
         x18fgEeKEoKF7XUUhAs/635hAwAWQwuEDcJ8f3QJ3ROr64+UtU7ltTfKVnLmXcgalHf3
         XT1zWFiTfm6OoLfn0G6r9ERYU6LNwfD8kWmQwDsUHZ8bILscLsMdLqAFpAqXb1yDK+jT
         wVGg==
X-Forwarded-Encrypted: i=1; AJvYcCUPVRONU6V4iw30HmOOslm9QSicc+/dAQUBuMCAc9KNDYkeI/Q4iCOfDJgK6aagoKlRA03CBajFvS5W@vger.kernel.org, AJvYcCXn5Fqelo+P+Tr+eVlSWdd8eJ26MobJAs32ust39xQzJPPRY/KBMYYUgT3CA6vO7zed+TD32FyfblTBepv5@vger.kernel.org
X-Gm-Message-State: AOJu0YzOr06YCzcgqTVIKESGkIn5wk9FZazh7sUaj7sciaadwcqIGTh2
	4uzpPKwsk6b8ztL32LegJ2kGl3O0/h2OTM0Hc6Z6tRNXVNws/oVdDzepbwPRbxw=
X-Gm-Gg: ASbGncvc80H/qeFdaJ8oDB7VAu/paBedViVLr2rQo0vlTs0ETUtOdsB1hN7E7Svag8o
	nvnkzhCii8CZ3WxTzWQOM/LGiAJJeycHM4P0s5iUk9Dw8EjftsHadh8kHyv8W+UTmerCyQtCYrX
	+XVVoB//XhdTeymciHmRtJGlKk9bMttoCuDOBhQnpdTCBputqpAPKMP0IbTOln6GyJxJ8KPYbGV
	VOUwUtlOKrb07Y6ZQFKiiuHLBTP48YEqjMaxNQ6wpuIZbBwjvDskqURs+3U2NjHQX/1LvwszQFF
	S0bTQLy3gpzoOQ8/J52DZd3agxPMxIjiUjyAbtHS7ktqr3sRTGQkhDpvXg==
X-Google-Smtp-Source: AGHT+IEwUzMN4VgYM9hj1LaWJ1cxE4doyeT0GVJ1Ly/tNx5vHTEHlFh8Y8cIwp4KvDsG5KS7tgKgqw==
X-Received: by 2002:a17:90a:da83:b0:305:2d27:7c9f with SMTP id 98e67ed59e1d1-30a3331eebbmr11229024a91.16.1746093705733;
        Thu, 01 May 2025 03:01:45 -0700 (PDT)
Received: from debian.domain.name ([2401:4900:1c45:13dc:af05:2012:1f6c:ed34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a47476120sm472477a91.13.2025.05.01.03.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 03:01:45 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-iio@vger.kernel.org
Cc: sayyad.abid16@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	olivier.moysan@foss.st.com,
	gstols@baylibre.com,
	tgamblin@baylibre.com,
	alisadariana@gmail.com,
	eblanc@baylibre.com,
	antoniu.miclaus@analog.com,
	andriy.shevchenko@linux.intel.com,
	stefan.popa@analog.com,
	ramona.gradinariu@analog.com,
	herve.codina@bootlin.com,
	tobias.sperling@softing.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] iio: adc: Kconfig: add Kconfig entry for TI ADS1262 driver
Date: Thu,  1 May 2025 15:30:40 +0530
Message-Id: <20250501100043.325423-3-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250501100043.325423-1-sayyad.abid16@gmail.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds the Kconfig option `CONFIG_TI_ADS1262` under the IIO ADC menu.
This allows users to select the TI ADS1262 driver for compilation
during kernel configuration.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/iio/adc/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6529df1a498c..f3f8a8cf5f89 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1542,6 +1542,18 @@ config TI_ADS1100
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1100.
 
+config TI_ADS1262
+	tristate "Texas Instruments ADS1262"
+	depends on SPI
+	select IIO_BUFFER
+	help
+	  If you say yes here you get support for Texas Instruments ADS1262
+	  32-bit precision ADC with programmable gain amplifier and internal
+	  voltage reference.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads1262.
+
 config TI_ADS1298
 	tristate "Texas Instruments ADS1298"
 	depends on SPI
-- 
2.39.5


