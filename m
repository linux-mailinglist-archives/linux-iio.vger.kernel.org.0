Return-Path: <linux-iio+bounces-25458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2A1C0CEC2
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 11:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49697346D75
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85292E972C;
	Mon, 27 Oct 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrBLRIYF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75D10F1
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560308; cv=none; b=dSEbcMtbb8bBtwqI7AWErM0qumiwLswnLggM6uATx8ggWVxS8aBWytyY4MEnDosC7xBITHj4qUyok1UZOUg4KIQhVNks6LyvHUQq2W8xM98tu91ua1HxbjsQB3DAb8eyyl64F0jBGuWfBAOeyIbJ3q+q1+EkZuir2P3k5BKEPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560308; c=relaxed/simple;
	bh=cqrBqLQytVCzcJ7E7kwhYkcYYp2Zs/BePmICGhQ/GWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kM1mlcX+GFkU91hRHpsZeshkzw7BRYmiHBOrggEvX2RzeuMWJP+euJxayTlIWNMIskUE+3CR8n7JJc4SHbqgbMNOkb+wgc4sUXOrfUU1D/lJDZLtIyeLCdtIDzZPg6RDzmDQ4cwPNS/3KJVucmZWg70NWEYpRZLLz64UEoWARgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vrBLRIYF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-592fcf7a1ceso3444340e87.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761560303; x=1762165103; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx03cUjHaKSnZslq4rOuaP2cLEUlRGHdIcj19b2yJKE=;
        b=vrBLRIYFYvNdHfOjSecnukcz3DdQK/MAkzO40xpZEuP664+FoHsh/MVlKUQIPj0DsW
         UYkqH4QSAVoi/hNN4wBCHJaR5B7KA9M9urGa4ONICv2RlV+JHTQUMpLKtGDSOrvd0M9W
         pLXYAl/a6hUiqu59Nz+mEDTlrmyNRmSzNPE/4ky9Mm+dyIDqnC/G0dYKCBxc3L0RtHV5
         MhXIlZzjL3LuSYvKdlBaCdeY3xBPlxvckE0oZOQDyMyOBYFRBroYW9/LGM7LoPSSd7eE
         6aZjA0LE9JuJ7xoWeFFnE957yfVeGf6QmNSv+nGKgGmaGh5HN+IYd2qnepXn1ll/2AEO
         3GFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761560303; x=1762165103;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jx03cUjHaKSnZslq4rOuaP2cLEUlRGHdIcj19b2yJKE=;
        b=AhX+heM02nYcz8oDaTSMy1qDiVa4AmlRxgj3eJT6WFMmpH0c6GX8s/K/p2E6iECqZf
         NghY1zOKgd9ebFa4qH9OsqEkgqkAVBPNmBXloeAmiZTQWvVkcoo0v41o4jpow7H4ERgJ
         XJbyvl9pi6QzRDfOANShOKC5ZDzABngEDpnjG0dNQXkH2uOlW5GU3M2TqNEWSFlFBtD5
         +bpmIZs769kemvUIOigBtK/Vlm0GA0+BPqePQIuVIneavb9UOdFSw75SCSr+ISNWlFJH
         /S4DWKj5qkWpAQ905pG5mFAZGRXPk8m5HWZi43zY6lkHMUVas/SW/HshEmrX9ZsKnXpw
         GUPA==
X-Gm-Message-State: AOJu0Yx3L4SMJ/TcrfqnwGwsPNjhhC07RTh649UEJ12efIorTlY3vHzS
	tFm9tdprJrwK8I1coEYOyj99FUlwdzt2D7u1b/oLlEMeKSt3h5V5DL74lu5AYoba34I=
