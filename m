Return-Path: <linux-iio+bounces-17398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29149A76033
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 09:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A1516835B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2491C3C08;
	Mon, 31 Mar 2025 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+BuwBX2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF211BD9E3;
	Mon, 31 Mar 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406634; cv=none; b=aId4VykM6C2nN/oRBEJpfAUrldWmxbcgsiWjd36GP6Y67vPE6PIsO5yaRZE3SFLuB766C25+oAtjRAf7whW5SUQ53nmh4UuxPjE1OSiQKAIVWrRIi/2R97Cu4zNirLHMl8oBFG3rC4KnWd51zJ/8UFb0BrtmErsyLjjru8GC1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406634; c=relaxed/simple;
	bh=pq0XkENy6BPmERuIcHD+0mcyeJVx4XQVikkemxoOxBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyztrvDkPu2NJEB7kzM7EKANTTERqAinbqWTqg+UsNVLMCoLP2AYyk8uNm/YpbTo6TB9o4OEdeLbUXhMPMMBAK09TnXKEI/IyDFOV2TNmpPmhchSbqYBjO8chh8LFtTRcR+LlxOX5hcKdZoNasz+9rQ0zDlGp+pmG1q4uOVhzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+BuwBX2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743406633; x=1774942633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pq0XkENy6BPmERuIcHD+0mcyeJVx4XQVikkemxoOxBY=;
  b=H+BuwBX2P8x0xjkC7/mJyZZ5Sv8+PxxBsRxC+Fqj4GLXSXOTZiRC3lT/
   39Ml/UckHeXkGA4HvpJxl606BUQQ3WdtpBEORmInuwwCjbuv2b5ljdopJ
   GKBYXKFmBXfuaJpaOL9CIQO8kS5H0+f3VwbIimzK04z2L6kzXwBtdjmlf
   56VvasqRn8I0tqyjJ/KGjCIsaFiuwF/qTMxeO+T6o6JuBfSHTMbJZlcOx
   YCSMqnwYFbFITNenIexaEF8w6/3I+B8sVKQZ0B4+6fBGfdoDcPKtUUvOl
   FFLU62IInNdPqcygBsTHiqWLyMQuEgO9Epshn/P7v4+2bR9WljbdLSTzb
   g==;
X-CSE-ConnectionGUID: x5xVMc+GRQm6LJWmzzwBRg==
X-CSE-MsgGUID: MOjbb3QsTD+C81N7orsw7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="70043517"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="70043517"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 00:37:12 -0700
X-CSE-ConnectionGUID: m//Nq2RmSa2yReBtlve5bg==
X-CSE-MsgGUID: WZ31RkDkQYiHbwBX3hZhWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="157012270"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 00:37:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tz9hh-00000007apW-043q;
	Mon, 31 Mar 2025 10:37:05 +0300
Date: Mon, 31 Mar 2025 10:37:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <Z-pGIMC7cu0QPBzi@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
 <20250316110237.0b558248@jic23-huawei>
 <222c5fa7-283b-48ce-9d01-34ca633674eb@gmail.com>
 <20250330170436.0fc14b64@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330170436.0fc14b64@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Mar 30, 2025 at 05:04:36PM +0100, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 13:24:07 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > On 16/03/2025 13:02, Jonathan Cameron wrote:
> > > On Thu, 13 Mar 2025 09:19:03 +0200
> > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:  

...

> > >> +	return (data->alarm_monitored[chan->channel] & BIT(dir));  
> > > 
> > > Drop the outer brackets as not adding anything.  
> > 
> > I just noticed that the integer returned from here is directly provided 
> > to the user-space. I don't know the history, but it feels a bit off to 
> > me. I mean, I would expect the read from sysfs file "*_en" to return '1' 
> > or '0' - not 0x04.
> > 
> > Oh well, I suppose it's too late to change this in the IIO core - but 
> > I'll do:
> > 	return !!(data->alarm_monitored[chan->channel] & BIT(dir));
> 
> Agreed it should be returning 1 or 0.
> 
> This stuff is a little bit messy.  I'd not be against that ABI
> cleanup if we squashed the values to 0,1 in the core as a follow up.
> 
> I doubt anyone relies on getting 0x4 as that would be very driver
> specific userspace code!

FWIW, the time this discussion was held, I looked at the code and it seems
we have such drivers. I doubt we can change it without potential breakage of
(some) user space tools.

-- 
With Best Regards,
Andy Shevchenko



