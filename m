Return-Path: <linux-iio+bounces-8199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD0D9469F4
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 16:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF93281A01
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FE41509B4;
	Sat,  3 Aug 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUIIn+02"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D51509A2;
	Sat,  3 Aug 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722693603; cv=none; b=rJY2ugp1l49DZ8ez/hrmPAJQesR+WK9HrjWtvUA2AJS2DMa/4j4f7Di54gIbObZaSuxM/yWPGk2AV3WpC8FBHzEgEiUqVcsvqwW3lY8irYzr5DOM7mFJd6O57ZTj5iuAdgVcfEXQHgyfLVQ2ikBtH9NocifgQHRFtNdhFAdtoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722693603; c=relaxed/simple;
	bh=WkWZa+0mangtTlCr2epe0OP1425q3NQWizY05UhJpVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gk63lXyEBM7aVGFAj2DIn87MNeOCuaHRnHbatZuaHwbKhBb7nxmUbxF1Bqaz69dc2MRtnuBF0mvrbJS99mFgDyIqjFIqJsA+qlfVGDrXurSKcBK0XcQN6zrDWLqBl+k1Dqgzhu4x+7hzRvuUPvftSuZqURZTWR0l+cIXIJuOM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUIIn+02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBCDC116B1;
	Sat,  3 Aug 2024 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722693602;
	bh=WkWZa+0mangtTlCr2epe0OP1425q3NQWizY05UhJpVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UUIIn+02+0vQusls/kCfanFrNSWK1+G005GqUNlL+IV4AJHfR34Q2GfSfQiR/hxg3
	 7VrlzESiVntb1/DDpHPvWzyL4paEo79J2UZ0ytSqyKmx39MEnuPS8GFTQbEdv6SPCH
	 qiYGUkH+1iDwyN1UqcF0mrp9TDU1Bx6ZaoJvfpcwScoZaOPzuscpmQDqCrrGa/4MzL
	 ZDAQugm+IuNYY4Kd/J0V4rrQmT006UT2B14qtftweURgiPvolbMxi1ZOYCvU8Yvrbl
	 KUlZXnrging/nh3xNSyegICvlXUp2aUGY3P32mUCHGhFYtugMpbRk/fNwfHbsqAaCr
	 RgqY9MmtMBncw==
Date: Sat, 3 Aug 2024 14:59:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Replaced IIO_INTENSITY channel with IIO_LIGHT
Message-ID: <20240803145956.2562ad71@jic23-huawei>
In-Reply-To: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
References: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 12:07:02 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Hello,
> 
Don't change the cover letter title between versions.
It makes them hard to track.  That title should not reflect changes
form previous version and it should always tell us which driver
the modifications are being made to!

> The first patch in the series adds support for configuring the gain and
> resolution(integration time) of the ltr390 sensor by writing to the
> respective registers. Then the available values for gain and resolution
> that are listed in the datasheet are provided via the `read_avail`
> callback. 
> 
> The second patch adds a new channel for the ALS feature of the sensor.
> The same configuration of gain and resolution has to be provided for this
> channel as well. As there are two IIO channels now, we would need to
> switch the sensor's mode of operation depending on which sensor is being
> accessed. Hence, mode switching is also provided.
> 
> Then the third patch adds support for calculating `counts_per_uvi` based
> on the current gain and resolution value.
> 
> Changes in v5:
> - Replaced the IIO_INTENSITY channel with IIO_LIGHT channel
> - We calculate the lux value directly using `als_data / (gain * int_time)`
> - Provided a scale channel where the scale is 0.6 * WINDOW_FACTOR
> - Link to v4: https://lore.kernel.org/linux-iio/20240730065822.5707-1-abhashkumarjha123@gmail.com/T/#m
> 
> Changes in v4:
> - Added "bitfield.h" include to fix `-Wimplicit-function-declaration`.
> - Link to v3: https://lore.kernel.org/linux-iio/20240729115056.355466-1-abhashkumarjha123@gmail.com/
> 
> Changes in v3:
> - Added cover letter to the patch series.
> - Fixed indentation in the patch description.
> - Patch specific changes are listed below.
> 
> [PATCH v3 1/3]
> 	- Cleaned up the spurious changes made in v2.
> 	- ltr390_set_int_time and ltr390_set_gain now return -EINVAL to
> 	indicate no match.
> 
> [PATCH v3 2/3]
> 	- Used enum ltr390_mode inside the ltr390_data struct.
> 	- Refactored `ltr390_set_mode` function according to the comments in v2.
> 
> [PATCH v3 3/3]
> 	- Simplified the formula for `counts_per_uvi` calculation.
> 	- Removed spurious whitespace changes introduced in v2.
> 
> - Link to v2: https://lore.kernel.org/linux-iio/20240728151957.310237-1-abhashkumarjha123@gmail.com/
> 
> Changes in v2:
> - Split the single patch into 3 patches.
> - Used FIELD_PREP to perform bit shifting.
> - Used enum for mode selection instead of defines.
> - Fixed indentation and whitespace issues pointed out in the comments
> - Replaced `mutex_lock(&data->lock)` with `guard(mutex)(&data->lock)`
> - Provided available values for gain and resolution via `read_avail`
>   instead of sysfs attributes.
> - Refactored `ltr390_set_gain` and `ltr390_set_int_time`.
> - Used early returns instead of single exit points.
> 
> - Link to v1: https://lore.kernel.org/linux-iio/20240718104947.7384-1-abhashkumarjha123@gmail.com/
> 
> Regards,
> Abhash
> 
> Abhash Jha (3):
>   iio: light: ltr390: Add configurable gain and resolution
>   iio: light: ltr390: Add ALS channel and support for gain and
>     resolution
>   iio: light: ltr390: Calculate 'counts_per_uvi' dynamically
> 
>  drivers/iio/light/ltr390.c | 238 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 220 insertions(+), 18 deletions(-)
> 


