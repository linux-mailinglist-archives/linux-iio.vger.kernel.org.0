Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3A41F40
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2019 10:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437258AbfFLIeQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jun 2019 04:34:16 -0400
Received: from chill.innovation.ch ([216.218.245.220]:35570 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbfFLIeM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jun 2019 04:34:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 5ACBE64015B;
        Wed, 12 Jun 2019 01:34:11 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Cjt27pUAIXOI; Wed, 12 Jun 2019 01:34:08 -0700 (PDT)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 172BA640176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1560328448;
        bh=9uOhgMeTBxOebjoRgOqr2pCpdL4W52XxLx1ZGtsJM9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbmJk1MEPGtjfkytlnzthYsZ2diGTzNjjE1rmvVuuocGq7ee592CsuAc1JNfH8XI/
         v5peOT6s4XvQTFjz5UUj5dftGPon1I1TTmIy5RGeaGmKteoxAxb+Om+btnXEf6DobG
         DdVlBhE/kyeoGnm/Ts5oJQQwGWyWaAwxyTz3k9bJM4r95Ll/jtcViLrRht17ixJfGD
         SMa1fEf5TS+RsR8Zw3M2OERsxPRzaLOaEkTL6HGd23K23/Zxadr5l5HiZ16/m23ZGN
         7Pg2v3r1I8M9FCjq9QYd3qhgN8vYnofcFHVOjrZNzNnZQlYwg1kDnmmAIlE5rJPeLl
         SiyxVezTDGoAQ==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] HID: apple-ib-tb: Add driver for the Touch Bar on MacBook Pro's.
Date:   Wed, 12 Jun 2019 01:33:59 -0700
Message-Id: <20190612083400.1015-3-ronald@innovation.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612083400.1015-1-ronald@innovation.ch>
References: <20190612083400.1015-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver enables basic touch bar functionality: enabling it, switching
between modes on FN key press, and dimming and turning the display
off/on when idle/active.

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/hid/Kconfig       |   10 +
 drivers/hid/Makefile      |    1 +
 drivers/hid/apple-ib-tb.c | 1389 +++++++++++++++++++++++++++++++++++++
 3 files changed, 1400 insertions(+)
 create mode 100644 drivers/hid/apple-ib-tb.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 545d3691fc1c..7621c2500d71 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -149,6 +149,16 @@ config HID_APPLE_IBRIDGE
 	  To compile this driver as a module, choose M here: the
 	  module will be called apple-ibridge.
 
+config HID_APPLE_IBRIDGE_TB
+	tristate "Apple iBridge Touch Bar"
+	depends on HID_APPLE_IBRIDGE
+	---help---
+	Say Y here if you want support for the Touch Bar on recent
+	MacBook Pros.
+
+	To compile this driver as a module, choose M here: the
+	module will be called apple-ib-tb.
+
 config HID_APPLEIR
 	tristate "Apple infrared receiver"
 	depends on (USB_HID)
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index a4da5663a541..0c46e5f70db1 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_HID_ALPS)		+= hid-alps.o
 obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
 obj-$(CONFIG_HID_APPLE_IBRIDGE)	+= apple-ibridge.o
+obj-$(CONFIG_HID_APPLE_IBRIDGE_TB)	+= apple-ib-tb.o
 obj-$(CONFIG_HID_APPLEIR)	+= hid-appleir.o
 obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
 obj-$(CONFIG_HID_AUREAL)	+= hid-aureal.o
