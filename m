Return-Path: <linux-iio+bounces-15135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64B1A2CDA5
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF01188D8F8
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E061B0401;
	Fri,  7 Feb 2025 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HQEQrEw4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2A1A5BA6
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958973; cv=none; b=jhe/XdUbvi6912M0MjcDYbvBSC96sjUEUEOU/l2OfrmQbAG4+DM2sixd5WDIkzmoIsUfFGlljLBp+9JXA/rpnX2daZsu/flruf0uqHAXAExEEORvlehIeMkXIhkexM2xw9vdIQIiE0Mbw2Nv9O5a8BwhgcIRL6UHahtrS14f4bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958973; c=relaxed/simple;
	bh=3RT+o1+T0VbqeXfjdh2+I26pJ7Uif/2+uVUfZuMToWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jyl/Q9fBb68Ottl7olk6IZyB/IYQR6nWCtKHIo54xDbBXkM9JSZk5006sxbkdjSIexE5fA+kWXsFYIYem4uG9vRFzinBp825curv4ERTKXWdf6twxjqdt2hRkVZESBttnXrpbE/L2QZbZ+zTBPvYPtpJy1V1gvLSXVYHcLFlBXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HQEQrEw4; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f63c89e72bso628454eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 12:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958971; x=1739563771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kk3LC/T2vaIR0Ht/6x/1dzEkwGWvB2I87emNxfb/ik=;
        b=HQEQrEw42+MnueNJ8Z8UeaK5vJtFWqQFhSrreDl4cVvl00eE4afs4GClD2/Buanzb7
         8ATGibNUsCKWG+6tea35f0LdwdzWFAdlNKItoouX5f0BtC5uznCt7VAsly/qk+B1r2PI
         RpE7XagFIBruXg/BkgBmmx3lpewZgALI/x+37BwTmgQgkZfMSAcswbW5Z6IU/Mfi3Ixp
         cioIZucs5HOEn8qqXhOaAzmzwoq2sRzpn02dBwoMZdZh9JbF8MVNjSkRxjOeChKX0S6q
         L20E+GPmotHi66JUNJkG/D05WUCWIkbcP3v55UFAI4pbjMm4GVYnipTnyrhJ6eKHZBeK
         Q/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958971; x=1739563771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kk3LC/T2vaIR0Ht/6x/1dzEkwGWvB2I87emNxfb/ik=;
        b=R7Bps8wR16wnSCp+ZlVet4A91xDlynfo75LWEzNQBvJhn58RySDIYXJUdD0u8Xajfs
         MwpSqxoIYfaDi6j2fgLadGddX2EIrPZg+Vs+qMhdw3I7pX7eQs8S6Eks3Btjyeq+Me/C
         Ezv5Ec9i1CrQJo6x2Ag/0EzhyFYsj7sWw41+O1yxopHKxtEHaCy14F3iVDEnWREx/u/e
         z5m/MoSgk8KxUxtVOamEKbNmvSFCWj388L2N2WUtZ4aimQiTJeUnW0ZLyt1zNYkERmBj
         fgb3HrvfOdviBrsy5OI7Ea7q5VbdmVwmOWfLWucm9sOkNd3J5rUPU5voKBLeZvL4tYlR
         +CHg==
X-Forwarded-Encrypted: i=1; AJvYcCWWFq+t9Fmoqg9EOjadohf7w3t511J0TPP+4nWX/9y4p6cmU3IPUxSzLns0HiiACRrqo+VjPAFru/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybD5xf4lXRWiNFHBUTDqNbWgGelmvi8irDvAkFKxL0QCtsbe8r
	mlHnNPEyrwjImEczfAF2V5ifdoUKbigQ1O2XX4f0svfQsINvSf/2YIj5wV+xU7Q=
X-Gm-Gg: ASbGncvAdmVaiZu1f9fAxCF1todJYQUKUzIkzrjXjGdPFWE7l/ijAXBUkbReg2av/qA
	5z4P4wzlISG6xcdYoNcmYCkwDQjoHLnCak7PbMLz7G0Jsc2kFVBi0N/vXjKHI67zjtnG2QRR9e8
	1cLrk0ITMsVQEgAM/4mSMkmuJfk6Cn+1DEDILI2YTLz8455JgDMyvMSHr+7hV6lU6bJKW0aOInr
	YpX8VLBSe4Qr4kaDE4N2I2APGnpJY+j8P5bz4aBF/kaTYTuijUf+C3Yu/rsE1n+YIjEznkSCaKg
	3uHraOUB/EzMSHH5OMu/QDbtSPfl0cYQc5eR42jgxIUqors=
