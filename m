Return-Path: <linux-iio+bounces-14173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B725A0A8C6
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC113A6440
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641BE1ACEAC;
	Sun, 12 Jan 2025 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM4Nj+Du"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194001AA7A6;
	Sun, 12 Jan 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736682706; cv=none; b=TihNvjz5tRbWrEYGTDMejTn7AiuIdUE8hcuuyrrsVW5lZV+iWjELRUdUKS0U33iIJhMC6fjmCMrpuJ8D39syKm1VzsgjF3HBIxk/W0nR8VW8oKrMZzyMnBIP0AIMYmyXu/KHjwk85CjITab8gYC0ropIum8HyXetBaS5upHLmQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736682706; c=relaxed/simple;
	bh=kLb2RSqL0b3nlKgCPbB3GXBfwnR1eJEpCb71GUrkvUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWP5bi/LBKGDIkCGGcNTb2W9UEJNrNnrFhPVS2gRwyZ0xFxkTaShOyIobKUpax1IUdu620UlsR5VrBG1KqLP4vcaNVj+cVr/sKzXeiP6IDZ1LU8es3YeY465hpgYLir8f6BahHMS1oe2mIGgP3noCTeDq061Ckd86EiJqd5jt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM4Nj+Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21236C4CEDF;
	Sun, 12 Jan 2025 11:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736682705;
	bh=kLb2RSqL0b3nlKgCPbB3GXBfwnR1eJEpCb71GUrkvUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lM4Nj+Du7fKz6Iotj3UaH2B19vCODVpzVl2rZZ6ZOBaylO+A32uuK4TGX3SboZZZV
	 KcuXFdl1Zq03OyUGFcTN78ndjHs9JvvS68EROslXVlnyUeZGP7GGFP1WgITiVxkMZ8
	 ujqw5ODblrowMT8fhELb4uokEIJBZ/7uM/u5sZH1FUZMVLP44H30y2IiCc83sf/8wh
	 RGMG8M4xQ7ddFgY2F1EIxXHH8JXWd4aaofA4c5/bmrjMpGpObu0TwxXqOFOdJJXstW
	 4T8URLdngzZp/fIv9W7CnZjTXKrL7YIFSo7Cor7PRtM5iekyzEgwh7NGD2I7g2tz2j
	 2l8a3wWuZlNWQ==
Date: Sun, 12 Jan 2025 11:51:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/5] iio: adc: ad7380: add alert support
Message-ID: <20250112115137.1e0c6f69@jic23-huawei>
In-Reply-To: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Jan 2025 13:49:32 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Hello,
> 
> The ad738x family includes a built-in alert mechanism for early
> detection of out-of-bounds conversion results. This series introduces
> this functionality to the ad7380 family.
> 
> This is the first non RFC version of the series (RFC available at [1] and [2]).
> 
> Given the fact that the main use case is to hardwire the interrupt line
> and according to discussions in V2 about interrupts, I think the best is
> to not generate events, at least while we don't have a reasonable way to
> correctly and efficiently handle interrupts.
> 
> Events attributes are still populated to allow user to set a threshold
> and enable alert detection, so alert pin can be hardwired.
> 
> Userspace event can still be added later if needed.
> 
> [1]: https://lore.kernel.org/r/20241029-ad7380-add-aleyyrt-support-v1-1-d0359401b788@baylibre.com
> [2]: https://lore.kernel.org/r/20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Series applied to the to testing branch of iio.git.

Unless the release is delayed for some reason, we are now too late to make
the merge window, so this is next cycle material.

I'll be rebasing the tree on rc1 once available and pushing out as togreg
only once that is done.

Thanks

Jonathan

> ---
> Changes in v4:
> - docs: fix some nitpicks from David Lechner
> - driver: fix some nitpicks from David Lechner and use helper functions
>   to get/set the thresholds
> - driver: fix reading the low threshold value
> - add Reviewed-by tag from David Lechner
> - Link to v3: https://lore.kernel.org/r/20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com
> 
> Changes in v3:
> - split regmap cache commit in two
> - remove interrupt handling completely, updating commit messages,
>   driver, and doc
> - fix minor comments from v2 review
> - improve commit message for iio_device_claim_direct_scoped removal
> - Link to v2: https://lore.kernel.org/r/20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com
> 
> Changes in v2:
> - fix read/write high/low thresholds
> - add reset_timeout mechanism for buffered reads
> - implement regcache
> - add cleanup patch to remove iio_device_claim_direct_scoped calls
> - add alert section in the Documentation page
> - Link to v1: https://lore.kernel.org/r/20241029-ad7380-add-aleyyrt-support-v1-1-d0359401b788@baylibre.com
> 
> ---
> Julien Stephan (5):
>       iio: adc: ad7380: do not use iio_device_claim_direct_scoped anymore
>       iio: adc: ad7380: enable regmap cache
>       iio: adc: ad7380: do not store osr in private data structure
>       iio: adc: ad7380: add alert support
>       docs: iio: ad7380: add alert support
> 
>  Documentation/iio/ad7380.rst |  33 +++-
>  drivers/iio/adc/ad7380.c     | 402 +++++++++++++++++++++++++++++++++++++------
>  2 files changed, 378 insertions(+), 57 deletions(-)
> ---
> base-commit: 5ab39233382c621d3271cc274d1534e1b687f4d3
> change-id: 20241029-ad7380-add-alert-support-4d0dd6cea8cd
> 
> Best regards,


