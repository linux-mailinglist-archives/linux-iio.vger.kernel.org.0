Return-Path: <linux-iio+bounces-27319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A8CD6528
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 15:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C12A83029BAD
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08F7299AAA;
	Mon, 22 Dec 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoNULGpW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC5D2989BC
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766412269; cv=none; b=WeyUP0GH9R1DKgDtD5npZCOok2R0Te47xuZ+1nfgILxFBsZB6XnnpsTw/hfK04s13GAvUoWsb5vPWboHaB04BbLn3+vxZZ872lgck35E+xaWUCfKg4cBgXBMuIgBouM2b/5Ou8iGCapYpVx9BTfTIfy+en51TADt8VeS7mlt9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766412269; c=relaxed/simple;
	bh=RTjNgM0ITKYnZDQHVSfIY3Sx9Hmq2CTMGEMunUJe5E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc3akhqrxYB4kXKKM6hGcOC7NNlLFA9AWOj7mSmsqaCEIuTh3CWrYPBHMDZZhkyoXgkjM7Bv2HilzyWQnRRYYdS2QeBFkr0Luyq3TcAwzoKW7l2jhNGgklvlu+HeGyGOIrZkCs/RfXmxbuaRakgUmhAI4lyIOR9AdBQkDQxOJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoNULGpW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0833b5aeeso54871385ad.1
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 06:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766412267; x=1767017067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZfVme307Ip5Olw5MZrEFy8a58y/dKXNzDim3vtx9ks=;
        b=SoNULGpWFcJD25FXbyk8NI5Yx9H3N8gi5XFfuCH7MUHXsSmmbVowf0cZyA9FG3k30o
         GapzhdEXOPxVqLjT8wmQTOrkfhHIG54355p1w3WWf6QxudkqY1Lej5MXVi6y0zUKA0XS
         4AjTFwV08iSILPGByLIfQ6DZkwh6ilMBgb7Q0JmRF9vgNRF8+I0NA5nDhocg9ASSkKwd
         c9N9s0Kiobhl0gSkiBvL3oK7RqBW8ezXpTLKI8iI/JU2qdoWheUh+eiOoZdHfVvVRU/V
         1PuhhJD+df2Cg4ARE1oF57Y+K/dbgWidIwmQeNjLpLkVQOHAXZUnsk6qQFZDdFATOfvJ
         M/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766412267; x=1767017067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZfVme307Ip5Olw5MZrEFy8a58y/dKXNzDim3vtx9ks=;
        b=HeQEId1EKUAAiKDmmPjUwucFlTfaf1jDte4ClL3QkgGPG3TvYakduyvGK5k0x+RbeH
         UfeOJ4ISfSGT6XAfmf5HUhJMkRIQO3ghe6mmjGKgd2EvQruVHa9/RiT/c/Ok/dNhWhbf
         SuZWAYKLpt1gyxmWZNDtCu8FRN/rUDMZF1C6rQJMBjq2er5fMaAsnYgCuAVtuH4e9G7x
         SbKyYaVmJIZUSrFYAnr3AF3t2vJ253FfhsGGBYUDuxB1tdbNkkTKhsYhN5BhkksASOMX
         XQy//PrxIddtcx7tncgkqPHO3q7NU1H//i+l1lkqALhN3G2yEzJNAlSOveUIDnlsPZQI
         rZzw==
X-Forwarded-Encrypted: i=1; AJvYcCX3d2F2GYoeJitDY5wznBaMS67wcI6z67S0mOx8BSMPKKjKB8QfBBXDqs6U2+8/RMj1ZF/751HnTAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1O0gGyNAVkteQNHgRhcuIKG/+CfhwvZLajO+nsUt+9A90l3xP
	S6D/18eVGcxJXKCC3RShTwdHTNDQ04/geEyfL28J63VytlCVcZnD+4ln
X-Gm-Gg: AY/fxX6L2115/QvEjRzeJidJA/1XT+R9fSHOx3Uek3CZmnFIGrzqaJnuzSQJKdG59Sw
	CFbnFp7tpTrzcMzLVXVmy+NvyH7+V/qLa6WEgoP+ThGjOnyn2333TRWI6T99Hkoot+K0dCcOUfs
	nW0mnQMxcGtu8GoqV9HD1OCNiJKm9El1Yd5gUe9MrtAN2r0QvVNhgejeLj7FioOZRk6NIkv0l1N
	Y2BfGOx8K44ZBnjKJDKXN8SOqmxRa2ScKT7VSXIB34CC/QDZ59waNOZecKMYh2/FIANsSJ/m6j+
	lQi4OU0bdj5WGJ5y137xZROaJCnnlSydrnVnbsNlvtSjzrAWV0wL5qN88eRE8y87HN2W+J4EEPC
	nrSHZY7mWBnHi4y96dQtvTR/DoxWdYmR645o3zh6fr7YtwMTpI40f5VENLP+rihLupuibwnR7Sq
	kfDNBDvjWa8XxnVPfaoUQ=
X-Google-Smtp-Source: AGHT+IFFKJIpMqFaPLAiLBAdahkGioEaKvLEW39RpXSSyzWntz/nWqzu/g3X/Ip0JD3rNwryyK8Kqg==
X-Received: by 2002:a05:7022:6281:b0:11a:2f10:fa46 with SMTP id a92af1059eb24-12172136f9dmr13995103c88.0.1766412267273;
        Mon, 22 Dec 2025 06:04:27 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm50331565c88.12.2025.12.22.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 06:04:26 -0800 (PST)
