Return-Path: <linux-iio+bounces-14752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4139A23E7B
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 14:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A8A1888E27
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 13:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508701C54BE;
	Fri, 31 Jan 2025 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZA2XY7F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815D1C5486;
	Fri, 31 Jan 2025 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330711; cv=none; b=qHg4ko7d+nvphqM/wgvxVHh1sHNtNbjatSlN+9pvDi5CVP/syCYDVnlRwfoW1v0gj4y2/wADPBC3o30sLO8Jw+TDut6kDxFygqdkR/wEtAVXTeAH1t8ueC/xvjH/gBd6ZZRlsMIQ15QYLeczDh35mPCWvaAQ/8TQjFEajx12pvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330711; c=relaxed/simple;
	bh=qVDJEPeeNE98djPQLV/AnekWmCXKylcLB4/S6HfXhX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwt8wr7+HGivQiU+bp0qFe7jwzHfK2oBI/IAw/uxHBHwGjY6fwss73reIKwGKM0N80Ob7vHL5YyrVsQHc9lvEzUoYXBsJaKwvV5cHyJhAaeBIxj0RrOl4oj24/iAO2k+9qFA4fKlO27D6NAkvsTQHTAm9Emg7O1mwq1fExCEJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZA2XY7F; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e3c47434eso2123323e87.3;
        Fri, 31 Jan 2025 05:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738330707; x=1738935507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xks8nqaxfbDP9RkUFe4/pjsT9Ei+JEQ7nDHf+BKbGpg=;
        b=mZA2XY7FhU245m8VMKOlbt7uvT6WZTpIEwsWceKwpIWaoqTdorwECv0th6MoW+/irs
         cg84Pzj4XNhvK5T71quvVkgnrEar4v6U/ovZFU7suLBsfkGeyE6+5nYmF4tK3ZIIm88Z
         /RspwoPQyxQUuarcQLAvLeLxw0h5sjfDsL8KXkU7m7Lu/kRTnEm7tV6rIcw4tJO/G4Mx
         mzynJTBkTD6iI0NRr34Dixl3PVSnNpOwsjrIKwlnGpz1pB19xaPsX4ifdjYCS2R4Swsa
         xKR9JmaEo+yzpf0aiy5ey/z6SLA0XqF1KEDAKfGP9Wc170rA0y1HfQ+h7BxaoO5R5t5d
         v7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738330707; x=1738935507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xks8nqaxfbDP9RkUFe4/pjsT9Ei+JEQ7nDHf+BKbGpg=;
        b=WPR4J2U7diJEhOKYLVpmI+JZ2CsKiJ53sYHwAngXuS++DoNA7eIxgG6eyTvS6rWFYR
         cnF7YpbUAXg25nhVe+KOUTXB7Eq6QjAueZJ1S9paXE/8D7hhjrVHr2KLYoR71Cx/Xkh1
         NyLtuLsh8s/FscPyoHlDXQwoTtk3+605Utsj0NrybYlEh37Lf89tWEWNm6KTfrceGb+o
         GM1pIk5DtRg6wtMrSbX/1wWDIfMCyv9XqGOW150BCH7nlVQzue5iMqhQInqjBsn+D0pa
         7VYg48Q5xRXyEzZQcV7280Xy+4escgFOAEKF3DDAtpEVV996hCLTXWSlfBL8bqqiJLJw
         8TFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLvkeTeXy+vREYLL13F1Ckq2Vba732xNsIOWhzKcJ1URUeP+kJjSN00kJ914aDTn1QykHJScyn0YD5yg==@vger.kernel.org, AJvYcCX+qOb2gDbiTWXvrBAp8iGtCLQnfxDTmYypvqtva1r+m/IO7MzJ/db17afI+BkmUFFhzjWJqTcn+ZuJ@vger.kernel.org, AJvYcCXGwMo6LWrJTWFYT20s+ZR3aKVHi04u656nRz+vj3V0/hh4HfnTyEZ4V36jrALOsiv+A9uVVyyELqk1@vger.kernel.org, AJvYcCXeRpxbuHRDkgVg9bhQ/x8l9wOmfSA4mD14E1xeW2dUnajSLW4UcyKSE/OD6FnIQM8j/6k4FUmxe0uF1tUM@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0UkESSUNb/0/0/zZpZatqJyzNI2JsuBIBwTi5rCMMfFqnw88
	j0a2AgBuR+GocM1KOPjN1Uk3PG5XppDqmtRYzH8lZiYNElEp3xD/
