Return-Path: <linux-iio+bounces-13277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77489E909C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D75162FA2
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92978217658;
	Mon,  9 Dec 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCEO+r9L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642622165FD;
	Mon,  9 Dec 2024 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740800; cv=none; b=uLczJNOFY09ZpvfjTgNF1IPzohUWDEQiOTQbAGtMvV7G5b7bOpFm6ejcIbOmU8YRbGBPdi06eBWKjnkhxO+v8dKKZrivMQJqXUiQSa2LWPo56yWGVOZ5Vwyq3b5obwQtXzF59gN3QRarFCzxXeHuMi2YWldg0F53Whqtn6nxSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740800; c=relaxed/simple;
	bh=mPp3A+YaqPyOYmfji8xIukatEBYjuD64UNTGqolPSg0=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=YRrnJjFlumPDAdTxILcY7Y/4ww1yv3mSN7BtOBAuw5TSOLbAHL3DlCeneco/mokWdKo7X9064rdpuIGCQ7s/2MOyj6x0ZSPAxgRNIloyMksdRo0f0Qa2x/2U/aAARsaC1v1R98tOoLkCRbcKnAoj7gDZ/Uw4m4yczV4jQieF7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCEO+r9L; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so30115615e9.1;
        Mon, 09 Dec 2024 02:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733740797; x=1734345597; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3asuRQ6tLJQZF6IE+GUKGUpYd0mBhQT3GbbPKDPpAbI=;
        b=NCEO+r9Lb4aP98Li7WTe8nuEcV7/l7+lfSnsEYWy5Hkx7svr8J3yn2hMkaycK73tPl
         YiRObDO3tTA8XxJ8d81+Ox7zL1bXHoTMyHIrBPfajbq2sgV7vllrcQOgqnndKnKEXy6u
         +2HfnhR7mX/tn0QjmkMcdyvk26aqfP2+b9HImRpeUhA9J4Qkg+rRYWS/nHB/uc5H1nG7
         6XPoRbxvSIoqRovCVxCgDtAMXmNoHTx8Q4RWkvgqFh8hvbOw6rCMt0bKHDmsuHzMouzv
         yoLsSQgpMdO/mTL33RDBSY7aLVsAZPCfAohAqahArda5qGza7xLT1wY+aX0or8uo8bzl
         xxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733740797; x=1734345597;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3asuRQ6tLJQZF6IE+GUKGUpYd0mBhQT3GbbPKDPpAbI=;
        b=tnJpgTOZptNuKEcqcB/UNM+24rx5ZtmGKmvXMkRGS2umfVgCm6fdZiihH86FIbMcFU
         URlywK2TJkwRKBNW37cdXQpaqPD6KqmvwaCZ8kgYryC3tBnlVcSgfr7paYZ/GC3z8EFY
         VCsLrZ3Rotr8vsuk+qS157vmLDyBleJi8VEv9FsPiUi+EgtbhSR1SSxVVHQ/ckuaJuPl
         q332L9EaU3trg+9JzFp89UG0hNCTlN3XmMhXN5zdncv9jD/0k75Izz6/hCmCFNSsLK+L
         fUjaVDBlPkbQ9N2p+qhXYiXxSyHOqL1VSlFVwaMTt5a0cyzqclioA6wIXOTlLXC9+zvb
         34+w==
X-Forwarded-Encrypted: i=1; AJvYcCUpgsJcI36PVmo2INuAs8cpT6Ofzj5FmY7WgKQpfthscJc/qHbPp68Wp/rtBQJIiK/JvbGWcgavfeY=@vger.kernel.org, AJvYcCXYpUVzGEVdqwbd7p3ap1osiKn3TGx+vP6LI61uQ1O5Y4+zZjEqZ5z6tXuFX9T8Ek3kYhNHtm63dgKljJve@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJFyLI7dOautM7TCKj9bnoOoPJnRMWmHdWkeATJ5ddiMEnIWC
	IVzkohYRnQgWVI0pCo0n8cxUYrVhFS54KWGWafLx2oWyquo8W506
