Return-Path: <linux-iio+bounces-4583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2786F8B4C6A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 17:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FD21C2094E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407C36AFAE;
	Sun, 28 Apr 2024 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUV5uP2T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EE41E49F
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714318623; cv=none; b=WK0nAOtv28lOsaE/O2hzqBQsOsHraTOhPNbLiCfuYZaxw9V+BAGMlh8FLv2kqDPB1aTcfaXa9q4S4vqzbKiwqaujW7T/p/Av7i0TNvZCat11NC97pVB5JEbsaX2QvjSWovq7fcCtvo9NnVrb9ICI2gFBRXHGzHvFBFuEzA4Jtl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714318623; c=relaxed/simple;
	bh=YdBKw2Bg2ktoUcs2+ezDKev6uboK0at9UVEf5rEbqAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozpHLkAO2wns9kAk3k5NI/ICmOm8EzMPisdi/IlO7o8uqYo1nn584O1tga2mTUeVZQ+YnWRQmmR76c8QtXYFYcbJ72qsu7W5QHt+MRaKrpE3b481RIggVqbu+RmKRO2x6gBMmC6AMbYoAv4j4msqOe39Zf5yzAoMoYo7Uv6v61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUV5uP2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A776C113CC;
	Sun, 28 Apr 2024 15:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714318622;
	bh=YdBKw2Bg2ktoUcs2+ezDKev6uboK0at9UVEf5rEbqAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUV5uP2TLXdH2IWhIvn41BoGC5ayzCaNNtJHBN6aNCxFucyMTxOUCQfBRWUAR8Xq6
	 LgK8EEXLgqz9Fr+smlmDfkXONMpyWsplc8K5cxCnjjgSnpsGyaa2PThgj4TaURvjDt
	 /ODTm/Tlyo1QuLEgq5+QjeHol+BZzrupHx6nUEjR2G68dRx6kBCDoLawVQyYpy/dHt
	 qxdNvDDU++zywTHbOLeOcZjUA1CRfKQgoODwJyuFALZk37nj1jrBmVaYqrauhqcHfG
	 0zlz6C1aEMGdItLNl/HO4ZNcrjJt8B0mS10HfCWvEuEKhDKWRxB4QmoR9/KdMUW14i
	 9otSwGoB8xYtw==
Date: Sun, 28 Apr 2024 16:36:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Lincoln Yuji <lincolnyuji@usp.br>, Lincoln Yuji
 <lincolnyuji@hotmail.com>, Luiza Soezima <lbrsoezima@usp.br>, Sabrina
 Araujo <sabrinaaraujo@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1015: use
 device_for_each_child_node_scoped()
Message-ID: <20240428163652.7da552d1@jic23-huawei>
In-Reply-To: <ZizeKo_E7Z5DOR9C@debian-BULLSEYE-live-builder-AMD64>
References: <20240426131953.14933-1-lincolnyuji@usp.br>
	<ZizeKo_E7Z5DOR9C@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Apr 2024 08:14:50 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Lincoln, Sabrina, Luiza,
> 
> The patch looks good, though the message should be wrapped to 75 columns
> and the "From:" tag was not needed and caused an email mismatch.
That usually means the commit author in the git tree this was generated
from is incorrect. Set that to match your email with
git commit --amend --author="Lincoln Yuji <lincolnyuji@usp.br>"


> 
> With those adjustments made,
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> Regards,
> Marcelo
> 
> On 04/26, Lincoln Yuji wrote:
> > From: Lincoln Yuji <lincolnyuji@hotmail.com>
> > 
> > This loop definition removes the need for manual releasing of the fwnode_handle
> > in early exit paths (here an error path) allow simplification of the code
> > and reducing the chance of future modifications not releasing
> > fwnode_handle correctly.
> > 
> > Co-developed-by: Luiza Soezima <lbrsoezima@usp.br>
> > Signed-off-by: Luiza Soezima <lbrsoezima@usp.br>
> > Co-developed-by: Sabrina Araujo <sabrinaaraujo@usp.br>
> > Signed-off-by: Sabrina Araujo <sabrinaaraujo@usp.br>
> > Signed-off-by: Lincoln Yuji <lincolnyuji@usp.br>
> > ---
> >  drivers/iio/adc/ti-ads1015.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> > index 6ae967e4d..d3363d02f 100644
> > --- a/drivers/iio/adc/ti-ads1015.c
> > +++ b/drivers/iio/adc/ti-ads1015.c
> > @@ -902,10 +902,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
> >  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> >  	struct ads1015_data *data = iio_priv(indio_dev);
> >  	struct device *dev = &client->dev;
> > -	struct fwnode_handle *node;
> >  	int i = -1;
> >  
> > -	device_for_each_child_node(dev, node) {
> > +	device_for_each_child_node_scoped(dev, node) {
> >  		u32 pval;
> >  		unsigned int channel;
> >  		unsigned int pga = ADS1015_DEFAULT_PGA;
> > @@ -927,7 +926,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
> >  			pga = pval;
> >  			if (pga > 5) {
> >  				dev_err(dev, "invalid gain on %pfw\n", node);
> > -				fwnode_handle_put(node);
> >  				return -EINVAL;
> >  			}
> >  		}
> > @@ -936,7 +934,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
> >  			data_rate = pval;
> >  			if (data_rate > 7) {
> >  				dev_err(dev, "invalid data_rate on %pfw\n", node);
> > -				fwnode_handle_put(node);
> >  				return -EINVAL;
> >  			}
> >  		}
> > -- 
> > 2.34.1
> > 
> >   


