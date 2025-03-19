Return-Path: <linux-iio+bounces-17084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62BBA687A7
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 10:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1E6189B206
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C72253321;
	Wed, 19 Mar 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOBhBqIq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB92116ED;
	Wed, 19 Mar 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375645; cv=none; b=Zl4Vnoms0oN7+3kMWzxeK2g89hm1d+HRZicagUZxUNwp0MxMwIerTFnufzglXFdFCstVwHoRwvH9ZoznQspTXvLOF+mAhpFokDnXIBm7dwncj9qiVJQkCmDtuqoOR11+n0j1Abz2j7L3nANz67J73fJ+Ygs0Ervw+ossf+TzPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375645; c=relaxed/simple;
	bh=dLUxq01k+q5g7y95QccNBbmhUY3uJw9W4BKARwlPKGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWHAJShczy8UH7BhaMxIVHMGl6ed59KGz5pEamL7Y57ecDZ4KGCO/cti/gmqxbR8mOPEyRDpVddbSAZ0xTA0dSa5GpYUy9hKUy3mYAdyvtpUVsShaqSrKHuSPlqf6L7Luogg71EhqkOEFZ/03JtloVa3EkXD3FZPv5JCMwTZ9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOBhBqIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7627FC4CEE9;
	Wed, 19 Mar 2025 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742375645;
	bh=dLUxq01k+q5g7y95QccNBbmhUY3uJw9W4BKARwlPKGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jOBhBqIq3qcz7Q+6e2HEm+55yFEdpjzn9T6K6D1uIKt8BLdAK4YYGxRBGbSv3AyqK
	 IzfyyDdbdpPcL9JZtbcLUM4eU6dN1VyRP3V1eiEYyE8HPngQ1qetpOZbasawoy98we
	 Mekeht5LeCovGlVnKHFA/tZ2bjFVW3XjKWJh4zHcMWUaTN0PepAsWygD/TUf9VcgTl
	 A+JUyc3kgxbDBd84YGLbx6HO7Y/aR8OilRwjn28A544elMRT6nYhE1xCeBLFx8rQwG
	 cIGDvSXf1wzRIJg0f4Dw0Y8jHzJ582/UEblA4pvONu7QZpH9uoW/mUITTuoW71IVi2
	 SxOmK78ShRIOg==
Date: Wed, 19 Mar 2025 09:14:01 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] iio: proximity: cros_ec_mkbp_proximity: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z9qK2fWOP2KinRot@google.com>
References: <Z9lEYdPPIyiRGm36@kspp>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9lEYdPPIyiRGm36@kspp>

On Tue, Mar 18, 2025 at 08:31:05PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/iio/proximity/cros_ec_mkbp_proximity.c:63:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

