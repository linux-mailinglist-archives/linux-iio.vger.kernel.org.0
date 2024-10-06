Return-Path: <linux-iio+bounces-10228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5BE991E18
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4AC51F21B9A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349CD175548;
	Sun,  6 Oct 2024 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+/Uf6eC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BCA29;
	Sun,  6 Oct 2024 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728214040; cv=none; b=Yl9aQPW8J7+59ZWbvw/Lq696AQeq861osQu2G6Q6lSI9yL15XYGmOvETw6RJaUi66PElQ4fFDN92REVNcWCQv9so1gu6FrWqAmageBEKgg8WcYvd6PWWhz+1rC5N4MypsgrLMW/CD2vhfgUE/SEwnQnTWo5faXj+SRHDSS8M8Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728214040; c=relaxed/simple;
	bh=GJyroqFA3A1Djt9tw1U4cgp9/G/Phrqepsh/OddSNF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i04kN0R2Ho60wp5y8lJuNl/ZsoFGJHz7UmYPfcqssx6slx3v0b4VyH+Cr6VdPyhhEXeUjAbxnxu9kbr2vIEJsmipwFrJnmDJ4ZKJUzc++bGriQbHuM06cD9fZ9WkWnnlapyVB0UpTrZnBPt0FjpLzYFMxIxuA7Sl0G/yfcvraOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+/Uf6eC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D67C4CEC5;
	Sun,  6 Oct 2024 11:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728214038;
	bh=GJyroqFA3A1Djt9tw1U4cgp9/G/Phrqepsh/OddSNF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j+/Uf6eC1j4k0olEBp5ohafGlUD9K+PfrKmOC9vWVTPYm3Hv92TQEdm07RXz/4Inu
	 tOMIU7tbQlwrGONfZ69NWTLh3XKJjvn0x0iSht60Crf5RGL1p31PhmNmiYKUdcv86h
	 6oy2hyTO+x0WlCB2nwPIWy2QpqgpbC6n/SMy6iOsqYMNMuFNrcijfOADHGRzIrUEkV
	 2Vr5/dvM++8IRnUTJUK92TDCF9KDLaxa3ktRitRS516uKIqMLqczyzeAQGQlDHOYUz
	 MFHU3Iuxvd8w5RhEq9ID8UTePhAUHPp8p19OXo5VfElRSw4nZEa2nUtGdD4EzAv9EY
	 X3d+uTVSSRNoA==
Date: Sun, 6 Oct 2024 12:27:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tudor Gheorghiu <tudor.reda@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH] staging: iio: frequency: rename macros
Message-ID: <20241006122712.2cff065c@jic23-huawei>
In-Reply-To: <Zvy0qyQJP1S17SFv@redaops>
References: <20241001202430.15874-2-tudor.reda@gmail.com>
	<20241001225426.wUBOFdMi@linutronix.de>
	<Zvy0qyQJP1S17SFv@redaops>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 05:49:15 +0300
Tudor Gheorghiu <tudor.reda@gmail.com> wrote:

