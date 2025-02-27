Return-Path: <linux-iio+bounces-16144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C57DA4856F
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 17:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A62017C106
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134E1C701B;
	Thu, 27 Feb 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="kmsCfQLl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13481C3F1C
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673800; cv=none; b=gc0w8WNSyXXKzOccV1GqxXxSx4mvS/gYH3tj+zCoPDHcLOVojKt1din8FKKrl+M3LLZ1cv18TAzFGpDx0AEnLZgIGX37ohVGQ7E+BAYTpydVct9O0N4gA+gs4TKmHUQsTDubigtfmhuy7KOBm8gfQjjCbwE9HRrimMJbYfx61ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673800; c=relaxed/simple;
	bh=DUeszSnaouG6w9lDct7P1Z+4G3HYjpiunwIlC0aVQcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzsLHbo+iAhmDnsMxUx3MjwKSUerEJ0J6wdRSFlb5nwTq00aPCKK1Urz19ar3xezUb8h5liUIfGq1nZHBr/Lk0tHhcTrllwaLxLourkyg+qLm49uHuR6r6Aep/IW23X7G9vRRxZj6+C5OmzRbcdPuH1XnXcBNg/kO4Jt6dqiKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=kmsCfQLl; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=ioIxjHlJsXmq+OWAbF1XxuFYPMpWucEXZaFjHtcDDnI=;
	b=kmsCfQLl03XfPrbO9MVch3+P79QSRPU8N2gFwxkl8EeFIhAkWdy8qKhYX9v7KzgQRsTNsQBSPWsNU
	 kT9XOxg5MY0Bq1jkU3Ph91DVQ/Jd/tisB5hjLtccOYejDF2zgpDMAkID4jIyEMhly5UXGA3pPEZa7q
	 P2FLIqjE/Vo26ILJ5NxkidhGGD2dmUyx60Sx/cVDLZtgT0M8ajYWtv+zjqA81rp23ppUh8tuqW0FWO
	 vi/KgRBlmyHfhcDLyrfacy4rVkwy1zf8o+oHo0rIi72iVrz6K3hKqlppj2/r3x1b7EohtXy3DmD8yV
	 9rIJKd7AvARybJz246qEwFzquIzid7w==
X-MSG-ID: e9879223-f527-11ef-b5ca-0050568164d1
From: David Jander <david@protonic.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	David Jander <david@protonic.nl>
Subject: [RFC PATCH 1/7] drivers: Add motion control subsystem
Date: Thu, 27 Feb 2025 17:28:17 +0100
Message-ID: <20250227162823.3585810-2-david@protonic.nl>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227162823.3585810-1-david@protonic.nl>
References: <20250227162823.3585810-1-david@protonic.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux Motion Control subsystem (LMC) is a new driver subsystem for
peripheral devices that control mechanical motion in some form or another.
This could be different kinds of motors (stepper, DC, AC, SRM, BLDC...)
or even linear actuators.
The subsystem presents a unified UAPI for those devices, based on char
devices with ioctl's.
It can make use of regular gpio's to function as trigger inputs, like
end-stops, fixed position- or motion start triggers and also generate
events not only to user-space but also to the IIO subsystem in the form of
IIO triggers.

Signed-off-by: David Jander <david@protonic.nl>
---
 MAINTAINERS                     |   8 +
 drivers/Kconfig                 |   2 +
 drivers/Makefile                |   2 +
 drivers/motion/Kconfig          |  19 +
 drivers/motion/Makefile         |   3 +
 drivers/motion/motion-core.c    | 823 ++++++++++++++++++++++++++++++++
 drivers/motion/motion-core.h    | 172 +++++++
 drivers/motion/motion-helpers.c | 590 +++++++++++++++++++++++
 drivers/motion/motion-helpers.h |  23 +
 include/uapi/linux/motion.h     | 229 +++++++++
 10 files changed, 1871 insertions(+)
 create mode 100644 drivers/motion/Kconfig
 create mode 100644 drivers/motion/Makefile
 create mode 100644 drivers/motion/motion-core.c
 create mode 100644 drivers/motion/motion-core.h
 create mode 100644 drivers/motion/motion-helpers.c
 create mode 100644 drivers/motion/motion-helpers.h
 create mode 100644 include/uapi/linux/motion.h

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..57267584166c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13418,6 +13418,14 @@ F:	Documentation/litmus-tests/
 F:	Documentation/memory-barriers.txt
 F:	tools/memory-model/
 
+LINUX MOTION CONTROL
+M:	David Jander <david@protonic.nl>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/motion/
+F:	Documentation/motion/
+F:	drivers/motion/
+
 LINUX-NEXT TREE
 M:	Stephen Rothwell <sfr@canb.auug.org.au>
 L:	linux-next@vger.kernel.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7bdad836fc62..6b3482187f38 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -245,4 +245,6 @@ source "drivers/cdx/Kconfig"
 
 source "drivers/dpll/Kconfig"
 
+source "drivers/motion/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 45d1c3e630f7..39476f2b5e55 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -195,3 +195,5 @@ obj-$(CONFIG_CDX_BUS)		+= cdx/
 obj-$(CONFIG_DPLL)		+= dpll/
 
 obj-$(CONFIG_S390)		+= s390/
