Return-Path: <linux-iio+bounces-20371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07F6AD43A0
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1633A5B16
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237D26463E;
	Tue, 10 Jun 2025 20:20:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C662459E5;
	Tue, 10 Jun 2025 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749586851; cv=none; b=sVFF4X+rVNMvORY3bSUh3OWc3aoTVriy74IOh9AmDES2XiK7zexMp7gyIBPJM6o+F23kvAZ3qFllcb+JiJhO/QDv3Wh5xRSg2vIlWzrTEVde4ow/1M4BKHxOaYrtkcTZcQDk8rnyvy50HsnBk4pJb9u8SBkI2muZ31Warce11uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749586851; c=relaxed/simple;
	bh=4YIahBu4rd17/nPYwIZ2ksHhwSOzzkxA9okvbsuDZhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf5sW1ybXxc1V54CaPoaEm24oIVOl6ea4z6K0JIjJM5s0ykMXY4LDJEQrJek+6IKAKAx2w10+9uigYte0jVyE/yIDy9IWKLn5jAoHsyFTozUzYN9w13g8iqUDPOYgLDjtkOFajG1ZjfLwJ3KgYzmLPTJ/xyJcS5EKQhQPeDgIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: hVr5P4C3SgiSy2bW/Vrk/g==
X-CSE-MsgGUID: g1GlOl9nR5i26uuTCVuFTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62368865"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="62368865"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 13:20:49 -0700
X-CSE-ConnectionGUID: iTzFtAzzT9C/4t/9IquyYA==
X-CSE-MsgGUID: IkXTW6PVTFWtPYx2pYxcAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147880186"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 13:20:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uP5Sd-00000005RWs-3JB3;
	Tue, 10 Jun 2025 23:20:43 +0300
Date: Tue, 10 Jun 2025 23:20:43 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marius.Cristea@microchip.com
Cc: jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for PAC194X
Message-ID: <aEiTm9rbJsFYtSfE@smile.fi.intel.com>
References: <20250606093929.100118-1-marius.cristea@microchip.com>
 <20250606093929.100118-3-marius.cristea@microchip.com>
 <1c7946f1-d712-4baa-8243-be6a55eec528@baylibre.com>
 <1b8b10816d1f2f34724e77c68de869422d6c84b6.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b8b10816d1f2f34724e77c68de869422d6c84b6.camel@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 10, 2025 at 03:07:34PM +0000, Marius.Cristea@microchip.com wrote:
> On Fri, 2025-06-06 at 12:02 -0500, David Lechner wrote:
> > On 6/6/25 4:39 AM, marius.cristea@microchip.com wrote:

...

> > > +#include <linux/acpi.h>
> > > +#include <linux/bitfield.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/err.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/events.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/unaligned.h>
> > 
> > This seems incomplete. Expecting at least linux/module.h,
> > linux/property.h, etc.
> 
> I will double check. Most probably those module are already included by
> a header.

And this is exactly the problem needs to be addressed.
Read about IFYU principle. That's what we want.

-- 
With Best Regards,
Andy Shevchenko



