Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881E23091F5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jan 2021 06:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhA3FJp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jan 2021 00:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3FFK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jan 2021 00:05:10 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBE9C06178B;
        Fri, 29 Jan 2021 18:37:20 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id b21so7868579pgk.7;
        Fri, 29 Jan 2021 18:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8bfdaiNUBe7vdvdQZwOnyFuG+AetfjsOnJmwyHZsyYI=;
        b=Vk5SiyWtzRaq6OgqyjX/mSSzDJguY7nj0s6oDTepUI86FBZfTGNBYshEUPJqGFt90N
         PlxGjE9OBg2nU19nmIr8zkSaBGnVfVbPfhVmufmXQB4zKrmffqL3vys4eLaP/f9xqPRI
         8fb34AagBEX9jvOW9nb1QSxSrGSdusw0rtupV/Q08ny4jdTJ/SJd3Pu3wlxA5eW4MmYb
         HdNHPl6LZzrepizVcKzc5soCID3jVtvzIC62U8s/Chxz+uh9CFV9GXaFe2VuyZtkLqF3
         aE82S1kK+XEwNykJENgk16vyOcXbYmhT6gtot1rLo2ypNqE1uTZtFeBqMd0lUPzQqz69
         cqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8bfdaiNUBe7vdvdQZwOnyFuG+AetfjsOnJmwyHZsyYI=;
        b=X2LoHyDh6aPBzKa1cdt+zUJyOQ/y5N/C5FsCMmZxbxo8XfoFguSE6jIDjpAi3tkrtL
         q8iYo0AFoiwpA+DHCV7j3qsLLkLIacx3nqNmOh1qSBqbiLMbV4qsOHPTF3qzBY4gnyla
         64Wtsq/P6lug/iSFJnGfvdUxiiE3m/NsYC+lCk5AO9TADLUMTkTs6TtFCfZ2qcwqwU29
         s8csjg2OBRu0FORcGY1l0UEcQuDtr70/7dXBh7X4XTOMKmWGHdsg5qx5LBV20fSAzWhL
         gGBVtUleE0wwcFsSkiGK/dB5hLA8UXHwQtdTB5wQhS5JZ4sCRBqw8gGUvp+t7f/Ll9Ip
         ezhQ==
X-Gm-Message-State: AOAM533M3NbjWRmL8UTETpoUoptnhG3Ew9ls4zCtCUIfA/lT/wiqafuH
        /gkT/cB1y9yMpM/rNH9gzcs=
X-Google-Smtp-Source: ABdhPJzMd1bDLeulVbvk57l4fBNZHuVKGgHRagmpMvQTLyJ40UmPp/1H3cFGpiFgEIFqxZKkh6fpOg==
X-Received: by 2002:a63:1d25:: with SMTP id d37mr7151675pgd.205.1611974240089;
        Fri, 29 Jan 2021 18:37:20 -0800 (PST)
Received: from localhost.localdomain (113x33x126x33.ap113.ftth.ucom.ne.jp. [113.33.126.33])
        by smtp.gmail.com with ESMTPSA id s21sm8872169pjz.13.2021.01.29.18.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 18:37:19 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org, fabrice.gasnier@foss.st.com
Cc:     fabrice.gasnier@st.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, benjamin.gaignard@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH v2 1/2] counter: 104-quad-8: Remove IIO counter ABI
Date:   Sat, 30 Jan 2021 11:37:03 +0900
Message-Id: <98a39983d5df761c058a469d1346fd8ffdef8516.1611973018.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611973018.git.vilhelm.gray@gmail.com>
References: <cover.1611973018.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The IIO counter driver has been superseded by the Counter subsystem as
discussed in [1]. This patch removes the IIO counter ABI from the
104-QUAD-8 driver.

[1] https://lore.kernel.org/lkml/20210119104105.000010df@Huawei.com/

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../testing/sysfs-bus-iio-counter-104-quad-8  | 133 ----
 MAINTAINERS                                   |   1 -
 drivers/counter/104-quad-8.c                  | 653 ++----------------
 drivers/counter/Kconfig                       |   2 +-
 4 files changed, 65 insertions(+), 724 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
