Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFBD47530
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfFPO3G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 10:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfFPO3G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 10:29:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 321B12133D;
        Sun, 16 Jun 2019 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560695345;
        bh=9ofTsX6q7RL1aAuUTwD32EQaijD0fUq+Een/3IeIbXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TdY5bPryovlMoe7OICNUgFOe9GqzKCQaqVll/VFg0Og4J5iLKl7j09S3C+D8/TQln
         HxOzhk6lVjyKmeDM9LtiPagAd+Ye4fid8Pd1EH1jfF8XiXpZXhFJHHQr9CaCZB2p/2
         BwQvXgnHc0iFSkZLFy5ROLhMFo01b7eGCxO3Gcl8=
Date:   Sun, 16 Jun 2019 15:28:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ronald =?UTF-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] HID: apple-ib-tb: Add driver for the Touch Bar
 on MacBook Pro's.
Message-ID: <20190616152859.6f1c247c@archlinux>
In-Reply-To: <20190612083400.1015-3-ronald@innovation.ch>
References: <20190612083400.1015-1-ronald@innovation.ch>
        <20190612083400.1015-3-ronald@innovation.ch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Jun 2019 01:33:59 -0700
Ronald Tschal=C3=A4r <ronald@innovation.ch> wrote:

> This driver enables basic touch bar functionality: enabling it, switching
> between modes on FN key press, and dimming and turning the display
> off/on when idle/active.
>=20
> Signed-off-by: Ronald Tschal=C3=A4r <ronald@innovation.ch>
A few minor comments inline from me, but as before well outside of my
areas of knowledge!

Jonathan

