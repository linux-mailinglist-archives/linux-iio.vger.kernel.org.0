Return-Path: <linux-iio+bounces-24197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055F0B7EEC8
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7761C03982
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 07:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4AA23643E;
	Wed, 17 Sep 2025 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuFgA6Vg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD125F995;
	Wed, 17 Sep 2025 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092532; cv=none; b=qpEPzV6yFm0x122+UQnslmfRpxBRlMWMhjb5p3Gy3F9spaODiU2StC76iSbFL/019y26XyjzHP2n6vc3iNUL7tCIsLjGNkyOzn516yogaMhIGyiLkRkyvlz7T/hS42CBQnUDL6K/BEb9Qhbtm9sFfjS58pv3shcSHPKZYPW+B5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092532; c=relaxed/simple;
	bh=1Y+By1UeT/6q+i84A+Veh7DTrXPP1wYJUfoamSwr0dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8KQw2k4jsxu/iwjV4WDm6NTBoKUhpLWWmRHoJu4TASA1k3c8Fo8uQ8lhk95Hwj4W71CMOrMIFeuwgWUfLiIAvIfusufqha+qoKwBswBm6NlsV4MaW4quuarzxWImQqmU2YEe3IXe7q/2ttjJ9fXHMpk7qivNiGk09WnQxTYcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuFgA6Vg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758092531; x=1789628531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Y+By1UeT/6q+i84A+Veh7DTrXPP1wYJUfoamSwr0dU=;
  b=KuFgA6Vgi9Uv2mD4B/ZJh5bfvVJ4hFO0lSql0tzBWVdspKk2O41TlOAN
   UN69fij2WXjto3RgqA+Rbg8Fb3BL2u3bKTN+g1tono2alOVFT/3R+C5M6
   nN81GPJ3LE1hnLpGdW7QZIH4h/qv21qarRUBpojT2cOJjprozKIWQu+A5
   GovYaBQqv00S2XxtmjeP8k2YGNYuMwRGNqU2pCKCllO56YsQLrwpHdeYB
   Ton98SmmtW+mgbyaLgU4s3a/1tF5zpfCaAEikV7WMoZtOLtudnd8NiWiq
   blgam8Voe+wh2WFkyGEzCw8U6W3BXepUJQsFfoXsF1i1ibI0dw9fTHIX8
   Q==;
X-CSE-ConnectionGUID: Ed287xSCRA6TFVDxTupTIA==
X-CSE-MsgGUID: kAMvkKNdSDOAOxY37w/PCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60316580"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60316580"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:02:10 -0700
X-CSE-ConnectionGUID: MpPcXApBQDuozBgcryjmfg==
X-CSE-MsgGUID: 5vAV9rFPR+mEzA/FsGv1UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="174965648"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:02:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uymB1-00000003jcD-3uIU;
	Wed, 17 Sep 2025 10:02:03 +0300
Date: Wed, 17 Sep 2025 10:02:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] regulator: ltm8054: Support output current limit
 control
Message-ID: <aMpc64pctVA1bvmr@smile.fi.intel.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-4-fd4e781d33b9@bootlin.com>
 <aMlj1OcfH8r9Zz6x@smile.fi.intel.com>
 <8772650.T7Z3S40VBb@fw-rgant>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8772650.T7Z3S40VBb@fw-rgant>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 04:27:25PM +0200, Romain Gantois wrote:
> On Tuesday, 16 September 2025 15:19:16 CEST Andy Shevchenko wrote:
> > On Tue, Sep 16, 2025 at 12:24:09PM +0200, Romain Gantois wrote:

First of all, please remove unneeded context (which is assumed you agree with)
in the replies. It makes reviewers' life much easier.

...

> > /*
> >  * Besides missing period at the end this is not correct multi-line style of
> > * the comments. Use this example.
> >  */
> > 
> > > +	tmp = LTM8054_MIN_CTL_V * (u64)priv->max_uA;
> 
> This cast avoids an overflow of the multiplication, since the result may
> easily exceed 32 bytes in size.

It's better to read in a way of

	tmp = (u64)priv->max_uA * LTM8054_MIN_CTL_mV;

-- 
With Best Regards,
Andy Shevchenko



