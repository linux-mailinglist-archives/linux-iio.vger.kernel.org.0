Return-Path: <linux-iio+bounces-23584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA775B3EB7F
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 17:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC771B27863
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DD22D5952;
	Mon,  1 Sep 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5ev0dC/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D126D4F8;
	Mon,  1 Sep 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741606; cv=none; b=scKic3rZO21aP1vs63fQdEqn+E4jJjcbXE+IDY956mL4GQZ1ey2mLXs/cppbn9VhUPybBP/ss9Un6wUXcAOdaBTJ631AXPhtX/hWz1EJI4KLuh/fBM86knvUIFIDtOEoyQ2Kmccsxb3r+MYJScfNMIBCbKpMNkp+2vBd2sVmcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741606; c=relaxed/simple;
	bh=uZGHb+cgjnlpDon+suaByeiQpVUlPqS31pGdaugkd+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ1w86dCEkdJ/1ljknKF0pbN2Gzq2TXPfH7aKWMb7dcIwy7P+skkJfu+gzq8VcGPPAP41D8Sg8HlvgtLIervedcMQioMGKhLSTXorkhuF14RAqrME8JEymaDYi0uLNHM5unTn4Ken8e1Lx4cD2VGWjdjrY1mV18hTV7Rc+RZ0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5ev0dC/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756741594; x=1788277594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZGHb+cgjnlpDon+suaByeiQpVUlPqS31pGdaugkd+s=;
  b=f5ev0dC/fqejA/v1Lz5WsOseSmAmPy2IGd4GAFVAhmmgITw6zVAJ4Hf5
   G2WKd6yytusDCqIhtBQ/UcjH4OO6HIoqImO/5LB95s0gF6E1GZDKgDwWE
   +UdVLj8OR47G+YvKXo8/vLVHS+4AJ+ZnLTy0eaqbQYmAhrvr8TKCZrZyc
   w5WyLITTbI7b1MXjhjkwhc709dwMKvXhmm7vG/P1qw6AKUyqtw7JV72ze
   0tiz8Jh9SazCP0zE5qWY3VwoQpqfBDNXysF0dnU3zQiQPyAj0C1dJmnFD
   pjb2yydgvxI4XXm6WIFL81/9IfkSsYQI6zl7aiHvtnquZ9JCtudTExGA6
   Q==;
X-CSE-ConnectionGUID: x0hhaQIST/mP/qyBSh0a/Q==
X-CSE-MsgGUID: PE4BUVkMRSiek5Hq9cz7JQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="70109691"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="70109691"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 08:46:34 -0700
X-CSE-ConnectionGUID: 1+NByHHCQku/4ZJP85MCnw==
X-CSE-MsgGUID: zLHLZXEPThGNFenvlm1GfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="201973997"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 08:46:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ut6jk-0000000ASdF-16ZP;
	Mon, 01 Sep 2025 18:46:28 +0300
Date: Mon, 1 Sep 2025 18:46:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] iio: use int type to store negative error codes
Message-ID: <aLW_1EXyV0Z9PC8L@smile.fi.intel.com>
References: <20250901135726.17601-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901135726.17601-1-rongqianfeng@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 01, 2025 at 09:57:24PM +0800, Qianfeng Rong wrote:
> Use int instead of unsigned int for 'ret' variable in ad5360_update_ctrl()
> and ad5421_update_ctrl() to store negative error codes or zero returned by
> other functions.

Both LGTM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



