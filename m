Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0F1D56B4
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEOQwz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 12:52:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45946 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOQwy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2020 12:52:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 2F1C42A32FD
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        kernel@collabora.com, Patrik Fimml <patrikf@chromium.org>
Subject: [PATCHv2 6/7] Input: Add "inhibited" property
Date:   Fri, 15 May 2020 18:52:37 +0200
Message-Id: <20200515165237.28906-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515164943.28480-1-andrzej.p@collabora.com>
References: <20200515164943.28480-1-andrzej.p@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Patrik Fimml <patrikf@chromium.org>

Userspace might want to implement a policy to temporarily disregard input
from certain devices, including not treating them as wakeup sources.

An example use case is a laptop, whose keyboard can be folded under the
screen to create tablet-like experience. The user then must hold the laptop
in such a way that it is difficult to avoid pressing the keyboard keys. It
is therefore desirable to temporarily disregard input from the keyboard,
until it is folded back. This obviously is a policy which should be kept
out of the kernel, but the kernel must provide suitable means to implement
such a policy.

This patch adds a sysfs interface for exactly this purpose.

To implement the said interface it adds an "inhibited" property to struct
input_dev and two optional methods - inhibit() and uninhibit(), and
effectively creates four states a device can be in: closed uninhibited,
closed inhibited, open uninhibited, open inhibited. It also defers calling
driver's ->open() and ->close() to until they are actually needed, e.g. it
makes no sense to prepare the underlying device for generating events
(->open()) if the device is inhibited.

              uninhibit
closed      <------------ closed
uninhibited ------------> inhibited
      | ^     inhibit        | ^
 1st  | |               1st  | |
 open | |               open | |
      | |                    | |
      | | last               | | last
      | | close              | | close
      v |     uninhibit      v |
open        <------------ open
uninhibited ------------> inhibited

The top inhibit/uninhibit transition happens when users == 0.
The bottom inhibit/uninhibit transition happens when users > 0.
The left open/close transition happens when !inhibited.
The right open/close transition happens when inhibited.
Due to all transitions being serialized with dev->mutex, it is impossible
to have "diagonal" transitions between closed uninhibited and open
inhibited or between open uninhibited and closed inhibited.

open() and close() - if provided - are called in both inhibit and uninhibit
paths. Please note that close() does not return a value, so if your driver
might need failing inhibiting, you need to provide inhibit() so that it
returns a value to check.

It is drivers' responsibility to implement their inhibiting capability in
terms of whatever is suitable in their context, be it open/close,
inhibit/uninhibit or a combination of both. The drivers should also ensure
that they properly interact with suspend/resume and PM runtime, because
most likely a side effect of inhibiting a device should be its going into
low power mode. Properly inhibiting a device means to prevent it from being
a wakeup source, so drivers should also take care of that.