X-Google-Smtp-Source: AGHT+IHHPAH+wQlAPWj4MVF5kQsTJi5JwWku/ib98UqIUvEioLfz44zhppCON7R0C22y2qbkvgZspw==
X-Received: by 2002:a05:6820:1ac2:b0:5fa:64c3:2938 with SMTP id 006d021491bc7-5fc5e5c6310mr2949325eaf.2.1738958971025;
        Fri, 07 Feb 2025 12:09:31 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:01 -0600
Subject: [PATCH v8 04/17] spi: offload-trigger: add PWM trigger driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-4-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a new driver for a generic PWM trigger for SPI offloads.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Use dev instead of &pdev->dev
* Swap order of "pwm" and "trigger" in name to follow "pwm-clock"
  precedent.

v5 changes:
* Updated to accommodate changes in other patches in this series.
* Add MAINTAINERS entry.

v4 changes: new patch in v4
---
 MAINTAINERS                           |   1 +
 drivers/spi/Kconfig                   |  12 +++
 drivers/spi/Makefile                  |   3 +
 drivers/spi/spi-offload-trigger-pwm.c | 162 ++++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6ac6cdc6278536b5c4f81ff183588b491798036..c94061c5012843825b2f6ba9a3063f230e5d654e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22344,6 +22344,7 @@ F:	include/linux/mtd/spi-nor.h
 
 SPI OFFLOAD
 R:	David Lechner <dlechner@baylibre.com>
+F:	drivers/spi/spi-offload-trigger-pwm.c
 F:	drivers/spi/spi-offload.c
 F:	include/linux/spi/spi-offload.h
 K:	spi_offload
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 02064a4e292815ec0213e2e446b4f90ed8855a52..2cfc14be869790f5226130428bb7cb40aadfb031 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1320,4 +1320,16 @@ endif # SPI_SLAVE
 config SPI_DYNAMIC
 	def_bool ACPI || OF_DYNAMIC || SPI_SLAVE
 
+if SPI_OFFLOAD
+
+comment "SPI Offload triggers"
+
+config SPI_OFFLOAD_TRIGGER_PWM
+	tristate "SPI offload trigger using PWM"
+	depends on PWM
+	help
+	  Generic SPI offload trigger implemented using PWM output.
+
+endif # SPI_OFFLOAD
+
 endif # SPI
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index bb5fc20df21332232533c2e70c0cc230f6bcf27f..0068d170bc99c750c13376c4013991d927bbac63 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -164,3 +164,6 @@ obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
 obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+= spi-slave-system-control.o
