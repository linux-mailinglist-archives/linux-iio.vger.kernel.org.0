Return-Path: <linux-iio+bounces-14751-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B739A23E82
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 14:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FEE3AA115
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645611C548A;
	Fri, 31 Jan 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWmeDqJe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7A1C5486;
	Fri, 31 Jan 2025 13:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738330688; cv=none; b=WZvRY9JwfK4VLteT2nF/duYy2nQ7IsrzYA1wq9OPZTrIaTvfBgfQkxLm8Qk1ewyXZE2krSfoJ08LZ5+qdgzCUFgFuQB0BV6/Cg0omfI9kKhIUxcEWVZPvRLoU5+tExQiQdvtJpN8hML+C9wr/q6GR1JghhD70te3gzPCnmYnkmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738330688; c=relaxed/simple;
	bh=Jhnc9C162SBMnlh8Aw9W4SJkW5VhUFUMCZAxJk18hW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq8Nz1NGQhLEmUvbkO0qQuioDGHVI6N5SEGwehm5B7ohT/eocpKWhheNd4UtXLbEUu4HSSmWT45o/v4P6qbiaR03wLYs/8fHRc9POMqG/bubTmMpU70Ta9vCXKbTAUWFDyCh9vkj77kyOoijMjghc3LKoCDLe3h1r3NCHmthxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWmeDqJe; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e384e3481so1767507e87.2;
        Fri, 31 Jan 2025 05:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738330683; x=1738935483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oChDXhqHKkUhDSAVlgwGEcs7Wy72o9JPn+1bew9OjO8=;
        b=NWmeDqJeas/D3bPhNBmo25fMEOd/Wudlw9bzRe1phzquMns0pJnyr4p7oH4jDpofHt
         O6ma8jq7+NGMDDOJ3kSmftyeIZ9o36L/Obr8GRrm9TwCwFy5ZqYUXj6oEY9mfCQjp0Gs
         IfdCz8YJVijFo2YK8NSTU3UICZvwz96GyB6burNSRo5zhjek1KvWA1EOS9NJilI7Ie9a
         /wWwXzXrHCmzobTdp7hqsl1ycq/kR4eJCvytDmFLMU2gjJM4dkEjEp9OLldvQAx2pPXg
         NkMPAHy2Z5umx9U6fVDG1yaqsN0BN4pE0SOtAip8s7RubSlXpAE0BrnbsT5ngLHMz3+6
         9RwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738330683; x=1738935483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oChDXhqHKkUhDSAVlgwGEcs7Wy72o9JPn+1bew9OjO8=;
        b=ILI7fzIa8Mb9lrCNoeguq5QnSRuD7aO+WSxsEd6sLRlLGVRBNuF51D84HnrrUf/baw
         RD4kVMoAsBkEQVU9HDr8UDzMOz2FOQ/Uwu7oFx2LeQKb4tQujAsZ2wl5gFXqITOXf7Xs
         Gz4ul3fVxtCmgfrcyu+hgCzz7B62L1fpRYAqObVVRyKth4CmEWY/NMgsbgJs0phYUx0e
         sta2gVqbEJb6WxCVEKH/ktNfJDf6Ra/UEWTt71Pz7T4NrNQpRc4KmwUKYgcQznY4ghoM
         0neWSOusi8Oc0vApDwxm6oLTPGdzHIjkxdK/90HmyMfTU9ZMDRhWzSeMJUdrboSg+b/f
         S6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpHC7IW3eYjuue2GHV5/JLt7W6Osc5gzJENQ7Im/umvNiPTw1LHyeZr1TNG/8dDfKTm6SiB7DjicMk@vger.kernel.org, AJvYcCX/PJhlZ8NGU+FAOpE8OMH8K240EmBM8lLyjYNLYdYPz18iWbBYGDNCkEy9t1UHlTMlsSvTETGDtJ7+ww==@vger.kernel.org, AJvYcCXHRsOoXjOWWuIuwFA+FdvuHnBG8ZMYow/9S9VK6vZggkO0rdbOdnrH3lI+Bl3D24YALX7HwWn0yt7Re04A@vger.kernel.org, AJvYcCXkl+ok6vslZuxZmJYWlFjN5Rckp6g5woC/c7RrOgvCuKPEaDwgqI3sMRybfsqGJntUmWb3sVP39H1X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8sHVHpsU7yL87SuFli4DoOgr8UGY6ONNiue8f+RmuxnDMnLfO
	/u/p9RTZi9JxdNA8y5BAKcJFHCyUWU0wbNuSbGTseKd+2nA5Aads
X-Gm-Gg: ASbGnctrZaxafj2rnn21dsFNNVVjYL4QdzIx3peeB1ffDHfEO5S0eO8Q7qmmOeEJ3uO
	t/0ohq+QGK3nPpEKQlU93lJxf3L2wj4CLbUtU85ywtOg9UnHrM87FWDrUdrto0cUJ9zttdoVMoE
	ifVquPcWH5YHxyRoK1zpIKozX8BqIODLHoCpU3ja36c4zdYzGNmAc/0zP2WU1ye27nUew0xZe3M
	w2HrqxQ6s6n3KNvRCEpiWwlBjCOeWXA9oQvITmMQspcdq2BICJIWRpC37XR8vfp/LYVv334uff2
	6o4/4pZqx0rJ6IyGRQbnG0PiR7Fm3BlJ6qagEiE99BK7A4o=
