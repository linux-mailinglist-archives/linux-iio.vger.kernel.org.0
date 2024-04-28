Return-Path: <linux-iio+bounces-4584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8642E8B4C6F
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 17:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9111F21498
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC516EB5D;
	Sun, 28 Apr 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utwwt3yl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8911E48A
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714318921; cv=none; b=aAvYLnJrU8mycVLpr+NNBcNESzpzZYx92j4IcNapn6PdyQhfmkRjo6IQAotPjCpJv8QMVvzasjbWSf3uB+cwYGe3ZhIdM3uaSknTQjjSxll9FcPIgyTFmyA2558UjzElN5Sjhz0746AyjfArKaEj5nJFPd+dfpvmJ5OdhXgdps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714318921; c=relaxed/simple;
	bh=wjbaf1QivMJjGsamE2b2hJz+2ozuAcH3xZwwYP27Vs8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocIXLLr/LM8prApEnJoBf5G6vKZwXQ2YMl9LxqlvFhsYZ0cxmQ1SOAl4m5PO3oh0sacMVQ8cwFw1xwe1mx032cqJAGrwVEJ3isbohkKZTdnsX9O4opg240T5n6oJZ/hxzu2Ez+pRQtXPFigYVz+ze6CyjLQVknvYwg/dQgY7+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utwwt3yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083D1C113CC;
	Sun, 28 Apr 2024 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714318920;
	bh=wjbaf1QivMJjGsamE2b2hJz+2ozuAcH3xZwwYP27Vs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Utwwt3yle6lDgJko/ayla9FaXsPpH15GIC7exnM4kYyJkcurbSb1t8yPInevPgymG
	 VTnNMz4YgodIkt24csJLT01MN3YC5Oycl7QZogw76hcNdIiQjUyr+IkH0Coo9ITpgH
	 e3qixE8PX5mX0iZbyoRea6/yRp1EkGtBnbIf/oB6QhSht6npvvNOM1ZpeezPC4OMKw
	 9dyShQ35uXMwLj+qMmP2c4zd9XkEk8qinpoy63R7H4411gGQA3yRJgvjCcqOUGE1AQ
	 yDbCI0Hh88IZ2O0EgUXIK+GBOVSowLi3Dm2E9T68MFWRloWgcecYhBZwSPKV0MOjIw
	 pH1mu6BJ6oLdg==
Date: Sun, 28 Apr 2024 16:41:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Lincoln Yuji <lincolnyuji@usp.br>, Lincoln Yuji
 <lincolnyuji@hotmail.com>, Luiza Soezima <lbrsoezima@usp.br>, Sabrina
 Araujo <sabrinaaraujo@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1015: use
 device_for_each_child_node_scoped()
Message-ID: <20240428164149.3d4b160b@jic23-huawei>
In-Reply-To: <20240428163652.7da552d1@jic23-huawei>
References: <20240426131953.14933-1-lincolnyuji@usp.br>
	<ZizeKo_E7Z5DOR9C@debian-BULLSEYE-live-builder-AMD64>
	<20240428163652.7da552d1@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Apr 2024 16:36:52 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 27 Apr 2024 08:14:50 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > Hi Lincoln, Sabrina, Luiza,
> > 
> > The patch looks good, though the message should be wrapped to 75 columns
> > and the "From:" tag was not needed and caused an email mismatch.  
> That usually means the commit author in the git tree this was generated
> from is incorrect. Set that to match your email with
> git commit --amend --author="Lincoln Yuji <lincolnyuji@usp.br>"
> 
Nope. I was wrong on that.   Indeed what Marcelo said in another
thread, you need to set the --from

Jonathan

> 
> > 
> > With those adjustments made,
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > 
> > Regards,
> > Marcelo
> > 
> > On 04/26, Lincoln Yuji wrote:  
> > > From: Lincoln Yuji <lincolnyuji@hotmail.com>
> > > 
> > > This loop definition removes the need for manual releasing of the fwnode_handle
> > > in early exit paths (here an error path) allow simplification of the code
> > > and reducing the chance of future modifications not releasing
> > > fwnode_handle correctly.
> > > 
> > > Co-developed-by: Luiza Soezima <lbrsoezima@usp.br>
> > > Signed-off-by: Luiza Soezima <lbrsoezima@usp.br>
> > > Co-developed-by: Sabrina Araujo <sabrinaaraujo@usp.br>
> > > Signed-off-by: Sabrina Araujo <sabrinaaraujo@usp.br>
> > > Signed-off-by: Lincoln Yuji <lincolnyuji@usp.br>
> > > ---
> > >  drivers/iio/adc/ti-ads1015.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> > > index 6ae967e4d..d3363d02f 100644
> > > --- a/drivers/iio/adc/ti-ads1015.c
> > > +++ b/drivers/iio/adc/ti-ads1015.c
> > > @@ -902,10 +902,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
> > >  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > >  	struct ads1015_data *data = iio_priv(indio_dev);
> > >  	struct device *dev = &client->dev;
> > > -	struct fwnode_handle *node;
> > >  	int i = -1;
> > >  
> > > -	device_for_each_child_node(dev, node) {
> > > +	device_for_each_child_node_scoped(dev, node) {
> > >  		u32 pval;
> > >  		unsigned int channel;
> > >  		unsigned int pga = ADS1015_DEFAULT_PGA;
> > > @@ -927,7 +926,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
> > >  			pga = pval;
> > >  			if (pga > 5) {
> > >  				dev_err(dev, "invalid gain on %pfw\n", node);
> > > -				fwnode_handle_put(node);
> > >  				return -EINVAL;
> > >  			}
> > >  		}
> > > @@ -936,7 +934,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
> > >  			data_rate = pval;
> > >  			if (data_rate > 7) {
> > >  				dev_err(dev, "invalid data_rate on %pfw\n", node);
> > > -				fwnode_handle_put(node);
> > >  				return -EINVAL;
> > >  			}
> > >  		}
> > > -- 
> > > 2.34.1
> > > 
> > >     
> 


