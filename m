Return-Path: <linux-iio+bounces-22984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C8AB2C6B8
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 16:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A622168513
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921FC221546;
	Tue, 19 Aug 2025 14:11:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DCE2EB85E
	for <linux-iio@vger.kernel.org>; Tue, 19 Aug 2025 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612708; cv=none; b=jFZMgHT8N70U2G0u7yTjynjeSiYBtgHpnlxsPB+bpLqPmgAd6f3HSXUkE0/K+/cjEyZXb8/0CbGpFxDh6sQWYkZrvJyJuMiV7jlHKYcjEZLBawciL8OSOozL78ksvNn7You0PGF4B1UP1o6RSbsClC64KKL5GR4nhuO+eCsqr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612708; c=relaxed/simple;
	bh=h8VMfZ5dQlHMpsx+zcqtlSMw6Gmi35cS5eLWjnjmy54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQG6OkQ8poDseV0du/hHRMLJ7+se9yazikKmIx10eFdVfe1hetJOJLZgJLg/35RmDtwfHB6MZEWrooLlBGarvCL7wvp+UJ0jt4T/dRjWU6wCdsDlXXL117npijA58+tgdQ3IDJDsG+ekaOxFErENWvIe+bj1N5A01J/hjZg2/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Aug 2025 10:11:33 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081910-arcane-parakeet-ded8c5@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818183214.380847-1-bcollins@kernel.org>
 <20250818183214.380847-7-bcollins@kernel.org>
 <f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e95533-c486-442f-a186-5e746dad2f4c@baylibre.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 19, 2025 at 09:05:39AM -0500, David Lechner wrote:
> On 8/18/25 1:32 PM, Ben Collins wrote:
> > From: Ben Collins <bcollins@watter.com>
> > 
> > MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> > to allow get/set of this value.
> > 
> > Use a filter_type[none, ema] for enabling the IIR filter.
> > 
> > Signed-off-by: Ben Collins <bcollins@watter.com>
> > ---
> > +		if (data->filter_level == 0)
> > +			return -EINVAL;
> 
> To implement Jonathan's request from v5, drop this error return.
> We'll also need a separate bool data->is_filter_enabled field so
> that we can keep the last set filter_level even when the filter
> is disabled. (i.e. data->filter_level is never == 0).
> 
> This way, if you set the filter level, you can enable and disable
> the filter via filter_type and still have the same filter level.
> 

Thanks, David. This is exactly what I've implemented, plus the
filter_enable attribute.

Adding the ABI doc updates as well.

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

