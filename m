Return-Path: <linux-iio+bounces-23051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF7AB2DE71
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 15:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19A45E4F36
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F7209F43;
	Wed, 20 Aug 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1k+mqGo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977C1FECAD;
	Wed, 20 Aug 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698180; cv=none; b=gDzMIF3EuQHa5kN179Lh2ImfRX5iaT4MmKsPG7Ra/Q9z+dlMTK8FnHcZddqwobNIr6lWcUKGhCWt3LPg0+f129qIAcuR2vOPtsr6sH98UbedSkvT0nBuZNVDbAm5KLjmBlOjs1f/D6v3qu7ZrYF+4vyHxiCPuRhTx2vPto2xPdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698180; c=relaxed/simple;
	bh=Z7G/14If/9CK+UBZzzYPV1MmXUnSBLj4Fxu7EHPGP+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4jq2i4XY5ZpBUcrBjGJA8SB7HiS2PlHg8dxOio+oP2pufbvnmsQGVZqDuynh1GxVwxrw0CflI9INp3Y79frqQVltJnDmMBfh+Ok5k/eXsEd1eExUTBTOIksVo96ogv7mVQTdIkn1zzbHPViucNQbCM9LsSyE2muEgdHv5mpVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1k+mqGo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755698179; x=1787234179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z7G/14If/9CK+UBZzzYPV1MmXUnSBLj4Fxu7EHPGP+g=;
  b=K1k+mqGoGNdeyNBqi3cLB5E/QyEs6y5IS1f1Zi8xUoxEoWfZw/e/pt65
   Ngt6KroO9POyPwg7t1BLeIDKA/l1ksW88SJiFuOOz5WJRYsGTtShnZwq6
   GBA7X1ZfFAFxNwORQhC2LyvQQhP+uZtKDzW9hKDqn/KabohwswOJMv/BX
   gNKdgYtYmCvWpsbxbkVv+Hz0KPmZt73AK07jmwCaZcMV4gXviE8ZAofur
   FGw3eyyQcPj8Zo1HF0zxzTBN3V8j7BrDHBHdtgLfwCKykcJ2pM6qKTVyR
   W+YJBk+LVmvk3zzNmOJsnej2PHBUxAqHn+P699L6XNyNzVHNbcXrnNpHO
   A==;
X-CSE-ConnectionGUID: WRhHSB/eSAKZcVkWSADCgg==
X-CSE-MsgGUID: Knk3w1WXRpywFjSWcwpXZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="80557129"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="80557129"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 06:56:18 -0700
X-CSE-ConnectionGUID: JJ5OOMrQRs+MEc4bgOwlWw==
X-CSE-MsgGUID: U8f7/K0RQny2Vb4X74yvRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173387942"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 06:56:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uojIS-00000006wyS-4AbF;
	Wed, 20 Aug 2025 16:56:12 +0300
Date: Wed, 20 Aug 2025 16:56:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <aKXT_HOrY1XUlsLu@smile.fi.intel.com>
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
 <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
 <20250816140448.37f38d0f@jic23-huawei>
 <aKVTJXe50zf07ipR@dixit>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKVTJXe50zf07ipR@dixit>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 20, 2025 at 10:16:29AM +0530, Dixit Parmar wrote:
> On Sat, Aug 16, 2025 at 02:04:48PM +0100, Jonathan Cameron wrote:

...

> > > +	TLV493D_AXIS_X,
> > > +	TLV493D_AXIS_Y,
> > > +	TLV493D_AXIS_Z,
> > > +	TLV493D_TEMPERATURE
> > As below.
> > 
> > > +};
> > > +
> > > +enum tlv493d_op_mode {
> > > +	TLV493D_OP_MODE_POWERDOWN,
> > > +	TLV493D_OP_MODE_FAST,
> > > +	TLV493D_OP_MODE_LOWPOWER,
> > > +	TLV493D_OP_MODE_ULTRA_LOWPOWER,
> > > +	TLV493D_OP_MODE_MASTERCONTROLLED
> > This is not a terminating entry, so would typically have a trailing comma.
> Isn't the last entry in the enum list is termintating entry and it should
> not have trailing comma?

No, it's not semantically. (Yes, it's terminating the list syntactically)

> > > +};

-- 
With Best Regards,
Andy Shevchenko



