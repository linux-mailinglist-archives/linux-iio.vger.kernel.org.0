Return-Path: <linux-iio+bounces-13896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71B2A0155D
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 15:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C821636FB
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1211BD9F9;
	Sat,  4 Jan 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blI4sdpZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCF8F5A;
	Sat,  4 Jan 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736002169; cv=none; b=VpPCEOS/6pGCKe68Lm8mvZk7lOPm01efecd2rHx0Tlf/+UPZUz2RyyxpAGvBjZtDa7Xy/dNLoGEl2oZ3oKCNFV5vC8AE0qk30D2b9KfYq5NvyaSfvq1MOOqePWuqJMyX4H8JwqVg+CwD8mvqdxbWwDZHcn6W/xNw0lxy3tSSoU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736002169; c=relaxed/simple;
	bh=CN9VucQ5r/XcslJyMzATOwEzLxHB+i2MsFSaVMS2HiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gT+qxtFevKPimtpSsbdatkxqUIecn8gvET/jI5ryZ2iOEff9//0oVc5wosn/3UiTPpLzXMFlyojeZMKjJCFzjYk3mmjTDL11loe9kykeng3RvZvWh15jkSjLL82XokerosJLpqUtoZ5mOHuXJSo8YM7GdJBbD6FHvetC61vNvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blI4sdpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655ECC4CED2;
	Sat,  4 Jan 2025 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736002169;
	bh=CN9VucQ5r/XcslJyMzATOwEzLxHB+i2MsFSaVMS2HiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=blI4sdpZnPVmkcOSyyG1+DM6ELyvDb8EIr3YMelNDuQ7QiWcd3AwQbygoMsgn9/hS
	 LdronaJow2qwIBWbvUgDCqWFH8B147x8/NttGI+vcVJ1UtclnQrozJ+n1s+SiFWLL6
	 8U6f1hMuDayB4rRtm0W39vrvyqC6uCPO6cBGs7v/h1Hx9AE1AOEft7GUGuZ0J0ehug
	 UTNkPwaP/oSJcYP8Ny+nFlwoF5913iTUk6n8KSySsFBww6Ih8lfEXPH/N5VpLhB6qe
	 z2Ioh3DdhiWlv99ZscqWCFIshnO6LOzyQbkq5SVcMhi3KNnYW1yVQWhRoBa3nv7OeI
	 t/MIwU25/LZYg==
Date: Sat, 4 Jan 2025 14:49:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Peter Rosin <peda@axentia.se>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: iio-mux: kzalloc instead of devm_kzalloc to
 ensure page alignment
Message-ID: <20250104144923.47933eb8@jic23-huawei>
In-Reply-To: <20241211181754.52e0f627@jic23-huawei>
References: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
	<20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
	<20241208181531.47997ab4@jic23-huawei>
	<97fd092da34bcdcf0a7f79c6079a04ce@gmail.com>
	<20241211181754.52e0f627@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 18:17:54 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 09 Dec 2024 11:39:55 +0100
> Matteo Martelli <matteomartelli3@gmail.com> wrote:
> 
> > On Sun, 8 Dec 2024 18:15:31 +0000, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Mon, 02 Dec 2024 16:11:08 +0100
> > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > >     
> > > > During channel configuration, the iio-mux driver allocates a page with
> > > > devm_kzalloc(PAGE_SIZE) to read channel ext_info. However, the resulting
> > > > buffer points to an offset of the page due to the devres header sitting
> > > > at the beginning of the allocated area. This leads to failure in the
> > > > provider driver when sysfs_emit* helpers are used to format the ext_info
> > > > attributes.
> > > > 
> > > > Switch to plain kzalloc version. The devres version is not strictly
> > > > necessary as the buffer is only accessed during the channel
> > > > configuration phase. Rely on __free cleanup to deallocate the buffer.
> > > > Also, move the ext_info handling into a new function to have the page
> > > > buffer definition and assignment in one statement as suggested by
> > > > cleanup documentation.
> > > > 
> > > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>    
> > > This seems fine to me, but the diff ended up a bit complex, so I'd like
> > > Peter to take a look as well before I apply it.    
> > 
> > For a simpler diff I could go for devm_get_free_pages()+devm_free_pages(),
> > but since devres doesn't seem necessary in this case, I think this patch
> > provides a cleaner solution at the end.  
> 
> The approach is fine I think, I'd just like a second opinion so will
> give Peter some time to get to it before applying.

I want to get some build coverage at least on this, so I've applied it
for now to the togreg branch of iio.git and pushed out as testing.
Still a few more days for Peter to shout if he wants more time to looks at it!

