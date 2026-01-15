Return-Path: <linux-iio+bounces-27817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A43EED232FE
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 09:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4769300BDA5
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 08:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB9733A719;
	Thu, 15 Jan 2026 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hT2mqnbD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E231354F;
	Thu, 15 Jan 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466259; cv=none; b=YhK6wL2mC7SjOVdH5WxZ239kyLpOlPbyfBf7GkgFw9mXv8uJOXsxPcutEY49PpRtAZInQUfro+1O8+c+P5UQk2DKuSLdmzI1TZgQkH23+sZu7jG/GG3n8Gghn2GDvqAoXiuJIPghM4Rk0+T2JyTpsRMjqhmFVHBZB4NxIv4fqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466259; c=relaxed/simple;
	bh=rN2WtW7R5Ty1GSTqZ6JsaQEKw5Cca7xgMLAD2WplUas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJoVNrERQvulMlR1ro8cpsPljEEEsO1sYVWe72ct5INQUwHOKAg8Pqa3GPPCQb9YaLAUq7H1f+xHmnmGboD/+C5Zd8OsICpS+XOngUYxpUEF7IN0vhsnF862zeZQKAMWWOiIg+hYCK+g/lKvIJVRZ1T809Qf6QSDSkt8O59EXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hT2mqnbD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768466258; x=1800002258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rN2WtW7R5Ty1GSTqZ6JsaQEKw5Cca7xgMLAD2WplUas=;
  b=hT2mqnbDRv//kdorjHbS3E7xTTbYbF/pjXW0RSdK/930PndoZfeOd0xo
   ZzaaGu2ZGniuw1Zw5Lej9m6C+CAX76G1ml80U8L2qNThlI+lOZTEpsOwL
   FcmJzF9gLRX5xmsuHov2BCEB0HGiak6IcgSs41qOWPo7Jh2aoRMQT9iEP
   cAv+TKfHLr8sAiQcYB/gyPZn466LDyVtoc+ER6OOuwYlNLPjDljXPCoAx
   HpeSD8wEryP7Yl2nR3RVt0dfBe0UA/eDGHxKZQMtIUEJ1Y66vt6qhq5PE
   OgerDsFJbLBhv7smZ/xi+VuyeapUcpCZ5/feZd5xldo2NxAdNxy0KqTg9
   w==;
X-CSE-ConnectionGUID: RxdyoPGSTmumiZZSUD40mQ==
X-CSE-MsgGUID: Rgx6NIOXSM2TEmSeb71/jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="87347720"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="87347720"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 00:37:37 -0800
X-CSE-ConnectionGUID: kp1tObyeTaWJc8AnORf/nQ==
X-CSE-MsgGUID: CqLyKKhCSlCIALYW8CzI1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="205184475"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.216])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 00:37:35 -0800
Date: Thu, 15 Jan 2026 10:37:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] iio: proximity: rfd77402: Use kernel helper for
 result polling
Message-ID: <aWinTdOD0FHaeqYp@smile.fi.intel.com>
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
 <20260115-rfd77402_v5-v5-2-594eb57683e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-rfd77402_v5-v5-2-594eb57683e4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 01:57:38PM +0530, Shrikant Raskar via B4 Relay wrote:

> Replace the manually written polling loop with read_poll_timeout(),
> the kernel's standard helper for waiting on hardware status.
> This makes the code easier to read and avoids repeating the same
> polling code in the driver.

Also need to add that you made it as a separate helper as it will be reused in
the future (or next changes).

No need to resend just for this, I hope Jonathan can tweak this whilst applying.

-- 
With Best Regards,
Andy Shevchenko



