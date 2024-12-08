Return-Path: <linux-iio+bounces-13241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C7F9E871D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBC62818AA
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701C18872D;
	Sun,  8 Dec 2024 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2WhAP6j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6DC22EE4;
	Sun,  8 Dec 2024 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733679811; cv=none; b=as3RBNeMef3yRk3gzIFfN93rAWomfhdp05NIQKG8ADR6IBzvy/KInZkSv4+dRBl+SOOXHNMBIq+aD7EX2ENVksh2mo+Ru62yCLsHPs8e192Y+i9QgAsR+7DYcgF9gnqW4rxheyh+CchLBmorG//oG2NHuswqAxyiX3+racbYe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733679811; c=relaxed/simple;
	bh=qNenoEFm9DAdkkxGpKFK5c49TtDiYow9qC8qYzpuLRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg0e1dQeVpfwu4LNwTWsd4bFl/i46UAcILLhfjhWcQrw07tglEZjc1fK96LPGJpw9q50Ls6YhsdKQsW/4sffx5QzHEirRlI/xXq6tmuO7bw1xBkbNcYBvz6rhF/ZwVLxip5KRFL3hC2UGO1xZzlHgb+N3RkPWFYOW6rQsIwn5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2WhAP6j; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733679810; x=1765215810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qNenoEFm9DAdkkxGpKFK5c49TtDiYow9qC8qYzpuLRY=;
  b=P2WhAP6je6KQBjsN4EsQlocBQRW7/dADdTbVETwsK8mPuejRMV0mnMEK
   RSjGtA/40GaaG85J5RkfAp3jmJheXoyog+kdZvy70U8EhzO/TuFvAPiVF
   f/qTLboUftDplQ8MpKISAomeWIGUEfGeBOcH5vKkBWDHG2q8L/v1lzJGV
   ElJM+ApMzkw+wz2iq293m4Dm/YEa8OhQja2G161t8eZmGaCc7YpukLtvq
   OhCQ8PH3SeC5Fk/MCTn+ziEiQItDerKgTMZy8GIeItnqv2ktNM0RNEAG2
   Uk8NCbn9GIor64x6snFl4405VnN9bgX2cvgucKz6t98YVo+lXqPpfcWvj
   w==;
X-CSE-ConnectionGUID: Oa2TVbDkQky4hqNMVoLQOA==
X-CSE-MsgGUID: K+oIX9UJQVS7JTbNMt3FLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="44445736"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="44445736"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 09:43:29 -0800
X-CSE-ConnectionGUID: UdW6DrVoT6Ok2Os8C8n1Xw==
X-CSE-MsgGUID: 6L0n9i/MQLWuVlw/FpITCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="99819509"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.245.12])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 09:43:28 -0800
Date: Sun, 8 Dec 2024 18:42:56 +0100
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: kx022a: document new chip_info structure members
Message-ID: <xfjchvcsoeuqz4j2rnqait2jqok7p3jzrs57n4hgzykkqhqkoj@so7z326jfrzv>
References: <Z1LDUj-naUdGSM6n@mva-rohm>
 <20241207180201.51deb7ce@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207180201.51deb7ce@jic23-huawei>

Hi Jonathan,

On Sat, Dec 07, 2024 at 06:02:01PM +0000, Jonathan Cameron wrote:
> On Fri, 6 Dec 2024 11:26:42 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> > The kx022a driver supports a few different HW variants. A chip-info
> > structure is used to describe sensor specific details. Support for
> > sensors with different measurement g-ranges was added recently,
> > introducing sensor specific scale arrays.
> > 
> > The members of the chip-info structure have been documented using
> > kerneldoc. The newly added members omitted the documentation. It is nice
> > to have all the entries documented for the sake of the consistency.
> > Furthermore, the scale table format may not be self explatonary, nor how
> > the amount of scales is informed.
> > 
> > Add documentation to scale table entries to maintain consistency and to
> > make it more obvious how the scales should be represented.
> > 
> > Suggested-by: Mehdi Djait <mehdi.djait@linux.intel.com>
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Applied to the togreg branch of iio.git. Initially pushed out as testing.
> 
> Mehdi, if you want to give a tag (or more feedback) I am happy to rebase
> for a few days.
> 
> Jonathan
> 
> > ---
> > Revision history:
> > v1 => v2:
> > - Improved wording based on discussion with Mehdi.
> > 
> >  drivers/iio/accel/kionix-kx022a.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> > index 142652ff4b22..d18d56cef098 100644
> > --- a/drivers/iio/accel/kionix-kx022a.h
> > +++ b/drivers/iio/accel/kionix-kx022a.h
> > @@ -137,6 +137,14 @@ struct kx022a_data;
> >   *
> >   * @name:			name of the device
> >   * @regmap_config:		pointer to register map configuration
> > + * scale_table:			An array of tables of scaling factors for
> > + *				a supported acceleration measurement range.
> > + *				Each table containing a single scaling
> > + *				factor consisting of two integers. The first
> > + *				value in a table is the integer part, and
> > + *				the second value is the	fractional part as
> > + *				parts per billion.
> > + * scale_table_size:		Amount of values in tables.

I just noticed that the '@' preceding the added members scale_table and
scale_table_size are missing, but I guess you can add those when
rebasing ?

--
Kind Regards
Mehdi Djait

