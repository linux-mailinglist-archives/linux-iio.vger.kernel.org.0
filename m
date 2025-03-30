Return-Path: <linux-iio+bounces-17384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F428A75BBC
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 20:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD29B188B51D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22A1DDC15;
	Sun, 30 Mar 2025 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ma2iYNBf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCD1D61BC;
	Sun, 30 Mar 2025 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743358320; cv=none; b=lsmswiyNAXtqeHjqUH91YJX17D09ehtOPJd3e2BzzwJ9hq91DWe6vAPf5Z+8/sB5JKkJjLodFMULdY6blL57NLulZiRbB+JUvrWYeJRmuRzeCjcBTvufeZ22+Dr2JTrJ6pmxAelmcOiki5cAq7VCK7CuNXnw78JbtGwWUZLVVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743358320; c=relaxed/simple;
	bh=Sdl20I5Xw+vi2BZmDfnPwKUCQrwnL638lDH7uUMnX6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCwQLLpuTLCbi9MPqbOrfzDp8oUxgO6thUAtjp0Swnmmu984FiwFIQ7vAvpelA15AB1n8FihUzAq6DWlWEDqwWfNsDuFP8kEckAkp6sPvvMHfJCe/uG7eZK+KRe2NlfIDm4C7BQjhUgbgmfZaab+WJ3QV+tHsiBDeaJDb1awCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ma2iYNBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9735C4CEDD;
	Sun, 30 Mar 2025 18:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743358320;
	bh=Sdl20I5Xw+vi2BZmDfnPwKUCQrwnL638lDH7uUMnX6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ma2iYNBfxtUWMjVVYvfsfZ+mW7HpLIU2br4hI7IPECCFqrh9aZhA1pIzimyLzyAR1
	 MIBFtQRMdUyTn2EUX6kSHFoCnCh3WmKunbIc48UQl53hmgWBotMWSTCPmxlIqrNy2w
	 6otjesBgOrj6s/KygwFlaxaynBqkFBGPsN3DsqRK/Yg9xOTBC2JG3K9+NAfUv+tkeh
	 7RDuvL8ByLfikMddYeAcoxT9Cvu6brYTVWrbgHeEDDNsMGEnwglfee6Vl1luySfn+l
	 AqBYK/KOEP+qyuU367n4gyfs5cVfMZm9yLYFoJCGTh2AeQ8AocgZtyk2EYzYnmxf6Y
	 uJkih+SHWuT2w==
Date: Sun, 30 Mar 2025 19:11:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Benson Leung <bleung@chromium.org>, Guenter Roeck
 <groeck@chromium.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] iio: proximity: cros_ec_mkbp_proximity: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250330191152.5b1b1259@jic23-huawei>
In-Reply-To: <Z9qK2fWOP2KinRot@google.com>
References: <Z9lEYdPPIyiRGm36@kspp>
	<Z9qK2fWOP2KinRot@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 09:14:01 +0000
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Tue, Mar 18, 2025 at 08:31:05PM +1030, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> > 
> > Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> > a flexible structure where the size of the flexible-array member
> > is known at compile-time, and refactor the rest of the code,
> > accordingly.
> > 
> > So, with these changes, fix the following warning:
> > 
> > drivers/iio/proximity/cros_ec_mkbp_proximity.c:63:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>  
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Thanks,

