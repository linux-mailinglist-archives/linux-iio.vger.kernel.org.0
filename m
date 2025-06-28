Return-Path: <linux-iio+bounces-21065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A562AEC93A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCCE16C0EB
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BE25B69E;
	Sat, 28 Jun 2025 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="czcv0bOK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0585323C8BE
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751130406; cv=none; b=MXZzJxg4tcN5rpDbnc+c9pkioevTLEjxnlejJWpPe5hzXU9juj8HsltWAjhMPlpqSxz4IDVWdHvPINW5xrt5qzsvYJKsoKGVLOOfT/UMy+FaU1w9Dc9eGPAQWq6UKK1GEKOsPBG7pzKrC+vf3PX414Tr9YjjExYBUOGivCnV7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751130406; c=relaxed/simple;
	bh=kTMoXyiMFCKquBwUavm7Rq/wKtAd7ZUCYz4F1Tbv2Og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Gzv2aQEbaCBOIiwtGhPd1QNa4TAzsnBINVEgUrRdLTZ/F3kyobmMqv/ohRW87eWKajFvPxosbEaBWoiGIeQOtHUHuP2hUE03eYz1oH+4pEi7JQosMxh9Qjhr0zQ1M2pgdtcJWKAiVYlN8XdMPWS3Jqxc9zKSDO5qJF8u9dK8qWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=czcv0bOK; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-408d7e2b040so2076716b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751130404; x=1751735204; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0V0H+yFnGFJ3mjtoaJcC0YtJ+XENtkBjlElwrlczuu0=;
        b=czcv0bOK5o7vEVxQEY/x7DvGroBiUPBPntrm+7DBSvHvN0+GSgyeVYpj6YtYutEpIk
         3Gtyr++kow3x4dJWhvqoJr+myRkVXDTDQ/n1Gw+EdR25xIcYhXNAA1cQW/yS3lZa2Xg7
         GRY0bzuSUaIoiijvXNV73+3FXLylUSigCcYxwwlw6vfg62PCmAOy4E00b5axb5l/l+sa
         hMHoQxLcuNLBbPxaIIwVoifJdCG3J4WF17CT4BjWUQmudTpeZKGftgTF1m+rYXGwWuAk
         hBlrvQqzPBSulBF0JzafSO/8FrvtPrC7a4BMiAwrGDDO9B54GY9sV0Ku8ZYKRJmZT0ji
         XDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751130404; x=1751735204;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0V0H+yFnGFJ3mjtoaJcC0YtJ+XENtkBjlElwrlczuu0=;
        b=DfA0leEldvCgWqoYBVA87/k+O0Pks0SwSDGT6byJna/v5QRm/fKARq2Crz309NYIBy
         DAPvRA3K5Kjv1KmGd0WS+m4joUxR6jjgFfthe1OYQBcJZ2vDGET31MjsDW5Tt4sP1edR
         RG3OVnP/49W2gjRkwkPlvzYLxeZ115SGUBlIUu+jBpqF7HIzsFV17Udsld1nUhUGU5T5
         xnUcHc/f7cIrpClU7GLksA6AGQt/Ij9SKy0LJyhq4iW2eEb+i2t8mZf3nBFMsfArnamV
         dWerX+4tEGKYGkm1DX7ATMYuV+e9RBKuEurR0MRTxENry4mkAcA/F0OnhFk6b+1kPgnC
         E3Mw==
X-Gm-Message-State: AOJu0YxD3ya/vEvWCIQmoIBr+ikGXBvZYl61bbXRs9sqPsbH1uedvtw1
	fWCn62IDMlxZ+R9Bb48B+/d1lsg1YMBs48sJTfNI7+saaA8xRV6x3lLJVJLilxh6bIc=
X-Gm-Gg: ASbGncts/x4uwlCW9fPSaLsqTzqeH4EVyy2kJgUIJNqf/LPUTw7OWeUSn1i6RTCTH9C
	UCbXM/HIvFFAZ1WNYlkJabBTjxstRMvVrsQuYnvHpSmSP6TwL62rqk2l0xvGCfqvIK8p/0HotHE
	7ELRDDiON8zje5kU1EEi2x2yYqH4olRp1wfsUzxBCiMKL+pnMcbrKNtoWvq8/qT8h8mxLv6be2D
	S/HWvccKy+s/9oszcd1vqYrsVRunOtVHK+9Yf2CRVKYrxBenGuUjJcJaLeupVMK/USvpsdz9z1+
	tYIH5N+2pbvBygJGGzUcrTJAeViOTeN+TJbwY80EZSpNrM9GVxxTI51Ei6zNC8gtI7yA
X-Google-Smtp-Source: AGHT+IFvAT3J/Rnzb09eXqDJ14DfPx9e8N5olrNVqt0Nou24JbJaeG+s2fYFr0yytVswuHKpF9xaeg==
X-Received: by 2002:a05:6870:d146:b0:2ef:17b3:3c9d with SMTP id 586e51a60fabf-2efed44c9f1mr5079195fac.7.1751130404031;
        Sat, 28 Jun 2025 10:06:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b8474dfbsm613686eaf.2.2025.06.28.10.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:06:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:06:35 -0500
Subject: [PATCH] iio: chemical: atlas-ezo-sensor: make atlas_ezo_devices
 const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-13-v1-1-2a7fd592a07c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABohYGgC/x3MTQqAIBBA4avErBsotd+rRAvRqWajoRKBePek5
 bd4L0OkwBRhbTIEejiydxV924C5tDsJ2VaD6MTQjWJGZo/Gu5jQ6qSxl0izlVLpZVLLBLW7Ax3
 8/s9tL+UDNaMATWMAAAA=
X-Change-ID: 20250628-iio-const-data-13-e8d334a97497
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=kTMoXyiMFCKquBwUavm7Rq/wKtAd7ZUCYz4F1Tbv2Og=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCEc9CPxm5x5qAHsJPSqXj08oq+4nGQm6xEpr
 3hhnih3gomJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAhHAAKCRDCzCAB/wGP
 wJCeB/sFi04FfeURmc9LRy9SBKflwHiuGnJBJ91RNhdyVX5MN42eXeUDF+ARzZR3Kz12sf0oJd9
 wuRmfUObZF41xgcfvhPB1q7EfvG/TQccXJx6DxDLe3V8sCT2qq7jqLKpHO5NHO7g1SbPgDvHZJc
 blZVPJKsVpf4vuLQzEfJTUvYhE6vLS9k7KWgSPcNPAWqKbiJkDAT/SpjRhtwwFg99Blz06GKmQt
 x3oKW+oXdGEIm9LifVhwmjeceG1pph+92qHkJs3Kua669NzecGeHZpjwsKkpe+M8WlL1oEm69f5
 h4sA/VuFW7g1CBXyhWfU29JCNqvn7XMRyiI0UKuypBm8WpFF
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct atlas_ezo_device atlas_ezo_devices[]. This
is read-only data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/chemical/atlas-ezo-sensor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index de0b87edd1887f5cf28cc50a36542f65f9d77dc5..59f3a4fa9e9f3b6e185399bad2e15487934ac87e 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -82,7 +82,7 @@ static const struct iio_chan_spec atlas_hum_ezo_channels[] = {
 	},
 };
 
-static struct atlas_ezo_device atlas_ezo_devices[] = {
+static const struct atlas_ezo_device atlas_ezo_devices[] = {
 	[ATLAS_CO2_EZO] = {
 		.channels = atlas_co2_ezo_channels,
 		.num_channels = 1,

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-13-e8d334a97497

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


