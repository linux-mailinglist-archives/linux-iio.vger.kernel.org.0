Return-Path: <linux-iio+bounces-12993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BC39E17EB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 10:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D8A28143C
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457EB1DF275;
	Tue,  3 Dec 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkHyWEza"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CDE4317C;
	Tue,  3 Dec 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218811; cv=none; b=T4nLRZiVQCJLNTQo9EFBC+k1RY8RaHAlphT0/JZQYz5V6g8SF/x6L5Cwj9aAHw0jvpWCnq/SQqn5JqmffG5O2Cn9q4nFoSLC+xAxlHTf5kRBYk5KQy2tKrr4hPMKD/Mhui36FN5HzT+/q+2QIXhLr91YZqZA0ida92NnP1e2sp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218811; c=relaxed/simple;
	bh=VyrUYMa578zw6pEH8jSCJqFz/bzLSDHZBN9Dus5sMxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSnpz3k+5Piw48uG2bqH5iLCHdod+Q0dGJx/Vdluumm6T/OhPdSc4C9PWQKN3fWuipBPhJSdFG73kWqV2E1PRQvHrO6Ka6Vq6EGnU2UiwtCupHaNe2ESGWynvQPJ+Qg/j4aCawPEE5Xxv3CFDs7tAUQwesOWCyXH7BoHcWMravI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkHyWEza; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733218809; x=1764754809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VyrUYMa578zw6pEH8jSCJqFz/bzLSDHZBN9Dus5sMxE=;
  b=jkHyWEzaa7XvUO8BZqUJWnqdcipVUu1LWcBFdToa++LqUBJAxJRtxecN
   0UGzQCO71U11U3qOYnHFNjsEU01GFUAcsZ/1RcHhNBnau8WJlDnQUlJ+L
   rzYWr04Xd5KoOEJrlxMc+jNNqIs3dG1gqbBAdBT3z42gWr54UvwmD+H0y
   PqYcGMk3we1Ri8bmXGSepSaCZ7zga1Wh1O4LTo//ZvHtL0puNL3RrWf/s
   qAIaq7Az2TPhXiiN59R08+JkknVZvIu2RSQrtzuubmwHRD9BNb/+uIpLw
   2/XqgaGAPlclx5PInbebccjfPG3hAr/9fgY1abw+L/TZjT6GUpibf2r/4
   Q==;
X-CSE-ConnectionGUID: tPouXByPTH6GPBF8qCzl5w==
X-CSE-MsgGUID: KbKmgBhqRdaKChCBMuCA0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44810356"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44810356"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 01:40:08 -0800
X-CSE-ConnectionGUID: robPXPqQSzygKe5cbd/zyQ==
X-CSE-MsgGUID: 1MrU5W2mTTKHIw/dZ+geWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="94216522"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.238])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 01:40:07 -0800
Date: Tue, 3 Dec 2024 10:39:58 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: kx022a: document new chip_info structure members
Message-ID: <y6intisaqsyfvyvmkgzmeyojc3punimy3uhtp6a25gm4tn77yc@oikj64bmtebt>
References: <Z02eXtrrO8U5-ffo@mva-rohm>
 <hv7kqspym5qkcwbw4r6ogi362sbooohijplxbkro5qdmndvhr6@t2cftbs4n7rz>
 <4004fafd-7596-4def-bf78-e91685f0c934@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4004fafd-7596-4def-bf78-e91685f0c934@gmail.com>

Hi Matti,

> > >   drivers/iio/accel/kionix-kx022a.h | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> > > index 142652ff4b22..82c4ced7426d 100644
> > > --- a/drivers/iio/accel/kionix-kx022a.h
> > > +++ b/drivers/iio/accel/kionix-kx022a.h
> > > @@ -137,6 +137,11 @@ struct kx022a_data;
> > >    *
> > >    * @name:			name of the device
> > >    * @regmap_config:		pointer to register map configuration
> > > + * scale_table:			Array of two integer tables containing
> > > + *				supported scales. Each scale is represented
> > > + *				a 2 value array. First value being full
> > > + *				integers, second being NANOs.
> > 
> > How about:
> > 
> > Array of tables containing two scaling factors for the supported
> > acceleration measurement ranges. First value is the integer part and
> > second value is the fractional part in nano units.
> > 
> 
> Hi Mehdi. Thanks for the input. I definitely prefer your wording over what I
> wrote. Except maybe the note about each table containing two scaling
> factors. I think a table contains two integers, but only one scaling factor
> which is composed of those integers.
> 

that is true, it is just one scaling factor.

> I am also still wondering if ppb (or even fully written "parts per billion")
> should be used instead of nano. In my ears the "nano" needs units, but I
> suppose the scale does not have any.
> 

So how about:
Array of tables containing a scaling factor for the supported
acceleration measurement range. First value is the integer part and
second value is the nano fractional part.

or:
Array of tables containing a scaling factor for the supported
acceleration measurement range. First value is the integer part and
second value is the nano/ppb (parts per billion) fractional part.

> Yours,
> 	-- Matti

--
Kind Regards
Mehdi Djait

