Return-Path: <linux-iio+bounces-21067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9290CAEC94A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CEE1894E58
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E33261393;
	Sat, 28 Jun 2025 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRWdCVYG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF0155CB3;
	Sat, 28 Jun 2025 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751130699; cv=none; b=PDovr7L8tM0ifSZPt50RDby5O+eYkqRhFLtJTx7LLlcP+/BorNKpTHNRQhajOo/O71lhYuknptHspT/LaRZOIFEyGmbOrUocCmaIlsWmHO9SFrXWxMV7F6OlyfQUEJvRCiFuxBF0RwDf5LqC6gEZXsGEMDqYueVHzjdJnsspylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751130699; c=relaxed/simple;
	bh=fHiykYGJP1EunXCsYwxhkHiEOe3nWiAfPDrLDIHzYXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar0+ZUxc0xzCK29CddN+MfAEFN5ZojtVPMPfc/i9Nw36aue7D60vbJ9mLL82EeuEXpVElqbWOwEAqNixVZ+pHgY4+UzlxRyH0sJqUyeW6tUnBBWrLe3Bm6GdPVnF6M8tQVYgeTG6gLmOsfBRw8QlUVqC5FJkmVXSbh38ZILuoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRWdCVYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7A4C4CEEA;
	Sat, 28 Jun 2025 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751130696;
	bh=fHiykYGJP1EunXCsYwxhkHiEOe3nWiAfPDrLDIHzYXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HRWdCVYGuGMakdtbS4Sn3E690+F+Zi1yY3MFSXRoA/XzcMBnzgdEZQKxAUOmtPtYU
	 DiRalHnYPCr1HEgYo7UjUxxCUCCRn8d/g/EvIQXxY3/ahjFGOcLyf+7y+XQpoD3iQ0
	 c9TAgSNsMDmm1+Nl12UgG3B83jfua86FVFwn60GsiVJtgchU5OqCs4l3tTkYypfWAB
	 pDQxFPLvV8TwJ2YZ0gLmTTDWbrB9sJuN+PQsdg5TFoNp7DiK95e23nFk3p8jvq0k5m
	 rEDRw6j05fuqub6SXm4QNKe/0WoMK99hhOYYxJ4m2McAdxqx5TBqEPWE2DJmGLZI6G
	 ShB07O30b4xKg==
Date: Sat, 28 Jun 2025 18:11:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
Message-ID: <20250628181129.08f55227@jic23-huawei>
In-Reply-To: <pndtt45aq6m.fsf@axis.com>
References: <cover.1749938844.git.waqar.hameed@axis.com>
	<5d12fcd6faae86f7280e753f887ea60513b22ea9.1749938844.git.waqar.hameed@axis.com>
	<20250622120756.3865fc4b@jic23-huawei>
	<pndtt45aq6m.fsf@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> >> +static int d3323aa_set_lp_filter_freq(struct iio_dev *indio_dev, const int val,
> >> +				      int val2)
> >> +{
> >> +	struct d3323aa_data *data = iio_priv(indio_dev);
> >> +	size_t idx;
> >> +
> >> +	/* Truncate fractional part to one digit. */
> >> +	val2 /= 100000;
> >> +
> >> +	for (idx = 0; idx < ARRAY_SIZE(d3323aa_lp_filter_freq); ++idx) {
> >> +		int integer = d3323aa_lp_filter_freq[idx][0] /
> >> +			      d3323aa_lp_filter_freq[idx][1];
> >> +		int fract = d3323aa_lp_filter_freq[idx][0] %
> >> +			    d3323aa_lp_filter_freq[idx][1];
> >> +
> >> +		if (val == integer && val2 == fract)
> >> +			break;
> >> +	}
> >> +
> >> +	if (idx == ARRAY_SIZE(d3323aa_lp_filter_freq))
> >> +		return -ERANGE;  
> >
> > It's a patch not a range check, so -EINVAL may make more sense as
> > a return value.  
> 
> Hm, `ERANGE`s message does say "*Numerical result* out of range...",
> which I can see is not really applicable here (strictly speaking, we are
> really not "calculating" anything...). However, isn't `EDOM` actually
> the better alternative here? Consider the following
> 
>   echo a > in_proximity_hardwaregain
>   sh: write error: Invalid argument
> 
>   echo 1234 > in_proximity_hardwaregain
>   sh: write error: Numerical argument out of domain

I'd still stick to -EINVAL as correct if not that informative simply
because EDOM is very rarely used (wasn't one I even knew existed
until today ;)

> >> +				       data);
> >> +	if (ret)
> >> +		return dev_err_probe(
> >> +			data->dev, ret,
> >> +			"Could not add disable regulator action\n");  
> > Odd formatting.
> >
> > 		return dev_err_probe(dev, ret,
> > 				     "Could not add disable regulator action\n");
> >
> > It's fine to go a little over 80 chars if it helps readability and here I think
> > it does. However it is vanishingly unlikely this would fail (as it basically means
> > memory allocation is failing in which case not much is going to work) so
> > common practice is not to bother with prints for failed devm_add_action_or_reset().
> > Those prints do make sense for devm calls that are doing something more complex
> > though so keep the rest.
> >
> > 	if (ret)
> > 		return ret;
> >
> > is fine here.  
> 
> `clang-format` trying its best here. Let's just remove the print then.
> 
> There are a bunch drivers in iio that are printing in this
> devm_add_action_or_reset()-error-path (though it looks like the majority
> are not doing that). Probably not really worth changing those; in case
> someone would really "miss" the (very unlikely) prints.

If they are doing dev_err_probe() it won't print anyway as that only 
returns -ENOMEM which dev_err_probe() doesn't print on simply because
you get lots of info if a memory allocation fails anyway.

https://elixir.bootlin.com/linux/v6.15.3/source/drivers/base/core.c#L5017

So on that basis it would be a sensible I think to do a cleanup patch set
to drop that particular devm_add_action_or_reset() / dev_err_probe()
combination.  If it were just a case of unlikely (rather than impossible)
I'd agree that it wasn't worth the churn!

Jonathan




