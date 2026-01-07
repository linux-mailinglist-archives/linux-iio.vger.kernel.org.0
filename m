Return-Path: <linux-iio+bounces-27513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9738DCFE086
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 14:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E1163047D97
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 13:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE8D34105C;
	Wed,  7 Jan 2026 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1MCj9sb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CC33F37A
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793203; cv=none; b=CYnRFWwW12AYermLP2mEk1jyX1rwJIZ1jyEOESOZgWnk2CVNTAKCRYhZALa0gwirWH38CiwTxKAVGmuE3JY6ftdltTOzQidObg+9loNCB29XO4hw7ryrruu4em+FTi6GeN79zC1WbBEl5RSevB+9T6Pml8iLwvz8Vx5ZqZh/fH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793203; c=relaxed/simple;
	bh=m0D9V4x0TDiYMScx+B2rDcfNHpt1W4utB08H2EYXkTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Se1j6n1fUapLLtKzYzfuutMtno07/NU7JY7LrPa2Vo0CvmmEoJTSqIfrG0Uxz3MvYTH1xjiUxMAruN1dmoeqh4HbL8IkB/n4UODsjMQSVI8zSqA8odrEH13IXfgOkHhnt2GfJC4d1Cbs9SxuyKVus9gwjSy21AKMDiA556SlyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c1MCj9sb; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477632b0621so12851215e9.2
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767793198; x=1768397998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reHYsRVhVlhU9/XLdVBvX/hBxL5PqvrIU5ifd6VhtQI=;
        b=c1MCj9sbolerNjOMN9gMJ4G6Vdx9y1omxk3sisMGw3VZ0UPpB2Uusu7g/h7hx49OTf
         nLoVJ/AJCCMJsF51qfpnz3hCA5HZHhn9mogFmA9O5PxkXuRBGjPkDysLWLiuuYLIrHYT
         4cTLuTnS0/yd2PcGSONVWoY82fyMFuJGtOpBF1x/Y22hNrBTMaK2+8oqjNrSxSIMjqJn
         az8d7PGgpti2tZots9Vu28NcYcBVgUz2no22bfE4VpFWuZHRwj39zNa0qRn/vq2X+Csx
         5IY9boglXzlRupC596H+AnxWsNEfUreDnbBP7r78wansGKvDrAFt7C4l3Zgopobxle4q
         OXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793198; x=1768397998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reHYsRVhVlhU9/XLdVBvX/hBxL5PqvrIU5ifd6VhtQI=;
        b=sHiaVrEnaPF9SGFuIbjLeCJeAUbxDxru5ZuM+2CglzazOa5A9htW+nNZx+BHd7/DPj
         ivnEQjenDdPCM0QBWNBaAbbN+mhB5ZQpdOQyCNxUPuMKQV2ihAjQOtsSqNDoyEpFpLNG
         39qh7euqnHvXOAIbBRUiYYaaEYKyuUYBbJ70PArUXSh1ZzivF/E8oQ6XZjQS5XiOXNtR
         SeZm6ak8hjlvwT8eWiS9C8zrkHIeTrxbOeLzmjej5gD3+ySEYYe0cKnInbKnpbbEsqel
         2eZKph1XDFs6JOQSHi6l5pJERviTKi5+dlip0Z0+OdlbaZ6sYROiT6yUWcV318VV1DoJ
         0viQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDf8CUFj5/tpdWzFZZSt1dj6fTo7wecCzzE1DvvO0kHo4ljQLoSaYareUqNwQqInn18ViFdO17SUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXfOl+solQMuiqoPlseyyTPUcnHTWzEbGbR5HHrKl0IMWgLb24
	sE9GcuWEts5oQq6VITLSz88enkftkGS87Aa6L+R7VWcc4YG40iAmoMqro3ttuBhE1dk=
X-Gm-Gg: AY/fxX6EHAp1okjDH7rcI0er0Aefe/4a1s8CYh42KLcve9i7wLdtSw+99yEgNbwcbWi
	yNuodS9GxjQwiDh/wwWAuns41T+/kcquFN4EsReLvPc/0SIJNTdaj2625/QGRX+/L8B5hwzDq99
	sX7m1vaLG6BhoPrz29vqL5kZVs4AEz5AUR053kw1pAm5Q2ofqBGWc6PVKunuu7ctjSigB+y1fBm
	VMDWzUYKFC/cnDudC5+1H0+R+ly5bir4vXtkgTAOLbB9DZgXS+MmQn049oT/rArmULvvfgzSd1Q
	Pvw2Ee5czmKHAvEQ5iUl7ZEkrrfRni0LF/gTLT1QNuL4PRaSrVTX4A4ligOCLycEJs6bP2/vaPR
	peXBrMKJESmOmpmnu30jDbL0q4D+K53FAQLhhz6c+RrtL84Xe2QXxttkXyP/6JemsRuOtupCSi/
	1/+v9ZsdKCTLiGUl6Vno4Le9nbPAmqIZfdlLNo27q51g==
X-Google-Smtp-Source: AGHT+IGsXFTEj4VT6TREhqzbbNBgMjGQPUdJHu/PUzy+9Vp/LyXJd2kFDSR3tgJFYV0qZeNTBlTjWA==
X-Received: by 2002:a05:600c:5490:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47d84b34819mr29682965e9.20.1767793198615;
        Wed, 07 Jan 2026 05:39:58 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:39ee:bc4c:aafe:6bd0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dade5sm10595542f8f.9.2026.01.07.05.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:39:58 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org
Cc: robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 1/3] counters: Reorder the Makefile
Date: Wed,  7 Jan 2026 14:39:50 +0100
Message-ID: <20260107133953.2094015-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107133953.2094015-1-daniel.lezcano@linaro.org>
References: <20260107133953.2094015-1-daniel.lezcano@linaro.org>
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


