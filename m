Return-Path: <linux-iio+bounces-20040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCBAC9189
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B18A3A7CFB
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BE3231835;
	Fri, 30 May 2025 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tF+bT+T0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB0231A51
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748615381; cv=none; b=PGeCzZwgRwaXTHopGT6LSwnFnh0c2h3ZIDcD1eHJjq76pcJp8o3QBW4ZA2HqjsshgBguuqO4rUznQxLe6Hm5TOm60YPJ0RfljwBwL4v5UN0TaPTSjwhuUQdFJL9KWL+kpdNjMAmf250Ob3EIbzhOsXhcHgDfNIVzY7MnMZnv16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748615381; c=relaxed/simple;
	bh=FrbTtGrivaT4Rj3CF57EXLkRqLyS9Vv1ydCdW8ZexzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UjfRddYFrVji9NcqnRR6ujo6wCxAlyCzh5EEySxsJu2qYstnYpa6o+CAR7dNmM8gigV4eggZNiIgDqX9XTbpFq7wz4Igln5/eI9sybZTg6M0EVG83IXXWQCp0Dt8QJtkWnVxDe3ln9DCMw3hFQFmgkl6udMVS87rOJIZO2EdkKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tF+bT+T0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so714417f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 07:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748615378; x=1749220178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iq6evQ1Ylo22d/EKkED7KgSCVafKGbfKTZIys9O8MM=;
        b=tF+bT+T0RRhix+jAo34JAHYIm2L+2TmuPuv/k3gNZyeVog8pVkmXN7Jit0V9Yjo8GH
         c2YgkPk+KPus2yMPWpPTl9eeIkYFw3FBxOJ2JYW5w7aa/npJQ78EbkkWkLvIBeNLCzYM
         oi+bpV9VScXX2o3yDNHT3li5DsmNMxR0otaAhQ2SreMDBI/I+6JDqApw4OHCY3Aj9wD0
         H4bo9XxVm5dEgH0jOooDtmV5mCikp+jDPIE6pD5w1qdkaGKpEN1ybEL1z2epPVbZJ//v
         5OxpddWN2TF2GPC29tUNCqp5kkuZXfh0ykyYirifvwpPQAj9vuuup8cFLO5lY3C6dvbM
         44QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748615378; x=1749220178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iq6evQ1Ylo22d/EKkED7KgSCVafKGbfKTZIys9O8MM=;
        b=W5S9CZL2bZXwTo74MvSM5i0MC0jOOp3aqNoiTU1AnmwklzAwgI6YY2FPcJMsSCRGSH
         AB0g1vh5Vc/YKd9ebdfAdp8HPkgcR7uSQh3QPGRPnwg06RfUU1YjncUki1MmRzmtq4+A
         kLYQJ0Ck02XavKkbtJdvcsSCW+UvmyHk6FvsEgiNcqF0nsuxWYBdR+wf7cZ7Qgou0p51
         S21juik+2tQzaarQXZsMuExpuT07AjADOavoYzKaZ6WwaO+czvlsZlktcVzhchdIE4hW
         SthJEPVl26seGeput/xNN5W1KDSBGNREwcRzXIfCiliil5Fc1JuYP0QYIqSdwF7EbDbO
         87dA==
X-Gm-Message-State: AOJu0YzVKNLDNDnfybm6a5ojhGxO7ygM6q92GwODIHc4+qUSINaCh6Xg
	5VJq1GNN+ohMmlI7ji1u5D19Mbun8Wbc8n6tPBG1zTlXzVyAwv5kh9mKDuKOnxlAyG8=
X-Gm-Gg: ASbGncvndMEDdm+pQ6W/C3gjd5u+WeGHfUpH0nzHSIxT9aNXhVNDLff9ZHXoQJhacPX
	MLnefMSMdmfMM1KhcsWvtbjmMjEDLhAuPlaA4effajcDQUKiw1Op9wzzf0rttmW7HvzU1sI2cKH
	/zWBKjiJuxg5fO+8cpl751mm5fzzwBGhygawJWVGcPwuqZL8ln5CA0aFnZm7EF1ZsnQhnO7Mw/Q
	eSKeZiHcqx4n9IKalVpK5TY0JAXn3rJ2zVaP0TfZEoTqxPZJ8RjD+93bqDVidYacPwJlaE7SGJF
	diEnx4mrL8gJI/OUmThqpox1xxAwgo0mroWGZbJfjiojUIXLpEQ+uzt+G/wTbefB+rDxIK3CSJR
	isYVukyQmofH+NPITnj9BrXT2TrYm00ED2Q1UztiohxFO3reD+nEl
X-Google-Smtp-Source: AGHT+IH2qFjwsL0ZpcsKi1Cp+Z/huaMzhDOx115aS4K84ZONVuPgMF4dhe/+D/7EpJnehWCn8NGKjA==
X-Received: by 2002:a05:6000:4382:b0:3a4:7382:d262 with SMTP id ffacd0b85a97d-3a4eed990bdmr6348269f8f.13.1748615377773;
        Fri, 30 May 2025 07:29:37 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a0421sm4979870f8f.97.2025.05.30.07.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 07:29:37 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 30 May 2025 16:27:57 +0200
Subject: [PATCH v2 2/2] iio: adc: ad7606: add enabling of optional Vrefin
 voltage
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-wip-bl-ad7606-reference-voltages-v2-2-d5e1ad7e6f14@baylibre.com>
References: <20250530-wip-bl-ad7606-reference-voltages-v2-0-d5e1ad7e6f14@baylibre.com>
In-Reply-To: <20250530-wip-bl-ad7606-reference-voltages-v2-0-d5e1ad7e6f14@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=948;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=UxklPPiojuFxSBZLSo/8pFrHGqCsGLMFqwxgwQ8ZpEM=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiwPFDwRvqrt+sstRcM7cqqjC9emNjtuP7IR+LgMUnlu
 zob+e9qd5SyMIhxMciKKbLUJUaYhN4OlVJewDgbZg4rE8gQBi5OAZiI+3RGhnOs2/yWdrxpzjk0
 W7fk81+Rp4oqL4rnxM82fGW37dfP5mcM/yuLlKc8OGWpUftu8nuzYKHljEmmV/6d18nmmK1kEt8
 SxwwA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add optional refin voltage enabling. The property "refin-supply" is
already available and optional in the current fdt dt_schema.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 3bbe9c05b5edbc11e8016c995c6ab64104836e7b..4fd9638eb6e56f800c7c97425e45e04f269e3df7 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1335,6 +1335,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		return dev_err_probe(dev, ret,
 				     "Failed to enable Vdrive supply\n");
 
+	ret = devm_regulator_get_enable_optional(dev, "refin");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret,
+				     "failed to enable REFIN voltage\n");
+
 	st->chip_info = chip_info;
 
 	if (st->chip_info->oversampling_num) {

-- 
2.49.0


