Return-Path: <linux-iio+bounces-15594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99956A3761B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59753188E8D4
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733D19D071;
	Sun, 16 Feb 2025 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjOK0BAh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B729450FE;
	Sun, 16 Feb 2025 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725188; cv=none; b=c9RC1m3h34kdDIwPBPV8ke4V/T6mgZRC9e5eK0HTasMxwzZGskg6vExMXSjKJpV4NO6uTrCCyXpWyAfcatxa8q1YiOneSrubN1tK6Q2gv11ONEGztMPisggo1O+0rv542WB+RmRDPD5i51b0eJV7xScqsWnRuX+Cz7XU/8MN+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725188; c=relaxed/simple;
	bh=SC/tuAOm11oCVUJiOo+McB3iHWTWiP1gMTvFuGu89bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpK9qa5+sJ4bzrg/bmD5rt5sJ5TMrKNMVDEl4WY7f2WWc6qzo56ik7F35n1kl8kr22ANwvXar7afpK+ief+lHpv9FumFTkAYnm6Ua0hpLmTzrBxZRIiXAf2RNhfFFgsPvnL+j7mHpEwV4CYV+fz7vTy2IOh4kZ4YSGCWF1BoCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjOK0BAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70575C4CEDD;
	Sun, 16 Feb 2025 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739725187;
	bh=SC/tuAOm11oCVUJiOo+McB3iHWTWiP1gMTvFuGu89bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LjOK0BAhP4tBI99Nx5vy4ZiuXj1NO3gslpAEUnCkgPVmaZbtVzp+7U0Gc0QARywLo
	 hN70p05uB7/X2PfK05gNdKRgjq+A7ZkmI5wJWzLRYfCVXNT4xFBdGw+5QtUY03ToSm
	 nw3+phcjHe8Slp0xIE1PFgySsx735f7meh+Qtx7uwlG1IvEdyjVrXi0hB92wZZQm24
	 VIG7vofvWX6djtnOKo47FwpFtU7FqK3St46CzRF6vTOfdp01F4+wO3iz5OZeeEE7dR
	 cxpAlsOluSe7u5qWo6f36DTqYASC84d4Ut6Vj1+HUN3inYk9Lo9xBlqxADFihM21t0
	 SY3xdX+a08lRw==
Date: Sun, 16 Feb 2025 16:59:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
 andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
 przemyslaw.kitszel@intel.com, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 10/12] iio: adc: xilinx-xadc-core: use
 devm_kmemdup_array()
Message-ID: <20250216165939.4780c4f4@jic23-huawei>
In-Reply-To: <20250212062513.2254767-11-raag.jadav@intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
	<20250212062513.2254767-11-raag.jadav@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 11:55:11 +0530
Raag Jadav <raag.jadav@intel.com> wrote:

> Convert to use devm_kmemdup_array() and while at it, use source size
> instead of destination.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Seems fine to me.
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index cfbfcaefec0f..e1f8740ae688 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1245,8 +1245,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
>  		channel_templates = xadc_us_channels;
>  		max_channels = ARRAY_SIZE(xadc_us_channels);
>  	}
> -	channels = devm_kmemdup(dev, channel_templates,
> -				sizeof(channels[0]) * max_channels, GFP_KERNEL);
> +	channels = devm_kmemdup_array(dev, channel_templates, max_channels,
> +				      sizeof(*channel_templates), GFP_KERNEL);
>  	if (!channels)
>  		return -ENOMEM;
>  