X-Google-Smtp-Source: AGHT+IFuwFzi2QvcmYBgAjDpfnthnUqAYoaocfqDGvVvfJUHpQIZzJd93tu4deUe/+1CTeVR2YFUdQ==
X-Received: by 2002:a05:6512:38d1:b0:540:358d:d9b5 with SMTP id 2adb3069b0e04-543e4ba64a1mr2876542e87.0.1738330682742;
        Fri, 31 Jan 2025 05:38:02 -0800 (PST)
Received: from mva-rohm (85-23-190-22.bb.dnainternet.fi. [85.23.190.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebebec5esm486551e87.236.2025.01.31.05.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 05:38:00 -0800 (PST)
Date: Fri, 31 Jan 2025 15:37:48 +0200
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
Subject: [RFC PATCH 3/5] iio: adc: Support ROHM BD79124 ADC
Message-ID: <e44851669ce7e91d1295ab7352535c93b89d35bf.1738328714.git.mazziesaccount@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B5xHhQjeBAxx0fyd"
Content-Disposition: inline
In-Reply-To: <cover.1738328714.git.mazziesaccount@gmail.com>


--B5xHhQjeBAxx0fyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
an automatic measurement mode, with an alarm interrupt for out-of-window
measurements. The window is configurable for each channel.

The I2C protocol for manual start of the measurement and data reading is
somewhat peculiar. It requires the master to do clock stretching after
sending the I2C slave-address until the slave has captured the data.
Needless to say this is not well suopported by the I2C controllers.

Thus the driver does not support the BD79124's manual measurement mode
but implements the measurements using automatic measurement mode relying
on the BD79124's ability of storing latest measurements into register.

The driver does also support configuring the threshold events for
detecting the out-of-window events.

The BD79124 keeps asserting IRQ for as long as the measured voltage is
out of the configured window. Thus the driver disables the event when
first event is handled. This prevents the user-space from choking on the
events - but it also requires the user space to reconfigure and
re-enable the monitored event when it wants to keep monitoring for new
occurrences.

It is worth noting that the ADC input pins can be also configured as
general purpose outputs. The pin mode should be configured using pincmux
driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

Regarding disabling the event upon reception - is this totally strange?
Is regular userspace compeletely unprepared for this, and better
prepared for handling large amounts of continuous events?

The BD79124 should not cause a total CPU-blocking IRQ storm because the
driver uses the autonomous sequencer mode - which has minimum of 0.75
millisecond delay between measurements. So, new IRQs can be raised with
this interval. (The 0.75 mS includes handling and acking / status reading
delays - so there is still not much time for things done outside of the
IRQ handling...)
---
 drivers/iio/adc/Kconfig            |  10 +
 drivers/iio/adc/Makefile           |   1 +
 drivers/iio/adc/rohm-bd79124-adc.c | 890 +++++++++++++++++++++++++++++
 3 files changed, 901 insertions(+)
 create mode 100644 drivers/iio/adc/rohm-bd79124-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..195a61ba5cf4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1188,6 +1188,16 @@ config RN5T618_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called rn5t618-adc.
=20
+config ROHM_BD79124
+	tristate "Rohm BD79124 ADC driver"
+	depends on MFD_ROHM_BD79124
+	help
+	  Say yes here to build support for the ROHM BD79124 ADC. The
+	  ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
+	  also an automatic measurement mode, with an alarm interrupt for
+	  out-of-window measurements. The window is configurable for each
+	  channel.
+
 config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ee19afba62b7..7049d984682d 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_QCOM_VADC_COMMON) +=3D qcom-vadc-common.o
 obj-$(CONFIG_RCAR_GYRO_ADC) +=3D rcar-gyroadc.o
 obj-$(CONFIG_RICHTEK_RTQ6056) +=3D rtq6056.o
 obj-$(CONFIG_RN5T618_ADC) +=3D rn5t618-adc.o
+obj-$(CONFIG_ROHM_BD79124) +=3D rohm-bd79124-adc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
 obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
diff --git a/drivers/iio/adc/rohm-bd79124-adc.c b/drivers/iio/adc/rohm-bd79=
124-adc.c
new file mode 100644
index 000000000000..7c95a1de1e71
--- /dev/null
+++ b/drivers/iio/adc/rohm-bd79124-adc.c
@@ -0,0 +1,890 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ROHM ADC driver for BD79124 ADC/GPO device
+ * https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_converter=
/dac/bd79124muf-c-e.pdf
+ *
+ * Copyright (c) 2025, ROHM Semiconductor.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/mfd/rohm-bd79124.h>
+
+#define BD79124_ADC_BITS 12
+#define BD79124_MASK_CONV_MODE GENMASK(6, 5)
+#define BD79124_MASK_AUTO_INTERVAL GENMASK(1, 0)
+#define BD79124_CONV_MODE_MANSEQ 0
+#define BD79124_CONV_MODE_AUTO 1
+#define BD79124_INTERVAL_075 0
+#define BD79124_INTERVAL_150 1
+#define BD79124_INTERVAL_300 2
+#define BD79124_INTERVAL_600 3
+
+#define BD79124_MASK_DWC_EN BIT(4)
+#define BD79124_MASK_STATS_EN BIT(5)
+#define BD79124_MASK_SEQ_START BIT(4)
+#define BD79124_MASK_SEQ_MODE GENMASK(1, 0)
+#define BD79124_MASK_SEQ_MANUAL 0
+#define BD79124_MASK_SEQ_SEQ 1
+
+#define BD79124_MASK_HYSTERESIS GENMASK(3, 0)
+#define BD79124_LOW_LIMIT_MIN 0
+#define BD79124_HIGH_LIMIT_MAX GENMASK(11, 0)
+
+/*
+ * The high limit, low limit and last measurement result are each stored in
+ * 2 consequtive registers. 4 bits are in the high bits of the 1.st regist=
er
+ * and 8 bits in the next register.
+ *
+ * These macros return the address of the 1.st reg for the given channel
+ */
+#define BD79124_GET_HIGH_LIMIT_REG(ch) (BD79124_REG_HYSTERESIS_CH0 + (ch) =
* 4)
+#define BD79124_GET_LOW_LIMIT_REG(ch) (BD79124_REG_EVENTCOUNT_CH0 + (ch) *=
 4)
