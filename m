Return-Path: <linux-iio+bounces-8541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA45295584C
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841B4282942
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC3814F9EE;
	Sat, 17 Aug 2024 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBzkbAoV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129E3A1C4;
	Sat, 17 Aug 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723904237; cv=none; b=E5RKikERLZGO1lb1raZO6UtFNcElscPmUX9FaXOZ0Ns2vjXtBj3uIJ02oHAvPFUM3YCoFj7ZmTfXaGxBZ9J3CGXMFIwn5JCdEgwlKZ0AlFVIbKOh0M1VmXafRs5bhd0Sx9YfdY1Q2jMyRyy/Y2B8i5LfGiUsEN7LMO1x1/zzLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723904237; c=relaxed/simple;
	bh=EMFKqh6oOCptzNQmGT3Z2OQrYlAQ40cUxslKmBydrzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5HleDfnDeX0XodKY6yxUAUonI4ivMDPRHItd0xijc9jzVlEDwGoxZT63GgbEwdquM93aqD5UhVhR3m73LFmdJFjIEkKyGrOd8+Drw3NxSEpi1NLjjqy85+U++q4I0ATDMndY0Or8zf1u0orcGr9C1UAQpbMBKKNxuBDtuLFV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBzkbAoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A190C116B1;
	Sat, 17 Aug 2024 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723904236;
	bh=EMFKqh6oOCptzNQmGT3Z2OQrYlAQ40cUxslKmBydrzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DBzkbAoVBtKEu03E64n16ADQx1juK+lu6I9BkzosJ0/adV36WOgncD2oWs8HCKR8j
	 rjhtgB+hGioj9sq3/zbI2gB7UnDw2sWynHA7Yk4imod4quM7N9acaG0qxQMtXcw/F9
	 v5RSCOoq/EHiPygKOJBgf9EymeddGrRLFbpomBzbQOAwPyKZD9EnwsR6tZcPknDM67
	 ulRZkiRtnuN8qREqy6O7uHMGO/wBCfysHHEZ1OT3LlPGL+6Rc/+P9oOI4aY4+/xI8P
	 nQerUrCFh8sIJkCoMXH3lGMHGrQ5xELYAD9HLz6IV4q2ym69KBAD7QWHcdh+PXeqbR
	 gqSJc3YORx0KQ==
Date: Sat, 17 Aug 2024 15:17:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: adc: ad4695: implement triggered buffer
Message-ID: <20240817151709.7aa1bf1a@jic23-huawei>
In-Reply-To: <20240813-iio-adc-ad4695-buffered-read-v2-0-9bb19fc1924b@baylibre.com>
References: <20240813-iio-adc-ad4695-buffered-read-v2-0-9bb19fc1924b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 12:26:39 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This is a fairly simple series that adds support for triggered buffers
> to the ad4695 driver.
> 
> Not directly related to this patch, but as a side discussion about
> future possibilities with this chip while we are here...
> 
> The advanced sequencer on this chip can repeat the same channel multiple
> times which, when combined with the autocycle feature, can be used to
> create different effective sampling rates for individual channels.
> 
> For example if we set up the sequence [IN1, IN2, IN1, IN3] and the time
> between each individual sample in the sequence is the same, then IN1 has
> an effective sampling rate of 2x the other channels.
> 
> Have there ever been discussions before about implementing something
> like this in the IIO subsystem? I didn't see anything that looked like
> this already implemented in the kernel.

Yes.  There has been discussion in the past, but it's hard to define
an ABI around so we have either given up, or had the driver unwind the
data flow into multiple buffers.  There are some IMUs that do tagged
data in their hardware fifos and you can configure the sampling frequencies
for sets of channels independently.

So you get

1 tag_accel :  accel_x accel_y accel_z
2 tag_accel :  accel_x accel_y accel_z
3 tag_magn : magn_x, magn_y magn_z
4 tag_accel :  accel_x accel_y accel_z
5 tag_accel :  accel_x accel_y accel_z
6 tag_magn : magn_x, magn_y magn_z
7 tag_accel : accel_x accel_y accel_z

The driver then pushes to multiple buffers.

accel_buffer:
1 tag_accel :  accel_x accel_y accel_z
2 tag_accel :  accel_x accel_y accel_z
4 tag_accel :  accel_x accel_y accel_z
5 tag_accel :  accel_x accel_y accel_z
7 tag_accel : accel_x accel_y accel_z

magn_buffer: 
3 tag_magn : magn_x, magn_y magn_z
6 tag_magn : magn_x, magn_y magn_z

etc.

See imu/st_lsm6dsx/st_lsm6dsx_buffer.c
and st_lsm6dsx_push_tagged_data()

I think we discussed more complex setups where channels could be offered
for different buffers, each with own sampling rate and the driver (note not
the IIO core) would try to unwind what you'd asked for into each buffer +
figure out how to configure the device.  Don't think that got implemented
though as the simple multibuffer solution was enough. 

Note this predated per iio_dev multiple buffer support so it was done with additional
IIO devices.

Otherwise we do have option to do repeat scan types. That works for
IN0 IN0 IN0 IN0 IN1 IN0 IN0 IN0 IN0 IN1 IN0 etc

That is really meant for multi value channels - e.g. quarternions where
a single value on it's own is meaningless (you need the scaling across
all 4 elements).

Jonathan

> 
> ---
> Changes in v2:
> v2 changes:
> * Don't error when only temperature channel is enabled, just add extra
>   xfer instead.
> * Drop use of reg/mask/val local variables.
> * Use struct initializer for xfer in ad4695_exit_conversion_mode().
> * Simplify return at end ad4695_buffer_preenable().
> * Use t_ACQ instead of t_CNVL to ensure proper acquisition time.
> * The temperature channel changes weren't quite trivial, so I didn't
>   pick up Nuno's Reviewed-by.
> * Link to v1: https://lore.kernel.org/r/20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com
> 
> ---
> David Lechner (2):
>       iio: adc: ad4695: implement triggered buffer
>       doc: iio: ad4695: document buffered read
> 
>  Documentation/iio/ad4695.rst |   9 +-
>  drivers/iio/adc/ad4695.c     | 250 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 255 insertions(+), 4 deletions(-)
> ---
> base-commit: d505a9dc8de83df2a8ce8c9e780f7b29887f34af
> change-id: 20240807-iio-adc-ad4695-buffered-read-f49eb511e300
> 
> Best regards,


