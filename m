Return-Path: <linux-iio+bounces-23126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ABBB30CFD
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF816078E3
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 03:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB2526D4F9;
	Fri, 22 Aug 2025 03:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH0jI5Zg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947B221739;
	Fri, 22 Aug 2025 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834703; cv=none; b=QB74UrpnIsrf4twIpScC7Ddp7y1+/Yk51Jux09KgWIh/m9ylisvLyuzANaHB4lZeSkcydmJg567kXzbsQ9dhdqL4hE6IuKJEICphFQrHMYEaIoUqDD3B+uBcA0UfKzwvoNro+XrKsQINDdeDkMmlTj6/JhtjxfeIZiSDWdrChE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834703; c=relaxed/simple;
	bh=9sYG9bHos7xB9NTLNoGx74dL9X517YjRrTR6gyjXoAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJShV1+nCXniNDw1ua6AuhRq1izA2Uta2gLewH9WJkpfRditK6RXSuZhRwjFfu/8QeKbkX7xw8VZDiVc1XbsVwBdN3bD26aOIbqjrBnBKZQgFUIcwUBtLVQV8KMu/QQwQg77Ker+kLZsD8LWgAbsmckd7hUVR92K8P2M7u8FVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IH0jI5Zg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77031d4638bso201467b3a.1;
        Thu, 21 Aug 2025 20:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834701; x=1756439501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EixXrQYznjJW/63oKtisPH5UyKT6tWjQS1Ri3VBxh8=;
        b=IH0jI5ZgXq5If1ZPf3kbLyFDyUeHmt5BWq7nJE1KcLSGk5FdA884kI5BbugxS+PgaL
         cUDsohXy8ISV70ArN1OWPODCWYB8Rl7FG2GwDGqibrWpWP4pBKpXC1pfj9v4B2XJAC66
         n0iYdLyhLlZTqdC7H0OC9BQSCKBj4uEGC8RFMwBE6Fzqflu9D43YVnHmgMDl1l7rUwQt
         TApyvUrY0FEdcPwag9l8yPR4aN9K6DOnMCYGF/jekLuzqjZXDyrB1uxHRvrtCjGwSjnC
         hgEpw1gvSnFbFZ0sogD47uiHA9I0EduC5m4lBVpt4vrNtwaGET5pGNfyO6iroeuU0ZSM
         mFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834701; x=1756439501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EixXrQYznjJW/63oKtisPH5UyKT6tWjQS1Ri3VBxh8=;
        b=njH5tjrHGajtqoYcWptMeV8LVPSOE2stUvKgSp1gAUm8Fha0Mp5J5cLBk+SRlVT344
         2R1cO9XdVGmQfNt3bvzDqK73gL1nVqn0hOUdmaOUi/ZC0M3xCSZDnNNclu4jiLkSfg+P
         rpttrzny5sQTuyCz+OkWWOnWQegNA0yJoBCMJGokklbNCIX03MENLFvX2njs3wWlY+bw
         ykVILnKuQGaS3WtWZiP++rujXrb8JtC3FuCMJq7S2KgTVbGLRH1w+kFpd4nzmYGViOs7
         Y9wSKFD3ME5k2Fcbr01l98yvZ55tZI7vaBsNFnZ8EXvIBl/JjNoFGV+xRoem36sqpVx9
         rR/A==
X-Forwarded-Encrypted: i=1; AJvYcCXDApniW0CLbLDgrB/g4LQp9R+yFO+uP8r0rfrqfto4ayjM7DwLuDmmRw2WOv+fKQun7Bdl/Yb0Wmzw7a8=@vger.kernel.org, AJvYcCXVWHdzvTnQLniI38yO85Mo8sSGe5w86ukzkOpluRzII1LayQEJ2CpzUolN8tBjhYbUwm1aBCYjPBulikMgWUwWePA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUWeBnMoKWwEZNKS2j+Gn8S9cFih1P2fliD9WQdMjXOwzgzJg
	cJx7KTP7jgvafoAQYVL5bj/Iee9USEjMd/YJB0YNkr26VR1ir0PJ53tf
X-Gm-Gg: ASbGncvI0iguB0rCMDwFWU1IBnxYu+qs5sgBrykJKF2DSZpBsgyJCpWgFBZUUH5ZZSw
	fzxkacND9o7wB0QJ6MakblYu3aduHurISYSoY+1UsC/YK0ZrTPla21t668hUnjX/jxSHfZQrzpi
	aHVltSd4G8RCZb9nArzEUIkycEuVqXMZh5U234GCLJR2MCfYEzhr4NlwYUoMon4f82gRo10HK4F
	yiYZH7QRGnbuFZXfujN7rqT1DEQd0OyhMMqzv9Pl3RjL/FjG3iCPTbi/QHBTqVe5cqsi5uNJvTz
	Afi1dfpIbHXaB6E/R9jt0lbfiIlpMnl9ltWAxPlcHGjiz8KH+SVgBp5P4DQWhCkGYj61fQtJBpL
	wT6NmyxJYhLA59ebaBfrx9ZIAyIh+
X-Google-Smtp-Source: AGHT+IGmG2iHm+kPtdB8VyZNf1Keeivo0b/Ddo4YxYKdTXfFyokHg1nQnJSsPhPXXQhViC7G78ZoCQ==
X-Received: by 2002:a05:6a00:2288:b0:770:3064:78fa with SMTP id d2e1a72fcca58-77030647984mr1909008b3a.2.1755834701233;
        Thu, 21 Aug 2025 20:51:41 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdb1sm9449656b3a.27.2025.08.21.20.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:51:40 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 09:19:56 +0530
Subject: [PATCH 08/10] iio: pressure: Drop unnecessary -ENOMEM messages
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-enomam_logs-v1-8-db87f2974552@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755834598; l=834;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=9sYG9bHos7xB9NTLNoGx74dL9X517YjRrTR6gyjXoAQ=;
 b=NI1M2YGG1OwJpwbLAJnJ6Qnit+GivyUJswFcnSjAyT2MnVw5sTWxxCLJoS3GZsCiajAbZFUyc
 84hThunItQmAHPZ5dwKUdMNC8vDzpzBO3EbM2n4xQrC+R98ypIPo+hY
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The drivers do not require their own error messages for error
-ENOMEM, memory allocation failures. So remove the dev_err
messages from the probe().

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/pressure/dlhl60d.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 48afe5c94000..c5f4f5efaef8 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -294,10 +294,8 @@ static int dlh_probe(struct i2c_client *client)
 	}
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
-	if (!indio_dev) {
-		dev_err(&client->dev, "failed to allocate iio device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	i2c_set_clientdata(client, indio_dev);
 

-- 
2.43.0


