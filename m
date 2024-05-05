Return-Path: <linux-iio+bounces-4815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551258BC2E8
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 19:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035531F2139F
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAABB5A109;
	Sun,  5 May 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItLeR4cH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119879D2;
	Sun,  5 May 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714931901; cv=none; b=mvqQWlfFff0+K1tT4SSO6Q8UHoDmkLKaznBGltY0PYcZQ7jsfsMJ/rDn0ev4ofZyXKVFYDjvU4aRSZIli+iHwIONbMwFsNEgB39oz1cMjyMAW57UIoW+GDBsV8bRn9N8t/RMXihumRpogm+BIt6qHyCuOYI2ACUdav5nIKbvuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714931901; c=relaxed/simple;
	bh=3GEudGU7ASMXSyyGWnReK03kwpORCk7RJpxQt9efhqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDiIdUkTwGtkpyC6NBUJxf6h94CtYGHGo/qvv6oS1gxtiZxZHcibJ9eGF8MX20EgzUNM1bkZj4qhJJNz11TgZnjf3lA4cBxhHpIwp2a7LpJpxlumNtrpk/QKLziOm+8GZtdmw3qSPBw9dfYUAsB/kZnz6mvup0rjbA4o8vzFQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItLeR4cH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0984C113CC;
	Sun,  5 May 2024 17:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714931901;
	bh=3GEudGU7ASMXSyyGWnReK03kwpORCk7RJpxQt9efhqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ItLeR4cHWW45OS5rq+aGVndOX8kBINwEtq378D2RjWQiosFtPGJt8kSc7E2r5G4NZ
	 Rx2Et9IL8XfJlCIC080wi9oq3bR14KyLpG5dsy149Y7VRR+HcjOwvH2xRbXgxSejRy
	 2+OdkDptJ7Jwl7b/h0q7L5Oo8ZJR+aNFtdWuIe9cL3L6Hs+S/w0AsF4Br5crppyKqg
	 AZwJkc0eaCmtH/egcnmrO3ARkP/bcg1JlaCSEwRJXnPXCq3gcUsDXpdv1Wqh8vzCt4
	 KAGZ/K4JkMTy/Y7LstcKHvi9H/CM4h7QwEJspeBgDlpIrNbV6d+h9NbxUn6xtQHeXw
	 w5tivJtdI4oSA==
Date: Sun, 5 May 2024 18:58:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <20240505185809.7636403e@jic23-huawei>
In-Reply-To: <CADFWO8EF0WxAV=k-ZAJ1McmaYv4SD5G+O4FhoMDsVQaRqe6sdg@mail.gmail.com>
References: <CADFWO8HOb4zY7rPsCxWe2nvrzd8FjVNw0k8=8s4yB7C_BwS0ig@mail.gmail.com>
	<20240116170337.00003a02@Huawei.com>
	<CADFWO8EF0WxAV=k-ZAJ1McmaYv4SD5G+O4FhoMDsVQaRqe6sdg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +}
> > > +
> > > +static const struct iio_chan_spec sdp500_channels[] = {
> > > +    {
> > > +        .type = IIO_PRESSURE,
> > > +        .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),  
> >
> > Looks like a simple linear scale.  Would be better to make scaling
> > a userspace / consumer problem and provide IIO_CHAN_INFO_RAW
> > and IIO_CHAN_INFO_SCALE.  
> 
> I prefer returning the pressure directly because there is no other calculation
> that the user of this driver can do. If they make the calculation differently
> then their pressure value would be wrong.

Ah. I missed this and just made the same comment on v2.
Let me give some more info than in the original review.

The documentation on how to apply scale is simple and this scaling is
pretty hard to get wrong.

There are a couple of reasons we prefer to make it a userspace problem
to do linear scaling and keep the actual channel value raw (if possible).
1) Logging applications typically store the scale once, and each data
   point is then much cheaper to store as a u16 than as a floating point
   number.
2) If you ever add buffered support, we do not support floating point
   values in the buffer.  That basically means we have to have both
   _PROCESSED and _RAW provided so that _SCALE makes sense for the buffer.
   Horribly messy ABI is the result.

Hence, push the scaling to userspace.

Note that we can't always do this as some conversion functions are
non linear and very hard to describe.  In those cases _PROCESSED makes
sense.  That's not true here.

Jonathan