X-Gm-Gg: ASbGncvAgfv+2nuU2RtrEtF3T941K6eaYv/a4Y2PV+QZD08cNQsO3VcU1BCdO/PLgi2
	Tyb74rjmFTarXFIrWvW75urDgXDY83UbAdGV/QqF4x2CZKwsRCb7+zk3ENeHLEmOgxQ3gqmRPI6
	GDDYrhee7aUpfkHxRFq9eIhtmVrQCKqOWL0DzgU+uGO/UYSRLUFFlO8B4X97IppSrzJUvmKKXO2
	68CwcbH297KvKxXEeTl1gIA0dm4g3ucqV0PTT7ZmrzzFijN9Cq+fkGxJQjPIZH00EBft2TorFvQ
	KSHWI9ajk9zp1mP3yGbL2ITvqVu9L3ECGoDiQqkPrHNgajo=
X-Google-Smtp-Source: AGHT+IEIVvrLzfycbwJtNgTwvGjmij6z7XlZ28AzUTj5xyjJOnyBbOvoTLskpc54B25Mb/DMF2bEsg==
X-Received: by 2002:a05:6512:1089:b0:542:6d01:f55c with SMTP id 2adb3069b0e04-543e4bdf58bmr4285653e87.3.1738330706640;
        Fri, 31 Jan 2025 05:38:26 -0800 (PST)
Received: from mva-rohm (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebdf1046sm479993e87.10.2025.01.31.05.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 05:38:24 -0800 (PST)
Date: Fri, 31 Jan 2025 15:38:15 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RFC PATCH 4/5] pinctrl: Support ROHM BD79124 pinmux / GPO
Message-ID: <3d85fe979fca352bed4d9841e3233c055dfaf154.1738328714.git.mazziesaccount@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JI/5detke+jV38o3"
Content-Disposition: inline
In-Reply-To: <cover.1738328714.git.mazziesaccount@gmail.com>


--JI/5detke+jV38o3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The AIN pins can be
used as ADC inputs, or as general purpose outputs.

Support changing pin function (GPO / ADC) and the gpo output control.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---

NOTE: This patch is not properly tested. More thorough testing is to be
done prior v2 if this pinmux approach makes sense.

 drivers/pinctrl/Kconfig           |  11 ++
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-bd79124.c | 276 ++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-bd79124.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 95a8e2b9a614..7dd9bb0d1ab4 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -145,6 +145,17 @@ config PINCTRL_AW9523
=20
 	  Say yes to enable pinctrl and GPIO support for the AW9523(B).
=20
+config PINCTRL_BD79124
+	tristate "Rohm BD79124 ADC/GPO"
+	depends on MFD_ROHM_BD79124
+	select PINMUX
+	select GPIOLIB
+	help
+	  The Rohm BD79124 is a 12-bit, 8-channel, SAR ADC. The analog input
+	  pins can also be configured to be used as general purpose outputs.
+
+	  Say yes to enable the pinmux and GPOs.
+
 config PINCTRL_BM1880
 	bool "Bitmain BM1880 Pinctrl driver"
 	depends on OF && (ARCH_BITMAIN || COMPILE_TEST)
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index fba1c56624c0..0caf6dc3d2c1 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PINCTRL_AT91PIO4)	+=3D pinctrl-at91-pio4.o
 obj-$(CONFIG_PINCTRL_AW9523)	+=3D pinctrl-aw9523.o
 obj-$(CONFIG_PINCTRL_AXP209)	+=3D pinctrl-axp209.o
 obj-$(CONFIG_PINCTRL_BM1880)	+=3D pinctrl-bm1880.o
