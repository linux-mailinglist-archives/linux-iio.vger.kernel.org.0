Return-Path: <linux-iio+bounces-23128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19DBB30D06
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D60C1CE45AE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 03:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA52836A3;
	Fri, 22 Aug 2025 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUG2E8sq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFB26F2AE;
	Fri, 22 Aug 2025 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834724; cv=none; b=Aj0JvJs6lmDgFMzPw+JnaYod5jzEz2q2BGFwY1kDTxMhmqwDtO9gQrud9lVKbwNttp69TenhxANqcHXe06Lo4QiutK8iQKgfzyrUfosVvC73VXqH1+4dH12n0S4a30i9Cx4hOx6/eVME8r7lU6wzuT/Ccnf5po4hRTNgz+AJLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834724; c=relaxed/simple;
	bh=/52vRgIJUjMO/j9jQkvKz+7tt80vmSfVQHF7sXmO88g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nVYy2Ro71pzi6cjVvg//0yw34h7aNDTsHiY2WO5K8nMGByNKVO2CkOEDrnkh9PUzV3c6T+bEm0sF+czdsbNyhcS8sAdFukWb/le2d9NxZogLR0NMRzm4uxt1E8550/nhpMeLSGi83Blg+Bca27pN6qQUaiFsbxk/xu4tH18ZLtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUG2E8sq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1658334b3a.1;
        Thu, 21 Aug 2025 20:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834723; x=1756439523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49sb8pd+Y6b5PW3M0gBrDMMusN8J4nmn5BPMHLBEa5M=;
        b=jUG2E8sq4yvqus9MQ2DPaMDwB3xfMDTbfbTm0ttuQJ3UOJ6Ls3OadS/A1w46UCRQk0
         wKAbI5hgqAyOxRMzz4SITZQj8O93WmE0c8E0fWlrqlR0UiXV3lO1ybNS0UrpkRrujoU7
         vtmWOGLvBCr0XKdsbgU44+TR2VkzQ15TIWX42kj5nzFCRCoP5C9uM1hdENLsht+eoiWE
         MSQ9ulH1T56cnP7tFVbtN5ToB5eckZTdFqJ+r9/XgOC3bCHoNtkJCJgM0NsWF1Ik7oCr
         gsKdhV30QUbCG/klHhX9z2KSEzbP+S5zrdDS5s2m+19+wg/YT0ALOdcjq/bKIPEzTTpG
         U4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834723; x=1756439523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49sb8pd+Y6b5PW3M0gBrDMMusN8J4nmn5BPMHLBEa5M=;
        b=HPxJ59xTeUrdUcJk+370C8fEx7h07g1Mwak9ydnB2uLhpqxqdk6tvMREAumTndExKG
         0D03ZG9XiE4S/NghTxq4MzAknpzHi6zvMMvgPAcUhJ5h2xX0lZdbIvqGIznYUzv0d/r2
         bFY5EY1nPDmSvsnwT3sEJTab1p0HPLnBqAqiKoL2dftMvyPA/8EkcdG4D2OYZXsdNIyH
         RLdXjwF68qdpl8XcYS1QE41URSlvqomIKaJ6gmATr8R5b127mE1jw1R8MdFFgOF1SQav
         jKagOKIzA88rr+7qTu1PaVmCME1D3fOwnLIaS40dRLWlB7MraxMaDmPsLQ2Ac/wpcjz7
         CqYA==
X-Forwarded-Encrypted: i=1; AJvYcCUhxnR6Y6jtJQ2JwPQQGurWSSs+/tOe3+SBVCBj2u6L3c3fsWiYdphWrATQRb1UQS1q1QJkcboI9Bvi7BQ=@vger.kernel.org, AJvYcCXK/js/c22Xk3/x0m+RU9DDFe8LLLwMG4FLVQqeaiufgT9NnArJhvFuuPKwCvw5Ba0XRA9ObvCUaojaWlaNqeDIV/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL+CBFr2AsY0T7e+CVefqr8scf0gd14p/AYu10O8q4rRnHn8KJ
	rrby2LxObqAqlg2Te3jkn1sYgFumnHl2HxkX/z6aMFYom6esqaNpPwYG
X-Gm-Gg: ASbGnctipYocj9QjKIddJx+fXaQ66wsZDPNlpEDQjrEVTYRLF4oROSAhS8uQ8ZrznG1
	H/iR0FQXzLAAPJNj9EY0Yw3277VuaIAyYUCfIx+8s2vyvGW930c3/0uF3Hzk20zOY6aOti5ChQW
	yZDt2X5dgGSjHSOHf+XzI9ls4T7jQCmVmPq9hfYc/FF2rIFmHWbZYXcd7uZBZDnxj7z5u6JC951
	4m73rLKDbx2asdOQmLGjDGFDi9756sLa6P8lNh/HFPD6n8wNIni7ZdqiHUgNQ/QzeurwR9fMwBY
	GVN/nHTzErH17nsPBpo5S4nCE6EFW70oEeTWOPF7Mq/rgi2FevJkEC8IFLF8BbN+UEOvVQxzs9F
	oVGmtAK37v/WfprUGuBhETUSZrk7f
X-Google-Smtp-Source: AGHT+IE/XZWblGeCYZs22CUnDKwXULfC+6SOqnh7RXjuAgW/Urgwc5sc12Db+DpiqPeiba2SievDcA==
X-Received: by 2002:a05:6a00:1742:b0:76e:99fc:db91 with SMTP id d2e1a72fcca58-770305105c8mr1796426b3a.3.1755834722669;
        Thu, 21 Aug 2025 20:52:02 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdb1sm9449656b3a.27.2025.08.21.20.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:52:02 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 09:19:58 +0530
Subject: [PATCH 10/10] iio: temperature: Drop unnecessary -ENOMEM messages
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-enomam_logs-v1-10-db87f2974552@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755834598; l=910;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=/52vRgIJUjMO/j9jQkvKz+7tt80vmSfVQHF7sXmO88g=;
 b=aO9X2tBzsuRCvTKvElyomG3RIlmdjR2h4cNhhqfgx56wssi9qwsbgRVsLxnMuUkDukkoN2haD
 KMTw66khfeTCy0kwjT6Jv3/dYxro2mv3JCJumcVZAKzBT0O80Sr5yzs
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The drivers do not require their own error messages for error
-ENOMEM, memory allocation failures. So remove the dev_err
messages from the probe().

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/temperature/mlx90632.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index ae4ea587e7f9..c4bf5dc2f266 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -1178,10 +1178,8 @@ static int mlx90632_probe(struct i2c_client *client)
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90632));
-	if (!indio_dev) {
-		dev_err(&client->dev, "Failed to allocate device\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	regmap = devm_regmap_init_i2c(client, &mlx90632_regmap);
 	if (IS_ERR(regmap)) {

-- 
2.43.0


