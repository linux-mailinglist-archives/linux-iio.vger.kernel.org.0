Return-Path: <linux-iio+bounces-8096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA1942EB8
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A566D1F277A2
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F5F1B0127;
	Wed, 31 Jul 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbaSTiXz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97D1AC428;
	Wed, 31 Jul 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429452; cv=none; b=tCmRGNQhyPC685HMDcCr7OCUyhyyw6RpcPFw0UHVbXUAmcRJL2NdOalNVTMkWOVkD1RWqvSkIPk9bHXoKPXf9968hV/ZizVbFpx+4yAO6Oeyiu2Nv9BeLQbhTBQdehjb69bQjdcchDoRVb9TpSgzc20cgazqhmHaw1N99f+IxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429452; c=relaxed/simple;
	bh=IDLxMQAziGWRT9o+BPx2alzRcIDpqU3lrCAQOaxKYqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgjY1CSCwbH/BmdMGiSxW2PAIYYYU6EybXwUQ9QiJKw1Q1Yt0ht3xqRSI5cZFUa4HP0/Ij4XYjYB8WQcqUQHizc0fSt+5lEcXbJUlxtk1RnTHESmZxwuwWcY95fHZLzfBEcqwGzZKhky/0kziTMS2jTSejvw06JJAp7rU6B9WTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbaSTiXz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42803bbf842so47251345e9.1;
        Wed, 31 Jul 2024 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722429449; x=1723034249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fs0NGjcaoyqSyOFGWGsNiT6fgwM5H3CXS/f87w8KQ3Q=;
        b=MbaSTiXzUP7/KNJiiH+FgvtKdEigX1OSwqLT82vF7GnPNEnHdhDi+9x5+y6ocA+Nz7
         AG21Q3vlPPwQXM0o7M1mY2mOgxSC1jTgaA7zOR2x0gV3U9LrK93tyxDRvdasAMCXR8ED
         cnNzExhNWdTJlIEmQ8AZyYsxeCsaPGOwVjJV1R7rR2tKE5hfORUa18oCAPt5NXr+cmfJ
         An4KnBpwbH75daEhsknzreZ1eazSpbrwSAKekUDCat02DaIP9aj8l/Kke11RYzLVgmjd
         pAagFHx28k1gzG40qZt7OdjkgYkwQap0beJR37S190doGmOZRn4/jLTViYoh+H8XyAXY
         /Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429449; x=1723034249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fs0NGjcaoyqSyOFGWGsNiT6fgwM5H3CXS/f87w8KQ3Q=;
        b=sgCBez1EwuEFy0irdxVSWrz0IlXQcujQsuEBfuMdBEwAHfdPllG0wz1l+vVZ/MfYFJ
         h/wrYGGXqSRfsBf6/uLSMGXwEIfqnomhNOfnVHKLJdcnYXzVMK+Sy5VXVmIL4yRF6S+L
         uf7VT/yMA/PLOK2x3SC+mpFF/m9ldufzDa3ut2EQiUVIeVMkbARhfGVSV0d+QCBgqsuY
         Bp+uSnMFjE/f4+R8ncVViY1LqDOlhQrcXTYakfhm9jvFxUw64L6JKfE0+W2yoyOogkRP
         p6ktWvaIM2tliPWaha5poBBpkpbEwxizwUm2mV4e3bJftlL89F6F92jaYJVtQy+tWbcA
         xMiA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2t0JAv1rzGo4xDo/exF/nUQswiAuWVjgOEBEwmgd86yzeDsniIkN9Qn86n6ekfnaCSSfeQWV9twijbiTuOQXpjFMFwE0U7NPN7LAXBtc23VA1JUNojGkB9Gfw4nNkROLwAXGsfiZ
X-Gm-Message-State: AOJu0Ywt7N/jBhSINe8FW6cV1VBePrdLZlHhyXWsCJb6uPUDXoFpKo/A
	5SUAfyGTxKcDdbAVCeWx5gLYcpNJFshw+7OPxeyzLWPe/CnLyQQIZZtmiMvDy6A=
X-Google-Smtp-Source: AGHT+IEknepjVVyNVqsJE7XlYUbb5dEK+cBAkF3rubSCnFg/8K8W91uYtddZ6ep7sxI3rI4IA7DpWQ==
X-Received: by 2002:a05:600c:4311:b0:428:111a:193 with SMTP id 5b1f17b1804b1-42811e0b9a7mr98270705e9.37.1722429448728;
        Wed, 31 Jul 2024 05:37:28 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64755sm20600465e9.36.2024.07.31.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:37:28 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Date: Wed, 31 Jul 2024 15:37:23 +0300
Subject: [PATCH 2/4] iio: adc: ad7124: fix config comparison
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-ad7124-fix-v1-2-46a76aa4b9be@analog.com>
References: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
In-Reply-To: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Stefan Popa <stefan.popa@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722429445; l=2214;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=IDLxMQAziGWRT9o+BPx2alzRcIDpqU3lrCAQOaxKYqg=;
 b=r2Tiqd5RKx0lTUK09pgnTP9nM67dNklhwhXN+iG0XME7bwL3j6OwUbAktTNgodNqtE0hcSVw0
 ycfOcwkzDikCo3g5Pxjg0lkzqQ085b2yq3x6EsbXzaryXRQcaO6eC02
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=

The ad7124_find_similar_live_cfg() computes the compare size by
substracting the address of the cfg struct from the address of the live
field. Because the live field is the first field in the struct, the
result is 0.

Also, the memcmp() call is made from the start of the cfg struct, which
includes the live and cfg_slot fields, which are not relevant for the
comparison.

Fix by grouping the relevant fields with struct_group() and use the
size of the group to compute the compare size; make the memcmp() call
from the address of the group.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7124.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 54d4c5597696..bd323c6bd756 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -147,15 +147,18 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	bool live;
 	unsigned int cfg_slot;
-	enum ad7124_ref_sel refsel;
-	bool bipolar;
-	bool buf_positive;
-	bool buf_negative;
-	unsigned int vref_mv;
-	unsigned int pga_bits;
-	unsigned int odr;
-	unsigned int odr_sel_bits;
-	unsigned int filter_type;
+	/* Following fields are used to compare equality. */
+	struct_group(config_props,
+		enum ad7124_ref_sel refsel;
+		bool bipolar;
+		bool buf_positive;
+		bool buf_negative;
+		unsigned int vref_mv;
+		unsigned int pga_bits;
+		unsigned int odr;
+		unsigned int odr_sel_bits;
+		unsigned int filter_type;
+	);
 };
 
 struct ad7124_channel {
@@ -334,11 +337,12 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = (u8 *)&cfg->live - (u8 *)cfg;
+	cmp_size = sizeof_field(struct ad7124_channel_config, config_props);
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
-		if (cfg_aux->live && !memcmp(cfg, cfg_aux, cmp_size))
+		if (cfg_aux->live &&
+		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
 			return cfg_aux;
 	}
 

-- 
2.43.0


