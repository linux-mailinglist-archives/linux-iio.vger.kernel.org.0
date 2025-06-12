Return-Path: <linux-iio+bounces-20569-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D10AD79EC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4335189461F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD229ACC3;
	Thu, 12 Jun 2025 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAv9+ZIl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887913D539;
	Thu, 12 Jun 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754118; cv=none; b=acwukK1+Yg+Rlx8vCk9aCzOAaxkW4DvBjQTVeWKkfnJ3ym14CDkVoy0nyAht30aYbVxJrIUnFotQrfNDDJJGjKbIOePvqHW6YwSsyNrBVmra7+YXLt7Vx+Es20P6Diq62wMZ36ovJW1zeUTPhLCJ65H3P11MbNvFHKSk0BltZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754118; c=relaxed/simple;
	bh=SJ1RLx1NtuABuOy4ALhhbAI3NOqKSx4Y7RPNg1TnpP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKPGSobBnHl8Pt1jRqrdUuz8R5LN9hN1qY0It8XZom05ZMo5DNpi8dgtqKIBhkNTN4y12zq+UEpVtwIcvkxUx+y0Rx6rkN2L2/bGYiNJC+manCAqZW0fm+Vq23xDu83GD7bAMgZJSHxcFJxHhhz1AYHyh61TVHxAKmwbicc4xWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAv9+ZIl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749754117; x=1781290117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SJ1RLx1NtuABuOy4ALhhbAI3NOqKSx4Y7RPNg1TnpP0=;
  b=HAv9+ZIlUmhSN0wNAmuOKsQxqQ9CGJGHF2YPJYZlg1bkfkgWfhBRAOT8
   Ghds+BaySPerA7E13kWyxpLkzowbf+kRju4bxXv8FpQspICspWwjkpdhB
   aktX5r83GhcxeUbGaikoJHK7ymekheuQAfhal/5NbRZ8zPDo/+cKFr6+S
   uXAzr2P4b+wq4jM0NxthFI+Zjr5QExiU3igN4KUKB8I0CCovNFwXHfQFz
   QhPqUuRWjNUCmZJO4dTCem/n5LAOqI4sg2xtD5Oafejh1A2mXQuDuZHRi
   QT1lPaOwfgRNPVrBMdgXgCX45P7a+tYokWjanBeqxnMaNiyhqYg1htKhi
   g==;
X-CSE-ConnectionGUID: 5DILYikLQI2yCBQYR/0jmw==
X-CSE-MsgGUID: ORb78eAGSTaOI8z0XmPWkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="39565856"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="39565856"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 11:48:36 -0700
X-CSE-ConnectionGUID: zvUljB3qQpq/VOx41BfE0Q==
X-CSE-MsgGUID: IPgFCQAkQWCqd3KCVvv4Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148153183"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 11:48:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uPmyR-000000061WV-2B0L;
	Thu, 12 Jun 2025 21:48:27 +0300
Date: Thu, 12 Jun 2025 21:48:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aEsg-3AWGRLTpvuJ@smile.fi.intel.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
 <aEifWXPV1nsIyWbT@smile.fi.intel.com>
 <aEnvcaP2ZNPLhzXi@debian-BULLSEYE-live-builder-AMD64>
 <aErMgh6AKVStF4rQ@smile.fi.intel.com>
 <aEreFQUZXsdsgBSm@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEreFQUZXsdsgBSm@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 12, 2025 at 11:03:01AM -0300, Marcelo Schmitt wrote:
> On 06/12, Andy Shevchenko wrote:
> > On Wed, Jun 11, 2025 at 06:04:49PM -0300, Marcelo Schmitt wrote:
> > > On 06/11, Andy Shevchenko wrote:
> > > > On Tue, Jun 10, 2025 at 05:31:25PM -0300, Marcelo Schmitt wrote:

...

> Not sure about sending a patch only adding a TODO to the regulator framework.
> Aren't developers expected to propose things?
> I'm anticipating 'talk is cheap, show me the code' coming.

This maybe done in a form of the discussion started with the maintainers and
stakeholders of regulator framework. It doesn't mean we must have something
in the form of the patch right now.

-- 
With Best Regards,
Andy Shevchenko