+obj-$(CONFIG_PINCTRL_BD79124)	+=3D pinctrl-bd79124.o
 obj-$(CONFIG_PINCTRL_CY8C95X0)	+=3D pinctrl-cy8c95x0.o
 obj-$(CONFIG_PINCTRL_DA850_PUPD) +=3D pinctrl-da850-pupd.o
 obj-$(CONFIG_PINCTRL_DA9062)	+=3D pinctrl-da9062.o
diff --git a/drivers/pinctrl/pinctrl-bd79124.c b/drivers/pinctrl/pinctrl-bd=
79124.c
new file mode 100644
index 000000000000..8d25b1c5345f
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-bd79124.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ROHM BD79124 ADC / GPO pinmux.
+ *
+ * Copyright (c) 2025, ROHM Semiconductor.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/mfd/rohm-bd79124.h>
+#include "pinctrl-utils.h"
+
+/*
+ * The driver expects pins top have 1 to 1 mapping to the groups.
+ * Eg, pin 'ID 0' is AIN0, and can be directly mapped to the group "ain0",=
 which
+ * also uses group ID 0. The driver mix and match the pin and group IDs. T=
his
+ * works because we don't have any specific multi-pin groups. If I knew ty=
pical
+ * use cases better I might've been able to create some funtionally meanin=
gful
+ * groups - but as I don't, I just decided to create per-pin groups for to=
ggling
+ * and individual pin to ADC-input or GPO mode. I believe this gives the
+ * flexibility for generic use-cases.
+ *
+ * If this is a false assumption and special groups are needed, then the p=
in <=3D>
+ * group mapping in this driver must be reworked. Meanwhile just keep the =
pin
+ * and group IDs matching!
+ */
+static const struct pinctrl_pin_desc bd79124_pins[] =3D {
+	PINCTRL_PIN(0, "ain0"),
+	PINCTRL_PIN(1, "ain1"),
+	PINCTRL_PIN(2, "ain2"),
+	PINCTRL_PIN(3, "ain3"),
+	PINCTRL_PIN(4, "ain4"),
+	PINCTRL_PIN(5, "ain5"),
+	PINCTRL_PIN(6, "ain6"),
+	PINCTRL_PIN(7, "ain7"),
+};
+
+static const char * const bd79124_pin_groups[] =3D {
+	"ain0",
+	"ain1",
+	"ain2",
+	"ain3",
+	"ain4",
+	"ain5",
+	"ain6",
+	"ain7",
+};
+
+static int bd79124_get_groups_count(struct pinctrl_dev *pcdev)
+{
+	return ARRAY_SIZE(bd79124_pin_groups);
+}
+
+static const char *bd79124_get_group_name(struct pinctrl_dev *pctldev,
+					   unsigned int group)
+{
+	return bd79124_pin_groups[group];
+}
+
+enum {
+	BD79124_FUNC_GPO,
+	BD79124_FUNC_ADC,
+	BD79124_FUNC_AMOUNT
+};
+
+static const char * const bd79124_functions[BD79124_FUNC_AMOUNT] =3D {
+	[BD79124_FUNC_GPO] =3D "gpo",
+	[BD79124_FUNC_ADC] =3D "adc",
+};
+
+struct bd79124_mux_data {
+	struct device *dev;
+	struct regmap *map;
+	struct pinctrl_dev *pcdev;
+	struct gpio_chip gc;
+};
+
+static int bd79124_pmx_get_functions_count(struct pinctrl_dev *pcdev)
+{
+	return BD79124_FUNC_AMOUNT;
+}
+
+static const char *bd79124_pmx_get_function_name(struct pinctrl_dev *pcdev,
+						  unsigned int selector)
+{
+	return bd79124_functions[selector];
+}
+
+static int bd79124_pmx_get_function_groups(struct pinctrl_dev *pcdev,
+		unsigned int selector,
+		const char * const **groups,
+		unsigned int * const num_groups)
+{
+	*groups =3D &bd79124_pin_groups[0];
+	*num_groups =3D ARRAY_SIZE(bd79124_pin_groups);
+
+	return 0;
+}
+
+static int bd79124_pmx_set(struct pinctrl_dev *pcdev, unsigned int func,
+			   unsigned int group)
+{
+	struct bd79124_mux_data *d =3D pinctrl_dev_get_drvdata(pcdev);
+
+	/* We use 1 to 1 mapping for grp <=3D> pin */
+	if (func =3D=3D BD79124_FUNC_GPO)
+		return regmap_set_bits(d->map, BD79124_REG_PINCFG, BIT(group));
+
+	return regmap_clear_bits(d->map, BD79124_REG_PINCFG, BIT(group));
+}
+
+/*
+ * Check that the pinmux has set this pin as GPO before allowing it to be =
used.
+ * NOTE: There is no locking in the pinctrl driver to ensure the pin _stay=
s_
+ * appropriately muxed. It is the responsibility of the device using this =
GPO
+ * (or ADC) to reserve the pin from the pinmux.
+ */
+static bool bd79124_is_gpo(struct bd79124_mux_data *d, unsigned int offset)
+{
+	int ret, val;
+
+	ret =3D regmap_read(d->map, BD79124_REG_PINCFG, &val);
+	/*
+	 * If read fails, don't allow setting GPO value as we don't know if
+	 * pin is used as AIN. (In which case we might upset the device being
+	 * measured - although I suppose the BD79124 would ignore the set value
+	 * if pin is used as AIN - but better safe than sorry, right?
+	 */
+	if (ret)
+		return 0;
+
+	return (val & BIT(offset));
+}
+
+static int bd79124gpo_direction_get(struct gpio_chip *gc, unsigned int off=
set)
+{
+	struct bd79124_mux_data *d =3D gpiochip_get_data(gc);
+
+	if (!bd79124_is_gpo(d, offset))
+		return -EINVAL;
+
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int =
value)
+{
+	struct bd79124_mux_data *d =3D gpiochip_get_data(gc);
+
+	if (!bd79124_is_gpo(d, offset)) {
+		dev_dbg(d->dev, "Bad GPO mux mode\n");
+		return;
+	}
+
+	if (value)
+		regmap_set_bits(d->map, BD79124_REG_GPO_VAL, BIT(offset));
+
+	regmap_clear_bits(d->map, BD79124_REG_GPO_VAL, BIT(offset));
+}
+
+static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *m=
ask,
+				   unsigned long *bits)
+{
+	int ret, val;
+	struct bd79124_mux_data *d =3D gpiochip_get_data(gc);
+
+	/* Ensure all GPIOs in 'mask' are set to be GPIOs */
+	ret =3D regmap_read(d->map, BD79124_REG_PINCFG, &val);
+	if (ret)
+		return;
+
+	if ((val & *mask) !=3D *mask) {
+		dev_dbg(d->dev, "Invalid mux config. Can't set value.\n");
+		/* Do not set value for pins configured as ADC inputs */
+		*mask &=3D val;
+	}
+
+	regmap_update_bits(d->map, BD79124_REG_GPO_VAL, *mask, *bits);
+}
+
+/* Template for GPIO chip */
+static const struct gpio_chip bd79124gpo_chip =3D {
+	.label			=3D "bd79124-gpo",
+	.get_direction		=3D bd79124gpo_direction_get,
+	.set			=3D bd79124gpo_set,
+	.set_multiple		=3D bd79124gpo_set_multiple,
+	.can_sleep		=3D true,
+	.ngpio			=3D 8,
+	.base			=3D -1,
+};
+
+static const struct pinmux_ops bd79124_pmxops =3D {
+	.get_functions_count =3D bd79124_pmx_get_functions_count,
+	.get_function_name =3D bd79124_pmx_get_function_name,
+	.get_function_groups =3D bd79124_pmx_get_function_groups,
+	.set_mux =3D bd79124_pmx_set,
+};
+
+static const struct pinctrl_ops bd79124_pctlops =3D {
+	.get_groups_count =3D bd79124_get_groups_count,
+	.get_group_name =3D bd79124_get_group_name,
+	.dt_node_to_map =3D pinconf_generic_dt_node_to_map_all,
+	.dt_free_map =3D pinctrl_utils_free_map,
+};
+
+static const struct pinctrl_desc bd79124_pdesc =3D {
+	.name =3D "bd79124-pinctrl",
+	.pins =3D &bd79124_pins[0],
+	.npins =3D ARRAY_SIZE(bd79124_pins),
+	.pmxops =3D &bd79124_pmxops,
+	.pctlops =3D &bd79124_pctlops,
+};
+
+static int bd79124_probe(struct platform_device *pdev)
+{
+	struct bd79124_mux_data *d;
+	int ret;
+
+	d =3D devm_kzalloc(&pdev->dev, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	d->dev =3D &pdev->dev;
+	d->map =3D dev_get_regmap(d->dev->parent, NULL);
+	if (!d->map)
+		return dev_err_probe(d->dev, -ENODEV, "No regmap\n");
+
+	d->gc =3D bd79124gpo_chip;
+
+	ret =3D devm_pinctrl_register_and_init(d->dev->parent,
+			(struct pinctrl_desc *)&bd79124_pdesc, d, &d->pcdev);
+	if (ret)
+		return dev_err_probe(d->dev, ret, "pincontrol registration failed\n");
+	ret =3D pinctrl_enable(d->pcdev);
+	if (ret)
+		return dev_err_probe(d->dev, ret, "pincontrol enabling failed\n");
+
+	ret =3D devm_gpiochip_add_data(d->dev, &d->gc, d);
+	if (ret)
+		return dev_err_probe(d->dev, ret, "gpio init Failed\n");
+
+	return 0;
+}
+
+static const struct platform_device_id bd79124_mux_id[] =3D {
+	{ "bd79124-pinmux", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, bd79124_mux_id);
+
+static struct platform_driver bd79124_mux_driver =3D {
+	.driver =3D {
+		.name =3D "bd79124-pinmux",
+		/*
+		 * Probing explicitly requires a few millisecond of sleep.
+		 * Enabling the VDD regulator may include ramp up rates.
+		 */
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe =3D bd79124_probe,
+	.id_table =3D bd79124_mux_id,
+};
+module_platform_driver(bd79124_mux_driver);
+
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("Pinmux/GPO Driver for ROHM BD79124");
+MODULE_LICENSE("GPL");
--=20
2.48.1


--JI/5detke+jV38o3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmec0kcACgkQeFA3/03a
ocUDkwf+O8HC/go+3KsKiruRYIknCumacgHXfC6kMgdJJVzCSM1SySzg+9FJsCm1
z1jNFushEkPEwNhrvbd9BsiDBZBym/qA0Er3aR+NDTo9Z9gJpGYjDdz2C+FWW07t
NGAy+A7VNi19zdS16SgCZCZgLulTuctecMSONwA2sy+kyPwceaohy644WLXzJVox
gvJd+Rxgf8ut2o/zoJIM9YGMtz2p0Un2TYjB8XNotlvF4kvywI0O/3vDXArq8mzX
Q4bb4AWb38zKrvx8kNlvD46TU1jMNFazYdCG/GEAKlUMAmm0QfQU971IkEpmgH8q
QQNFDZrey6GBS5CkW1NUBSZ/OHT+2Q==
=JB44
-----END PGP SIGNATURE-----

--JI/5detke+jV38o3--

