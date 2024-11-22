Return-Path: <linux-iio+bounces-12486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE19D5E2F
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 12:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1CFB2108B
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0121DE4C3;
	Fri, 22 Nov 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qu6C+tfe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A91DE2D2
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275248; cv=none; b=rNqIU1ZtJjdO3No6lUqfgO7h8g9u6m4f2DqGgW6Go48UULJ8vYRrRgnqoioahw/ADyzOctmy5i5SUVeZjgPGtTZDMWn/L60jdYOTUOHZ1JVJIZZbjrZ/blSizBcu/CL47AJ3jbW/xDVZLe03RG4kb2Im9UJxJJnmU6Rko/+eW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275248; c=relaxed/simple;
	bh=Fwu9pQaKK4bs27HnVW7THTQBGwD2l8i0eSmDYU2vXCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5/zk3zUQr4cdfEyES5gczvU2LjLLI2yXqZI6Z/TPQlriBDpeeKH+839MfZIT0kChn66ls45KhM3PctwQq1MKEAiNkGwzDnK+5ilLO3g1iEXZYd2S/Sa4vM8xQRa0gm7gyF9wrV0G7RQewpe4mZ/fdgD5oOJ6taENXR6gm0pjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qu6C+tfe; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53dd8eb55c4so351500e87.3
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 03:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732275244; x=1732880044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpgNB9SWivbZpiMjps5KlWBpMotrye0qsJeGvBEzXWI=;
        b=qu6C+tfet0aqvhpbY2YuBHE1wgt7vUxcoRkgEI+zTI7Zqm7nn/Sly4dCl7YAcWJW3k
         AbqN3fSKlKlhpY+jgXeMhZK2zKNTbYTAtasjoBdWWnblmGwtHd3kKHTsPo/doMB2kT6p
         G7Ky+bW014wnP34lZxwNJLSNrXkHmLyt9CDGbfzoT0eiVo+8/eIHzwD1VtnS9QpgFb2L
         DAXPxJ2Cg0RYtjbNe09Dv/++va6s1Ip5jWsZR0v5Riu8zNyUwkqmQzsTK3WFDAMJp9Py
         0rDRd54HrKd1Cdv5kUkMHqV6P9XjNagjDid+uVFZALnbFW3BRsWnZna2FnhYw1PkecYm
         qGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275244; x=1732880044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpgNB9SWivbZpiMjps5KlWBpMotrye0qsJeGvBEzXWI=;
        b=ZSKHYIKYprFDWSmc3GCH66GuTeZzuD8Jsx80dSQdtyUdIFfyR2pE2FnCG0dx7VRmYC
         hiZRAQlXdmghB2iFs8Z6fNO/Bf3fJV9LffYqsoI8C80E/1KLhp8vjJyeshPnp2ACkAqC
         iAOa8Dv9iK6LP2Gmrs4Ce6B6Oa58ugmshS8PEMRO0wbQsWaZWNjetu+KRwzSpLhw5SyT
         sLbPnlVgpUB9/e4rGUkCtrZ+x+LPWKAzPEG9nDQq/gmScfl4vMcNVm/FmmVx24UZXm2Z
         FvbKSMDWBo9LtXArEs6Eb/SbruR9HsxtwZdzlmK/8VA6iLsLrH9c4ZRWD7H8OBZY3e0X
         8ffA==
X-Forwarded-Encrypted: i=1; AJvYcCX15RJIu83X5ikR/qOYzglMjMkR5Q2BXP9bS35L65lOwLcjHPDgFSU+oDBNt1LO6Zq23KJJhEqfWU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5zoRQFDnOdBKEvidCLF0gLKYnDu4XBnn/MSneTud6AuWF8iK
	Ddbrm+vX3fnLs3dlv/SD8Bf0Ko/cGHKMfrOKwJF2fniNLgOMpczwT9wpFEqXHec=
X-Gm-Gg: ASbGncu9AbRbJvs8Y66sqCEe/5lXMYYBc+KvkhmWMOcBjzUjoWuBuft6fo3h6lUeu5F
	yS/i0/si1TSXGS/y+I/c4izNQMUoxXBrxBOf/ylHGorRXIX94GnmLHdeng/QCYsyS/nvvE3yjgU
	Wc8uFoSkzNeF9DzqnyDGAm+c88KKGhmb3CaJRA/hl18RCHnievRlm5O+gJcywmEEB3fy2DjmXwI
	hVN4RUFy0ZQGHfBbrJoziV6dUNMBlWgfbqM+DQ2vHnyelPIcjG3kJkQB7jzXigpfByveGjGrU+/
	mV4=
X-Google-Smtp-Source: AGHT+IGY4KL3gCdwtgcr2ARFmOwxE6aZ74yS1b6Efv6OiNkTxvo9zl48r2AjcV4V65Rv+zVV1h8AXQ==
X-Received: by 2002:a05:6512:130e:b0:539:8d2c:c01c with SMTP id 2adb3069b0e04-53dd39b56a2mr1338934e87.41.1732275243991;
        Fri, 22 Nov 2024 03:34:03 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3531sm2196400f8f.80.2024.11.22.03.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:34:03 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 05/10] iio: adc: ad_sigma_delta: Handle CS assertion as intended in ad_sd_read_reg_raw()
Date: Fri, 22 Nov 2024 12:33:24 +0100
Message-ID: <20241122113322.242875-17-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=Fwu9pQaKK4bs27HnVW7THTQBGwD2l8i0eSmDYU2vXCo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnQGwP+uX3MtJEWS+RfPimNiqvazuzBpl/Y/8il dAOidMUjOCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0BsDwAKCRCPgPtYfRL+ TtQeCACfyQe6khjGWPIs1NVzkex84kRh0k98KqeDcKOtxhCaZH9NuGYdsMLcAbk9ZqX6bPkvO5m bXHALbVMq1mIo8nyfqd3FXsnNOgAstiP27UHFEoZYoX8delxVGSXFpu9wrXDNN6P/ckZbgIngHy fm5nhBvhEYYaH4ZaFGmVzxQ5MrXQL9I/mBlJQZCuJSqn8cuWM0+2gmrkHPEkeBgQxeF42CYU9Rk Ge5koPf9IR1VdKGlTxomJy2Zl3cawmaHIMJkxEaAl/Gz8vTlY7IdP/aUikBK9nssZn6iTncyAcb Cm60Ob3X+v++8+50hE/as31pef+RAyTSP1Aw5mGy+6D/i/BT
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When struct ad_sigma_delta::keep_cs_asserted was introduced only
register writing was adapted to honor this new flag. Also respect it
when reading a register.

Fixes: df1d80aee963 ("iio: ad_sigma_delta: Properly handle SPI bus locking vs CS assertion")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 4c8d986b6609..5e7e5cb908d8 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -109,7 +109,7 @@ static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 		}, {
 			.rx_buf = val,
 			.len = size,
-			.cs_change = sigma_delta->bus_locked,
+			.cs_change = sigma_delta->keep_cs_asserted,
 		},
 	};
 	struct spi_message m;
-- 
2.45.2


