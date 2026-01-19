Return-Path: <linux-iio+bounces-27937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9318AD3A0B4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 08:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E8F730049F3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 07:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9416E3382C6;
	Mon, 19 Jan 2026 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOqroMch"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3781E376C;
	Mon, 19 Jan 2026 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809289; cv=none; b=F+YiTLWZ5EcEXiGSbZQmT201THeeQpem5emoi1+M6SU40nmgYlQz/P7MC+XNIpp1EkqhOzYlgJiRjlEn3Ifjs4VQV2Zuc643sucRLCAk93ok5k/Qv9bdd13TYkAsJdqZVGjYPm9e7FacoTvTA6hpJfh1jMByAZNVNBQC9LRjDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809289; c=relaxed/simple;
	bh=IqSuV5OGHQhS7jvB1m2gWugJQxBdc0VzmgxFQxWukJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIH5XcrH7I7iv+CpT4m/hz2PVOFWsNAo9VRN/u4ZoIxuhRLIgXki3MgAex1edzs2gAxmSXH3nDoYXfkjpIJG7y5O4XzIB9npmpCpEUHoNjCbaQGg4Pk4bb6yuT9JYpN5UQrkZXI0dIPdUIipKtuVt+ekT0UTM9vYutKZZkqNvQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOqroMch; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768809288; x=1800345288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IqSuV5OGHQhS7jvB1m2gWugJQxBdc0VzmgxFQxWukJU=;
  b=YOqroMchHJI5gMjuHH0aQW4TRK1Sq0aG69O4/XSDhgXy4LO+Wuqc3ex1
   st5baJvaUu0wsSXKKKke8SEFqJk1seiRJxtQaiKwCeEB4PUcYLPAswD/+
   9NJRVtIsU1wJiuczH62918G2u2QN2DcktQLUTSz7COlfVKzF0zajsuYEq
   fla7Y6iQkjY7UhMVpB4GY+Pmmcg5Lmanm9lJXx9nNB/vabMbOg0os576s
   IPkcWakkgHPUIjrcH+VrCKsDsaqaSDNmTGGhoTHF2b8mkoozdHBtZ9ZnA
   WNHS6aHWodp764XetHUXv+bRyMQV5YVf/Cenj59ghuayAFmmVweoWk0Z+
   Q==;
X-CSE-ConnectionGUID: vTnOVY1bTlS53WcHXFjsew==
X-CSE-MsgGUID: gP+YRGNtTbKmt4g+7EjPIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69990865"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="69990865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:54:47 -0800
X-CSE-ConnectionGUID: keN1T8UQTjmwaYWI6HVuUw==
X-CSE-MsgGUID: znIkEPuNTo+2HL1rniHotQ==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:54:44 -0800
Date: Mon, 19 Jan 2026 09:54:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jonath4nns@gmail.com
Subject: Re: [PATCH v6 3/5] units: add conversion macros for percentage
 related units
Message-ID: <aW3jQtiBcgcXLgsR@smile.fi.intel.com>
References: <cover.1768350772.git.Jonathan.Santos@analog.com>
 <dde9b98e2ab2bfdb5806ee413732cdfeb6c1c90b.1768350772.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dde9b98e2ab2bfdb5806ee413732cdfeb6c1c90b.1768350772.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 06:27:03AM -0300, Jonathan Santos wrote:
> Add macros to convert between ratio and percentage related units,
> including percent (1/100), permille (1/1,000), permyriad (1/10,000,
> also equivalent to one Basis point) and per cent mille (1/100,000).
> Those are  Used for precise fractional calculations in engineering,
> finance, and measurement applications.

This version LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



