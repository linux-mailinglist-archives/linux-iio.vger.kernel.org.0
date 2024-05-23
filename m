Return-Path: <linux-iio+bounces-5208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED648CD127
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EBE1F22464
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D0145B33;
	Thu, 23 May 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlmcoavo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B02746F;
	Thu, 23 May 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463312; cv=none; b=l1tdSIlfoG/+2pRgg9Qp4H4ry5J2K3tAyWj7N18MTZUziko4S5X85FMGhWmCbgCwGTVgMFrLNvEQilWut8v8TwCIj9Sy7/Oi2uOjrDCx9W17TKzg/Dsue/5rv8W6/hC67uJ9A06CH/mz5x0zJwGjQIBMU+JD4xu8/u7vp7xeXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463312; c=relaxed/simple;
	bh=eNlIxiqDzedCnOeX0xoj9OjpK35zUFeGYBak2boMgzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ/t85Tfd7YNQ6ZM98AtXIvYzNzKOsinjyUU8VSFtwbs/7wWgS11pRerdsyqqDDiRiSBOiPCAmQYkk1JnSebnC2YgcgfRKFIfdEjxL2bHTOJxqNJcvsegXJHq30Ioy7TnQE5XKGPM+SFYzEZAS0VQjdW6k5jjxRUR0QbV/QrfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dlmcoavo; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e576057c2bso111158351fa.1;
        Thu, 23 May 2024 04:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716463309; x=1717068109; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=asqwjj/YdEsrYXQGdSoC0a/xfkjKBOz+Tei0ANsb2Oo=;
        b=DlmcoavoIP87jmLMNeSvCLRE0cJrQmj7cqNALOm83UpbUgZQ+hSGeze0v+Yl5Hm+Rb
         bCU7/Q3LHGsGtunDAnuUSz0pkjnyT9zsp9/7Jay2s2PY9zX5sy7g/O8L+CnJXwLklTlB
         3BlcMuOR8BdlL/tgKfroG2rENfEhBYBKSjbLvbvbAzXn98uYBpExmEtebaYidk5PI+lp
         zKNEJt3+HmG0bErx/Boxe22S513JaEFZ8e5BXsI8eIqdgme6dgFk+mEbW4/MfYnIm23q
         bJ+FgrYWMbthJC/aw5d24UfwvW6dkPcxv1TuJ7eYpKChXLHfVVagPfmLE7jHKSIQvesY
         uaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716463309; x=1717068109;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asqwjj/YdEsrYXQGdSoC0a/xfkjKBOz+Tei0ANsb2Oo=;
        b=QUYfNxcEXAMeQSpdcCKRWzhTP/zrTh/L8oyCtyeaTNFgObysOi5B7UTRngz1+G9Bwu
         Avr9g5OS4McLT1MRc4TJOCMPIn6G77np/c/UjfteGO7ZVqnBavtU9EYfiaz2KuZfSsxe
         ZIysvfhroSYvswrhqktd4N4hiGfpZE2vLcXXBPT0cy5EYfR+zsaMrN5caFhAWLteuv9Z
         lNi9NOGqd207GWYNkp9A2AZGZYwoiznugkHWbcumR2mi2f2Ox0ZtfDO281D1hJPv3POz
         7uQwhc2e3tieswg9F6Q4lE8hxuVgC6QUI7OOLYtC0uSYGKWZ5KoG3EDYUc2SMixrQVYo
         71VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTDtn+ZQ8pw5Uoq+OEiMaQUFEMXcMTfAmfzV13uyHYkb9n4DQzrnfUBj5v9lFsqDZqotWjyblw7id100G2ovHu1wPgF2RjOKQA6QvJyCS1D0wl3MX8202r35k+t7NzH3YKgT6DHaRw
X-Gm-Message-State: AOJu0YwHSlvpJ+YceeE+B8JUxEVp8zGzC/Zxx9Vl4n/Zj94jFAm3H+nT
	+Xv77b9M9bjLa4Ir6ZF8UldKerVS5SZBrc+FswcfJcev4DvYKWlY
X-Google-Smtp-Source: AGHT+IGM0g3nsTRP7Ys88GWXMtA5nlv5SymajA2Gk9zudU0Qveo6rp3T5jqP/JjGaQHLkUG+t2U+ig==
X-Received: by 2002:a05:651c:10a7:b0:2e9:485d:45a4 with SMTP id 38308e7fff4ca-2e949466b84mr35709191fa.16.1716463308741;
        Thu, 23 May 2024 04:21:48 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7dd4sm1920033566b.139.2024.05.23.04.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:21:48 -0700 (PDT)
Date: Thu, 23 May 2024 13:21:46 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Hepp <andrew.hepp@ahepp.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/2] iio: temperature: mcp9600: Provide index for both
 channels