> ---
>  drivers/hid/Kconfig       |   10 +
>  drivers/hid/Makefile      |    1 +
>  drivers/hid/apple-ib-tb.c | 1389 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1400 insertions(+)
>  create mode 100644 drivers/hid/apple-ib-tb.c
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 545d3691fc1c..7621c2500d71 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -149,6 +149,16 @@ config HID_APPLE_IBRIDGE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called apple-ibridge.
> =20
> +config HID_APPLE_IBRIDGE_TB
> +	tristate "Apple iBridge Touch Bar"
> +	depends on HID_APPLE_IBRIDGE
> +	---help---
> +	Say Y here if you want support for the Touch Bar on recent
> +	MacBook Pros.
> +
> +	To compile this driver as a module, choose M here: the
> +	module will be called apple-ib-tb.
> +
>  config HID_APPLEIR
>  	tristate "Apple infrared receiver"
>  	depends on (USB_HID)
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index a4da5663a541..0c46e5f70db1 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_HID_ALPS)		+=3D hid-alps.o
>  obj-$(CONFIG_HID_ACRUX)		+=3D hid-axff.o
>  obj-$(CONFIG_HID_APPLE)		+=3D hid-apple.o
>  obj-$(CONFIG_HID_APPLE_IBRIDGE)	+=3D apple-ibridge.o
> +obj-$(CONFIG_HID_APPLE_IBRIDGE_TB)	+=3D apple-ib-tb.o
>  obj-$(CONFIG_HID_APPLEIR)	+=3D hid-appleir.o
>  obj-$(CONFIG_HID_ASUS)		+=3D hid-asus.o
>  obj-$(CONFIG_HID_AUREAL)	+=3D hid-aureal.o
> diff --git a/drivers/hid/apple-ib-tb.c b/drivers/hid/apple-ib-tb.c
> new file mode 100644
> index 000000000000..6daee80060ce
> --- /dev/null
> +++ b/drivers/hid/apple-ib-tb.c
> @@ -0,0 +1,1389 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple Touch Bar Driver
> + *
> + * Copyright (c) 2017-2018 Ronald Tschal=C3=A4r
> + */
> +
> +/*
> + * Recent MacBookPro models (13,[23] and 14,[23]) have a touch bar, which
> + * is exposed via several USB interfaces. MacOS supports a fancy mode
> + * where arbitrary buttons can be defined; this driver currently only
> + * supports the simple mode that consists of 3 predefined layouts
> + * (escape-only, esc + special keys, and esc + function keys).
> + *
> + * The first USB HID interface supports two reports, an input report that
> + * is used to report the key presses, and an output report which can be
> + * used to set the touch bar "mode": touch bar off (in which case no tou=
ches
> + * are reported at all), escape key only, escape + 12 function keys, and
> + * escape + several special keys (including brightness, audio volume,
> + * etc). The second interface supports several, complex reports, most of
> + * which are unknown at this time, but one of which has been determined =
to
> + * allow for controlling of the touch bar's brightness: off (though touc=
hes
> + * are still reported), dimmed, and full brightness. This driver makes
> + * use of these two reports.
> + */
> +
> +#define dev_fmt(fmt) "tb: " fmt
> +
> +#include <linux/apple-ibridge.h>
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/input.h>
> +#include <linux/jiffies.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb.h>
> +#include <linux/workqueue.h>
> +
> +#define HID_UP_APPLE		0xff120000
> +#define HID_USAGE_MODE		(HID_UP_CUSTOM | 0x0004)
> +#define HID_USAGE_APPLE_APP	(HID_UP_APPLE  | 0x0001)
> +#define HID_USAGE_DISP		(HID_UP_APPLE  | 0x0021)
> +#define HID_USAGE_DISP_AUX1	(HID_UP_APPLE  | 0x0020)
> +
> +#define APPLETB_MAX_TB_KEYS	13	/* ESC, F1-F12 */
> +
> +#define APPLETB_CMD_MODE_ESC	0
> +#define APPLETB_CMD_MODE_FN	1
> +#define APPLETB_CMD_MODE_SPCL	2
> +#define APPLETB_CMD_MODE_OFF	3
> +#define APPLETB_CMD_MODE_UPD	254
> +#define APPLETB_CMD_MODE_NONE	255
> +
> +#define APPLETB_CMD_DISP_ON	1
> +#define APPLETB_CMD_DISP_DIM	2
> +#define APPLETB_CMD_DISP_OFF	4
> +#define APPLETB_CMD_DISP_UPD	254
> +#define APPLETB_CMD_DISP_NONE	255
> +
> +#define APPLETB_FN_MODE_FKEYS	0
> +#define APPLETB_FN_MODE_NORM	1
> +#define APPLETB_FN_MODE_INV	2
> +#define APPLETB_FN_MODE_SPCL	3
> +#define APPLETB_FN_MODE_MAX	APPLETB_FN_MODE_SPCL
> +
> +#define APPLETB_DEVID_KEYBOARD	1
> +#define APPLETB_DEVID_TOUCHPAD	2
> +
> +#define APPLETB_MAX_DIM_TIME	30
> +
> +static int appletb_tb_def_idle_timeout =3D 5 * 60;
> +module_param_named(idle_timeout, appletb_tb_def_idle_timeout, int, 0444);
> +MODULE_PARM_DESC(idle_timeout, "Default touch bar idle timeout:\n"
> +			       "    >0 - turn touch bar display off after no keyboard, trackp=
ad, or touch bar input has been received for this many seconds;\n"
> +			       "         the display will be turned back on as soon as new in=
put is received\n"
> +			       "     0 - turn touch bar display off (input does not turn it o=
n again)\n"
> +			       "    -1 - turn touch bar display on (does not turn off automat=
ically)\n"
> +			       "    -2 - disable touch bar completely");
> +
> +static int appletb_tb_def_dim_timeout =3D -2;
> +module_param_named(dim_timeout, appletb_tb_def_dim_timeout, int, 0444);
> +MODULE_PARM_DESC(dim_timeout, "Default touch bar dim timeout:\n"
> +			      "    >0 - dim touch bar display after no keyboard, trackpad, or=
 touch bar input has been received for this many seconds\n"
> +			      "         the display will be returned to full brightness as so=
on as new input is received\n"
> +			      "     0 - dim touch bar display (input does not return it to fu=
ll brightness)\n"
> +			      "    -1 - disable timeout (touch bar never dimmed)\n"
> +			      "    [-2] - calculate timeout based on idle-timeout");
> +
> +static int appletb_tb_def_fn_mode =3D APPLETB_FN_MODE_NORM;
> +module_param_named(fnmode, appletb_tb_def_fn_mode, int, 0444);
> +MODULE_PARM_DESC(fnmode, "Default Fn key mode:\n"
> +			 "    0 - function-keys only\n"
> +			 "    [1] - fn key switches from special to function-keys\n"
> +			 "    2 - inverse of 1\n"
> +			 "    3 - special keys only");
> +
> +static ssize_t idle_timeout_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf);
> +static ssize_t idle_timeout_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t size);
> +static DEVICE_ATTR_RW(idle_timeout);
> +
> +static ssize_t dim_timeout_show(struct device *dev,
> +				struct device_attribute *attr, char *buf);
> +static ssize_t dim_timeout_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t size);
> +static DEVICE_ATTR_RW(dim_timeout);
> +
> +static ssize_t fnmode_show(struct device *dev, struct device_attribute *=
attr,
> +			   char *buf);
> +static ssize_t fnmode_store(struct device *dev, struct device_attribute =
*attr,
> +			    const char *buf, size_t size);
> +static DEVICE_ATTR_RW(fnmode);
> +
> +static struct attribute *appletb_attrs[] =3D {
> +	&dev_attr_idle_timeout.attr,
> +	&dev_attr_dim_timeout.attr,
> +	&dev_attr_fnmode.attr,
> +	NULL,

Documentation for these?=20

> +};
> +
> +static const struct attribute_group appletb_attr_group =3D {
> +	.attrs =3D appletb_attrs,
> +};
> +
...

