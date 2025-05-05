Return-Path: <linux-iio+bounces-19149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC3DAA9C39
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161D11A8087E
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3E264FB1;
	Mon,  5 May 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUoJgtXf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E3F19CC22;
	Mon,  5 May 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471976; cv=none; b=mMCXe7/a77tRFMBBdM58CZoflWY4f6MPbxqCFc4846QgXbkNbdlbpG+o+kcvSus1m8YRk2TJ4EyibJEERPpHlywEVc1XRpTgQQJoOvlWaLC7JqgXL6Ynptr8nppWNCu7ikWNyJtWMEgCcoFsRBzfj5IYeOjJ2MvV6i8EQgzK518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471976; c=relaxed/simple;
	bh=/7mJu71F9OPyCt3Jag+oX7HWwGl4CM36nTfBEKaElr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBn5b01MdD/1X7bWgwpLwTk48HqvFjK8IQTQtbepCYtyLc78+pwXp/sBJlNwgadSgDIYgt9/6xRj273VgBrti9or37+rKJ53JGhfMjsATUIcPk7tegPRwfw99D7Hs3TuxPBB2cBw7bIKy1E25eiZGIGNpR0KZns8qTC2PMkU9vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUoJgtXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3F7C4CEE4;
	Mon,  5 May 2025 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746471976;
	bh=/7mJu71F9OPyCt3Jag+oX7HWwGl4CM36nTfBEKaElr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VUoJgtXfObLp5LOa1MVeFicX7WuEyhjTB+lxlg4JSYcnjzi5gb8iYtI+K1U6qkKIU
	 t1PRf+Y5sx0DH1Puvmyrs6Bh59l8deZbB9kDuKUtcFAD3+qw+GolCCSpZg/8S01Pis
	 Owmne4M3vHB+dp24XrvfufF/R5rLkH6LbkytpMmxxIoHDSuk8B7963097/LZOhQzwp
	 XGskixd5BdbZ/eZMcJl3Dfm/JNvzLF+uErEeOjopz8bUeJO2vSdfne8rSFgNz9XO2N
	 HIHS2F9FXi1ezu+t6jDfxLAcVA+HbHOgQcdMLmXa2XR4u6PXPq9sLw0KJ1utcUuxrL
	 JQqElDHJcVIzg==
Date: Mon, 5 May 2025 20:06:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v1 1/3] docs: iio: imu: smi330: Add ABI documentation
Message-ID: <20250505200609.54756520@jic23-huawei>
In-Reply-To: <20250505151641.52878-2-Jianping.Shen@de.bosch.com>
References: <20250505151641.52878-1-Jianping.Shen@de.bosch.com>
	<20250505151641.52878-2-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 May 2025 17:16:39 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: Jianping Shen <Jianping.Shen@de.bosch.com>
> 
> Add ABI documentation for Bosch imu smi330.

The general rule is that new ABI is unused ABI so we need to think
hard about whether these can be mapped to existing userspace ABI.

Some of the complexity here is for features I'd not expect to even
see in an initial driver submission.  The current code is more or
less unreviewable because is too large. Please strip it back to 
a more minimal initial driver that we can review and then added
features that can be reviewed as incremental changes.  I have no idea
when I'll have time to review a 3312 line driver - might be a few weeks
at least.

For an initial driver I'd remove all the ALT function stuff. That can
come later when we have the basic driver merged.

what to do in each patch of building up the driver depends a bit on
driver complexity but a common pattern would be something like this
(order varies)

1) Dt-binding. This needs to be as complete as possible.
2) Basic driver - sysfs only access to standard ABI.
3) Buffered support
4) Event support (often this comes in a lot of steps for a complex device)
5) Power management support
6) Features that require new ABI.

Aim for each patch / series being fairly short.  < 1000ish lines
of code is a fairly hard rule unless it's lots of register defines
or similar easy to review stuff.

< 400 lines or so for other changes. 

Complex code needs to be in even smaller chunks.  The aim here is to
make good use of reviewer time when they can't get half a day or more
to try and look at a massive single patch.

Note that none of this is a comment on the actual code, just on
how to make it simpler to get a complex device supported upstream.