> On Wed, Oct 02, 2024 at 12:54:26AM +0200, Nam Cao wrote:
> > 
> > You probably want to elaborate what you mean by "their naming choice" (i.e.
> > how does the naming choice causes this false warning?)
> > 
> > I got curious and digged into checkpatch.pl. This script expects macros
> > whose names match "IIO_DEV_ATTR_[A-Z_]+" to have the first integer argument
> > to be octal. And this driver defines macros which "luckily" match that
> > pattern.
> > 
> > There is only IIO_DEV_ATTR_SAMP_FREQ which matches the pattern, and accepts
> > umode_t as its first argument.
> > 
> > Instead of changing code just to make checkpatch.pl happy, perhaps it's
> > better to fix the checkpatch script? Maybe something like the untested
> > patch below?
> > 
> > Or since checkpatch is wrong, maybe just ignore it.
> > 
> > Best regards,
> > Nam
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 4427572b2477..2fb4549fede2 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -817,7 +817,7 @@ our @mode_permission_funcs = (
> >  	["debugfs_create_(?:file|u8|u16|u32|u64|x8|x16|x32|x64|size_t|atomic_t|bool|blob|regset32|u32_array)", 2],
> >  	["proc_create(?:_data|)", 2],
> >  	["(?:CLASS|DEVICE|SENSOR|SENSOR_DEVICE|IIO_DEVICE)_ATTR", 2],
> > -	["IIO_DEV_ATTR_[A-Z_]+", 1],
> > +	["IIO_DEV_ATTR_SAMP_FREQ", 1],
> >  	["SENSOR_(?:DEVICE_|)ATTR_2", 2],
> >  	["SENSOR_TEMPLATE(?:_2|)", 3],
> >  	["__ATTR", 2],  
> 
> Hi!
> 
> Yes, this is exactly what I discovered while inspecting checkpatch
> myself, however it did not occur to me this could be a problem with
> checkpatch. But looking deeper, it seems like it is:
> 
> IIO_DEV_ATTR_SAMP_FREQ is defined in include/linux/iio/sysfs.h, along
> with other helper macros:
> 
> > /**
> >  * IIO_DEV_ATTR_SAMP_FREQ - sets any internal clock frequency
> >  * @_mode: sysfs file mode/permissions
> >  * @_show: output method for the attribute
> >  * @_store: input method for the attribute
> >  **/
> > #define IIO_DEV_ATTR_SAMP_FREQ(_mode, _show, _store)			\
> > 	IIO_DEVICE_ATTR(sampling_frequency, _mode, _show, _store, 0)
> > 
> > /**
> >  * IIO_DEV_ATTR_SAMP_FREQ_AVAIL - list available sampling frequencies
> >  * @_show: output method for the attribute
> >  *
> >  * May be mode dependent on some devices
> >  **/
> > #define IIO_DEV_ATTR_SAMP_FREQ_AVAIL(_show)				\
> > 	IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO, _show, NULL, 0)
> > /**
> >  * IIO_DEV_ATTR_INT_TIME_AVAIL - list available integration times
> >  * @_show: output method for the attribute
> >  **/
> > #define IIO_DEV_ATTR_INT_TIME_AVAIL(_show)		\
> > 	IIO_DEVICE_ATTR(integration_time_available, S_IRUGO, _show, NULL, 0)
> > 
> > #define IIO_DEV_ATTR_TEMP_RAW(_show)			\
> > 	IIO_DEVICE_ATTR(in_temp_raw, S_IRUGO, _show, NULL, 0)  
> 
> The checkpatch script will match all these macros, even if
> IIO_DEV_ATTR_SAMP_FREQ is the only one where we need to check for octal
> literal arguments. I grep'd through the entire sourcecode, and the only
> false positives with literal decimal arguments which match "IIO_DEV_ATTR_[A-Z_]+"
> are inside this driver.
> 
> I accidentally discovered this issue by running
> checkpatch on the said driver files.
> 
> I will submit a patch to the checkpatch maintainers with this thread
> linked, and if they agree this is a bug and accept the patch,
> this driver patch will no longer be needed, since checkpatch will no longer flag
> these macros as false positives.
> 
> Do I have your permission to add your name and email to Suggested-by?

Hmm. If you really want to clean this up, then these macros shouldn't
exist at all.  They are legacy of ancient IIO code style and some slightly
ropey code even then (which is why it's in staging!)

Right option is to use the read_raw callbacks in conjunction with the
info_mask_* bitmaps that indicate which attributes the IIO core should create.
There are some corners in here such as PHASESYMBOL for which we've
never fixed on an ABI and that might need custom attributes, but even
then these macros probably wouldn't be involved.

So I'd don't mind 'fixing' checkpatch or the code, but I'd
rather we fixed the drivers up properly.

However I would also like someone from ADI to input on whether they plan
to clean these up in future?  Or is this something you'd support someone
else doing? I quickly checked one of them and the ad9832 is still a production
part so they may be interest in a clean upstream driver.

+CC Nuno to chase that question down.  This is the ad9832 and ad9834 DDS
chips.  ADI are doing a good job at bringing out of tree code in at the
moment, but it would also be good to finally tidy up the remaining stuff
in staging (or dump it once and for all!)

Jonathan



> 
> Thanks!
> Tudor


