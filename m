Return-Path: <linux-iio+bounces-7390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D74929788
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 13:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B431C20A14
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C01BF3A;
	Sun,  7 Jul 2024 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvGwxSoY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C3D1CD00;
	Sun,  7 Jul 2024 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720350204; cv=none; b=me/GuMbuRGOihG7LP/nqZm4UhFJQcNRc9fcVe1VdSfbIJ95XqcsN9cVIkNAIfVGRCBWH+JAHmjg/fhhMNoTKhuK7mFN+YROUum53j4RwUSuACWdkAf9Hb0tIo1iS/A2kBCMn8FpsU4IstsNtvdNpWinvW35pqle9e87aT+IadnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720350204; c=relaxed/simple;
	bh=rZq8y/nfB592aWpSAA6XvX0lF6OMilx0LOgA1yo+8TA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1jefBrcljC4t5al8lhDj8kgktvgZQDE+VZrhH8I9DsOb9qfdLzJeTwuQ2BIzWej4dVp4L0zYAznEvfK4+KvGDIE3FgOLDaD6jOt5x3N0KBA38VuLN8KHt+goVoBHxO7Y/pBElcKi2N3SKI7Pif97CFbn3NP9gf3VomQ6JPbYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvGwxSoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B14AC3277B;
	Sun,  7 Jul 2024 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720350203;
	bh=rZq8y/nfB592aWpSAA6XvX0lF6OMilx0LOgA1yo+8TA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvGwxSoYJuakPOlDpRHXlFptfutMGIfqXzFmmW8kJvfyIMSHxcq7Y9fdNoTp5n/BL
	 Jxa2LurSK7neDOoQF7kQWbamXeoUgvr6NF3PYWygcqNTqXg2GFORuFrAMiWEm4MXZ2
	 rWXzoBIbtyNW1KTx8hevn3qBIkUEIxFEIZwd915aRXOnYOdI8FkysRH/57QRMOfPtE
	 BcOgkf7HCSocRQFQBjIm/1FTAun6mHJvYRLIbWM+jdfnukk/I8hhRKxM8qNj6aFqNA
	 A6onupEz7vDbPW6z1pFy5qbTUUIcUBDxZdqsfrsV87BbRMDSvPO0OLSa2vpYbJ8+O3
	 87U1BVqAdJcog==
Date: Sun, 7 Jul 2024 12:03:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, jstephan@baylibre.com,
 dlechner@baylibre.com, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/8] iio: adc: ad7606: Improvements
Message-ID: <20240707120314.7d363662@jic23-huawei>
In-Reply-To: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jul 2024 17:34:04 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> This series adds the following improvements over the current AD7606's
> driver implementation:
> 
> - Fix wrong usage of gpio array
> - Fix standby that was documented as ACTIVE_LOW but handled in the
>   driver as if it was ACTIVE_HIGH
> - Improve dt-bindings documentation
> - Switch mutex lock to scoped guard
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Given issues I'm having locally with b4 I applied these but added tags by hand.
Tweaked last patch description to mention guard() rather than scoped_guard()
to reflect changes in v3.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Remove the two first patches that were already picked up.
> - Add styling corrections.
> - [Patch 6/8] Improve commit message.
> - [Patch 8/8] Replace every scoped_guard by simple guard.
> - Link to v2: https://lore.kernel.org/r/20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com
> 
> Changes in v2:
> - Change scoped guard to guard(mutex)(&st->lock). This was tested with
>   Rob's bot condition, and seems not to generate warning anymore.
> - Reorder the commits for avoiding bisection issues and respect commit
>   priority rules.
> - Add vdrive-supply to required properties.
> - Separate cosmetic changes from content ones in dt-binding
>   descriptions.
> - Move maxItems changes (and plural in descriptions) to the commit that
>   adds conditions.
> - Link to v1: https://lore.kernel.org/r/20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com
> 
> ---
> Guillaume Stols (8):
>       dt-bindings: iio: adc: adi,ad7606: normalize textwidth
>       dt-bindings: iio: adc: adi,ad7606: improve descriptions
>       dt-bindings: iio: adc: adi,ad7606: add supply properties
>       dt-bindings: iio: adc: adi,ad7606: fix example
>       dt-bindings: iio: adc: adi,ad7606: add conditions
>       iio: adc: ad7606: fix oversampling gpio array
>       iio: adc: ad7606: fix standby gpio state to match the documentation
>       iio: adc: ad7606: switch mutexes to scoped_guard
> 
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 123 ++++++++++++++++-----
>  drivers/iio/adc/ad7606.c                           |  47 ++++----
>  drivers/iio/adc/ad7606_spi.c                       |   5 +-
>  3 files changed, 115 insertions(+), 60 deletions(-)
> ---
> base-commit: 340fa834ae229a952db04a57ed13fd5d35d75818
> change-id: 20240416-cleanup-ad7606-161e2ed9818b
> 
> Best regards,