Signed-off-by: Patrik Fimml <patrikf@chromium.org>
Co-developed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/input/input.c | 136 ++++++++++++++++++++++++++++++++++++++----
 include/linux/input.h |   8 +++
 2 files changed, 134 insertions(+), 10 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 41377bfa142d..5b859a178c11 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -367,8 +367,13 @@ static int input_get_disposition(struct input_dev *dev,
 static void input_handle_event(struct input_dev *dev,
 			       unsigned int type, unsigned int code, int value)
 {
-	int disposition = input_get_disposition(dev, type, code, &value);
+	int disposition;
 
+	/* filter-out events from inhibited devices */
+	if (dev->inhibited)
+		return;
+
+	disposition = input_get_disposition(dev, type, code, &value);
 	if (disposition != INPUT_IGNORE_EVENT && type != EV_SYN)
 		add_input_randomness(type, code, value);
 
@@ -612,7 +617,7 @@ int input_open_device(struct input_handle *handle)
 
 	handle->open++;
 
-	if (dev->users++) {
+	if (dev->users++ || dev->inhibited) {
 		/*
 		 * Device is already opened, so we can exit immediately and
 		 * report success.
@@ -660,6 +665,14 @@ int input_flush_device(struct input_handle *handle, struct file *file)
 }
 EXPORT_SYMBOL(input_flush_device);
 
+static inline void input_stop(struct input_dev *dev)
+{
+	if (dev->poller)
+		input_dev_poller_stop(dev->poller);
+	if (dev->close)
+		dev->close(dev);
+}
+
 /**
  * input_close_device - close input device
  * @handle: handle through which device is being accessed
@@ -675,13 +688,8 @@ void input_close_device(struct input_handle *handle)
 
 	__input_release_device(handle);
 
-	if (!--dev->users) {
-		if (dev->poller)
-			input_dev_poller_stop(dev->poller);
-
-		if (dev->close)
-			dev->close(dev);
-	}
+	if (!dev->inhibited && !--dev->users)
+		input_stop(dev);
 
 	if (!--handle->open) {
 		/*
@@ -1416,12 +1424,49 @@ static ssize_t input_dev_show_properties(struct device *dev,
 }
 static DEVICE_ATTR(properties, S_IRUGO, input_dev_show_properties, NULL);
 
+static int input_inhibit(struct input_dev *dev);
+static int input_uninhibit(struct input_dev *dev);
+
+static ssize_t inhibited_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", input_dev->inhibited);
+}
+
+static ssize_t inhibited_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t len)
+{
+	struct input_dev *input_dev = to_input_dev(dev);
+	ssize_t rv;
+	bool inhibited;
+
+	if (strtobool(buf, &inhibited))
+		return -EINVAL;
+
+	if (inhibited)
+		rv = input_inhibit(input_dev);
+	else
+		rv = input_uninhibit(input_dev);
+
+	if (rv != 0)
+		return rv;
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(inhibited);
+
 static struct attribute *input_dev_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_phys.attr,
 	&dev_attr_uniq.attr,
 	&dev_attr_modalias.attr,
 	&dev_attr_properties.attr,
+	&dev_attr_inhibited.attr,
 	NULL
 };
 
@@ -1703,6 +1748,77 @@ void input_reset_device(struct input_dev *dev)
 }
 EXPORT_SYMBOL(input_reset_device);
 
+static int input_inhibit(struct input_dev *dev)
+{
+	int ret = 0;
+
+	mutex_lock(&dev->mutex);
+
+	if (dev->inhibited)
+		goto out;
+
+	if (dev->users) {
+		if (dev->inhibit) {
+			ret = dev->inhibit(dev);
+			if (ret)
+				goto out;
+		}
+		input_stop(dev);
+	}
+
+	spin_lock_irq(&dev->event_lock);
+	input_dev_release_keys(dev);
+	input_dev_toggle(dev, false);
+	spin_unlock_irq(&dev->event_lock);
+
+	dev->inhibited = true;
+
+out:
+	mutex_unlock(&dev->mutex);
+	return ret;
+}
+
+static int input_uninhibit(struct input_dev *dev)
+{
+	int ret = 0;
+
+	mutex_lock(&dev->mutex);
+
+	if (!dev->inhibited)
+		goto out;
+
+	if (dev->users) {
+		if (dev->open) {
+			ret = dev->open(dev);
+			if (ret)
+				goto toggle;
+		}
+		if (dev->uninhibit) {
+			ret = dev->uninhibit(dev);
+			if (ret) {
+				if (dev->close)
+					dev->close(dev);
+				goto toggle;
+			}
+		}
+		if (dev->poller)
+			input_dev_poller_start(dev->poller);
+	}
+
+	dev->inhibited = false;
+
+toggle:
+	if (!dev->inhibited) {
+		spin_lock_irq(&dev->event_lock);
+		input_dev_toggle(dev, true);
+		spin_unlock_irq(&dev->event_lock);
+	}
+
+out:
+	mutex_unlock(&dev->mutex);
+	return ret;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int input_dev_suspend(struct device *dev)
 {
@@ -2131,7 +2247,7 @@ bool input_device_enabled(struct input_dev *dev)
 {
 	lockdep_assert_held(&dev->mutex);
 
-	return dev->users > 0;
+	return !dev->inhibited && dev->users > 0;
 }
 EXPORT_SYMBOL_GPL(input_device_enabled);
 
diff --git a/include/linux/input.h b/include/linux/input.h
index eda4587dba67..8d0dcfaeaf6f 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -127,6 +127,9 @@ enum input_clock_type {
  *	and needs not be explicitly unregistered or freed.
  * @timestamp: storage for a timestamp set by input_set_timestamp called
  *  by a driver
+ * @inhibit: makes the device ignore all input
+ * @uninhibit: undoes the effect of inhibit
+ * @inhibited: indicates that the input device is inhibited
  */
 struct input_dev {
 	const char *name;
@@ -201,6 +204,11 @@ struct input_dev {
 	bool devres_managed;
 
 	ktime_t timestamp[INPUT_CLK_MAX];
+
+	int (*inhibit)(struct input_dev *dev);
+	int (*uninhibit)(struct input_dev *dev);
+
+	bool inhibited;
 };
 #define to_input_dev(d) container_of(d, struct input_dev, dev)
 
-- 
2.17.1

