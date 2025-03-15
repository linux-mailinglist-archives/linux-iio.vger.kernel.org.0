Return-Path: <linux-iio+bounces-16884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40391A6329F
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 22:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8238B16F798
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 21:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580C1A3149;
	Sat, 15 Mar 2025 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUyMT9gt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B65197A8E;
	Sat, 15 Mar 2025 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742075767; cv=none; b=K792J5u9EQkreUyDA3pr3zqdJG80kQ3yrlo6gKJXcFOJrseRETXffv/5Nnk+oLupFcRDZqVWZt9Vq/8kQebU0el/Q8m1SJpqibhXcnUZwngr9Y3F0+vqu5z+oyCPNtchpSbku1WEn4i9BZKU6R/45S9H2ihL4aiWgfH5ClDHook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742075767; c=relaxed/simple;
	bh=zEP1AsJWOjAINPoMS205umleYb+VbBnUqXVLudVGoZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMBmzeib7hdGRGIdDnujijVR/v0HTvGJ+NKNxikPQqKOa2W6NYZaXHz+7iPTX+t0NPkQ/EcDWasJcYchLNWO9/P8PmgB+DJ0Dogi3ZGQKRH3ynA1pgecHJFNm/yqgzU6sp6+dHqEf94XXrqvxbzIfJnV19wpJyD7SdKvqEyF2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUyMT9gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F3DC4CEE5;
	Sat, 15 Mar 2025 21:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742075765;
	bh=zEP1AsJWOjAINPoMS205umleYb+VbBnUqXVLudVGoZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dUyMT9gtTl45VUvStCjjZOTVc7vEwcPEdZXIpk1iFimk4gJv9KxAAFVLiLGhzBjG5
	 dNNoZUHSg+Vr3FMPa3XafkRsaSEB6zR3eIvmiqtQ6U91aPPpmrTCDtEObXJXedwVHt
	 i/3P4DA5bE6P4W1arIRkUj4oLQvkJhy1ZPkDbL1EiG7mYZusY71p+n/jC9cjtPL0WK
	 aO+EVa4cMaZ8mXFfjD8Pl+u+H3tT74krUzrKZLGodmn+UbiltSE3bvSOoH4yfo/9sq
	 uDrBi4gzIz7o6TeWcnrkEOQ36iT1huN1gYgHIerK30Z3sJQBkOxFewPzNJlefZT5uo
	 Aw85g2/QugGAQ==
Date: Sat, 15 Mar 2025 14:56:02 -0700
From: Kees Cook <kees@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: ak8974: Add __nonstring annotations
 for unterminated strings
Message-ID: <202503151455.B8E9F6F1@keescook>
References: <20250310222346.work.810-kees@kernel.org>
 <CACRpkdbUk8bVWLPwVRq0qzaKRC80=bV1Wd01h+5xfH1O7-BVaQ@mail.gmail.com>
 <20250315183125.40f9c566@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250315183125.40f9c566@jic23-huawei>

On Sat, Mar 15, 2025 at 06:31:25PM +0000, Jonathan Cameron wrote:
> On Fri, 14 Mar 2025 11:31:09 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > On Mon, Mar 10, 2025 at 11:23 PM Kees Cook <kees@kernel.org> wrote:
> > 
> > > When a character array without a terminating NUL character has a static
> > > initializer, GCC 15's -Wunterminated-string-initialization will only
> > > warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> > > with __nonstring to and correctly identify the char array as "not a C
> > > string" and thereby eliminate the warning.
> > >
> > > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: linux-iio@vger.kernel.org
> > > Signed-off-by: Kees Cook <kees@kernel.org>  
> > 
> > Fair enough,
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> Kees,
> 
> I've currently queued this for next cycle as it doesn't feel like a fix
> as such and I've already sent my pull request for the merge window.
> 
> Is it worth rushing it in, or is a fully cycle delay an issue? (6.16)
> 
> If slow is fine, applied to the testing branch of iio.git which gets
> 0-day bot exposure.

No rush needed at all. This is just for cleaning up warnings for the
coming releases of GCC 15 in couple months. Thanks for picking it up!

-- 
Kees Cook

