Return-Path: <linux-iio+bounces-26925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBADCABED2
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 04:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 641D430567A4
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 03:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ED52E8B6B;
	Mon,  8 Dec 2025 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8wa295u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438C23FC41
	for <linux-iio@vger.kernel.org>; Mon,  8 Dec 2025 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765163145; cv=none; b=abuZuh6qe4n6bOhbOJVNmCMrYgBkUSdX6pVnsE6za3KlHZ9yIC64LjOQ1XT8w1mzaDH0RzmNu+XJliiabuLhFaMbDzp4was1aR1H9QWIRSqxBwyA4+1hazbQUlCH/ZBeB/BWJdR6PHY3hzlVcGn9+OOJxPL9/bjAKN9lWCatiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765163145; c=relaxed/simple;
	bh=m0D9V4x0TDiYMScx+B2rDcfNHpt1W4utB08H2EYXkTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMq68rsasHbAFyx6WMye56ljJ4/B0JovfupjpDGS6BZuxlCDZhf5JG5V0WNrZHyvBBIrFd6bC6hQWi6n58eZ4zEwaA8jx2+HxbZ7FQUUrBUMuIgAU39sI1c/aS+kevEM9Gbq+atjz+joa9qA/f10fYFV+l2EFPgONW7PoVd9r1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8wa295u; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso32055255e9.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 19:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765163138; x=1765767938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reHYsRVhVlhU9/XLdVBvX/hBxL5PqvrIU5ifd6VhtQI=;
        b=R8wa295uhw5LPI5x8KhwsVKi+4n0nWN8AnA9AXPBx8yC8MvAieTb73BjI/jqvDTWEp
         t8nu3/Qtye8F1DP9Tb0pj3F2JdSiYEvV59zs7UIZon+FzjBDkuninZDIIHUruOnE5IYl
         JLUtuoVN8N2KED801sOLqBDT9dzGzE00eqiM2NZYWAM+uKqIfKQfdzbozD9nMDecUdwi
         Z7UmVG7/UgWZ+G9Mtg7uE/8CFL74hAJkhpr7Vzr6E1f/m5pccjChkRkpzS0H843jhxPQ
         hMlaUX1xKYI64YCaxXGrpobvRxd2rii/1aJBBZxvnhv0ULVlqboZ2zwGDsTB/dAc4Qxg
         /Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765163138; x=1765767938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reHYsRVhVlhU9/XLdVBvX/hBxL5PqvrIU5ifd6VhtQI=;
        b=Z7R1MfmSge4jbnL1RLBC0/NWj4DPf8CEqIgEIfQja5l7lZrCw2zYW54LTfFimg8S0s
         iOQcMYaPeHB/xgODDEaJG17S0UBh1UHNNAgCETbb9jrZIwi6dzbHPdAicXEl6bR1Z0Jd
         xLl760DVvjah8bq6YI6JeeL6yP/cTZniGCZmiJWCWYk6kkxH0+Y2vuwzyBCCjnJz39X0
         OTmH1W1puznATz0oqESxrXnQIynoYusCe/3aM5Q+8TDoc8as6jzKQkD8bw9zYpyS6g+L
         kH8xw9vT27OS25rj66gZNWbQzYx5DeWCIJQLn3JU01qM13ARGHQscfssF/KduysQh2zw
         ETFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmsCp2VFH8x155mck7+ki+MDSAXT+870yFYrrtqVJJKTtXiJG9vEccgLNHAgdP4pH9YxXEAIrR534=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qf6I8EBldO8S0DWZDLZ+YARkEZ8S9JolbyYxDfQJ5XJa3jQq
	cZbB2rcCh8eUA9JYdlDLsL1ag3jMu7mj2rKuO4DaFChedszKr6lQvUA5yHROg4IBFbA=
X-Gm-Gg: ASbGncttgWeTrvKZj4Ju8uNg8yO8mcuqbrM6rvTiA6K1wp/DW9sBF3bUvpiJDqdE5SL
	xPxrC+5dKgaQdxmZWLml7ddIHYT3Yf7qeqQlXIMF/fc89x0JjB/jkSc0S4QUt0ki1YI+hFCuo8E
	Bq1TAPBJvfmVnB9zisC2Xk/l9sAZYhmBJxfbNXzrydrOWF7dq6jH/wmVmyqwwS6lk8bekfDsJLQ
	hldNqYBG0AduGabejRBj+cgPZuwTa9hccH11WvKBqIHU5GBaHQN30c5TSWh9hVkGERGXiMgo2WD
	6IjeqPvCsLytWSyJJSPVRC1brOvZcZJyrwSZqWx8l6zHjta65B1nZyPoTWfanTKTfsGrBSUExpU
	s02GQuRAXYWv00DFY71SvM5w6EliCX5F565gQPGYCflezl1b9n8GtTAhkXsuyXVYpTpGaL1tNBT
	ksYHPQUuaHY032543RqZFGkA19ff2QRFuXC0AepRfoZg==
X-Google-Smtp-Source: AGHT+IE5NLuFXDyXwZeEfScNoLU+uyHbkMSa7QkD1GDahbK5J8VDnVXB/PQgU5tmn4TB0uE2IXuIpg==
X-Received: by 2002:a05:600c:4e55:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-47939e1cac1mr60317925e9.18.1765163138213;
        Sun, 07 Dec 2025 19:05:38 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310b8e70sm220564885e9.5.2025.12.07.19.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 19:05:37 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v1 1/3] counters: Reorder the Makefile
Date: Mon,  8 Dec 2025 04:04:11 +0100
Message-ID: <20251208030413.3117660-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208030413.3117660-1-daniel.lezcano@linaro.org>
References: <20251208030413.3117660-1-daniel.lezcano@linaro.org>
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


