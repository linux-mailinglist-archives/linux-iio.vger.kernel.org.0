Return-Path: <linux-iio+bounces-15608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37806A3766F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 19:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE6F3AEE20
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845618A92D;
	Sun, 16 Feb 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIMdZms5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2625771;
	Sun, 16 Feb 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739728823; cv=none; b=oCkcI+64HIlq35ds9x54HX5DctSfoSbQNUgSZ9Y1GN9QdhxXqOoKfDRJRiJ6hKf8fwsklue4l5B7Ih/YARrHG9OWklJUVnDDnEy75zBmjMefChW+htcypPS9oGQFnGsUU0G9EpeZNIpvIN1nHClTLmA4yrvMdkEASQgw9IVT+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739728823; c=relaxed/simple;
	bh=diIO3ITDoU7AktJFiSmDVWriGSibTVn0llDzkSO25Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgx/NPUiKBDEH7IGFBw2iPNq84My2m5q9u+ProYew27sx8/jxORZHtq1aydWeP3EwOskSmd2TVtzBirNfi+zyvTqN8gUcWJQwgh8NF3F1kalett53IplhCq0ygQ/Mcad9FCvLzjnVDd5VnLLeFGD8OtXVEsEJzVsluDhJpB/5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIMdZms5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5298CC4CEDD;
	Sun, 16 Feb 2025 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739728822;
	bh=diIO3ITDoU7AktJFiSmDVWriGSibTVn0llDzkSO25Ms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NIMdZms5lWeG8dIDKm8bhY22lqDJUm2YErtH8uW7HX0OfYUkM+3+wd+4u6/ppB0iL
	 nkfff5r0uVoIZjYrTWafNvoiLaxkwcLHeHxVO36PpDPPn8J91coUcNvkG5bKJnsIa1
	 L4OUP6VHbIjcpTHKZhpUhj9B/vGNvUZ/68Jt0/ywSYM2xd7STd3g0mGpBJJN/InULV
	 YYE6xLXiQ2RL7ijUBvsNMq62SlNjFSsWk/YC1ZnUSL4WF+n+rKj1brcjV2oO9/OE+H
	 tRbLPEQ8JNdhaLK+OzQ+yU4MZStpHFEzqX5kRkiCIP+8A8zX1M13yJ5WBmdJi9szxa
	 OK51pagyYacQQ==
Date: Sun, 16 Feb 2025 18:00:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 14/14] docs: iio: add documentation for adxl345
 driver
Message-ID: <20250216180015.17787b22@jic23-huawei>
In-Reply-To: <20250210110119.260858-15-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
	<20250210110119.260858-15-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 11:01:19 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The documentation describes the ADXL345 driver, IIO interface,
> interface usage and configuration.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

I was running out of time so this was a little more superficial review than I would
have liked to have done.  I've commented on a few bits that I was confuse about in the driver.
Document is showing how useful these are :)

Jonathan

> +
> +Particular IIO events will be triggered by the corresponding interrupts. The
> +sensor driver supports no or one active INT line, where the sensor has two
> +possible INT IOs. Configure the used INT line in the devicetree. If no INT line
> +is configured, the sensor falls back to FIFO bypass mode and no events are
> +possible, only X, Y and Z axis measurements are possible.
> +
> +The following table shows the ADXL345 related device files, found in the
> +specific device folder path ``/sys/bus/iio/devices/iio:deviceX/events``.
> +
> ++---------------------------------------------+-----------------------------------------+
> +| Event handle                                | Description                             |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_gesture_doubletap_en               | Enable double tap detection on all axis |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]               |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_gesture_doubletap_suppressedbit_en | Enable double tap suppress bit          |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latent in [us]               |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_gesture_singletap_timeout          | Single tap duration in [us]             |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB  |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_mag_falling_en                     | Enable free fall detection              |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_mag_falling_period                 | Free fall time in [us]                  |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_mag_falling_value                  | Free fall threshold value in 62.5/LSB   |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_mag_referenced_falling_en          | Set 1 to couple inactivity AC, 0 for DC |

