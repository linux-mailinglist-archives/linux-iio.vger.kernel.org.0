Return-Path: <linux-iio+bounces-16575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08F8A57C2A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F61516E6B8
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538F81E9B0E;
	Sat,  8 Mar 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXg6Ifae"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDBE1E8359;
	Sat,  8 Mar 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452657; cv=none; b=lWBLIhJUcUgP1y3tNwnduEgZx66f/nc3SeC+T9TIra1OxR5CaH1YedVOvnY3J3bmf7SpOIa4rGG+Bl4421As0mObMlCBPZPsq6fN5505XvDdjdSrUmX8qC684PRkAKdIVlU5GJ065UPPtr4AZ9nRCok++fgRALO7lpBuIYLAdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452657; c=relaxed/simple;
	bh=zukLuVZquSpBt41C2EFKFn86YAE7G8TH2t/2Y3RItps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEi7/JKS81jKsjhiQwtQfA3v6WqoGFBmcsq4aCZM22LExIknJFOC9w8FqyQqFUkY/XDbHsCtFj/RJ3oqn66TexmULmPRDsfCrO20Hb5g7tPv1Dw2bQxfCb1AqmtKW4F7L4B3Lz0RXulDYportFCCtSc4p3okf4pi6o5Ybtdt1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXg6Ifae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33D9C4CEE0;
	Sat,  8 Mar 2025 16:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741452656;
	bh=zukLuVZquSpBt41C2EFKFn86YAE7G8TH2t/2Y3RItps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iXg6IfaewLz89ab7WY7g6PaicLru+znqMziV7Egb7krkpv0fJwEsgMvtExibQW7hN
	 6huU3GeJUFEqflDdWStDU59BR9spfZR6fQauzepLYFC4mLenvsmdElLuueDiiPdQI0
	 LmAEhiiKETjCRPs+mUUeo/lWJX6bzJI6SN9WgdgWdAs45IAhnHcixV5srxHdjTUGe0
	 JPsfClvfokmR0fbE8oVdUSako6znToz/OZCtPYb5UWtS8neEogl9gK9tZ6NbgkIYnu
	 BEzVdZSzR6D3Ud4++EkPFc3UUm+t5KW6CmlkAhxOYHO0LrSI1+BdEsKVHDTCvnawuJ
	 NokxTMD1AiOyg==
Date: Sat, 8 Mar 2025 16:50:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
Message-ID: <20250308165048.408d31ad@jic23-huawei>
In-Reply-To: <20250222164519.45c48a52@jic23-huawei>
References: <Z7dnrEpKQdRZ2qFU@Emma>
	<20250222164337.0372fb58@jic23-huawei>
	<20250222164519.45c48a52@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 16:45:19 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 22 Feb 2025 16:43:37 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Thu, 20 Feb 2025 17:34:36 +0000
> > Karan Sanghavi <karansanghvi98@gmail.com> wrote:
> >   
> > > The array contains only 5 elements, but the index calculated by
> > > veml6075_read_int_time_index can range from 0 to 7,
> > > which could lead to out-of-bounds access. The check prevents this issue.
> > > 
> > > Coverity Issue
> > > CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
> > > overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
> > > elements at element index 7 (byte offset 31) using
> > > index int_index (which evaluates to 7)
> > > 
> > > Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor driver")
> > > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> > > ---    
> > Superficially this looks hardening against malicious or broken hardware.
> > That is fine to add, but not worth backporting or (in my opinion) adding a fixes
> > tag.  
> Ah I see Javier asked for the fixes tag.  Ok.  Maybe just add a note that
> the hardware is not expected to return such an out of bounds value.
> 
> That will help me to remember we don't need to rush this one upstream!
I guess you don't have time so I made the changes requested and applied.
(mostly so I can stop tracking the status!)

Jonathan

> 
> Jonathan
> 
> >   
> > >  drivers/iio/light/veml6075.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> > > index 05d4c0e9015d..5dd951f6e989 100644
> > > --- a/drivers/iio/light/veml6075.c
> > > +++ b/drivers/iio/light/veml6075.c
> > > @@ -201,7 +201,12 @@ static int veml6075_read_int_time_index(struct veml6075_data *data)
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > -	return FIELD_GET(VEML6075_CONF_IT, conf);
> > > +	int int_index = FIELD_GET(VEML6075_CONF_IT, conf);
> > > +
> > > +	if (int_index >= ARRAY_SIZE(veml6075_it_ms))
> > > +		return -EINVAL;
> > > +
> > > +	return int_index;
> > >  }
> > >  
> > >  static int veml6075_read_int_time_ms(struct veml6075_data *data, int *val)    
> >   
> 
> 