+#define BD79124_GET_RECENT_RES_REG(ch) (BD79124_REG_RECENT_CH0_LSB + (ch) =
* 2)
+
+/*
+ * The hysteresis for a channel is stored in the same register where the
+ * 4 bits of high limit reside.
+ */
+#define BD79124_GET_HYSTERESIS_REG(ch) BD79124_GET_HIGH_LIMIT_REG(ch)
+
+enum {
+	BD79124_CH_0,
+	BD79124_CH_1,
+	BD79124_CH_2,
+	BD79124_CH_3,
+	BD79124_CH_4,
+	BD79124_CH_5,
+	BD79124_CH_6,
+	BD79124_CH_7,
+	BD79124_MAX_NUM_CHANNELS
+};
+
+struct bd79124_data {
+	s64 timestamp;
+	struct regmap *map;
+	struct device *dev;
+	int vmax;
+	int alarm_monitored[BD79124_MAX_NUM_CHANNELS];
+	/*
+	 * The BD79124 is configured to run the measurements in the background.
+	 * This is done for the event monitoring as well as for the read_raw().
+	 * Protect the measurement starting/stopping using a mutex.
+	 */
+	struct mutex mutex;
+};
+
+struct bd79124_raw {
+	u8 bit0_3; /* Is set in high bits of the byte */
+	u8 bit4_11;
+};
+#define BD79124_RAW_TO_INT(r) ((r.bit4_11 << 4) | (r.bit0_3 >> 4))
+
+/*
+ * The high and low limits as well as the recent result values are stored =
in
+ * the same way in 2 consequent registers. The first register contains 4 b=
its
+ * of the value. These bits are stored in the high bits [7:4] of register,=
 but
+ * they represent the low bits [3:0] of the value.
+ * The value bits [11:4] are stored in the next register.
+ *
+ * Read data from register and convert to integer.
+ */
+static int bd79124_read_reg_to_int(struct bd79124_data *d, int reg,
+				   unsigned int *val)
+{
+	int ret;
+	struct bd79124_raw raw;
+
+	ret =3D regmap_bulk_read(d->map, reg, &raw, sizeof(raw));
+	if (ret)
+		dev_dbg(d->dev, "bulk_read failed %d\n", ret);
+	*val =3D BD79124_RAW_TO_INT(raw);
+
+	return ret;
+}
+
+/*
+ * The high and low limits as well as the recent result values are stored =
in
+ * the same way in 2 consequent registers. The first register contains 4 b=
its
+ * of the value. These bits are stored in the high bits [7:4] of register,=
 but
+ * they represent the low bits [3:0] of the value.
+ * The value bits [11:4] are stored in the next regoster.
+ *
+ * Conver the integer to register format and write it using rmw cycle.
+ */
+static int bd79124_write_int_to_reg(struct bd79124_data *d, int reg,
+				    unsigned int val)
+{
+	struct bd79124_raw raw;
+	int ret, tmp;
+
+	raw.bit4_11 =3D (u8)(val >> 4);
+	raw.bit0_3 =3D (u8)(val << 4);
+
+	ret =3D regmap_read(d->map, reg, &tmp);
+	if (ret)
+		return ret;
+
+	raw.bit0_3 |=3D (0xf & tmp);
+
+	return regmap_bulk_write(d->map, reg, &raw, sizeof(raw));
+}
+
+static const struct iio_event_spec bd79124_events[] =3D {
+	{
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_RISING,
+		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_FALLING,
+		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_EITHER,
+		.mask_separate =3D BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
+#define BD79124_CHAN(idx) {						\
+	.type =3D IIO_VOLTAGE,						\
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
+	.indexed =3D 1,							\
+	.channel =3D idx,							\
+}
+
+#define BD79124_CHAN_EV(idx) {						\
+	.type =3D IIO_VOLTAGE,						\
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
+	.indexed =3D 1,							\
+	.channel =3D idx,							\
+	.event_spec =3D bd79124_events,					\
+	.num_event_specs =3D ARRAY_SIZE(bd79124_events),			\
+}
+
+static const struct iio_chan_spec bd79124_channels[] =3D {
+	BD79124_CHAN_EV(0),
+	BD79124_CHAN_EV(1),
+	BD79124_CHAN_EV(2),
+	BD79124_CHAN_EV(3),
+	BD79124_CHAN_EV(4),
+	BD79124_CHAN_EV(5),
+	BD79124_CHAN_EV(6),
+	BD79124_CHAN_EV(7),
+};
+
+static const struct iio_chan_spec bd79124_channels_noirq[] =3D {
+	BD79124_CHAN(0),
+	BD79124_CHAN(1),
+	BD79124_CHAN(2),
+	BD79124_CHAN(3),
+	BD79124_CHAN(4),
+	BD79124_CHAN(5),
+	BD79124_CHAN(6),
+	BD79124_CHAN(7),
+};
+
+/*
+ * The BD79124 supports muxing the pins as ADC inputs or as a general purp=
ose
+ * output. This muxing is handled by a pinmux driver. Here we just check t=
he
+ * settings from the register, and disallow using the pin if pinmux is set=
 to
+ * GPO.
+ *
+ * NOTE: This driver does not perform any locking to ensure the pinmux sta=
ys
+ * toggled to ADC for the duration of the whatever operation is being done.
+ * It is responsibility of the user to configure the pinmux.
+ */
+static bool bd79124_chan_is_adc(struct bd79124_data *d, unsigned int offse=
t)
+{
+	int ret, val;
+
+	ret =3D regmap_read(d->map, BD79124_REG_PINCFG, &val);
+	/* If read fails, don't allow using as AIN (to be on a safe side) */
+	if (ret)
+		return 0;
+
+	return !(val & BIT(offset));
+}
+
+static int bd79124_read_event_value(struct iio_dev *idev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int *val,
+				    int *val2)
+{
+	struct bd79124_data *d =3D iio_priv(idev);
+	int ret, reg;
+
+	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
+		return -EINVAL;
+
+	/* ensure pinmux is set to ADC */
+	if (!bd79124_chan_is_adc(d, chan->channel))
+		return -EBUSY;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (dir =3D=3D IIO_EV_DIR_RISING)
+			reg =3D BD79124_GET_HIGH_LIMIT_REG(chan->channel);
+		else if (dir =3D=3D IIO_EV_DIR_FALLING)
+			reg =3D BD79124_GET_LOW_LIMIT_REG(chan->channel);
+		else
+			return -EINVAL;
+
+		ret =3D bd79124_read_reg_to_int(d, reg, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_EV_INFO_HYSTERESIS:
+		reg =3D BD79124_GET_HYSTERESIS_REG(chan->channel);
+		ret =3D regmap_read(d->map, reg, val);
+		if (ret)
+			return ret;
+		/* Mask the non hysteresis bits */
+		*val &=3D BD79124_MASK_HYSTERESIS;
+		/*
+		 * The data-sheet says the hysteresis register value needs to be
+		 * sifted left by 3 (or multiplied by 8, depending on the
+		 * page :] )
+		 */
+		*val <<=3D 3;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bd79124_start_measurement(struct bd79124_data *d, int chan)
+{
+	int val, ret, regval;
+
+	/* ensure pinmux is set to ADC */
+	if (!bd79124_chan_is_adc(d, chan))
+		return -EBUSY;
+
+	/* See if already started */
+	ret =3D regmap_read(d->map, BD79124_REG_AUTO_CHANNELS, &val);
+	if (val & BIT(chan))
+		return 0;
+
+	/* Stop the sequencer */
+	ret =3D regmap_clear_bits(d->map, BD79124_REG_SEQUENCE_CFG,
+				BD79124_MASK_SEQ_START);
+	if (ret)
+		return ret;
+
+	/* Add the channel to measured channels */
+	ret =3D regmap_write(d->map, BD79124_REG_AUTO_CHANNELS, val | BIT(chan));
+	if (ret)
+		return ret;
+
+	/* Restart the sequencer */
+	ret =3D regmap_set_bits(d->map, BD79124_REG_SEQUENCE_CFG,
+			      BD79124_MASK_SEQ_START);
+	if (ret)
+		return ret;
+
+	/*
+	 * Start the measurement at the background. Don't bother checking if
+	 * it was started, regmap has cache
+	 */
+	regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_AUTO);
+
+	return regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
+				BD79124_MASK_CONV_MODE, regval);
+}
+
+static int bd79124_stop_measurement(struct bd79124_data *d, int chan)
+{
+	int val, ret;
+
+	/* Ensure pinmux is set to ADC */
+	if (!bd79124_chan_is_adc(d, chan))
+		return -EBUSY;
+
+	/* If alarm is requested for the channel we won't stop measurement */
+	if (d->alarm_monitored[chan])
+		return 0;
+
+	/* See if already stopped */
+	ret =3D regmap_read(d->map, BD79124_REG_AUTO_CHANNELS, &val);
+	if (!(val & BIT(chan)))
+		return 0;
+
+	/* Stop the sequencer */
+	ret =3D regmap_clear_bits(d->map, BD79124_REG_SEQUENCE_CFG,
+				BD79124_MASK_SEQ_START);
+
+	/* Clear the channel from the measured channels */
+	ret =3D regmap_write(d->map, BD79124_REG_AUTO_CHANNELS,
+			   (~BIT(chan)) & val);
+	if (ret)
+		return ret;
+
+	/* Stop background conversion if it was the last channel */
+	if (!((~BIT(chan)) & val)) {
+		int regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE,
+					BD79124_CONV_MODE_MANSEQ);
+
+		ret =3D regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
+					 BD79124_MASK_CONV_MODE, regval);
+		if (ret)
+			return ret;
+	}
+
+	/* Restart the sequencer */
+	return regmap_set_bits(d->map, BD79124_REG_SEQUENCE_CFG,
+			       BD79124_MASK_SEQ_START);
+}
+
+static int bd79124_read_event_config(struct iio_dev *idev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct bd79124_data *d =3D iio_priv(idev);
+	int val, ret, reg, disabled;
+
+	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
+		return -EINVAL;
+
+	/* ensure pinmux is set to ADC */
+	if (!bd79124_chan_is_adc(d, chan->channel))
+		return -EBUSY;
+
+	ret =3D regmap_read(d->map, BD79124_REG_ALERT_CH_SEL, &val);
+	if (ret)
+		return ret;
+
+	/* The event is disabled if alerts for the channel are disabled */
+	if (!(val & BIT(chan->channel)))
+		return 0;
+
+	/*
+	 * If alerts are on, then the event may be disabled if limit is set to
+	 * the one extreme. (HW does not support disabling rising/falling
+	 * thresholds independently. Hence we resort to setting high limit to
+	 * MAX, or low limit to 0 to try effectively disable thresholds).
+	 */
+	if (dir =3D=3D IIO_EV_DIR_RISING) {
+		reg =3D BD79124_GET_HIGH_LIMIT_REG(chan->channel);
+		disabled =3D BD79124_HIGH_LIMIT_MAX;
+	} else if (dir =3D=3D IIO_EV_DIR_FALLING) {
+		reg =3D BD79124_GET_LOW_LIMIT_REG(chan->channel);
+		disabled =3D BD79124_LOW_LIMIT_MIN;
+	} else {
+		return -EINVAL;
+	}
+	ret =3D bd79124_read_reg_to_int(d, reg, &val);
+	if (ret)
+		return ret;
+
+	return val !=3D disabled;
+}
+
+static int bd79124_disable_event(struct bd79124_data *d,
+				 enum iio_event_direction dir, int channel)
+{
+	int dir_bit =3D BIT(dir), reg;
+	unsigned int limit;
+
+	d->alarm_monitored[channel] &=3D (~dir_bit);
+	/*
+	 * Set thresholds either to 0 or to 2^12 - 1 as appropriate to prevent
+	 * alerts and thus disable event generation.
+	 */
+	if (dir =3D=3D IIO_EV_DIR_RISING) {
+		reg =3D BD79124_GET_HIGH_LIMIT_REG(channel);
+		limit =3D BD79124_HIGH_LIMIT_MAX;
+	} else if (dir =3D=3D IIO_EV_DIR_FALLING) {
+		reg =3D BD79124_GET_LOW_LIMIT_REG(channel);
+		limit =3D BD79124_LOW_LIMIT_MIN;
+	} else {
+		return -EINVAL;
+	}
+
+	/*
+	 * Stop measurement if there is no more events to monitor.
+	 * We don't bother checking the retval because the limit
+	 * setting should in any case effectively disable the alarm.
+	 */
+	if (!d->alarm_monitored[channel]) {
+		bd79124_stop_measurement(d, channel);
+		regmap_clear_bits(d->map, BD79124_REG_ALERT_CH_SEL,
+			       BIT(channel));
+	}
+
+	return bd79124_write_int_to_reg(d, reg, limit);
+}
+
+/* Do we need to disable the measurement for the duration of the limit con=
f ? */
+static int bd79124_write_event_config(struct iio_dev *idev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, bool state)
+{
+	struct bd79124_data *d =3D iio_priv(idev);
+	int dir_bit =3D BIT(dir);
+
+	guard(mutex)(&d->mutex);
+
+	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
+		return -EINVAL;
+
+	/* ensure pinmux is set to ADC */
+	if (!bd79124_chan_is_adc(d, chan->channel))
+		return -EBUSY;
+
+	if (state) {
+		int ret;
+
+		/* Set channel to be measured */
+		ret =3D bd79124_start_measurement(d, chan->channel);
+		if (ret)
+			return ret;
+
+		d->alarm_monitored[chan->channel] |=3D dir_bit;
+
+		/* Add the channel to the list of monitored channels */
+		ret =3D regmap_set_bits(d->map, BD79124_REG_ALERT_CH_SEL,
+				      BIT(chan->channel));
+		if (ret)
+			return ret;
+
+		/*
+		 * Enable comparator. Trust the regmap cache, no need to check
+		 * if it was already enabled.
+		 *
+		 * We could do this in the hw-init, but there may be users who
+		 * never enable alarms and for them it makes sense to not
+		 * enable the comparator at probe.
+		 */
+		return regmap_set_bits(d->map, BD79124_REG_GEN_CFG,
+				      BD79124_MASK_DWC_EN);
+	}
+
+	return bd79124_disable_event(d, dir, chan->channel);
+}
+
+static int bd79124_write_event_value(struct iio_dev *idev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info, int val,
+				     int val2)
+{
+	struct bd79124_data *d =3D iio_priv(idev);
+	int reg;
+
+	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
+		return -EINVAL;
+
+	/* ensure pinmux is set to ADC */
+	if (!bd79124_chan_is_adc(d, chan->channel))
+		return -EBUSY;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (dir =3D=3D IIO_EV_DIR_RISING)
+			reg =3D BD79124_GET_HIGH_LIMIT_REG(chan->channel);
+		else if (dir =3D=3D IIO_EV_DIR_FALLING)
+			reg =3D BD79124_GET_LOW_LIMIT_REG(chan->channel);
+		else
+			return -EINVAL;
+
+		return bd79124_write_int_to_reg(d, reg, val);
+
+	case IIO_EV_INFO_HYSTERESIS:
+			reg =3D BD79124_GET_HYSTERESIS_REG(chan->channel);
+			val >>=3D 3;
+
+		return regmap_update_bits(d->map, reg, BD79124_MASK_HYSTERESIS,
+					  val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bd79124_read_last_result(struct bd79124_data *d, int chan,
+				    int *result)
+{
+	struct bd79124_raw raw;
+	int ret;
+
+	ret =3D regmap_bulk_read(d->map, BD79124_GET_RECENT_RES_REG(chan), &raw,
+			       sizeof(raw));
+	if (ret)
+		return ret;
+
+	*result =3D BD79124_RAW_TO_INT(raw);
+
+	return 0;
+}
+
+static int bd79124_single_chan_seq(struct bd79124_data *d, int chan, int *=
old)
+{
+	int ret;
+
+	/* Stop the sequencer */
+	ret =3D regmap_clear_bits(d->map, BD79124_REG_SEQUENCE_CFG,
+				BD79124_MASK_SEQ_START);
+	if (ret)
+		return ret;
+
+	/*
+	 * It may be we have some channels monitored for alarms so we want to
+	 * cache the old config and return it when the single channel
+	 * measurement has been completed. Read the old config.
+	 */
+	ret =3D regmap_read(d->map, BD79124_REG_AUTO_CHANNELS, old);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(d->map, BD79124_REG_AUTO_CHANNELS, BIT(chan));
+	if (ret)
+		return ret;
+
+	/* Restart the sequencer */
+	return regmap_set_bits(d->map, BD79124_REG_SEQUENCE_CFG,
+			      BD79124_MASK_SEQ_START);
+}
+
+static int bd79124_single_chan_seq_end(struct bd79124_data *d, int old)
+{
+	int ret;
+
+	/* Stop the sequencer */
+	ret =3D regmap_clear_bits(d->map, BD79124_REG_SEQUENCE_CFG,
+				BD79124_MASK_SEQ_START);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(d->map, BD79124_REG_AUTO_CHANNELS, old);
+	if (ret)
+		return ret;
+
+	/* Restart the sequencer */
+	return regmap_set_bits(d->map, BD79124_REG_SEQUENCE_CFG,
+			      BD79124_MASK_SEQ_START);
+}
+
+static int bd79124_read_raw(struct iio_dev *idev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long m)
+{
+	struct bd79124_data *d =3D iio_priv(idev);
+	int ret;
+
+	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
+		return -EINVAL;
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+	{
+		int old_chan_cfg, tmp;
+		int regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE,
+					BD79124_CONV_MODE_AUTO);
+
+		guard(mutex)(&d->mutex);
+
+		/* ensure pinmux is set to ADC */
+		if (!bd79124_chan_is_adc(d, chan->channel))
+			return -EBUSY;
+
+		/*
+		 * Start the automatic conversion. This is needed here if no
+		 * events have been enabled.
+		 */
+		ret =3D regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
+			BD79124_MASK_CONV_MODE, regval);
+		if (ret)
+			return ret;
+
+		ret =3D bd79124_single_chan_seq(d, chan->channel, &old_chan_cfg);
+		if (ret)
+			return ret;
+
+		/*
+		 * The maximum conversion time is 6 uS. Ensure the sample is
+		 * ready
+		 */
+		udelay(6);
+
+		ret =3D bd79124_read_last_result(d, chan->channel, val);
+		/* Try unconditionally returning the chan config */
+		tmp =3D bd79124_single_chan_seq_end(d, old_chan_cfg);
+		if (tmp)
+			dev_err(d->dev,
+				"Failed to return config. Alarms may be disabled\n");
+
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		*val =3D d->vmax / 1000;
+		*val2 =3D BD79124_ADC_BITS;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info bd79124_info =3D {
+	.read_raw =3D bd79124_read_raw,
+	.read_event_config =3D &bd79124_read_event_config,
+	.write_event_config =3D &bd79124_write_event_config,
+	.read_event_value =3D &bd79124_read_event_value,
+	.write_event_value =3D &bd79124_write_event_value,
+};
+
+static irqreturn_t bd79124_event_handler(int irq, void *priv)
+{
+	int ret, i_hi, i_lo, i;
+	struct iio_dev *idev =3D priv;
+	struct bd79124_data *d =3D iio_priv(idev);
+
+	/*
+	 * Return IRQ_NONE if bailing-out without acking. This allows the IRQ
+	 * subsystem to disable the offending IRQ line if we get a hardware
+	 * problem. This behaviour has saved my poor bottom a few times in the
+	 * past as, instead of getting unusably unresponsive, the system has
+	 * spilled out the magic words "...nobody cared".
+	 */
+	ret =3D regmap_read(d->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
+	if (ret)
+		return IRQ_NONE;
+
+	ret =3D regmap_read(d->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
+	if (ret)
+		return IRQ_NONE;
+
+	if (!i_lo && !i_hi)
+		return IRQ_NONE;
+
+	for (i =3D 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
+		u64 ecode;
+
+		if (BIT(i) & i_hi) {
+			ecode =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+					IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
+
+			iio_push_event(idev, ecode, d->timestamp);
+			/*
+			 * The BD79124 keeps the IRQ asserted for as long as
+			 * the voltage exceeds the threshold. It may not serve
+			 * the purpose to keep the IRQ firing and events
+			 * generated in a loop because it may yield the
+			 * userspace to have some problems when event handling
+			 * there is slow.
+			 *
+			 * Thus, we disable the event for the channel. Userspace
+			 * needs to re-enable the event.
+			 *
+			 * We don't check the result as there is not much to do.
+			 * Also, this should not lead to total IRQ storm
+			 * because the BD79124 is running in autonomous mode,
+			 * which means there is by minimum 0.75 mS idle time
+			 * between changing the channels. That should be
+			 * sufficient to show some life on system, even if the
+			 * event handling couldn't keep up.
+			 */
+			bd79124_disable_event(d, IIO_EV_DIR_RISING, i);
+		}
+		if (BIT(i) & i_lo) {
+			ecode =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+					IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING);
+
+			iio_push_event(idev, ecode, d->timestamp);
+		}
+	}
+
+	ret =3D regmap_write(d->map, BD79124_REG_EVENT_FLAG_HI, i_hi);
+	if (ret)
+		return IRQ_NONE;
+
+	ret =3D regmap_write(d->map, BD79124_REG_EVENT_FLAG_LO, i_lo);
+	if (ret)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd79124_irq_handler(int irq, void *priv)
+{
+	struct iio_dev *idev =3D priv;
+	struct bd79124_data *d =3D iio_priv(idev);
+
+	d->timestamp =3D iio_get_time_ns(idev);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static int bd79124_hw_init(struct bd79124_data *d)
+{
+	int ret, regval;
+
+	/* Stop auto sequencer */
+	ret =3D regmap_clear_bits(d->map, BD79124_REG_SEQUENCE_CFG,
+				BD79124_MASK_SEQ_START);
+	if (ret)
+		return ret;
+
+	/* Enable writing the measured values to the regsters */
+	ret =3D regmap_set_bits(d->map, BD79124_REG_GEN_CFG,
+				 BD79124_MASK_STATS_EN);
+	if (ret)
+		return ret;
+
+	/* Set no channels to be auto-measured */
+	ret =3D regmap_write(d->map, BD79124_REG_AUTO_CHANNELS, 0x0);
+	if (ret)
+		return ret;
+
+	/* Set no channels to be manually measured */
+	ret =3D regmap_write(d->map, BD79124_REG_MANUAL_CHANNELS, 0x0);
+	if (ret)
+		return ret;
+
+	/* Set the measurement interval to 0.75 mS */
+
+	regval =3D FIELD_PREP(BD79124_MASK_AUTO_INTERVAL, BD79124_INTERVAL_075);
+	ret =3D regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
+			BD79124_MASK_AUTO_INTERVAL, regval);
+	if (ret)
+		return ret;
+
+	/* Sequencer mode to auto */
+	ret =3D regmap_set_bits(d->map, BD79124_REG_SEQUENCE_CFG,
+			      BD79124_MASK_SEQ_SEQ);
+	if (ret)
+		return ret;
+
+	regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_MANSEQ);
+	/* Don't start the measurement */
+	return regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
+			BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_MANSEQ);
+
+}
+
+#define BD79124_VDD_MAX 5250000
+#define BD79124_VDD_MIN 2700000
+
+static int bd79124_probe(struct platform_device *pdev)
+{
+	struct bd79124_data *d;
+	struct iio_dev *idev;
+	int ret, irq, *parent_data;
+
+	idev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*d));
+	if (!idev)
+		return -ENOMEM;
+
+	d =3D iio_priv(idev);
+
+	parent_data =3D dev_get_drvdata(pdev->dev.parent);
+	if (!parent_data)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "reference voltage missing\n");
+
+	/*
+	 * Recommended VDD voltage from the data-sheet:
+	 * Analog/Digital Supply Voltage VDD 2.70 - 5.25 V
+	 */
+	d->vmax =3D *parent_data;
+	if (d->vmax < BD79124_VDD_MIN || d->vmax > BD79124_VDD_MAX) {
+		return dev_err_probe(d->dev, -EINVAL,
+				     "VDD (%d) out of range [%d - %d]\n",
+				     d->vmax, BD79124_VDD_MIN, BD79124_VDD_MAX);
+
+		return -EINVAL;
+	}
+
+	irq =3D platform_get_irq_byname_optional(pdev, "thresh-alert");
+	if (irq < 0) {
+		if (irq =3D=3D -EPROBE_DEFER)
+			return irq;
+
+		idev->channels =3D &bd79124_channels_noirq[0];
+		idev->num_channels =3D ARRAY_SIZE(bd79124_channels_noirq);
+		dev_dbg(d->dev, "No IRQ found, events disabled\n");
+	} else {
+		idev->channels =3D &bd79124_channels[0];
+		idev->num_channels =3D ARRAY_SIZE(bd79124_channels);
+	}
+
+	idev->info =3D &bd79124_info;
+	idev->name =3D "bd79124";
+	idev->modes =3D INDIO_DIRECT_MODE;
+
+	d->dev =3D &pdev->dev;
+	d->map =3D dev_get_regmap(d->dev->parent, NULL);
+	if (!d->map)
+		return dev_err_probe(d->dev, -ENODEV, "No regmap\n");
+
+	mutex_init(&d->mutex);
+
+	ret =3D bd79124_hw_init(d);
+	if (ret)
+		return ret;
+
+	if (irq > 0) {
+		ret =3D devm_request_threaded_irq(d->dev, irq, bd79124_irq_handler,
+					&bd79124_event_handler, IRQF_ONESHOT,
+					"adc-thresh-alert", idev);
+		if (ret)
+			return dev_err_probe(d->dev, ret,
+					     "Failed to register IRQ\n");
+	}
+
+	return devm_iio_device_register(d->dev, idev);
+}
+
+static const struct platform_device_id bd79124_adc_id[] =3D {
+	{ "bd79124-adc", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, bd79124_adc_id);
+
+static struct platform_driver bd79124_driver =3D {
+	.driver =3D {
+		.name =3D "bd79124-adc",
+		/*
+		 * Probing explicitly requires a few millisecond of sleep.
+		 * Enabling the VDD regulator may include ramp up rates.
+		 */
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe =3D bd79124_probe,
+	.id_table =3D bd79124_adc_id,
+};
+module_platform_driver(bd79124_driver);
+
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("Driver for ROHM BD79124 ADC");
+MODULE_LICENSE("GPL");
--=20
2.48.1


--B5xHhQjeBAxx0fyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmec0iwACgkQeFA3/03a
ocWoYQgAoEzDdeNziJZVdeW1bqUxcWDCF3vxiYNtx0pNbwVtdHiQvKKcGA6AanxK
MIh7kcqp5AtZHFkqE5ZemapHtCvq800HAaD/H0Feq5dVAGOAjRYLybpvLH8t/Idc
7Cm+GPuOx+hcWkRTjcRe9YmSaTHneZhDJ6T/9glhEC4UbtAMAyTQkTXI5uUaGllk
GsbTo45MEviW0QjlnHcr43Gsmd3GatgiDz1DuvwuCGB2CbR1CE7O0ZFR/7bJ9ZHh
G6WcjRzeMjbcryCo0pzU3SH8j6vu9USz8cLMut97aUe3aWKUXr2eO/LLydaM+h17
KmWwwkqzYDn2vOeOT0DoUlMVIOoJQg==
=pk70
-----END PGP SIGNATURE-----

--B5xHhQjeBAxx0fyd--

