Return-Path: <linux-iio+bounces-14313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8118A0C2F5
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71253A6A99
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAE71F8928;
	Mon, 13 Jan 2025 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BpBjB+Aa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C21D54FA
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802061; cv=none; b=P+amQhUW6PWMIJnPzVSmHw0KCOhKvkcYFGUe32+hFrHQvHHLhGYi5zk46u+WNQ++z3W2gOGgjXOa9Yy43mvvCBFoq6acq8aDBorJjlWrZpQZE6mWQvG0XrxpMOQcMmsi6XGR+eJ+ePNJUNkixKGl43oBYU6d/jh5EKLVnzdRhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802061; c=relaxed/simple;
	bh=PkEUx+IKdxonmVQHfwUHjeni3IBvRLaLJ3jz9AU+lBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FvN4N6qrqVEsMub0B//TnXjexQAlgok7gkw4YnvRlY9y7z5zg9X0TYIquVsDkKTo9y61kjEouB8CuxvG48HqLtbbZkCk8HbyXNqUZv1ig6OwK1kCl8Q1aEg7AjdKx8aY3eZGTuRMgrcaWfFHrXOJvjgKoFptpH6MmmZQj6V2oOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BpBjB+Aa; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71e36b27b53so2497375a34.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802057; x=1737406857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUMXly5G435wzXfcy9cF6pr2cqHAnNAJb1ILwBdzdDc=;
        b=BpBjB+AaKjS5wiJyq+AZEHdGacvQzEp+8l8Ka7+fuIv/FvirDxGwkXBp6Bh7wch7KY
         ZPIUMxPeSFmYIQ3EVkbLQFho+OES4ViA33c8ulTZA9i7hXthMEBz4cI/ro8gLUV25yr+
         NWtO9Kc4+jzTxHGYXeHNUo3fUeQuop0oRqJCPwp+6ndF5bzubX84lbEmvo+11ZoOvcrf
         w6SwnwNLDqLNbUmX8hTssyGhPAxEDFJ8SytEcBO+iabgHE2oT4xPmZ8binTVAWa42XhV
         batwhLocUbtOdSFhD/BsMavT8gAfZGXguAR6r00gQFHBD2vhJCpdVD6QMa1tYOxyF09W
         RtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802057; x=1737406857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUMXly5G435wzXfcy9cF6pr2cqHAnNAJb1ILwBdzdDc=;
        b=eU8Kh7BofizGRT/g8ZSRxXmZ56TJTq3tz7FiUM6Fpm5NZtLW73/i7QxsgtV0LHn5Ts
         iUuOpPdUtMBAfeLz+k8tk6UHz5wVr6mDqo/QJyZmepuVQfJ3Q6WQaFOP3H434k8PNOBH
         M1LH1fsfLJR5Hu0QDva5VZRZDOdtLSUcw/dtKwnrC06SLRhmBjC/wuZPhwbhoKlVRK/w
         BpwTAjSoGdzWbXSLE3NpWv1r2ZUQ417E1s7h0xyTOHg96VvPvhHQniciBBViNvshZm5T
         hkuVcLN/K9ja3lUFMMnjHLbuNGfeg1DvALbopj61BzIeNTb+Q06eKqbpfcKKkbGofFL+
         +cHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuTWhmwqiHEU2Z+MqrEcuVwNo3QHvYhTdpT8rlzzSCHImVegI4t/BYBcAuASdpDKn8FCHhMKoa8YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFTpkMpLIeQcD2phqSiuMf9ML+wxfmyrKqxaev+OgOo3yVKB/
	dSOPvTEYoeQK5LJ3B/PCoZmb54K2lh0dFNwo5XaE1xAhDFWt1H1zCMFIk5KZGOs=
X-Gm-Gg: ASbGnctEyyS8oVKhMwRHgrQp/UrLuzCdpa/6qgrE9evQnTYL5u8yXHVMERFnxxzGSnp
	WMIBk01Zq4e4hVIPGTGqJ5BCUKQzM0mymnhxlJdjWldCc+d36pFw2xMqr3Wwtz3sNCTa3F+criH
	izTZtn4VROe/HkpoY0GWuSWW13SdFthT54C1wdAbAELA+PmtDOnZBM+2z3BTmV1oNhvyu1s0lYn
	eUnl61I2NnNBWEmg8JmqoyEbsLygajkyTIp0VFctG5lTQcZHh7AbF6zTue1UZasr8Mfkvt+dYyb
	3BAtZIwgX9Vn
X-Google-Smtp-Source: AGHT+IFN0vmX+YSlnYm5UCpNH16HfLq9nwCNAFlYnWBSrfdZ1vvk5m0Y6Ba/pSGS/ESa1ZKKLltX3g==
X-Received: by 2002:a05:6830:4704:b0:71d:50f0:afc5 with SMTP id 46e09a7af769-721e2ec8d51mr17915950a34.21.1736802057370;
        Mon, 13 Jan 2025 13:00:57 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:00:56 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:09 -0600
Subject: [PATCH v7 04/17] spi: offload-trigger: add PWM trigger driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-4-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
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
index 00d80a1c680678f339a4c2ac584396edb2cbc405..6e00644a0866ae622587fa1fa8c40de7bfc752c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22271,6 +22271,7 @@ F:	include/linux/mtd/spi-nor.h
 
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


