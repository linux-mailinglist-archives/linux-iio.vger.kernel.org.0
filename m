Return-Path: <linux-iio+bounces-4810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 615098BBFFF
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 12:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B211F214B6
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA72779E4;
	Sun,  5 May 2024 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tek13VQM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AC749C;
	Sun,  5 May 2024 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714904152; cv=none; b=OAJdQcLcYHYxDbrwfEJbArT7cKJ3g83P7crNOFiE3AG/ZM14vWPiGS75FuGhS7Npf4HxE5BxHc4F4T/SvxJDfJsO8xuzjpNggVo5r9kbeZn5yO62Dm8c9NyoHM6pauCB92eImlWP6eTz+bUx2ZaeCxzsy6uIx7heQ1EmXVuOqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714904152; c=relaxed/simple;
	bh=0XKn5KyE0UnxNmHj2HHee7Et02H9uYvYyVyAj3MOENs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdTTyxfnj2sOH5HyKDQZvGqPg9YUrCv/AnIJlk/U0WbT5HshzUEGBNFyPckDXzmxdXy+9q6ITq3kVkPqL2h8yM2R5tqHcAP7QYcVECReh/5gYj5jBU2vqIOzfnECa3qJnng3I5mm6YDykAyrPvL1kfhCeW4u7V6DBku6mUFM5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tek13VQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7E4C113CC;
	Sun,  5 May 2024 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714904152;
	bh=0XKn5KyE0UnxNmHj2HHee7Et02H9uYvYyVyAj3MOENs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tek13VQMUAkg9kg+Xdntk+1i6ZClzuyUP+btZLoaRVGzvDqBIdxhRAqtFXVZ7dZXK
	 MnkPCA+bALied8kiwlZNEmN2KIcUOXL7gknSmuRE3/tvQKugUAHELbGpthsxU4drRm
	 2Aq8iiSei0b2ONRIpAksfCmilAolxj0XruuwFWFrPPdKH2kF3siQm2EwsnrekPuXYN
	 TdbYNVeYoXdbTblH9/CzLuMdOKRd8Bx7ul5JfTmHreqkuoimXjVrnazwE2FGkNMqIF
	 l671OgXhlNmuCx+3gs9nL1wPuLFtJq77chFlZqNAyfNjlI3UUHTeYGAz/YrOzz8J4O
	 y5VJq9sjDk7qQ==
Date: Sun, 5 May 2024 11:15:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Andrew Hepp <andrew.hepp@ahepp.dev>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: temperature: mcp9600: set channel2 member
Message-ID: <20240505111541.13b94920@jic23-huawei>
In-Reply-To: <20240430122157.GA46332@debian>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
	<20240430120535.46097-2-dima.fedrau@gmail.com>
	<20240430131102.00005e58@Huawei.com>
	<20240430122157.GA46332@debian>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 14:21:57 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Am Tue, Apr 30, 2024 at 01:11:02PM +0100 schrieb Jonathan Cameron:
> > On Tue, 30 Apr 2024 14:05:31 +0200
> > Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> >   
> > > Set channel2 member of channel 0 to IIO_MOD_TEMP_OBJECT and set modified
> > > member to 1.  
> > This an ABI change, so needs a strong argument + must be a fix 
> > rather than an improvement.  So why does this need to change?
> >  
> Hi Jonathan,
> 
> I don't know if it is an valid argument but when using tool "iio_info"
> the temp_object wasn't displayed at all. After adding these two lines
> the temp_object is displayed. Don't know if it is a problem with the
> userspace tools.

Just to check, it displayed not temperature channel for this?

If you could send the file listing of the appropriate
/sys/bus/iio/devices/iio\:deviceX/ directory that would be great.

It is possible the tools don't cope with a mixture of modified and unmodified
channels (without index).  Whilst the ABI docs don't say you can't do this
it is a rather obscure corner case.

The maping from hotjunction to object isn't totally clear to me.
Mind you neither is the mapping from cold junction to ambient (that one is
a bit stronger as the datasheet tables assume
Cold Junction Temperature == Ambient Temperature.

Example of why I don't like this is object is no obvious if the hotjunction
is in a gas or liquid.  The object defintion was I think added for infrared
temperature sensors where you get nothing meaningful without an object to
emit the infrared.

An alternative would be to provide an index for both channels. Also an ABI
change, but avoids the object / hot junction issue and I would assume works
fine with iio_info.

Jonathan



> 
> iio_info version: 0.25 (git tag:b6028fde)
> Libiio version: 0.25 (git tag: b6028fd) backends: local xml ip usb serial
> 
> Besides that it eases distinction between the two channels in the last
> patch, but I think this argument is not strong enough. :)
> 
> Best regards,
> Dimitri
> 
> >   
> > > 
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > ---
> > >  drivers/iio/temperature/mcp9600.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > > index 7a3eef5d5e75..e277edb4ae4b 100644
> > > --- a/drivers/iio/temperature/mcp9600.c
> > > +++ b/drivers/iio/temperature/mcp9600.c
> > > @@ -26,6 +26,8 @@ static const struct iio_chan_spec mcp9600_channels[] = {
> > >  	{
> > >  		.type = IIO_TEMP,
> > >  		.address = MCP9600_HOT_JUNCTION,
> > > +		.channel2 = IIO_MOD_TEMP_OBJECT,
> > > +		.modified = 1,
> > >  		.info_mask_separate =
> > >  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > >  	},  
> >   
> 


