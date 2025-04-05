Return-Path: <linux-iio+bounces-17647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C3A7CA95
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 19:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7996177BA7
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 17:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25A819A2A3;
	Sat,  5 Apr 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of4FwQRs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD01993B2;
	Sat,  5 Apr 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743873138; cv=none; b=R7VZArB8BJ/5YLe3CONLlKolBVDBZs0IGp7CMYgi0Gt25zM6BbRraqzisEBloQC6/Bo/bHjfIQNS5BcoWxalLnkyn/ayHYex28JZ+oer2UkNh7SiVvjRh4FnoLlYnuj0m0CSq/7//Sjp1ywgJIiYzZwHByrFRt0EkVVR0oJECKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743873138; c=relaxed/simple;
	bh=Oc4uyqHtOPFNtYHEZPJaclnM3in6j64NjiX3Ew8Xm5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuE1PR6tPDyLmAd+5obfkwE6Tsw+FOf4+IL1jPkcJNpfjUbao3xYVPMimwwgueNY6oV7MUu0Bhg036adtVkxOqICbv+x/fjnLWOHbN/e6NLFh7GRkyAhSarG0/7m0FN5SHCU6LHKBA7VhWVWm7H8RkFSpsA5og1j7U0H64N6cR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of4FwQRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E29FC4CEE4;
	Sat,  5 Apr 2025 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743873137;
	bh=Oc4uyqHtOPFNtYHEZPJaclnM3in6j64NjiX3Ew8Xm5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Of4FwQRszpMcns+kgRM4Apg1oV7ZC7LZWaz1ZMoxOHHSC5p6DkM8MTkq6Fub7LcL0
	 99GIGrIvz+6zu1nWA6auKVu2JRpMH78lHYp+ulqZqjrK6OX4bzeDn+CtV5b5mMCWAK
	 sjvVFjZR8WTBO0vW5voAyw+Pv+wGzWLs3LOLipDReO3oDCQWlH3ls7PwI7ddpis3EG
	 yHm2GQ1gbTVn3/qb9ieBgC1QRro8xYefAOYPVlKBbvn6LVzR1aSwvOvnr3ZfdnRM6o
	 g//upi+9V2bYmzyIb2HKkcHXHm+z/OTT+lq1jeDlhA142xhoL3eYDRvT34EK51b/CD
	 Us25Zmz+Cvxuw==
Date: Sat, 5 Apr 2025 18:12:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] iio: light: Modernize al3010 and al3320a
 codebase
Message-ID: <20250405181210.5e7a181a@jic23-huawei>
In-Reply-To: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
References: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Apr 2025 21:33:23 +0200
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> This series aims to improve code readability and modernize it to align
> with the recently upstreamed AL3000a.
> 
> Apart from slightly improved error reporting, and error handling
> there should be no functional changes.
> 
> Module  before after
> al3010  72 kB  58 kB
> al3320a 72 kB  58 kB
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
Applied, but with tweaks to not add print messages as described in patches 1 and 3.
That meant a bunch of hand application was needed for 4-5.  Please check the result
in the testing branch of iio.git.

Thanks,

Jonathan

> Changes in v4:
> - Fixed mixed-up rebase changes between commits and added
>   regmap_get_device into _init functions to get the device.
> - Link to v3: https://lore.kernel.org/r/20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz
> 
> Changes in v3:
> - Stripped patches merged from second version of patchset.
> - Dropped iio: light: al3010: Move devm_add_action_or_reset back to _probe
>   in favor of opposite approach moving devm_add.. to _init for al3xx0a:
>   - iio: light: al3000a: Fix an error handling path in al3000a_probe()
>   - iio: light: al3320a: Fix an error handling path in al3320a_probe()
> - Link to v2: https://lore.kernel.org/r/20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz
> 
> Changes in v2:
> - Dropped Daniel's email update.
> - Dropped DRV_NAME introduction for al3000a
> - Added DRV_NAME define removal for al3010 and al3320a.
> - Splitted unsigned int conversion into separate patches.
> - Replaced generic value with specific raw and gain variable.
> - Use dev_err_probe() for error handling.
> - Separated devm_add_action_or_reset move from _init back to _probe.
> - Dropped copyright update.
> - Link to v1: https://lore.kernel.org/r/20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz
> 
> ---
> David Heidelberg (5):
>       iio: light: al3010: Improve al3010_init error handling with dev_err_probe()
>       iio: light: al3000a: Fix an error handling path in al3000a_probe()
>       iio: light: al3320a: Fix an error handling path in al3320a_probe()
>       iio: light: al3010: Implement regmap support
>       iio: light: al3320a: Implement regmap support
> 
>  drivers/iio/light/al3000a.c |  9 +++--
>  drivers/iio/light/al3010.c  | 85 +++++++++++++++++++++++--------------------
>  drivers/iio/light/al3320a.c | 89 +++++++++++++++++++++++++--------------------
>  3 files changed, 100 insertions(+), 83 deletions(-)
> ---
> base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
> change-id: 20250308-al3010-iio-regmap-038cea39f85d
> 
> Best regards,


