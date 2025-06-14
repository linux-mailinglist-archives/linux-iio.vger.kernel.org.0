Return-Path: <linux-iio+bounces-20661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C478AD9D6B
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 16:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444EC3B74FC
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7F2D9EDB;
	Sat, 14 Jun 2025 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0I+Klij"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81EE70808;
	Sat, 14 Jun 2025 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749910631; cv=none; b=V7v1BcQf619ZtLFiXYCIDda6LBQFm6b94qcV8RUCGkY/U1YZJhGaC6yhQXXNXldMlIlrIwTbL6jbUmtBiOZDosHyybu3rmwDtlXNgf939qA0ctyoktXPzqJIGmJsDm6/OKAG4m299q0GlcLEWqb0K4EyUTfHz6Va4Vx31nvhDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749910631; c=relaxed/simple;
	bh=Bjaf1tdbvAELd6/YZ7q3IKeF7gZ5dfUUOgR/rJG4v2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkk9nssG7D3LZ0NZl9KSC0lMzeiqt7hm20eFb/AOskqefo08XtRqrhk//MGXZVqeSgxtEYJC+3AbDO7DkGxXnTXYcfR4qlRNxL2POzNrzkHzw+yvsEv7k4k6Tw9k9qDcdyvx0Z8/X7iFGJozdJ4wrcDU8CBIGE0xJjqhhF5H0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0I+Klij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F81C4CEEE;
	Sat, 14 Jun 2025 14:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749910630;
	bh=Bjaf1tdbvAELd6/YZ7q3IKeF7gZ5dfUUOgR/rJG4v2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u0I+KlijanW87g35dfr0coFfXQmPh/xMlKuSXjDTJ5QBgBtXF4nztj7GQdpsLQyvW
	 GgkzGroheCKy0kum23iHX+G24pRB362tVsQ5lBe9TdWfm2+1/N0MaI7WegVvLz9U27
	 jRNS6sZFv065F7en3tf0qRHTzbQ7aXUx1b8DQwnMLyX6BW7L46U/5XprQiOj1zDRlN
	 qtEQnTBzByVd8Glp79ZQ9oyTg4Q31SBYo/WAt0X9BQhvGiP13hAv+9ApdV9CgAFTcv
	 bY7+ItsHybMKtHTUhyeRJ1FKO86JULPfDI4B4TapC5NZdbq32zrFMT1SHaRQISY6TB
	 lPPD04J5cyetg==
Date: Sat, 14 Jun 2025 15:17:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 11/11] docs: iio: add documentation for adxl345
 driver
Message-ID: <20250614151703.047e83fe@jic23-huawei>
In-Reply-To: <20250610215933.84795-12-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-12-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 21:59:33 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The documentation describes the ADXL345 driver, IIO interface,
> interface usage and configuration.

Trivial but wrap commit descriptions at 75 chars.

The main comment on this is that, when talking about datasheet terms / settings
etc it would be good to reflect them back to the IIO controls that actually allow
us to change them.

Otherwise seems reasonable to me.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>


> +
> +Sensor Events
> +-------------
> +
> +Particular IIO events will be triggered by the corresponding interrupts. The
> +sensor driver supports no or one active INT line, where the sensor has two
> +possible INT IOs. Configure the used INT line in the devicetree. If no INT line
> +is configured, the sensor falls back to FIFO bypass mode and no events are
> +possible, only X, Y and Z axis measurements are possible.
> +
> +The following table shows the ADXL345 related device files, found in the
> +specific device folder path ``/sys/bus/iio/devices/iio:deviceX/events``.
> +Note, the default activity/inactivity is DC coupled. Thus only AC coupled
> +activity and inactivity are mentioned explicitly.

This paragraph probably wants to talk about the mapping of AC coupled to 'adaptive'
I couldn't relate it directly to the table without that.

> +
> ++---------------------------------------------+---------------------------------------------+
> +| Event handle                                | Description                                 |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_gesture_doubletap_en               | Enable double tap detection on all axis     |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_gesture_doubletap_reset_timeout    | Double tap window in [us]                   |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_gesture_doubletap_tap2_min_delay   | Double tap latent in [us]                   |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_gesture_singletap_timeout          | Single tap duration in [us]                 |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_gesture_singletap_value            | Single tap threshold value in 62.5/LSB      |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_mag_falling_period                 | Inactivity time in seconds                  |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_mag_falling_value                  | Inactivity threshold value in 62.5/LSB      |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_mag_adaptive_rising_en             | Enable AC coupled activity on X axis        |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_mag_adaptive_falling_period        | AC coupled inactivity time in seconds       |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_mag_adaptive_falling_value         | AC coupled inactivity threshold in 62.5/LSB |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_mag_adaptive_rising_value          | AC coupled activity threshold in 62.5/LSB   |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_mag_rising_en                      | Enable activity detection on X axis         |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_mag_rising_value                   | Activity threshold value in 62.5/LSB        |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_x_gesture_singletap_en             | Enable single tap detection on X axis       |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_x&y&z_mag_falling_en               | Enable inactivity detection on all axis     |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_x&y&z_mag_adaptive_falling_en      | Enable AC coupled inactivity on all axis    |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_y_gesture_singletap_en             | Enable single tap detection on Y axis       |
> ++---------------------------------------------+---------------------------------------------+
> +| in_accel_z_gesture_singletap_en             | Enable single tap detection on Z axis       |
> ++---------------------------------------------+---------------------------------------------+
> +
> +Find a detailed description of a particular functionality in the sensor
> +datasheet.
> +
> +Setting the **ODR** explicitly will result in estimated adjusted default values

Say how to set ODR etc in IIO terms as well perhaps?

> +for the inactivity time detection, where higher frequencies shall default to
> +longer wait periods, and vice versa. It is also possible to explicitly
> +configure inactivity wait times, if the defaulting approach does not match
> +application requirements. Setting 0 here, will fall back to default setting.

I'm not particularly keen on that 0 aspect as it's unintuitive.  Why do we need
a means to go back to the default? 

> +
> +The **g range** configuration also tries to estimate activity and inactivity
> +thresholds when switching to another g range. The default range will be
> +factorized by the relation of old range divided by new range. The value never
> +becomes 0 and will be at least 1 and at most 255 i.e. 62.5g/LSB according to
> +the datasheet. Nevertheless activity and inactivity thresholds can be
> +overwritten by explicit values.