X-Gm-Gg: ASbGnct9dwEKSWLL0pNo4BrpRBg2M9fpsa+zEH8DxmAHLbGYq/5ih7ByWFPq3kLmAlq
	QzjnNuChf49M4eGHwNGN8qBXNP/TYLjhQvBwTKwOsTxWF+J/PfI+KPGZsm8Iye854p+ciq8QeDi
	c7x0Ndy2q3T6TDdCR44jY2rMsawM7RI6uIAXImn8Y8jY5vEECfzd/a+lxFFQOeU9S8bgzbNmHgK
	ozytjasMG/0YOAmacIUmyZ2u83tdGMt5M/jKtypt0xOFpFoomeJ+b/20M7wP4fsJ8eBTasb2sx4
	TVImmSAyLCGVTIKWDDsu4iioA56ruA==
X-Google-Smtp-Source: AGHT+IF5xznv/RtVfKo9rFPIJm071XFnsTogp1q0UGeIEDIKt+XyXv3Z+L4inzvf0NgfCz9gDP/JGw==
X-Received: by 2002:a5d:5f4c:0:b0:385:faf5:ebb8 with SMTP id ffacd0b85a97d-3862a893fadmr7274272f8f.7.1733740796475;
        Mon, 09 Dec 2024 02:39:56 -0800 (PST)
