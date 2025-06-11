Return-Path: <linux-iio+bounces-20440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5549AD5990
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764CE7AAE0A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1FA1B4132;
	Wed, 11 Jun 2025 15:05:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A2119A2A3;
	Wed, 11 Jun 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654325; cv=none; b=gG5QltTyeWDemWn0QUwnPIxaEfjxCIrJZpXvSImQ/LyuqXZHTurugMfBSpTk16icNqwTNQYTINrcA7yl/mLwF88gzX21ISRX27yhXj8dTqX/uIzXRps6UpmpqcrM+FRj/l/oz1Eg3xy2gZUc04un677A59shY8R/q0N44eAY6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654325; c=relaxed/simple;
	bh=QjLClqRVz+CYv9XhfFqEgl6l63rKHLxQAkX0Xetgals=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUv7jo4oZF1wYzxgTevD/ekv6SN3SWT8M43O3YL+n+6J63pqqteb2N4L1b2oyf/Hjmyjz1YunVnz/F9KVkTqjjPVaFIHdIk+MqJNy8+C+q8jfXrBaxu7fWanfQoihRInQ5a6DF1U2/vqedLEaEOBmAFjNpsG8LyyhcAfmwzGe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: OhNPaFf7REWPC7v5kdZMKg==
X-CSE-MsgGUID: qelceS6nRRyJHJd7f1xDgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="50908907"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="50908907"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:05:23 -0700
X-CSE-ConnectionGUID: AKVC6IMFTp+oftk7hDHREQ==
X-CSE-MsgGUID: fakhjhUMQeeGy573vEOD8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="178131513"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:05:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1uPN0u-00000005g9z-1arZ;
	Wed, 11 Jun 2025 18:05:16 +0300
Date: Wed, 11 Jun 2025 18:05:16 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, bagasdotme@gmail.com,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/11] iio: accel: adxl313: add activity sensing
Message-ID: <aEmbLG0S5P7m35a-@smile.fi.intel.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
 <20250601172139.59156-8-l.rubusch@gmail.com>
 <CAHp75VemOXhpRp2hfDhvzi3y5j5oL-_0xMmWRWkwEtX7Ks5nMQ@mail.gmail.com>
 <CAFXKEHZcS2qpb1zp6kkQm_Pb-MxYHErpjD=q6huuLm1Nq=xjqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFXKEHZcS2qpb1zp6kkQm_Pb-MxYHErpjD=q6huuLm1Nq=xjqA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 11, 2025 at 04:49:34PM +0200, Lothar Rubusch wrote:
> On Sun, Jun 1, 2025 at 9:38 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Jun 1, 2025 at 8:22 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:

...

> > > +       int ret = -ENOENT;
> > > +
> > > +       if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
> > > +               ret = iio_push_event(indio_dev,
> > > +                                    IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > +                                                       IIO_MOD_X_OR_Y_OR_Z,
> > > +                                                       IIO_EV_TYPE_MAG,
> > > +                                                       IIO_EV_DIR_RISING),
> > > +                                    ts);
> > > +               if (ret)
> > > +                       return ret;
> > > +       }
> > >
> > >         if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
> > >                 samples = adxl313_get_samples(data);
> > >                 if (samples < 0)
> > >                         return samples;
> > >
> > > -               return adxl313_fifo_push(indio_dev, samples);
> > > +               ret = adxl313_fifo_push(indio_dev, samples);
> >
> > This is not needed...
> 
> IMHO this will be needed, or shall be needed in the follow up context.

Right, but wouldn't be better to update at the same time when this new context
appears?

> The [going to be renamed] function push_events() shall evaluate the
> interrupt status register for the events the driver can handle and
> also eventually drain the FIFO in case of watermark. It shall
> distinguish between failure, events / drain the FIFO which can be
> handled, and events which cannot be handled so far. It's not a if /
> else, there can be some event, and some fifo data. Therefore I'd like
> not a simple return here, but init a ret var.
> 
> I interpreted your reviews, to change the particular implementation as
> if there was just activity. Then in a follow up patch, rewrite it
> again, now to distinguish just bewteen just activity and inactivity
> e.g. by if/else. Eventually rewrite it by a third approach to
> distinghish activity, inactivity, AC-coupled activity and AC-coupled
> inactivity, might be now switch/case. Eventually you might complain
> that my patches contain way too much modification of every line in
> every patch.
> 
> I'd rather like to start right away with the final structure with just
> the first element - e.g. "activity" - leads to results like the above.
> Less churn among patches, but having just one element looks like
> having taken an over-complicated approach.
> 
> Perhaps it's my patch split? Unsure, I tried to note in the commit message:
> > This is a preparatory patch. Some of the definitions and functions are
> > supposed to be extended for inactivity later on.
> Perhaps it needs more feedback here?
> 
> Another example is seting up the read/write_event_config() or
> read/write_event_value() functions. I mean, eventually this will
> become a switch/case implementation. Of course with just one element
> switch/case seems to be obvious overkill. Going by your advice, I
> changed it to if(!..) return, it's definitely cleaner. Definitely in
> the follow up patches this will be rewritten, though.
> 
> Please, let me know what is the best approach or what I can improve to
> avoid such "ping pong patching" as you name it?
> 
> Might be that you're right here in this particular case, but then it
> would be better to discuss the final structure, isn't it?

Basically I use the following rule of thumb: I made an approach and look at
the each patch separately and at the series as a whole (with the end result).
If it's too much of rewriting (yes, I admit, that in some cases it's
unavoidable to have some changes as we do feature-by-feature incremental
changes), I try to rethink. Repeat, until the result looks good enough.
I.o.w. you, as the author of this code, can propose something better based on
your knowledge of the HW and vision of what you want at the end.

Yeah, this might require time and a few attempts which one can argue would be
waste of time. But at least this is my personal experience and flow with my
own patches.

> > >         }
> > >
> > >         /* Return error if no event data was pushed to the IIO channel. */
> > > -       return -ENOENT;
> > > +       return ret;
> >
> > ...and this looks wrong.
> 
> Well, as I said. Each separate if-condition (not just if-else), could
> be ok or not. If ok, the function still shall continue, might be at
> the end, also a watermark flag is in the status reg and the FIFO needs
> to be drained. It also might be, that some event comes which the
> driver does still not handle, but not necessarily an error
> (missconfiguration). So, draining the FIFO helps in most cases to
> bring a derailed sensor back on track. If not doing so, it silmply
> stops working, you would need to turn off and on again, or even power
> cycle the setup.
> 
> Probably you have a better idea here, but pls have a look into the
> final setup. I really appreciate your feedbacks. I understand this is
> a rather problematic part of the code. To me it makes sense like this,
> but I'd highly appreciate your advice.

I will do my best. Thanks for your patience!

> > Before the case was clear, if we have no respective bit set in the
> > int_stat, we return ENOENT. Now it depends on the other bit. If this
> > is correct behaviour, it needs a comment.

-- 
With Best Regards,
Andy Shevchenko