diff --git a/drivers/hid/apple-ib-tb.c b/drivers/hid/apple-ib-tb.c
new file mode 100644
index 000000000000..6daee80060ce
--- /dev/null
+++ b/drivers/hid/apple-ib-tb.c
@@ -0,0 +1,1389 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Apple Touch Bar Driver
+ *
+ * Copyright (c) 2017-2018 Ronald Tschalär
+ */
+
+/*
+ * Recent MacBookPro models (13,[23] and 14,[23]) have a touch bar, which
+ * is exposed via several USB interfaces. MacOS supports a fancy mode
+ * where arbitrary buttons can be defined; this driver currently only
+ * supports the simple mode that consists of 3 predefined layouts
+ * (escape-only, esc + special keys, and esc + function keys).
+ *
+ * The first USB HID interface supports two reports, an input report that
+ * is used to report the key presses, and an output report which can be
+ * used to set the touch bar "mode": touch bar off (in which case no touches
+ * are reported at all), escape key only, escape + 12 function keys, and
+ * escape + several special keys (including brightness, audio volume,
+ * etc). The second interface supports several, complex reports, most of
+ * which are unknown at this time, but one of which has been determined to
+ * allow for controlling of the touch bar's brightness: off (though touches
+ * are still reported), dimmed, and full brightness. This driver makes
+ * use of these two reports.
+ */
+
+#define dev_fmt(fmt) "tb: " fmt
+
+#include <linux/apple-ibridge.h>
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+
+#define HID_UP_APPLE		0xff120000
+#define HID_USAGE_MODE		(HID_UP_CUSTOM | 0x0004)
+#define HID_USAGE_APPLE_APP	(HID_UP_APPLE  | 0x0001)
+#define HID_USAGE_DISP		(HID_UP_APPLE  | 0x0021)
+#define HID_USAGE_DISP_AUX1	(HID_UP_APPLE  | 0x0020)
+
+#define APPLETB_MAX_TB_KEYS	13	/* ESC, F1-F12 */
+
+#define APPLETB_CMD_MODE_ESC	0
+#define APPLETB_CMD_MODE_FN	1
+#define APPLETB_CMD_MODE_SPCL	2
+#define APPLETB_CMD_MODE_OFF	3
+#define APPLETB_CMD_MODE_UPD	254
+#define APPLETB_CMD_MODE_NONE	255
+
+#define APPLETB_CMD_DISP_ON	1
+#define APPLETB_CMD_DISP_DIM	2
+#define APPLETB_CMD_DISP_OFF	4
+#define APPLETB_CMD_DISP_UPD	254
+#define APPLETB_CMD_DISP_NONE	255
+
+#define APPLETB_FN_MODE_FKEYS	0
+#define APPLETB_FN_MODE_NORM	1
+#define APPLETB_FN_MODE_INV	2
+#define APPLETB_FN_MODE_SPCL	3
+#define APPLETB_FN_MODE_MAX	APPLETB_FN_MODE_SPCL
+
+#define APPLETB_DEVID_KEYBOARD	1
+#define APPLETB_DEVID_TOUCHPAD	2
+
+#define APPLETB_MAX_DIM_TIME	30
+
+static int appletb_tb_def_idle_timeout = 5 * 60;
+module_param_named(idle_timeout, appletb_tb_def_idle_timeout, int, 0444);
+MODULE_PARM_DESC(idle_timeout, "Default touch bar idle timeout:\n"
+			       "    >0 - turn touch bar display off after no keyboard, trackpad, or touch bar input has been received for this many seconds;\n"
+			       "         the display will be turned back on as soon as new input is received\n"
+			       "     0 - turn touch bar display off (input does not turn it on again)\n"
+			       "    -1 - turn touch bar display on (does not turn off automatically)\n"
+			       "    -2 - disable touch bar completely");
+
+static int appletb_tb_def_dim_timeout = -2;
+module_param_named(dim_timeout, appletb_tb_def_dim_timeout, int, 0444);
+MODULE_PARM_DESC(dim_timeout, "Default touch bar dim timeout:\n"
+			      "    >0 - dim touch bar display after no keyboard, trackpad, or touch bar input has been received for this many seconds\n"
+			      "         the display will be returned to full brightness as soon as new input is received\n"
+			      "     0 - dim touch bar display (input does not return it to full brightness)\n"
+			      "    -1 - disable timeout (touch bar never dimmed)\n"
+			      "    [-2] - calculate timeout based on idle-timeout");
+
+static int appletb_tb_def_fn_mode = APPLETB_FN_MODE_NORM;
+module_param_named(fnmode, appletb_tb_def_fn_mode, int, 0444);
+MODULE_PARM_DESC(fnmode, "Default Fn key mode:\n"
+			 "    0 - function-keys only\n"
+			 "    [1] - fn key switches from special to function-keys\n"
+			 "    2 - inverse of 1\n"
+			 "    3 - special keys only");
+
+static ssize_t idle_timeout_show(struct device *dev,
+				 struct device_attribute *attr, char *buf);
+static ssize_t idle_timeout_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size);
+static DEVICE_ATTR_RW(idle_timeout);
+
+static ssize_t dim_timeout_show(struct device *dev,
+				struct device_attribute *attr, char *buf);
+static ssize_t dim_timeout_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size);
+static DEVICE_ATTR_RW(dim_timeout);
+
+static ssize_t fnmode_show(struct device *dev, struct device_attribute *attr,
+			   char *buf);
+static ssize_t fnmode_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t size);
+static DEVICE_ATTR_RW(fnmode);
+
+static struct attribute *appletb_attrs[] = {
+	&dev_attr_idle_timeout.attr,
+	&dev_attr_dim_timeout.attr,
+	&dev_attr_fnmode.attr,
+	NULL,
+};
+
+static const struct attribute_group appletb_attr_group = {
+	.attrs = appletb_attrs,
+};
+
+struct appletb_device {
+	bool			active;
+	struct device		*log_dev;
+
+	struct hid_field	*mode_field;
+	struct hid_field	*disp_field;
+	struct hid_field	*disp_field_aux1;
+	struct appletb_iface_info {
+		struct hid_device	*hdev;
+		struct usb_interface	*usb_iface;
+		bool			suspended;
+	}			mode_iface, disp_iface;
+
+	struct input_handler	inp_handler;
+	struct input_handle	kbd_handle;
+	struct input_handle	tpd_handle;
+
+	bool			last_tb_keys_pressed[APPLETB_MAX_TB_KEYS];
+	bool			last_tb_keys_translated[APPLETB_MAX_TB_KEYS];
+	bool			last_fn_pressed;
+
+	ktime_t			last_event_time;
+
+	unsigned char		cur_tb_mode;
+	unsigned char		pnd_tb_mode;
+	unsigned char		cur_tb_disp;
+	unsigned char		pnd_tb_disp;
+	bool			tb_autopm_off;
+	bool			restore_autopm;
+	struct delayed_work	tb_work;
+	/* protects most of the above */
+	spinlock_t		tb_lock;
+
+	int			dim_timeout;
+	int			idle_timeout;
+	bool			dim_to_is_calc;
+	int			fn_mode;
+};
+
+struct appletb_key_translation {
+	u16 from;
+	u16 to;
+};
+
+static const struct appletb_key_translation appletb_fn_codes[] = {
+	{ KEY_F1,  KEY_BRIGHTNESSDOWN },
+	{ KEY_F2,  KEY_BRIGHTNESSUP },
+	{ KEY_F3,  KEY_SCALE },		/* not used */
+	{ KEY_F4,  KEY_DASHBOARD },	/* not used */
+	{ KEY_F5,  KEY_KBDILLUMDOWN },
+	{ KEY_F6,  KEY_KBDILLUMUP },
+	{ KEY_F7,  KEY_PREVIOUSSONG },
+	{ KEY_F8,  KEY_PLAYPAUSE },
+	{ KEY_F9,  KEY_NEXTSONG },
+	{ KEY_F10, KEY_MUTE },
+	{ KEY_F11, KEY_VOLUMEDOWN },
+	{ KEY_F12, KEY_VOLUMEUP },
+};
+
+static struct appletb_device *appletb_dev;
+
+static int appletb_send_usb_ctrl(struct appletb_iface_info *iface_info,
+				 __u8 requesttype, struct hid_report *report,
+				 void *data, __u16 size)
+{
+	struct usb_device *dev = interface_to_usbdev(iface_info->usb_iface);
+	u8 ifnum = iface_info->usb_iface->cur_altsetting->desc.bInterfaceNumber;
+	int tries = 0;
+	int rc;
+
+	do {
+		rc = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+				     HID_REQ_SET_REPORT, requesttype,
+				     (report->type + 1) << 8 | report->id,
+				     ifnum, data, size, 2000);
+		if (rc != -EPIPE)
+			break;
+
+		usleep_range(1000 << tries, 3000 << tries);
+	} while (++tries < 5);
+
+	return (rc > 0) ? 0 : rc;
+}
+
+static bool appletb_disable_autopm(struct hid_device *hdev)
+{
+	int rc;
+
+	rc = hid_hw_power(hdev, PM_HINT_FULLON);
+
+	if (rc == 0)
+		return true;
+
+	hid_err(hdev,
+		"Failed to disable auto-pm on touch bar device (%d)\n", rc);
+	return false;
+}
+
+/*
+ * While the mode functionality is listed as a valid hid report in the usb
+ * interface descriptor, it's not sent that way. Instead it's sent with
+ * different request-type and without a leading report-id in the data. Hence
+ * we need to send it as a custom usb control message rather via any of the
+ * standard hid_hw_*request() functions.
+ */
+static int appletb_set_tb_mode(struct appletb_device *tb_dev,
+			       unsigned char mode)
+{
+	void *buf;
+	bool autopm_off = false;
+	int rc;
+
+	if (!tb_dev->mode_iface.hdev)
+		return -ENOTCONN;
+
+	buf = kmemdup(&mode, 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	autopm_off = appletb_disable_autopm(tb_dev->mode_iface.hdev);
+
+	rc = appletb_send_usb_ctrl(&tb_dev->mode_iface,
+				   USB_DIR_OUT | USB_TYPE_VENDOR |
+							USB_RECIP_DEVICE,
+				   tb_dev->mode_field->report, buf, 1);
+	if (rc < 0)
+		dev_err(tb_dev->log_dev,
+			"Failed to set touch bar mode to %u (%d)\n", mode, rc);
+
+	if (autopm_off)
+		hid_hw_power(tb_dev->mode_iface.hdev, PM_HINT_NORMAL);
+
+	kfree(buf);
+
+	return rc;
+}
+
+/*
+ * We don't use hid_hw_request() because that doesn't allow us to get the
+ * returned status from the usb-control request; we also don't use
+ * hid_hw_raw_request() because would mean duplicating the retry-on-EPIPE
+ * in our appletb_send_usb_ctrl().
+ */
+static int appletb_send_hid_report(struct appletb_iface_info *iface_info,
+				   struct hid_report *report)
+{
+	unsigned char *buf;
+	int rc;
+
+	buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	hid_output_report(report, buf);
+
+	rc = appletb_send_usb_ctrl(iface_info,
+				   USB_DIR_OUT | USB_TYPE_CLASS |
+							USB_RECIP_INTERFACE,
+				   report, buf, hid_report_len(report));
+
+	kfree(buf);
+
+	return rc;
+}
+
+static int appletb_set_tb_disp(struct appletb_device *tb_dev,
+			       unsigned char disp)
+{
+	struct hid_report *report;
+	int rc;
+
+	if (!tb_dev->disp_iface.hdev)
+		return -ENOTCONN;
+
+	report = tb_dev->disp_field->report;
+
+	rc = hid_set_field(tb_dev->disp_field_aux1, 0, 1);
+	if (!rc)
+		rc = hid_set_field(tb_dev->disp_field, 0, disp);
+	if (rc) {
+		dev_err(tb_dev->log_dev,
+			"Failed to set display report fields (%d)\n", rc);
+		return rc;
+	}
+
+	/*
+	 * Keep the USB interface powered on while the touch bar display is on
+	 * for better responsiveness.
+	 */
+	if (disp != APPLETB_CMD_DISP_OFF && !tb_dev->tb_autopm_off)
+		tb_dev->tb_autopm_off =
+			appletb_disable_autopm(report->device);
+
+	rc = appletb_send_hid_report(&tb_dev->disp_iface, report);
+
+	if (rc < 0)
+		dev_err(tb_dev->log_dev,
+			"Failed to set touch bar display to %u (%d)\n", disp,
+			rc);
+
+	if (disp == APPLETB_CMD_DISP_OFF && tb_dev->tb_autopm_off) {
+		hid_hw_power(tb_dev->disp_iface.hdev, PM_HINT_NORMAL);
+		tb_dev->tb_autopm_off = false;
+	}
+
+	return rc;
+}
+
+static bool appletb_any_tb_key_pressed(struct appletb_device *tb_dev)
+{
+	return !!memchr_inv(tb_dev->last_tb_keys_pressed, 0,
+			    sizeof(tb_dev->last_tb_keys_pressed));
+}
+
+static void appletb_schedule_tb_update(struct appletb_device *tb_dev, s64 secs)
+{
+	schedule_delayed_work(&tb_dev->tb_work, msecs_to_jiffies(secs * 1000));
+}
+
+static void appletb_set_tb_worker(struct work_struct *work)
+{
+	struct appletb_device *tb_dev =
+		container_of(work, struct appletb_device, tb_work.work);
+	s64 time_left = 0, min_timeout, time_to_off;
+	unsigned char pending_mode;
+	unsigned char pending_disp;
+	unsigned char current_disp;
+	bool restore_autopm;
+	bool any_tb_key_pressed, need_reschedule;
+	int rc1 = 1, rc2 = 1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	/* handle explicit mode-change request */
+	pending_mode = tb_dev->pnd_tb_mode;
+	pending_disp = tb_dev->pnd_tb_disp;
+	restore_autopm = tb_dev->restore_autopm;
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+
+	if (pending_mode != APPLETB_CMD_MODE_NONE)
+		rc1 = appletb_set_tb_mode(tb_dev, pending_mode);
+	if (pending_mode != APPLETB_CMD_MODE_NONE &&
+	    pending_disp != APPLETB_CMD_DISP_NONE)
+		msleep(25);
+	if (pending_disp != APPLETB_CMD_DISP_NONE)
+		rc2 = appletb_set_tb_disp(tb_dev, pending_disp);
+
+	if (restore_autopm && tb_dev->tb_autopm_off)
+		appletb_disable_autopm(tb_dev->disp_field->report->device);
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	need_reschedule = false;
+
+	if (rc1 == 0) {
+		tb_dev->cur_tb_mode = pending_mode;
+
+		if (tb_dev->pnd_tb_mode == pending_mode)
+			tb_dev->pnd_tb_mode = APPLETB_CMD_MODE_NONE;
+		else
+			need_reschedule = true;
+	}
+
+	if (rc2 == 0) {
+		tb_dev->cur_tb_disp = pending_disp;
+
+		if (tb_dev->pnd_tb_disp == pending_disp)
+			tb_dev->pnd_tb_disp = APPLETB_CMD_DISP_NONE;
+		else
+			need_reschedule = true;
+	}
+	current_disp = tb_dev->cur_tb_disp;
+
+	tb_dev->restore_autopm = false;
+
+	/* calculate time left to next timeout */
+	if (tb_dev->idle_timeout == -2 || tb_dev->idle_timeout == 0)
+		min_timeout = -1;
+	else if (tb_dev->idle_timeout == -1)
+		min_timeout = tb_dev->dim_timeout;
+	else if (tb_dev->dim_timeout <= 0)
+		min_timeout = tb_dev->idle_timeout;
+	else
+		min_timeout = min(tb_dev->dim_timeout, tb_dev->idle_timeout);
+
+	if (min_timeout > 0) {
+		s64 idle_time =
+			(ktime_ms_delta(ktime_get(), tb_dev->last_event_time) +
+			 500) / 1000;
+
+		time_left = max(min_timeout - idle_time, 0LL);
+		if (tb_dev->idle_timeout <= 0)
+			time_to_off = -1;
+		else if (idle_time >= tb_dev->idle_timeout)
+			time_to_off = 0;
+		else
+			time_to_off = tb_dev->idle_timeout - idle_time;
+	} else {
+		/* not used - just to appease the compiler */
+		time_to_off = 0;
+	}
+
+	any_tb_key_pressed = appletb_any_tb_key_pressed(tb_dev);
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+
+	dev_dbg(tb_dev->log_dev, "timeout calc: idle_timeout=%d dim_timeout=%d min_timeout=%lld time_left=%lld need_reschedule=%d any_tb_key_pressed=%d\n",
+		tb_dev->idle_timeout, tb_dev->dim_timeout, min_timeout,
+		time_left, need_reschedule, any_tb_key_pressed);
+
+	/* a new command arrived while we were busy - handle it */
+	if (need_reschedule) {
+		appletb_schedule_tb_update(tb_dev, 0);
+		return;
+	}
+
+	/* if no idle/dim timeout, we're done */
+	if (min_timeout <= 0)
+		return;
+
+	/* manage idle/dim timeout */
+	if (time_left > 0) {
+		/* we fired too soon or had a mode-change - re-schedule */
+		appletb_schedule_tb_update(tb_dev, time_left);
+	} else if (any_tb_key_pressed) {
+		/* keys are still pressed - re-schedule */
+		appletb_schedule_tb_update(tb_dev, min_timeout);
+	} else {
+		/* dim or idle timeout reached */
+		int next_disp = (time_to_off == 0) ? APPLETB_CMD_DISP_OFF :
+						     APPLETB_CMD_DISP_DIM;
+		if (next_disp != current_disp &&
+		    appletb_set_tb_disp(tb_dev, next_disp) == 0) {
+			spin_lock_irqsave(&tb_dev->tb_lock, flags);
+			tb_dev->cur_tb_disp = next_disp;
+			spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+		}
+
+		if (time_to_off > 0)
+			appletb_schedule_tb_update(tb_dev, time_to_off);
+	}
+}
+
+static u16 appletb_fn_to_special(u16 code)
+{
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(appletb_fn_codes); idx++) {
+		if (appletb_fn_codes[idx].from == code)
+			return appletb_fn_codes[idx].to;
+	}
+
+	return 0;
+}
+
+static unsigned char appletb_get_cur_tb_mode(struct appletb_device *tb_dev)
+{
+	return tb_dev->pnd_tb_mode != APPLETB_CMD_MODE_NONE ?
+				tb_dev->pnd_tb_mode : tb_dev->cur_tb_mode;
+}
+
+static unsigned char appletb_get_cur_tb_disp(struct appletb_device *tb_dev)
+{
+	return tb_dev->pnd_tb_disp != APPLETB_CMD_DISP_NONE ?
+				tb_dev->pnd_tb_disp : tb_dev->cur_tb_disp;
+}
+
+static unsigned char appletb_get_fn_tb_mode(struct appletb_device *tb_dev)
+{
+	switch (tb_dev->fn_mode) {
+	case APPLETB_FN_MODE_FKEYS:
+		return APPLETB_CMD_MODE_FN;
+
+	case APPLETB_FN_MODE_SPCL:
+		return APPLETB_CMD_MODE_SPCL;
+
+	case APPLETB_FN_MODE_INV:
+		return (tb_dev->last_fn_pressed) ? APPLETB_CMD_MODE_SPCL :
+						   APPLETB_CMD_MODE_FN;
+
+	case APPLETB_FN_MODE_NORM:
+	default:
+		return (tb_dev->last_fn_pressed) ? APPLETB_CMD_MODE_FN :
+						   APPLETB_CMD_MODE_SPCL;
+	}
+}
+
+/*
+ * Switch touch bar mode and display when mode or display not the desired ones.
+ */
+static void appletb_update_touchbar_no_lock(struct appletb_device *tb_dev,
+					    bool force)
+{
+	unsigned char want_mode;
+	unsigned char want_disp;
+	bool need_update = false;
+
+	/*
+	 * Calculate the new modes:
+	 *   idle_timeout:
+	 *     -2  mode/disp off
+	 *     -1  mode on, disp on/dim
+	 *      0  mode on, disp off
+	 *     >0  mode on, disp off after idle_timeout seconds
+	 *   dim_timeout (only valid if idle_timeout > 0 || idle_timeout == -1):
+	 *     -1  disp never dimmed
+	 *      0  disp always dimmed
+	 *     >0  disp dim after dim_timeout seconds
+	 */
+	if (tb_dev->idle_timeout == -2) {
+		want_mode = APPLETB_CMD_MODE_OFF;
+		want_disp = APPLETB_CMD_DISP_OFF;
+	} else {
+		want_mode = appletb_get_fn_tb_mode(tb_dev);
+		want_disp = tb_dev->idle_timeout ==  0 ? APPLETB_CMD_DISP_OFF :
+			    tb_dev->dim_timeout  ==  0 ? APPLETB_CMD_DISP_DIM :
+							 APPLETB_CMD_DISP_ON;
+	}
+
+	/*
+	 * See if we need to update the touch bar, taking into account that we
+	 * generally don't want to switch modes while a touch bar key is
+	 * pressed.
+	 */
+	if (appletb_get_cur_tb_mode(tb_dev) != want_mode &&
+	    !appletb_any_tb_key_pressed(tb_dev)) {
+		tb_dev->pnd_tb_mode = want_mode;
+		need_update = true;
+	}
+
+	if (appletb_get_cur_tb_disp(tb_dev) != want_disp &&
+	    (!appletb_any_tb_key_pressed(tb_dev) ||
+	     want_disp != APPLETB_CMD_DISP_OFF)) {
+		tb_dev->pnd_tb_disp = want_disp;
+		need_update = true;
+	}
+
+	if (force)
+		need_update = true;
+
+	/* schedule the update if desired */
+	dev_dbg_ratelimited(tb_dev->log_dev,
+			    "update: need_update=%d, want_mode=%d, cur-mode=%d, want_disp=%d, cur-disp=%d\n",
+			    need_update, want_mode, tb_dev->cur_tb_mode,
+			    want_disp, tb_dev->cur_tb_disp);
+
+	if (need_update) {
+		cancel_delayed_work(&tb_dev->tb_work);
+		appletb_schedule_tb_update(tb_dev, 0);
+	}
+}
+
+static void appletb_update_touchbar(struct appletb_device *tb_dev, bool force)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	if (tb_dev->active)
+		appletb_update_touchbar_no_lock(tb_dev, force);
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+}
+
+static void appletb_set_idle_timeout(struct appletb_device *tb_dev, int new)
+{
+	tb_dev->idle_timeout = new;
+
+	if (tb_dev->dim_to_is_calc && tb_dev->idle_timeout > 0)
+		tb_dev->dim_timeout = new - min(APPLETB_MAX_DIM_TIME, new / 3);
+	else if (tb_dev->dim_to_is_calc)
+		tb_dev->dim_timeout = -1;
+}
+
+static ssize_t idle_timeout_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct appletb_device *tb_dev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", tb_dev->idle_timeout);
+}
+
+static ssize_t idle_timeout_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct appletb_device *tb_dev = dev_get_drvdata(dev);
+	long new;
+	int rc;
+
+	rc = kstrtol(buf, 0, &new);
+	if (rc || new > INT_MAX || new < -2)
+		return -EINVAL;
+
+	appletb_set_idle_timeout(tb_dev, new);
+	appletb_update_touchbar(tb_dev, true);
+
+	return size;
+}
+
+static void appletb_set_dim_timeout(struct appletb_device *tb_dev, int new)
+{
+	if (new == -2) {
+		tb_dev->dim_to_is_calc = true;
+		appletb_set_idle_timeout(tb_dev, tb_dev->idle_timeout);
+	} else {
+		tb_dev->dim_to_is_calc = false;
+		tb_dev->dim_timeout = new;
+	}
+}
+
+static ssize_t dim_timeout_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct appletb_device *tb_dev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			tb_dev->dim_to_is_calc ? -2 : tb_dev->dim_timeout);
+}
+
+static ssize_t dim_timeout_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	struct appletb_device *tb_dev = dev_get_drvdata(dev);
+	long new;
+	int rc;
+
+	rc = kstrtol(buf, 0, &new);
+	if (rc || new > INT_MAX || new < -2)
+		return -EINVAL;
+
+	appletb_set_dim_timeout(tb_dev, new);
+	appletb_update_touchbar(tb_dev, true);
+
+	return size;
+}
+
+static ssize_t fnmode_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct appletb_device *tb_dev = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", tb_dev->fn_mode);
+}
+
+static ssize_t fnmode_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t size)
+{
+	struct appletb_device *tb_dev = dev_get_drvdata(dev);
+	long new;
+	int rc;
+
+	rc = kstrtol(buf, 0, &new);
+	if (rc || new > APPLETB_FN_MODE_MAX || new < 0)
+		return -EINVAL;
+
+	tb_dev->fn_mode = new;
+	appletb_update_touchbar(tb_dev, false);
+
+	return size;
+}
+
+static int appletb_tb_key_to_slot(unsigned int code)
+{
+	switch (code) {
+	case KEY_ESC:
+		return 0;
+	case KEY_F1:
+	case KEY_F2:
+	case KEY_F3:
+	case KEY_F4:
+	case KEY_F5:
+	case KEY_F6:
+	case KEY_F7:
+	case KEY_F8:
+	case KEY_F9:
+	case KEY_F10:
+		return code - KEY_F1 + 1;
+	case KEY_F11:
+	case KEY_F12:
+		return code - KEY_F11 + 11;
+	default:
+		return -1;
+	}
+}
+
+static int appletb_hid_event(struct hid_device *hdev, struct hid_field *field,
+			     struct hid_usage *usage, __s32 value)
+{
+	struct appletb_device *tb_dev = hid_get_drvdata(hdev);
+	unsigned int new_code = 0;
+	unsigned long flags;
+	bool send_dummy = false;
+	bool send_trnsl = false;
+	int slot;
+	int rc = 0;
+
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_KEYBOARD ||
+	    usage->type != EV_KEY)
+		return 0;
+
+	/*
+	 * Skip non-touch-bar keys.
+	 *
+	 * Either the touch bar itself or usbhid generate a slew of key-down
+	 * events for all the meta keys. None of which we're at all interested
+	 * in.
+	 */
+	slot = appletb_tb_key_to_slot(usage->code);
+	if (slot < 0)
+		return 0;
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	if (!tb_dev->active) {
+		spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+		return 0;
+	}
+
+	new_code = appletb_fn_to_special(usage->code);
+
+	if (value != 2)
+		tb_dev->last_tb_keys_pressed[slot] = value;
+
+	tb_dev->last_event_time = ktime_get();
+
+	appletb_update_touchbar_no_lock(tb_dev, false);
+
+	/*
+	 * We want to suppress touch bar keys while the touch bar is off, but
+	 * we do want to wake up the screen if it's asleep, so generate a dummy
+	 * event in that case.
+	 */
+	if (tb_dev->cur_tb_mode == APPLETB_CMD_MODE_OFF ||
+	    tb_dev->cur_tb_disp == APPLETB_CMD_DISP_OFF) {
+		send_dummy = true;
+		rc = 1;
+	/* translate special keys */
+	} else if (new_code &&
+		   ((value > 0 &&
+		     appletb_get_cur_tb_mode(tb_dev) == APPLETB_CMD_MODE_SPCL)
+		    ||
+		    (value == 0 && tb_dev->last_tb_keys_translated[slot]))) {
+		tb_dev->last_tb_keys_translated[slot] = true;
+		send_trnsl = true;
+		rc = 1;
+	/* everything else handled normally */
+	} else {
+		tb_dev->last_tb_keys_translated[slot] = false;
+	}
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+
+	/*
+	 * Need to send these input events outside of the lock, as otherwise
+	 * we can run into the following deadlock:
+	 *            Task 1                         Task 2
+	 *     appletb_hid_event()            input_event()
+	 *       acquire tb_lock                acquire dev->event_lock
+	 *       input_event()                  appletb_inp_event()
+	 *         acquire dev->event_lock        acquire tb_lock
+	 */
+	if (send_dummy) {
+		input_event(field->hidinput->input, EV_KEY, KEY_UNKNOWN, 1);
+		input_event(field->hidinput->input, EV_KEY, KEY_UNKNOWN, 0);
+	} else if (send_trnsl) {
+		input_event(field->hidinput->input, usage->type, new_code,
+			    value);
+	}
+
+	return rc;
+}
+
+static void appletb_inp_event(struct input_handle *handle, unsigned int type,
+			      unsigned int code, int value)
+{
+	struct appletb_device *tb_dev = handle->private;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	if (!tb_dev->active) {
+		spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+		return;
+	}
+
+	if (type == EV_KEY && code == KEY_FN && value != 2)
+		tb_dev->last_fn_pressed = value;
+
+	tb_dev->last_event_time = ktime_get();
+
+	appletb_update_touchbar_no_lock(tb_dev, false);
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+}
+
+/* Find and save the usb-device associated with the touch bar input device */
+static struct usb_interface *appletb_get_usb_iface(struct hid_device *hdev)
+{
+	struct device *dev = &hdev->dev;
+
+	/* iBridge virt-hid */
+	if (!dev->bus || strcmp(dev->bus->name, "hid") != 0)
+		return NULL;
+
+	/* real hid */
+	dev = dev->parent;
+	if (!dev || !dev->bus || strcmp(dev->bus->name, "hid") != 0)
+		return NULL;
+
+	/* usb dev */
+	dev = dev->parent;
+	if (!dev || !dev->bus || strcmp(dev->bus->name, "usb") != 0)
+		return NULL;
+
+	return to_usb_interface(dev);
+}
+
+static int appletb_inp_connect(struct input_handler *handler,
+			       struct input_dev *dev,
+			       const struct input_device_id *id)
+{
+	struct appletb_device *tb_dev = handler->private;
+	struct input_handle *handle;
+	int rc;
+
+	if (id->driver_info == APPLETB_DEVID_KEYBOARD) {
+		handle = &tb_dev->kbd_handle;
+		handle->name = "tbkbd";
+	} else if (id->driver_info == APPLETB_DEVID_TOUCHPAD) {
+		handle = &tb_dev->tpd_handle;
+		handle->name = "tbtpad";
+	} else {
+		dev_err(tb_dev->log_dev, "Unknown device id (%lu)\n",
+			id->driver_info);
+		return -ENOENT;
+	}
+
+	if (handle->dev) {
+		dev_err(tb_dev->log_dev,
+			"Duplicate connect to %s input device\n", handle->name);
+		return -EEXIST;
+	}
+
+	handle->open = 0;
+	handle->dev = input_get_device(dev);
+	handle->handler = handler;
+	handle->private = tb_dev;
+
+	rc = input_register_handle(handle);
+	if (rc)
+		goto err_free_dev;
+
+	rc = input_open_device(handle);
+	if (rc)
+		goto err_unregister_handle;
+
+	dev_dbg(tb_dev->log_dev, "Connected to %s input device\n",
+		handle == &tb_dev->kbd_handle ? "keyboard" : "touchpad");
+
+	return 0;
+
+ err_unregister_handle:
+	input_unregister_handle(handle);
+ err_free_dev:
+	input_put_device(handle->dev);
+	handle->dev = NULL;
+	return rc;
+}
+
+static void appletb_inp_disconnect(struct input_handle *handle)
+{
+	struct appletb_device *tb_dev = handle->private;
+
+	input_close_device(handle);
+	input_unregister_handle(handle);
+
+	dev_dbg(tb_dev->log_dev, "Disconnected from %s input device\n",
+		handle == &tb_dev->kbd_handle ? "keyboard" : "touchpad");
+
+	input_put_device(handle->dev);
+	handle->dev = NULL;
+}
+
+static int appletb_input_configured(struct hid_device *hdev,
+				    struct hid_input *hidinput)
+{
+	int idx;
+	struct input_dev *input = hidinput->input;
+
+	/*
+	 * Clear various input capabilities that are blindly set by the hid
+	 * driver (usbkbd.c)
+	 */
+	memset(input->evbit, 0, sizeof(input->evbit));
+	memset(input->keybit, 0, sizeof(input->keybit));
+	memset(input->ledbit, 0, sizeof(input->ledbit));
+
+	/* set our actual capabilities */
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(EV_REP, input->evbit);
+	__set_bit(EV_MSC, input->evbit);  /* hid-input generates MSC_SCAN */
+
+	for (idx = 0; idx < ARRAY_SIZE(appletb_fn_codes); idx++) {
+		input_set_capability(input, EV_KEY, appletb_fn_codes[idx].from);
+		input_set_capability(input, EV_KEY, appletb_fn_codes[idx].to);
+	}
+
+	input_set_capability(input, EV_KEY, KEY_ESC);
+	input_set_capability(input, EV_KEY, KEY_UNKNOWN);
+
+	return 0;
+}
+
+static int appletb_extract_report_info(struct appletb_device *tb_dev,
+				       struct hid_device *hdev)
+{
+	struct appletb_iface_info *iface_info;
+	struct usb_interface *usb_iface;
+	struct hid_field *field;
+
+	field = appleib_find_hid_field(hdev, HID_GD_KEYBOARD, HID_USAGE_MODE);
+	if (field) {
+		iface_info = &tb_dev->mode_iface;
+		tb_dev->mode_field = field;
+	} else {
+		field = appleib_find_hid_field(hdev, HID_USAGE_APPLE_APP,
+					       HID_USAGE_DISP);
+		if (!field)
+			return 0;
+
+		iface_info = &tb_dev->disp_iface;
+		tb_dev->disp_field = field;
+		tb_dev->disp_field_aux1 =
+			appleib_find_hid_field(hdev, HID_USAGE_APPLE_APP,
+					       HID_USAGE_DISP_AUX1);
+
+		if (!tb_dev->disp_field_aux1 ||
+		    tb_dev->disp_field_aux1->report !=
+						tb_dev->disp_field->report) {
+			dev_err(tb_dev->log_dev,
+				"Unexpected report structure for report %u in device %s\n",
+				tb_dev->disp_field->report->id,
+				dev_name(&hdev->dev));
+			return -ENODEV;
+		}
+	}
+
+	usb_iface = appletb_get_usb_iface(hdev);
+	if (!usb_iface) {
+		dev_err(tb_dev->log_dev,
+			"Failed to find usb interface for hid device %s\n",
+			dev_name(&hdev->dev));
+		return -ENODEV;
+	}
+
+	iface_info->hdev = hdev;
+	iface_info->usb_iface = usb_get_intf(usb_iface);
+	iface_info->suspended = false;
+
+	return 1;
+}
+
+static struct appletb_iface_info *
+appletb_get_iface_info(struct appletb_device *tb_dev, struct hid_device *hdev)
+{
+	if (hdev == tb_dev->mode_iface.hdev)
+		return &tb_dev->mode_iface;
+	if (hdev == tb_dev->disp_iface.hdev)
+		return &tb_dev->disp_iface;
+	return NULL;
+}
+
+static bool appletb_test_and_mark_active(struct appletb_device *tb_dev)
+{
+	unsigned long flags;
+	bool activated = false;
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	if (tb_dev->mode_iface.hdev && tb_dev->disp_iface.hdev &&
+	    !tb_dev->active) {
+		tb_dev->active = true;
+		activated = true;
+	}
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+
+	return activated;
+}
+
+static bool appletb_test_and_mark_inactive(struct appletb_device *tb_dev,
+					   struct hid_device *hdev)
+{
+	unsigned long flags;
+	bool deactivated = false;
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	if (tb_dev->mode_iface.hdev && tb_dev->disp_iface.hdev &&
+	    tb_dev->active &&
+	    (hdev == tb_dev->mode_iface.hdev ||
+	     hdev == tb_dev->disp_iface.hdev)) {
+		tb_dev->active = false;
+		deactivated = true;
+	}
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+
+	return deactivated;
+}
+
+static const struct input_device_id appletb_input_devices[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_BUS |
+			INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.bustype = BUS_SPI,
+		.keybit = { [BIT_WORD(KEY_FN)] = BIT_MASK(KEY_FN) },
+		.driver_info = APPLETB_DEVID_KEYBOARD,
+	},			/* Builtin keyboard device */
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_BUS |
+			INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.bustype = BUS_SPI,
+		.keybit = { [BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH) },
+		.driver_info = APPLETB_DEVID_TOUCHPAD,
+	},			/* Builtin touchpad device */
+	{ },			/* Terminating zero entry */
+};
+
+static int appletb_probe(struct hid_device *hdev,
+			 const struct hid_device_id *id)
+{
+	struct appletb_device *tb_dev = appletb_dev;
+	struct appletb_iface_info *iface_info;
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	if (!tb_dev->log_dev)
+		tb_dev->log_dev = &hdev->dev;
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+
+	hid_set_drvdata(hdev, tb_dev);
+
+	/* initialize the report info */
+	rc = hid_parse(hdev);
+	if (rc) {
+		dev_err(tb_dev->log_dev, "als: hid parse failed (%d)\n", rc);
+		goto error;
+	}
+
+	rc = appletb_extract_report_info(tb_dev, hdev);
+	if (rc < 0)
+		goto error;
+
+	rc = hid_hw_start(hdev, HID_CONNECT_DRIVER | HID_CONNECT_HIDINPUT);
+	if (rc) {
+		dev_err(tb_dev->log_dev, "hw start failed (%d)\n", rc);
+		goto clear_iface_info;
+	}
+
+	rc = hid_hw_open(hdev);
+	if (rc) {
+		dev_err(tb_dev->log_dev, "hw open failed (%d)\n", rc);
+		goto stop_hid;
+	}
+
+	/* do setup if we have both interfaces */
+	if (appletb_test_and_mark_active(tb_dev)) {
+		/* initialize the touch bar */
+		if (appletb_tb_def_fn_mode >= 0 &&
+		    appletb_tb_def_fn_mode <= APPLETB_FN_MODE_MAX)
+			tb_dev->fn_mode = appletb_tb_def_fn_mode;
+		else
+			tb_dev->fn_mode = APPLETB_FN_MODE_NORM;
+		appletb_set_idle_timeout(tb_dev, appletb_tb_def_idle_timeout);
+		appletb_set_dim_timeout(tb_dev, appletb_tb_def_dim_timeout);
+		tb_dev->last_event_time = ktime_get();
+
+		tb_dev->pnd_tb_mode = APPLETB_CMD_MODE_UPD;
+		tb_dev->pnd_tb_disp = APPLETB_CMD_DISP_UPD;
+
+		appletb_update_touchbar(tb_dev, false);
+
+		/* set up the input handler */
+		tb_dev->inp_handler.event = appletb_inp_event;
+		tb_dev->inp_handler.connect = appletb_inp_connect;
+		tb_dev->inp_handler.disconnect = appletb_inp_disconnect;
+		tb_dev->inp_handler.name = "appletb";
+		tb_dev->inp_handler.id_table = appletb_input_devices;
+		tb_dev->inp_handler.private = tb_dev;
+
+		rc = input_register_handler(&tb_dev->inp_handler);
+		if (rc) {
+			dev_err(tb_dev->log_dev,
+				"Unable to register keyboard handler (%d)\n",
+				rc);
+			goto mark_inactive;
+		}
+
+		/* initialize sysfs attributes */
+		rc = sysfs_create_group(&tb_dev->mode_iface.hdev->dev.kobj,
+					&appletb_attr_group);
+		if (rc) {
+			dev_err(tb_dev->log_dev,
+				"Failed to create sysfs attributes (%d)\n", rc);
+			goto unreg_handler;
+		}
+
+		dev_dbg(tb_dev->log_dev, "Touchbar activated\n");
+	}
+
+	return 0;
+
+unreg_handler:
+	input_unregister_handler(&tb_dev->inp_handler);
+mark_inactive:
+	appletb_test_and_mark_inactive(tb_dev, hdev);
+	cancel_delayed_work_sync(&tb_dev->tb_work);
+	hid_hw_close(hdev);
+stop_hid:
+	hid_hw_stop(hdev);
+clear_iface_info:
+	iface_info = appletb_get_iface_info(tb_dev, hdev);
+	if (iface_info) {
+		usb_put_intf(iface_info->usb_iface);
+		iface_info->usb_iface = NULL;
+		iface_info->hdev = NULL;
+	}
+error:
+	return rc;
+}
+
+static void appletb_remove(struct hid_device *hdev)
+{
+	struct appletb_device *tb_dev = hid_get_drvdata(hdev);
+	struct appletb_iface_info *iface_info;
+	unsigned long flags;
+
+	if (appletb_test_and_mark_inactive(tb_dev, hdev)) {
+		sysfs_remove_group(&tb_dev->mode_iface.hdev->dev.kobj,
+				   &appletb_attr_group);
+
+		input_unregister_handler(&tb_dev->inp_handler);
+
+		cancel_delayed_work_sync(&tb_dev->tb_work);
+		appletb_set_tb_mode(tb_dev, APPLETB_CMD_MODE_OFF);
+		appletb_set_tb_disp(tb_dev, APPLETB_CMD_DISP_ON);
+
+		if (tb_dev->tb_autopm_off)
+			hid_hw_power(tb_dev->disp_iface.hdev, PM_HINT_NORMAL);
+
+		dev_info(tb_dev->log_dev, "Touchbar deactivated\n");
+	}
+
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+
+	iface_info = appletb_get_iface_info(tb_dev, hdev);
+	if (iface_info) {
+		usb_put_intf(iface_info->usb_iface);
+		iface_info->usb_iface = NULL;
+		iface_info->hdev = NULL;
+	}
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	if (tb_dev->log_dev == &hdev->dev) {
+		if (tb_dev->mode_iface.hdev)
+			tb_dev->log_dev = &tb_dev->mode_iface.hdev->dev;
+		else if (tb_dev->disp_iface.hdev)
+			tb_dev->log_dev = &tb_dev->disp_iface.hdev->dev;
+		else
+			tb_dev->log_dev = NULL;
+	}
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+}
+
+#ifdef CONFIG_PM
+static int appletb_suspend(struct hid_device *hdev, pm_message_t message)
+{
+	struct appletb_device *tb_dev = hid_get_drvdata(hdev);
+	struct appletb_iface_info *iface_info;
+	unsigned long flags;
+	bool all_suspended = false;
+
+	if (message.event != PM_EVENT_SUSPEND &&
+	    message.event != PM_EVENT_FREEZE)
+		return 0;
+
+	/*
+	 * Wait for both interfaces to be suspended and no more async work
+	 * in progress.
+	 */
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	if (!tb_dev->mode_iface.suspended && !tb_dev->disp_iface.suspended) {
+		tb_dev->active = false;
+		cancel_delayed_work(&tb_dev->tb_work);
+	}
+
+	iface_info = appletb_get_iface_info(tb_dev, hdev);
+	if (iface_info)
+		iface_info->suspended = true;
+
+	if ((!tb_dev->mode_iface.hdev || tb_dev->mode_iface.suspended) &&
+	    (!tb_dev->disp_iface.hdev || tb_dev->disp_iface.suspended))
+		all_suspended = true;
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+
+	flush_delayed_work(&tb_dev->tb_work);
+
+	if (!all_suspended)
+		return 0;
+
+	/*
+	 * The touch bar device itself remembers the last state when suspended
+	 * in some cases, but in others (e.g. when mode != off and disp == off)
+	 * it resumes with a different state; furthermore it may be only
+	 * partially responsive in that state. By turning both mode and disp
+	 * off we ensure it is in a good state when resuming (and this happens
+	 * to be the same state after booting/resuming-from-hibernate, so less
+	 * special casing between the two).
+	 */
+	if (message.event == PM_EVENT_SUSPEND) {
+		appletb_set_tb_mode(tb_dev, APPLETB_CMD_MODE_OFF);
+		appletb_set_tb_disp(tb_dev, APPLETB_CMD_DISP_OFF);
+	}
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	tb_dev->cur_tb_mode = APPLETB_CMD_MODE_OFF;
+	tb_dev->cur_tb_disp = APPLETB_CMD_DISP_OFF;
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+
+	dev_info(tb_dev->log_dev, "Touchbar suspended.\n");
+
+	return 0;
+}
+
+static int appletb_reset_resume(struct hid_device *hdev)
+{
+	struct appletb_device *tb_dev = hid_get_drvdata(hdev);
+	struct appletb_iface_info *iface_info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tb_dev->tb_lock, flags);
+
+	iface_info = appletb_get_iface_info(tb_dev, hdev);
+	if (iface_info)
+		iface_info->suspended = false;
+
+	if ((tb_dev->mode_iface.hdev && !tb_dev->mode_iface.suspended) &&
+	    (tb_dev->disp_iface.hdev && !tb_dev->disp_iface.suspended)) {
+		/*
+		 * Restore touch bar state. Note that autopm state is not
+		 * preserved, so need explicitly restore that here.
+		 */
+		tb_dev->active = true;
+		tb_dev->restore_autopm = true;
+		tb_dev->last_event_time = ktime_get();
+
+		appletb_update_touchbar_no_lock(tb_dev, true);
+
+		dev_info(tb_dev->log_dev, "Touchbar resumed.\n");
+	}
+
+	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
+
+	return 0;
+}
+#endif
+
+static struct appletb_device *appletb_alloc_device(void)
+{
+	struct appletb_device *tb_dev;
+
+	tb_dev = kzalloc(sizeof(*tb_dev), GFP_KERNEL);
+	if (!tb_dev)
+		return NULL;
+
+	spin_lock_init(&tb_dev->tb_lock);
+	INIT_DELAYED_WORK(&tb_dev->tb_work, appletb_set_tb_worker);
+
+	return tb_dev;
+}
+
+static void appletb_free_device(struct appletb_device *tb_dev)
+{
+	cancel_delayed_work_sync(&tb_dev->tb_work);
+	kfree(tb_dev);
+}
+
+static const struct hid_device_id appletb_hid_ids[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LINUX_FOUNDATION,
+			 USB_DEVICE_ID_IBRIDGE_TB) },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(hid, appletb_hid_ids);
+
+static struct hid_driver appletb_hid_driver = {
+	.name = "apple-ib-touchbar",
+	.id_table = appletb_hid_ids,
+	.probe = appletb_probe,
+	.remove = appletb_remove,
+	.event = appletb_hid_event,
+	.input_configured = appletb_input_configured,
+#ifdef CONFIG_PM
+	.suspend = appletb_suspend,
+	.reset_resume = appletb_reset_resume,
+#endif
+};
+
+static int __init appletb_init(void)
+{
+	struct appletb_device *tb_dev;
+	int rc;
+
+	tb_dev = appletb_alloc_device();
+	if (!tb_dev)
+		return -ENOMEM;
+
+	appletb_dev = tb_dev;
+
+	rc = hid_register_driver(&appletb_hid_driver);
+	if (rc)
+		goto error;
+
+	return 0;
+
+error:
+	appletb_free_device(tb_dev);
+	return rc;
+}
+
+static void __exit appletb_exit(void)
+{
+	hid_unregister_driver(&appletb_hid_driver);
+	appletb_free_device(appletb_dev);
+}
+
+module_init(appletb_init);
+module_exit(appletb_exit);
+
+MODULE_AUTHOR("Ronald Tschalär");
+MODULE_DESCRIPTION("MacBookPro Touch Bar driver");
+MODULE_LICENSE("GPL v2");
-- 
2.21.0