Received: from localhost (host-80-180-16-130.pool80180.interbusiness.it. [80.180.16.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59ceb6sm12905967f8f.42.2024.12.09.02.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:39:56 -0800 (PST)
Date: Mon, 09 Dec 2024 11:39:55 +0100
Message-ID: <97fd092da34bcdcf0a7f79c6079a04ce@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH 2/2] iio: iio-mux: kzalloc instead of devm_kzalloc to
 ensure page alignment
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Peter Rosin <peda@axentia.se>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241208181531.47997ab4@jic23-huawei>
References: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
	<20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
	<20241208181531.47997ab4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Sun, 8 Dec 2024 18:15:31 +0000, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 02 Dec 2024 16:11:08 +0100
> Matteo Martelli <matteomartelli3@gmail.com> wrote:
> 
> > During channel configuration, the iio-mux driver allocates a page with
> > devm_kzalloc(PAGE_SIZE) to read channel ext_info. However, the resulting
> > buffer points to an offset of the page due to the devres header sitting
> > at the beginning of the allocated area. This leads to failure in the
> > provider driver when sysfs_emit* helpers are used to format the ext_info
> > attributes.
> > 
> > Switch to plain kzalloc version. The devres version is not strictly
> > necessary as the buffer is only accessed during the channel
> > configuration phase. Rely on __free cleanup to deallocate the buffer.
> > Also, move the ext_info handling into a new function to have the page
> > buffer definition and assignment in one statement as suggested by
> > cleanup documentation.
> > 
> > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> This seems fine to me, but the diff ended up a bit complex, so I'd like
> Peter to take a look as well before I apply it.

For a simpler diff I could go for devm_get_free_pages()+devm_free_pages(),
but since devres doesn't seem necessary in this case, I think this patch
provides a cleaner solution at the end.

> 
> Do you have a board that is hitting this?  If so, a fixes tag is definitely
> appropriate. I think it is probably appropriate even it not.

I am not sure if any existing board is affected as I encountered this
issue while experimenting with consumer drivers, thus using a custom DT
on top of sun50i-a64-pine64.dts just for testing. The following DT files
might be affected but only if the iio channel controlled by the iio_mux
multiplexer owns an ext_info attribute which is also exposed on sysfs.

$ grep -Rl 'io-channel-mux' arch
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
arch/arm/boot/dts/microchip/at91-tse850-3.dts
arch/arm/boot/dts/microchip/at91-natte.dtsi
arch/arm64/boot/dts/rockchip/rk3566-powkiddy-rk2023.dtsi
arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353x.dtsi
arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg503.dts
arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dtb
arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dts

I am also not sure what would be the reference commit for the Fixes tag.
The related ext_info attributes handling was introduced in the first
commit of the iio_mux implementation. If that applies, following the
corresponding Fixes tag.

Fixes: 7ba9df54b091 ("iio: multiplexer: new iio category and iio-mux driver")

> 
> Jonathan
> 

Best regards,
Matteo
> > ---
> >  drivers/iio/multiplexer/iio-mux.c | 84 +++++++++++++++++++++------------------
> >  1 file changed, 46 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> > index 2953403bef53bbe47a97a8ab1c475ed88d7f86d2..c309d991490c63ba4299f1cda7102f10dcf54982 100644
> > --- a/drivers/iio/multiplexer/iio-mux.c
> > +++ b/drivers/iio/multiplexer/iio-mux.c
> > @@ -7,6 +7,7 @@
> >   * Author: Peter Rosin <peda@axentia.se>
> >   */
> >  
> > +#include <linux/cleanup.h>
> >  #include <linux/err.h>
> >  #include <linux/iio/consumer.h>
> >  #include <linux/iio/iio.h>
> > @@ -237,49 +238,18 @@ static ssize_t mux_write_ext_info(struct iio_dev *indio_dev, uintptr_t private,
> >  	return ret;
> >  }
> >  
> > -static int mux_configure_channel(struct device *dev, struct mux *mux,
> > -				 u32 state, const char *label, int idx)
> > +static int mux_configure_chan_ext_info(struct device *dev, struct mux *mux,
> > +				       int idx, int num_ext_info)
> >  {
> >  	struct mux_child *child = &mux->child[idx];
> > -	struct iio_chan_spec *chan = &mux->chan[idx];
> >  	struct iio_chan_spec const *pchan = mux->parent->channel;
> > -	char *page = NULL;
> > -	int num_ext_info;
> >  	int i;
> >  	int ret;
> >  
> > -	chan->indexed = 1;
> > -	chan->output = pchan->output;
> > -	chan->datasheet_name = label;
> > -	chan->ext_info = mux->ext_info;
> > -
> > -	ret = iio_get_channel_type(mux->parent, &chan->type);
> > -	if (ret < 0) {
> > -		dev_err(dev, "failed to get parent channel type\n");
> > -		return ret;
> > -	}
> > -
> > -	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
> > -		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
> > -	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
> > -		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> > -
> > -	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
> > -		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
> > -
> > -	if (state >= mux_control_states(mux->control)) {
> > -		dev_err(dev, "too many channels\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	chan->channel = state;
> > +	char *page __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!page)
> > +		return -ENOMEM;
> >  
> > -	num_ext_info = iio_get_channel_ext_info_count(mux->parent);
> > -	if (num_ext_info) {
> > -		page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
> > -		if (!page)
> > -			return -ENOMEM;
> > -	}
> >  	child->ext_info_cache = devm_kcalloc(dev,
> >  					     num_ext_info,
> >  					     sizeof(*child->ext_info_cache),
> > @@ -318,8 +288,46 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
> >  		child->ext_info_cache[i].size = ret;
> >  	}
> >  
> > -	if (page)
> > -		devm_kfree(dev, page);
> > +	return 0;
> > +}
> > +
> > +static int mux_configure_channel(struct device *dev, struct mux *mux, u32 state,
> > +				 const char *label, int idx)
> > +{
> > +	struct iio_chan_spec *chan = &mux->chan[idx];
> > +	struct iio_chan_spec const *pchan = mux->parent->channel;
> > +	int num_ext_info;
> > +	int ret;
> > +
> > +	chan->indexed = 1;
> > +	chan->output = pchan->output;
> > +	chan->datasheet_name = label;
> > +	chan->ext_info = mux->ext_info;
> > +
> > +	ret = iio_get_channel_type(mux->parent, &chan->type);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to get parent channel type\n");
> > +		return ret;
> > +	}
> > +
> > +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
> > +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
> > +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
> > +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> > +
> > +	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
> > +		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
> > +
> > +	if (state >= mux_control_states(mux->control)) {
> > +		dev_err(dev, "too many channels\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	chan->channel = state;
> > +
> > +	num_ext_info = iio_get_channel_ext_info_count(mux->parent);
> > +	if (num_ext_info)
> > +		return mux_configure_chan_ext_info(dev, mux, idx, num_ext_info);
> >  
> >  	return 0;
> >  }
> > 
> 


