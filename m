Return-Path: <linux-iio+bounces-21718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D07BB0722C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 11:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEF0188CE17
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBCA2EE982;
	Wed, 16 Jul 2025 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuC9zt5q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859128EA72;
	Wed, 16 Jul 2025 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752659377; cv=none; b=tjxctEZiTG6vkDuAmodu/lcKxUObxETqNVH8hOiXGwDcoaOCvkSlov5kzgaPIaJqUVb+Mok/61y2Zlrb56gg3iHaKimSJuQ99g46djygMdm3LNVy+13wT3IN7aw8bzHYThH+GSpX9KPJdZIxUIs4xGrxvOdKyjS61ShpJdfysfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752659377; c=relaxed/simple;
	bh=/qH41E0eWXl8rH95/n9qaIle/8nKoTpHI/7/0QnbsZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYH6bDqCGrO+fXLkvMVUUQJN/jIIU6nihLFRgkjnpiDDI08nQzlAfqZfIk+0vjVAXFd5iO2Q3g8EpoC1GNr3+d5R2pfVhzpWuGGpaZZJCvSzyT1YYPkRoPf6PhpcaFcmFsrQ9+lR5U0zu/MyWHy7HK7ud4n+qHwT5G1PGDKdSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuC9zt5q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752659375; x=1784195375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/qH41E0eWXl8rH95/n9qaIle/8nKoTpHI/7/0QnbsZc=;
  b=QuC9zt5qil6E59nlgfR+5uJ3kXw0LoDv93H5SXeMHXqZp8iZJLMImUQX
   QBVe6Ncfa6u2LlcVQ6Gvd55Asyje/9Dfakr4o/+D7JnsnaVyQLoCS3Bh6
   /uU1h9BA02PB4E+QB23WmBq4Z6cJxz47lVdHpnK9GXecatSnCDbd3Ek6y
   qpYvTJbZPduZLN45p4Tsi7hY248UXbSDeDHSQHB4VHiAVi/0H85FYzGTt
   Ab6+Qc9sAiTMdRIp6fozM9xbs4salhQ/Hkk5BbpnOZabWi7SVfWRFl/q8
   1bm9xas8LGtEtRudvr5JN2NYPRfxnlw1heTfDgQQGoYpOWz79wYuI84wZ
   Q==;
X-CSE-ConnectionGUID: fuyouHH6QliKyQV1gfzczQ==
X-CSE-MsgGUID: oBOGunaIRsKG1kU6HJBSMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="57504069"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="57504069"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:49:34 -0700
X-CSE-ConnectionGUID: F315Y0c6RACuOfCcYomDxA==
X-CSE-MsgGUID: idn6st+lTIeN5+mu3sJyMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157265083"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 02:49:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubylU-0000000Fu1L-2vOD;
	Wed, 16 Jul 2025 12:49:28 +0300
Date: Wed, 16 Jul 2025 12:49:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <aHd1qDR3jNTKBbun@smile.fi.intel.com>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
 <20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
 <aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
 <j7vqnxx3d6cws2zsveqohr6iqtno5thlauypnowlijifiwx5ow@6arfipnjkfh7>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j7vqnxx3d6cws2zsveqohr6iqtno5thlauypnowlijifiwx5ow@6arfipnjkfh7>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 08:52:41PM -0300, Gustavo Silva wrote:
> On Tue, Jul 15, 2025 at 10:37:21AM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 11, 2025 at 08:36:03PM -0300, Gustavo Silva wrote:

...

> > Is this already documented in ABI?
> > 
> Not yet. Should this have a device-specific ABI entry?

I don't know, but what I can say is that change is no-go without documented ABI.

-- 
With Best Regards,
Andy Shevchenko



