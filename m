Return-Path: <linux-iio+bounces-23125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B657FB30CFA
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD411CE46E8
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 03:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FD727F736;
	Fri, 22 Aug 2025 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHDFpstA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01B27CB21;
	Fri, 22 Aug 2025 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834692; cv=none; b=AOd1LcRnPtlUzL6GaV9dDI2ZC5SvDMyqIaQNDsS8qwVYP46uQA6+OGUn4XGXcHjo6SFRuuqef1H8Fw68AzEyDdYIkNLr/vWAtw8CT4XcQV2re2TD+4pwZc8ZFPDR8MPajf322RRFHsz4pgno2tR/5RyAsoK8gXgnAZ3QaXosT9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834692; c=relaxed/simple;
	bh=E1V6sSqy5U5ix2vZ9xw2GcRNF44acNubcMe6cIl813U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQYU0oECQBP3Z9zN5ERen0QJcrO22VuKeqquBuTjbSavd7ViAJemleY+5p0ccssUT1Jq0Y8XX5l46/QtOh0cKEzbvSwNNTYKz0r9dUSmwM8uM2V5j5o9xH4ygtM0xjAog2KefNXqi578txgLYUJ4fhFH3d/u4mkv6aiduO105J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHDFpstA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3252c3b048cso44159a91.2;
        Thu, 21 Aug 2025 20:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755834690; x=1756439490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ic1RSwaMXXzlWjrwYqAcZq1BU5xUJqmqIIBPYXlasM=;
        b=bHDFpstA2/ulmTseWova0V2vdqW7xhvrIZXyLPUqp/9cFDkP4lYW3zN5WUVtgiLVCT
         kqySJ/ZMtEf8pyVNDIVSlx2rxitJhJOQ+Xmbi6Snjd212ULISmM3Nd+5TVwOesz7FDyP
         +ArkeGGJI414xmDnDzjtuzH6d42lUipTrW8sNAz3RJQWWTXxT7hkj/SWokeYsAda2Dnb
         etGqa7gTNY4Wkasc8vvttn+MhZSuE9m0IXQ6laQOBHmB5osFfoZBmPy+YCY+ONx7vu3u
         ijvMMZtwiT3ryRqrwbKK1WTl+v/gV7XkPtnx63QSkpXYQ1VObDXS4F9wGmQITyLKDqcv
         mJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755834690; x=1756439490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ic1RSwaMXXzlWjrwYqAcZq1BU5xUJqmqIIBPYXlasM=;
        b=vlXWHzPjethdOt4B1haWUJNACttb7l3gMBTERgV3kWQUlWFJUn/EtiGO/w7WP6I+4D
         sBjtI6zHr9MeCHT/HVb3XEyBTFwtAKvevA9OcKLEmEGfbn8qc2OmbnONY0dp9VQWguZm
         WpEPr8MI0hVmsvGW3Cx59HDKHiNvoR269pnkHr5rA/UuAJwRCA8SrDuZFN83mSDcWq4j
         oVf4xVE3e2m1ZDwI1eHKSsG+LroMhVEwTjag0CbnGFS6191iJbwQNuwQijeRVAOCXuzE
         VuDGUWGP/vgKmCsxQzvYvrtI9QIF4IQIWC/vb3oCGH3btw65j9vLG8n5H7pIOHi3aHhO
         SslQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4JwFkTac1Qllk77oTG342nfApxWDS8EkQvv7q+/tcgmDbTVamZ4MCHJizsIxaO5LW9HTtW7YlKFXuMQw=@vger.kernel.org, AJvYcCWMmuAuqmv55kS80C+5FAMvQoIAS+YY8SbNRVefzVyTXzWiT8bYZxKgUhPPwUp23o9YGwO5mhn5+Nv5PFIiDx2H2Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+mKllMQI5LO++AofZXG00bylYubx1mOooXRhpgFbuFzy8Ot9
	RwSyA5SIXI0hyKMhRw4/LK6XttsAVQCJWnphqYF8IJwq2Z0BQxbYAazH
X-Gm-Gg: ASbGncvms0HaKbfBmuedNRomupK+adITHVYXT3bg4T3/zqH+OMXiqZ2cy5R9gX/oSgd
	kJWt+RYk8B86dvoBV/m9ajK51JRiBa9XkXqkqOt5mIJVzCiBOiKwhU3miAtfZjS1ecfNhvg/Utn
	IWNIE79OZ4lr759U0/CWzY3QPxPCpBD07Cicd/AExBRKudZf70Q7Zv42DwZNMWICHrDkc0A8Rig
	W24EuK841PufCGM7YD8uO4ynl2dC6DprJJZviPPhVTyyL5MMzsFVRzNSyvB89CSEu1QR84CbQgO
	4qxPNdm/4oKiaynrFy2for8YCXg0X4fTp4tbNVY90tfQ3S2vYECu6UmXIEoGeCzpHalQQA1WEHY
	EffnabHCTZNQoMdyr6LIRbiF4c+uz
X-Google-Smtp-Source: AGHT+IHazmWMn5flz3tUaLeTbaWTObNzUqMBMWJOszgRw6Z/ukldWbaL+PRp8cadzUHNkyL/sZ9JwA==
X-Received: by 2002:a17:90b:3905:b0:323:7e80:881a with SMTP id 98e67ed59e1d1-32518b82606mr2312355a91.37.1755834689799;
        Thu, 21 Aug 2025 20:51:29 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:807:34f9:502:b902:b409])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdb1sm9449656b3a.27.2025.08.21.20.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:51:29 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 09:19:55 +0530
Subject: [PATCH 07/10] iio: potentiostat: Drop unnecessary -ENOMEM messages
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-enomam_logs-v1-7-db87f2974552@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755834598; l=902;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=E1V6sSqy5U5ix2vZ9xw2GcRNF44acNubcMe6cIl813U=;
 b=aWuPdlGcfJX5HdaU6dQ4HYX84kcudR6WWXh2AU7VNH88OlFqJsDl+0zRF36EXeUVuuUYIi8ni
 WpnWGOqUnKCBWTnDisswIM4TkMfukTERrC0n2E6vcvNG0UpfSGUKNEb
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The drivers do not require their own error messages for error
-ENOMEM, memory allocation failures. So remove the dev_err
messages from the probe().

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 030498d0b763..eccc2a34358f 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -321,10 +321,8 @@ static int lmp91000_probe(struct i2c_client *client)
 	data->trig = devm_iio_trigger_alloc(dev, "%s-mux%d",
 					    indio_dev->name,
 					    iio_device_id(indio_dev));
-	if (!data->trig) {
-		dev_err(dev, "cannot allocate iio trigger.\n");
+	if (!data->trig)
 		return -ENOMEM;
-	}
 
 	init_completion(&data->completion);
 

-- 
2.43.0


