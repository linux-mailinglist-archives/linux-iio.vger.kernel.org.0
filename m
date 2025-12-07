Return-Path: <linux-iio+bounces-26870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B6DCAB4FE
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 13:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1951730439FA
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC432D7DCF;
	Sun,  7 Dec 2025 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdPWZ/aM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD82701B6;
	Sun,  7 Dec 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111944; cv=none; b=g+NsM/hhgcI5qIqidrPxWXaVj0vMAFF+yV8zDGffl6LT/Yj2UlQEjseBu9p/4e8Km2mV+CxXwop6r2GiAjBGgeqdxhoPYSpis2cvS9bqqlBFL5XubEQQcaxBGyChUU4l731BGFEFNFfvkL8wwuYJyLCDOxiYrxMcdVPcBZwwH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111944; c=relaxed/simple;
	bh=5DpbDqYKRLj8Bt189kwuFQzt3t9gLYSKq3Zvo+9lAC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APqf0e0E6Uw/FwVmWpeNBmDV5RtX20PqURepTqxmjmp00diFbRpiVdtNXmZNO1QZ5KfVIqkNw0SpnLKBEfBGm5+7R2QBnKcK7D8NlSSQuRy1uY94rl7dAO7Yvaokvxu095hBpWXI1AP2MkHNwPdboFu9gJVrWaSjnCGLtx72ERo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdPWZ/aM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBA8C4CEFB;
	Sun,  7 Dec 2025 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765111944;
	bh=5DpbDqYKRLj8Bt189kwuFQzt3t9gLYSKq3Zvo+9lAC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sdPWZ/aMnKlIkgqd4o/HkwPt5Q9FZ8H4taJUkTYrpY7zzDbc7TPUEyBoDkiHISsN7
	 g/WH8ZWJclamNsLuwpxTdSIWS9spj6yV8MP6yTFNVi5jY25q99256iQzj7S6ma36SZ
	 Id9/jsazTM/DN5uxF90KNXYp3a2KqbMYQIJEdUUw9APVdhodTeZphH4FajB3Bj73Wh
	 UcLDJA9FBy7oj4PAE6qEZ4WGfY150N7T5SFz5+abS3eakBce1rwdIpkh0aAwczGUkc
	 b4qGLJtne8ssAu+lFBhnAN79cqBwW+8u8FcNNvWfsXG2E6oYr+ux14+L7VcbBwd6ce
	 fmv2dRijaYtkw==
Date: Sun, 7 Dec 2025 12:52:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: amplifiers: adl8113: add driver support
Message-ID: <20251207125213.1f413e6b@jic23-huawei>
In-Reply-To: <aTSWk_p62hJBKCtN@smile.fi.intel.com>
References: <20251205144058.1918-1-antoniu.miclaus@analog.com>
	<20251205144058.1918-3-antoniu.miclaus@analog.com>
	<20251206190332.53874d41@jic23-huawei>
	<aTSWk_p62hJBKCtN@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Dec 2025 22:48:19 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Dec 06, 2025 at 07:03:32PM +0000, Jonathan Cameron wrote:
> > On Fri, 5 Dec 2025 16:40:41 +0200
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:  
> 
> ...
> 
> > > +	/* Always include internal amplifier (14dB) */
> > > +	st->gain_configs[i].path = ADL8113_INTERNAL_AMP;
> > > +	st->gain_configs[i].gain_db = 14;  
> > 
> > Could do this as something like:  
> 
> I remember a discussion where it was against this approach due to compiler
> warnings or so. However, IIRC, there was slightly different pattern, i.e.
> 
> 	foo[i].bar = ...
> 	foo[i++].baz = ...
> 
> That said, I have no objection to your proposal, but we need to use it with
> a good compile test coverage (clang with `make W=1` for a starter.

That's my standard 1st build choice now because it seems to be fussiest ;)
I haven't tried this one however.

Googling came up with a link saying GCC gives warnings on cases where
not all structure elements are set.  I think they always should be here
though which may make this fine (and act as a correct warning if they aren't).
That only works if the two uninitialized structure elements are dropped
obviously!

> 
> OTOH, the original code is robust enough...
> 
> > 	st->gain_configs[i++] = (struct adl8113_gain_config) {
> > 		.path = ADL8113_INTERNAL_AMP,
> > 		.gain_db = 14,
> > 	};  
> 
> ...and doesn't require a good understanding of differences between designated
> initialisers and compound literals.

Fair enough.  Original is better than the i++ in only the second in my view.

Jonathan

> 
> > 	st->gain_configs[i++] = (struct adl8113_gain_config) {
> > 		.path = ADL8113_INTERNAL_BYPASS,
> > 		.gain_db = -2,
> > 	};  
> 
> 


