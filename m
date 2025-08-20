Return-Path: <linux-iio+bounces-23066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6CEB2DFCC
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427C31C45E1D
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194092EFDA8;
	Wed, 20 Aug 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFfv9dEn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F01527EFFF;
	Wed, 20 Aug 2025 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701118; cv=none; b=L3WGQnW8gjXwEyNy22/3DLesQynTkGPikaBR9NBKdDcfk0T6ILGHVMswsvzSNKI2wBuoW1uVXI4kheQuvhTEpKM8oZMAYE09Xzk0GUPU/v7fpsWoooaXir+LqbkkXujkqx+zNOW1r16TIkOCJ53C4TgalF3Hvj+EC8dazvKZOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701118; c=relaxed/simple;
	bh=odjo2XZQ6XrWahDC2Msd54vDnQEkIOtAcoMfk6YB34M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiRbdgEH584qfjhrMSDFtS+Jd51a5Fuk7fI54Wo+0Yi6c6nS2SLgsyQ5VbacTbQYZMM9tdjedSvuKlNHYm/DvhL1kTY2WS6mGYbnXlMZOU7CwAWVxUk12VORem5f/2P35wgWIKBHVmzkwnuug5PKMpfbkXN9JFYZizpOHkd62wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFfv9dEn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755701117; x=1787237117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=odjo2XZQ6XrWahDC2Msd54vDnQEkIOtAcoMfk6YB34M=;
  b=RFfv9dEnps9asHSIvqqXWEUK4TSh6d58tm6vXaWz1yFyd8XT5Ovnz1PN
   ROgQftrx2SYKVHYNMaE5QCrGKWeFl5fMFGVW4vXwRPk2hV7ebuUqaKcKU
   QVRNwuREdu5Vvp8ZVXcAXm88vG0J9mOSd1ldFhexrWolkrSWO7HaleshM
   no544p6LnNPrOae5eQs4Vx8Rb3N1X0eStjP8SBJnSrUb2YhD6MuFjMu1+
   8upskwEhieigH1DVvjVfCrIk3PcXWx4bRJqRjaSgyQR8shTL2oxduBnpf
   MCq63ZYA6oaBgozG/TBhFHritJ1WCKgwXSHJR1VskDIpAJ38ijw09X+rI
   A==;
X-CSE-ConnectionGUID: 8GcAI/roQ/+EXdvX3bDyLQ==
X-CSE-MsgGUID: vQhhxP4yRD+BHh9LNWtyHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69066925"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69066925"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:45:17 -0700
X-CSE-ConnectionGUID: EwMB1xU4QhanClp+V84E9Q==
X-CSE-MsgGUID: qh0RcRk8S+KpeabvXOKvIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="173495822"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:45:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uok3s-00000006xfb-1srv;
	Wed, 20 Aug 2025 17:45:12 +0300
Date: Wed, 20 Aug 2025 17:45:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Davis <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] iio: health: afe4403: Do not store dev pointer in
 device struct
Message-ID: <aKXfeOi2y55L1c7A@smile.fi.intel.com>
References: <20250813225840.576305-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813225840.576305-1-afd@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 13, 2025 at 05:58:35PM -0500, Andrew Davis wrote:
> The device *dev is only used in probe(), so no need to store it
> in the device local data struct. In all the places in probe()
> we did use that, just use a new local variable for the same.

...

> -		afe->trig = devm_iio_trigger_alloc(afe->dev,
> +		afe->trig = devm_iio_trigger_alloc(dev,
>  						   "%s-dev%d",

It can be made one line less, but it's already applied...

>  						   indio_dev->name,
>  						   iio_device_id(indio_dev));
>  		if (!afe->trig) {
> -			dev_err(afe->dev, "Unable to allocate IIO trigger\n");
> +			dev_err(dev, "Unable to allocate IIO trigger\n");
>  			return -ENOMEM;
>  		}

-- 
With Best Regards,
Andy Shevchenko