That interface doesn't work align with the normal ABI.


Should be a selection of either mag_referenced_falling_en or another event to
pick between AC and DC. I assume thresh_falling_en though i'll admit to being a little
lost in what this hardware is doing!

> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_mag_referenced_rising_en           | Set 1 to couple activity AC, 0 for DC   |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_thresh_falling_en                  | Enable inactivity detection             |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_thresh_falling_period              | Inactivity time in seconds              |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_thresh_falling_value               | Inactivity threshold value in 62.5/LSB  |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_thresh_rising_en                   | Enable activity detection               |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_thresh_rising_value                | Activity threshold value in 62.5/LSB    |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis   |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis   |
> ++---------------------------------------------+-----------------------------------------+
> +| in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis   |
> ++---------------------------------------------+-----------------------------------------+
> +
> +Find a detailed description of a particular functionality in the sensor
> +datasheet.
> +
> +Setting the ODR explicitly will result in estimated adjusted default values
> +for the inactivity time detection, where higher frequencies shall default to
> +longer wait periods, and vice versa. It is also possible to explicetly
> +configure inactivity wait times, if the defaulting approach does not match
> +application requirements. Setting 0 here, will fall back to default setting.
> +
> +The g range configuration also tries to estimate activity and inactivity
> +thresholds when switching to another g range. The default range will be
> +factorized by the relation of old range divided by new range. The value never
> +becomes 0 and will be at least 1 and at most 255 i.e. 62.5g/LSB according to
> +the datasheet. Nevertheless activity and inactivity thresholds can be
> +overwritten by explicit values.
> +
> +When activity and inactivity events are enabled, the driver automatically will
> +set link bit and autosleep bit. The link bit serially links the activity and
> +inactivity functions. 

So this is a sort of hysteresis?  We may want to describe that more directly.

> On the other side, the autosleep function switches the
> +sensor to sleep mode if the inactivity function is enabled. This will reduce
> +current consumption to the sub-12.5Hz rate.
> +
> +In dc-coupled operation, the current acceleration magnitude is compared
> +directly with THRESH_ACT and THRESH_INACT registers to determine whether
> +activity or inactivity was detected. In ac-coupled operation for activity
> +detection, the acceleration value at the start of activity detection is taken
> +as a reference value. New samples are then compared to this reference value.

That applies for activity - the inactivity description is rather more confusing.

> +
> +Single tap detection can be configured according to the datasheet by specifying
> +threshold and duration. If only the single tap is in use, the single tap
> +interrupt is triggered when the acceleration goes above threshold (i.e. DUR
> +start) and below the threshold, as long as duration is not exceeded. If single
> +tap and double tap are in use, the single tap is triggered when the doulbe tap
> +event has been either validated or invalidated.
> +
> +For double tap configure additionally window and latency in [us]. Latency
> +starts counting when the single tap goes below threshold and is a waiting
> +period, any spikes here are ignored for double tap detection. After latency,
> +the window starts. Any rise above threshold, with a consequent fall below
> +threshold within window time, rises a double tap signal when going below
> +threshold.
> +
> +A double tap event can be invalidated in three ways: If the suppress bit is set,
> +any acceleration spike above the threshold already during the latency time
> +invalidates the double tap detection immediately, i.e. during latence must not
> +occur spikes for double tap detection with suppress bit set.
> +A double tap event is invalidated if acceleration lies above the threshold at
> +the start of the window time for the double tap detection.
> +Additionally a double tap event can be invalidated if an acceleration exceeds
> +the time limit for taps, set by duration register, since also for the double
> +tap the same value for duration counts, i.e. when rising above threshold the
> +fall below threshold has to be within duration time.
> +
> +A free fall event will be detected if the signal goes below the configured
> +threshold, for the configured time [us].
> +
> +Note, that activity/inactivy, as also freefall is recommended for 12.5 Hz ODR
> +up to 400 Hz.
> +
>

