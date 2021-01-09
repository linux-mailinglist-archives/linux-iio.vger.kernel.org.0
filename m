Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0FA32F0315
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jan 2021 20:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbhAITIr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 14:08:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbhAITIq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Jan 2021 14:08:46 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B19E2399A;
        Sat,  9 Jan 2021 19:08:05 +0000 (UTC)
Date:   Sat, 9 Jan 2021 19:08:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] Documentation/ABI/testing: Add documentation for
 AD5766 new ABI
Message-ID: <20210109190802.4c4fcbc2@archlinux>
In-Reply-To: <20210108183739.27634-2-cristian.pop@analog.com>
References: <20210108183739.27634-1-cristian.pop@analog.com>
        <20210108183739.27634-2-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Jan 2021 20:37:38 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> New interface is proposed for dither functionality. This future allows
> composing  an external signals to the selected output channel.
> The dither signal can be turned on/off, scaled, inverted, or it can be
> selected from different sources.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
Hi Cristian,

One trivial inline to fix if you need to respin. Otherwise I can tidy up whilst
applying.

Jonathan


> ---
> Changelog v5:                                                              
>         - Rename property to: "in_voltageY_dither_enable"                  
>         - Change scale values to: "1 0.75 0.5 0.25"                        
>         - Specify KernelVersion
>  .../ABI/testing/sysfs-bus-iio-dac-ad5766      | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766 b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
> new file mode 100644
> index 000000000000..6e5e383b2c53
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ad5766
> @@ -0,0 +1,31 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_ennable
Typo, enable but I can fix that whilst applying if there is nothing else.

Jonathan

> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Dither enable. Write 1 to enable dither or 0 to disable it.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_invert
> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Inverts the dither applied to the selected DAC channel. Dither is not
> +		inverted by default. Write "1" to invert dither.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale_available
> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Returns possible scalings available for the current channel.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_scale
> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Scales the dither before it is applied to the selected channel.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_dither_source
> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Selects dither source applied to the selected channel. Write "0" to
> +		select N0 source, write "1" to select N1 source.

