Return-Path: <linux-iio+bounces-8798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D692795EF26
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9387C289D77
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29601547C5;
	Mon, 26 Aug 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8oqnuog"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D214153BF7;
	Mon, 26 Aug 2024 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669776; cv=none; b=txvqu9S+fL+ltOtHbLFQmj0CZBm+GkDQQ7Wqq3/vkRpSUagHlByzcNFGEuEXwyWWOsjYGMW242J6vxuZMnrnUaXbsH6sA6e2FQPsPCHUaSUmIATvlchqh0Gasi6dvAfC8ipfna0pSq2ExgIxKBW43T4wqQNE+yxcwSTbg1LSOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669776; c=relaxed/simple;
	bh=ClPeBht/T7EmYVNmoSEnlwqB3+kAovTzL7N5mb9DiDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/1frAU8u7F9StumUFbA91nXMxQ3Qy5XB2Ae5Ohixmh3aasZxx5lpJmiUW6toYaUNHlNOuBBwQu7yGZDeQYi3eOa8MWStOQqoOz7PjDnDWTgTSYjktecmriykJ408IdZzBGGjeQNaV46tDU1h61ykjBUPXviWlgbbgq1SSJUvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8oqnuog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BDDC4FF6F;
	Mon, 26 Aug 2024 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724669776;
	bh=ClPeBht/T7EmYVNmoSEnlwqB3+kAovTzL7N5mb9DiDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y8oqnuogSYGfFGVE7kY0uP+UjQ5+Ju7Ir/46b7MWBR0HcD4YcGBci2wjAe3vBdhVi
	 uH6LxnMMu4oW4jeqYwnHCqfN0WWJikvbCTuQTq81oFnylopCXhAnOdZeUrRyY1mbjv
	 a/5JNeBuZR/f47u0YoO/kVy8S48QxUMMzMy46zcCdFWL0Lsxo0u4Twp4W01De30IHI
	 PlZVlmY/GJO/RsvHOulwfo5mB7pD1LTJGYx80xMs7N1L4OKcH2SBuxDizL6855jTtT
	 XLrh6GRAd00wAmPUXZVYiywexnPjq/w7J2WMI6UTLo+EFw5/r8Zo2hxjFvCVqNp5D1
	 B3L2zZPOHrRgQ==
Date: Mon, 26 Aug 2024 11:56:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] iio: dac: ad5449: drop support for platform data
Message-ID: <20240826115605.40a53c35@jic23-huawei>
In-Reply-To: <20240817123210.04b3c2f8@jic23-huawei>
References: <20240814092629.9862-1-brgl@bgdev.pl>
	<20240817123210.04b3c2f8@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Aug 2024 12:32:10 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 14 Aug 2024 11:26:29 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > There are no longer any users of the platform data struct. Remove
> > support for it from the driver.
> > 
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>  
> 
> I'm fine with this but want an ADI ack.
Well no one screamed no, which probably means anyone seeing the patch
title was fine with the concept and didn't open the thread :)
(or given time of year, they are all on holiday!)

Anyhow, applied.  If it turns out it's still needed I might revert
on request.

Jonathan

> 
> Jonathan
> 
> > ---
> >  drivers/iio/dac/ad5449.c             | 15 ++---------
> >  include/linux/platform_data/ad5449.h | 39 ----------------------------
> >  2 files changed, 2 insertions(+), 52 deletions(-)
> >  delete mode 100644 include/linux/platform_data/ad5449.h
> > 
> > diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
> > index 4572d6f49275..953fcfa2110b 100644
> > --- a/drivers/iio/dac/ad5449.c
> > +++ b/drivers/iio/dac/ad5449.c
> > @@ -20,8 +20,6 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  
> > -#include <linux/platform_data/ad5449.h>
> > -
> >  #define AD5449_MAX_CHANNELS		2
> >  #define AD5449_MAX_VREFS		2
> >  
> > @@ -268,7 +266,6 @@ static const char *ad5449_vref_name(struct ad5449 *st, int n)
> >  
> >  static int ad5449_spi_probe(struct spi_device *spi)
> >  {
> > -	struct ad5449_platform_data *pdata = spi->dev.platform_data;
> >  	const struct spi_device_id *id = spi_get_device_id(spi);
> >  	struct iio_dev *indio_dev;
> >  	struct ad5449 *st;
> > @@ -306,16 +303,8 @@ static int ad5449_spi_probe(struct spi_device *spi)
> >  	mutex_init(&st->lock);
> >  
> >  	if (st->chip_info->has_ctrl) {
> > -		unsigned int ctrl = 0x00;
> > -		if (pdata) {
> > -			if (pdata->hardware_clear_to_midscale)
> > -				ctrl |= AD5449_CTRL_HCLR_TO_MIDSCALE;
> > -			ctrl |= pdata->sdo_mode << AD5449_CTRL_SDO_OFFSET;
> > -			st->has_sdo = pdata->sdo_mode != AD5449_SDO_DISABLED;
> > -		} else {
> > -			st->has_sdo = true;
> > -		}
> > -		ad5449_write(indio_dev, AD5449_CMD_CTRL, ctrl);
> > +		st->has_sdo = true;
> > +		ad5449_write(indio_dev, AD5449_CMD_CTRL, 0x0);
> >  	}
> >  
> >  	ret = iio_device_register(indio_dev);
> > diff --git a/include/linux/platform_data/ad5449.h b/include/linux/platform_data/ad5449.h
> > deleted file mode 100644
> > index d687ef5726c2..000000000000
> > --- a/include/linux/platform_data/ad5449.h
> > +++ /dev/null
> > @@ -1,39 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0-only */
> > -/*
> > - * AD5415, AD5426, AD5429, AD5432, AD5439, AD5443, AD5449 Digital to Analog
> > - * Converter driver.
> > - *
> > - * Copyright 2012 Analog Devices Inc.
> > - *  Author: Lars-Peter Clausen <lars@metafoo.de>
> > - */
> > -
> > -#ifndef __LINUX_PLATFORM_DATA_AD5449_H__
> > -#define __LINUX_PLATFORM_DATA_AD5449_H__
> > -
> > -/**
> > - * enum ad5449_sdo_mode - AD5449 SDO pin configuration
> > - * @AD5449_SDO_DRIVE_FULL: Drive the SDO pin with full strength.
> > - * @AD5449_SDO_DRIVE_WEAK: Drive the SDO pin with not full strength.
> > - * @AD5449_SDO_OPEN_DRAIN: Operate the SDO pin in open-drain mode.
> > - * @AD5449_SDO_DISABLED: Disable the SDO pin, in this mode it is not possible to
> > - *			read back from the device.
> > - */
> > -enum ad5449_sdo_mode {
> > -	AD5449_SDO_DRIVE_FULL = 0x0,
> > -	AD5449_SDO_DRIVE_WEAK = 0x1,
> > -	AD5449_SDO_OPEN_DRAIN = 0x2,
> > -	AD5449_SDO_DISABLED = 0x3,
> > -};
> > -
> > -/**
> > - * struct ad5449_platform_data - Platform data for the ad5449 DAC driver
> > - * @sdo_mode: SDO pin mode
> > - * @hardware_clear_to_midscale: Whether asserting the hardware CLR pin sets the
> > - *			outputs to midscale (true) or to zero scale(false).
> > - */
> > -struct ad5449_platform_data {
> > -	enum ad5449_sdo_mode sdo_mode;
> > -	bool hardware_clear_to_midscale;
> > -};
> > -
> > -#endif  
> 
> 


