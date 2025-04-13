Return-Path: <linux-iio+bounces-18040-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD25A87173
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 11:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13FB3BD861
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7118D63A;
	Sun, 13 Apr 2025 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWEqINNs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7AA927
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744537885; cv=none; b=h/ia1n77+7oDWGnHSW+yAIwbgtfwhex24B4GnNutfFiJEdyeQxEWegF6XqBpcw5TSI+fhXJ7WQQVQiyNZABKngrm8gOGALAH9h92Y72g6xOA+MiZnubnG/Y3V5e3LNVDYKA3h/+M1IuJOtShVcQxpv4+8dOv5U4DiwhReXLPJ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744537885; c=relaxed/simple;
	bh=YjawpkKX+Kn5pLUbccmVSPwezVgr5NIidSzIj1zXIIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPabnaAUiAqOYNJ1VMVhyb7MuEoPF/CJpOePNxmCwuVxA3E2WpaXqI+q1yILEL7R519cQmFHPKVm3jmdFVVgW2BuU7ihWF5NayDMX/hclGlwby646Op7MMXSMUj1hdE8a+68SqrfEyuRyZypz8vwzbo86G6dcULXPpZ0BaeRuhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWEqINNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18421C4CEDD;
	Sun, 13 Apr 2025 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744537884;
	bh=YjawpkKX+Kn5pLUbccmVSPwezVgr5NIidSzIj1zXIIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XWEqINNse/qLZ2wxpnmKBzKKie8gxHoQYbl0YlqznXcKdjk8z8Mf78y0S1tTpwodz
	 D7B86tkjm1qLjXrerS28NC0jJfTRxu0x+istURmmFzdxJRcGeyB+QGktdsWTIeEssm
	 Bb5m7gg8RzswYAzQDQruTldbr9n+lyYB9fERSOpcQOYMzgq0NdOTXXbiB1JvsAjaiz
	 f0NFn5sYpZnfNvH0KzY3guFmWeQvqKzEF/Qx9esBgWfedv6puO30LLByj+kxNI2oUm
	 Iepvlh88JBvUoSSZOdwOg/bsESQ4mgi8C9z29z67GBeQAxexzmisag+pdh+eoULLFi
	 1fNIvfwjZciEA==
Date: Sun, 13 Apr 2025 10:51:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 05/20] iio: introduced iio_push_to_buffers_with_ts()
 that takes a data_total_len argument.
Message-ID: <20250413105119.56b0e887@jic23-huawei>
In-Reply-To: <Z_OYWKli6qVPgW2_@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
	<20250406172001.2167607-6-jic23@kernel.org>
	<Z_OYWKli6qVPgW2_@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 12:18:16 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Sun, Apr 06, 2025 at 06:19:46PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Check that data_total_len argument against iio_dev->scan_bytes.
> > 
> > The size needs to be at least as big as the scan. It can be larger,
> > which is typical if only part of fixed sized storage is used due to
> > a subset of channels being enabled.  
> 
> ...
> 
> > +static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
> > +					      void *data, size_t data_total_len,
> > +					      int64_t timestamp)  
> 
> Do we still need to inherit int64_t type? Can't it be s64 instead?

Indeed not.  I'll not update the existing call because I expect that to
go away shortly but definitely doesn't make sense to keep the mysterious int64_t
usage here.

> 
> > +{
> > +	if (unlikely(data_total_len < indio_dev->scan_bytes)) {  
> 
> > +		dev_err(&indio_dev->dev,
> > +			"Undersized storage pushed to buffer\n");  
> 
> One line, even for the fanatics of 80.

It's 82 chars :)  Fair enough though.

> 
> > +		return -ENOSPC;
> > +	}
> > +
> > +	return iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
> > +}  
> 


