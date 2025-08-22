Return-Path: <linux-iio+bounces-23127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C690CB30D01
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4A516D4E8
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 03:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981E286893;
	Fri, 22 Aug 2025 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSnQN/IP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B181A01BF;
	Fri, 22 Aug 2025 03:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834714; cv=none; b=FldGoKdGk55N8enhxEhRGmwnvgxTB5zv1nQ60qTE1ZYpUWZonAWF0PnstT3VZQclZGo/TjGp/VZNjmyefR7rVdOwPPh1qpIdaBLgt56OlBh54y+msSdllZb14UmrG0f4Gor//HqWVX3aX85OIOTwZkRtxViqYYxoj9u/ltkvp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834714; c=relaxed/simple;
	bh=o0kHbqFpyBP/mgTiX4N/QGk9oAOztYPO8grzmPdvqrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2C/8tiW/udCHsI0Rw9pz8IRXc6MDHstY4RGUc+XewmJLRSx1HKPeeH77IcF5E+CsrFuUGLLrK8zC0tZrq2bn99imKJo7ZTfC/H6+m4elKjWTrFWi0SV1eqN7enSP9/NNerpQZb8uI8xv2ufLEQppNCMz/qdyFTcoaghDO8Ev38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSnQN/IP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1658271b3a.1;
        Thu, 21 Aug 2025 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834713; x=1756439513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtaId0UEXdWNlODSrBbRe1UfW9oq1uGtqK7BQmJdRjE=;
        b=hSnQN/IPuaSzS3/RStIF4fZSQd6S78+GatppZaZTxd0DWA1Ff4jnmPU9UAo0pE9qVF
         dqZtHcp3fabB6sirlSTdBHYD2egtz0V2RO6nJzjJKw4nb2LqwP7ZWQi0m0Xo7jnq9jFw
         EbOFH9PzXK0tAJPDsLGZ265dEdQ00NUrE6KWj7IsoM4hkZDJ+ZmEbssDp3y8weqkqRyS
         Ig3mvSIy8ZYr9TkAwOXeM2twEkSEx0eeXyAczDWkQqE/1XEEw+BEp2eV9ZFJmDgNG4gr
         PK+SVuTohtYlRoqKp1hc2LCJzV+6EAZqSuOhc6mfjfhY93xbXCcje+iKIriB0WBkQuIh
         od2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834713; x=1756439513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtaId0UEXdWNlODSrBbRe1UfW9oq1uGtqK7BQmJdRjE=;
        b=P+ztMm+z/PHiRsPQX4cDTl3DVN2Ak3uwlOMXnxLyw9ei6y593bm1VTANwW5MXuqc0C
         vyFCyYq2PEQWdA0WzLLIS6PNMtDT5lJk/cvIQEbasMxOPspp/aBqvHkyyXQDxxaIgrPd
         Wwja31bNwXuu4I3NaCfNKq6qJdT166JDkqKhqZqBC3TzMqBsYGmJCZTFTOfK/PnfjSf3
         ECpqOws1UaWS0koahrQTeW29CNZP9TaWcLdi1vwWW3Ae8v6O/r7yYZrssPIDfKOGAhly
         9k0DQ2Q5tmi+dxmV32xCCRNwRlyXAK7N3rrxk6LL9MgvElUWTQYayE7XO/LbM0rYux2b
         Eaeg==
X-Forwarded-Encrypted: i=1; AJvYcCU6OcrepjeIJ30X7fekOfUAFaxLqEFAlKEwzyIoCmk7PAM+3pMiELyOQfYt1NPmv9RS8Rd5EwFbMmYmCSc=@vger.kernel.org, AJvYcCUSKZNkAPtU2YqTL4kGN/tzYOJycubXU4vEdlNA+kxnx2y7IhEAIqZgU/vQvqnHLw9hUpgaq6UKLqE7nyA/0+G/0UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2yL/63xnITqENZVlTmODZmM3QfHSOGMP36mmWKEtts0pbzOvx
	HSs4P7uAEurrKANE54PWTySHxwq+u7Cyh0R7mnD4ULvJYfaQu/vN7c95
X-Gm-Gg: ASbGnctYUGGZyKX734hj5qKdDdXjRbupFFtJks2IHi5BVVe0SldGv3VovcmMs4Y7SJQ
	6toi7scF82qRwUWat4KaE7w44ueeLdgwmnyrILZtWxrPka66yI13L+ibP51hIvQZYZhuKaoscvf
	VEhjhSi3B8Jo4iZKNjsvKxD9a6lENnbnY485oqn0tNyGUJmyR6rkRp50OF6Zgo3bwYCcRtfvV67
	GcPPnszN31RiRtnoqTsxyxlIesk7fpoij7SD0BbcPyU6qJWK4YaEcwr181Vp1Nu+Fm5Mezw3lC8
	U7d6xK/gqrtBGnH9zIgYEROHwUSnTBuekybUYd1c6EQ30LGQHjp1WBepe5jJStPitHVXsKDZg7b
	pr69430/KLJm6mps7Sfe6AjVw6Ux1
X-Google-Smtp-Source: AGHT+IHEL8ONsqgS7iIxwqRUVPY9B8jnNtZgB3rknZG4iSaMdkOlahK3+51EyJoqDE0SH8cv7geg1Q==
X-Received: by 2002:aa7:8889:0:b0:748:e289:6bc with SMTP id d2e1a72fcca58-7703051195bmr1992722b3a.1.1755834712769;
        Thu, 21 Aug 2025 20:51:52 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdb1sm9449656b3a.27.2025.08.21.20.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:51:52 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 09:19:57 +0530
Subject: [PATCH 09/10] iio: proximity: Drop unnecessary -ENOMEM messages
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-enomam_logs-v1-9-db87f2974552@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755834598; l=1421;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=o0kHbqFpyBP/mgTiX4N/QGk9oAOztYPO8grzmPdvqrY=;
 b=Q8J70rA64x5Wx/SDVM/m1/65rdR7MZeOH79krewJg9gKcpihiqbOP8UjztiODzFgeo32vIohz
 JBzgUFPJRTDAPYbuF7xQHLIOA4XuPnb93j9EvkSJSHk3SkSO6mnz926
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The drivers do not require their own error messages for error
-ENOMEM, memory allocation failures. So remove the dev_err
messages from the probe().

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/proximity/ping.c  | 4 +---
 drivers/iio/proximity/srf04.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
index c5b4e1378b7d..e3487094d7be 100644
--- a/drivers/iio/proximity/ping.c
+++ b/drivers/iio/proximity/ping.c
@@ -280,10 +280,8 @@ static int ping_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(struct ping_data));
-	if (!indio_dev) {
-		dev_err(dev, "failed to allocate IIO device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->dev = dev;
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index b059bac1078b..f9d32f9aba1f 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -253,10 +253,8 @@ static int srf04_probe(struct platform_device *pdev)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(struct srf04_data));
-	if (!indio_dev) {
-		dev_err(dev, "failed to allocate IIO device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->dev = dev;

-- 
2.43.0