Jonathan
> 
> >   
> > > 
> > > Do you have a board that is hitting this?  If so, a fixes tag is definitely
> > > appropriate. I think it is probably appropriate even it not.    
> > 
> > I am not sure if any existing board is affected as I encountered this
> > issue while experimenting with consumer drivers, thus using a custom DT
> > on top of sun50i-a64-pine64.dts just for testing. The following DT files
> > might be affected but only if the iio channel controlled by the iio_mux
> > multiplexer owns an ext_info attribute which is also exposed on sysfs.
> > 
> > $ grep -Rl 'io-channel-mux' arch
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> > arch/arm/boot/dts/microchip/at91-tse850-3.dts
> > arch/arm/boot/dts/microchip/at91-natte.dtsi
> > arch/arm64/boot/dts/rockchip/rk3566-powkiddy-rk2023.dtsi
> > arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353x.dtsi
> > arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg503.dts
> > arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
> > arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dtb
> > arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dts
> > 
> > I am also not sure what would be the reference commit for the Fixes tag.
> > The related ext_info attributes handling was introduced in the first
> > commit of the iio_mux implementation. If that applies, following the
> > corresponding Fixes tag.
> > 
> > Fixes: 7ba9df54b091 ("iio: multiplexer: new iio category and iio-mux driver")  
> That works I think.
> 
> Thanks,
> 
> >   
> > > 
> > > Jonathan
> > >     
> > 
> > Best regards,
> > Matteo  
> > > > ---
> > > >  drivers/iio/multiplexer/iio-mux.c | 84 +++++++++++++++++++++------------------
> > > >  1 file changed, 46 insertions(+), 38 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> > > > index 2953403bef53bbe47a97a8ab1c475ed88d7f86d2..c309d991490c63ba4299f1cda7102f10dcf54982 100644
> > > > --- a/drivers/iio/multiplexer/iio-mux.c
> > > > +++ b/drivers/iio/multiplexer/iio-mux.c
> > > > @@ -7,6 +7,7 @@
> > > >   * Author: Peter Rosin <peda@axentia.se>
> > > >   */
> > > >  
> > > > +#include <linux/cleanup.h>
> > > >  #include <linux/err.h>
> > > >  #include <linux/iio/consumer.h>
> > > >  #include <linux/iio/iio.h>
> > > > @@ -237,49 +238,18 @@ static ssize_t mux_write_ext_info(struct iio_dev *indio_dev, uintptr_t private,
> > > >  	return ret;
> > > >  }
> > > >  
> > > > -static int mux_configure_channel(struct device *dev, struct mux *mux,
> > > > -				 u32 state, const char *label, int idx)
> > > > +static int mux_configure_chan_ext_info(struct device *dev, struct mux *mux,
> > > > +				       int idx, int num_ext_info)
> > > >  {
> > > >  	struct mux_child *child = &mux->child[idx];
> > > > -	struct iio_chan_spec *chan = &mux->chan[idx];
> > > >  	struct iio_chan_spec const *pchan = mux->parent->channel;
> > > > -	char *page = NULL;
> > > > -	int num_ext_info;
> > > >  	int i;
> > > >  	int ret;
> > > >  
> > > > -	chan->indexed = 1;
> > > > -	chan->output = pchan->output;
> > > > -	chan->datasheet_name = label;
> > > > -	chan->ext_info = mux->ext_info;
> > > > -
> > > > -	ret = iio_get_channel_type(mux->parent, &chan->type);
> > > > -	if (ret < 0) {
> > > > -		dev_err(dev, "failed to get parent channel type\n");
> > > > -		return ret;
> > > > -	}
> > > > -
> > > > -	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
> > > > -		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
> > > > -	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
> > > > -		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> > > > -
> > > > -	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
> > > > -		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
> > > > -
> > > > -	if (state >= mux_control_states(mux->control)) {
> > > > -		dev_err(dev, "too many channels\n");
> > > > -		return -EINVAL;
> > > > -	}
> > > > -
> > > > -	chan->channel = state;
> > > > +	char *page __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > > > +	if (!page)
> > > > +		return -ENOMEM;
> > > >  
> > > > -	num_ext_info = iio_get_channel_ext_info_count(mux->parent);
> > > > -	if (num_ext_info) {
> > > > -		page = devm_kzalloc(dev, PAGE_SIZE, GFP_KERNEL);
> > > > -		if (!page)
> > > > -			return -ENOMEM;
> > > > -	}
> > > >  	child->ext_info_cache = devm_kcalloc(dev,
> > > >  					     num_ext_info,
> > > >  					     sizeof(*child->ext_info_cache),
> > > > @@ -318,8 +288,46 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
> > > >  		child->ext_info_cache[i].size = ret;
> > > >  	}
> > > >  
> > > > -	if (page)
> > > > -		devm_kfree(dev, page);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int mux_configure_channel(struct device *dev, struct mux *mux, u32 state,
> > > > +				 const char *label, int idx)
> > > > +{
> > > > +	struct iio_chan_spec *chan = &mux->chan[idx];
> > > > +	struct iio_chan_spec const *pchan = mux->parent->channel;
> > > > +	int num_ext_info;
> > > > +	int ret;
> > > > +
> > > > +	chan->indexed = 1;
> > > > +	chan->output = pchan->output;
> > > > +	chan->datasheet_name = label;
> > > > +	chan->ext_info = mux->ext_info;
> > > > +
> > > > +	ret = iio_get_channel_type(mux->parent, &chan->type);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "failed to get parent channel type\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
> > > > +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
> > > > +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
> > > > +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> > > > +
> > > > +	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
> > > > +		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
> > > > +
> > > > +	if (state >= mux_control_states(mux->control)) {
> > > > +		dev_err(dev, "too many channels\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	chan->channel = state;
> > > > +
> > > > +	num_ext_info = iio_get_channel_ext_info_count(mux->parent);
> > > > +	if (num_ext_info)
> > > > +		return mux_configure_chan_ext_info(dev, mux, idx, num_ext_info);
> > > >  
> > > >  	return 0;
> > > >  }
> > > >     
> > >     
> >   
> 
> 


