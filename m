Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0257644F8E3
	for <lists+linux-iio@lfdr.de>; Sun, 14 Nov 2021 16:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhKNP5M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 10:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235630AbhKNP5I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Nov 2021 10:57:08 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D83960EE2;
        Sun, 14 Nov 2021 15:54:13 +0000 (UTC)
Date:   Sun, 14 Nov 2021 15:58:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] Documentation:ABI:testing:admv1013: add ABI docs
Message-ID: <20211114155859.5836a4e0@jic23-huawei>
In-Reply-To: <20211105112930.122017-4-antoniu.miclaus@analog.com>
References: <20211105112930.122017-1-antoniu.miclaus@analog.com>
        <20211105112930.122017-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 5 Nov 2021 13:29:30 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the use of the Local Oscillator Feedthrough Offset
> calibration.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../testing/sysfs-bus-iio-frequency-admv1013  | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> new file mode 100644
> index 000000000000..f52cd55a66c6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> @@ -0,0 +1,27 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_i_lo_feedthrough_offset_calib_positive
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Positive
> +		in the Intermediate Frequency mode.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_i_lo_feedthrough_offset_calib_negative
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Negative
> +		in the Intermediate Frequency mode.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_q_lo_feedthrough_offset_calib_positive
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Positive
> +		in the Intermediate Frequency mode.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_q_lo_feedthrough_offset_calib_negative
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Negative
> +		in the Intermediate Frequency mode.

Hmm. 
Unfortuantely we never came to a clear conclusion on ABI in previous versions. 
However whatever we do should remain in line with the current ABI and I'm not sure this does.
We tend to call calibration offsets calibbias (though the reasons are probably lost the mists
of time). 

Let's see if I can work out what these actually are.

LO stands for Local Oscillator and is effectively one of the inputs to the device (mixed
with the baseband to produce the output).  Device doing either single side band, or Quadrature
modulation.

This particular tweak is a trick to remove dc offsets in the internal mixer or coupling
across different signals. (CARRIER FEEDTHROUGH NULLING) page 26 of the datasheet.

So what do we call these.  Question 1, are they on the input or the output?  Kind of in the middle
so even that part isn't obvious.  I'd argue they are effectively on the input signal but could
be persuaded that wasn't true.  They also only apply in Single side band (IF) mode...

So if we define the device as having LO band baseband inputs, then we'd have the following.
(some of these we won't actually expose as there aren't any controls on them)

in_altvoltage0 -.. positive LO input.
in_altvoltage1 -.. negative LO input.
in_altvoltage0-1 .. LO input
/* For quadrature modulation */
in_altvoltage2 - .. I_P positive baseband input to be modulated as I
in_altvoltage3 - .. I_N negative baseband input to be modulated as I
in_altvoltage2-3 -  The differential baseband input to be modulated as I.

in_altvoltage4 - .. Q_P positive baseband input to be modulated as Q
in_altvoltage5 - .. Q_N negative baseband input to be modulated as Q
in_altvoltage4-5 - The differential baseband input to be modulated as I.

/* In Single Side Band IF Mode */
in_altvoltage2 - .. IF_I Single Side band signal modulated as I
in_altvoltage3 - .. IF_Q Single Side band signal modulated as Q

In all cases output would be only one as there is only one pin.
 
out_voltage0

Now we can't have differential channels with I and Q without cheating
and using ext_info instead of the auto created elements, however the intent
is to keep the naming convention inline with what we will have should
we ever extend IIO to separate channel2 uses.  The LO vs IF vs I can be sensibly
handled with channel labels I think rather than adding even more info to the
naming.

So my reading of the datasheet suggests we should have something like

This is messy because we have two uses of the single input - one for I and one for Q.
in_altvoltage0_q_calibbias - LO feedthrough Q offset on positive side. 
in_altvotlage1_q_calibbias - LO feedthrough Q offset on negative side.
in_altvoltage0_n_calibbias - LO feedthrough N offset on positive side.
in_altvoltage1_n_calibbias - LO feedhtrough N offset on negative side.

These next two are awkwards as they are phase shifts of a differential channel after
using it to generate the internal LO_Q and LO_N signals.
in_altvoltage0-1_q_phase - LO path quadrature Q phase shift
in_altvoltate0-1_n_phase - LO path quadrature N phase shift

Slightly amusingly there aren't any obvious things to hang on an output channel
except for the envelope detector if that's wired somewhere useful and maybe the
VVA temperature compensation or the two Voltage Control Variable Attenuators
if you expose those as being wired up to regulators so we can know their voltage
and hence the output scaling.

Jonathan




