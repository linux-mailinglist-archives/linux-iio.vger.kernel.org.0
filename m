Return-Path: <linux-iio+bounces-14335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24CA0FDC9
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1011699AF
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 01:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F8D3596B;
	Tue, 14 Jan 2025 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCUvJeNU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7EF5695;
	Tue, 14 Jan 2025 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736816804; cv=none; b=IfmFJbjpqog04pSwLOVbpXf36ZGZm7cPZb+qpYsdB5uVC+jUB2djowHFZqxNbmbzz7A45KiIVQ7OEefWrzF90yAzNH391t2betXb1LREQ4i4jJXNUUF+yIPSPjSyZDbLQVM6VHWBPFf7lGKt2Hn41D7nY7Ef8jZQDL6AmaEpBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736816804; c=relaxed/simple;
	bh=YZjUNm8imIEQzrNGcFxwYqJS6knxD89komPXCuBZSqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnSXE/racIRKq8sCNx6NXpBLZcsO1sMctE3ThgYkrfTWAMTCKlwH1AVq+cmMO3WAt/ETWnYncj96n+KdvjrpSXj6XJpexszXVaJ+z9v7GLyzCdk5Iizc82Mh7MPpyZZkpTB3yJ/k4CGmHefU6RSAnfZEnTlf7AkLtvmYkV4EYt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCUvJeNU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b9b003e7bfso49049485a.3;
        Mon, 13 Jan 2025 17:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736816802; x=1737421602; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPMaVlC8/XyEjOUMlbhV80ufFhLZcaDU2B7mfTsk8j0=;
        b=UCUvJeNUoKPeIcb/YezMR+7TXZcTWkxgqrpTrI807jnX9Wp4coi9cgB8B0m21XKUpO
         scONKvu80ckOtrYyTfJZ4bmq4tkUDv7ca0QP4jl+sP2+iBwHkzfNs7i1b0R1C5Ug56bg
         ZyrnvGAZylbkV2vPzXmjo9LYoCvzuWWDTp5KVnZfT0aijxRMhk0Gg+Var4+dB7kWNXqI
         CxUVoXBb69r+jmK+s3kEngXjmUuhKXdcXSoH9f5Wz8O0JeTLwJZFED8H7iKPXcYhipqc
         iq1vjetJkFWAYvDoUDYYHVkXV0B47drzLEwxUStDSQ6Cw1FNrMFQNFtNjQmivyo8WKSQ
         5WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736816802; x=1737421602;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPMaVlC8/XyEjOUMlbhV80ufFhLZcaDU2B7mfTsk8j0=;
        b=WJnplQ+OStyZxiiTvZJCPAKQV0EaqwOYRKegaTCowK6o6HK4mi5J85ih2tJcH6g/9q
         NSlPuvuR+h5JmywyuUNTPBxwJvyx7+R3lES+9jf/qp7WnSXJfopuzcs0e4uU1jkl++FA
         bBg361ndmXQ1K9tfvHR7r7XZtlzilnWimKJ9ibEeo8CDYEzbAM7Gqm7T1z0O/SgiNNBk
         KPEPk3DRS/BasGp9eI+kvReMaK5/1ffOOd9woBoa1t8D7NTj5vLbr/HmMmmf7ZXZdhUS
         kngmHyNKI1oTOrRD91Xn1Bb5NYuLaab6l7lUcNnapnOBEvoTDaF7VaXKR3lODwucetLO
         kkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyLjdV45DPpm8oq9AuCyzQkMY5Nsv6pvjGHl/MaensSfJu8wSa1KraNlBV4ZchIhcLBtlTjoB2cYvx@vger.kernel.org, AJvYcCVpjnrKo5LcEQ2/gtr18jnbqKFCSjSstCTah3ll8yDTeWU1eb1HT4+q7TXsFOYhT/H93GZS4mhpFojmOHBI@vger.kernel.org, AJvYcCXgb8s5X21+L7zDoRXwGtCRhrQBdv3zIY4UPWFFrBW2WcHnYRg4VzD8izv6RNikNuINNcuzzGeVspRs@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9yj9phMSDp8UqlQ+plHibtSKd8Q3aSbGj2iewraaLFqdxwGd
	rDCl1EPGM2qwc6HLSaK3azOmk4UjZEE74ULX72/x4X/9j3S25Ji8
X-Gm-Gg: ASbGncu5D9giXkV+qX7Jp8Ozs9L+rB/0//AAXmS9WVf4z51QyAVbUdoRK7wysw+PQdC
	FotcrIjAdgwOYdHW8yyiDvO0sWQUXEpJ5QV+HNvFZxClMVsC3G5mJ3Od9xDpP9mAcdrHVg4zKof
	8BOMv6JZJgcOzne/BVjxo/DffZlhYG/Qkbo/AZXEX0GByLi4/TpqiSCM8FEyD06fSnIY9yXOnX4
	dswKC7KLvEel5jEic7+bL8xA9bJNRxmzELU6qVhDvzi0DXqAlUgu8lS48AItzTOiPijp0sTvN7c
	xg==
