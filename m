Return-Path: <linux-iio+bounces-10578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 135EB99D6C2
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 20:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97DB5B214E0
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DC51C9ECD;
	Mon, 14 Oct 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3De4mpp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E8E83CDA;
	Mon, 14 Oct 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931840; cv=none; b=h9lQEfzhn6NM3KDcDAHfFJ3YZb2U+v/JjncaW6UEnniBB+n8kT7g3FbbQRVok9OlfRgHbsUxv1lOj3ZzRoXG9LxCwddRxx0tmBwd6bogPliApw/uQKudd9CMKByOxhEqirZn6gYinYcEuJGwRgcEMegdtTrs7dPgIMFD2a+bFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931840; c=relaxed/simple;
	bh=8CxyoZM6b0iTDZyQblZinhoqLPT7pox/70+HNj5UqKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W48lzlM049U2XAnkQ0s8vhHTVBb5EbH30FWQe+2g2vFLlMMeqnZZzz0ij0lwFYb4h6gGFOc6mbxvEhIB5Llo4doJFyR/+ssw/YkSahuB9SR46TdtYDLe/s7p5s2xdO+nkxRMUmQGJwR/71rLHeMlFQSLdIiEqo/d4lDdwODdAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3De4mpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A05C4CEC3;
	Mon, 14 Oct 2024 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728931839;
	bh=8CxyoZM6b0iTDZyQblZinhoqLPT7pox/70+HNj5UqKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j3De4mppJnukKXTdDs813rYewsw9vrlZuHNUG+BO6heYvN/kFEVdtYOeox6ATxemd
	 cAA+r0X+iFKb9FYeXXo3tZ4NzypYBFAGe9+cGQwNAmxYN2CkjDH57OlBZKODIai08K
	 2fjsOwBYeMsXFxwHHOhMvM+iHeSH+qpaFkVZVVbIdyUPDeMsHwWeBDDo/kbVINH2v9
	 1HYnhVRp6FX/5jJb5d0rFirlaMLUWjE2IWBIWCNW/HadWcwWdH+OtQ94xC2+kC9Hs8
	 oCjQoVX9fq2q0nUWPHNyurbGo5VYGmlu2w1PQN25F8T8ohfcm/AkXya0KlKD+odX0S
	 Pc7KQc6Hny+KA==
Date: Mon, 14 Oct 2024 19:50:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>
Subject: Re: [PATCH 1/3] iio: imu: Add i2c driver for bmi260 imu
Message-ID: <20241014195031.741dff13@jic23-huawei>
In-Reply-To: <87jzeboi3g.fsf@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-2-justin@justinweiss.com>
	<20241012120830.338aca19@jic23-huawei>
	<874j5grafd.fsf@justinweiss.com>
	<20241013161457.506c2296@jic23-huawei>
	<87jzeboi3g.fsf@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Oct 2024 13:36:51 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Jonathan Cameron <jic23@kernel.org> writes:
> 
> >> >> +static const struct acpi_device_id bmi270_acpi_match[] = {
> >> >> +	{ "BOSC0260", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
> >> >> +	{ "BMI0260",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },
> >> >> +	{ "BOSC0160", (kernel_ulong_t)&bmi270_chip_info[BMI260] },
> >> >> +	{ "BMI0160",  (kernel_ulong_t)&bmi270_chip_info[BMI260] },    
> >> >
> >> > Sigh.  That's not a valid ACPI ID or PNP ID.
> >> > (Well technically it is, but it belongs to the Benson Instrument Company
> >> > not Bosch)
> >> >
> >> > Which of these have been seen in the wild?
> >> > For any that are not of the BOSC0160 type form add a comment giving
> >> > a device on which they are in use.    
> >> 
> >> I know of the BMI0160 (this seems to be the most common way the BMI260
> >> is identified on handheld PCs), and the 10EC5280 has been seen in the
> >> wild, as described here:
> >> https://lore.kernel.org/all/CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com/
> >> 
> >> I have not personally seen any devices using BMI0260, but I'll add
> >> comments to the BMI0160 and 10EC5280 entries with some examples of
> >> devices that use those IDs.  
> >
> > Drop any we don't have evidence are out there.
> >
> > Do we have any confirmation from Bosch (or products in the wild) for
> > the structurally correct BOSC0160 etc?  Those would normally have
> > to be tracked by Bosch as allocated for this purpose.
> >  
> 
> I haven't seen any reported, but the Windows driver INF has all five of
> these entries listed. I don't see any evidence of the BOSC0160 or
> BOSC0260 being used other than that Windows driver file.

Ok.  Lets leave the extras out for now and see if anyone screams.

> 
> BMI0160 seems by far the most common, with some appearances of 10EC5280
> (some AYANEO devices, possibly some GPD Win Max 2 devices) and BMI0260
> (OrangePi NEO).
> 
> >>   
> >> >> +	{ "10EC5280", (kernel_ulong_t)&bmi270_chip_info[BMI260] },    
> >> >
> >> > What's this one?  There is no such vendor ID.
> >> >    
> >>  
> > ...
> >  
> >> >>  
> >> >>  static const struct of_device_id bmi270_of_match[] = {
> >> >> -	{ .compatible = "bosch,bmi270" },
> >> >> +	{ .compatible = "bosch,bmi270", .data = &bmi270_chip_info[BMI270] },    
> >> >
> >> > If the bmi260 supports SPI, should be added here as well. (I've no idea if it does!)
> >> >
> >> > Or is this because you can't test it?    
> >> 
> >> Yeah, it was because I can't test it, the BMI260 does support SPI. I can
> >> add entries here, though.
> >> 
> >> Should the ACPI match entries from I2C also go here? All of the devices
> >> with mismatched IDs seem to use I2C so there might not be as much of a
> >> problem here.  
> > We want the incorrect formatted ones to be as hard to use as possible to discourage
> > them going into new products.  Can't do anything to solve the i2c cases
> > but definitely don't want to allow them for SPI as well if no evidence
> > of products where it yet matters.
> >
> > If we have confirmation from Bosch of the BOSC forms, then those I would like
> > in the SPI drivers as well (to point to the correct option for anyone using
> > this in future!)
> >
> > Jonathan
> >    
> 
> Agreed. Since we don't have confirmation of the correct values here or
> any that are in use, I would be OK either adding the single BOSC0260
> entry (as a guess, which may or may not be used) or leaving it out
> entirely until an entry is needed.
> 
Add that one as it might encourage anyone who happens to consider Linux
support to do this right...

If anyone has contacts at Bosch to moan at about their garbage use
of ACPI IDs in windows drivers, please do.

Jonathan

> Justin
> 
> >>   
> >> >>  	{ }
> >> >>  };
> >> >>      
> >> 
> >> Thanks again,
> >> Justin  


