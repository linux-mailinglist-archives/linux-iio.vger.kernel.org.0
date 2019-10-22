Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5ACE0114
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 11:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfJVJsT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 05:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbfJVJsS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 05:48:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846EC2089E;
        Tue, 22 Oct 2019 09:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571737697;
        bh=R5RgAstKCexZymJeVqVBt1NYcMVXUggrxCKFiFdo9v0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=keeDlu/bLtQEpPt1yTUzC9G2rd2mPZ3lqVgc8MH6op6C/e0oEXnlkXX7utRDb6ufB
         +DU284PwEpnxf1l7ssgf2rs91JZVpdBNsBvZElUe6LNXmFMY4BEDshcuH+2/lRBD2E
         QUyjTlc0xPg0IQ4WyYjvVF2xHEbz+ZUz/By5CXBM=
Date:   Tue, 22 Oct 2019 10:48:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: documentation: light: Add veml6030 sysfs
 documentation
Message-ID: <20191022104812.7f71b726@archlinux>
In-Reply-To: <1571716705-23113-1-git-send-email-gupt21@gmail.com>
References: <1571664705-7123-1-git-send-email-gupt21@gmail.com>
        <1571716705-23113-1-git-send-email-gupt21@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Oct 2019 09:28:25 +0530
Rishi Gupta <gupt21@gmail.com> wrote:

> The driver for veml6030 light sensor provides custom sysfs entries
> used to know parameters supported by the driver and to configure
> sensor like setting power saving mode and persistence etc. This
> commit document them.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
Hi Rishi,

Main issue here is that a lot of this is standard ABI.  Only ABI that
is non standard should be documented in a per device file.  If we don't
do this ever driver drifts off in it's own direction!

For PSM you run into the normal problem of custom ABI.  Reality is that
generic userspace will have no idea what to do with it.  Hence try
if at all possible to avoid custom ABI.  The PSM control appears to
be a control on the 'refresh rate' which corresponds to the maximum
possible sampling_frequency.  Hence use the standard ABI for sampling
frequency.  More info inline.

> ---
> Changes in v4:
> * None
> 
> Changes in v3:
> * Updated Date from September to October
> * Updated KernelVersion from 5.3.1 to 5.4
> * in_illuminance_period_available is now in events directory
> 
> Changes in v2:
> * None
> 
>  .../ABI/testing/sysfs-bus-iio-light-veml6030       | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030 b/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
> new file mode 100644
> index 0000000..13cd321
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
> @@ -0,0 +1,49 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_psm_available
> +Date:		October 2019
> +KernelVersion:	5.4
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		Provides list of valid values that can be used to activate a
> +		particular power saving mode in sensor. For ex; 1 means psm
> +		mode 1 and 2 means psm mode 2 and so on.
To a user of this device these modes are meaningless.  A user should not
need to open the datasheet to find out.

One thing to note is we very rarely let in power mode stuff in userspace interfaces
because it's very hard for userspace to know what to do with the them.

If there is a reason to switch modes it should be wrapped up in the driver.
We have things like runtime power management with timing based suspend etc
to magically deal with this stuff for us.

Superficially this effect of these seems to be on the 'refresh time', suggesting
that these are actually trading off potential sampling frequency for power
saving?  If that is the case, please handle this as a sampling_frequency control.
Userspace will set that as low as possible to meet it's requirements, as that
saves power in almost any device.  Clearly this value is interlinked with the
integration time.   That's fine. Integration time takes priority as that is what
a user actually 'needs' to control (to avoid saturation).  So when integration
time changes, the available and current sampling_frequency will change.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_psm
> +Date:		October 2019
> +KernelVersion:	5.4
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		Writing '1' will activate power saving mode 1 in sensor.
> +		Similarly, 2 is to activate psm mode 2 and so on.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_period_available

This is standard ABI so should either already be documented, or should be added to the
main ABI file
ABI/testing/sysfs-bus-iio

I think this is true for all the others below as well.


> +Date:		October 2019
> +KernelVersion:	5.4
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		List of valid values available in multiples of integration time
> +		for which the light intensity must be above the cutoff level
> +		before interrupt is asserted. This refers to persistence values.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_either_period
> +Date:		October 2019
> +KernelVersion:	5.4
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		Value in multiple of integration time for which the light intensity must
> +		be above the cutoff level before interrupt is asserted.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_rising_value
> +Date:		October 2019
> +KernelVersion:	5.4
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		Raw threshold value from 0 to 0xffffffff. An interrupt will be asserted whenever
> +		light intensity is above this value.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_falling_value


> +Date:		October 2019
> +KernelVersion:	5.4
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		Raw threshold value from 0 to 0xffffffff. An interrupt will be asserted whenever
> +		light intensity is below this value.

