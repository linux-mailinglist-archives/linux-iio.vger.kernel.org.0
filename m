Return-Path: <linux-iio+bounces-19766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1460CABF098
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 11:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF26C4E47BC
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD225A2AE;
	Wed, 21 May 2025 09:58:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B37259C8B;
	Wed, 21 May 2025 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821533; cv=none; b=AVfJ02acA9+X1T/Nq1PRj18UfCpT9MO93Af6fkzV308olKhxUKXIuTrKhhf1bxO0RiA39rqUAa0Zx64LTdLQKRSOo2/DHttj4LZ/tJBv/mnjxdF0E0r+zPWiwlY+aKzbSjURG932uXGPUpyWWSvBFtmKYvf2frBni/4iVX8SUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821533; c=relaxed/simple;
	bh=/AEdO5xOOYcRYmyslAG1dnL4NyVxYBFOODoOflYKuK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+fB6bXoC2TEaIQlVseMr92nki7wvrMoEG902DUEXyZHZ9Sz+XSiCvTWh+rqu9rGPrIiFbGtljLaTQqXhZtsAWrNRGohSwGVo6meFS3BMOp3xEzkZR/XPV2mVUHqPHCMNK6kF5uHuaQD4rhNtxnC9LrUeVMq/fOOHmlJNTeMeBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: cfYk2Vp+Sa2LC7O3R2JZOw==
X-CSE-MsgGUID: LIRdZfzOQZaz5ES8IGKZqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="67204643"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="67204643"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 02:58:51 -0700
X-CSE-ConnectionGUID: SQjm8CQ8T4edxqW5+apF5g==
X-CSE-MsgGUID: AOY/iVoNSRGkWPmzoGkpBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="163272720"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 02:58:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uHgDl-00000003a2x-1YlF;
	Wed, 21 May 2025 12:58:45 +0300
Date: Wed, 21 May 2025 12:58:45 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/12] iio: accel: adxl313: add activity sensing
Message-ID: <aC2j1U11BqkDn2II@smile.fi.intel.com>
References: <CAFXKEHavquk_oyhMpkawkKUwnfNA_eFWH5XYFsZQkM1_-Rh6Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXKEHavquk_oyhMpkawkKUwnfNA_eFWH5XYFsZQkM1_-Rh6Vg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 20, 2025 at 10:25:03PM +0200, Lothar Rubusch wrote:
> > On Sun, May 18, 2025 at 11:13:18AM +0000, Lothar Rubusch wrote:

...

> > > +static int adxl313_set_act_inact_en(struct adxl313_data *data,
> > > +                               enum adxl313_activity_type type,
> > > +                               bool cmd_en)
> > > +{
> > > +   unsigned int axis_ctrl = 0;
> > > +   unsigned int threshold;
> > > +   bool en;
> > > +   int ret;
> > > +
> > > +   if (type == ADXL313_ACTIVITY)
> > > +           axis_ctrl = ADXL313_ACT_XYZ_EN;
> > > +
> > > +   ret = regmap_update_bits(data->regmap,
> > > +                            ADXL313_REG_ACT_INACT_CTL,
> > > +                            axis_ctrl,
> > > +                            cmd_en ? 0xff : 0x00);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type], &threshold);
> > > +   if (ret)
> > > +           return ret;
> >
> > > +   en = false;
> >
> > Instead...
> >
> > > +   if (type == ADXL313_ACTIVITY)
> > > +           en = cmd_en && threshold;
> >
> >       else
> >               en = false;
> >
> > > +   return regmap_update_bits(data->regmap, ADXL313_REG_INT_ENABLE,
> > > +                             adxl313_act_int_reg[type],
> > > +                             en ? adxl313_act_int_reg[type] : 0);
> > > +}
> 
> The above is a good example for the following. From time to time, I face
> the situation in a function where I'd like to end up with something like
> 
>     if (foo = A) {
>         var = thenDoA();
>     } else {
>         var = thenDoB();
>     }
>     doSomething(var);
> 
> In a first patch I'll introduce only the following and remark in the
> commit message, that this will be extended. Since smatch/sparse tool
> will complain, I'll need to fiddle around with initializations
> (becoming obsolete in the end), e.g. I'll end up with something like
> this in a first patch A:
> 
>     var = nonsense;
>     if (foo = A) {
>         var = thenDoA();
>     }
>     doSomething(var);
> 
> This is the case for switch(type) case IIO_...MAG: as only type (for
> now). This is the case for this is_act_inact_enabled(),
> set_act_inact(), etc.
> 
> I assume it's better to simplify each commit individually and don't
> leave the "churn" around which might make sense in combination with a
> follow patch? Is this a general approach I should follow?

I believe so.

> Or, can it be legitimate to just split an if/else and add if-clause in
> a patch A and the else clause in the other patch B, since both are
> probably actually not complex. Such that patch A for itself looks a
> bit odd, but will make sense together with patch B?

Yes, but just make sure the each of the patches (after being applied) give the
plausible result.

...

> > > +static int adxl313_read_event_config(struct iio_dev *indio_dev,
> > > +                                const struct iio_chan_spec *chan,
> > > +                                enum iio_event_type type,
> > > +                                enum iio_event_direction dir)
> > > +{
> > > +   struct adxl313_data *data = iio_priv(indio_dev);
> >
> > > +   bool int_en;
> >
> > Why? You return the int here... I would expect rather to see unsigned int...
> >
> > > +   int ret;
> > > +
> > > +   switch (type) {
> > > +   case IIO_EV_TYPE_MAG:
> > > +           switch (dir) {
> > > +           case IIO_EV_DIR_RISING:
> > > +                   ret = adxl313_is_act_inact_en(data,
> > > +                                                 ADXL313_ACTIVITY,
> > > +                                                 &int_en);
> > > +                   if (ret)
> > > +                           return ret;
> > > +                   return int_en;
> >
> > ...or even simply
> >
> >                       return adx1313...(...);
> >
> > > +           default:
> > > +                   return -EINVAL;
> > > +           }
> > > +   default:
> > > +           return -EINVAL;
> > > +   }
> > > +}
> 
> This one here is interesting, to my understanding I followed here e.g.
> the approach of the ADXL380 which is supposed to be a quite recent
> driver [the _read/write_event_config() there.]

> Now, your remark made me think: I'm unsure, can I actually I implement
> the following approach here?
> - return >0 : true

=1, but yes. We have plenty of functions like this in the kernel.

> - return =0 : false
> - return <0 : error
> 
> It seems to work (unsure about the  error cases, though),
> but much cleaner and simpler! I'll send that in v2,
> pls let me know if I missunderstood you.

-- 
With Best Regards,
Andy Shevchenko



