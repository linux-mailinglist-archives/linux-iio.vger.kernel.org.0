Return-Path: <linux-iio+bounces-24201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E9B7EE83
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA74E1C03576
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 08:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7A305E32;
	Wed, 17 Sep 2025 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czVFqugW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7161C07C3;
	Wed, 17 Sep 2025 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096754; cv=none; b=r98dNfXigdEt7ibhPnR9FrXd4d8LWC5nPAkDFS1Xvva1zPImWtAhPQyrQFruB4ZIgu3CYyokB4OqG1mNU8LEveEwN2uCbYVwVCRaXlkZK5aRhYVmnKFxSLvRrJ15tJZOV1mlJsdg0/7HvHC8MOb3M3NwkemaptpEp4u12kt6oqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096754; c=relaxed/simple;
	bh=W0CFetujHE7WZ0AXtTeJlgOe4r0Thr25WAO41RpeW10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUpLtS5ll36G9ua1Xz/Rjft3Wz4jqC9Lqts4ha+GJlmv0PWq83bfmWdbnfQ2OY52EK9VA94VQ0jZ4f2I5B7JihZlEq5lIjKlphwjzxpl6aRGz7A7q2o1s+AK27mLl5JR24flRdfE+lN9butNC8nw0floRYGgv5xmfBiizEIQKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czVFqugW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758096752; x=1789632752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W0CFetujHE7WZ0AXtTeJlgOe4r0Thr25WAO41RpeW10=;
  b=czVFqugWLROYPxPPk97T2ZxVECXniHYqGSRdRBijc2ZXJfDAmWxKvP63
   L8f0hpW2YEAIlHbAX0dqD/doU+0KNHjJr3YLjbpY8n06psEex/pFvmvgl
   e5+FzMHLM2qyUyZXZSuQagxve76Ux20h2z3D5Oh94jkESTB3B7CkpxFhF
   NRdn5uNSTxXy+vmvFZmxmu02eX6m9SdzlAejY1x9S7yE52QbakJaSCAJX
   XZRqhC5jekIO+7ia3gnSWJ1AUkwaMDFcqeTv8yPAv1cPYsSDO4LtyVxfg
   0ttg59hJmZARckaEtIVSuos0aD5T80PCalHg4Vo0ApUKLp7PHde4S6kiK
   A==;
X-CSE-ConnectionGUID: f+6Q2unEQky4B5XE+O96Gg==
X-CSE-MsgGUID: 3z/oucj7SC6ncA/9MSA2Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60321688"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60321688"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:12:32 -0700
X-CSE-ConnectionGUID: yUZhlXUuRQqZTOOFJgamTA==
X-CSE-MsgGUID: EdIZkDAzSSOU1rFSBTH/KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="212331204"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:12:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uynH6-00000003kTQ-1tPG;
	Wed, 17 Sep 2025 11:12:24 +0300
Date: Wed, 17 Sep 2025 11:12:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v11 2/3] iio: adc: max14001: New driver
Message-ID: <aMptaOOmQ6SUoMLj@smile.fi.intel.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <c257f7feb92dcf33bf7a55810fe69d13890374d5.1757971454.git.marilene.agarcia@gmail.com>
 <2d5ef36b-ae37-453d-a19b-76fc97b7f14f@baylibre.com>
 <aMptAUsQaUIYpVNG@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMptAUsQaUIYpVNG@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 17, 2025 at 11:10:42AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 01:04:41PM -0500, David Lechner wrote:
> > On 9/15/25 5:16 PM, Marilene Andrade Garcia wrote:

...

> > > Change I was not able to do:
> > > - I could not remove bitrev16 because I am using an SPI controller that
> > > does not support SPI_LSB_FIRST. So I suggest keeping bitrev16 and not using
> > > the spi-lsb-first devicetree property for now, since this driver currently
> > > works for both types of controllers: those that support it and those that
> > > do not. I left a TODO comment to address this issue as soon as the SPI
> > > kernel code starts handling the bit-reverse operation for controllers that
> > > do not have this support. Once I finish my work on this driver, if the SPI
> > > code still does not include this handling, I can submit patches to add it.
> > 
> > I looked more at what it would take to implement this in the SPI core code
> > and found that it would actually be quite difficult to do in a generic way
> > because there are so many edge/corner/n-dim cases. We can't change tx_buf
> > data in-place because it might be const data that is in some memory area
> > that can't be modified. And things would get complicated if different
> > transfers pointed to the same buffer memory addresses anyway. So we would
> > basically have to allocate new memory for all buffers, copy all tx data to
> > that new memory, reverse all of the tx bits, and update all the pointers in
> > the transfer structs. Then when the message was finished, we would have to
> > reverse all of the rx bits, copy all of the rx buffers back to the original
> > buffers and put all the buffer pointers back the way they were. But this
> > could write over some of the original tx data if tx_buf and rx_buf point to
> > the same original buffer, which would break things if a peripheral driver
> > expected the tx data to persist.
> 
> And what's the problem here? We do the same with bounce-buffers in case
> of DMA/IOMMU (okay, without actual data modification, but it's possible
> on-the-fly).

Actually, can this be done on a regmap level instead? We have a lot of custom
regmap IO accessors, bulk accessor that does something to a data can be also
implemented.

> > And we can't do this during the SPI optimize
> > step because that currently allows the tx_buf data values to be modified after
> > optimization.
> 
> This I don't know, so perhaps it's indeed a showstopper.
> 
> > So perhaps it is best to just handle it in the peripheral driver. It will
> > be much more efficent that way anyway.
> > 
> > However, we still do want to handle SPI_LSB_FIRST now so that people with
> > hardware support can be more efficient and we don't want things to break
> > if someone puts spi-lsb-first in the devicetree.


-- 
With Best Regards,
Andy Shevchenko



