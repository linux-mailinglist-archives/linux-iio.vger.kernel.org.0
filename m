Return-Path: <linux-iio+bounces-25858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6776C2D9C2
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 19:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA95189A03D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E7231C56D;
	Mon,  3 Nov 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzezhX5v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F431B832;
	Mon,  3 Nov 2025 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193464; cv=none; b=lKxyCxxCxKn2pbnutKHBcV+3HSjRcM2I11+QamYPfZYCPWb9sINe7jtcfVeh2+Dic3ENGwEIrlFZrO5UBofxwTjpfCJL5zeImPr4+GEybMYis49C7TK+9/Bgawy9wLdGZgaMlbfoGbPgqw/WlKXf/w00lSA0lmFCQjdby/ZQmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193464; c=relaxed/simple;
	bh=va05Mvt1eD6PFtFEKUpfUa5jMNLoaEZADG41u4Ql/M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7i/r3mVqUqiPGFAyT0M1Jhca6wH2JtGGbVuA+smuqT8w506PmXcJq7Q4AAlg8MbtgZdYMHMJ79n1qQ0dRrIKr8bI8Pywx8ljItP0A6TMGJo8d3qwM4HzLQw56k54fOgnyl4LedSuAnjckynDJWd9BZ2h83rFGnUxr+mXIEE9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzezhX5v; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762193464; x=1793729464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=va05Mvt1eD6PFtFEKUpfUa5jMNLoaEZADG41u4Ql/M4=;
  b=WzezhX5vP4eqjEfEWSedLXcNf5hyRJ3E5f+lKwZG2DVihtGe/nRQrnQK
   MK+YzyPU+G4gTh3DGNPPm+q9ar3yixOCvYucKSqe5MGA0HBDezw/ICD1S
   sJ8rEG3l8X70kZfubmaJmD2Gj1Gbs3UF3Th7c/fHsVbhtw3SJa247f5lk
   s3H3xTUaEkvYS7C46qwJm5GYVBJJCFW67IQuiD70HOCHv2ZZBIamewH3/
   GRSZgREZcgT34bcMYNN+8aU7g3SXYiM8GyOAFZTM8e1589SDc1DNnJ0wo
   MkjbU2IUEvuU2yifiaq6SPKooYec90FGPmf0s92YMlVQzlfQapvxY7Bxu
   g==;
X-CSE-ConnectionGUID: SzgVStMESbaX/2M/XXaN7Q==
X-CSE-MsgGUID: 7XdgR2R5TYW4WpSgbspTJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64310646"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="64310646"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 10:11:03 -0800
X-CSE-ConnectionGUID: lYK2nm35QX+me1Q/Ii1pxg==
X-CSE-MsgGUID: c/gQnkyGRYa3OAlETYavtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="187083144"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 10:10:59 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFz12-00000005ERt-0H0D;
	Mon, 03 Nov 2025 20:10:52 +0200
Date: Mon, 3 Nov 2025 20:10:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, linux@roeck-us.net,
	Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v9 6/6] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aQjwK2IC1NML2w5F@smile.fi.intel.com>
References: <20251031-i3c_ddr-v9-0-f1e523ebaf78@nxp.com>
 <20251031-i3c_ddr-v9-6-f1e523ebaf78@nxp.com>
 <aQhkRmtJMoB7vv8U@smile.fi.intel.com>
 <aQjQ4jsG6Gc2u3n+@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQjQ4jsG6Gc2u3n+@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:57:22AM -0500, Frank Li wrote:
> On Mon, Nov 03, 2025 at 10:13:58AM +0200, Andy Shevchenko wrote:
> > On Fri, Oct 31, 2025 at 12:39:18PM -0400, Frank Li wrote:

...

> > > - 1 -> ARRAY_SIZE()
> >
> > Maybe I missed the answer, but why are the arrays to begin with?
> 
> I3C/I2C transfer API required pass down one array. Keep the same coding
> style with existed one, like
> 
> source/drivers/base/regmap/regmap-i3c.c

I can understand why it's done there (there are read and write and they use
different amount of items in the arrays). But here in your case IIRC there
is only one function that uses predefined arrays out of a single entry. So
I do not see a justification for having an array. OTOH it's not a big deal
and I leave it to Jonathan to decide.

-- 
With Best Regards,
Andy Shevchenko



