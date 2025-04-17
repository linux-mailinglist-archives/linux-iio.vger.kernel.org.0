Return-Path: <linux-iio+bounces-18202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAC0A92308
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1ED464CE1
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D642550CF;
	Thu, 17 Apr 2025 16:52:09 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E822248AE;
	Thu, 17 Apr 2025 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908729; cv=none; b=E6G7nnwwLCwG/hj+v8haWhzpo25IQHRaHWw8Ff34CZl5X7bQ+MreSI9GwGMKp1i7kzYK/PN5matIpRwFQC5O3amleWJWqvSZLe7Kw9Bq0WruPGsggjFmoYdYYNQnmimyt4/iLzv0sxvmTKVbciKE/KravsJmzhtOfeauQx+OzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908729; c=relaxed/simple;
	bh=ZX5+ZMuzN0+oeRvlRrAinL5qAKSvOLrYyM7VzdvBIws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4nl2GDutyuRChe0u2u3pwPE0LjM9ZmzJQND03fbl+6aWU7U5olb0RlX9EBFcJ3ENH1guTbyfygQC4yzcT5o6zFGanzwKu1QbGlxtC4HxTThBNNMud8dqEpXBtmEkdkCokZHzryTrxoVby/bdWgGGGBZRPf4kKwcuNX7HK44uNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: KgnVKv9GReKnyeb0I9jr7A==
X-CSE-MsgGUID: v2QFJM1oRSiOBjbsG91hMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="45645317"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="45645317"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 09:52:06 -0700
X-CSE-ConnectionGUID: CzbQI+88Q4+q7Fw8S7Pmrg==
X-CSE-MsgGUID: W9ni30eDQ46n1sV9xFuHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="131400371"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 09:52:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1u5ST2-0000000DG3p-0MvS;
	Thu, 17 Apr 2025 19:52:00 +0300
Date: Thu, 17 Apr 2025 19:51:59 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: gyeyoung <gye976@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 3/4] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <aAExr-YPkYAsSQTc@smile.fi.intel.com>
References: <20250409024311.19466-1-gye976@gmail.com>
 <20250409024311.19466-5-gye976@gmail.com>
 <CAHp75VfMHdw-6vrELbjjD3T323uDz7U9wRP5YSk2jZ26wBuLTQ@mail.gmail.com>
 <CAKbEznsVxexdrXX72G-tCUHjznx6na1h8MrCFPKrHd27GXht8A@mail.gmail.com>
 <CAHp75VeU5sERbVz-4OxkJNC-pjT3B5AvfAMj09LXd6v4MdeDeg@mail.gmail.com>
 <CAKbEznvXdfszfiuXma_GWhYLwj7mR_WX_H4r6iHZWKp2=41tJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbEznvXdfszfiuXma_GWhYLwj7mR_WX_H4r6iHZWKp2=41tJw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 17, 2025 at 11:03:12PM +0900, gyeyoung wrote:
> On Tue, Apr 15, 2025 at 2:21 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> > > > > +       /*
> > > > > +        * serdev receive buffer.
> > > > > +        * When data is received from the MH-Z19B,
> > > > > +        * the 'mhz19b_receive_buf' callback function is called and fills this buffer.
> > > > > +        */
> > > > > +       char buf[9];
> > > >
> > > > Should it be DMA-safe?
> > >
> > > I'm not sure if I understood your point correctly,
> > > This code isn't DMA-safe. I'm currently understanding why DMA-safe is necessary.
> > > (but actually other drivers implementing 'serdev ops' use non-DMA-safe buffers.)
> > > I will verify this part and then send the next patch.
> >
> > Because some of the UART drivers may enable DMA by default if it's
> > available and your code won't work on them, right? But double check if
> > serdev makes it DMA-safe before use.
> 
> It seems that the serdev buf doesn't need to be DMA-safe. I looked
> into the PL011 driver as an example,
> which uses DMA, and found that the data received via DMA is firstly
> stored in the buffer within the 'uart_amba_port' structure, and then
> copied into the 'tty_bufhead' within the tty_port. Later, in serdev's
> receive_buf(), it simply copies from the tty_bufhead to into serdev
> buf. So I think there's no need to consider DMA-safe in the serdev buf
> itself.

But who will give those guarantees (note, the code is most likely may be run on
different UART controllers (PL011 is just one of many), have you checked all
supported drivers for DMA?

> would this make sense? If so, I think there is no need to change the
> code related to the buffer.

The bare minimum is to make sure this buffer occupies the cacheline.
Read about DMA safety for the cache coherency.

-- 
With Best Regards,
Andy Shevchenko



