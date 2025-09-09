Return-Path: <linux-iio+bounces-23903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99BAB4FC29
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DBDA16DDC3
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5885D2DFF04;
	Tue,  9 Sep 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yj27dGsb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097233A038;
	Tue,  9 Sep 2025 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423713; cv=none; b=HmrC0eqJWXqmqYflrKkL9Mw3LhMJaxoL5ybz4qwIjy2C987cjgiA8e4ycRHEHEUeIVPKoRd0t+kqTKSlRUFbTjW1BpovokqKcW3yZydZTd9NeX68HktZHj6tNjXiYRi+ONGGvdUcimuyd+pT6MMYUhEJ0ll729tZAtj2jIke/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423713; c=relaxed/simple;
	bh=/ESSoS9CuhXSl+kOhQway3WlPy+udplWXPG3zRrJY7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN1yheJ8LKowEjWdb52ERnAA8Bt6YYYoHam18Fx2uT/E6v0uIehIMpetD4kvUV30yeE3WYgIef/d33d+gOcLfEIXXSrp1tReru5L+VWsjRnbhK4mQKVDjt9myA9WuQMBpMVPLwR+glPcF2Ld61NFQNdxq9ipv3VCTwBNHSLSVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yj27dGsb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757423712; x=1788959712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ESSoS9CuhXSl+kOhQway3WlPy+udplWXPG3zRrJY7U=;
  b=Yj27dGsbrRc6NasKWUZaV1bETP6utKM6stjTUfgj61ng59XdN+Y+O0ut
   /2sAko5fZIH7mRey019t0Lwfjny5HQTIWPquDa07pphncrasNv/gwzEkX
   id8ZLwFAWcCvRUy33sqalQGddv1iyC4LBLgbpqubB97/UTbVAo/lMlf68
   i+wEhRN8sxoqNqb13Rm8otebr7+xw6gqkdwQY33cw2Haa7Bi3KKZ2YD8R
   yD/2KaecsHOlH+v+T7/yuCEQIWsN2+Yirj5l7BCMkHjJ1ds7RxREFmqQ6
   lHPgWvulxbE5MzXR8VJVb1EA6/+asibPMNnnKKBBYULz/AUSV4lDq0pbT
   g==;
X-CSE-ConnectionGUID: 49mS2U9MQ2m+oRT2CRY95A==
X-CSE-MsgGUID: NIrLgYa2Q2an49pBkp2TaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="63342496"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="63342496"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 06:15:11 -0700
X-CSE-ConnectionGUID: i8oS7dJjRymM8LlIf0uWzQ==
X-CSE-MsgGUID: lDFgcWJUQ++PxXSBhO/Yog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="177376556"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 06:15:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uvyBd-00000001Rmp-0jQj;
	Tue, 09 Sep 2025 16:15:05 +0300
Date: Tue, 9 Sep 2025 16:15:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	rafael@kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 5/5] iio: imu: inv_icm42600: use guard() to release
 mutexes
Message-ID: <aMAoWPAvOmOfgfaR@smile.fi.intel.com>
References: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
 <20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com>
 <aMAR4Jx3pWQ1_rjX@smile.fi.intel.com>
 <wl4fvd76hjf66k6pmkoce5wg5luspxjjsclxg5pdh7rjycarko@ovddl55mn77l>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wl4fvd76hjf66k6pmkoce5wg5luspxjjsclxg5pdh7rjycarko@ovddl55mn77l>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 09, 2025 at 11:53:02AM +0000, Sean Nyekjaer wrote:
> On Tue, Sep 09, 2025 at 02:39:12PM +0100, Andy Shevchenko wrote:
> > On Tue, Sep 09, 2025 at 09:11:11AM +0200, Sean Nyekjaer wrote:

...

> > >  	/* exit if FIFO is already on */
> > >  	if (st->fifo.on) {
> > > -		ret = 0;
> > > -		goto out_on;
> > 
> > Probably you wanted the same comment here
> > 
> > 	/* increase FIFO on counter */
> > 
> > > +		st->fifo.on++;
> > > +		return 0;
> > >  	}

...

> > >  	/* exit if there are several sensors using the FIFO */
> > >  	if (st->fifo.on > 1) {
> > > -		ret = 0;
> > > -		goto out_off;
> > 
> > In the similar way
> > 
> 
> Considered it. But isn't it obvious whats happening?

With the same equality existing ones may be killed. Some of consistency at least :-)

> I will be happy to add them...

> > 	/* decrease FIFO on counter */
> > 
> > > +		st->fifo.on--;
> > > +		return 0;
> > >  	}

-- 
With Best Regards,
Andy Shevchenko



