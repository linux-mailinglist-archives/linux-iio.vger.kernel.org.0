Return-Path: <linux-iio+bounces-27448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FB1CEC72F
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 19:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1B7F3022F3F
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B832FA0EF;
	Wed, 31 Dec 2025 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwXzQ0kf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA32BD033;
	Wed, 31 Dec 2025 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204722; cv=none; b=sa7BocyvHSBzWUSiG0fAAox8GR5l5NgSkwoChZv8vP4NFQulRpqSjYANw0c7PI4QTDoMW0k770+lbP4BVkI9cE8DHfOdSjzBtPayrSjjG+jaiEBfGKD5iV9E5ArNaWp19cZhmt/96fe1myBQMUMSz2sIuO8PulD+r5gBBcGRtuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204722; c=relaxed/simple;
	bh=NtvlE+8EZBddqH9geff8v4rapWBE7FQ6RKa3xRqMNkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMjj+ETtsn1XS8ulValj7aZCQ6zQEc+nnjSJzZhSHz/T9/spCVKCDNp9dJ0IP/n0rQ+0VneMpMFMi/KmE192dN7bRJGXTTbmkJ/0cjQRezKL0nYr/O7AABpGcUALXzpCHNSY0aPCoiOwQM/HhowXOfjLOOuNfI1wrUf0kwVGbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwXzQ0kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5629AC113D0;
	Wed, 31 Dec 2025 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767204721;
	bh=NtvlE+8EZBddqH9geff8v4rapWBE7FQ6RKa3xRqMNkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BwXzQ0kf38eJA7mADvyFAtuz+4phdJxWiJVAfQdOaUhxfzdarWyEuWbQnCCRPPKDE
	 //r8w8nT/H0cwJnvYh/iMd529IRg4ngMv8f7t7Nqqs8asToaqVXXMGWc9X2HlaTaE4
	 WkCwdLGvkF5FWNUhOV1qnFFRIpm0Y44uCzW6CQ8f+GTfw5h/BmLH7rLiEpOgyCj152
	 77+vs1AWTq3WB8FEKJCcgznMT392vGK6XJtErO7/SDlv4usFm9/ym/J+HE5kMci4so
	 idyBvwfcWVtl4uYHsb0ZXWrrB7Sw8KfZqZmSnOB1qesqa1bHq8V7ojeIEXj8tpNnfB
	 i6OOvyR3F4V1Q==
Date: Wed, 31 Dec 2025 18:11:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/6] staging: iio: ad9832: remove dds.h dependency
Message-ID: <20251231181153.556f14fe@jic23-huawei>
In-Reply-To: <20251231180939.422e9e62@jic23-huawei>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
	<20251230203459.28935-5-tomasborquez13@gmail.com>
	<20251231180939.422e9e62@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Dec 2025 18:09:39 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 30 Dec 2025 17:34:57 -0300
> Tomas Borquez <tomasborquez13@gmail.com> wrote:
> 
> > Remove dependency on dds.h by converting custom macros to standard IIO
> > attribute declarations.
> > 
> > Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>  
> Hi Tomas,
> 
> Happy new year (almost)
> 
> > ---
> >  drivers/staging/iio/frequency/ad9832.c | 37 +++++++++++---------------
> >  1 file changed, 15 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > index 4bb203a67046..aa78973c3a3c 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -24,8 +24,6 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  
> > -#include "dds.h"
> > -
> >  /* Registers */
> >  #define AD9832_FREQ0LL		0x0
> >  #define AD9832_FREQ0HL		0x1
> > @@ -238,27 +236,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
> >  	}
> >  }
> >  
> > -/*
> > - * see dds.h for further information
> > - */
> > +static IIO_DEVICE_ATTR(out_altvoltage0_frequency0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> > +static IIO_DEVICE_ATTR(out_altvoltage0_frequency1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> > +
> > +static IIO_DEVICE_ATTR(out_altvoltage0_frequencysymbol, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
> > +static IIO_CONST_ATTR(out_altvoltage0_frequency_scale, "1"); /* 1Hz */  
> 
> This seems like a pointless attribute.  Default scaling for everything in IIO when
> attributes don't tell us otherwise is 1 so should be fine dropping this one.
> 
> > +
> > +static IIO_DEVICE_ATTR(out_altvoltage0_phase0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
> > +static IIO_DEVICE_ATTR(out_altvoltage0_phase1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
> > +static IIO_DEVICE_ATTR(out_altvoltage0_phase2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
> > +static IIO_DEVICE_ATTR(out_altvoltage0_phase3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
> > +
> > +static IIO_DEVICE_ATTR(out_altvoltage0_phasesymbol, 0200, NULL, ad9832_write, AD9832_PHASE_SYM);
> > +static IIO_CONST_ATTR(out_altvoltage0_phase_scale, "0.0015339808"); /* 2PI/2^12 rad */  
> 
> I can't immediately think of precedence for scaling of an attribute other than
> _raw.  Whilst it's painful, this isn't a high perf path, so we should probably
> just do fixed point inputs for phase0,phase1 etc and deal with the scaling
> in the driver.  That avoids adding new ABI for this very rare case.
> 
> >  
> > -static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> > -static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> > -static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
> > -static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
> > -
> > -static IIO_DEV_ATTR_PHASE(0, 0, 0200, NULL, ad9832_write, AD9832_PHASE0H);
> > -static IIO_DEV_ATTR_PHASE(0, 1, 0200, NULL, ad9832_write, AD9832_PHASE1H);
> > -static IIO_DEV_ATTR_PHASE(0, 2, 0200, NULL, ad9832_write, AD9832_PHASE2H);
> > -static IIO_DEV_ATTR_PHASE(0, 3, 0200, NULL, ad9832_write, AD9832_PHASE3H);
> > -static IIO_DEV_ATTR_PHASESYMBOL(0, 0200, NULL,
> > -				ad9832_write, AD9832_PHASE_SYM);
> > -static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12 rad*/
> > -
> > -static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
> > -				ad9832_write, AD9832_PINCTRL_EN);
> > -static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
> > -				ad9832_write, AD9832_OUTPUT_EN);
> > +static IIO_DEVICE_ATTR(out_altvoltage0_pincontrol_en, 0200, NULL, ad9832_write, AD9832_PINCTRL_EN);  
> 
> I'm not that keen on having the documentation only several patches later. Drag that
> before this patch or combine adding the new ABI and documentation in the same patch
Ah. I'd missed that this is deliberately a no change patch with old abi.

So ignore the stuff that doesn't make sense with that in mind!

> 
> Jonathan
> 
> 
> > +static IIO_DEVICE_ATTR(out_altvoltage0_out_enable, 0200, NULL, ad9832_write, AD9832_OUTPUT_EN);
> >  
> >  static struct attribute *ad9832_attributes[] = {
> >  	&iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,  
> 


