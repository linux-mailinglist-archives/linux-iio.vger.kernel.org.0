Return-Path: <linux-iio+bounces-14225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55913A0AA83
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DF33A7336
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66271B983E;
	Sun, 12 Jan 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh022iMh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198DEEBB;
	Sun, 12 Jan 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736695928; cv=none; b=bDvugDG7CiUqnEcS+BQdOsmsNqF6hfSe0k6d6zzFAXUbcLQHdpI/XHJwhn/guUAVsyJMl0VIoehu9vq7/XmyndFNYDVAAPq+RrBkOSO8L6L9zxrqB+rNm8iJq2xLN2rCeL5BnhCXMBtaO9kUFROIlBGIfR6f+quhjJbhkeuZ7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736695928; c=relaxed/simple;
	bh=yezxlloN8EhvyuBnSE+1RhA8rmdf7J/AA23lsbKfKXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJGmkU7koV2xLCv/uuNK1Ior3eceW0HLgA2DNOgYUZbsh5tsn73Bkct2k7FF1MIsCEIGhP8ddAUaR8j4mXtHZ6JTgthdrlfRQoEEiq9JcBWCCDb1y//B7RBl8H7ydkkhHyAyNs1lXQ+nmAL7uEgySZgq1irul9+sJOCKsy+WsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh022iMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3626C4CEDF;
	Sun, 12 Jan 2025 15:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736695928;
	bh=yezxlloN8EhvyuBnSE+1RhA8rmdf7J/AA23lsbKfKXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yh022iMhqlGeiDqLzmDuMFHQ5I86hwUvu18IrClRnZADhJPG1sYBDLE2lnjsLRx47
	 MKY0pjpfHUTwyXrVoGAmi/060EsqbNtL0UGt/cLmisZOle8i6UjN9QW31nHiE2bzgb
	 /f2oLqR+XiGQmI627EXUfitHIGxTgAxvvppwKEXufhAxgu3GvCuun/Kxduu0CK02rj
	 UcFMcpK9BNJx3OLndfGoK+koeF4KXHwX0Y+8j95s3MJup/tZHgQf//ETe40KHkUb/W
	 5V+NAsvEX2aFcuVckMfnTmvBZS0Y7hrWPhrLLBXxBsA3bMZlavlfV18N501F9quOMI
	 FDGr7oXpQpUGg==
Date: Sun, 12 Jan 2025 15:31:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ad4695: add offload-based oversampling
 support
Message-ID: <20250112153159.5169b164@jic23-huawei>
In-Reply-To: <20250109-ad4695-oversampling-v2-1-a46ac487082c@baylibre.com>
References: <20250109-ad4695-oversampling-v2-0-a46ac487082c@baylibre.com>
	<20250109-ad4695-oversampling-v2-1-a46ac487082c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Jan 2025 13:47:23 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add support for the ad4695's oversampling feature when SPI offload is
> available. This allows the ad4695 to set oversampling ratios on a
> per-channel basis, raising the effective-number-of-bits from 16
> (OSR == 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e. one
> full cycle through the auto-sequencer). The logic for reading and
> writing sampling frequency for a given channel is also adjusted based on
> the current oversampling ratio.
> 
> The non-offload case isn't supported as there isn't a good way to
> trigger the CNV pin in this mode. Support could be added in the future
> if a use-case arises.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
LGTM
Assuming no requests for changes otherwise feel free to poke me when
the dependency is available upstream. I'll keep it live in patchwork
but I tend only to loop back over outstanding stuff once or twice a cycle
and maybe that will be long after needed for this one!

Jonathan