deleted file mode 100644
index bac3d0d48b7b..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
+++ /dev/null
@@ -1,133 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/in_count_count_mode_available
-What:		/sys/bus/iio/devices/iio:deviceX/in_count_noise_error_available
-What:		/sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
-What:		/sys/bus/iio/devices/iio:deviceX/in_index_index_polarity_available
-What:		/sys/bus/iio/devices/iio:deviceX/in_index_synchronous_mode_available
-KernelVersion:	4.10
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		Discrete set of available values for the respective counter
-		configuration are listed in this file.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_countY_count_mode
-KernelVersion:	4.10
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		Count mode for channel Y. Four count modes are available:
-		normal, range limit, non-recycle, and modulo-n. The preset value
-		for channel Y is used by the count mode where required.
-
-		Normal:
-			Counting is continuous in either direction.
-
-		Range Limit:
-			An upper or lower limit is set, mimicking limit switches
-			in the mechanical counterpart. The upper limit is set to
-			the preset value, while the lower limit is set to 0. The
-			counter freezes at count = preset when counting up, and
-			at count = 0 when counting down. At either of these
-			limits, the counting is resumed only when the count
-			direction is reversed.
-
-		Non-recycle:
-			Counter is disabled whenever a 24-bit count overflow or
-			underflow takes place. The counter is re-enabled when a
-			new count value is loaded to the counter via a preset
-			operation or write to raw.
-
-		Modulo-N:
-			A count boundary is set between 0 and the preset value.
-			The counter is reset to 0 at count = preset when
-			counting up, while the counter is set to the preset
-			value at count = 0 when counting down; the counter does
-			not freeze at the bundary points, but counts
-			continuously throughout.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_countY_noise_error
-KernelVersion:	4.10
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		Read-only attribute that indicates whether excessive noise is
-		present at the channel Y count inputs in quadrature clock mode;
-		irrelevant in non-quadrature clock mode.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_countY_preset
-KernelVersion:	4.10
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		If the counter device supports preset registers, the preset
-		count for channel Y is provided by this attribute.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_countY_quadrature_mode
-KernelVersion:	4.10
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		Configure channel Y counter for non-quadrature or quadrature
-		clock mode. Selecting non-quadrature clock mode will disable
-		synchronous load mode. In quadrature clock mode, the channel Y
-		scale attribute selects the encoder phase division (scale of 1
-		selects full-cycle, scale of 0.5 selects half-cycle, scale of
-		0.25 selects quarter-cycle) processed by the channel Y counter.
-
-		Non-quadrature:
-			The filter and decoder circuit are bypassed. Encoder A
-			input serves as the count input and B as the UP/DOWN
-			direction control input, with B = 1 selecting UP Count
-			mode and B = 0 selecting Down Count mode.
-
-		Quadrature:
-			Encoder A and B inputs are digitally filtered and
-			decoded for UP/DN clock.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_countY_set_to_preset_on_index
-KernelVersion:	4.10
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		Whether to set channel Y counter with channel Y preset value
-		when channel Y index input is active, or continuously count.
-		Valid attribute values are boolean.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_index_polarity
-KernelVersion:	4.10
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		Active level of channel Y index input; irrelevant in
-		non-synchronous load mode.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_synchronous_mode
-KernelVersion:	4.10
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This interface is deprecated; please use the Counter subsystem.
-
-		Configure channel Y counter for non-synchronous or synchronous
-		load mode. Synchronous load mode cannot be selected in
-		non-quadrature clock mode.
-
-		Non-synchronous:
-			A logic low level is the active level at this index
-			input. The index function (as enabled via
-			set_to_preset_on_index) is performed directly on the
-			active level of the index input.
-
-		Synchronous:
-			Intended for interfacing with encoder Index output in
-			quadrature clock mode. The active level is configured
-			via index_polarity. The index function (as enabled via
-			set_to_preset_on_index) is performed synchronously with
-			the quadrature clock on the active level of the index
-			input.
diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..f2d94e1f4032 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -298,7 +298,6 @@ M:	Syed Nayyar Waris <syednwaris@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
-F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 F:	drivers/counter/104-quad-8.c
 
 ACCES PCI-IDIO-16 GPIO DRIVER
diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 78766b6ec271..9691f8612be8 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -9,8 +9,6 @@
 #include <linux/counter.h>
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/types.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/isa.h>
@@ -29,7 +27,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
 #define QUAD8_NUM_COUNTERS 8
 
 /**
- * struct quad8_iio - IIO device private data structure
+ * struct quad8 - device private data structure
  * @counter:		instance of the counter_device
  * @fck_prescaler:	array of filter clock prescaler configurations
  * @preset:		array of preset values
@@ -41,9 +39,9 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  * @synchronous_mode:	array of index function synchronous mode configurations
  * @index_polarity:	array of index function polarity configurations
  * @cable_fault_enable:	differential encoder cable status enable configurations
- * @base:		base port address of the IIO device
+ * @base:		base port address of the device
  */
