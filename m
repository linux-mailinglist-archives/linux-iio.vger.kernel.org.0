Return-Path: <linux-iio+bounces-15451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC511A32B7A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 17:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8237A1901
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D44421E0BA;
	Wed, 12 Feb 2025 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+d4lLC7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772142135A1;
	Wed, 12 Feb 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377335; cv=none; b=sJ9wHycRd0BmZ0NVT/xO02gHSsAgnBFoXAw9JyLIs2s0rPt922LMloRKmal0JdvGzXxLLK7l6nMv1BXr5DRpr8edqHYBz8nmB7YeWaQN1mF74RGDG6UKVv1bRtYhZHtzD+JBC6sLym8ChaLTTahBDKbaT/XcqenIxwi/lZArGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377335; c=relaxed/simple;
	bh=zAt+KHCm2WIHn21DRXUOGexi0mT5f1t387ncoNKjYuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMlaTjXLX96UbvQapmh/vvh54wFlD+VLR0UXR46O5rwM8XiMHBZYMio5RlUpiJQzwV4PSCi7BSwkvkuQ1nQtafqk/KrVaTPyGNhikont119N1Ns1GniyCzOmgOzZQJ7bBU0ehExqMZ3uj/2+cdjChsMabMc6hOVr0pOxiWt5cs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+d4lLC7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739377333; x=1770913333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zAt+KHCm2WIHn21DRXUOGexi0mT5f1t387ncoNKjYuM=;
  b=f+d4lLC7GY2D23Aj3qMmEqX/uyJaRQsis2rqPnS8exFWtDyuvQotAIdE
   XdgrglR7dZsBELTGYRX7Brk3UZUuhCKDeKVV7kH3jP7H2LB+Tdr1R+oE7
   1uc+5MPzbmiiYnFIbIqn/ilfWzpCeZC9yzoQr17H15Kqjs+uvcfdvbfV8
   aYfUhYOMGxySSM/fqKRfaN+GU5rg/UGcg+gmX8pUCR2oN5OdPbjOwzk9b
   AAkdwKDK0qoU+WIk2R5s2jt1TWkIAEoJ1NDJWZUUxA3rl9PpWhYMDUhRG
   qI3NvpKw/DipF7OiNFK+8iUMYbSOaf1fVyRZjWfShbnCAnSC2HDU5fC44
   Q==;
X-CSE-ConnectionGUID: nVqUfJuFQlOuAesG39Itfw==
X-CSE-MsgGUID: Keg2ySv1Ttq4r1KTbEIfxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39967029"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="39967029"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:22:12 -0800
X-CSE-ConnectionGUID: h9l+8dR6Q6265NLaG+W0eg==
X-CSE-MsgGUID: YAuoXcCEQuu5LuYVt94GiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143812635"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:22:09 -0800
Date: Wed, 12 Feb 2025 18:22:06 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
	dmitry.torokhov@gmail.com, jic23@kernel.org,
	przemyslaw.kitszel@intel.com, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 00/12] Split devres APIs to device/devres.h and
 introduce devm_kmemdup_array()
Message-ID: <Z6zKrvdPYPKPcjk2@black.fi.intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
 <Z6yAbfVtm8nlZzqu@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6yAbfVtm8nlZzqu@smile.fi.intel.com>

On Wed, Feb 12, 2025 at 01:05:17PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 12, 2025 at 11:55:01AM +0530, Raag Jadav wrote:
> > This series
> > 
> > 1. Splits device/devres.h for the users that are only interested in devres APIs.
> >    Original work by Andy Shevchenko:
> >    https://lore.kernel.org/r/20241203195340.855879-1-andriy.shevchenko@linux.intel.com
> > 
> > 2. Introduces a more robust and cleaner devm_kmemdup_array() helper and uses it
> >    across drivers.
> > 
> > The idea behind embedding both work into a single series is to make the review
> > process easier and reduce conflicts while merging.
> > 
> > Current proposal is to merge initial patches with an immutable tag (volunteered
> > by Andy) for other subsystems to use. Feel free to share a better alternative.
> 
> > v5: Move IOMEM_ERR_PTR() to err.h (Andy)
> >     Reduce distribution to pinctrl/iio/input patches
> 
> Weren't there two more patches that were actually Acked by Jonathan?

Nope, iio only has one user each.

Raag

