Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A7B3272AF
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 16:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhB1PEc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 28 Feb 2021 10:04:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2613 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhB1PEc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 10:04:32 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DpRN35tl8z67qtQ;
        Sun, 28 Feb 2021 22:58:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 28 Feb 2021 16:03:47 +0100
Received: from localhost (10.47.88.221) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 28 Feb
 2021 15:03:47 +0000
Date:   Sun, 28 Feb 2021 15:02:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ronald =?ISO-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
CC:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/5] HID: apple-ibridge: Add Apple iBridge HID driver
 for T1 chip.
Message-ID: <20210228150239.00007d34@Huawei.com>
In-Reply-To: <20210228012643.69944-5-ronald@innovation.ch>
References: <20210228012643.69944-1-ronald@innovation.ch>
        <20210228012643.69944-5-ronald@innovation.ch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.88.221]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 27 Feb 2021 17:26:42 -0800
Ronald Tschalär <ronald@innovation.ch> wrote:

> The iBridge device provides access to several devices, including:
> - the Touch Bar
> - the iSight webcam
> - the light sensor
> - the fingerprint sensor
> 
> This driver provides the core support for managing the iBridge device
> and the access to the underlying devices. In particular, the
> functionality for the touch bar and light sensor is exposed via USB HID
> interfaces, and on devices with the T1 chip one of the HID devices is
> used for both functions. So this driver creates virtual HID devices, one
> per top-level report collection on each HID device (for a total of 3
> virtual HID devices). The sub-drivers then bind to these virtual HID
> devices.
> 
> This way the Touch Bar and ALS drivers can be kept in their own modules,
> while at the same time making them look very much like as if they were
> connected to the real HID devices. And those drivers then work (mostly)
> without further changes on MacBooks with the T2 chip that don't need
> this driver.
> 
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
Hi Ronald.

This is far from my specialty but mostly looks sensible to me.

Just one thing stood out that I couldn't understand. See below.

Jonathan

> new file mode 100644
> index 0000000000000..5f2b71c199746
> --- /dev/null
> +++ b/drivers/hid/apple-ibridge.c
> @@ -0,0 +1,682 @@

...

> +
> +#ifdef CONFIG_PM
> +/**
> + * appleib_forward_int_op() - Forward a hid-driver callback to all drivers on
> + * all virtual HID devices attached to the given real HID device.
> + * @hdev the real hid-device
> + * @forward a function that calls the callback on the given driver
> + * @args arguments for the forward function
> + *
> + * This is for callbacks that return a status as an int.
> + *
> + * Returns: 0 on success, or the first error returned by the @forward function.
> + */
> +static int appleib_forward_int_op(struct hid_device *hdev,
> +				  int (*forward)(struct hid_driver *,
> +						 struct hid_device *, void *),
> +				  void *args)
> +{
> +	struct appleib_hid_dev_info *hdev_info = hid_get_drvdata(hdev);
> +	struct hid_device *sub_hdev;
> +	int rc = 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hdev_info->sub_hdevs); i++) {
> +		sub_hdev = hdev_info->sub_hdevs[i];
> +		if (sub_hdev->driver) {
> +			rc = forward(sub_hdev->driver, sub_hdev, args);
> +			if (rc)
> +				break;

return rc; here would be cleaner.

> +		}
> +
> +		break;

This is unusual.  It's a for loop but as far as I can see only first iteration
can ever run as we exit the loop at this break if we haven't done so earlier.
What is the intent here?

> +	}
> +
> +	return rc;
> +}

