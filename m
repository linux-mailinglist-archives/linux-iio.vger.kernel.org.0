Return-Path: <linux-iio+bounces-26988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B60CB1F8F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 06:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8151A30DD63C
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 05:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9F42FFF8C;
	Wed, 10 Dec 2025 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O94VMrIq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65EE2FF64D
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 05:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765344320; cv=none; b=a/ze6Rd4QfQHXEZoiRT83sabYlBT5lLcaUip8jgugdTRoEDXydC2eC3xLLJLR6nVS33D0MBe4ZLcJjU+4trbYQRfWRnjRoprOmlU3cRN4un3Gecl500zlCnYX+Os4QBFFx7TY5Bxk+R/Awv+BuLKDUIkMnz3TXX+f6WN+cEvY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765344320; c=relaxed/simple;
	bh=m0D9V4x0TDiYMScx+B2rDcfNHpt1W4utB08H2EYXkTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V66ajRkHfNHBZVGH60UJeKXYtglXYMsIZJavlbv/eb8wG7JSCQ6St6wNZk/WhgQnt215o57eLk/gheajWqhjKoW8xpz9wMIY1d9MSRh719II13VyciiY+ZHvqkL0VLcCqhzwHH91sjCfdJJrL7ACWmbKUp3x/cRPxaqjQKZR+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O94VMrIq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso73004235e9.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Dec 2025 21:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765344317; x=1765949117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reHYsRVhVlhU9/XLdVBvX/hBxL5PqvrIU5ifd6VhtQI=;
        b=O94VMrIqOkA8jK41fIudLRgAjibQGu8rL1v61rVC9XHY9c9dQSqnup3V81T9ii9cZD
         cImiaTVPdc5jAduXPQHWH6hNYE3s8TJzfLIRJVxRrE55RVZU2pahbaroW3okpEqpBV2M
         2imvmcn7e3JymdinkubkUWyZrO6ydTm6HEMEKFr9k6HQhWS1Z7Hu0ji4GBxQHAGt1NCc
         dld5n7Pe6EVIZbmPCWLlfw4dKJRQYA4216hhX3QXjvSpGJDbDKa8ML36SpouFh1tEM2m
         KYLoVM0hlcg1LEwSdem/SwEGuJhv1QYfookm4OGEfOYIsrsvgraQw2220ppkSdoYPdo1
         ki/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765344317; x=1765949117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reHYsRVhVlhU9/XLdVBvX/hBxL5PqvrIU5ifd6VhtQI=;
        b=SwLMmLnE9lngmmW3Xtl9W6jRGEYk+O4m/8yjbLlku6w4WsGujV5JnzNsaxOuiVS/8I
         1tpvUvqx8kZO43ts2NVPsWA5E2Nepkt4LbF1xTfrAcBeXTV/faBx8Rl4JyQgaPz4IXWy
         gN4pJrpc0H0mZNHj5pdaC/AX4gbt/fU529Fq7SjNgtbncxBkORoBTMp9IWsPw2C91c3D
         PwJ07HKSwJ7v45e2gIeh3tNBg3V53NIWtR/eXjBHqMjiy4YgJQCqq+g9xPzrzUoxus/4
         FTmC1ykRWP+vum3xyVxMRrdriQZWKfJSrgM7NALVa0/GjBa5bZBXv3mWXKo9l9ApoyUC
         S3jw==
X-Forwarded-Encrypted: i=1; AJvYcCU/H21Dz0QRqNXaYLhcQALintj48y/pnGpFqR2EUg2ICyD/4fSUngXK7rqepKtcfjqKc/VDTU6+NEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8N5H+WiQ6Fk2S+Z7e4V4RKmaNclby/FteKr9RG8oME9b9euGa
	6VzQ9KuA9NCTL6wCdQdoU5Wx0I+fJFuXM7PW96/OFurhhFsuDBIbSZ+yq436lrYWMgo=
X-Gm-Gg: ASbGnct7lD+0EZ/ACt37VAesek+oDrOh2FkOIlYqBr5rMRFFsMvR0pUyHTABooMVe+P
	hN+VybVmJYp5D/ZAp80Yl1rLCsHyMiQSATtbErEWgMguuOU8yIDRfR8SjoPZyec1BtR4+1ep3Kh
	Nq67r12iaQE/brqNQ/6e7UDwxCWIjwdQo7HwcEAbHjX3oftcFfyUMlZDsc/I/V2nUCH9bNJQ8Ag
	q6sTZohZ3atLdJN1LKLBSZOVD9HiaMg0k8Q/QLt9lscDQ4et3KkkUv4OkcnHp0S1pm0IUXMo82P
	+GEPvq4a/7scv/lZCUn+hYfQvGMbrz8D07rubtcdEYtN06xb6BTATiBbLKrhq208X+3SmGW7Qua
	Hv0s0Od3iqIL5uQWzaQgzgvW+I0KfYul3aTyrsNbrBacar5wZPsWnKw+hJv/k7MyZ5eKmTNgroO
	9Nb457ajoW3SNJRynS8vcjJNwI/n0PKhc=
X-Google-Smtp-Source: AGHT+IG3Zk1Zjw2omcTEAj9n1igWjHPWpnedtObj3XU66AORvz3hVgQfVSF4vsHfxaK23om068XQpg==
X-Received: by 2002:a05:600c:4714:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-47a8374de03mr8181085e9.5.1765344317023;
        Tue, 09 Dec 2025 21:25:17 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:4fde:b93c:87db:86e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d3a75a3sm33485695e9.6.2025.12.09.21.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 21:25:16 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: wbg@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: s32@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 1/3] counters: Reorder the Makefile
Date: Wed, 10 Dec 2025 06:24:45 +0100
Message-ID: <20251210052449.4154283-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210052449.4154283-1-daniel.lezcano@linaro.org>
References: <20251210052449.4154283-1-daniel.lezcano@linaro.org>
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