There are quite a few other drivers undergoing slow feature growth
at the moment across multiple kernel cycles (mostly ADCs right now
but we did this for many of the more complex IMUs in the past).
This is a common situation.

Thanks,

Jonathan


> 
> Signed-off-by: Jianping Shen <Jianping.Shen@de.bosch.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-smi330          | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-smi330
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-smi330 b/Documentation/ABI/testing/sysfs-bus-iio-smi330
> new file mode 100644
> index 00000000000..68220926beb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-smi330
> @@ -0,0 +1,149 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/events/self_cal
> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		The device offers self-calibration for the gyroscope sensitivity error and the gyroscope offset. 
wrap to 80 chars.

> +		self-calibration to reduce the gyroscope sensitivity error is also known as component re-trim (CRT).
> +		The self-calibration ABI will run the calibration routine and update the data path registers in the device.
> +		Before initiating the self-calibration, the accelerometer is required to be enabled in high performance
> +		mode with a sample rate preferred in the range of 25 Hz up to 200 Hz and the alternative sensor
> +		configurations for accelerometer and gyroscope must be disabled.
> +		If these preconditions are not fulfilled, the driver will make sure they are fulfilled by changing appropriate 
> +		register values and then restore the configuration after the self-calibration has been performed.
Given this is all invisible outside of the driver, the need to save an restore settings does
not need to be mentioned in the ABI docs.

We normally don't expose this sort of calibration routine to userspace as it is highly disruptive and
we need to block it if anything else is going on.  The solution is to run it once at driver
bind.  Similar to reset below, if the usecase needs to re do it then unbinding and rebinding
the driver reflects the fact we are taking it effectively offline for a while.


> +		The self-calibration can be triggered by writing '1' to the sysfs entry.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/self_test
> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		The self-test of the device checks for a correct function of the accelerometer as well as the gyroscope. 
> +		The execution of the self-test expects the following prerequisites to be fulfilled. 
> +		For the self-test, the accelerometer must be configured to high performance mode at least, and the
> +		alternative sensor configurations for accelerometer and gyroscope must be disabled. If these preconditions 
> +		are not fulfilled, the driver will make sure they are fulfilled by changing appropriate register values 
> +		and then restore the configuration after the self-test has been performed.
> +		Once a self test is initiated, the output of data of the device to the registers and FIFO data buffer 
> +		as well as all features are disabled. While the self-test is in progress, the host is not allowed to modify 
> +		the configuration of the device.

Similar to above in that there is too much info here and typically we do this as well on
driver bind - not on demand because it is highly disruptive as you note.

> +		The self-test can be triggered by writing '1' to the sysfs entry.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/soft_reset
> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		The softreset performs a fundamental reset to the device which is largely equivalent to a power cycle. 
> + 		Following a delay, all user configuration settings are overwritten with their default state wherever applicable. 
> + 		To access the serial interface after a soft reset, the same timing constraints apply as for power on.
> + 		The soft-reset can be triggered by writing '1' to the sysfs entry.

Usual time we do a soft reset is on driver probe. If it needs to be controlled from
userspace later, a driver unbind and bind will have the same effect.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/control_auto_op_mode
> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		The auto-operation mode change is a built-in feature to support the smart power management of the device. 
> +		The function provides automatic switching among two sets of operation modes for its accelerometer and gyroscope. 
> +		In the following, the one set of configurations consists of ACC_CONF and GYR_CONF for the accelerometer and gyroscope 
> +		and is called user configuration. The other set sensor of configurations consists of ALT_ACC_CONF and ALT_GYR_CONF, 
> +		and is called alternative configuration. The switching is initiated by events of enabled advanced features 
> +		or by commands sent from the host to switch from alternative configuration to user configuration.

A lot of device specific detail the user doesn't need to know about.
I assume this boils down to a form of runtime power management?  Wire it up to that
power management infrastructure. If people don't want it they can disable
runtime PM and pay the power cost.

Seems unlikely to me that anyone will be interested in only doing it for
one or other sensor, so a single runtime pm standard control is probably
sufficient.  Runtime PM is an advanced feature though so may not belong
in the 'initial' driver submission.

As the next attribute shows it can be triggered by other things.


