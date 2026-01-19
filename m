Return-Path: <linux-iio+bounces-27975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 659A1D3B33E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B928030022F6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1545F30E0FD;
	Mon, 19 Jan 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHHR4ab+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFE3009D4;
	Mon, 19 Jan 2026 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842439; cv=none; b=ZkT/FNSs7itT3MR6CNdkatwkNh0wTRCtMnmJn+besgQWzWKS4hurHCqEBA/Hs02WZi/G4XwA4mrBR4jnX7JVZUvlcU0/zZFNLRI+MLNnllME9GbpsZ2+Qt0GItgCAsY06/yGGORoNk/v/0hvbdHEU1OEj0Kwp/c8TeJwg/eFD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842439; c=relaxed/simple;
	bh=umGUgXUvr1uT8JukHyQuH75tpKnMXwJ4gEX/wfj8CtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcQ5DB5JIB/dDDq8nobct9dzXapoaTeESf4LLwfvgxyZvYWzwbeCu9cMVOVVYrAoNigRcN2VeXjwmNVPjAH/+4aWcFTHVfC6+AKKZUYCirgIZsae3oqLgbkyg4Vg7Hb77AKZdjy3PasCI6D4yAYEHlUsr/trVjiXTkxPKltKAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHHR4ab+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768842438; x=1800378438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=umGUgXUvr1uT8JukHyQuH75tpKnMXwJ4gEX/wfj8CtA=;
  b=jHHR4ab+7JpwK1gYGr4JY/sWVe0ISoIFShy+jKlxhqfA5LtLjYNfIDu7
   xD1M5hB2HiR6O5jo9tP9ZXqqdXtYXD8B/cIMsW/7bWon6IHqFv+VNy1Ub
   ap5pZu7QCVCFLzUFdJCU8TwAP0X9ArTB8g/OX9GuLV/qJutfEXPEbfP6n
   6GQrJ+0IF1USSpqpW9TMoWLl+c8c/XMqFp6LOm2WE4REJezef5E4BgFe+
   JybR8E+xmYa9VI+mTHExc6Dj5N2IdhMUtoh5zueegWvHX0+5YJQLZWRiT
   KMd28ftdly8BBCBPaVpR9JFBpUFpgwFr8txtYj0PHS7xhxgXOCmu6yUR1
   w==;
X-CSE-ConnectionGUID: zv7KStBWR7OiX77KClAtJw==
X-CSE-MsgGUID: 1T2l/CgJSQOtH5egFF+aHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70106619"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="70106619"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 09:07:17 -0800
X-CSE-ConnectionGUID: FDZ5n+reQkmsVYELbboAOQ==
X-CSE-MsgGUID: hKjQXR76SVSKRSyem0tumA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="243497123"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 09:07:13 -0800
Date: Mon, 19 Jan 2026 19:07:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/7] iio: frequency: adf41513: driver implementation
Message-ID: <aW5kk6K30Izckvg5@smile.fi.intel.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
 <20260116-adf41513-iio-driver-v4-3-dbb7d6782217@analog.com>
 <aW3dxuelYDM67pqZ@smile.fi.intel.com>
 <texwv5s2tvcy34bwr4iruj5xofmea663pwletmpqpuh66zulmv@m7qvjgqbhalv>
 <aW40ylvMwVhqNQMw@smile.fi.intel.com>
 <hgy3bcrqqsvt7pobhnzuvwzhb2taetpxltkaxpigmmlvmlirod@v6anhmrsvv2r>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hgy3bcrqqsvt7pobhnzuvwzhb2taetpxltkaxpigmmlvmlirod@v6anhmrsvv2r>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 04:37:09PM +0000, Rodrigo Alencar wrote:
> On 26/01/19 03:42PM, Andy Shevchenko wrote:
> > On Mon, Jan 19, 2026 at 11:21:59AM +0000, Rodrigo Alencar wrote:
> > > On 26/01/19 09:31AM, Andy Shevchenko wrote:
> > > > On Fri, Jan 16, 2026 at 02:32:22PM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > > > +static int adf41513_parse_uhz(const char *str, u64 *freq_uhz)
> > > > > +{
> > > > > +	u64 uhz = 0;
> > > > > +	int f_count = ADF41513_HZ_DECIMAL_PRECISION;
> > > > > +	bool frac_part = false;
> > > > > +
> > > > > +	if (str[0] == '+')
> > > > > +		str++;
> > > > > +
> > > > > +	while (*str && f_count > 0) {
> > > > > +		if ('0' <= *str && *str <= '9') {
> > > > > +			uhz = uhz * 10 + *str - '0';
> > > > > +			if (frac_part)
> > > > > +				f_count--;
> > > > > +		} else if (*str == '\n') {
> > > > > +			if (*(str + 1) == '\0')
> > > > > +				break;
> > > > > +			return -EINVAL;
> > > > 
> > > > > +		} else if (*str == '.' && !frac_part) {
> > > > 
> > > > This can be found by strchr() / strrchr() (depending on the expectations of
> > > > the input).
> > > > 
> > > > > +			frac_part = true;
> > > > > +		} else {
> > > > > +			return -EINVAL;
> > > > > +		}
> > > > > +		str++;
> > > > > +	}
> > > > 
> > > > With the above the rest becomes just a couple of simple_strtoull() calls with
> > > > a couple of int_pow(10) calls (and some validation on top).
> > > > 
> > > > > +	for (; f_count > 0; f_count--)
> > > > > +		uhz *= 10;
> > > > 
> > > > This is int_pow(10).
> > > > 
> > > > > +	*freq_uhz = uhz;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > 
> > > The current implementation is kind of a stripped version of
> > > __iio_str_to_fixpoint(). Would you prefer something like this, then?:
> > 
> > Do they have most of the parts in common? If so, why can't we use
> > __iio_str_to_fixpoint() directly? Or why can't we slightly refactor
> > that to give us the results we need here?
> 
> __iio_str_to_fixpoint() only parses "int" chunks, adf41513_parse_uhz
> was modified to accomodate the u64 parsing removing unnecessary stuff.

But why? The fractional part most likely will be kept int (it's up to 10⁻⁹).
The integer can be bigger than 10⁹?

> I am preparing V5 to use simple_strtoull. Thanks for early review
> and suggestions.

-- 
With Best Regards,
Andy Shevchenko



