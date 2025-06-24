Return-Path: <linux-iio+bounces-20936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24785AE5DA3
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 09:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDB24008AC
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F648254B09;
	Tue, 24 Jun 2025 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQoBOm1u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D856253B47;
	Tue, 24 Jun 2025 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750092; cv=none; b=Km+UVoTT/eK9QAOabAQAbl4TV/MPC/QklqAaxYwL8e6ptTtoWgSbGcifjsG8tHUBlEjIUraE1HwNXQOnxoPj5f/aaflSwGnLWLiEqokxibyzhXfGy1URTa9BIJB32j/ea6kueD3ZR4LBVhFed90iX0oDJbS9Oxrt1VFuNoSr+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750092; c=relaxed/simple;
	bh=UpuqpA1vESFJrEGfO1lC4nqQldZ8FEUumluvqyaDbBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrVITrr7jg7EIf1FKNK1nRNvtn1yEWeiiITTBLO+SpE90YXzd2WjcGtPLd5WCOayBEMc1vs/JvwfRqbdhvN5wk5bx6pjtCHT60DnPy/YJzFyplkaKTf7YH14wwCLWB1X7+IVABQuBTfnKPAKywbFRw2ZqaBHxU6PnB52PjpYRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQoBOm1u; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750750091; x=1782286091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UpuqpA1vESFJrEGfO1lC4nqQldZ8FEUumluvqyaDbBk=;
  b=VQoBOm1uPuTdsZ3ADKs6GM/2mj4roeU+5cwnLuzrAZTdQ4iMYZf1mIHD
   D593yxPbQtkN4NyQX/u2qj8/fvKZI4Gj+7vIesExR3ioUszkiX0QVUPLR
   cMxM8OpLn3c/pmVZNkMQNtFjnQeVosSzWizgrQr1Dbsxr+BEXqmB8wYli
   dsf+Q7l5BcqVXc3z3P2pQ+ls2h2Mn1x9kFgW2N4io0quocmHYNfNL8ZJH
   xkHOnpxXJW5aBFaveXyQJ2fKDK50b4HthwTLsjvAauCZ4rCO91QrwsyFH
   T0WjDjHO+vM5uwkKT9qvHd1L51edOTRZeNv1w6K+47JfOiFeZwv2fheXM
   w==;
X-CSE-ConnectionGUID: A+DgpJoERG2qzfuIz2IkpA==
X-CSE-MsgGUID: 71ZKqBfeT02lAJHoIcgxjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="64037746"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="64037746"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:28:10 -0700
X-CSE-ConnectionGUID: Z71nk8nYRuilM5ZhEUrI1g==
X-CSE-MsgGUID: 9J55saeBROyC+lAS1DxVoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="189035512"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 00:28:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTy4Y-00000009PAK-47rV;
	Tue, 24 Jun 2025 10:28:02 +0300
Date: Tue, 24 Jun 2025 10:28:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v10 3/7] iio: accel: adxl345: add activity event feature
Message-ID: <aFpTgoEIkWorp_pQ@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
 <20250622155010.164451-4-l.rubusch@gmail.com>
 <aFkfjAekGJTU5o71@smile.fi.intel.com>
 <CAFXKEHbGThKzMxg=aZMgVEZ2S2hUoGAOoE5wu_vCuzEPqL0+cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHbGThKzMxg=aZMgVEZ2S2hUoGAOoE5wu_vCuzEPqL0+cA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 23, 2025 at 10:57:39PM +0200, Lothar Rubusch wrote:
> On Mon, Jun 23, 2025 at 11:34 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sun, Jun 22, 2025 at 03:50:06PM +0000, Lothar Rubusch wrote:

...

> > > +     case IIO_EV_TYPE_MAG:
> > > +             return adxl345_read_mag_config(st, dir,
> > > +                                            ADXL345_ACTIVITY);
> >
> > It looks like you set the editor to wrap at 72 characters, but here the single
> > line less than 80! Note that the limit is *exactly* 80 character.
> >
> 
> I have my setup adjusted to 80 characters. Anyway, the cases here is
> different, it needs
> to be seen in context of the follow up patches. I tried to prepare the
> patches now in a way
> where changes are mostly "added". Is this correct and desired patch preparation?
> 
> In the particular case, this patch now adds ACTIVITY. A follow up
> patch will add INACTIVITY.
> Since this is still building up, it will add yet another argument to
> those functions, i.e.
> > > +             return adxl345_write_mag_config(st, dir,
> > > +                                             ADXL345_ACTIVITY,
> 
> will become, later
> > >               return adxl345_write_mag_config(st, dir,
> > >                                               ADXL345_ACTIVITY,
> > > +                                             ADXL345_INACTIVITY,

Yeah, but with the difference that you still remove the added line in the case
above (as this example is not the same as what we are talking about).

I think you wanted more something like

		return adxl345_read_mag_config(st, dir,
					       ADXL345_ACTIVITY);

ito become

		return adxl345_read_mag_config(st, dir,
					       ADXL345_INACTIVITY,
					       ADXL345_ACTIVITY);

> To make the change more additive, I did linebreaks earlier than 80
> characters. Is this
> legitimate in this case?

I think so.

> If so, I'll keep all related formatting as is (and will only change
> the other requests).

Sure.

> Otherwise, I can do it differently and adopt all the formatting
> changes to prioritize 80 characters.

-- 
With Best Regards,
Andy Shevchenko