X-Gm-Gg: ASbGncuArjB9iHqxjIQXdiHA1xkHWtEjtDhk6l/WCjm8ddp8wSFLb7T1jKjYDOHdNsW
	q/QDfJwtxxTWbtDm5j+PD/YIufVMGtxSL2XzPxCMyi/Q4jxavoLGelmlbYHVr3rpYBy5JJMgbRD
	u/6Pzr0R8JGrK13QCBz6I4IxR2MDn61XedYs7fD8LVP+7Ur8Braod0AH4pPxWDoAtOWWlczE8+q
	jJzw545ho7ACW/P/83Vt64VV7YwMYlM2Qhrm84bJAYf6Dn3YU4Z95QR66l6Jsqj8GSpd8EKnBFG
	p+vmQmz6BTQDhG4d0DYdpUX0tr+ot86FvEHTq6ls+UMp3fwY1QY+vhwwO+huAt2Rlp6LwtF9k+g
	mjYoEgtK96YfJzOQ4knzi5ih0DVDzKQiOf2Nt268EB7pnEUULxSfuCB0ALWgQjiZNSDNtZEfocP
	HYoCE4X9SXNXOiVpq1fRDmnu+UWYmqJKaSRZxfn06NJCrIHRMnUa5TSe7GwLWCiw2kfA==
X-Google-Smtp-Source: AGHT+IH7t8z7lDWKkakNj0SLYuUWwctos1aBtTyjZBDabk0/LlhiEDtCYrfnR0zT5tDvpxsBwbOmzg==
X-Received: by 2002:a05:6512:3a93:b0:592:f72f:c1d2 with SMTP id 2adb3069b0e04-592fc9d4fa5mr3566258e87.10.1761560303437;
        Mon, 27 Oct 2025 03:18:23 -0700 (PDT)
Received: from [192.168.1.2] (c-92-34-217-190.bbcust.telenor.se. [92.34.217.190])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f6e644sm2225342e87.79.2025.10.27.03.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 03:18:23 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 11:18:17 +0100
Subject: [PATCH] iio: accel: bmc150: Fix irq assumption regression
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-fix-bmc150-v1-1-ccdc968e8c37@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNz3bTMCt2k3GRDUwNd81RTMwtDI6MkIzNTJaCGgqJUoCzYsOjY2lo
 AMCLE4VwAAAA=
X-Change-ID: 20251027-fix-bmc150-7e568122b265
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: linux-iio@vger.kernel.org, stable@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.3

The code in bmc150-accel-core.c unconditionally calls
bmc150_accel_set_interrupt() in the iio_buffer_setup_ops,
such as on the runtime PM resume path giving a kernel
splat like this if the device has no interrupts:

Unable to handle kernel NULL pointer dereference at virtual
  address 00000001 when read
CPU: 0 UID: 0 PID: 393 Comm: iio-sensor-prox Not tainted
  6.18.0-rc1-postmarketos-stericsson-00001-g6b43386e3737 #73 PREEMPT
Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
PC is at bmc150_accel_set_interrupt+0x98/0x194
LR is at __pm_runtime_resume+0x5c/0x64
(...)
Call trace:
bmc150_accel_set_interrupt from bmc150_accel_buffer_postenable+0x40/0x108
bmc150_accel_buffer_postenable from __iio_update_buffers+0xbe0/0xcbc
__iio_update_buffers from enable_store+0x84/0xc8
enable_store from kernfs_fop_write_iter+0x154/0x1b4
kernfs_fop_write_iter from do_iter_readv_writev+0x178/0x1e4
do_iter_readv_writev from vfs_writev+0x158/0x3f4
vfs_writev from do_writev+0x74/0xe4
do_writev from __sys_trace_return+0x0/0x10

This bug seems to have been in the driver since the beginning,
but it only manifests recently, I do not know why.

Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/bmc150-accel-core.c | 5 +++++
 drivers/iio/accel/bmc150-accel.h      | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 3c5d1560b163..f4421a3b0ef2 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -523,6 +523,10 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 	const struct bmc150_accel_interrupt_info *info = intr->info;
 	int ret;
 
+	/* We do not always have an IRQ */
+	if (!data->has_irq)
+		return 0;
+
 	if (state) {
 		if (atomic_inc_return(&intr->users) > 1)
 			return 0;
@@ -1696,6 +1700,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	}
 
 	if (irq > 0) {
+		data->has_irq = true;
 		ret = devm_request_threaded_irq(dev, irq,
 						bmc150_accel_irq_handler,
 						bmc150_accel_irq_thread_handler,
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index 7a7baf52e595..6e9bb69a1fd4 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -59,6 +59,7 @@ enum bmc150_accel_trigger_id {
 struct bmc150_accel_data {
 	struct regmap *regmap;
 	struct regulator_bulk_data regulators[2];
+	bool has_irq;
 	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct mutex mutex;

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251027-fix-bmc150-7e568122b265

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


