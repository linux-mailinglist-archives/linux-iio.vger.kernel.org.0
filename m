Return-Path: <linux-iio+bounces-9791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AB5987537
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 16:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E87B237D7
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44D7136349;
	Thu, 26 Sep 2024 14:12:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6FD26296;
	Thu, 26 Sep 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359939; cv=none; b=leHNvu8m8oiveDcEAyw7zks2nAEdgaSmZGy4kkuRZzRzqL2R8Ej/6dxkWK5QqAkGDlphNCiArME55pSXANjdtrY8/5SCRMLRpCfIOwqki0m9Ck6weqAboQUkNbfFf9Dkg5ZePe+gFxx8a+1G3CE4utit6LI0YfcRUcp0rgppBhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359939; c=relaxed/simple;
	bh=2nhtvdFj51Zs02wrpcBijb6ad+R6L05k2rianj2S1tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUXKOLb4yyavIsad0nqL8GqPjKpJo8wMjUpY3esvOOP7gmCocXqK2Cxc9xogz/UCLNK8hh65PC9N1qiI/pkEtSxfejqFXsdZWxNke+zpDx6Tffl6eUikKfsqJYBOqkcc9jQJiTDGc3LJgD5FUDaceLEwcCbMDxpFh6RMXjOaEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 7Udm/fb4SwGMvc3IHD6Q9A==
X-CSE-MsgGUID: NcAND5wTQ5uiXWDKVqXEDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26595452"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26595452"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:12:09 -0700
X-CSE-ConnectionGUID: iV47HJ+RRnSx71Rt6yhgMg==
X-CSE-MsgGUID: vQHYOvx/TQmvpv1A/Llysg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="76941762"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:12:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1stpDu-0000000DDeC-0hey;
	Thu, 26 Sep 2024 17:12:02 +0300
Date: Thu, 26 Sep 2024 17:12:01 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <ZvVrsXrm8XBYGeRn@smile.fi.intel.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
 <20240926135418.8342-3-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926135418.8342-3-ramona.nechita@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 26, 2024 at 04:53:56PM +0300, Ramona Alexandra Nechita wrote:
> The filter mode / filter type property is used for ad4130
> and ad7779 drivers, therefore the ABI doc file for ad4130
> was removed, merging both of them in the sysfs-bus-iio.
> Since one of the drivers is available from 6.1, the version
> has been set to 6.1 for these attributes.

...

> +Description:
> +		Reading returns a list with the possible filter modes. Options
> +		for the attribute:
> +			* "sinc3"	- The digital sinc3 filter. Moderate 1st conversion time.
> +		    Good noise performance.
> +			* "sinc4"       - Sinc 4. Excellent noise performance. Long
> +			1st conversion time.
> +			* "sinc5"	- The digital sinc5 filter. Excellent noise performance
> +			* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
> +		    time.
> +			* "sinc3+rej60" - Sinc3 + 60Hz rejection.
> +			* "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
> +		    time.
> +			* "sinc3+pf1"   - Sinc3 + device specific Post Filter 1.
> +			* "sinc3+pf2"   - Sinc3 + device specific Post Filter 2.
> +			* "sinc3+pf3"   - Sinc3 + device specific Post Filter 3.
> +			* "sinc3+pf4"   - Sinc3 + device specific Post Filter 4.

I still think that a compromise to leave the existing values as an example in
the existing bindings is a good to have.

But if Jonathan thinks otherwise, I'm not against it.
For the rest
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