> +/*
> + * While the mode functionality is listed as a valid hid report in the u=
sb
> + * interface descriptor, it's not sent that way. Instead it's sent with
> + * different request-type and without a leading report-id in the data. H=
ence
> + * we need to send it as a custom usb control message rather via any of =
the
> + * standard hid_hw_*request() functions.
> + */
> +static int appletb_set_tb_mode(struct appletb_device *tb_dev,
> +			       unsigned char mode)
> +{
> +	void *buf;
> +	bool autopm_off =3D false;
> +	int rc;
> +
> +	if (!tb_dev->mode_iface.hdev)
> +		return -ENOTCONN;
> +
> +	buf =3D kmemdup(&mode, 1, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	autopm_off =3D appletb_disable_autopm(tb_dev->mode_iface.hdev);
> +
> +	rc =3D appletb_send_usb_ctrl(&tb_dev->mode_iface,
> +				   USB_DIR_OUT | USB_TYPE_VENDOR |
> +							USB_RECIP_DEVICE,
Odd indentation.

> +				   tb_dev->mode_field->report, buf, 1);
> +	if (rc < 0)
> +		dev_err(tb_dev->log_dev,
> +			"Failed to set touch bar mode to %u (%d)\n", mode, rc);
> +
> +	if (autopm_off)
> +		hid_hw_power(tb_dev->mode_iface.hdev, PM_HINT_NORMAL);
> +
> +	kfree(buf);
> +
> +	return rc;
> +}
...

> +
> +static int appletb_set_tb_disp(struct appletb_device *tb_dev,
> +			       unsigned char disp)
> +{
> +	struct hid_report *report;
> +	int rc;
> +
> +	if (!tb_dev->disp_iface.hdev)
> +		return -ENOTCONN;
> +
> +	report =3D tb_dev->disp_field->report;
> +
> +	rc =3D hid_set_field(tb_dev->disp_field_aux1, 0, 1);
> +	if (!rc)
> +		rc =3D hid_set_field(tb_dev->disp_field, 0, disp);

This stacked error handling is less readable than just having two
separate error blocks with very similar comments.

> +	if (rc) {
> +		dev_err(tb_dev->log_dev,
> +			"Failed to set display report fields (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	/*
> +	 * Keep the USB interface powered on while the touch bar display is on
> +	 * for better responsiveness.
> +	 */
> +	if (disp !=3D APPLETB_CMD_DISP_OFF && !tb_dev->tb_autopm_off)
> +		tb_dev->tb_autopm_off =3D
> +			appletb_disable_autopm(report->device);
> +
> +	rc =3D appletb_send_hid_report(&tb_dev->disp_iface, report);
> +
Nitpick. For consistency should probably not be a blank line here.
> +	if (rc < 0)
> +		dev_err(tb_dev->log_dev,
> +			"Failed to set touch bar display to %u (%d)\n", disp,
> +			rc);
> +
> +	if (disp =3D=3D APPLETB_CMD_DISP_OFF && tb_dev->tb_autopm_off) {
> +		hid_hw_power(tb_dev->disp_iface.hdev, PM_HINT_NORMAL);
> +		tb_dev->tb_autopm_off =3D false;
> +	}
> +
> +	return rc;
> +}
> +
...

> +static int appletb_probe(struct hid_device *hdev,
> +			 const struct hid_device_id *id)
> +{
> +	struct appletb_device *tb_dev =3D appletb_dev;
> +	struct appletb_iface_info *iface_info;
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(&tb_dev->tb_lock, flags);
> +
> +	if (!tb_dev->log_dev)
> +		tb_dev->log_dev =3D &hdev->dev;
> +
> +	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
> +
> +	hid_set_drvdata(hdev, tb_dev);
> +
> +	/* initialize the report info */
> +	rc =3D hid_parse(hdev);
> +	if (rc) {
> +		dev_err(tb_dev->log_dev, "als: hid parse failed (%d)\n", rc);
> +		goto error;
> +	}
> +
> +	rc =3D appletb_extract_report_info(tb_dev, hdev);
> +	if (rc < 0)
> +		goto error;
> +
> +	rc =3D hid_hw_start(hdev, HID_CONNECT_DRIVER | HID_CONNECT_HIDINPUT);
> +	if (rc) {
> +		dev_err(tb_dev->log_dev, "hw start failed (%d)\n", rc);
> +		goto clear_iface_info;
> +	}
> +
> +	rc =3D hid_hw_open(hdev);
> +	if (rc) {
> +		dev_err(tb_dev->log_dev, "hw open failed (%d)\n", rc);
> +		goto stop_hid;
> +	}
> +
> +	/* do setup if we have both interfaces */
> +	if (appletb_test_and_mark_active(tb_dev)) {
> +		/* initialize the touch bar */
> +		if (appletb_tb_def_fn_mode >=3D 0 &&
> +		    appletb_tb_def_fn_mode <=3D APPLETB_FN_MODE_MAX)
> +			tb_dev->fn_mode =3D appletb_tb_def_fn_mode;
> +		else
> +			tb_dev->fn_mode =3D APPLETB_FN_MODE_NORM;
> +		appletb_set_idle_timeout(tb_dev, appletb_tb_def_idle_timeout);
> +		appletb_set_dim_timeout(tb_dev, appletb_tb_def_dim_timeout);
> +		tb_dev->last_event_time =3D ktime_get();
> +
> +		tb_dev->pnd_tb_mode =3D APPLETB_CMD_MODE_UPD;
> +		tb_dev->pnd_tb_disp =3D APPLETB_CMD_DISP_UPD;
> +
> +		appletb_update_touchbar(tb_dev, false);
> +
> +		/* set up the input handler */
> +		tb_dev->inp_handler.event =3D appletb_inp_event;
> +		tb_dev->inp_handler.connect =3D appletb_inp_connect;
> +		tb_dev->inp_handler.disconnect =3D appletb_inp_disconnect;
> +		tb_dev->inp_handler.name =3D "appletb";
> +		tb_dev->inp_handler.id_table =3D appletb_input_devices;
> +		tb_dev->inp_handler.private =3D tb_dev;
> +
> +		rc =3D input_register_handler(&tb_dev->inp_handler);
> +		if (rc) {
> +			dev_err(tb_dev->log_dev,
> +				"Unable to register keyboard handler (%d)\n",
> +				rc);
> +			goto mark_inactive;
> +		}
> +
> +		/* initialize sysfs attributes */
> +		rc =3D sysfs_create_group(&tb_dev->mode_iface.hdev->dev.kobj,
> +					&appletb_attr_group);
> +		if (rc) {
> +			dev_err(tb_dev->log_dev,
> +				"Failed to create sysfs attributes (%d)\n", rc);
> +			goto unreg_handler;
> +		}
> +
> +		dev_dbg(tb_dev->log_dev, "Touchbar activated\n");
> +	}
> +
> +	return 0;
> +
> +unreg_handler:
> +	input_unregister_handler(&tb_dev->inp_handler);
> +mark_inactive:
> +	appletb_test_and_mark_inactive(tb_dev, hdev);
> +	cancel_delayed_work_sync(&tb_dev->tb_work);
> +	hid_hw_close(hdev);
> +stop_hid:
> +	hid_hw_stop(hdev);
> +clear_iface_info:
> +	iface_info =3D appletb_get_iface_info(tb_dev, hdev);
> +	if (iface_info) {
> +		usb_put_intf(iface_info->usb_iface);
> +		iface_info->usb_iface =3D NULL;
> +		iface_info->hdev =3D NULL;
> +	}

It might be cleaner to put this block into a utility function
named appropriately to make it clear it's undoing stuff from
the *_extract_report_info call.  Initially I wondered where
this stuff we are undoing came from.

> +error:
> +	return rc;
> +}
> +
> +static void appletb_remove(struct hid_device *hdev)
> +{
> +	struct appletb_device *tb_dev =3D hid_get_drvdata(hdev);
> +	struct appletb_iface_info *iface_info;
> +	unsigned long flags;
> +
> +	if (appletb_test_and_mark_inactive(tb_dev, hdev)) {
> +		sysfs_remove_group(&tb_dev->mode_iface.hdev->dev.kobj,
> +				   &appletb_attr_group);
> +
> +		input_unregister_handler(&tb_dev->inp_handler);
> +
> +		cancel_delayed_work_sync(&tb_dev->tb_work);
> +		appletb_set_tb_mode(tb_dev, APPLETB_CMD_MODE_OFF);
> +		appletb_set_tb_disp(tb_dev, APPLETB_CMD_DISP_ON);
> +
> +		if (tb_dev->tb_autopm_off)
> +			hid_hw_power(tb_dev->disp_iface.hdev, PM_HINT_NORMAL);
> +
> +		dev_info(tb_dev->log_dev, "Touchbar deactivated\n");
> +	}
> +
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +
> +	iface_info =3D appletb_get_iface_info(tb_dev, hdev);
> +	if (iface_info) {
> +		usb_put_intf(iface_info->usb_iface);
> +		iface_info->usb_iface =3D NULL;
> +		iface_info->hdev =3D NULL;
> +	}
> +
> +	spin_lock_irqsave(&tb_dev->tb_lock, flags);
> +
> +	if (tb_dev->log_dev =3D=3D &hdev->dev) {
> +		if (tb_dev->mode_iface.hdev)
> +			tb_dev->log_dev =3D &tb_dev->mode_iface.hdev->dev;
> +		else if (tb_dev->disp_iface.hdev)
> +			tb_dev->log_dev =3D &tb_dev->disp_iface.hdev->dev;
> +		else
> +			tb_dev->log_dev =3D NULL;
> +	}
> +
> +	spin_unlock_irqrestore(&tb_dev->tb_lock, flags);
> +}
...

