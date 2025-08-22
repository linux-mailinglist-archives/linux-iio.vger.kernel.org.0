Return-Path: <linux-iio+bounces-23124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0241B30CF8
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F1D1CE493B
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 03:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E926D4CE;
	Fri, 22 Aug 2025 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ+ZaWlN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDD1A01BF;
	Fri, 22 Aug 2025 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834683; cv=none; b=N4mb/zTv/6QDRNaw8CdhRgX/Vgm5LchG4+GnbLrhXxxSnTd1ySOBzJlTfMYnhdj8X/BIOLrJ95i21jVWQJUNLOKKdBekFYbN7iKt3l4NjwMDBdHVHMzcg7BVy0LQVaVB3RwCI/bZYx5+yV98msmQqlFaWC0DH2QrnL9qtGsBgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834683; c=relaxed/simple;
	bh=pH5Ai2hUrCDisN8BOZgbmkwzCO0ZlcGH3OL3twprr98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2HVFdXRi/LinVIWee5tsW2T0iO46tEyIoW1XO6WtCytgeTBrhbj6TQ8N3YQ8doRnQ7PbwjC7C9xV3vQ2S6jeu0pWm1Yc4S8CmKPA1l5z6lAXkooD1UWMNWlT6Y+UQf+Lqt+fkhzQy0b34lV1UdJE6xuyQvt4NwlfgsFvNlNDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ+ZaWlN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e09f58so1939966a91.2;
        Thu, 21 Aug 2025 20:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834680; x=1756439480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=np6SZ5B7upvOBORmSoVmVjKcF6KBdFBAeJOHZZ+4P0U=;
        b=iQ+ZaWlNwZGlZZjr+GQ+sYPi1eeE4ypGJk3XNqj/1lBEbIVuX2V1GDHreuRQ0yslqt
         SLji+M4IvPwbBDtfvPYJRRcgK3nzJnjPICt9z01ZnlZdksoKX4EYe+WOpm9gYCvJ1ORK
         BnjrUSY6B6rLOp1PeEWRReS4GZcPjKUsUMlDLsSyLhnfFGuRVs5wYpxr9ICMI1IWY29E
         6snLhCsS8aQhFXBaHdRLlkQJ/K57kxlCjJrKp2txHR8vEpszxx2wnJhyX7kcJwoMSnmY
         ABLZN4j/vJ2ebUW52nyGc3BkjuvkXMMrzBpqJPjqzpokhJk4y7tI5SZ2hJapmSyB1W8j
         2A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834680; x=1756439480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np6SZ5B7upvOBORmSoVmVjKcF6KBdFBAeJOHZZ+4P0U=;
        b=YtrRis7lyvnnpeeVhBv2DYUDnyxyAxvzb/UnIbXvJ645yVG/i8MLDdT9kDDgYlQA9S
         zxaW4wVLx1QIMLCqV2xLVaa9mBuN41hUstxFc4eLwu1Q2BLFX8j1brjn2hmWkkVDqxmP
         ZjOE9W3rIrUPQY2Uqt7zTW9z+kX30AmLTiMFdHpVT6HA8bKuTzeAK/R6agn65FnsWhb1
         RmL2HxJ4yH+tfA/YBtWo9Dch0/v9PLbwINr9irCwzt8C0UKDG4MyyzuzWu1VSmj5RVUy
         e/0tfX/+g6OU1lmy+548HH+RLRpmcUHjGk/8ncY3chPgKQf/zsSIxZQN0DQ02ZqW3nJu
         MBSg==
X-Forwarded-Encrypted: i=1; AJvYcCVVZr8KLqiLXWyTY4PPkMNa79heAarpCCzi3zdY157TFDMx1xlqk7nfIq6Qb+OvJSaUvIPjkyEeFQVYVG3W8pEdIEw=@vger.kernel.org, AJvYcCWRPtFWu4MgdNLPtk9WGoW+/FzRaNra56S1zjD5sZ4mvve+BWru70LfUeJxrIqWBkl0rKWGwmjwqvLEwr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/sYNQMqdzfDe4A8f1XZLzkqjbswghAUM8VObhvMSvdFVLbNM
	5NDi1ocxNJsx3kuOg2Zbbhq4hD0WMuZ5dOBLW5ybQ+6BViFLqCi/u0Xm
X-Gm-Gg: ASbGncv71977fn9oDqhsdfPhkBxKJnOBySOlB/b/RSS6XVzcX/3qxbKVpDyIwwkiltq
	jqkDP6miUCEVRdzT9ivKqUi+5yFiXfggTAtFJdvF+7NEUg5QQoYAL8tN8M/YUprwUspQdDgQnox
	yDEwS5uol49EYx2nJwZA7Gsml5qGEurm99dMCKpJF+PkKa64a22Yervo/a80rv0aeonDFqwwAvs
	EZuFx74oKpviVbD3I9g4kJU5AEkiMtmQFYSLGakJp6FUfQdXBkTH96+f+S/k35QizE+1BJ4wNMf
	eWq3jJNm6bCCOVY22FQxag9rCgx7shiPRmNJjyOanDQTglwqdykTQfj3r3iEaLHry6Y16WxI8JX
	rhyHLH3pzxOnd6b16U2unoFNd7HL1
X-Google-Smtp-Source: AGHT+IF0W1wMk0TjpqOG5yWpDYSHE+kGycH9vB3pAPEZix8kJbdhTkbj67P4mBR5VUeKZQKxuFXy/Q==
X-Received: by 2002:a17:90b:2f47:b0:31e:cc6b:320f with SMTP id 98e67ed59e1d1-32515ee3cf2mr2179359a91.5.1755834679733;
        Thu, 21 Aug 2025 20:51:19 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdb1sm9449656b3a.27.2025.08.21.20.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:51:19 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 09:19:54 +0530
Subject: [PATCH 06/10] iio: light: Drop unnecessary -ENOMEM messages
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-enomam_logs-v1-6-db87f2974552@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755834598; l=855;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=pH5Ai2hUrCDisN8BOZgbmkwzCO0ZlcGH3OL3twprr98=;
 b=Y4ggOYOq64L6yz5Aop13NAzu+enc9eQG0wtQN7sAaQGY/CtYvE7KKRmnVjQ/LyhlGnFPJNk+s
 4PGO2+PkJQrCiL+ev9sp3RlbFbdj4x77C3RhVe0TX59MpA67qjAQTzb
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The drivers do not require their own error messages for error
-ENOMEM, memory allocation failures. So remove the dev_err
messages from the probe().

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/light/stk3310.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index deada9ba4748..c7ccf58e52d7 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -609,10 +609,8 @@ static int stk3310_probe(struct i2c_client *client)
 	struct stk3310_data *data;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed!\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	data = iio_priv(indio_dev);
 	data->client = client;

-- 
2.43.0


