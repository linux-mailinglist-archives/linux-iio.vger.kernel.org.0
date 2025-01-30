Return-Path: <linux-iio+bounces-14745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4DA2339B
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 19:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6859C18831C3
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647441EF091;
	Thu, 30 Jan 2025 18:14:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233C8831
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260887; cv=none; b=fJbzSFwg9+Cnmjxv78QOUVA1yRM3hIciPBjEhyxTYtDZ+GcZZLFn/vZ93tRQxqZE3khj+WaSSIk/9N9upxAdi1YXLV8twKBk5bIsr2CXa1PSPRKWUsSTWb5bWGAe9Asv/v2etaFRaocMWue4pJeZhw8PHMf6D2n9v67SyPw96j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260887; c=relaxed/simple;
	bh=apGarcPQlYe5lbhi7aN68BFwJHWs7jzgQpCxdFNh4G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrTZGiRzd/jAl3VoSBQmmx9xtqRZPl1cgdpXoyqHQxsjA9glSPIalCbw3YpeuYwitatvUBfIf0/5etvtIT5W7580P3U7Y/WfA7stxOY+XaFtXaEo/TN0ktLX06b/Ojl7rekdNdwiCA50Bxwv0S/aLg+PYfk6WJB5931zC+4luKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: wj/L3HGmS7qmfYltoXR09g==
X-CSE-MsgGUID: uYDj9J5iQlmiI8LNfgAltg==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38022825"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="38022825"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 10:14:45 -0800
X-CSE-ConnectionGUID: Ir5KT+8ETt+6XdDls0X8Bw==
X-CSE-MsgGUID: jjhjg8jeRD2gdhop8PlqVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="109362162"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 10:14:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tdZ3n-00000006kFx-2dp0;
	Thu, 30 Jan 2025 20:14:39 +0200
Date: Thu, 30 Jan 2025 20:14:39 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Walle <michael@walle.cc>, Nuno Sa <nuno.sa@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4130: Fix comparison of channel setups
Message-ID: <Z5vBj62990oPT0QK@smile.fi.intel.com>
References: <cover.1738258777.git.u.kleine-koenig@baylibre.com>
 <584b8bae1ad158fc86bd1cd9bd3dcae54b58093e.1738258777.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <584b8bae1ad158fc86bd1cd9bd3dcae54b58093e.1738258777.git.u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 30, 2025 at 06:45:01PM +0100, Uwe Kleine-König wrote:

...

> +	BUILD_BUG_ON(sizeof(*a) !=
> +		     sizeof(struct {
> +				    unsigned int iout0_val;
> +				    unsigned int iout1_val;
> +				    unsigned int burnout;
> +				    unsigned int pga;
> +				    unsigned int fs;
> +				    u32 ref_sel;
> +				    enum ad4130_filter_mode filter_mode;
> +				    bool ref_bufp;
> +				    bool ref_bufm;
> +			    }));

Is I shuffle the fields (for whatever reason) this may give false positive
warnings. I think this BUILD_BUG_ON() is unreliable and ugly looking
(static_assert() won't help much here either), so on the second though I think
it's better to simply add a comments in both places (here and near to the
structure definition) to explain that these needs to be in sync.

> +	if (a->iout0_val != b->iout0_val ||
> +	    a->iout1_val != b->iout1_val ||
> +	    a->burnout != b->burnout ||
> +	    a->pga != b->pga ||
> +	    a->fs != b->fs ||
> +	    a->ref_sel != b->ref_sel ||
> +	    a->filter_mode != b->filter_mode ||
> +	    a->ref_bufp != b->ref_bufp ||
> +	    a->ref_bufm != b->ref_bufm)
> +		return false;
> +
> +	return true;

-- 
With Best Regards,
Andy Shevchenko



