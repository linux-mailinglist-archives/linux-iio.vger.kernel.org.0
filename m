Return-Path: <linux-iio+bounces-11929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C09BD97A
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 00:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34518B219C3
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 23:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E080C21645B;
	Tue,  5 Nov 2024 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uQjHrY1x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C321644F;
	Tue,  5 Nov 2024 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848108; cv=none; b=YS9ojeflJwzUBJ0QMiiligG7inW/Aa+dkmUQyGjEKjxwRiBVEYgWOUVNWd4gxLMHfySUyWFtcJR3lOH8TQGUvM4srieX5v9k7ePphoBW4jjuqofv6t86w2dEzPGbAFG/ivir0CR389nyNhpeHu4h5rYkWUNzz0QAGUqdlbzks7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848108; c=relaxed/simple;
	bh=8hyQC3wg/dy6ArnmFuKqZoU88ZMlDCQzqexyu2kyvcw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Gwr1ve1GmMW4QQKD/HWo2+Y3GceeK/V0AKed5Ny6NJzdRcl3X2dTzeJAlOK8licreBp71HA+uirJaYGV8AfdOysROXBpLVkhjRyhuRwabQU5xUoGAIfcFBOozYCSQ10nvoZ+Sy0J1h4StCGJ5KNGXt8fTdoXQsjvnB80kJF6t9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uQjHrY1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DBBC4CECF;
	Tue,  5 Nov 2024 23:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730848107;
	bh=8hyQC3wg/dy6ArnmFuKqZoU88ZMlDCQzqexyu2kyvcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQjHrY1xg1V3tQr+kJYpMo75KeIXwZLKw/cSwj3DD5Z/xTO0ArpHNyQruoNpyXfD/
	 UVsY0RFdJq4MOZ1DU6ZJ2kp1+VcZRBKF85yRkPJBml5NywCYLSoCSwn3mygimr2Sj4
	 a9E2AWhubqRWILR0Xp0xtZPasD/19t490eTPl8JA=
Date: Tue, 5 Nov 2024 15:08:26 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, bartosz.golaszewski@linaro.org,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] util_macros.h: fix/rework find_closest() macros
Message-Id: <20241105150826.86b0a8f2c0df2a4822b07757@linux-foundation.org>
In-Reply-To: <20241105145406.554365-1-aardelean@baylibre.com>
References: <20241105145406.554365-1-aardelean@baylibre.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Nov 2024 16:54:05 +0200 Alexandru Ardelean <aardelean@baylibre.com> wrote:

> A bug was found in the find_closest() (find_closest_descending() is also
> affected after some testing), where for certain values with small
> progressions, the rounding (done by averaging 2 values) causes an incorrect
> index to be returned.

Convincing changelog, thanks.

> -#define find_closest(x, a, as) __find_closest(x, a, as, <=)
> +#define find_closest(x, a, as)						\
> +({									\
> +	typeof(as) __fc_i, __fc_as = (as) - 1;				\
> +	long __fc_mid_x, __fc_x = (x);					\
> +	long __fc_left, __fc_right;					\
> +	typeof(*a) const *__fc_a = (a);					\
> +	for (__fc_i = 0; __fc_i < __fc_as; __fc_i++) {			\
> +		__fc_mid_x = (__fc_a[__fc_i] + __fc_a[__fc_i + 1]) / 2;	\
> +		if (__fc_x <= __fc_mid_x) {				\
> +			__fc_left = __fc_x - __fc_a[__fc_i];		\
> +			__fc_right = __fc_a[__fc_i + 1] - __fc_x;	\
> +			if (__fc_right < __fc_left)			\
> +				__fc_i++;				\
> +			break;						\
> +		}							\
> +	}								\
> +	(__fc_i);							\
> +})
>
> ...
>
> +#define find_closest_descending(x, a, as)				\

Boy these things are hard to read.  They're also bloaty and I'm
counting 36ish callsites!

Can we fix both issues by just giving up on the macro approach and
reimplement them in out-of-line C code?  All the sites I looked at are
using 32-bit quantities - a mix of signed and unsigned.  

It's separate from this bugfix of course, but would it be feasible for
someone to go switch all callers to use u32's then reimplement these in
lib/find_closest.c?


