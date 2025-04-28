Return-Path: <linux-iio+bounces-18761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCF6A9E9E6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 09:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885F6173235
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 07:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82E71EB194;
	Mon, 28 Apr 2025 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxXxFQUw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A890B1DF25C;
	Mon, 28 Apr 2025 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826349; cv=none; b=mNAkwNxdpf8jJXUJXOwcF0dRKSW11/u4mPpmi5uw47l/8vv5SBbSi0P4yeSWEFBRiIBAvwQSQ0FQslZOizpOSLawZKPLHLOm9wLVYDUc7b9yy8RZrxBJ6isnJzW9jE/+ok3YvgQS2HzHC17BPFURIGG4OXiVfVSqzefLkw6XgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826349; c=relaxed/simple;
	bh=kppXuiS+8xqPRG5sBttxhO/jv23p9dH1yPP/0KlrHC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p29fammrfEQhE2Hqd3gSQzHrBKIDPq63KKRfw544XOBwj0reM2gyD+WaNtn4U5Ahh7JFPS8vDU05YIlau1CJ36PuP5cfkGX/UdsnULbD7X6vUaaWxTiLc85sh0LEGkssJm5AkL6c04Guq9qmZIUx6gj96zJXpB1YkYBG1L+fSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxXxFQUw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745826348; x=1777362348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kppXuiS+8xqPRG5sBttxhO/jv23p9dH1yPP/0KlrHC8=;
  b=UxXxFQUwIiNKBpG2M8qbfRf+/HV4GM97dene2lBAnPAv1BXxEi21kUMP
   J3NKAEOCr9ZqgtUBFUC/JXCSCCkDokvv0I5s5ZCqjr4lGJv4C7Qx5DyT9
   5TrKcf/znAiPcN7gimaMUcrD/VR/Og2LDsV2bsxd0jDTSYa2m8IR6txp1
   Vv5kVCfNcKALPux4D5QQxGBSYAQBwRZOLsVzMMMgursifOzpHeG1SqNuA
   BzEWTIxLa2T4jr8gW42UDGwaWkqjL0N0XFvIlgIPO/dfI6RnZkxEbEjAA
   URhpWocEm0h6N52KrT0UlgIzvte74vIwABNeyEEbZVECWAJow8VQLpBjf
   w==;
X-CSE-ConnectionGUID: Nlp1091aRYaX2SKqepIHnw==
X-CSE-MsgGUID: r1acmouuSRCA6QKLoAXH+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="47545062"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="47545062"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 00:45:47 -0700
X-CSE-ConnectionGUID: gXt0AyZDRHGPDxmAVgVnuA==
X-CSE-MsgGUID: IA9EteJAShyegnxW+Wef0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="138617872"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 00:45:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u9JBM-000000011Kl-09HN;
	Mon, 28 Apr 2025 10:45:40 +0300
Date: Mon, 28 Apr 2025 10:45:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org,
	Lukas Rauber <lukas.rauber@janitza.de>
Subject: Re: [PATCH v2 1/3] iio: adc: mcp3911: fix device dependent mappings
 for conversion result registers
Message-ID: <aA8yI27J4d_bFaGe@smile.fi.intel.com>
References: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
 <20250428-mcp3911-fixes-v2-1-406e39330c3d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-mcp3911-fixes-v2-1-406e39330c3d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 28, 2025 at 08:54:11AM +0200, Marcus Folkesson wrote:
> The conversion result registers differs between devices. Make sure the
> mapping is correct by using a device dependent .get_raw() callback function.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