+
+# SPI offload triggers
+obj-$(CONFIG_SPI_OFFLOAD_TRIGGER_PWM)	+= spi-offload-trigger-pwm.o
diff --git a/drivers/spi/spi-offload-trigger-pwm.c b/drivers/spi/spi-offload-trigger-pwm.c
new file mode 100644
index 0000000000000000000000000000000000000000..b26d4437c589052709a8206f8314ffd08355870e
--- /dev/null
+++ b/drivers/spi/spi-offload-trigger-pwm.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ *
+ * Generic PWM trigger for SPI offload.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/mod_devicetable.h>
+#include <linux/spi/offload/provider.h>
+#include <linux/types.h>
+
+struct spi_offload_trigger_pwm_state {
+	struct device *dev;
+	struct pwm_device *pwm;
+};
+
+static bool spi_offload_trigger_pwm_match(struct spi_offload_trigger *trigger,
+					  enum spi_offload_trigger_type type,
+					  u64 *args, u32 nargs)
+{
+	if (nargs)
+		return false;
+
+	return type == SPI_OFFLOAD_TRIGGER_PERIODIC;
+}
+
+static int spi_offload_trigger_pwm_validate(struct spi_offload_trigger *trigger,
+					    struct spi_offload_trigger_config *config)
+{
+	struct spi_offload_trigger_pwm_state *st = spi_offload_trigger_get_priv(trigger);
+	struct spi_offload_trigger_periodic *periodic = &config->periodic;
+	struct pwm_waveform wf = { };
+	int ret;
+
+	if (config->type != SPI_OFFLOAD_TRIGGER_PERIODIC)
+		return -EINVAL;
+
+	if (!periodic->frequency_hz)
+		return -EINVAL;
+
+	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
+	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
+	wf.duty_length_ns = wf.period_length_ns / 2;
+
+	ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
+	if (ret < 0)
+		return ret;
+
+	periodic->frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.period_length_ns);
+
+	return 0;
+}
+
+static int spi_offload_trigger_pwm_enable(struct spi_offload_trigger *trigger,
+					  struct spi_offload_trigger_config *config)
+{
+	struct spi_offload_trigger_pwm_state *st = spi_offload_trigger_get_priv(trigger);
+	struct spi_offload_trigger_periodic *periodic = &config->periodic;
+	struct pwm_waveform wf = { };
+
+	if (config->type != SPI_OFFLOAD_TRIGGER_PERIODIC)
+		return -EINVAL;
+
+	if (!periodic->frequency_hz)
+		return -EINVAL;
+
+	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
+	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
+	wf.duty_length_ns = wf.period_length_ns / 2;
+
+	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
+}
+
+static void spi_offload_trigger_pwm_disable(struct spi_offload_trigger *trigger)
+{
+	struct spi_offload_trigger_pwm_state *st = spi_offload_trigger_get_priv(trigger);
+	struct pwm_waveform wf;
+	int ret;
+
+	ret = pwm_get_waveform_might_sleep(st->pwm, &wf);
+	if (ret < 0) {
+		dev_err(st->dev, "failed to get waveform: %d\n", ret);
+		return;
+	}
+
+	wf.duty_length_ns = 0;
+
+	ret = pwm_set_waveform_might_sleep(st->pwm, &wf, false);
+	if (ret < 0)
+		dev_err(st->dev, "failed to disable PWM: %d\n", ret);
+}
+
+static const struct spi_offload_trigger_ops spi_offload_trigger_pwm_ops = {
+	.match = spi_offload_trigger_pwm_match,
+	.validate = spi_offload_trigger_pwm_validate,
+	.enable = spi_offload_trigger_pwm_enable,
+	.disable = spi_offload_trigger_pwm_disable,
+};
+
+static void spi_offload_trigger_pwm_release(void *data)
+{
+	pwm_disable(data);
+}
+
+static int spi_offload_trigger_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_offload_trigger_info info = {
+		.fwnode = dev_fwnode(dev),
+		.ops = &spi_offload_trigger_pwm_ops,
+	};
+	struct spi_offload_trigger_pwm_state *st;
+	struct pwm_state state;
+	int ret;
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	info.priv = st;
+	st->dev = dev;
+
+	st->pwm = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->pwm))
+		return dev_err_probe(dev, PTR_ERR(st->pwm), "failed to get PWM\n");
+
+	/* init with duty_cycle = 0, output enabled to ensure trigger off */
+	pwm_init_state(st->pwm, &state);
+	state.enabled = true;
+
+	ret = pwm_apply_might_sleep(st->pwm, &state);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to apply PWM state\n");
+
+	ret = devm_add_action_or_reset(dev, spi_offload_trigger_pwm_release, st->pwm);
+	if (ret)
+		return ret;
+
+	return devm_spi_offload_trigger_register(dev, &info);
+}
+
+static const struct of_device_id spi_offload_trigger_pwm_of_match_table[] = {
+	{ .compatible = "pwm-trigger" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spi_offload_trigger_pwm_of_match_table);
+
+static struct platform_driver spi_offload_trigger_pwm_driver = {
+	.driver = {
+		.name = "pwm-trigger",
+		.of_match_table = spi_offload_trigger_pwm_of_match_table,
+	},
+	.probe = spi_offload_trigger_pwm_probe,
+};
+module_platform_driver(spi_offload_trigger_pwm_driver);
+
+MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
+MODULE_DESCRIPTION("Generic PWM trigger");
+MODULE_LICENSE("GPL");

-- 
2.43.0