X-Google-Smtp-Source: AGHT+IEZ2GcHfOflVGnA+0WlUNV5LdUrGCAK3KCOXqj2ofkNJRV7gSlHyE12K+86tjPNXutPcSZs7A==
X-Received: by 2002:a05:620a:5696:b0:7be:494a:3660 with SMTP id af79cd13be357-7be494a40b6mr26578085a.1.1736816801911;
        Mon, 13 Jan 2025 17:06:41 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3237fedsm551023785a.25.2025.01.13.17.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 17:06:41 -0800 (PST)
Date: Mon, 13 Jan 2025 22:06:37 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: 58ea1899-05be-4743-911b-77a56f08c347@baylibre.com,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 03/15] Documentation: ABI: testing: ad7768-1: Add
 device specific ABI documentation.
Message-ID: <Z4W4nS8a5A2PZ4wV@JSANTO12-L01.ad.analog.com>
Reply-To: 20250112131021.5601aaea@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <f78c3dee381b23c17787f1e2bc9c5667741d407b.1736201898.git.Jonathan.Santos@analog.com>
 <58ea1899-05be-4743-911b-77a56f08c347@baylibre.com>
 <Z4L9PKKNfonI/4E2@JSANTO12-L01.ad.analog.com>
 <20250112122047.1e1978e0@jic23-huawei>
 <20250112131021.5601aaea@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250112131021.5601aaea@jic23-huawei>

On 01/12, Jonathan Cameron wrote:
> On Sun, 12 Jan 2025 12:20:47 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Sat, 11 Jan 2025 20:22:36 -0300
> > Jonathan Santos <jonath4nns@gmail.com> wrote:
> > 
> > > On 01/07, David Lechner wrote:  
> > > > On 1/7/25 9:24 AM, Jonathan Santos wrote:    
> > > > > Add ABI documentation specific to the ad7768-1 device, detailing
> > > > > the decimation_rate attribute for better clarity and usability.
> > > > > 
> > > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > > ---
> > > > >  .../ABI/testing/sysfs-bus-iio-adc-ad7768-1          | 13 +++++++++++++
> > > > >  1 file changed, 13 insertions(+)
> > > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > > > > 
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > > > > new file mode 100644
> > > > > index 000000000000..065247f07cfb
> > > > > --- /dev/null
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> > > > > @@ -0,0 +1,13 @@
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate_available
> > > > > +KernelVersion:
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		Reading returns a range of possible decimation rate values.
> > > > > +
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate
> > > > > +KernelVersion:
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		Sets up the decimation rate for the digital filter. This can
> > > > > +		directly impact in the final sampling frequency. Reading returns
> > > > > +		the decimation rate. Writing sets the decimation rate.    
> > > > 
> > > > If this only affects the filter, I would suggest to add `filter_` to the
> > > > beginning of the attribute names.
> > > > 
> > > > Also, an explanation of how to interpret the numbers would be helpful. It looks
> > > > like a unitless number that acts a sort of a multiplier or divider, but that
> > > > part isn't so clear to me. 
> > > > 
> > > > Or...
> > > > 
> > > > Since the decimation rate affects the -3dB point of the filters we could use
> > > > the standard IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY instead of introducing
> > > > a new attribute.    
> > > 
> > > Well, here the -3dB cutoff depends on the ODR, which is determined by both the MCLK
> > > divider and decimation rate.
> > > 
> > > Wideband: -3dB at 0.433 × ODR
> > > Sinc5: -3dB at 0.204 × ODR
> > > Sinc3: -3dB at 0.2617 × ODR
> > > 
> > > If we use _filter_low_pass_3db_frequency to control the decimation and _sampling_frequency
> > > to control the MCLK divider, wouldn’t it be confusing for one to always affect the other?
> > > A different ODR would result in a different cutoff, and vice versa.  
> > 
> > We should definitely not have a filter control changing sampling frequency (which tends to
> > be a more common control for users to fiddle with).  However the other way around is
> > fine.  So for a given _sampling_frequency present via
> > in_xx_filter_low_pass_3db_frequency_available the list of
> > possible 3db frequencies and use them to configure the decimation.
> > 
> > > 
> > > Would something like <type>[_name]_oversampling_ratio make more sense? Let me know what you think  
> > 
> > I'd rather not if we can avoid that new ABI, but it is is better than a new term
> > like decimation_rate.
> Reading the code I realised I'd misunderstood this question.
> Yes for controlling decimation via oversampling.  Decimation (to me at least)
> means 'ignoring' data but seems here it means averaging it.
> 

Yes, for this device the decimation is indeed averaging the data.

> Controls should be in order of preference
> sampling_frequency (try to keep this constant as others chagnes - if you have to because of range issues,
>   tweak it) This is the rate we get data at after filter.
> oversampling_ratio (again try to keep constant) - controls samples taken per output one.
> _3db_frequency - anything left to control on the filter, or just a RO output of what it currently means.
> 
> Jonathan
> 

Great, then. Decimation will be controlled by oversampling, frequency 
modulator controlled by sampling frequency and _3db_frequency as RO 
attribute, since there are no parameters left.

> 
> 
> > 
> > Jonathan
> > 
> > >   
> > 
> > 
> 