-struct quad8_iio {
+struct quad8 {
 	struct mutex lock;
 	struct counter_device counter;
 	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
@@ -98,532 +96,10 @@ struct quad8_iio {
 #define QUAD8_CMR_QUADRATURE_X2 0x10
 #define QUAD8_CMR_QUADRATURE_X4 0x18
 
-
-static int quad8_read_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel;
-	unsigned int flags;
-	unsigned int borrow;
-	unsigned int carry;
-	int i;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		if (chan->type == IIO_INDEX) {
-			*val = !!(inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
-				& BIT(chan->channel));
-			return IIO_VAL_INT;
-		}
-
-		flags = inb(base_offset + 1);
-		borrow = flags & QUAD8_FLAG_BT;
-		carry = !!(flags & QUAD8_FLAG_CT);
-
-		/* Borrow XOR Carry effectively doubles count range */
-		*val = (borrow ^ carry) << 24;
-
-		mutex_lock(&priv->lock);
-
-		/* Reset Byte Pointer; transfer Counter to Output Latch */
-		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
-		     base_offset + 1);
-
-		for (i = 0; i < 3; i++)
-			*val |= (unsigned int)inb(base_offset) << (8 * i);
-
-		mutex_unlock(&priv->lock);
-
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_ENABLE:
-		*val = priv->ab_enable[chan->channel];
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		*val = 1;
-		*val2 = priv->quadrature_scale[chan->channel];
-		return IIO_VAL_FRACTIONAL_LOG2;
-	}
-
-	return -EINVAL;
-}
-
-static int quad8_write_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int val, int val2, long mask)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel;
-	int i;
-	unsigned int ior_cfg;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		if (chan->type == IIO_INDEX)
-			return -EINVAL;
-
-		/* Only 24-bit values are supported */
-		if ((unsigned int)val > 0xFFFFFF)
-			return -EINVAL;
-
-		mutex_lock(&priv->lock);
-
-		/* Reset Byte Pointer */
-		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
-
-		/* Counter can only be set via Preset Register */
-		for (i = 0; i < 3; i++)
-			outb(val >> (8 * i), base_offset);
-
-		/* Transfer Preset Register to Counter */
-		outb(QUAD8_CTR_RLD | QUAD8_RLD_PRESET_CNTR, base_offset + 1);
-
-		/* Reset Byte Pointer */
-		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
-
-		/* Set Preset Register back to original value */
-		val = priv->preset[chan->channel];
-		for (i = 0; i < 3; i++)
-			outb(val >> (8 * i), base_offset);
-
-		/* Reset Borrow, Carry, Compare, and Sign flags */
-		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_FLAGS, base_offset + 1);
-		/* Reset Error flag */
-		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
-
-		mutex_unlock(&priv->lock);
-
-		return 0;
-	case IIO_CHAN_INFO_ENABLE:
-		/* only boolean values accepted */
-		if (val < 0 || val > 1)
-			return -EINVAL;
-
-		mutex_lock(&priv->lock);
-
-		priv->ab_enable[chan->channel] = val;
-
-		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
-
-		/* Load I/O control configuration */
-		outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
-
-		mutex_unlock(&priv->lock);
-
-		return 0;
-	case IIO_CHAN_INFO_SCALE:
-		mutex_lock(&priv->lock);
-
-		/* Quadrature scaling only available in quadrature mode */
-		if (!priv->quadrature_mode[chan->channel] &&
-				(val2 || val != 1)) {
-			mutex_unlock(&priv->lock);
-			return -EINVAL;
-		}
-
-		/* Only three gain states (1, 0.5, 0.25) */
-		if (val == 1 && !val2)
-			priv->quadrature_scale[chan->channel] = 0;
-		else if (!val)
-			switch (val2) {
-			case 500000:
-				priv->quadrature_scale[chan->channel] = 1;
-				break;
-			case 250000:
-				priv->quadrature_scale[chan->channel] = 2;
-				break;
-			default:
-				mutex_unlock(&priv->lock);
-				return -EINVAL;
-			}
-		else {
-			mutex_unlock(&priv->lock);
-			return -EINVAL;
-		}
-
-		mutex_unlock(&priv->lock);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static const struct iio_info quad8_info = {
-	.read_raw = quad8_read_raw,
-	.write_raw = quad8_write_raw
-};
-
-static ssize_t quad8_read_preset(struct iio_dev *indio_dev, uintptr_t private,
-	const struct iio_chan_spec *chan, char *buf)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n", priv->preset[chan->channel]);
-}
-
-static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
-	const struct iio_chan_spec *chan, const char *buf, size_t len)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel;
-	unsigned int preset;
-	int ret;
-	int i;
-
-	ret = kstrtouint(buf, 0, &preset);
-	if (ret)
-		return ret;
-
-	/* Only 24-bit values are supported */
-	if (preset > 0xFFFFFF)
-		return -EINVAL;
-
-	mutex_lock(&priv->lock);
-
-	priv->preset[chan->channel] = preset;
-
-	/* Reset Byte Pointer */
-	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
-
-	/* Set Preset Register */
-	for (i = 0; i < 3; i++)
-		outb(preset >> (8 * i), base_offset);
-
-	mutex_unlock(&priv->lock);
-
-	return len;
-}
-
-static ssize_t quad8_read_set_to_preset_on_index(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-		!priv->preset_enable[chan->channel]);
-}
-
-static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
-	size_t len)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-	bool preset_enable;
-	int ret;
-	unsigned int ior_cfg;
-
-	ret = kstrtobool(buf, &preset_enable);
-	if (ret)
-		return ret;
-
-	/* Preset enable is active low in Input/Output Control register */
-	preset_enable = !preset_enable;
-
-	mutex_lock(&priv->lock);
-
-	priv->preset_enable[chan->channel] = preset_enable;
-
-	ior_cfg = priv->ab_enable[chan->channel] |
-		(unsigned int)preset_enable << 1;
-
-	/* Load I/O control configuration to Input / Output Control Register */
-	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
-
-	mutex_unlock(&priv->lock);
-
-	return len;
-}
-
-static const char *const quad8_noise_error_states[] = {
-	"No excessive noise is present at the count inputs",
-	"Excessive noise is present at the count inputs"
-};
-
-static int quad8_get_noise_error(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-
-	return !!(inb(base_offset) & QUAD8_FLAG_E);
-}
-
-static const struct iio_enum quad8_noise_error_enum = {
-	.items = quad8_noise_error_states,
-	.num_items = ARRAY_SIZE(quad8_noise_error_states),
-	.get = quad8_get_noise_error
-};
-
-static const char *const quad8_count_direction_states[] = {
-	"down",
-	"up"
-};
-
-static int quad8_get_count_direction(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-
-	return !!(inb(base_offset) & QUAD8_FLAG_UD);
-}
-
-static const struct iio_enum quad8_count_direction_enum = {
-	.items = quad8_count_direction_states,
-	.num_items = ARRAY_SIZE(quad8_count_direction_states),
-	.get = quad8_get_count_direction
-};
-
-static const char *const quad8_count_modes[] = {
-	"normal",
-	"range limit",
-	"non-recycle",
-	"modulo-n"
-};
-
-static int quad8_set_count_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int cnt_mode)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	unsigned int mode_cfg = cnt_mode << 1;
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-
-	mutex_lock(&priv->lock);
-
-	priv->count_mode[chan->channel] = cnt_mode;
-
-	/* Add quadrature mode configuration */
-	if (priv->quadrature_mode[chan->channel])
-		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
-
-	/* Load mode configuration to Counter Mode Register */
-	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
-
-	mutex_unlock(&priv->lock);
-
-	return 0;
-}
-
-static int quad8_get_count_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return priv->count_mode[chan->channel];
-}
-
-static const struct iio_enum quad8_count_mode_enum = {
-	.items = quad8_count_modes,
-	.num_items = ARRAY_SIZE(quad8_count_modes),
-	.set = quad8_set_count_mode,
-	.get = quad8_get_count_mode
-};
-
-static const char *const quad8_synchronous_modes[] = {
-	"non-synchronous",
-	"synchronous"
-};
-
-static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int synchronous_mode)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-	unsigned int idr_cfg = synchronous_mode;
-
-	mutex_lock(&priv->lock);
-
-	idr_cfg |= priv->index_polarity[chan->channel] << 1;
-
-	/* Index function must be non-synchronous in non-quadrature mode */
-	if (synchronous_mode && !priv->quadrature_mode[chan->channel]) {
-		mutex_unlock(&priv->lock);
-		return -EINVAL;
-	}
-
-	priv->synchronous_mode[chan->channel] = synchronous_mode;
-
-	/* Load Index Control configuration to Index Control Register */
-	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
-
-	mutex_unlock(&priv->lock);
-
-	return 0;
-}
-
-static int quad8_get_synchronous_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return priv->synchronous_mode[chan->channel];
-}
-
-static const struct iio_enum quad8_synchronous_mode_enum = {
-	.items = quad8_synchronous_modes,
-	.num_items = ARRAY_SIZE(quad8_synchronous_modes),
-	.set = quad8_set_synchronous_mode,
-	.get = quad8_get_synchronous_mode
-};
-
-static const char *const quad8_quadrature_modes[] = {
-	"non-quadrature",
-	"quadrature"
-};
-
-static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int quadrature_mode)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-	unsigned int mode_cfg;
-
-	mutex_lock(&priv->lock);
-
-	mode_cfg = priv->count_mode[chan->channel] << 1;
-
-	if (quadrature_mode)
-		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
-	else {
-		/* Quadrature scaling only available in quadrature mode */
-		priv->quadrature_scale[chan->channel] = 0;
-
-		/* Synchronous function not supported in non-quadrature mode */
-		if (priv->synchronous_mode[chan->channel])
-			quad8_set_synchronous_mode(indio_dev, chan, 0);
-	}
-
-	priv->quadrature_mode[chan->channel] = quadrature_mode;
-
-	/* Load mode configuration to Counter Mode Register */
-	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
-
-	mutex_unlock(&priv->lock);
-
-	return 0;
-}
-
-static int quad8_get_quadrature_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return priv->quadrature_mode[chan->channel];
-}
-
-static const struct iio_enum quad8_quadrature_mode_enum = {
-	.items = quad8_quadrature_modes,
-	.num_items = ARRAY_SIZE(quad8_quadrature_modes),
-	.set = quad8_set_quadrature_mode,
-	.get = quad8_get_quadrature_mode
-};
-
-static const char *const quad8_index_polarity_modes[] = {
-	"negative",
-	"positive"
-};
-
-static int quad8_set_index_polarity(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int index_polarity)
-{
-	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const int base_offset = priv->base + 2 * chan->channel + 1;
-	unsigned int idr_cfg = index_polarity << 1;
-
-	mutex_lock(&priv->lock);
-
-	idr_cfg |= priv->synchronous_mode[chan->channel];
-
-	priv->index_polarity[chan->channel] = index_polarity;
-
-	/* Load Index Control configuration to Index Control Register */
-	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
-
-	mutex_unlock(&priv->lock);
-
-	return 0;
-}
-
-static int quad8_get_index_polarity(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
-{
-	const struct quad8_iio *const priv = iio_priv(indio_dev);
-
-	return priv->index_polarity[chan->channel];
-}
-
-static const struct iio_enum quad8_index_polarity_enum = {
-	.items = quad8_index_polarity_modes,
-	.num_items = ARRAY_SIZE(quad8_index_polarity_modes),
-	.set = quad8_set_index_polarity,
-	.get = quad8_get_index_polarity
-};
-
-static const struct iio_chan_spec_ext_info quad8_count_ext_info[] = {
-	{
-		.name = "preset",
-		.shared = IIO_SEPARATE,
-		.read = quad8_read_preset,
-		.write = quad8_write_preset
-	},
-	{
-		.name = "set_to_preset_on_index",
-		.shared = IIO_SEPARATE,
-		.read = quad8_read_set_to_preset_on_index,
-		.write = quad8_write_set_to_preset_on_index
-	},
-	IIO_ENUM("noise_error", IIO_SEPARATE, &quad8_noise_error_enum),
-	IIO_ENUM_AVAILABLE("noise_error", &quad8_noise_error_enum),
-	IIO_ENUM("count_direction", IIO_SEPARATE, &quad8_count_direction_enum),
-	IIO_ENUM_AVAILABLE("count_direction", &quad8_count_direction_enum),
-	IIO_ENUM("count_mode", IIO_SEPARATE, &quad8_count_mode_enum),
-	IIO_ENUM_AVAILABLE("count_mode", &quad8_count_mode_enum),
-	IIO_ENUM("quadrature_mode", IIO_SEPARATE, &quad8_quadrature_mode_enum),
-	IIO_ENUM_AVAILABLE("quadrature_mode", &quad8_quadrature_mode_enum),
-	{}
-};
-
-static const struct iio_chan_spec_ext_info quad8_index_ext_info[] = {
-	IIO_ENUM("synchronous_mode", IIO_SEPARATE,
-		&quad8_synchronous_mode_enum),
-	IIO_ENUM_AVAILABLE("synchronous_mode", &quad8_synchronous_mode_enum),
-	IIO_ENUM("index_polarity", IIO_SEPARATE, &quad8_index_polarity_enum),
-	IIO_ENUM_AVAILABLE("index_polarity", &quad8_index_polarity_enum),
-	{}
-};
-
-#define QUAD8_COUNT_CHAN(_chan) {					\
-	.type = IIO_COUNT,						\
-	.channel = (_chan),						\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
-		BIT(IIO_CHAN_INFO_ENABLE) | BIT(IIO_CHAN_INFO_SCALE),	\
-	.ext_info = quad8_count_ext_info,				\
-	.indexed = 1							\
-}
-
-#define QUAD8_INDEX_CHAN(_chan) {			\
-	.type = IIO_INDEX,				\
-	.channel = (_chan),				\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-	.ext_info = quad8_index_ext_info,		\
-	.indexed = 1					\
-}
-
-static const struct iio_chan_spec quad8_channels[] = {
-	QUAD8_COUNT_CHAN(0), QUAD8_INDEX_CHAN(0),
-	QUAD8_COUNT_CHAN(1), QUAD8_INDEX_CHAN(1),
-	QUAD8_COUNT_CHAN(2), QUAD8_INDEX_CHAN(2),
-	QUAD8_COUNT_CHAN(3), QUAD8_INDEX_CHAN(3),
-	QUAD8_COUNT_CHAN(4), QUAD8_INDEX_CHAN(4),
-	QUAD8_COUNT_CHAN(5), QUAD8_INDEX_CHAN(5),
-	QUAD8_COUNT_CHAN(6), QUAD8_INDEX_CHAN(6),
-	QUAD8_COUNT_CHAN(7), QUAD8_INDEX_CHAN(7)
-};
-
 static int quad8_signal_read(struct counter_device *counter,
 	struct counter_signal *signal, enum counter_signal_value *val)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 	unsigned int state;
 
 	/* Only Index signal levels can be read */
