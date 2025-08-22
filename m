Return-Path: <linux-iio+bounces-23123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3373EB30CF5
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347DC1CE45CB
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 03:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBF02253FD;
	Fri, 22 Aug 2025 03:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlAG2IiH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB11FECBA;
	Fri, 22 Aug 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834671; cv=none; b=kpkMZ4umNh62vtiVa5yqFqM5976RXFrd0BQoREyMRdE6l2Y/CG3xqie5VepJEfu3mxmmkio1GzBoivhdUZf2B65acTy9TGYDI3/QVDB63EorwuNoV2SzXQcQSbUcNBW2GU0iuoSufWo0lXxsw+jRohE26RXU1582pQ4vPa5dUw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834671; c=relaxed/simple;
	bh=c8hX9rvl6rr2dhjjNLkJgB0+zkmehac1mQEbRhCM7pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ofx+4s5lsh1Eo9rhm1BPjjOZXz/FPv4CZL0PD8G3gw78JKoIkqFQB0kNuU2nGsLNa7CAuXpngx6oQCSu1kBLta14lWBAGT4H81qJ7GSVQVt9pyEXv+PZ2WMOTziRv5ErsjhMTmMPUFQNZZMSPa9dsmhkJQRdFpBhU2y5cjiJjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlAG2IiH; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266b2368so1126124a91.0;
        Thu, 21 Aug 2025 20:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834669; x=1756439469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqrtxAz9cctGN9u8jlxCJdnxps3sEfbBI35+GThZJ5o=;
        b=MlAG2IiHPD8MSj+Lwl1GbSb0A5tiVmJjF/HBAZDO0WL34+XmRQL8AE8FhBTd8m/iRR
         DLrz8kJyMsRMvFF/bSsqTNMqHlLA2K9l4cQJYcbEyH+2x8wgeZ0ZAVf+OSVX8xAFwlYf
         AIRZBf1vpeNo391DOy3eueN73flv/XBul+hmY8otPCjWUQUNJVjndnZuuOZnfxo5+UXo
         gtaAI7TK+fKzhTLg10k1QhngRiv5LSo0wNB3sVHxDYw7BNtMWt4o110RHEQ0YEYU0gU5
         Am6VVhVCSLit2WF9f2CCZgBEn27C8YbrqfBsTXx1zKDb4QqCZIbwIRtXUNncN87RlAp8
         xzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834669; x=1756439469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqrtxAz9cctGN9u8jlxCJdnxps3sEfbBI35+GThZJ5o=;
        b=Q78PuAFxTJZo0o5DQE23XB2SGZ0Qdmt2qmsy4/6EJEdu/zWfhPFmUrnNMoqeP32CYh
         1CCCBQ2ArJHy8CtFI6xqjHFn7nfz7C7SBd0rtW8k/MTnNLSyK9a0aqzB4ih9cPD6svNK
         Pu2MMwQ8hVBAWOBqM0Zsmt5rLp7Akxe09j3nlv5P0/aMh4VoOsH4SoleErWKQr6mQLxg
         2PsI24WfJ3O5JnineIiuQSGpZaklAqXhEM1TACueJCjbO87WTHlk+RN2MKYHLyjzfdp5
         B8C/ot40Gt+0W+KFzlp4FAQh/n4g6z68Eh76lQdZ6vxOjgMvZwcrpMl78rmaq33gn1Oq
         id7g==
X-Forwarded-Encrypted: i=1; AJvYcCU/BUNNFYRYBACJpgeVxFy9ZEGVSthZIYlzdvTMDTL66TacCNhi2KnHDTS05yjTfrqPsz7Ua7MuI/ikxZH8XLxzCf4=@vger.kernel.org, AJvYcCV5fU80g12vnHXHKgIozAEdAn3ZnIhkkMYSJL+PkLSZHR7MdSfddgGduUtxX9O5EBQIHM2+KrxjYdCHtu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qtaO5dibllfJ+lziV6+ueyLf1TraYSrgU/4Nfa5LTtOdorbJ
	zEwelPBYSHBoTLruW2+ql5C1cIJ4KA+nuf17OMVmcVi56QfFpOyyDOAA
X-Gm-Gg: ASbGnctE/RMjrBOU1ChoafqZjB8de1dRtJphAlTP1nwFEgRZwxqPefducuSthBLoQhb
	2PnQyFs+nvmqDiADP+H8ErlNpfvhxF0937q5jSFFhKwwyx/7WnEtZYI5X4A06nyQ8eXFkMfVIsr
	yogVP4BCeWtZJ0mUvBpHZxg4Oq+rJLQ6z7hAjCteLNDpuxylA7JJT9Yb+UYeg4H9ysYOdha8nAG
	rgk8mdHUg7jUVDm+1lc819EXCkM0Sw6g4Y6P6OO1023Q6Nq3X26KVericyn24QmQUlZwWEs7P5s
	dfhjwrvsyNz+1CDbFZROhVNcZeauJ6CZrK4ubmVs98kEEOoqaWE0TtysXwJE8aXiTwyvttvRRmp
	NT00BT8bZ2DWHNuyJ5i7CO1cGWOGC
X-Google-Smtp-Source: AGHT+IFlyHvge1r2eEDywa691vO3EH8Zw57rYlejYo//N9dseDi4JFrUwk2dU+AEjPu1HGJfNaSDAg==
X-Received: by 2002:a17:90b:278b:b0:323:7e7f:b8f4 with SMTP id 98e67ed59e1d1-32518b80cfamr2288523a91.37.1755834669027;
        Thu, 21 Aug 2025 20:51:09 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdb1sm9449656b3a.27.2025.08.21.20.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:51:08 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 09:19:53 +0530
Subject: [PATCH 05/10] iio: humidity: Drop unnecessary -ENOMEM messages
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-enomam_logs-v1-5-db87f2974552@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755834598; l=1404;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=c8hX9rvl6rr2dhjjNLkJgB0+zkmehac1mQEbRhCM7pU=;
 b=ZgaeM24zC7IN3+he8TY2T9s8YSEkwL7SoNKuSaTSjAtLL/67LBM7qENhJcDRsU+1mIQixXTl8
 Ul2eMZUGNU4CG0gfDDCnLldXt5ixt1iTh4jFKaiKgitF507++7QKEdv
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The drivers do not require their own error messages for error
-ENOMEM, memory allocation failures. So remove the dev_err
messages from the probe().

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/humidity/am2315.c | 4 +---
 drivers/iio/humidity/dht11.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index f021c3e6d886..02ca23eb8991 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -224,10 +224,8 @@ static int am2315_probe(struct i2c_client *client)
 	struct am2315_data *data;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed!\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->client = client;
diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 48c59d09eea7..cc8f02f3b763 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -296,10 +296,8 @@ static int dht11_probe(struct platform_device *pdev)
 	struct iio_dev *iio;
 
 	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
-	if (!iio) {
-		dev_err(dev, "Failed to allocate IIO device\n");
+	if (!iio)
 		return -ENOMEM;
-	}
 
 	dht11 = iio_priv(iio);
 	dht11->dev = dev;

-- 
2.43.0


