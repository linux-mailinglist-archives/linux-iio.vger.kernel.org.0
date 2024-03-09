Return-Path: <linux-iio+bounces-3406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA39387727A
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 18:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A171C21235
	for <lists+linux-iio@lfdr.de>; Sat,  9 Mar 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4AC225DA;
	Sat,  9 Mar 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwxmwtC6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899820DC3
	for <linux-iio@vger.kernel.org>; Sat,  9 Mar 2024 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710005893; cv=none; b=Osh3AGMAuB1+Ey9bMo5tHKVJyvXDVaJ8OCtZ5L2roZupnXS2Sj1FfpmblKp0zTs78Oh64VR6T5FaOi9t5bJFbac5MEFCYSB9YZ0pBvrjin8YJMgMEXh2qaYyU2Mo3w9gAae4uWJ99xZeIiHbYMRH08mOdaKjOJS6mMEPZRaDYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710005893; c=relaxed/simple;
	bh=HWuEMFKCIkgnFC73fbSBA/U+FL8rAdQpCKV5gP+o3V8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNEUXhc+yCdFO2xdMlIAG+WGEZGLqbx21ZJiCaDHnb7mfFMsqyZAFmeNugCBazBkwjDsUFblI4UZv/sW+tFj0E/ltKWACf0658YwFlKkXbs7J3XTsT5xf/jxzP4pv8HamVMJeseswfO1WbVTUx0eXbpwKo1l5Hy4BfpweNKfYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwxmwtC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E84FC433C7;
	Sat,  9 Mar 2024 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710005893;
	bh=HWuEMFKCIkgnFC73fbSBA/U+FL8rAdQpCKV5gP+o3V8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mwxmwtC68FjQckIUxMoP3KOYNeC5ThMP7LOySEj5T/rNXhb33rh3WLCyMMjLgs+ll
	 z2AH8h8YTgcdRlfgG/9h5+rqBTNL/5W8MZDP2wawxRITikKrnfixyrJkk/gMjLpwkf
	 O7Bw5LPIdyAy3FY0UCBG3Dlp0iyTG+qv088rwSVz0lWy3IoGSMnARm8lZqLvo6vdKb
	 3WYhO7JUzdZM6E1Cb/Qp1uivyw34Iv/p44xs5UNFUdQThi0dXzqYxGDdeltW59vMMQ
	 90UipGlU1y4FhW2+5ymPXxG2OKJEvip5CNx2AUtAxpw9DukvgzuR8oKsdogXq/7qjz
	 gCnPPNTFZZt2Q==
Date: Sat, 9 Mar 2024 17:38:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio: imu: inv_mpu6050: add new interrupt handler
 for WoM events
Message-ID: <20240309173801.05205880@jic23-huawei>
In-Reply-To: <FR3P281MB1757BE6895EF363ED0ABAE74CE232@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
	<20240225160027.200092-4-inv.git-commit@tdk.com>
	<20240303171013.110eddee@jic23-huawei>
	<FR3P281MB1757BE6895EF363ED0ABAE74CE232@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >>  		st->chip_config.magn_fifo_enable))
> >> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> >> index ec2398a87f45..7ffbb9e7c100 100644
> >> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> >> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> >> @@ -6,6 +6,7 @@
> >>  #include <linux/pm_runtime.h>
> >>  
> >>  #include <linux/iio/common/inv_sensors_timestamp.h>
> >> +#include <linux/iio/events.h>
> >>  
> >>  #include "inv_mpu_iio.h"
> >>  
> >> @@ -223,6 +224,52 @@ static const struct iio_trigger_ops inv_mpu_trigger_ops = {
> >>  	.set_trigger_state = &inv_mpu_data_rdy_trigger_set_state,
> >>  };
> >>  
> >> +static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void *p)
> >> +{
> >> +	struct iio_dev *indio_dev = p;
> >> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> >> +
> >> +	st->it_timestamp = iio_get_time_ns(indio_dev);
> >> +
> >> +	return IRQ_WAKE_THREAD;  
> >
> >I think you can use iio_pollfunc_store_time().  
> 
> The problem here is that interrupt can happen without buffer/trigger on, when only WoM is on.
> In my understanding, poll function is not attached when buffer is off and poll function is NULL.

Ah ok - I'd missed that mattered here.