@@ -641,7 +117,7 @@ static int quad8_signal_read(struct counter_device *counter,
 static int quad8_count_read(struct counter_device *counter,
 	struct counter_count *count, unsigned long *val)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned int flags;
 	unsigned int borrow;
@@ -672,7 +148,7 @@ static int quad8_count_read(struct counter_device *counter,
 static int quad8_count_write(struct counter_device *counter,
 	struct counter_count *count, unsigned long val)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
 	int i;
 
@@ -727,7 +203,7 @@ static enum counter_count_function quad8_count_functions_list[] = {
 static int quad8_function_get(struct counter_device *counter,
 	struct counter_count *count, size_t *function)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const int id = count->id;
 
 	mutex_lock(&priv->lock);
@@ -755,7 +231,7 @@ static int quad8_function_get(struct counter_device *counter,
 static int quad8_function_set(struct counter_device *counter,
 	struct counter_count *count, size_t function)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const int id = count->id;
 	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
 	unsigned int *const scale = priv->quadrature_scale + id;
@@ -811,7 +287,7 @@ static int quad8_function_set(struct counter_device *counter,
 static void quad8_direction_get(struct counter_device *counter,
 	struct counter_count *count, enum counter_count_direction *direction)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 	unsigned int ud_flag;
 	const unsigned int flag_addr = priv->base + 2 * count->id + 1;
 
@@ -845,7 +321,7 @@ static int quad8_action_get(struct counter_device *counter,
 	struct counter_count *count, struct counter_synapse *synapse,
 	size_t *action)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	int err;
 	size_t function = 0;
 	const size_t signal_a_id = count->synapses[0].signal->id;
@@ -905,10 +381,15 @@ static const struct counter_ops quad8_ops = {
 	.action_get = quad8_action_get
 };
 
+static const char *const quad8_index_polarity_modes[] = {
+	"negative",
+	"positive"
+};
+
 static int quad8_index_polarity_get(struct counter_device *counter,
 	struct counter_signal *signal, size_t *index_polarity)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
 
 	*index_polarity = priv->index_polarity[channel_id];
@@ -919,7 +400,7 @@ static int quad8_index_polarity_get(struct counter_device *counter,
 static int quad8_index_polarity_set(struct counter_device *counter,
 	struct counter_signal *signal, size_t index_polarity)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
 	unsigned int idr_cfg = index_polarity << 1;
@@ -945,10 +426,15 @@ static struct counter_signal_enum_ext quad8_index_pol_enum = {
 	.set = quad8_index_polarity_set
 };
 
+static const char *const quad8_synchronous_modes[] = {
+	"non-synchronous",
+	"synchronous"
+};
+
 static int quad8_synchronous_mode_get(struct counter_device *counter,
 	struct counter_signal *signal, size_t *synchronous_mode)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
 
 	*synchronous_mode = priv->synchronous_mode[channel_id];
@@ -959,7 +445,7 @@ static int quad8_synchronous_mode_get(struct counter_device *counter,
 static int quad8_synchronous_mode_set(struct counter_device *counter,
 	struct counter_signal *signal, size_t synchronous_mode)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
 	unsigned int idr_cfg = synchronous_mode;
@@ -1001,7 +487,7 @@ static ssize_t quad8_count_floor_read(struct counter_device *counter,
 static int quad8_count_mode_get(struct counter_device *counter,
 	struct counter_count *count, size_t *cnt_mode)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 
 	/* Map 104-QUAD-8 count mode to Generic Counter count mode */
 	switch (priv->count_mode[count->id]) {
@@ -1025,7 +511,7 @@ static int quad8_count_mode_get(struct counter_device *counter,
 static int quad8_count_mode_set(struct counter_device *counter,
 	struct counter_count *count, size_t cnt_mode)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	unsigned int mode_cfg;
 	const int base_offset = priv->base + 2 * count->id + 1;
 
@@ -1084,7 +570,7 @@ static ssize_t quad8_count_direction_read(struct counter_device *counter,
 static ssize_t quad8_count_enable_read(struct counter_device *counter,
 	struct counter_count *count, void *private, char *buf)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 
 	return sprintf(buf, "%u\n", priv->ab_enable[count->id]);
 }
@@ -1092,7 +578,7 @@ static ssize_t quad8_count_enable_read(struct counter_device *counter,
 static ssize_t quad8_count_enable_write(struct counter_device *counter,
 	struct counter_count *count, void *private, const char *buf, size_t len)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
 	int err;
 	bool ab_enable;
@@ -1116,10 +602,15 @@ static ssize_t quad8_count_enable_write(struct counter_device *counter,
 	return len;
 }
 
+static const char *const quad8_noise_error_states[] = {
+	"No excessive noise is present at the count inputs",
+	"Excessive noise is present at the count inputs"
+};
+
 static int quad8_error_noise_get(struct counter_device *counter,
 	struct counter_count *count, size_t *noise_error)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id + 1;
 
 	*noise_error = !!(inb(base_offset) & QUAD8_FLAG_E);
@@ -1136,18 +627,18 @@ static struct counter_count_enum_ext quad8_error_noise_enum = {
 static ssize_t quad8_count_preset_read(struct counter_device *counter,
 	struct counter_count *count, void *private, char *buf)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 
 	return sprintf(buf, "%u\n", priv->preset[count->id]);
 }
 
-static void quad8_preset_register_set(struct quad8_iio *quad8iio, int id,
-		unsigned int preset)
+static void quad8_preset_register_set(struct quad8 *priv, int id,
+				      unsigned int preset)
 {
-	const unsigned int base_offset = quad8iio->base + 2 * id;
+	const unsigned int base_offset = priv->base + 2 * id;
 	int i;
 
-	quad8iio->preset[id] = preset;
+	priv->preset[id] = preset;
 
 	/* Reset Byte Pointer */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
@@ -1160,7 +651,7 @@ static void quad8_preset_register_set(struct quad8_iio *quad8iio, int id,
 static ssize_t quad8_count_preset_write(struct counter_device *counter,
 	struct counter_count *count, void *private, const char *buf, size_t len)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	unsigned int preset;
 	int ret;
 
@@ -1184,7 +675,7 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
 	struct counter_count *count, void *private, char *buf)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 
 	mutex_lock(&priv->lock);
 
@@ -1205,7 +696,7 @@ static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
 static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 	struct counter_count *count, void *private, const char *buf, size_t len)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	unsigned int ceiling;
 	int ret;
 
@@ -1235,7 +726,7 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
 	struct counter_count *count, void *private, char *buf)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 
 	return sprintf(buf, "%u\n", !priv->preset_enable[count->id]);
 }
@@ -1243,7 +734,7 @@ static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
 static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
 	struct counter_count *count, void *private, const char *buf, size_t len)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id + 1;
 	bool preset_enable;
 	int ret;
@@ -1274,7 +765,7 @@ static ssize_t quad8_signal_cable_fault_read(struct counter_device *counter,
 					     struct counter_signal *signal,
 					     void *private, char *buf)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
 	bool disabled;
 	unsigned int status;
@@ -1304,7 +795,7 @@ static ssize_t quad8_signal_cable_fault_enable_read(
 	struct counter_device *counter, struct counter_signal *signal,
 	void *private, char *buf)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
 	const unsigned int enb = !!(priv->cable_fault_enable & BIT(channel_id));
 
@@ -1315,7 +806,7 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 	struct counter_device *counter, struct counter_signal *signal,
 	void *private, const char *buf, size_t len)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
 	bool enable;
 	int ret;
@@ -1345,7 +836,7 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 static ssize_t quad8_signal_fck_prescaler_read(struct counter_device *counter,
 	struct counter_signal *signal, void *private, char *buf)
 {
-	const struct quad8_iio *const priv = counter->priv;
+	const struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
 
 	return sprintf(buf, "%u\n", priv->fck_prescaler[channel_id]);
@@ -1355,7 +846,7 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	struct counter_signal *signal, void *private, const char *buf,
 	size_t len)
 {
-	struct quad8_iio *const priv = counter->priv;
+	struct quad8 *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
 	const int base_offset = priv->base + 2 * channel_id;
 	u8 prescaler;
@@ -1531,11 +1022,9 @@ static struct counter_count quad8_counts[] = {
 
 static int quad8_probe(struct device *dev, unsigned int id)
 {
-	struct iio_dev *indio_dev;
-	struct quad8_iio *quad8iio;
+	struct quad8 *priv;
 	int i, j;
 	unsigned int base_offset;
-	int err;
 
 	if (!devm_request_region(dev, base[id], QUAD8_EXTENT, dev_name(dev))) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -1543,32 +1032,23 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	/* Allocate IIO device; this also allocates driver data structure */
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*quad8iio));
-	if (!indio_dev)
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
 
-	/* Initialize IIO device */
-	indio_dev->info = &quad8_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
-	indio_dev->channels = quad8_channels;
-	indio_dev->name = dev_name(dev);
-
 	/* Initialize Counter device and driver data */
-	quad8iio = iio_priv(indio_dev);
-	quad8iio->counter.name = dev_name(dev);
-	quad8iio->counter.parent = dev;
-	quad8iio->counter.ops = &quad8_ops;
-	quad8iio->counter.counts = quad8_counts;
-	quad8iio->counter.num_counts = ARRAY_SIZE(quad8_counts);
-	quad8iio->counter.signals = quad8_signals;
-	quad8iio->counter.num_signals = ARRAY_SIZE(quad8_signals);
-	quad8iio->counter.priv = quad8iio;
-	quad8iio->base = base[id];
+	priv->counter.name = dev_name(dev);
+	priv->counter.parent = dev;
+	priv->counter.ops = &quad8_ops;
+	priv->counter.counts = quad8_counts;
+	priv->counter.num_counts = ARRAY_SIZE(quad8_counts);
+	priv->counter.signals = quad8_signals;
+	priv->counter.num_signals = ARRAY_SIZE(quad8_signals);
+	priv->counter.priv = priv;
+	priv->base = base[id];
 
 	/* Initialize mutex */
-	mutex_init(&quad8iio->lock);
+	mutex_init(&priv->lock);
 
 	/* Reset all counters and disable interrupt function */
 	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
@@ -1602,13 +1082,8 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	/* Enable all counters */
 	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 
-	/* Register IIO device */
-	err = devm_iio_device_register(dev, indio_dev);
-	if (err)
-		return err;
-
 	/* Register Counter device */
-	return devm_counter_register(dev, &quad8iio->counter);
+	return devm_counter_register(dev, &priv->counter);
 }
 
 static struct isa_driver quad8_driver = {
@@ -1621,5 +1096,5 @@ static struct isa_driver quad8_driver = {
 module_isa_driver(quad8_driver, num_quad8);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
-MODULE_DESCRIPTION("ACCES 104-QUAD-8 IIO driver");
+MODULE_DESCRIPTION("ACCES 104-QUAD-8 driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 2de53ab0dd25..63ffbebcf455 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -14,7 +14,7 @@ if COUNTER
 
 config 104_QUAD_8
 	tristate "ACCES 104-QUAD-8 driver"
-	depends on PC104 && X86 && IIO
+	depends on PC104 && X86
 	select ISA_BUS_API
 	help
 	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
-- 
2.30.0

