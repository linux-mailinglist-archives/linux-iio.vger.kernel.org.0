Return-Path: <linux-iio+bounces-678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3B8076DF
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405D31F211A3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6316AB92;
	Wed,  6 Dec 2023 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFqQOeDx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7894F1F3
	for <linux-iio@vger.kernel.org>; Wed,  6 Dec 2023 17:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026DFC433C8;
	Wed,  6 Dec 2023 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701884768;
	bh=f2thWcW62IXUOrbPqO5jq+mUatO667MclBvkg0ftvMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DFqQOeDxOragNgCWaFB6fa/ZCUeDo5jmoU1N3o+euH/x/dJRnbGN2Dh947WoRMkcs
	 /8vTxrMuMnU1i0jggbiaweErVewwBVFafutVmrUkeGA79VysLZHGTCqqUwZSand9Id
	 P286oQYjgY9ncbftP7gKexfXpcyozXEK501VzUGOXW8GGSOgMTrcLziO1Tpk1jqieM
	 wYVgyZl83Rvd38DSfChLMVXpet5nxAyRnU+DZ5uwNFjwDl2NbCZ2ZrloMIvObrhEzp
	 PstIjHRDwzbwlpmj+NcnMZBMO7kVyN5imz2VUVNOrVh+l8aEqjQpOnMldvYYKDcBYW
	 qCKNGvsZ/5pLg==
Date: Wed, 6 Dec 2023 17:45:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Angel
 Iglesias <ang.iglesiasg@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andreas Klinger <ak@it-klinger.de>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v7 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series
Message-ID: <20231206174558.27f72d37@jic23-huawei>
In-Reply-To: <ZW4_OoyKSZ3EBL2x@smile.fi.intel.com>
References: <20231204194401.20891-1-petre.rodan@subdimension.ro>
	<20231204194401.20891-2-petre.rodan@subdimension.ro>
	<ZW4_OoyKSZ3EBL2x@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > +		ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> > +						triplet);
> > +		if (ret < 0)
> > +			return dev_err_probe(dev, -EINVAL,
> > +				"honeywell,pressure-triplet is invalid\n");  
> 
> Still you can use mentioned device property API.
> 

This is one of the rare cases where basing on iio/togreg is
sensible because you do want a feature that only exists there today.
Just state that you have done so in the cover letter.

Jonathan


> ...
> 
> > +		return dev_err_probe(dev, -EINVAL,
> > +			"pressure limits are invalid\n");  
> 
> Indentation?
> 