Message-ID: <20240523112146.GB513807@debian>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
 <20240517081050.168698-2-dima.fedrau@gmail.com>
 <20240519171438.08810789@jic23-huawei>
 <23efcf4c-b5b2-d245-931f-0420e61701fe@ahepp.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23efcf4c-b5b2-d245-931f-0420e61701fe@ahepp.dev>

Am Mon, May 20, 2024 at 10:28:10PM -0400 schrieb Andrew Hepp:
> Hi all,
> 
> I attempted to send this yesterday, but I guess I leaked some HTML into the
> message and it was rejected from the lists. I am resending it now as plain
> text. Apologies for any inconvenience or confusion.
> 
> On 5/19/24 12:14 PM, Jonathan Cameron wrote:
> > On Fri, 17 May 2024 10:10:49 +0200
> > Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> > 
> > > The mapping from cold junction to ambient temperature is inaccurate. We
> > > provide an index for hot and cold junction temperatures.
> > > 
> > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > Hi Dmitri,
> >
> > I'm not sure you replied to the question in previous review of what
> > sysfs files exist for this device.  Whilst I am at least a little
> > open to changing the ABI, I'd like to fully understand what
> > is currently presented and why iio_info is having trouble with it.
> > 
> > I also want an ack from Andrew on this one given might break it existing
> > usage.
> 
> I’m not actively using the cold junction temperature reading, so I would be
> happy to see any deficiencies in the ABI corrected.
> 
> > 
> > The current interface is perhaps less than ideal, but I don't think it
> > is wrong as such. Whilst I wasn't particularly keen on the cold junction
> > == ambient I'm not sure moving to just indexed is an improvement.
> > Hence looking for input from Andrew. +CC Nuno as someone who is both
> > active in IIO and has written thermocouple front end drivers in
> > the past.
> 
> The ABI docs state
> 
>     The ambient and object modifiers distinguish between ambient (reference)
> and distant temperatures for contactless measurements
> Reading more of the Linux Driver API docs, those say that .modified is "used
> to indicate a physically unique characteristic of the channel”, and that
> .indexed is "simply another instance”.
> 
> I’m not sure whether measuring temperature at a different location meets the
> bar of a “physically unique characteristic”. Maybe it does. But I don’t
> think of the cold junction temperature as “simply another instance”. Perhaps
> that’s a mistake on my behalf.
> 
> Reviewing temperature drivers using IIO_MOD_TEMP_AMBIENT, they all seem to
> be reporting die temperatures. Some are IR sensors, but there are a couple
> other thermocouples like the MCP9600.
> 
> Reviewing drivers using “.indexed”, one is an IR sensor and one is a
> thermocouple. In both cases, the indexed channels seem to represent a “full
> featured” channel. The IR sensor also reports IIO_MOD_TEMP_AMBIENT, so they
> chose not to make it an additional index.
> 
> It seems to me that using IIO_MOD_TEMP_AMBIENT is more in line with what has
> been done in the past. But I may be misunderstanding something and I am not
> opposed to using and index if it’s determined that is more correct.
>

Thanks for the explanation and the effort, must have taken some time. I
think you are right. I will remove the patch from the series, so that no
ABI change takes place.

Best regards,
Dimitri

> Thanks,
> Andrew
> 
> > 
> > Jonathan
> > 
> > 
> > > ---
> > >   drivers/iio/temperature/mcp9600.c | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > > index 46845804292b..22451d1d9e1f 100644
> > > --- a/drivers/iio/temperature/mcp9600.c
> > > +++ b/drivers/iio/temperature/mcp9600.c
> > > @@ -14,6 +14,9 @@
> > >   #include <linux/iio/iio.h>
> > > +#define MCP9600_CHAN_HOT_JUNCTION	0
> > > +#define MCP9600_CHAN_COLD_JUNCTION	1
> > > +
> > >   /* MCP9600 registers */
> > >   #define MCP9600_HOT_JUNCTION 0x0
> > >   #define MCP9600_COLD_JUNCTION 0x2
> > > @@ -25,17 +28,19 @@
> > >   static const struct iio_chan_spec mcp9600_channels[] = {
> > >   	{
> > >   		.type = IIO_TEMP,
> > > +		.channel = MCP9600_CHAN_HOT_JUNCTION,
> > >   		.address = MCP9600_HOT_JUNCTION,
> > >   		.info_mask_separate =
> > >   			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > > +		.indexed = 1,
> > >   	},
> > >   	{
> > >   		.type = IIO_TEMP,
> > > +		.channel = MCP9600_CHAN_COLD_JUNCTION,
> > >   		.address = MCP9600_COLD_JUNCTION,
> > > -		.channel2 = IIO_MOD_TEMP_AMBIENT,
> > > -		.modified = 1,
> > >   		.info_mask_separate =
> > >   			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > > +		.indexed = 1,
> > >   	},
> > >   };
> > 