Date: Mon, 22 Dec 2025 11:06:07 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/14] iio: pressure: mprls0025pa: memset rx_buf before
 reading new data
Message-ID: <aUlQTxtWo0VUi4Yh@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-6-b36a170f1a5c@subdimension.ro>
 <aUYqSUvA9fF_n-0Y@debian-BULLSEYE-live-builder-AMD64>
 <aUZdb9R9BLMfBpLJ@sunspire.home.arpa>
 <20251221182151.288a6da4@jic23-huawei>
 <aUjd5AJHohyW_kXM@lipo.home.arpa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUjd5AJHohyW_kXM@lipo.home.arpa>

Hi Petre,

On 12/22, Petre Rodan wrote:
> 
> hello Jonathan,
> 
> thank you for the review.
> 
> On Sun, Dec 21, 2025 at 06:21:51PM +0000, Jonathan Cameron wrote:
> > On Sat, 20 Dec 2025 10:25:19 +0200
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> > 
> > > Hello,
> > > 
> > > On Sat, Dec 20, 2025 at 01:47:05AM -0300, Marcelo Schmitt wrote:
> > > > On 12/18, Petre Rodan wrote:  
> > > > > Zero out input buffer before reading the new conversion.
> > > > > Perform this operation in core instead of in the bus specific code.
> > > > > 
> > > > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > > > > ---
> > > > >  drivers/iio/pressure/mprls0025pa.c     | 2 ++
> > > > >  drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
> > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> > > > > index 00b1ff1e50a8..7cc8dd0d8476 100644
> > > > > --- a/drivers/iio/pressure/mprls0025pa.c
> > > > > +++ b/drivers/iio/pressure/mprls0025pa.c
> > > > > @@ -16,6 +16,7 @@
> > > > >  #include <linux/mod_devicetable.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/property.h>
> > > > > +#include <linux/string.h>
> > > > >  #include <linux/units.h>
> > > > >  
> > > > >  #include <linux/gpio/consumer.h>
> > > > > @@ -239,6 +240,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
> > > > >  		}
> > > > >  	}
> > > > >  
> > > > > +	memset(data->rx_buf, 0, sizeof(data->rx_buf));  
> > > > This is unusual and I don't think it's needed for the SPI path. Doesn't the I2C
> > > > subsystem overwrite the rx buffer with what it reads from the device?  
> > > 
> > > I thought it's best practice to ensure that old conversions are not accidentally re-used in case the read operation fell thru the cracks.
> > > that's exactly why in this particular case the BUSY flag is implemented on the hardware side.
> > > 
> > > please tell me how a few byte memset() would be detrimental.
> > 
> > We don't normally do this as old data isn't a potential leak of anything
> > sensitive.
> 
> from my point of view as someone writing drivers for chemistry lab instruments, stale readings are to be avoided at all costs.
> it's not about leaking sensitive data, it's about providing a warning sign if the read operation fails silently.
> 
> as an extreme (but fictional) example, a pilot looking at an altimeter would immediately recognize that something is wrong with it's pitot tube if it's giving out an off-scale static reading. if instead the output is believable (which would be the case when older readings are repeated due to an uncaught intermittent read error) then there would be some uncertainty and he would not know to definitely ignore the output of this particular instrument and trust another one instead.
> 
> the same logic applies to any instrument in a lab setting. 
> a digital titration system that mixes multiple reagents needs to rely on fresh conversions to know when to stop a process. some advanced sensors even provide an incrementing conversion counter, others simply signal that a measurement is ongoing/not fresh via a BUSY flag and these are designed so that the driver can avoid a stale reading.
> 
> getting back to my driver, some pressure sensor series have a latch-up sensitivity and they misbehave during reads in various ways under certain conditions. I understand that you say that silent fails are unlikely but I'd like to keep the memset, for peace of mind.

I agree with you that old conversions should not be accidentally re-used nor
errors silently be ignored. But, to me, memset the read buffer to zero looks
like we don't trust the underlying I2C and SPI layers. In that case, we should
fix data read in those subsystems (if there is anyhting be fixed there).
Though probably unlikely scenario to happen, how would one trust the sensor
reading in a scenario where the extected measurement would be close to zero.

My suggestion is to look for a way of ensuring the transfer timing requirements
specified in data sheet page 18 [1]. See the dummy delay transfer suggestion to
patch 09.

[1]: https://4donline.ihs.com/images/VipMasterIC/IC/HWSC/HWSC-S-A0016036563/HWSC-S-A0016036563-1.pdf?hkey=CECEF36DEECDED6468708AAF2E19C0C6

> 
> > However in most drivers this only spills out at all as
> > a result of say a change in configured channels and is normally harmless
> > as userspace knows to ignore stuff in the gaps anyway.  If there is
> > another cases here (you mention the busy flag) then add a comment on why
> > it makes sense. I don't in general want drivers to start doing this as
> > it is in the fast path and sometimes the memset is non trivial (here it
> > is probably irrelevant as the buffer is small).
> > 
> > Thanks,
> > 
> > Jonathan

