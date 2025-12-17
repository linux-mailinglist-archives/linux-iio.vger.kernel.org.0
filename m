Return-Path: <linux-iio+bounces-27131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8868CC66AB
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 08:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF2E3300249D
	for <lists+linux-iio@lfdr.de>; Wed, 17 Dec 2025 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6943133BBA3;
	Wed, 17 Dec 2025 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StbrB3d9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465D43358C5
	for <linux-iio@vger.kernel.org>; Wed, 17 Dec 2025 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765957820; cv=none; b=bpZgQpJgTMQu+F2HVZD3lnRg6a7fBRu/a469yhNbUMGNVBpAujXmb/PYYh3RRL7Cxfztw9szvejahBdh+u0MNbJutDxsE7Q7lPY0ujEYMwRfjdns050pRxVHimC+D91QqFXc8DC1pNt7oqfPdBZXar7paRytFZFXOVQ6L57+eM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765957820; c=relaxed/simple;
	bh=m0D9V4x0TDiYMScx+B2rDcfNHpt1W4utB08H2EYXkTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/095N+NesZF5vSlgZeDrn5cVgxLyuM62iRs5QBb7ZuAmIRNMDyRCjAc78A8QhlC1IV24wjCdf4iawSG4R53JWCDXhYOKBzHJQzCRoursWFRhqOyDPCTBWkDvP3G1ZCMs20cSqX7ITVovZuKTj8+U2fbeLbV4tvuu7GzLvNche0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=StbrB3d9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so2152768f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Dec 2025 23:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765957816; x=1766562616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reHYsRVhVlhU9/XLdVBvX/hBxL5PqvrIU5ifd6VhtQI=;
        b=StbrB3d9bH6MzWe9qh9ziSuYrL7Tdlw6H917XsSknkV9Iyd4mIi1B6nFgD4YFIrsLW
         waK686duKqoxiInG7ab0HV/kHRY1KWA3EJ/kPf/4uQDEtIS7JlHsS8kQIyv0BbPs5OJ9
         b8ASMv7oK/vHqI7n7UNN9RMP4mo2fS6BkqPoUjaS70mQ2gb36uhCKfxYHi+mskXBo8jF
         RxrXXVn1km+J0yW2DUuhKSHdoFpDA1LfnmbTg1aLFG+tXVlqC4BBT8qQ5HDCZvB7qqlo
         FdsYdRHHH5PCX2FcIjKFdHxKrZ7whEhK+ce7DKK4f6QlmmR14gKU5yfGiVKEjfHvnFc3
         gzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765957816; x=1766562616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reHYsRVhVlhU9/XLdVBvX/hBxL5PqvrIU5ifd6VhtQI=;
        b=wuJlpaU8LSUG/y0Qb9zaU3+Hln1PmglPOoaXd1YMUlbzRIpD+Fuj4xy17lPwQRV0mm
         UKRkCga8FUvBCBlNNaZasDs6M9JTfdLS/RQcJ6+UoDnSmrrp3ottb95R16L1BkA0PiQ6
         xdrACU2WJWGPst1XjkMgOcvpBy2l4kxgcJC8aAWcZsEA3wd5w6YvAlJ6SR5y9jNrggjb
         Ehd31he3I9op6UIULLb7sIdwBC/WWyO6iqHoCfphk2vlKbZ0w472hDhaUMbSZjJao/s+
         +xLpiaIhkUau1UHtSMAjdmqwKNNTVjtv1VxGMyU3XrXeBVTqErAlsq92XpgWy7jsQV0o
         aF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjg+Tqr+Ac+DwXhCI8MzvxSmyKVN1EOcrxP1SsWcHP/OU0OLxOuQnOp8gyD530gFUgxwLKSKytE6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/FUqMl3oJ2eCY20tCZVyTprmqykjjV6Ahtrzr2r+7V2HcVTt
	1f/HCOgKMi1tkwMd8I3NbtwZunZ/dcBqjHL5aPEvTAHWLK3knlclx5uCYdNR4FFPbyE=
X-Gm-Gg: AY/fxX6x+KDvVQcoxDkV+x77K7iFrI/ZvY/UpynW3NSs+shNSyXO9pB5H4d4iqAb6Pu
	ne1QkutcSSxr7yBBgqlH48lOFqx0LX41s3Gwnf8LAc3XdjM2ar37DgJv7PEF2UWVqkHt5yo6Zbd
	DrbZ+Hf6je7zQwV6q3MO8ghVrDoAVcVAhTSJyBt8bijJtKWOUwOEanqs0FKNS7P+e6TgPUgt2pl
	8YHAv2YrrLIrVab+YuzXZGWENTQNNRRquaoM4xeePVCtzhzI5yRGTtLaVN5TblMQcL4kzNFj9XM
	9eSpV2u7fmO2KwM3UTkGTOh3iUqmEhXDuHq0oy3Ey/l+JtjLpKtG/wcsMshGpGjG9rcUqoBs5JG
	oq+s00h9tyc2Vj5QUV40E3B2cszCPeY1pkL0yYe7UJbiLcHNGl7l+o4JGyuRi8qeV3DeQrzEJ+o
	1AAxX7og5FCvLJgQ9WnRp0fEtV9+VwNhw=
X-Google-Smtp-Source: AGHT+IFnx406KO2q93NhOrqRhNQ711mt1VR1CvL6ul0btReeHMDv6zRYevqWvEWqN/pLnAUfw+qqmA==
X-Received: by 2002:a05:600c:45c8:b0:477:b0b9:312a with SMTP id 5b1f17b1804b1-47a8f8a7136mr148399285e9.7.1765957816540;
        Tue, 16 Dec 2025 23:50:16 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bdc1edff5sm26094315e9.14.2025.12.16.23.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 23:50:15 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 1/3] counters: Reorder the Makefile
Date: Wed, 17 Dec 2025 08:49:55 +0100
Message-ID: <20251217075000.2592966-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217075000.2592966-1-daniel.lezcano@linaro.org>
References: <20251217075000.2592966-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next changes provide a new driver. For the sake of clarity,
reorder the Makefile alphabetically.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/counter/Makefile | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index fa3c1d08f706..40e644948e7a 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -6,14 +6,16 @@
 obj-$(CONFIG_COUNTER) += counter.o
 counter-y := counter-core.o counter-sysfs.o counter-chrdev.o
 
-obj-$(CONFIG_I8254)		+= i8254.o
-obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
+obj-$(CONFIG_104_QUAD_8)		+= 104-quad-8.o
+obj-$(CONFIG_FTM_QUADDEC)		+= ftm-quaddec.o
+obj-$(CONFIG_I8254)			+= i8254.o
+obj-$(CONFIG_INTEL_QEP)			+= intel-qep.o
 obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
-obj-$(CONFIG_RZ_MTU3_CNT)	+= rz-mtu3-cnt.o
-obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
-obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
-obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
-obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
 obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
-obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
-obj-$(CONFIG_TI_ECAP_CAPTURE)	+= ti-ecap-capture.o
+obj-$(CONFIG_RZ_MTU3_CNT)		+= rz-mtu3-cnt.o
+obj-$(CONFIG_STM32_TIMER_CNT)		+= stm32-timer-cnt.o
+obj-$(CONFIG_STM32_LPTIMER_CNT)		+= stm32-lptimer-cnt.o
+obj-$(CONFIG_TI_ECAP_CAPTURE)		+= ti-ecap-capture.o
+obj-$(CONFIG_TI_EQEP)			+= ti-eqep.o
+
+
-- 
2.43.0