+
+obj-$(CONFIG_MOTION)		+= motion/
diff --git a/drivers/motion/Kconfig b/drivers/motion/Kconfig
new file mode 100644
index 000000000000..085f9647b47b
--- /dev/null
+++ b/drivers/motion/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig MOTION
+	bool "Linux Motion Control support"
+	select IIO
+	help
+	  The Linux Motion Control subsystem contains drivers for different
+	  types of motion control hardware, like (stepper-)motor drivers and
+	  linear actuators.
+	  Say Y here if you want to chose motion control devices.
+
+if MOTION
+
+config MOTION_HELPERS
+	bool
+	depends on MOTION
+
+endif # MOTION
+
diff --git a/drivers/motion/Makefile b/drivers/motion/Makefile
new file mode 100644
index 000000000000..ed912a8ed605
--- /dev/null
+++ b/drivers/motion/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MOTION)		+= motion-core.o
+obj-$(CONFIG_MOTION_HELPERS)	+= motion-helpers.o
diff --git a/drivers/motion/motion-core.c b/drivers/motion/motion-core.c
new file mode 100644
index 000000000000..2963f1859e8b
--- /dev/null
+++ b/drivers/motion/motion-core.c
@@ -0,0 +1,823 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Motion Control Subsystem - Core
+ *
+ * Copyright (C) 2024 Protonic Holland
+ *                    David Jander <david@protonic.nl>
+ */
+
+#include <asm-generic/bitops/builtin-fls.h>
+#include <asm-generic/errno-base.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/container_of.h>
+#include <linux/hrtimer_types.h>
+#include <linux/gfp_types.h>
+#include <linux/module.h>
+
+#include <linux/fs.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/kmod.h>
+#include <linux/motion.h>
+#include <linux/poll.h>
+#include <linux/ptrace.h>
+#include <linux/ktime.h>
+#include <linux/iio/trigger.h>
+#include <linux/gpio/consumer.h>
+
+#include "motion-core.h"
+#include "motion-helpers.h"
+#include <linux/time.h>
+#include <linux/uaccess.h>
+#include <linux/string.h>
+#include <linux/math64.h>
+#include <linux/mutex.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+
+#define MOTION_PROFILE_VALID BIT(31)
+
+static LIST_HEAD(motion_list);
+static DEFINE_MUTEX(motion_mtx);
+static int motion_major;
+static DEFINE_IDA(motion_minors_ida);
+
+struct iio_motion_trigger_info {
+	unsigned int minor;
+};
+
+static int motion_minor_alloc(void)
+{
+	int ret;
+
+	ret = ida_alloc_range(&motion_minors_ida, 0, MINORMASK, GFP_KERNEL);
+	return ret;
+}
+
+static void motion_minor_free(int minor)
+{
+	ida_free(&motion_minors_ida, minor);
+}
+
+static int motion_open(struct inode *inode, struct file *file)
+{
+	int minor = iminor(inode);
+	struct motion_device *mdev = NULL, *iter;
+	int err;
+
+	mutex_lock(&motion_mtx);
+
+	list_for_each_entry(iter, &motion_list, list) {
+		if (iter->minor != minor)
+			continue;
+		mdev = iter;
+		break;
+	}
+
+	if (!mdev) {
+		err = -ENODEV;
+		goto fail;
+	}
+
+	dev_info(mdev->dev, "MOTION: open %d\n", mdev->minor);
+	file->private_data = mdev;
+
+	if (mdev->ops.device_open)
+		err = mdev->ops.device_open(mdev);
+	else
+		err = 0;
+fail:
+	mutex_unlock(&motion_mtx);
+	return err;
+}
+
+static int motion_release(struct inode *inode, struct file *file)
+{
+	struct motion_device *mdev = file->private_data;
+	int i;
+
+	if (mdev->ops.device_release)
+		mdev->ops.device_release(mdev);
+
+	for (i = 0; i < mdev->num_gpios; i++) {
+		int irq;
+		struct motion_gpio_input *gpio = &mdev->gpios[i];
+
+		if (gpio->function == MOT_INP_FUNC_NONE)
+			continue;
+		irq = gpiod_to_irq(gpio->gpio);
+		devm_free_irq(mdev->dev, irq, gpio);
+		gpio->function = MOT_INP_FUNC_NONE;
+	}
+
+	if (!kfifo_is_empty(&mdev->events))
+		kfifo_reset(&mdev->events);
+
+	/* FIXME: Stop running motions? Probably not... */
+
+	return 0;
+}
+
+static ssize_t motion_read(struct file *file, char __user *buffer,
+			  size_t count, loff_t *ppos)
+{
+	struct motion_device *mdev = file->private_data;
+	unsigned int copied = 0L;
+	int ret;
+
+	if (!mdev->dev)
+		return -ENODEV;
+
+	if (count < sizeof(struct mot_event))
+		return -EINVAL;
+
+	do {
+		if (kfifo_is_empty(&mdev->events)) {
+			if (file->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			ret = wait_event_interruptible(mdev->wait,
+					!kfifo_is_empty(&mdev->events) ||
+					mdev->dev == NULL);
+			if (ret)
+				return ret;
+			if (mdev->dev == NULL)
+				return -ENODEV;
+		}
+
+		if (mutex_lock_interruptible(&mdev->read_mutex))
+			return -ERESTARTSYS;
+		ret = kfifo_to_user(&mdev->events, buffer, count, &copied);
+		mutex_unlock(&mdev->read_mutex);
+
+		if (ret)
+			return ret;
+	} while (!copied);
+
+	return copied;
+}
+
+static __poll_t motion_poll(struct file *file, poll_table *wait)
+{
+	struct motion_device *mdev = file->private_data;
+	__poll_t mask = 0;
+
+	poll_wait(file, &mdev->wait, wait);
+	if (!kfifo_is_empty(&mdev->events))
+		mask = EPOLLIN | EPOLLRDNORM;
+	dev_info(mdev->dev, "Obtained POLL events: 0x%08x\n", mask);
+
+	return mask;
+}
+
+static long motion_move_distance(struct motion_device *mdev,
+		channel_mask_t ch, speed_raw_t speed, pos_raw_t distance)
+{
+	ktime_t time;
+	u64 tmp;
+	u64 tmpmul = NSEC_PER_SEC; /* Convert speed (1/s) to time in nsec */
+
+	if (mdev->ops.move_distance)
+		return mdev->ops.move_distance(mdev, ch, speed, distance);
+
+	if (!mdev->ops.move_timed)
+		return -EOPNOTSUPP;
+
+	if (!speed)
+		return -EINVAL;
+
+	/*
+	 * Handling of potential integer overflows when converting distance
+	 * to time duration without sacrificing too much precision:
+	 * speed_conv_div and speed_conv_mul can be very large, yet the
+	 * resulting quotient is most likely a lot smaller. If we do the
+	 * multiplication first we retain the highest precision, but we need
+	 * to be mindful of integer overflows, so we do one test to see if there
+	 * are enough bits left to increase the precision further.
+	 */
+	tmp = ((u64)distance * mdev->capabilities.speed_conv_div);
+	if (tmp < (1ULL << 48)) {
+		tmpmul = NSEC_PER_MSEC;
+		tmp *= MSEC_PER_SEC;
+	}
+	tmp = div_u64(tmp, mdev->capabilities.speed_conv_mul);
+	tmp = div_u64(tmp, speed);
+	time = tmp * tmpmul;
+	return mdev->ops.move_timed(mdev, ch, speed, time);
+}
+
+static long motion_move_timed(struct motion_device *mdev, channel_mask_t ch,
+		speed_raw_t speed, mot_time_t duration)
+{
+	ktime_t t;
+
+	if (mdev->ops.move_timed) {
+		t = mot_time2ktime(duration);
+		return mdev->ops.move_timed(mdev, ch, speed, t);
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static long motion_set_profile_locked(struct motion_device *mdev,
+		struct mot_profile *prof)
+{
+	long ret;
+	struct mot_profile *dst;
+	int i;
+
+	lockdep_assert_held(&mdev->mutex);
+
+	if ((prof->na > mdev->capabilities.max_apoints) ||
+			(prof->nv > mdev->capabilities.max_vpoints))
+		return -EINVAL;
+
+	/* Check if used acceleration values are positive and non zero */
+	for (i = 0; i < prof->na; i++)
+		if (prof->acc[i] <= 0)
+			return -EINVAL;
+
+	if (!mdev->ops.validate_profile || !mdev->ops.set_profile)
+		return -EOPNOTSUPP;
+
+	if (prof->index >= MOT_MAX_PROFILES)
+		return -EINVAL;
+
+	ret = mdev->ops.validate_profile(mdev, prof);
+	if (ret)
+		return ret;
+
+	dst = &mdev->profiles[prof->index];
+
+	*dst = *prof;
+	dst->index |= MOTION_PROFILE_VALID;
+
+	return 0L;
+}
+
+static long motion_get_profile_locked(struct motion_device *mdev, u32 index,
+		struct mot_profile *dst)
+{
+	struct mot_profile *src;
+
+	lockdep_assert_held(&mdev->mutex);
+
+	if (index >= MOT_MAX_PROFILES)
+		return -EINVAL;
+
+	if (!(mdev->profiles[index].index & MOTION_PROFILE_VALID))
+		return -EINVAL;
+
+	src = &mdev->profiles[index];
+	*dst = *src;
+
+	return 0L;
+}
+
+static long motion_start_locked(struct motion_device *mdev, struct mot_start *s)
+{
+	long ret = 0L;
+	mot_time_t conv_duration;
+
+	lockdep_assert_held(&mdev->mutex);
+
+	if (s->reserved1 || s->reserved2)
+		return -EINVAL;
+	if (s->channel >= mdev->capabilities.num_channels)
+		return -EINVAL;
+	if ((s->index >= MOT_MAX_PROFILES) || (s->direction > MOT_DIRECTION_RIGHT))
+		return -EINVAL;
+	if (!(mdev->profiles[s->index].index & MOTION_PROFILE_VALID))
+		return -EINVAL;
+	if (s->when >= MOT_WHEN_NUM_WHENS)
+		return -EINVAL;
+	if (s->duration && s->distance)
+		return -EINVAL;
+	if (!mdev->ops.motion_distance && !mdev->ops.motion_timed)
+		return -EOPNOTSUPP;
+	if (s->duration) {
+		if (!mdev->ops.motion_timed)
+			return -EOPNOTSUPP;
+		/* FIXME: Implement time to distance conversion? */
+		return mdev->ops.motion_timed(mdev, s->channel, s->index,
+				s->direction, s->duration, s->when);
+	}
+	if (!mdev->ops.motion_distance) {
+		ret = motion_distance_to_time(mdev, s->index, s->distance,
+				&conv_duration);
+		if (ret)
+			return ret;
+		return mdev->ops.motion_timed(mdev, s->channel, s->index,
+				s->direction, conv_duration, s->when);
+	}
+	ret = mdev->ops.motion_distance(mdev, s->channel, s->index,
+			s->distance, s->when);
+
+	return ret;
+}
+
+static irqreturn_t motion_gpio_interrupt(int irq, void *dev_id)
+{
+	struct motion_gpio_input *gpio = dev_id;
+	struct motion_device *mdev = container_of(gpio, struct motion_device,
+			gpios[gpio->index]);
+	struct mot_event evt = {0};
+	struct mot_status st;
+	int val = gpiod_get_raw_value(gpio->gpio);
+	channel_mask_t chmsk;
+	channel_mask_t chmsk_l = 0;
+	channel_mask_t chmsk_r = 0;
+
+	dev_info(mdev->dev, "GPIO IRQ val=%d edge=%d\n", val, gpio->edge);
+	/* FIXME: This is racy and we shouldn't try to support shared IRQ! */
+	if ((gpio->edge == MOT_EDGE_FALLING) && val)
+		return IRQ_NONE;
+
+	if ((gpio->edge == MOT_EDGE_RISING) && !val)
+		return IRQ_NONE;
+
+	evt.event = MOT_EVENT_INPUT;
+	evt.input_index = gpio->index;
+	evt.timestamp = ktime2mot_time(ktime_get());
+
+	mutex_lock(&mdev->mutex);
+	/* FIXME: It may be possible and desirable to obtain position and
+	 * speed from multiple channels with one call to the driver.
+	 */
+	chmsk = gpio->chmask;
+	while (chmsk) {
+		unsigned int ch = ffs(chmsk) - 1;
+
+		chmsk &= ~(1 << ch);
+		evt.channel = ch;
+		st.channel = ch;
+		mdev->ops.get_status(mdev, &st);
+		evt.speed = st.speed;
+		evt.position = st.position;
+		motion_report_event(mdev, &evt);
+		if (st.speed < 0)
+			chmsk_l |= (1 << ch);
+		else if (st.speed > 0)
+			chmsk_r |= (1 << ch);
+	}
+
+	switch (gpio->function) {
+	case MOT_INP_FUNC_STOP_NEG:
+		if (chmsk_l)
+			mdev->ops.basic_stop(mdev, chmsk_l);
+		break;
+	case MOT_INP_FUNC_STOP_POS:
+		if (chmsk_r)
+			mdev->ops.basic_stop(mdev, chmsk_r);
+		break;
+	case MOT_INP_FUNC_STOP:
+		mdev->ops.basic_stop(mdev, gpio->chmask);
+		break;
+	case MOT_INP_FUNC_DECEL_NEG:
+		if (chmsk_l)
+			mdev->ops.motion_stop(mdev, chmsk_l, MOT_WHEN_IMMEDIATE);
+		break;
+	case MOT_INP_FUNC_DECEL_POS:
+		if (chmsk_r)
+			mdev->ops.motion_stop(mdev, chmsk_r, MOT_WHEN_IMMEDIATE);
+		break;
+	case MOT_INP_FUNC_DECEL:
+		mdev->ops.motion_stop(mdev, gpio->chmask, MOT_WHEN_IMMEDIATE);
+		break;
+	case MOT_INP_FUNC_START:
+		if (mdev->ops.external_trigger)
+			mdev->ops.external_trigger(mdev, gpio->index,
+					gpio->chmask);
+		break;
+	default:
+		break;
+	}
+	mutex_unlock(&mdev->mutex);
+
+	return IRQ_HANDLED;
+}
+
+static int motion_config_gpio(struct motion_device *mdev, int idx,
+		unsigned int func, unsigned int edge, channel_mask_t chmsk)
+{
+	struct motion_gpio_input *gpio = &mdev->gpios[idx];
+	bool irq_claimed = false;
+	int irq = gpiod_to_irq(gpio->gpio);
+	int flags;
+
+	if (gpio->function != MOT_INP_FUNC_NONE) {
+		if (func == MOT_INP_FUNC_NONE)
+			devm_free_irq(mdev->dev, irq, mdev);
+		irq_claimed = true;
+	}
+	gpio->chmask = chmsk;
+	gpio->function = func;
+	gpio->edge = edge;
+	if (!irq_claimed) {
+		if (edge == MOT_EDGE_FALLING)
+			flags = IRQF_TRIGGER_FALLING;
+		else
+			flags = IRQF_TRIGGER_RISING;
+		flags |= IRQF_SHARED | IRQF_ONESHOT;
+		dev_info(mdev->dev, "Claiming GPIO IRQ %d\n", irq);
+		return devm_request_threaded_irq(mdev->dev, irq, NULL,
+				motion_gpio_interrupt, flags,
+				dev_name(mdev->dev), gpio);
+	}
+
+	return 0;
+}
+
+static long motion_config_input_locked(struct motion_device *mdev, struct mot_input *inp)
+{
+	int idx;
+
+	lockdep_assert_held(&mdev->mutex);
+
+	if (!inp->external)
+		return mdev->ops.config_trigger(mdev, inp->index, inp->function,
+				inp->edge, inp->chmask);
+
+	idx = inp->index;
+	idx -= mdev->capabilities.num_ext_triggers - mdev->num_gpios;
+	/*
+	 * FIXME: idx is now the index of GPIO external trigger.
+	 * Other types of external triggers are not yet supported.
+	 */
+	if ((idx >= mdev->num_gpios) || (idx < 0)) {
+		WARN_ONCE(true, "Input index unexpectedly out of range.");
+		return -EINVAL;
+	}
+	return motion_config_gpio(mdev, idx, inp->function, inp->edge,
+			inp->chmask);
+}
+
+static long motion_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct motion_device *mdev = file->private_data;
+	void __user *argp = (void __user *)arg;
+	long ret;
+
+	switch (cmd) {
+	case MOT_IOCTL_APIVER:
+		force_successful_syscall_return();
+		return MOT_UAPI_VERSION;
+	case MOT_IOCTL_BASIC_RUN: {
+		struct mot_speed_duration spd;
+
+		if (copy_from_user(&spd, argp, sizeof(spd)))
+			return -EFAULT;
+		if (!mdev->ops.basic_run)
+			return -EINVAL;
+		if (spd.channel >= mdev->capabilities.num_channels)
+			return -EINVAL;
+		if (spd.distance && spd.duration)
+			return -EINVAL;
+		/* FIXME: Check reserved for zero! */
+		mutex_lock(&mdev->mutex);
+		if (!spd.distance && !spd.duration)
+			ret = mdev->ops.basic_run(mdev, spd.channel, spd.speed);
+		else if (spd.distance)
+			ret = motion_move_distance(mdev, spd.channel,
+					spd.speed, spd.distance);
+		else
+			ret = motion_move_timed(mdev, spd.channel, spd.speed,
+				mot_time2ktime(spd.duration));
+		mutex_unlock(&mdev->mutex);
+		break;
+	}
+	case MOT_IOCTL_BASIC_STOP: {
+		u32 ch;
+
+		if (copy_from_user(&ch, argp, sizeof(ch)))
+			return -EFAULT;
+		/* Stop takes channel mask as only argument */
+		if (fls(ch) > mdev->capabilities.num_channels)
+			return -EINVAL;
+		mutex_lock(&mdev->mutex);
+		ret = mdev->ops.basic_stop(mdev, ch);
+		mutex_unlock(&mdev->mutex);
+		break;
+	}
+	case MOT_IOCTL_GET_CAPA:
+		ret = copy_to_user(argp, &mdev->capabilities, sizeof(struct mot_capabilities));
+		break;
+	case MOT_IOCTL_GET_STATUS: {
+		struct mot_status st;
+
+		if (copy_from_user(&st, argp, sizeof(st)))
+			return -EFAULT;
+		if (st.channel >= mdev->capabilities.num_channels)
+			return -EINVAL;
+		if (!mdev->ops.get_status)
+			return -EINVAL;
+		mutex_lock(&mdev->mutex);
+		ret = mdev->ops.get_status(mdev, &st);
+		mutex_unlock(&mdev->mutex);
+		if (ret)
+			break;
+		ret = copy_to_user(argp, &st, sizeof(struct mot_status));
+		break;
+	}
+	case MOT_IOCTL_SET_PROFILE: {
+		struct mot_profile prof;
+
+		if (copy_from_user(&prof, argp, sizeof(prof)))
+			return -EFAULT;
+		mutex_lock(&mdev->mutex);
+		ret = motion_set_profile_locked(mdev, &prof);
+		mutex_unlock(&mdev->mutex);
+		break;
+	}
+	case MOT_IOCTL_GET_PROFILE: {
+		struct mot_profile prof;
+
+		if (copy_from_user(&prof, argp, sizeof(prof)))
+			return -EFAULT;
+		mutex_lock(&mdev->mutex);
+		ret = motion_get_profile_locked(mdev, prof.index, &prof);
+		mutex_unlock(&mdev->mutex);
+		if (ret)
+			break;
+		ret = copy_to_user(argp, &prof, sizeof(prof));
+		break;
+	}
+	case MOT_IOCTL_START: {
+		struct mot_start start;
+
+		if (copy_from_user(&start, argp, sizeof(start)))
+			return -EFAULT;
+		mutex_lock(&mdev->mutex);
+		ret = motion_start_locked(mdev, &start);
+		mutex_unlock(&mdev->mutex);
+		break;
+	}
+	case MOT_IOCTL_STOP: {
+		struct mot_stop stop;
+
+		if (copy_from_user(&stop, argp, sizeof(stop)))
+			return -EFAULT;
+		if (fls(stop.chmask) > mdev->capabilities.num_channels)
+			return -EINVAL;
+		if (stop.when >= MOT_WHEN_NUM_WHENS)
+			return -EINVAL;
+		if (!mdev->ops.motion_stop)
+			return -EINVAL;
+		mutex_lock(&mdev->mutex);
+		ret = mdev->ops.motion_stop(mdev, stop.chmask, stop.when);
+		mutex_unlock(&mdev->mutex);
+		break;
+	}
+	case MOT_IOCTL_CONFIG_INPUT: {
+		struct mot_input inp;
+
+		if (copy_from_user(&inp, argp, sizeof(inp)))
+			return -EFAULT;
+		if (fls(inp.chmask) > mdev->capabilities.num_channels)
+			return -EINVAL;
+		if ((inp.external > 1) || (inp.function > MOT_INP_FUNC_NUM_FUNCS))
+			return -EINVAL;
+		if (!inp.external && (inp.index >= mdev->capabilities.num_int_triggers))
+			return -EINVAL;
+		if (inp.external && (inp.index >= mdev->capabilities.num_ext_triggers))
+			return -EINVAL;
+		if (!inp.external && !mdev->ops.config_trigger)
+			return -EOPNOTSUPP;
+		mutex_lock(&mdev->mutex);
+		ret = motion_config_input_locked(mdev, &inp);
+		mutex_unlock(&mdev->mutex);
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static char *motion_devnode(const struct device *dev, umode_t *mode)
+{
+	const struct motion_device *mdev = dev_get_drvdata(dev);
+
+	if (mode && mdev->mode)
+		*mode = mdev->mode;
+	if (mdev->nodename)
+		return kstrdup(mdev->nodename, GFP_KERNEL);
+	return NULL;
+}
+
+static const struct class motion_class = {
+	.name		= "motion",
+	.devnode	= motion_devnode,
+};
+
+static const struct file_operations motion_fops = {
+	.owner		= THIS_MODULE,
+	.read		= motion_read,
+	.poll		= motion_poll,
+	.unlocked_ioctl = motion_ioctl,
+	.open		= motion_open,
+	.llseek		= noop_llseek,
+	.release	= motion_release,
+};
+
+static int motion_of_parse_gpios(struct motion_device *mdev)
+{
+	int ngpio, i;
+
+	ngpio = gpiod_count(mdev->parent, "motion,input");
+	if (ngpio < 0) {
+		if (ngpio == -ENOENT)
+			return 0;
+		return ngpio;
+	}
+
+	if (ngpio >= MOT_MAX_INPUTS)
+		return -EINVAL;
+
+	for (i = 0; i < ngpio; i++) {
+		mdev->gpios[i].gpio = devm_gpiod_get_index(mdev->parent,
+				"motion,input", i, GPIOD_IN);
+		if (IS_ERR(mdev->gpios[i].gpio))
+			return PTR_ERR(mdev->gpios[i].gpio);
+		mdev->gpios[i].function = MOT_INP_FUNC_NONE;
+		mdev->gpios[i].chmask = 0;
+		mdev->gpios[i].index = i;
+	}
+
+	mdev->num_gpios = ngpio;
+	mdev->capabilities.num_ext_triggers += ngpio;
+
+	return 0;
+}
+
+static void motion_trigger_work(struct irq_work *work)
+{
+	struct motion_device *mdev = container_of(work, struct motion_device,
+							iiowork);
+	iio_trigger_poll(mdev->iiotrig);
+}
+
+/**
+ * motion_register_device - Register a new Motion Device
+ * @mdev: description and handle of the motion device
+ *
+ * Register a new motion device with the motion subsystem core.
+ * It also handles OF parsing of external trigger GPIOs and registers an IIO
+ * trigger device if IIO support is configured.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int motion_register_device(struct motion_device *mdev)
+{
+	dev_t devt;
+	int err = 0;
+	struct iio_motion_trigger_info *trig_info;
+
+	if (!mdev->capabilities.num_channels)
+		mdev->capabilities.num_channels = 1;
+	if (mdev->capabilities.features | MOT_FEATURE_PROFILE)
+		mdev->capabilities.max_profiles = MOT_MAX_PROFILES;
+	if (!mdev->capabilities.speed_conv_mul)
+		mdev->capabilities.speed_conv_mul = 1;
+	if (!mdev->capabilities.speed_conv_div)
+		mdev->capabilities.speed_conv_div = 1;
+	if (!mdev->capabilities.accel_conv_mul)
+		mdev->capabilities.accel_conv_mul = 1;
+	if (!mdev->capabilities.accel_conv_div)
+		mdev->capabilities.accel_conv_div = 1;
+
+	mutex_init(&mdev->mutex);
+	mutex_init(&mdev->read_mutex);
+	INIT_KFIFO(mdev->events);
+	init_waitqueue_head(&mdev->wait);
+
+	err = motion_of_parse_gpios(mdev);
+	if (err)
+		return err;
+
+	mdev->minor = motion_minor_alloc();
+
+	mdev->iiotrig = iio_trigger_alloc(NULL, "mottrig%d", mdev->minor);
+	if (!mdev->iiotrig) {
+		err = -ENOMEM;
+		goto error_free_minor;
+	}
+
+	trig_info = kzalloc(sizeof(*trig_info), GFP_KERNEL);
+	if (!trig_info) {
+		err = -ENOMEM;
+		goto error_free_trigger;
+	}
+
+	iio_trigger_set_drvdata(mdev->iiotrig, trig_info);
+
+	trig_info->minor = mdev->minor;
+	err = iio_trigger_register(mdev->iiotrig);
+	if (err)
+		goto error_free_trig_info;
+
+	mdev->iiowork = IRQ_WORK_INIT_HARD(motion_trigger_work);
+
+	INIT_LIST_HEAD(&mdev->list);
+
+	mutex_lock(&motion_mtx);
+
+	devt = MKDEV(motion_major, mdev->minor);
+	mdev->dev = device_create_with_groups(&motion_class, mdev->parent,
+				devt, mdev, mdev->groups, "motion%d", mdev->minor);
+	if (IS_ERR(mdev->dev)) {
+		dev_err(mdev->parent, "Error creating motion device %d\n",
+				mdev->minor);
+		mutex_unlock(&motion_mtx);
+		goto error_free_trig_info;
+	}
+	list_add_tail(&mdev->list, &motion_list);
+	mutex_unlock(&motion_mtx);
+
+	return 0;
+
+error_free_trig_info:
+	kfree(trig_info);
+error_free_trigger:
+	iio_trigger_free(mdev->iiotrig);
+error_free_minor:
+	motion_minor_free(mdev->minor);
+	dev_info(mdev->parent, "Registering motion device err=%d\n", err);
+	return err;
+}
+EXPORT_SYMBOL(motion_register_device);
+
+void motion_unregister_device(struct motion_device *mdev)
+{
+	struct iio_motion_trigger_info *trig_info;
+
+	trig_info = iio_trigger_get_drvdata(mdev->iiotrig);
+	iio_trigger_unregister(mdev->iiotrig);
+	kfree(trig_info);
+	iio_trigger_free(mdev->iiotrig);
+	mutex_lock(&motion_mtx);
+	list_del(&mdev->list);
+	device_destroy(&motion_class, MKDEV(motion_major, mdev->minor));
+	motion_minor_free(mdev->minor);
+	mdev->dev = NULL; /* Trigger chardev read abort */
+	mutex_unlock(&motion_mtx);
+}
+EXPORT_SYMBOL(motion_unregister_device);
+
+/**
+ * motion_report_event - Report an event to the motion core.
+ * @mdev: The motion device reporting the event
+ * @evt: The event to be reported and queued.
+ *
+ * Drivers should call this function when there is a motion event, such as
+ * target reached or a (virtual-) stop triggered. This applies only to internal
+ * trigger inputs; external GPIO trigger events are handled by the core.
+ */
+void motion_report_event(struct motion_device *mdev, struct mot_event *evt)
+{
+	int ret;
+
+	dev_info(mdev->dev, "Report event: %d\n", evt->event);
+	switch (evt->event) {
+	case MOT_EVENT_INPUT:
+	case MOT_EVENT_TARGET:
+	case MOT_EVENT_STOP:
+		ret = kfifo_put(&mdev->events, *evt);
+		if (ret)
+			wake_up_poll(&mdev->wait, EPOLLIN);
+		irq_work_queue(&mdev->iiowork);
+		break;
+	default:
+		break;
+	}
+
+}
+EXPORT_SYMBOL(motion_report_event);
+
+static int __init motion_init(void)
+{
+	int err;
+
+	err = class_register(&motion_class);
+	if (err)
+		return err;
+
+	motion_major = register_chrdev(0, "motion", &motion_fops);
+	if (motion_major <= 0) {
+		err = -EIO;
+		goto fail;
+	}
+	return 0;
+
+fail:
+	pr_err("unable to get major number for motion devices\n");
+	class_unregister(&motion_class);
+	return err;
+}
+subsys_initcall(motion_init);
diff --git a/drivers/motion/motion-core.h b/drivers/motion/motion-core.h
new file mode 100644
index 000000000000..92d0fc816265
--- /dev/null
+++ b/drivers/motion/motion-core.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __MOTION_CORE_H__
+#define __MOTION_CORE_H__
+
+#include <linux/major.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/kfifo.h>
+#include <linux/irq_work.h>
+#include <uapi/linux/motion.h>
+
+struct motion_device;
+
+/**
+ * struct motion_ops - Motion driver API
+ * @device_open: Called when the associated device is opened
+ * @device_release: Called when the associated device is closed
+ * @basic_run: Start a basic movement of channel @ch with speed @v. Speed is a
+ *      signed value. Sign indicates direction.
+ * @basic_stop: Immediately stops all active movements of all channels set in
+ *      channel mask @ch.
+ * @get_status: Get current speed and position (if supported) from the channel
+ *      specified in st->channel.
+ * @move_distance: Start a movement just like basic_run(), but stop after
+ *      reaching the specified distance. Optional.
+ * @move_timed: Start a movement just like basic_run(), but stop after a
+ *      specified time. Optional.
+ * @validate_profile: Check if all parameters of a specified movement profile
+ *      (acceleration/speed curve) is valid for this driver. Optional.
+ * @motion_distance: Start or prepare to start a movement following a specified
+ *      motion profile until reaching the target distance. Optional.
+ * @motion_timed: Start or prepare to start a movement following a specified
+ *      motion profile that takes exactly @t time. Optional.
+ * @motion_stop: Stop or prepare to stop a movement that was initiated with
+ *      either motion_timed() or motion_distance() prematurely while following
+ *      the deceleration segment of the profile the movement was started with.
+ *      Optional.
+ * @config_trigger: Setup a trigger @index for a certaing function @func that
+ *      applies to all channels set in channel mask @ch. Only applies to
+ *      internal triggers. Optional.
+ * @external_trigger: Initiate a movement by external trigger on all channels
+ *      set in channel mask @ch. Optional.
+ *
+ * Channel mask parameters of typo channel_mask_t are bitmasks that specify
+ * multiple channels the call applies to simultaneously.
+ *
+ * The parameter @when specifies one of the MOT_WHEN_* values defined in the
+ * motion UAPI.
+ * The parameter @func specifies one of the MOT_FUNC_* values defined in the
+ * motion UAPI.
+ * The parameter @edge can be either MOT_EDGE_FALLING or MOT_EDGE_RISING.
+ * The parameter @index either refers to the index of a motion profile, or the
+ * index of an internal trigger intput depending on the context.
+ *
+ * All function calls specified as "Optional" above need to be implemented only
+ * if the driver can support the required functionality.
+ */
+struct motion_ops {
+	int (*device_open)(struct motion_device *mdev);
+	int (*device_release)(struct motion_device *mdev);
+	int (*basic_run)(struct motion_device *mdev, unsigned int ch, s32 v);
+	int (*basic_stop)(struct motion_device *mdev, channel_mask_t ch);
+	int (*get_status)(struct motion_device *mdev, struct mot_status *st);
+	int (*move_distance)(struct motion_device *mdev, unsigned int ch,
+			s32 v, u32 d);
+	int (*move_timed)(struct motion_device *mdev, unsigned int ch, s32 v,
+			ktime_t t);
+	int (*validate_profile)(struct motion_device *mdev,
+			struct mot_profile *p);
+	int (*set_profile)(struct motion_device *mdev, struct mot_profile *p);
+	int (*motion_distance)(struct motion_device *mdev, unsigned int ch,
+			unsigned int index, s32 d, unsigned int when);
+	int (*motion_timed)(struct motion_device *mdev, unsigned int ch,
+			unsigned int index, unsigned int dir, ktime_t t,
+			unsigned int when);
+	int (*motion_stop)(struct motion_device *mdev, channel_mask_t ch,
+			unsigned int when);
+	int (*config_trigger)(struct motion_device *mdev, unsigned int index,
+			unsigned int func, unsigned int edge, channel_mask_t ch);
+	void (*external_trigger)(struct motion_device *mdev, unsigned int index,
+			channel_mask_t ch);
+};
+
+struct motion_gpio_input {
+	struct gpio_desc *gpio;
+	unsigned int function;
+	unsigned int edge;
+	unsigned int index;
+	channel_mask_t chmask;
+};
+
+/**
+ * struct motion_device - Represents a motion control subsystem device
+ * @ops: struct motion_ops implementing the functionality of the device.
+ * @parent: Parent struct device. This can be an underlying SPI/I2C device or
+ *      a platform device, etc... This is mandatory.
+ * @dev: Newly created motion device associated with the denode. Filled in
+ *      by motion_register_device().
+ * @minor: The motion device minor number allocated by motion_register_device().
+ * @list: Internal housekeeping.
+ * @groups: Attribute groups of the device. The driver can add an entry to the
+ *      attributes table if required. Should be used for all run-time parameters
+ *      of the underlying hardware, like current limits, virtual stop positions,
+ *      etc...
+ * @nodename: Optional name of the devnode. Default NULL will use motionXX
+ * @mode: Optional mode for the devnode.
+ * @mutex: Mutex for serializing access to the device. Used by the core and
+ *      locked during calls to the @ops. Should be locked by the driver if
+ *      entered from other places, like interrupt threads.
+ * @read_mutex: Mutex used by the core for serializing read() calls to the
+ *      device.
+ * @capabilities: struct mot_capabilities, describes the capabilities of the
+ *      particular driver.
+ * @profiles: Statically allocated list of motion profiles. The core stores
+ *      motion profiles supplied by user-space in this list. The @index
+ *      parameter in @ops calls is an index into this list if applicable.
+ * @gpios: Statically allocated list of external trigger inputs associated with
+ *      this device. These are specified in the fwnode.
+ * @num_gpios: Number of external GPIO trigger inputs parsed from the fwnode.
+ * @wait: poll() waitqueue for motion events to user-space.
+ * @events: KFIFO of motion events.
+ * @iiotrig: IIO trigger of motion events.
+ * @iiowork: The irq_work that dispatches the IIO trigger events.
+ * @helper_cookie: internal data for helper functions such as timed_speed
+ *      helpers.
+ *
+ * Motion device drivers should (devm_)kzalloc this struct and fill in all
+ * required information (@ops, @parent and @capabilities) and then call
+ * motion_register_device() from their probe function.
+ *
+ * @parent should hold any drvdata for the driver if needed, and the drvdata
+ * struct should contain this struct motion_device as a member, so that it can
+ * be retrieved with container_of() macros.
+ */
+struct motion_device {
+	struct motion_ops		ops;
+	struct device			*parent;
+	struct device			*dev;
+	int				minor;
+	struct list_head		list;
+	const struct attribute_group	*groups[3];
+	const char			*nodename;
+	umode_t				mode;
+	struct mutex			mutex;
+	struct mutex			read_mutex;
+	struct mot_capabilities		capabilities;
+	struct mot_profile		profiles[MOT_MAX_PROFILES];
+	struct motion_gpio_input	gpios[MOT_MAX_INPUTS];
+	unsigned int			num_gpios;
+	wait_queue_head_t		wait;
+	DECLARE_KFIFO(events, struct mot_event, 16);
+	struct iio_trigger		*iiotrig;
+	struct irq_work			iiowork;
+	void				*helper_cookie;
+};
+
+static inline ktime_t mot_time2ktime(mot_time_t t)
+{
+	return (ktime_t)t;
+}
+
+static inline mot_time_t ktime2mot_time(ktime_t t)
+{
+	return (mot_time_t)t;
+}
+
+int motion_register_device(struct motion_device *mdev);
+void motion_unregister_device(struct motion_device *mdev);
+void motion_report_event(struct motion_device *mdev, struct mot_event *evt);
+
+#endif /* __MOTION_CORE_H__ */
diff --git a/drivers/motion/motion-helpers.c b/drivers/motion/motion-helpers.c
new file mode 100644
index 000000000000..b4c8dda84aa7
--- /dev/null
+++ b/drivers/motion/motion-helpers.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Motion Control Subsystem - helper functions
+ *
+ * Copyright (C) 2024 Protonic Holland
+ *      David Jander <david@protonic.nl>
+ */
+
+#include <linux/fwnode.h>
+#include <linux/property.h>
+#include <linux/device.h>
+#include <linux/gfp_types.h>
+#include <linux/hrtimer_types.h>
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/motion.h>
+#include "motion-helpers.h"
+#include "motion-core.h"
+
+#define MOTION_TIMER_PERIOD (20 * NSEC_PER_MSEC)
+
+struct motion_timed_speed {
+	struct motion_device *mdev;
+	struct motion_timed_speed_ops *ops;
+	unsigned int speed_full_scale;
+	spinlock_t lock;
+	struct hrtimer timer;
+	unsigned int speed_actual;
+	unsigned int dir;
+	unsigned int speed_max;
+	unsigned int speed_start;
+	unsigned int speed_end;
+	unsigned int deceleration;
+	ktime_t taccel;
+	ktime_t tdecel;
+	ktime_t duration;
+	ktime_t ts_start;
+	unsigned int next_index;
+	unsigned int next_dir;
+	ktime_t next_duration;
+	unsigned int ext_trg_index;
+	unsigned int ext_trg_dir;
+	ktime_t ext_trg_duration;
+};
+
+static inline int __to_signed_speed(unsigned int dir, unsigned int speed)
+{
+	if (dir)
+		return speed;
+	return -speed;
+}
+
+static int motion_timed_speed_open(struct motion_device *mdev)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+
+	if (mts->ops->startup)
+		mts->ops->startup(mdev);
+
+	return 0;
+}
+
+static int motion_timed_speed_release(struct motion_device *mdev)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+
+	dev_info(mdev->dev, "Release\n");
+	hrtimer_cancel(&mts->timer);
+	if (mts->ops->powerdown)
+		mts->ops->powerdown(mdev);
+	else
+		mts->ops->set_speed(mdev, 0, 0);
+	mts->next_duration = 0;
+	mts->speed_actual = 0;
+	mts->dir = 0;
+
+	return 0;
+}
+
+static int motion_timed_speed_get_status(struct motion_device *mdev, struct mot_status *st)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+
+	st->speed = __to_signed_speed(mts->dir, mts->speed_actual);
+	st->position = 0; /* FIXME: Not yet supported */
+
+	return 0;
+}
+
+static int motion_timed_speed_basic_run(struct motion_device *mdev, unsigned int ch, s32 v)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+	int ret;
+	unsigned int dir = (v < 0) ? 0 : 1;
+	unsigned int dc = abs(v);
+	unsigned long flags;
+
+	hrtimer_cancel(&mts->timer);
+
+	spin_lock_irqsave(&mts->lock, flags);
+	ret = mts->ops->check_speed(mdev, dir, dc);
+	if (!ret) {
+		mts->speed_max = dc;
+		mts->ops->set_speed(mdev, dir, dc);
+		mts->speed_actual = dc;
+		mts->dir = dir;
+	}
+	spin_unlock_irqrestore(&mts->lock, flags);
+
+	return ret;
+}
+
+static int motion_timed_speed_basic_stop(struct motion_device *mdev, channel_mask_t ch)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+	unsigned long flags;
+
+	hrtimer_cancel(&mts->timer);
+
+	spin_lock_irqsave(&mts->lock, flags);
+	mts->ops->set_speed(mdev, 0, 0);
+	mts->dir = 0;
+	mts->speed_actual = 0;
+	mts->speed_max = 0;
+	spin_unlock_irqrestore(&mts->lock, flags);
+
+	return 0;
+}
+
+static int motion_timed_speed_move_timed(struct motion_device *mdev, unsigned int ch,
+		s32 v, ktime_t t)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+	unsigned long flags;
+	unsigned int dir = (v < 0) ? 0 : 1;
+	unsigned int dc = abs(v);
+	int ret;
+
+	hrtimer_cancel(&mts->timer);
+
+	spin_lock_irqsave(&mts->lock, flags);
+	ret = mts->ops->check_speed(mdev, dir, dc);
+	if (!ret) {
+		mts->ops->set_speed(mdev, dir, dc);
+		mts->speed_actual = dc;
+		mts->dir = dir;
+		mts->ts_start = ktime_get();
+		mts->duration = t;
+		mts->speed_max = dc;
+		mts->deceleration = 0;
+		mts->taccel = 0;
+		mts->tdecel = 0;
+		mts->speed_start = 0;
+		mts->speed_end = 0;
+	}
+	spin_unlock_irqrestore(&mts->lock, flags);
+	if (ret)
+		return ret;
+
+	hrtimer_start(&mts->timer, MOTION_TIMER_PERIOD, HRTIMER_MODE_REL_SOFT);
+
+	return ret;
+}
+
+static int motion_timed_speed_validate_profile(struct motion_device *mdev,
+		struct mot_profile *p)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+
+	if ((p->na != 2) || (p->nv != 3))
+		return -EINVAL;
+	if ((p->acc[0] <= 0) || (p->acc[1] <= 0))
+		return -EINVAL;
+	if ((p->vel[0] > p->vel[1]) || (p->vel[2] > p->vel[1]))
+		return -EINVAL;
+	if ((p->vel[0] < 0) || (p->vel[1] <= 0) || (p->vel[2] < 0))
+		return -EINVAL;
+	if (p->vel[1] > mts->speed_full_scale)
+		return -EINVAL;
+	return 0;
+}
+
+static int motion_timed_speed_set_profile(struct motion_device *mdev,
+		struct mot_profile *p)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+	unsigned long flags;
+	unsigned int smd;
+	unsigned int esd;
+
+	spin_lock_irqsave(&mts->lock, flags);
+	mts->speed_start = p->vel[0];
+	mts->speed_max = p->vel[1];
+	mts->speed_end = p->vel[2];
+	mts->deceleration = p->acc[1];
+	smd = mts->speed_max - mts->speed_start;
+	esd = mts->speed_max - mts->speed_end;
+	mts->taccel = div_u64((u64)smd * NSEC_PER_SEC, p->acc[0]);
+	mts->tdecel = div_u64((u64)esd * NSEC_PER_SEC, mts->deceleration);
+	spin_unlock_irqrestore(&mts->lock, flags);
+
+	return 0;
+}
+
+static void motion_timed_with_index(struct motion_device *mdev,
+		unsigned int index, int dir, ktime_t t)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+
+	motion_timed_speed_set_profile(mdev, &mdev->profiles[index]);
+	mts->ops->set_speed(mdev, dir, mts->speed_start);
+	mts->speed_actual = mts->speed_start;
+	mts->dir = dir;
+	mts->duration = t;
+	mts->ts_start = ktime_get();
+}
+
+static int calc_speed(struct motion_timed_speed *mts, ktime_t now, ktime_t trem)
+{
+	int smd = mts->speed_max - mts->speed_actual;
+	int dva = mts->speed_max - mts->speed_start;
+	int dvd = mts->speed_actual - mts->speed_end;
+	ktime_t tel = ktime_sub(now, mts->ts_start);
+
+	if (trem <= 0)
+		return 0;
+
+	mts->tdecel = mts->deceleration ?
+		      div_u64((u64)dvd * NSEC_PER_SEC, mts->deceleration) : 0;
+
+	if ((smd <= 0) && (ktime_compare(trem, mts->tdecel) > 0))
+		return mts->speed_max;
+
+	/* Due to (trem > 0), zerodivision can't happen here */
+	if (ktime_compare(trem, mts->tdecel) < 0)
+		return mts->speed_end + div64_s64((dvd * trem), mts->tdecel);
+
+	/* Due to (tel > 0) zerodivision can't happen here */
+	if (ktime_compare(tel, mts->taccel) < 0)
+		return mts->speed_start + div64_s64((dva * tel), mts->taccel);
+
+	return mts->speed_actual;
+}
+
+static enum hrtimer_restart motion_timed_speed_timer(struct hrtimer *timer)
+{
+	struct motion_timed_speed *mts = container_of(timer,
+			struct motion_timed_speed, timer);
+	struct motion_device *mdev = mts->mdev;
+	struct mot_event evt = {0};
+	unsigned long flags;
+	ktime_t now = ktime_get();
+	ktime_t trem = ktime_sub(ktime_add(mts->ts_start, mts->duration), now);
+	int speed;
+	int ret = HRTIMER_RESTART;
+
+	spin_lock_irqsave(&mts->lock, flags);
+	speed = calc_speed(mts, now, trem);
+	if (speed != mts->speed_actual) {
+		mts->ops->set_speed(mdev, mts->dir, speed);
+		mts->speed_actual = speed;
+		mts->dir = mts->dir;
+	}
+	spin_unlock_irqrestore(&mts->lock, flags);
+	if (trem <= 0) {
+		mutex_lock(&mdev->mutex);
+		if (mts->next_duration) {
+			motion_timed_with_index(mdev, mts->next_index,
+					mts->next_dir, mts->next_duration);
+			mts->next_duration = 0;
+		} else {
+			ret = HRTIMER_NORESTART;
+		}
+		evt.speed = __to_signed_speed(mts->dir, mts->speed_actual);
+		evt.timestamp = ktime2mot_time(now);
+		evt.event = MOT_EVENT_TARGET;
+		motion_report_event(mdev, &evt);
+		mutex_unlock(&mdev->mutex);
+	}
+
+	if (ret == HRTIMER_RESTART)
+		hrtimer_add_expires_ns(timer, MOTION_TIMER_PERIOD);
+
+	return ret;
+}
+
+static int motion_timed_speed_motion_timed(struct motion_device *mdev, unsigned int ch,
+			unsigned int index, unsigned int dir, ktime_t t,
+			unsigned int when)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+	int ret = 0;
+
+	ret = mts->ops->check_speed(mdev, dir, 0);
+	if (ret)
+		return -EINVAL;
+
+	switch (when) {
+	case MOT_WHEN_NEXT:
+		if (mts->next_duration) {
+			ret = -EAGAIN;
+		} else {
+			mts->next_duration = t;
+			mts->next_index = index;
+			mts->next_dir = dir;
+		}
+		break;
+	case MOT_WHEN_EXT_TRIGGER:
+		if (mts->ext_trg_duration) {
+			ret = -EAGAIN;
+		} else {
+			mts->ext_trg_duration = t;
+			mts->ext_trg_index = index;
+			mts->ext_trg_dir = dir;
+		}
+		break;
+	case MOT_WHEN_IMMEDIATE:
+		motion_timed_with_index(mdev, index, dir, t);
+		hrtimer_start(&mts->timer, MOTION_TIMER_PERIOD,
+				HRTIMER_MODE_REL_SOFT);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int motion_timed_speed_motion_stop(struct motion_device *mdev, channel_mask_t ch,
+		unsigned int when)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+	unsigned long flags;
+
+	if (when != MOT_WHEN_IMMEDIATE)
+		return -EINVAL;
+
+	spin_lock_irqsave(&mts->lock, flags);
+	if (hrtimer_active(&mts->timer)) {
+		mts->duration = mts->tdecel;
+		mts->ts_start = ktime_get();
+	}
+	spin_unlock_irqrestore(&mts->lock, flags);
+
+	return 0;
+}
+
+static void motion_timed_speed_ext_trigger(struct motion_device *mdev, unsigned int index,
+		channel_mask_t ch)
+{
+	struct motion_timed_speed *mts =
+		(struct motion_timed_speed *)mdev->helper_cookie;
+
+	if (mts->ext_trg_duration) {
+		hrtimer_cancel(&mts->timer);
+
+		motion_timed_with_index(mdev, mts->ext_trg_index,
+				mts->ext_trg_dir, mts->ext_trg_duration);
+		mts->ext_trg_duration = 0;
+		hrtimer_start(&mts->timer, MOTION_TIMER_PERIOD,
+				HRTIMER_MODE_REL_SOFT);
+	}
+}
+
+static struct motion_ops motion_timed_speed_motion_ops = {
+	.device_open = motion_timed_speed_open,
+	.device_release = motion_timed_speed_release,
+	.get_status = motion_timed_speed_get_status,
+	.basic_run = motion_timed_speed_basic_run,
+	.basic_stop = motion_timed_speed_basic_stop,
+	.move_timed = motion_timed_speed_move_timed,
+	.validate_profile = motion_timed_speed_validate_profile,
+	.set_profile = motion_timed_speed_set_profile,
+	.motion_timed = motion_timed_speed_motion_timed,
+	.motion_stop = motion_timed_speed_motion_stop,
+	.external_trigger = motion_timed_speed_ext_trigger
+};
+
+/**
+ * motion_timed_speed_init - Initialize a simple timed-speed motion device
+ * @mdev: Motion device that shall be initialized
+ * @ops: API functions provided by driver
+ * @full_scale: The maximum integer value for "full speed" for this device
+ *
+ * Allows a motion control driver that only has a means of adjusting motor
+ * speed and optionally -direction to augment its functionality to support
+ * trapezoidal motion profiles.
+ *
+ * Caller should create a struct motion_device and, populate
+ * capabilities.type, capabilities.subdiv and optionally the scaling factors
+ * and then call this function, which will add mdev->ops and fill in the
+ * rest. It is responsibility of the driver to call motion_register_device()
+ * afterwards.
+ *
+ * Return: 0 in case of success or a negative errno.
+ */
+int motion_timed_speed_init(struct motion_device *mdev,
+		struct motion_timed_speed_ops *ops, unsigned int full_scale)
+{
+	struct motion_timed_speed *mts;
+
+	mts = devm_kzalloc(mdev->parent, sizeof(struct motion_timed_speed),
+			GFP_KERNEL);
+	if (!mts)
+		return -ENOMEM;
+
+	mts->ops = ops;
+	mts->mdev = mdev;
+	mts->speed_full_scale = full_scale;
+	mdev->ops = motion_timed_speed_motion_ops;
+	mdev->capabilities.features |= MOT_FEATURE_SPEED | MOT_FEATURE_ACCEL |
+	    MOT_FEATURE_PROFILE;
+	mdev->capabilities.num_channels = 1;
+	mdev->capabilities.max_apoints = 2;
+	mdev->capabilities.max_vpoints = 3;
+	mdev->capabilities.num_int_triggers = 0;
+	mdev->capabilities.num_ext_triggers = 0; /* Filled in by core */
+	mdev->capabilities.subdiv = 1;
+	mdev->helper_cookie = mts;
+
+	spin_lock_init(&mts->lock);
+	hrtimer_init(&mts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	mts->timer.function = motion_timed_speed_timer;
+
+	return 0;
+}
+EXPORT_SYMBOL(motion_timed_speed_init);
+
+/**
+ * motion_fwnode_get_capabilities - Get motion specific properties from fwnode
+ * @mdev: Motion device to populate
+ * @fwnode: fwnode handle to read properties from.
+ *
+ * Reads motion specific properties from @fwnode and populates @mdev
+ * capabilities.
+ */
+void motion_fwnode_get_capabilities(struct motion_device *mdev,
+		struct fwnode_handle *fwnode)
+{
+	unsigned int val, err;
+
+	err = fwnode_property_read_u32(fwnode, "motion,speed-conv-mul", &val);
+	if (!err)
+		mdev->capabilities.speed_conv_mul = val;
+	err = fwnode_property_read_u32(fwnode, "motion,speed-conv-div", &val);
+	if (!err && val)
+		mdev->capabilities.speed_conv_div = val;
+	err = fwnode_property_read_u32(fwnode, "motion,acceleration-conv-mul", &val);
+	if (!err)
+		mdev->capabilities.accel_conv_mul = val;
+	err = fwnode_property_read_u32(fwnode, "motion,acceleration-conv-div", &val);
+	if (!err && val)
+		mdev->capabilities.accel_conv_div = val;
+}
+EXPORT_SYMBOL(motion_fwnode_get_capabilities);
+
+static inline int __d2t_vmax(u64 a, u64 d, u32 Vmax32, u64 Vs, u64 Ve, u64 Xt,
+		u64 t2, u64 *Vs2, u64 *Ve2, ktime_t *t)
+{
+	u64 Vmax = (u64)Vmax32;
+	u64 Vm2 = Vmax * Vmax32;
+	u64 dva = Vmax32 - Vs;
+	u64 dvd = Vmax32 - Ve;
+	u64 ta = div_u64(dva * MSEC_PER_SEC, (u32)a);
+	u64 td = div_u64(dvd * MSEC_PER_SEC, (u32)d);
+	u64 X1;
+	u64 X3;
+	u64 Xtv = div_u64(Vmax * t2, MSEC_PER_SEC);
+	u64 tms;
+
+	*Vs2 = (u64)Vs * Vs;
+	*Ve2 = (u64)Ve * Ve;
+	X1 = div64_u64(Vm2 - *Vs2, a << 1);
+	X3 = div64_u64(Vm2 - *Ve2, d << 1);
+
+	/* Check if we can reach Vmax. If not try again with new Vmax */
+	if (Xt > (X1 + X3 + Xtv)) {
+		tms = ta + td;
+		tms += div_u64(MSEC_PER_SEC * (Xt - X1 - X3), Vmax32);
+		*t = ktime_add_ms(0, tms);
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+
+/**
+ * motion_distance_to_time - Convert distance to time period
+ * @mdev: Motion device
+ * @index: The index of the motion profile to use
+ * @distance: The covered distance of the complete movement
+ * @t: Pointer to ktime_t result
+ *
+ * Converts the @distance of a movement using a motion (acceleration) profile
+ * specified by @index into a time interval this movement would take.
+ *
+ * The only supported profile type is trapezoidal (3 velocity points and 2
+ * acceleration values), and it takes into account Tvmax and the case where
+ * Vmax cannot be reached because the distance is too short.
+ *
+ * Return: 0 on success and -ENOTSUPP if profile is not trapezoidal.
+ */
+long motion_distance_to_time(struct motion_device *mdev,
+		unsigned int index, int distance, ktime_t *t)
+{
+	struct mot_profile *p = &mdev->profiles[index];
+	unsigned int Vs = p->vel[0];
+	unsigned int Ve = p->vel[2];
+	u64 Vmax;
+	u64 a = p->acc[0]; /* Has been checked to be non-zero */
+	u64 d = p->acc[1]; /* Has been checked to be non-zero */
+	u64 Xt = abs(distance);
+	u64 t2 = ktime_to_ms(p->tvmax);
+	u64 Ve2, Vs2, Bt, disc;
+	s64 ACt;
+	unsigned int bl;
+
+	if ((p->na != 2) || (p->nv != 3))
+		return -EOPNOTSUPP;
+
+	if (!__d2t_vmax(a, d, p->vel[1], Vs, Ve, Xt, t2, &Vs2, &Ve2, t))
+		return 0;
+
+	/*
+	 * We can't reach Vmax, so we need to determine Vmax that
+	 * satisfies tvmax and distance, given a and d.
+	 * For that we need to solve a quadratic equation in the form:
+	 *
+	 * 0 = Vm^2*(1/2a + 1/2d) + Vm * tvmax - Vs^2/2a - Ve^2/2d - Xt
+	 *
+	 * Doing this with only 64-bit integers will require scaling to
+	 * adequate bit-lengths and an inevitable loss of precision.
+	 * Precision is not critical since this function will be used
+	 * to approximate a mechanical movement's distance by timing.
+	 */
+	bl = fls(a) + fls(d) + fls(Ve) + fls(Vs);
+	bl = max(0, (bl >> 1) - 16);
+	Bt = div_u64(a * d * t2, MSEC_PER_SEC);
+
+	/*
+	 * All terms are shifted left by bl bits *twice* (!)
+	 * This will go into the square-root, so the result needs to be
+	 * shifted right by bl bits only *once*.
+	 */
+	ACt = -((a*a) >> bl)*(Ve2 >> bl) - ((d*d) >> bl)*(Vs2 >> bl) -
+	      ((a*d) >> bl)*((2*d*Xt + 2*a*Xt + Vs2 + Ve2) >> bl);
+	disc = (Bt >> bl) * (Bt >> bl) - ACt;
+	if (disc < 0) {
+		/* This should not be possible if (Ve, Vs) < Vm */
+		WARN_ONCE(true, "Discriminator is negative!");
+		disc = 0;
+	}
+
+	/*
+	 * We have all the parts of the quadratic formula, so we can
+	 * calculate Vmax. There are some constraints we can take
+	 * for granted here:
+	 *  - The term 4AC (ACt) is strictly negative, so the
+	 *    discriminant will always be bigger than Bt^2.
+	 *  - Due to this, the result of the square root will be
+	 *    bigger than Bt, which means there will always be one
+	 *    positive real solution for Vmax.
+	 *  - The dividend (a + d) cannot be zero, since a and d are
+	 *    both tested to be positive and non zero in
+	 *    motion_set_profile().
+	 */
+	 /* NOLINTNEXTLINE(clang-analyzer-core.DivideZero) */
+	Vmax = div64_u64(-Bt + ((u64)int_sqrt64(disc) << bl), a + d);
+	Ve = min(Ve, Vmax);
+	Vs = min(Vs, Vmax);
+	dev_info(mdev->dev, "D2T: Vs=%u, Vmax=%llu, Ve=%u\n", Vs, Vmax, Ve);
+
+	/* Try again with new Vmax. This time will always succeed. */
+	__d2t_vmax(a, d, Vmax, Vs, Ve, Xt, t2, &Vs2, &Ve2, t);
+
+	return 0;
+}
+EXPORT_SYMBOL(motion_distance_to_time);
diff --git a/drivers/motion/motion-helpers.h b/drivers/motion/motion-helpers.h
new file mode 100644
index 000000000000..0752390bf33a
--- /dev/null
+++ b/drivers/motion/motion-helpers.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __MOTION_HELPERS_H__
+#define __MOTION_HELPERS_H__
+
+#include "motion-core.h"
+
+struct motion_timed_speed_ops {
+	void (*set_speed)(struct motion_device *mdev, unsigned int dir,
+			unsigned int speed);
+	int (*check_speed)(struct motion_device *mdev, unsigned int dir,
+			unsigned int speed);
+	void (*startup)(struct motion_device *mdev);
+	void (*powerdown)(struct motion_device *mdev);
+};
+
+int motion_timed_speed_init(struct motion_device *mdev,
+		struct motion_timed_speed_ops *ops, unsigned int full_scale);
+void motion_fwnode_get_capabilities(struct motion_device *mdev,
+		struct fwnode_handle *fwnode);
+long motion_distance_to_time(struct motion_device *mdev,
+		unsigned int index, int distance, ktime_t *t);
+
+#endif /* __MOTION_HELPERS_H__ */
diff --git a/include/uapi/linux/motion.h b/include/uapi/linux/motion.h
new file mode 100644
index 000000000000..72a7e564114d
--- /dev/null
+++ b/include/uapi/linux/motion.h
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_MOTION_H
+#define _UAPI_LINUX_MOTION_H
+
+#include <linux/const.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* NOTE: Proposing to use IOC 'M' seq 0x80-0xc0 */
+
+#define MOT_MAX_PROFILES 32
+#define MOT_MAX_SPEEDPTS 5
+#define MOT_MAX_ACCELPTS 6
+#define MOT_MAX_INPUTS 32
+#define MOT_UAPI_VERSION 1
+
+/* Trigger inputs and End Stop functions */
+enum {
+	MOT_INP_FUNC_NONE = 0,	/* No-op, used to clear previous functions */
+	MOT_INP_FUNC_STOP,	/* Stop immediately */
+	MOT_INP_FUNC_STOP_POS,	/* Stop immediately if moving forward */
+	MOT_INP_FUNC_STOP_NEG,	/* Stop immediately if moving backward */
+	MOT_INP_FUNC_DECEL,	/* Stop by deceleration curve */
+	MOT_INP_FUNC_DECEL_POS,
+	MOT_INP_FUNC_DECEL_NEG,
+	MOT_INP_FUNC_START,	/* Start motion with preset profile */
+	MOT_INP_FUNC_SIGNAL,	/* Only produce a signal (EPOLLIN) */
+	MOT_INP_FUNC_NUM_FUNCS
+};
+
+/* Config trigger input edge */
+#define MOT_EDGE_RISING 0
+#define MOT_EDGE_FALLING 1
+
+/* Start/Stop conditions */
+enum {
+	MOT_WHEN_IMMEDIATE = 0,
+	MOT_WHEN_INT_TRIGGER,	/* On internal trigger input */
+	MOT_WHEN_EXT_TRIGGER,	/* On external trigger input */
+	MOT_WHEN_NEXT,		/* After preceding (current) motion ends */
+	MOT_WHEN_NUM_WHENS
+};
+
+/* Event types */
+enum {
+	MOT_EVENT_NONE = 0,
+	MOT_EVENT_TARGET,	/* Target position reached */
+	MOT_EVENT_STOP,		/* Endstop triggered */
+	MOT_EVENT_INPUT,	/* (Virtual-) input event */
+	MOT_EVENT_STALL,	/* Motor stalled */
+	MOT_EVENT_ERROR,	/* Other motor drive error */
+	MOT_EVENT_NUM_EVENTS
+};
+
+#define MOT_DIRECTION_LEFT 0
+#define MOT_DIRECTION_RIGHT 1
+
+/* Convention of signed position, speed and acceleration:
+ * movement of one channel is unidimensional, meaning position can be above or
+ * below the origin (positive or negative respecively). Consequently, given
+ * a positive position, a positive speed represents a movement further away
+ * from the origin (position 0), while a negative speed value represents a
+ * movement towards the origin. The opposite is valid when starting from a
+ * negative position value.
+ * Analogous to what speed does to position, is what acceletation does to speed:
+ * Given positive speed, positive acceleration increments the speed, and given
+ * "negative" speed, negative acceleration decrements the speed (increments its
+ * absolute value).
+ * For movement profiles, the convention is that profile (acceleration-, speed-)
+ * values are strictly positive. The direction of movement is solely determined
+ * by the relative position (i.e. "positive" or "negative" displacement).
+ */
+typedef __u32 channel_mask_t;
+typedef __s32 pos_raw_t;
+typedef __s32 speed_raw_t;
+typedef __s32 accel_raw_t;
+typedef __u32 torque_raw_t;
+typedef __s64 mot_time_t; /* Try to mimic ktime_t, unit is nanoseconds. */
+
+#define MOT_FEATURE_SPEED	BIT(0)
+#define MOT_FEATURE_ACCEL	BIT(1)
+#define MOT_FEATURE_ENCODER	BIT(2)
+#define MOT_FEATURE_PROFILE	BIT(3)
+#define MOT_FEATURE_VECTOR	BIT(4)
+
+enum motion_device_type {
+	MOT_TYPE_DC_MOTOR,
+	MOT_TYPE_AC_MOTOR,
+	MOT_TYPE_STEPPER,
+	MOT_TYPE_BLDC,
+	MOT_TYPE_SRM,
+	MOT_TYPE_LINEAR,
+	MOT_TYPE_NUM_TYPES
+};
+
+struct mot_capabilities {
+	__u32 features;
+	__u8 type;
+	__u8 num_channels;
+	__u8 num_int_triggers;
+	__u8 num_ext_triggers;
+	__u8 max_profiles;
+	__u8 max_vpoints;
+	__u8 max_apoints;
+	__u8 reserved1;
+	__u32 subdiv; /* Position unit sub-divisions, microsteps, etc... */
+	/*
+	 * Coefficients for converting to/from controller time <--> seconds.
+	 * Speed[1/s] = Speed[controller_units] * conv_mul / conv_div
+	 * Accel[1/s^2] = Accel[controller_units] * conv_mul / conv_div
+	 */
+	__u32 speed_conv_mul;
+	__u32 speed_conv_div;
+	__u32 accel_conv_mul;
+	__u32 accel_conv_div;
+	__u32 reserved2;
+};
+
+struct mot_speed_duration {
+	__u32 channel;
+	speed_raw_t speed;
+	mot_time_t duration;
+	pos_raw_t distance;
+	__u32 reserved[3];
+};
+
+struct mot_status {
+	__u32 channel;
+	pos_raw_t position;
+	speed_raw_t speed;
+	__u32 reserved;
+};
+
+struct mot_input {
+	__u32 index;
+	__u8 external;
+	__u8 edge;
+	__u8 reserved[2];
+	__u32 function;
+	channel_mask_t chmask;
+};
+
+/**
+ * struct mot_profile - Describe an acceleration profile
+ * @index: The index into the table of profiles to change
+ * @tvmax: Minimum time to stay at maximum velocity
+ * @tvzero: Minimum time to stay at zero velocity
+ * @na: Number of acceleration values
+ * @nv: Number of velocity values
+ * @acc: List of acceleration values. All values are absolute machine units.
+ * @vel: List of velocity values. All values are absolure machine units.
+ *
+ * 3 different types of acceleration curves are supported:
+ * 1. Trapezoidal - comprised of 3 velocity values and 2 acceleration values.
+ *    Motion starts at start velocity (vel[0]) and accelerates with acc[0]
+ *    linearly up to maximum velocity vel[1]. Maximum velocity is maintained
+ *    for at least tvmax, before decelerating with acc[1] down to stop
+ *    velocity vel[2]. After that velocity drops to zero and stays there for
+ *    at least tvzero.
+ *
+ * 2. Dual slope - comprised of 4 velocity values and 4 acceleration values.
+ *    Similar to trapezoidal profile above, but adding an intermediate
+ *    velocity vel[1]. acc[0] is the first acceleration slope between
+ *    vel[0] and vel[1]. acc[1] is the second acceleration slope between
+ *    vel[1] and vel[2] (maximum velocity). acc[2] is the first deceleration
+ *    slope between vel[2] and vel[1], and acc[3] is the final deceleration
+ *    slope between vel[1] and vel[3].
+ *
+ * 3. S-curve profile - Most advanced profile, often also called 8-point
+ *    profile, comprised of 5 velocity values and 6 acceleration values.
+ */
+struct mot_profile {
+	__u32 index;
+	mot_time_t tvmax;
+	mot_time_t tvzero;
+	__u8 na;
+	__u8 nv;
+	__u8 reserved[2];
+	accel_raw_t acc[MOT_MAX_ACCELPTS];
+	speed_raw_t vel[MOT_MAX_SPEEDPTS];
+};
+
+struct mot_start {
+	__u32 channel;
+	__u8 direction;
+	__u8 index;
+	__u8 when;
+	__u8 reserved1;
+	mot_time_t duration;
+	pos_raw_t distance;
+	__u32 reserved2;
+};
+
+struct mot_stop {
+	channel_mask_t chmask;
+	__u8 when;
+	__u8 reserved[3];
+};
+
+struct mot_event {
+	__u32 channel;
+	__u8 event;
+	__u8 reserved1[3];
+	pos_raw_t position;
+	speed_raw_t speed;
+	mot_time_t timestamp;
+	__u32 input_index;
+	__u32 reserved2;
+};
+
+/* API capabilities interrogation ioctls */
+#define MOT_IOCTL_APIVER		_IO('M', 0x80)
+#define MOT_IOCTL_GET_CAPA		_IOR('M', 0x81, struct mot_capabilities)
+
+/* Basic motion control */
+#define MOT_IOCTL_GET_STATUS		_IOWR('M', 0x82, struct mot_status)
+#define MOT_IOCTL_BASIC_RUN		_IOW('M', 0x83, struct mot_speed_duration)
+#define MOT_IOCTL_BASIC_STOP		_IOW('M', 0x84, __u32)
+
+/* Feedback control */
+#define MOT_IOCTL_CONFIG_INPUT		_IOW('W', 0x85, struct mot_input)
+
+/* Profile control */
+#define MOT_IOCTL_SET_PROFILE		_IOW('M', 0x86, struct mot_profile)
+#define MOT_IOCTL_GET_PROFILE		_IOWR('M', 0x87, struct mot_profile)
+#define MOT_IOCTL_START			_IOW('M', 0x88, struct mot_start)
+#define MOT_IOCTL_STOP			_IOW('M', 0x89, struct mot_stop)
+
+#endif /* _UAPI_LINUX_MOTION_H */
-- 
2.47.2


