Return-Path: <linux-iio+bounces-27681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8A0D1B598
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 22:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D05B3016349
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 21:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179331DDA4;
	Tue, 13 Jan 2026 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acLzRItT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C430E839;
	Tue, 13 Jan 2026 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338399; cv=none; b=FAMV35b8oxiSTcIllr/nTf9PE1Rs3j4CXKjbIdFPTTq6RNlRVQTEoQMwjSLUgPnmUBACy6jyf7TUl2H1yybS33BHoYHmJ1OkpIBgWw+LTLZ3U+r7V7oITNaJepCJy41mZpM02mFI9cu0yByBkBqIKA2dPzEAe+tuhW0BT0r9vCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338399; c=relaxed/simple;
	bh=NQNmHZUzU2rr5cfDcwGPXcHxvMtebF6mWDkJjB8y3gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY+d3bddguUn1Vn45nlUyivXQH73VajnZo2O3KPQYDSWoOKpoqxwU94gDudiIfHslazqnTNfixDdSi9sv9UFH77KmRbNRBmJiqsBBkFU+u+yZm7YaKFEfhlajExEIiGilUmSTpTIXb0t8Dq9u+euIJfob+gFC+0c7B8QFN+cauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acLzRItT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768338398; x=1799874398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NQNmHZUzU2rr5cfDcwGPXcHxvMtebF6mWDkJjB8y3gE=;
  b=acLzRItTozar5GJ/PO8X/zjVknk2eBxgZzGJJtxWctQ6a5k+ylpnB4cY
   3noqZlRLM7/LuKQ5G1Ti/qzsiq7DK8PVSVQSsGRuI6M5wor1G+e3BYsMe
   1A9UCuCG60glVoD2Hlxuo9b6yKD2fDP6dyCgEYxeXorENLydpaSM6HAHu
   JwsVEVj///QWdoPQwILP+IVrwKhYlY8Sgky3k5y4WphDvXDXfACrivv3R
   tyD9pn22iHLMwkXsjfPmSPzb47DV71k4jygukRKtOl29NkMPQ174XI8f7
   H7xTyJlRpy+JEM9xOHRD6oaI0xcmgvH/GEhAcXEaO2+yFhKyqBq+hCUuu
   w==;
X-CSE-ConnectionGUID: Gsqtw0pyTSGW7gFNlIqp4Q==
X-CSE-MsgGUID: Z5ZkmGd3RJiYt2jHRhm+Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68640837"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="68640837"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:06:37 -0800
X-CSE-ConnectionGUID: 5cof0vVeRCORVRvjh4mMfg==
X-CSE-MsgGUID: yPRernD/TayE07TEcZQXKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204279935"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 13:06:35 -0800
Date: Tue, 13 Jan 2026 23:06:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: industrialio-backend: support backend
 capabilities
Message-ID: <aWaz2JrwtwwE3dEc@smile.fi.intel.com>
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
 <20260113-b4-ad9467-optional-backend-v2-2-0a27e7e72f41@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-b4-ad9467-optional-backend-v2-2-0a27e7e72f41@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 13, 2026 at 12:12:48PM +0000, Tomas Melin wrote:
> Not all backends support the full set of capabilities provided by the
> industrialio-backend framework. Capability bits can be used in frontends
> and backends for checking for a certain feature set, or if using
> related functions can be expected to fail.
> 
> Capability bits should be set by a compatible backend and provided when
> registering the backend.

...

> struct iio_backend {

>  	u8 idx;
> +	u32 caps;

Please, run `pahole` to see if there is a better place for a new member.
(I bet there is.)

>  };

...

> +enum iio_backend_capabilities {
> +	IIO_BACKEND_CAP_TEST_PATTERNS = BIT(0),
> +	IIO_BACKEND_CAP_BUFFERING = BIT(1),
> +	IIO_BACKEND_CAP_CALIBRATION = BIT(2)

Add trailing comma, it will allow to avoid unneeded churn in the future.

> +};


-- 
With Best Regards,
Andy Shevchenko



