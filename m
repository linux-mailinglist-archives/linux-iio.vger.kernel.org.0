Return-Path: <linux-iio+bounces-11951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABAB9BF7D0
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 21:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064C21C2148B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7720BB42;
	Wed,  6 Nov 2024 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="snd6+Ptp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5520BB40;
	Wed,  6 Nov 2024 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923730; cv=none; b=NyK/Z8ILlnfk4LWkGuq0va/XgbgdoyBCmDVnZxg6KqUfY90SH9YvpuR4BN6k9UBH57V9W5MUbB9NBkDBq9wNmyxrNF+A+cHiZl7XrZC53OoDGFgE1zEqwojejioFA0DdARWGlOjYD1hyi/CRtOrD39ZH9aseSFbscnqYU0PcD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923730; c=relaxed/simple;
	bh=LlUk3eFg56pt7glKzGWJnK1gGhXpfQ7rxkpRP9kafac=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fo6p+2HRvbbxbSInWG7SAkwnWBFeitWSJxWIBclg1S+qEwjxOLj8F7fPutVk86d2xMLY0Wke+M4MwN8EYA+5cBmWRrxHnZS/3GjF4svVsCgMu9HjcTvh/MIwtW3yJIgW4EUw7WuEzRdNmofwoq5YYgp+nQ1pUn5SKsPHzitLIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=snd6+Ptp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198B7C4CEC6;
	Wed,  6 Nov 2024 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730923729;
	bh=LlUk3eFg56pt7glKzGWJnK1gGhXpfQ7rxkpRP9kafac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=snd6+PtpLFwr5vlwQN/DQqTFf9pvtNOmTphTY6Zma9EsLff99+uUek4+2f0wuALHU
	 0ag9tms8Su9dBDWDwfBqLKMrkXJLp+vWv8Av4Yz7O+/uC6Xvkw57AMvKkFiqKrB44L
	 8ZWXC0r6xvQotZj982G2I/eKags4G6COINt65EwA=
Date: Wed, 6 Nov 2024 12:08:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, bartosz.golaszewski@linaro.org,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] util_macros.h: fix/rework find_closest() macros
Message-Id: <20241106120848.63b6665af42264a70bba1621@linux-foundation.org>
In-Reply-To: <CA+GgBR-a050NUMB4Z=Q1UhqjAcKRVVw4k+S9uBZp6iRGqHkB6A@mail.gmail.com>
References: <20241105145406.554365-1-aardelean@baylibre.com>
	<20241105150826.86b0a8f2c0df2a4822b07757@linux-foundation.org>
	<CA+GgBR-a050NUMB4Z=Q1UhqjAcKRVVw4k+S9uBZp6iRGqHkB6A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 6 Nov 2024 16:03:36 +0200 Alexandru Ardelean <aardelean@baylibre.com> wrote:

> On Wed, Nov 6, 2024 at 1:08 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > Can we fix both issues by just giving up on the macro approach and
> > reimplement them in out-of-line C code?  All the sites I looked at are
> > using 32-bit quantities - a mix of signed and unsigned.
> >
> 
> Converting this to a static-inline was my other thought, rather than
> keeping the macros.

Non-inline, I think.  It's big.

> But I'm not sure where to draw the line between too much rework vs a bug-fix.
> Just fixing the bug was done in V1 of this patch, but then the kunit
> exposed a bunch more.

Sure, just the minimum for a bugfix.

> > It's separate from this bugfix of course, but would it be feasible for
> > someone to go switch all callers to use u32's then reimplement these in
> > lib/find_closest.c?
> >
> 
> That would work.
> How would a rework be preferred?
> As a continuation to this patchset? Or a V3 to this patchset?

A new and separate patchset.  A low-priority cleanup from whoever has
the time and motivation ;)

> But, moving forward: what would some preferences be?
> - have variants of find_closest() for unsigned/signed arrays? (
> find_closest_u32() or find_closest_i32() ?)
>    - AFAICT so far, there aren't any values in the arrays that get
> close to INT32_MAX, so int32 may work for now
>    - maybe later some 64-bit variants could be added if needed
> - should the variables X, mid, left & right be the same signedness as the array
>
> The only preference (towards which I'm leaning) is just making sure
> that X (and friends) are signed.

Yes, I guess int32 would be best.  I agree that unsigned values greater
than INT_MAX are unlikely.

I suggest a series of patches which convert individual callers to int32
and the final patch introduces lib/find_closest.c.

