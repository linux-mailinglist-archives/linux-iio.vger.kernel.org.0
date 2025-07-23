Return-Path: <linux-iio+bounces-21918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9379B0F6F2
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D1A1C217FE
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0DE2E63F;
	Wed, 23 Jul 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5pokeMo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA92EE97A
	for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284301; cv=none; b=c3R4vHAhr80xdPU4ScgS4Tuhid+hyr1728bJ6T6po9fUhT4bZS0Cz7lqSiJlH9wUykxh7epmHxV5aN/vN7abTUXJ8WbfbR/uc9U5bHmfETL2inKW/AoqKEmkTJ8FJIJw8V57whRMFAmNkJJVgEi8p+k1XtkbS8/178o+Q6dBO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284301; c=relaxed/simple;
	bh=XByc3zqnNkeiKVYakFMyhipvufN0CWu6qrUtKWQsNLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5xVTSQ/a6veqV/iDmQ2JQ53qSl9hvMzStJnUuZvLcuAWz8KqQ3sJnxkX5cuYJcqMq904wf2LR0lnDtFCShkQ3M8VVJeuSJqfDpWbkkNELX5zprSnnn7IU9sUTJdwqFvc0Gy+cFbhf7GOUauKFON0GAt0Sg3ENhg6AhaYtmEmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5pokeMo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753284300; x=1784820300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XByc3zqnNkeiKVYakFMyhipvufN0CWu6qrUtKWQsNLg=;
  b=V5pokeMoMzLkr4H0xe5L2xtv4Ld+HFln6QXA9C1aCt+49vrC591SXWtB
   u1AobzTD4OxFeE6D7o3qYqyv4IMWQLLZL88nYtbzGpnk96oqnpRUIaWsb
   LnxtyWwDbq2iKVq8Fn9ZramAGBetupDFa/V/E3C1ncpcIfc/wPtPnVS39
   FfXTr6D9t91wxwAFzmTxO6+0jstJ0XDvIqdTUZJLnK4+rXksT1ugDaNgQ
   jqWsQOuQCWuaIe5vvBCJXo7VAO3AaYzL2/Qa3hIv2D7D94yxV9lyVCgba
   DSeKipACCTKbEqM+umYUln3DtSmbe/lS4JOx5COm82xom+zDD7an/quUi
   g==;
X-CSE-ConnectionGUID: AUTasOXbSv6Zlr/DjiQp1Q==
X-CSE-MsgGUID: M00ycoXdQDC2a4mA1HGmGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66268418"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="66268418"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:24:59 -0700
X-CSE-ConnectionGUID: 8B9Iiee9QSKdTXuDP6LRFw==
X-CSE-MsgGUID: 61lIy7nqSQa0d0yflSp21A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159315863"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 08:24:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uebKw-00000000KEU-1e9H;
	Wed, 23 Jul 2025 18:24:54 +0300
Date: Wed, 23 Jul 2025 18:24:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
Message-ID: <aID-xkMl1kp8GMiw@smile.fi.intel.com>
References: <20250721150614.51918-1-hansg@kernel.org>
 <20250721150614.51918-3-hansg@kernel.org>
 <7e3cc17a-1ceb-40ac-bc4c-31487cd0deea@baylibre.com>
 <47bc1555-0855-4dca-a189-ce84e14d9e41@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47bc1555-0855-4dca-a189-ce84e14d9e41@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 21, 2025 at 09:02:10PM +0200, Hans de Goede wrote:
> On 21-Jul-25 8:43 PM, David Lechner wrote:
> > On 7/21/25 10:06 AM, Hans de Goede wrote:

...

> >> +#define DC_TI_ADC_CH3_DATAH_REG			0x5A
> >> +#define DC_TI_ADC_CH3_DATAL_REG			0x5B
> > 
> > Could be less verbose with just:
> > 
> > #define DC_TI_ADC_CHX_DATAH_REG(x)			(0x54 + 2 * (x))
> 
> Ack, will fix.

And drop H, it is not needed either if we properly use endianess wise types and
conversions.

...

> > Is the raw value already in millidegrees C or do we need
> > IIO_CHAN_INFO_SCALE here?
> 
> The scale is unknown (I guess this depends on the thermistor
> connected), which is why there is no IIO_CHAN_INFO_SCALE
> here.
> 
> Note I have no datasheet, this is all based on the Android
> kernel sourcecode dump mentioned in the commit message.

I think I have access to it. What should I look for specifically?

(list all your questions here, please, without spreading over the code and mails)

But note, I will be on vacation for 4 more weeks (and I think it's not an issue
as this is material for the next v6.18 cycle anyway).

-- 
With Best Regards,
Andy Shevchenko



