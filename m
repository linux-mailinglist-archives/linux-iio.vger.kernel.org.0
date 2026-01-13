Return-Path: <linux-iio+bounces-27676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AC9D1A6E6
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 17:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C267308EA01
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5924434DCD6;
	Tue, 13 Jan 2026 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mD2Z9EEl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612134D938
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323152; cv=none; b=M4ocNo0CoX+qEZieB1BCdq06tmZlwiAzwKHIaQosRC44ITKZitWXt9Ie97wFFLVv47cXvX1aN/dpblygKcr8Qu7bGf4kF+64qbsd9fuiUMP2pMfSnXumgz20VUis8URBKB40ObVFmpHykR71/mo2ITsqOsyQmsM/qsvwXPkupJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323152; c=relaxed/simple;
	bh=m0D9V4x0TDiYMScx+B2rDcfNHpt1W4utB08H2EYXkTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4QXpp5e/gPpVLZLDqKDGfWSd5augM1HX000Gjtv0R9CZl+9uKRpvcsG20HYvmSF556bfaukv7r/QvBiAEaYUSj/6DTtOL5CmxC0O/ea9lZUVpVSVkz1LXJt3GvkMwav0lno2PQLzXEkIKaCozkEQoRMFBi7CMpbf7D8Wv402/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mD2Z9EEl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ed987d51aso8917955e9.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 08:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768323148; x=1768927948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reHYsRVhVlhU9/XLdVBvX/hBxL5PqvrIU5ifd6VhtQI=;
        b=mD2Z9EElqKO/hQhsq9tOguQfawJojXnQNFJ4eey+mu+S/YDB57FMwV+D41IhXfKKvc
         OXqJA21UXgmBZVxarYyOCTYbPD/9HKJ6W7fhj0iSTMT1mRd3DuOUF9i/0SRg7HuNf41j
         8g5owQ2OsouP+UJWETa6gn8JzTQlHJ/tpyYL7+5MI9G4DR+XniahuTtsZy80w2KfRqdE
         w3gpmEMVnqz+w2sq94Tz/iYd0/Hbo1XgUYZI9rW4E8KMtVXSoKtY/ur82nhM1XyRYHP7
         GwPrWPlltPJdnJczlViPTIh9vslFbQH79H/ADhi62PcSg5daIjdc2arouTzrTgcgls4d
         l6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323148; x=1768927948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reHYsRVhVlhU9/XLdVBvX/hBxL5PqvrIU5ifd6VhtQI=;
        b=CZ17nP9MEujKenB9VT9PVz0zJ/45RUz4n5e6umMcpw6cHyb+acvuxJw/PqOpm7h0AH
         wok9cpqFV3Ri2duaxPQDgUAU9s0SY0OOyzTHnzjVeOfyB9m4cIJok5MtXPM/DarfP3tl
         X/gpcjWX9b7FsJr9PhV1ltvJJMyzGiiNvEdTcKgyeI+npRHwdol6wYUoI2zPG8qppyF7
         TZ7iwMsAxt6lFDVgInBhe4ze7VGRfCEjPBb9J3w6bRaDKYars6LLrzgWoNKFFLVTtr39
         PZQJ3od8DA35Z0y76nRRy84onO+wqhsfxvP7hAO+NZ7fRsJrRePvinccYz/N6mbik4oi
         D0AA==
X-Forwarded-Encrypted: i=1; AJvYcCUwIWkS6jrD79dRjiqyZIHWhjTPUgob5Fosbq+HdU3Ye+GihDLkeuz3M3n4VjD11MX/5qAsN52iBEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd30zbOD81hA/HWrS8a4ReZwBjZbK3694rT9O70UNWH+o8ld7m
	VciJEUO4nhrbSGQPKCZeBAbduOBvOF+y4IAVT3eJSnBMuN5FIkO/o06argNTb9ptZBs=
X-Gm-Gg: AY/fxX6wddZk/jaKYEtc/33LxxnvQwCP1EuAjAZzpHjjQRrjqASxa9CYBeyO1Z6vfqy
	1V5TLNJk15cVLG4hsTbK8f/X9/LaJlFpU4OOawUsEzR/PWW3OBPtb/obneQ9NyFJa/WO+xQ0LsL
	kH/Uxq1H2mTtbCtYWFGe+TsUSHVhIvOqj6RSGK99QKTacAWJKEqbaQgeZfU2A1BFQ0BRUckxAB+
	jiTuLpUD2j6z+XLWuCka7f93jG30Clcsolh7jx78DsZ+e2O5wy5PwQLnPpmrugqghnZtDWaQCmR
	FaJZxPtavXwkXHNyHshxEbNTHe40/yu2EeV5xmrNaXPQtwWaLVa5FZWSRs2yFS4C3OSjcn12iOh
	mzW2nyaeUdXiYO6bD/pogYej5qWiePBFbDklkqAuToUwz4x8h36Lv/BLlv/UkOhfmcTm0QfayDN
	q+U7rMJamOdt2Euu6Bs+gShS1tFRnlXSs=
X-Google-Smtp-Source: AGHT+IE2mf8KyPtT6cpp9Z+sIL+E+Nhzb//si5kbvx2m3OmBsCtIM58L0qqoJtaQDiBQE8qxSXV8Ag==
X-Received: by 2002:a05:600c:500d:b0:477:9d54:58d7 with SMTP id 5b1f17b1804b1-47d84b3b881mr210609265e9.29.1768323147822;
        Tue, 13 Jan 2026 08:52:27 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:3594:70ab:9964:c5ec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm431684925e9.7.2026.01.13.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:52:26 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org
Cc: Frank.li@nxp.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 1/3] counters: Reorder the Makefile
Date: Tue, 13 Jan 2026 17:52:18 +0100
Message-ID: <20260113165220.1599038-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113165220.1599038-1-daniel.lezcano@linaro.org>
References: <20260113165220.1599038-1-daniel.lezcano@linaro.org>
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


