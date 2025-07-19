Return-Path: <linux-iio+bounces-21776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2725B0AFC4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C201E3B17D4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEF627B4E1;
	Sat, 19 Jul 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB6G+IYt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64A27A931
	for <linux-iio@vger.kernel.org>; Sat, 19 Jul 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752927364; cv=none; b=q1qADGgCPdhZJyp6AcUd6J3qi4IlOmBwGDH15QI+edQ7MACnrwMnwdmYViXEoTsqCsjxNkAUC0gJlH3FBrB4AUdtBBsWx8FjGRsvHGso2o3x+j90eWwNB9Ms7mIqT/VATalzaGOl8Js9DqbGxUou5DGAMB954hy1WLMYMzcKLkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752927364; c=relaxed/simple;
	bh=7sHOMcyju39vj0iC2jjIDhKXntfiz6deY4blHFaNwNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZIlD0/W6mrIj8r9F2BUzBDznkGzR12QogiXA0eR6r/QMl/8zvEtfUa5kuctW5DOdcSZr5UinFkX1lq2//PYEvRFq5DEZcqq3RLS/9fMIqee01ZhDabNnqpkR027AEhzpVGVhf/MSgFiNS0OTWhA4Anb/7EP5GDwuceFLh303eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB6G+IYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714A7C4CEE3;
	Sat, 19 Jul 2025 12:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752927364;
	bh=7sHOMcyju39vj0iC2jjIDhKXntfiz6deY4blHFaNwNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MB6G+IYtPS3V8i0wn1pE935/RqeEDkV6Px05DMngro+T6PvnDewRCBin2zcCNf0lw
	 K8eUOLnBp+V1VOt0ufGadf46/inpIj62adkMOL1pOO5X+AqnoD5ymjv2M7H3wbJKNK
	 6GRSVRGY5tt7m4/IDH/BvE4eStvRfOu7cGiJGG6TOhGiQBNzx+Ee7jv/QDtHEJZZQF
	 aNVkny8i3IVhxNIMAjjMUzjyveLMlhT1rgCVRQW7MWSFFQD9DzfpOuEdkhCGhYU5DZ
	 0o9aeptlHMG90aVAJ1Fq9OniZKFV4jc4MU19GP7sdy4oCP0NcOsD2mU+6q+geVX4Hj
	 c7MV5efGWk7QQ==
Date: Sat, 19 Jul 2025 13:15:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: adc: ad4170-4: Add digital filter and sample
 frequency config support
Message-ID: <20250719131556.1ecbdf5a@jic23-huawei>
In-Reply-To: <c6e54942-5b42-484b-be53-9d4606fd25c4@sabinyo.mountain>
References: <c6e54942-5b42-484b-be53-9d4606fd25c4@sabinyo.mountain>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 18:00:03 -0500
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hello Marcelo Schmitt,
> 
> Commit 6b648c49d491 ("iio: adc: ad4170-4: Add digital filter and
> sample frequency config support") from Jul 7, 2025 (linux-next),
> leads to the following (unpublished) Smatch static checker warning:
> 
> drivers/iio/adc/ad4170-4.c:883 ad4170_set_filter_type()	warn: always clamps to 4
> drivers/iio/adc/ad4170-4.c:886 ad4170_set_filter_type() warn: always clamps to 1
> 
> drivers/iio/adc/ad4170-4.c
>     870         /*
>     871          * The filters provide the same ODR for a given filter_fs value but
>     872          * there are different minimum and maximum filter_fs limits for each
>     873          * filter. The filter_fs value will be adjusted if the current filter_fs
>     874          * is out of the limits of the just requested filter. Since the
>     875          * filter_fs value affects the ODR (sampling_frequency), changing the
>     876          * filter may lead to a change in the sampling frequency.
>     877          */
>     878         scoped_guard(mutex, &st->lock) {
>     879                 if (!iio_device_claim_direct(indio_dev))
>     880                         return -EBUSY;
>     881 
>     882                 if (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> So "val" can either be 0 or 2.
> 
> --> 883                         setup->filter_fs = clamp(val, AD4170_SINC3_MIN_FS,  
>                                                               ^^^^^^^^^^^^^^^^^^^
>     884                                                  AD4170_SINC3_MAX_FS);
>                                                          ^^^^^^^^^^^^^^^^^^^
> and we clamp it to 4-65532.  Since filter_fs is always 4 in the end, why
> not just say "setup->filter_fs = AD4170_SINC3_MIN_FS;"?

Code is weird.  My 'guess' from comments is intent is actually trying to tweak
setup->filter_fs in event of the previous value now being impossible for the new
filter type.

				setup->filter_fs = clamp(setup->filter_fs, AD4170_SINC_MIN_FS,
							 AD4170_SINC3_MAX_FS)

etc.

Marcelo?

> 
>     885                 else
>     886                         setup->filter_fs = clamp(val, AD4170_SINC5_MIN_FS,
>                                                          ^^^
> On this path "val" can only be AD4170_SINC5 (1)
> 
>     887                                                  AD4170_SINC5_MAX_FS);
>     888 
>     889                 setup->filter &= ~AD4170_FILTER_FILTER_TYPE_MSK;
>     890                 setup->filter |= FIELD_PREP(AD4170_FILTER_FILTER_TYPE_MSK,
>     891                                             filter_type_conf);
>     892 
>     893                 ret = ad4170_write_channel_setup(st, chan->address, false);
>     894                 iio_device_release_direct(indio_dev);
>     895         }
>     896 
>     897         return ret;
>     898 }
> 
> regards,
> dan carpenter
> 


