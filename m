Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C25460067
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 18:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhK0ROo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Nov 2021 12:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhK0RMo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 12:12:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8808BC06175A;
        Sat, 27 Nov 2021 09:08:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 836A160EDF;
        Sat, 27 Nov 2021 17:08:48 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 536A8C53FBF;
        Sat, 27 Nov 2021 17:08:45 +0000 (UTC)
Date:   Sat, 27 Nov 2021 17:13:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] Documentation:ABI:testing:admv1013: add ABI docs
Message-ID: <20211127171346.0b022545@jic23-huawei>
In-Reply-To: <20211123115336.65827-3-antoniu.miclaus@analog.com>
References: <20211123115336.65827-1-antoniu.miclaus@analog.com>
        <20211123115336.65827-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 13:53:36 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the use of the Local Oscillator Feedthrough Offset
> calibration.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu

Nearly there, but I think the naming isn't quite consistent with normal ABI
and thinking on it a little more, not sure the freq_mode stuff should be
userspace controllable as it will be reflected in the wiring.

Thanks,

Jonathan


> ---
> changes in v5:
>  - rework the custom device attributes based on the feedback received in v4
>  - add frequency translation modes custom attributes.
>  .../testing/sysfs-bus-iio-frequency-admv1013  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> new file mode 100644
> index 000000000000..3ff80909f007
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> @@ -0,0 +1,55 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_phase_i

So why phase_i, rather than i_phase?

My logic is that 0-1 is the channel index, i it he modifier and phase is the info_mask element
saying what we are actually modifying about this channel.

So much as we'd have in_accel0_x_scale as with 0 as the index, x as the modifier and 
scale as the 'what' about the channel, the ordering should be the other way around to
what you have.  I and Q are defined as modifiers already so we should remain consistent
with that rather than defining a 'what' as phase_i applied to an unmodified channel
which is what i think this currently corresponds to.

> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior path quadrature I phase shift.

Raw?  Phase is already documented in the main ABI/testing/sysfs-bus-iio documentation as
being in radians.  That needs to be true here as well so we have consistent ABI.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_phase_q
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior path quadrature Q phase shift.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_calibbias_i
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Positive
> +		side.

I'd drop the raw from this as well, though calibbias is often unit free so no need to say anything
about units for this one.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_calibbias_q
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Positive
> +		side.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage1_calibbias_i
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Negative
> +		side.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage1_calibbias_q
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Negative
> +		side.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/freq_mode_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading this returns the valid values that can be written to the freq_mode attribute.

Silly question.  How is this the mode of the 'frequency'.  IIRC it's the type of input signal
being provided.   Speaking of which, this is a characteristic of the wiring so I think
this is something that should be in DT unless I'm missing something and should not
be in the control of userspace... (hopefully I didn't say the other way around in an earlier review!)


> +
> +		- if -> Intermediate Frequency
> +		- iq -> Quadrature I/Q mode.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/freq_mode
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute configures the frequency mode.
> +		Reading returns the actual mode.

