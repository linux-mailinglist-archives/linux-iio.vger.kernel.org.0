Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27F72D8E05
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 15:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgLMOsE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 09:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbgLMOsE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 09:48:04 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F013523121;
        Sun, 13 Dec 2020 14:47:22 +0000 (UTC)
Date:   Sun, 13 Dec 2020 14:47:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] Documentation/ABI/testing: Add documentation for
 AD5766 new ABI
Message-ID: <20201213144718.45de62b7@archlinux>
In-Reply-To: <20201208131957.34381-2-cristian.pop@analog.com>
References: <20201208131957.34381-1-cristian.pop@analog.com>
        <20201208131957.34381-2-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Dec 2020 15:19:56 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> New interface is proposed for dither functionality. This future allows
> composing  an external signals to the selected output channel.
> The dither signal can be turned on/off, scaled, inverted, or it can be
> selected from different sources.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

Great - much easier to discuss with docs.

Some comments inline.  Note we need to always construct ABI with the intent
that it be easy to generalize to other devices. Sometimes that leads to
slightly different decisions than we might make for a single driver.

> ---
>  .../ABI/testing/sysfs-bus-iio-dac-ad5766      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
> new file mode 100644
> index 000000000000..361bbd0862df
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
> @@ -0,0 +1,45 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_pwr
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Dither power on/off. Write 0 to power on dither or 1 to power it off.

_enable is what we tend to have for similar cases of turning things on or off.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_invert
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Inverts the dither applied to the selected DAC channel. Dither signal is
> +		not inverted (default) Dither signal is inverted.

This one is good.  Clear docs and good naming.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Returns possible scalings available for the current channel:
> +		"NO_SCALING 75%_SCALING 50%_SCALING 25%_SCALING"

Needs to be numbers.  75 50 25  + I'm going to guess that no scaling == 100%?
If so then use 100 to represent that.

 
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Scales the dither before it is applied to the selected channel.
> +		NO_SCALING - No scaling
> +		75%_SCALING - 75% scaling
> +		50%_SCALING - 50% scaling
> +		25%_SCALING - 25% scaling

As above and in previous review - needs to be just a number, not a string.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_source_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Returns possible dither sources available for the selected channel:
> +		"NO_DITHER N0 N1"
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_source
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Selects dither source applied to the selected channel.
> +		NO_DITHER - No dither applied
> +		N0 - N0 dither signal applied
> +		N1 - N1 dither signal applied
So you already have an enable. If the enable isn't set I'd assume
that is same as no dither applied?  If so just don't support NO_DITHER here
it doesn't give us anything extra.

I wondered about whether this should just be 0 or 1, but as these are
effectively arbitrary labels (in general, with assumption this
interface may get used for other devices!) N0, N1 is fine for this.




