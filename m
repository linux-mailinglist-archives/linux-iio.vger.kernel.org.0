Return-Path: <linux-iio+bounces-25830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59666C2ACA9
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 10:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE471348FF8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFFC2EBB98;
	Mon,  3 Nov 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xB2g1qtr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206CD2EBBB3
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162584; cv=none; b=JUgemiRAPglkYABqnSGKXi4/h+SF8b7yprq52NJItPjq0Ay+HFsGsZIQYl6GzGoaX78tquZOEI0GCy2c1yz3OQ/RAk+7aaB898u8PB5NeDuEVJ5qmtlWkbOwn6aznsKhxBcR8tOceGpu78Up4t+HbEEZ6BTr8437N/ULndD0nrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162584; c=relaxed/simple;
	bh=/fMMww+VnRA+hcUIhl7JMhlaSfVDZu5RLtut+X9bMaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lOGh9WOlGTz6mdAM7iylRcQLt3z/zPRY3e8xkcH0jMzsuady7AtH0q+GUKmyIYhrYu3tX+as8jRSrNxtDAe6adzvjI3RN8Cr7qGbYiwmNjNI2E6kdzLTubqvHzoA+3DQk3lxF3TWEiLdBSg+1YLEVMWNYuFwmJTIel4fUGGH8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xB2g1qtr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5942bac322dso758061e87.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 01:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762162580; x=1762767380; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9yW62hLGR641KE85jpQSWPUCRsBAzSiXnExBD5jnO/s=;
        b=xB2g1qtrpd44V4OkSLjf1aDJE+B1F/K45/lOKgy0lxFr194hrglfNEXsFhC+X7pyeL
         hSSu/WBingd/arXSglbELlXLqvSWC2bALZoHfglrHHKqqENqJF31SRJ/3TZjRKlptOTN
         qVm7M/z1YT6zlKDd2/HXXGf9CtH3uFXi98e43VfbLlw7UZmFQBKnDlttVtWrz0qVDVKr
         EsErNj63EDd/V0aDvaVgQf9L3NCtYSte2objlr7HTtFrifF5TVXq2PqeEeGKMtqNpltR
         dGo4htu1GsiO2+0ccHO7k1AMdXrTGAFASOPdQ8OrSTkFdqgM9tIvZeeA7IEI7f51hEpj
         Oaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162580; x=1762767380;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yW62hLGR641KE85jpQSWPUCRsBAzSiXnExBD5jnO/s=;
        b=oDHagRCeDqNiQQxFfKT77EXfXndK7pouA3fbY2GRdRbrfdLTsyzfcOa69cMT1aMhM1
         FejDvMuulvIpEIp7WFy8Ckzuasaw6DwRstEVMYOwYVtN5lU4i5bZ2wUUHuQTOAICgcO5
         T9wsY0zT245ASh/4yMyuDq1R98sOrKmq+EdTmHYA8ja81gL003tgDLxWooNk/nd7uHt8
         UZEI/mGr5+ElPLLCV6b53kCAQxEPuOi4GIobYD3lwqZr3PD52zWxzJb+nG13JdRncE14
         JadB1eHEtP23wdR+POUkEQVrrSTWBM5hhSCVwmiikLzQrOOW7WzLW1tacLqlSBNaX2dA
         RFWg==
X-Gm-Message-State: AOJu0Ywex+KhnvesxW9j1E1nRX2q2AMaEGGsDZqSb9necTtTQ/dIf+fZ
	6PqJey+r2q9FkICvXpEijH5fknO7fexcfnXIXmd3F1g/8JO2wmaDtRx5DkUCrELcOb0=
X-Gm-Gg: ASbGncs1Jb54bY8eS/WqAg513PQokS1CoISQt8Yp81SvcGTtKKYdDkYCX/9nu8BFaVy
	XBLd+4qJpiOHlVWvHStWpfGYwbKaKulMBlCjX7BTgL+JkA3Lt3wG2K6fo6Scc7llgVRL2aAjC9G
	RBa6PKlcf8HM0dmIUepK21N+rXAaJBEwwnFPtWkRp1QlhOoCPEW1MIVXuWIR0Nm6gbAKMjxVGXe
	ikI7gb9jA0fIgphnV/tjRCCUhTKfeIGQgBBnHrt6pKHMV7N7InU1hKKkfAIAk0PtHs2MQA/Sp0j
	XuNqsKKAVsuD401breTjpyy0AjR4wWTaxqoujFYPWLzyZZe0VseFvwTZqt5vz4oPZVpgluRtJkg
	1RNmSxfrxPS1wTXcBt1CcbyXpkYfcKHtPKfUcMta7rtkqSJgrkPwdLYOzgcyDQdIVJwUmmY3LHJ
	gzSRn+X4sdCFMc0bzcrtMzxJOefN2ouGilXb5Z77g1Iqs8
X-Google-Smtp-Source: AGHT+IEbLGArSP9pXAbGMd97ofMZmPRcH8dCTCvclwnpkuf4fwAmP+p9NpZYFomPMnXnC7iNc9dIaQ==
X-Received: by 2002:ac2:4c49:0:b0:594:2df2:84ab with SMTP id 2adb3069b0e04-5942df28800mr633101e87.8.1762162580137;
        Mon, 03 Nov 2025 01:36:20 -0800 (PST)
Received: from [192.168.1.2] (c-92-34-217-190.bbcust.telenor.se. [92.34.217.190])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f39c0fdsm2722074e87.39.2025.11.03.01.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:36:19 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 03 Nov 2025 10:36:18 +0100
Subject: [PATCH v2] iio: accel: bmc150: Fix irq assumption regression
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-fix-bmc150-v2-1-0811592259df@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22MywrCMBBFf6XM2kgykoeu/A/pok3HdkCTkkhQS
 v7d2LXLcy/nbJApMWW4dBskKpw5hgZ46MAvQ5hJ8NQYUKJWEq2481uMT6+0FJa0cQpxRKOhCWu
 i9u6xW9944fyK6bO3i/qtfzNFCSW8n/zZOHL+ZK8PDkOKx5hm6GutX6YOqd+lAAAA
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

Store the IRQ number in the state struct, as this is a common
pattern in other drivers, then use this to determine if we have
IRQ support or not.

Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Instead of a bool has_irq in the state struct, store the Linux IRQ
  number itself and switch behaviour on that.
- Link to v1: https://lore.kernel.org/r/20251027-fix-bmc150-v1-1-ccdc968e8c37@linaro.org
---
 drivers/iio/accel/bmc150-accel-core.c | 5 +++++
 drivers/iio/accel/bmc150-accel.h      | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 3c5d1560b163..42ccf0316ce5 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -523,6 +523,10 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 	const struct bmc150_accel_interrupt_info *info = intr->info;
 	int ret;
 
+	/* We do not always have an IRQ */
+	if (data->irq <= 0)
+		return 0;
+
 	if (state) {
 		if (atomic_inc_return(&intr->users) > 1)
 			return 0;
@@ -1696,6 +1700,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	}
 
 	if (irq > 0) {
+		data->irq = irq;
 		ret = devm_request_threaded_irq(dev, irq,
 						bmc150_accel_irq_handler,
 						bmc150_accel_irq_thread_handler,
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index 7a7baf52e595..e8f26198359f 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -58,6 +58,7 @@ enum bmc150_accel_trigger_id {
 
 struct bmc150_accel_data {
 	struct regmap *regmap;
+	int irq;
 	struct regulator_bulk_data regulators[2];
 	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251027-fix-bmc150-7e568122b265

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


