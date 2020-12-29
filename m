Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586252E724C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 17:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgL2Q2n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 11:28:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2Q2n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 11:28:43 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D621207BC;
        Tue, 29 Dec 2020 16:28:01 +0000 (UTC)
Date:   Tue, 29 Dec 2020 16:27:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] Documentation/ABI/testing: Add documentation for
 AD5766 new ABI
Message-ID: <20201229162758.187beafd@archlinux>
In-Reply-To: <20201218171231.58794-2-cristian.pop@analog.com>
References: <20201218171231.58794-1-cristian.pop@analog.com>
        <20201218171231.58794-2-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Dec 2020 19:12:30 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> New interface is proposed for dither functionality. This future allows
> composing  an external signals to the selected output channel.
> The dither signal can be turned on/off, scaled, inverted, or it can be
> selected from different sources.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
Coming together nicely though a few more thoughts came to mind when reading
this. Only significant one is whether we are better with decimal scaling
than percentage scaling for consistency with channel scales etc?

Jonathan

> ---
> Changelog v4:
> 	- Change to "in_voltageY_dither_enable"
> 	- Change scale to numbers + 100% for no scaling
> 	- Possible dither source values: 0 - N0, 1 - N1 
>  .../ABI/testing/sysfs-bus-iio-dac-ad5766      | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
> new file mode 100644
> index 000000000000..72100edb88bb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
> @@ -0,0 +1,36 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_pwr

in_voltageY_dither_en would be more consistent with existing ABI naming.

> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Dither enable. Write 1 to enable dither or 0 to disable it.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_invert
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Inverts the dither applied to the selected DAC channel. Dither is not
> +		inverted by default. Write "1" to invert dither.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Returns possible scalings available for the current channel:

Given this one is self defining and may well get generalized to other devices I'd
got with a description that doesn't provide values.

Returns possible scalings as percentages.

However, thinking more on this it's a bit inconsistent with other scale values we have
which are given in decimal.  Would "1 0.75 0.5 0.25" work as well here?

> +		"100 75 50 25" scaling.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Scales the dither before it is applied to the selected channel:
> +		100 - No scaling
> +		75 - 75% scaling
> +		50 - 50% scaling
> +		25 - 25% scaling

As above, I'm don't really see an advantage in providing the values.  Any userspace
ought to cope with any (finding out what is there via _available).
"Scales the dither before it is applied to the selected channel.  1 corresponds
to no scaling".

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_source
> +KernelVersion:

Please fill in the expected kernel version.  I'll fix it if this happens to merge near
the change over in a cycle, but it's easier to fix something that is there
than to add it from scratch :)

> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Selects dither source applied to the selected channel. Write "0" to
> +		select N0 source, write "1" to select N1 source.

