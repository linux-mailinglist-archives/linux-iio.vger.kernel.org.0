Return-Path: <linux-iio+bounces-21964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAFDB109DD
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 14:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD985A5244
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B872BEC23;
	Thu, 24 Jul 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1NHubdb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7BB26A1B8;
	Thu, 24 Jul 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358566; cv=none; b=UuSc2ov7PiBiIBsyOJiMEpefQJ1Bo7/ohXGkDKCQ8pvUVCLgs8Cv0TaB5b654Vt3azvlW6Xmqefz8J7XgAbLbNobTRM/JMVtIFWPwGmC1Rtn3GPwRnJhxdKxOx34j4u0Bx4XxvH3Gq0wrpFya1JI+1mrcL9nbbsXsbJzhD8sGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358566; c=relaxed/simple;
	bh=gC7/IIv94UYiIF+2wRA2qk2JP6efc/iZNut4/NBExbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFIHTAqZd4CQd+MXQaSsc9DopI0WOxAeYJlN5AXFEq4u3UGYgmxkrz9j2L8eieLbJcBXDV9Yh3G5CARn0vPxTlSscW5X/42eX/1U3GFcBcKj8XscJaHUj+Gq0R6lKRFG+7AgT+QgKJjmDc10uBNNkVZWBRFSO21hHJg80eXe7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1NHubdb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753358565; x=1784894565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gC7/IIv94UYiIF+2wRA2qk2JP6efc/iZNut4/NBExbU=;
  b=T1NHubdblyl/DBkHq9Q0bAzt/oPgpn6wZW9QYbrOAjHJ+p32GYaX3Kow
   fIHs172hd1U81n/xpiXM98jL6ylTS0z+AG0CLv0X/jQzsnLiwc+UX8z7d
   ooa/SZn/7L+Nu5nWjnuubwSFedOV0jL7ixMn80iHMSfdit6cOmQM2Ma6K
   o/wduRJ7X3TQZ7/PqlUUtP6ssZGWsa+3ZyFz7cx3b5qaamLmkQHrM72lA
   ZlYYzmMIe9xyPgi7E0+CGfcCFlthLYSMaWq76lCy/6b3uZosqTi7XAhiU
   PgpL8bpAUqRHyeFDQH0IkrF/U7XJl5anTeLt4b198Ya8xmNwAyAxAE5Pc
   A==;
X-CSE-ConnectionGUID: Sma6i95aQ+GpjxwU4GBq/A==
X-CSE-MsgGUID: 06ut4kYcQh+NTBUMfUEA+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55518791"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55518791"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:02:44 -0700
X-CSE-ConnectionGUID: LXkrErb3R5W2QB9gcKSz0Q==
X-CSE-MsgGUID: 0dMvp4U9QTqt8cdLwKHtFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="197330820"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 05:02:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ueuek-00000000Ysk-3Zaa;
	Thu, 24 Jul 2025 15:02:38 +0300
Date: Thu, 24 Jul 2025 15:02:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7280a: Remove unused macros
Message-ID: <aIIg3m1eXC3dNfeM@smile.fi.intel.com>
References: <aIIQ3xxCNfpTouxQ@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIIQ3xxCNfpTouxQ@pc>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 24, 2025 at 11:54:23AM +0100, Salah Triki wrote:
> This is to fix the following warnings when compiling the ad7280a driver using
> LLVM=1 and W=2:

W=2 ?! No, please don't do that. W=2 is for informative purposes. Better spend
your efforts against W=1 which are still plenty in the kernel.


On top of that, often the definitions is a (arguable not the best) piece of
documentation of the HW, we don't drop them because they are unused (today).

NAK.

-- 
With Best Regards,
Andy Shevchenko