> +		The advanced feature engine and interrupts must be enabled for the auto-operation mode to take effect. 
> +		Available options:
> +		0 - Enables switching possiblility to alternate configuration for accelerometer
> +		1 - Enables switching possiblility to alternate configuration for gyroscope
> +		2 - Enables switching possiblility to alternate configuration for accelerometer and gyroscope
> +		3 - Disables auto-operation mode change
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/set_auto_op_mode_cond
> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		The conditions to switch operation mode must be configured by selecting one of the advanced features 
> +		that will trigger the auto-operation mode change. 
> +		The same advanced feature cannot be selected as a trigger for both user configuration and alternative configuration.
> +		Available options:
> +		0 - Change to user settings by A_NO_MOTION
> +		1 - Change to user settings by A_ANY_MOTION
> +		2 - Change to user settings by H_TILT_DETECTION
> +		3 - Change to alternative settings by A_NO_MOTION
> +		4 - Change to alternative settings by A_ANY_MOTION
> +		5 - Change to alternative settings by H_TILT_DETECTION

Ok. This is an interesting feature.  However it is also an advanced feature
that probably doesn't belong in an initial driver submission where it will
just slow down the chances of anything getting merged. I'd drop this
support and ABI for now.  I'm not immediately sure how we would control
it but the ABI will need to be a closer fit for existing ABI than this is.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/config_user_overwrite
> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		The configurations of the sensors can be instantly reset to the user configuration by directly writing 
> +		to either ACC_CONF or GYR_CONF, if the option is enabled.
> +		Available options:
> +		0 - No mode change when writing to ACC_CONF or GYR_CONF
> +		1 - Any write to ACC_CONF or GYR_CONF will instanly switch back to associated user configuration
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/alt_status
> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		Reports the active configuration for the accelerometer and gyroscope.
> +		Available options:
> +		0x00 - ACC_CONF and GYR_CONF are used
> +		0x01 - ALT_ACC_CONF and GYR_CONF are used
> +		0x10 - ACC_CONF and ALT_GYR_CONF are used
> +		0x11 - ALT_ACC_CONF and ALT_GYR_CONF are used
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/alt_odr

For later discussion but it would need to map to something more directly
related to sampling_frequency which is the primary ABI for this.

> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		Set alternative output data rate (for accelerometer and gyroscope).
> +		Available options:

For what it is worth IIO ABI support decimals. So use them, not rounding to nearest
integer.

> +		0 - 0.78125 Hz
> +		1 - 1.5625 Hz
> +		3 - 3.125 Hz
> +		6 - 6.25 Hz
> +		12 - 12.5 Hz
> +		25 - 25 Hz
> +		50 - 50 Hz
> +		100 - 100 Hz
> +		200 - 200 Hz
> +		400 - 400 Hz
> +		800 - 800 Hz
> +		1600 - 1600 Hz
> +		3200 - 3200 Hz
> +		6400 - 6400 Hz
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/alt_acc_mode

Power modes are rarely a useful ABI because a user cares about characteristics
of those modes, not the datasheet terms for them.  They care what frequency 
or precision they get.

> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		Set alternative accelerometer power mode.
> +		Available options:
> +		0 - Suspend

Suspend is something we'd do via runtime PM or similar.  Automatically establish
when the sensor isn't being used and save some power.  Leaving it to userspace
control basically means it isn't used and the device ends up always powered up.

> +		3 - Low power
> +		4 - Normal
> +		7 - Performance
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/alt_gyr_mode
> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		Set alternative gyroscope power mode.
> +		Available options:
> +		0 - Suspend
> +		3 - Low power
> +		4 - Normal
> +		7 - Performance
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/alt_acc_avg_num
This would need to map to standard oversampling_ratio ABI.

> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		Set alternative accelerometer averaging number.
> +		Available options:
> +		1, 2, 4, 8, 16, 32, 64
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/alt_gyr_avg_num
> +KernelVersion:	6.16
> +Contact:	Stefan.Gutmann@de.bosch.com
> +Description:
> +		Set alternative gyroscope averaging number.
> +		Available options:
> +		1, 2, 4, 8, 16, 32, 64


