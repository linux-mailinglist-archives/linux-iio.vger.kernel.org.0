Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6501746003B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhK0Qjd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 11:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbhK0Qhc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 11:37:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33610C061748;
        Sat, 27 Nov 2021 08:34:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD44960EBC;
        Sat, 27 Nov 2021 16:34:17 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 30D6EC53FBF;
        Sat, 27 Nov 2021 16:34:14 +0000 (UTC)
Date:   Sat, 27 Nov 2021 16:39:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio:filter:admv8818: Add sysfs ABI documentation
Message-ID: <20211127163916.264e58be@jic23-huawei>
In-Reply-To: <20211123133900.133027-4-antoniu.miclaus@analog.com>
References: <20211123133900.133027-1-antoniu.miclaus@analog.com>
        <20211123133900.133027-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 15:39:00 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add initial ABI documentation for admv8818 filter sysfs interfaces.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Anntoniu,

I'd focused on the other attributes previously and as a result missed
the issue with scaling for the 3db_frequency attrs.

See below,

Jonathan

> ---
> changes in v2:
>  - remove bandwidth/center frequency related custom device attributes
>  - remove bypass filter mode
>  .../ABI/testing/sysfs-bus-iio-filter-admv8818 | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> new file mode 100644
> index 000000000000..7211b5d0daa0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
> @@ -0,0 +1,44 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_high_pass_3db_frequency
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The cut-off frequency of the ADMV8818 high pass filter. The value is scaled using
> +		the `out_altvoltageY_scale` attribute so that GHz frequencies are valid inputs,

out_altvoltage_Y_scale applies to out_altvoltageY_raw (sure that doesn't actually exist here, but
we can't change it's meaning to something entirely different like this).

> +		The accepted range of values for the frequencies is between 1.75GHz and 19.9GHz.
> +
> +		The default value for the scale is 1000000, therefore MHz frequency values are
> +		passed as input.

Hmm. The scaling things is not how the other instances of 3db_frequency work and we need to be consistent.
So even though it's a lot of zeros this needs to be in HZ.

Note we ran into a requirement for 64 bit values recently so now have IIO_VAL_INT_64 which will
probably work for you here.

once that is tidied up these two 3db_frequency attributes are standard ABI (fit with the same for
other channels).  As such, please put them in the relevant existing entries for similar 3db_frequency.

Note that, if you want to express ranges that belongs in the sysfs attribute
*3db_frequency_available, not the documentation.



> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_filter_low_pass_3db_frequency
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The cut-off frequency of the ADMV8818 low pass filter. The value is scaled using
> +		the `out_altvoltageY_scale` attribute so that GHz frequencies are valid inputs,
> +		The accepted range of values for the frequencies is between 2.05GHz and 18.85GHz.
> +
> +		The default value for the scale is 1000000, therefore MHz frequency values are
> +		passed as input.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Scale high pass and lowpass filter frequency values to Hz.

As above, this needs to go because it doesn't logically mean this when considered alongside the
existing ABI.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_mode_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading this returns the valid values that can be written to the
> +		on_altvoltage0_mode attribute:
> +
> +		- auto -> Adjust bandpass filter to track changes in input clock rate.
> +		- manual -> disable/unregister the clock rate notifier / input clock tracking.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_mode
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute configures the filter mode.
> +		Reading returns the actual mode.
This bit works for me.  There is a risk we will run into different definitions of filter_mode
in the future and the docs builder doesn't let you have multiple definitions. If that happens
we may need to move this.   Can do it when needed however as this is the first such definition.

Thanks,

Jonathan


