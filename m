Return-Path: <linux-iio+bounces-27076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E76ACBBC58
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 16:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0530530084C4
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E043728B4F0;
	Sun, 14 Dec 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9VEQn5U"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB928727B;
	Sun, 14 Dec 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765725275; cv=none; b=eOv84MwXTLnXjz/I069KcR27GmNDbXA4MphaVbgItRMUE6D2y7/wlJHig4XGkit1XypklSMd/r/DKxON9Xy5X1mRXCX1xrv4RX4olCWuLJhvYTowAVsIGL8KaWwnFFCqViWEFyBaQ/asl2YRh3IYoYDncTyXDy9kcko+VBKM74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765725275; c=relaxed/simple;
	bh=2V6J6u2SRYjY+V2U7T6xXb/ruoLnNBpGcyymsD7BXGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CviAWuHChEwJQmODaKL/lOSnWcLhT3oXr6i4GlFN2OlU7TcxNpbINzifIsWeXMjW33du4f/I4ExK8aANwNI0xs2DJMTWBxkjzUcrwPe6bce0SM6fNyLruLpbw4vxS5p3VDsBm8p4roAybZ4l2mT1oLyBXBNpcAHrR+d6j1saRI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9VEQn5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E555C4CEF1;
	Sun, 14 Dec 2025 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765725275;
	bh=2V6J6u2SRYjY+V2U7T6xXb/ruoLnNBpGcyymsD7BXGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T9VEQn5UV87wjRJvJCPfvMJlqH/yb4maVKUXO34ZfOCKDdPJTTd20wtcOfnn8AKO9
	 l21jPdcNOR4j36JTTSIRExdORh/Iz4OU8c3NDfs910/Vyz2MOp2X3gYrrNrhetOg3r
	 K+9owdty92HfvGfJpJZ47D/xekXU19jN08UW8nABgYj84zuRxfnAAZ17BBJ/lCSlK4
	 XMegIz14Zi5om26OFq6px4rBZ58Dub+uzDWHz9/hpdH3sm9xpiEMx+uAi8zcq1p6f9
	 pnVr2uYiPDkHPlsEeVQ3f6aAdUZknZcW1xHjCLmfWEFfSTKZfs/sKuRaaBpxs61HUs
	 GgHbE1eRTn0Kg==
Date: Sun, 14 Dec 2025 15:14:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/3] iio: adc: ad9467: add support for ad9211
Message-ID: <20251214151426.2bbd8515@jic23-huawei>
In-Reply-To: <20251209-add-ad9211-v5-0-8da056eb62e9@vaisala.com>
References: <20251209-add-ad9211-v5-0-8da056eb62e9@vaisala.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Dec 2025 15:38:09 +0000
Tomas Melin <tomas.melin@vaisala.com> wrote:

> This series adds support for the ad9211, a variant of the already
> supported devices.
> 
> Example usage:
> 
> $ cat name 
> ad9211
> $ cat in_voltage_scale_available 
> 0.957031 0.976562 0.996093 1.015625 1.035156 1.054687 1.074218
> 1.093750 1.113281 1.132812 1.152343 1.162109 1.171875 1.181640
> 1.191406 1.201171 1.220703 1.240234 1.259765 1.279296 1.298828
> 1.318359 1.337890 1.357421 1.376953 1.396484 1.416015 1.425781
> 1.435546 1.445312 1.455078 1.464843
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9211.pdf
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>

Hi Tomas,

Series applied.  There was a bit of fuzz, but I guess that's down to
the fix I have queued up in a different branch. So should be fine.

Applied to the testing branch of iio.git for now as I will be rebasing
on rc1 once available before pushing out as togreg for linux-next to
pick up.

Thanks,

Jonathan

> ---
> Changes in v5:
> - Sort header includes by group
> - Link to v4: https://lore.kernel.org/r/20251209-add-ad9211-v4-0-02217f401292@vaisala.com
> 
> Changes in v4:
> - Add commit which sorts headers includes
> - Drop array_size.h patch
> - Link to v3: https://lore.kernel.org/r/20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com
> 
> Changes in v3:
> - Add Cleanup kernel.h in favor of array_size.h patch
> - Drop redundant empty line
> - Amend commit messages
> - Link to v2: https://lore.kernel.org/r/20251204-add-ad9211-v2-0-a1561f977ee5@vaisala.com
> 
> Changes in v2:
> - Use HZ_PER_MHZ
> - Update commit message texts.
> - Link to v1: https://lore.kernel.org/r/20251203-add-ad9211-v1-0-170e97e6df11@vaisala.com
> 
> ---
> Tomas Melin (3):
>       dt-bindings: adc: ad9467: add support for ad9211
>       iio: adc: ad9467: sort header includes
>       iio: adc: ad9467: add support for ad9211
> 
>  .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |  2 +
>  drivers/iio/adc/ad9467.c                           | 61 ++++++++++++++++++----
>  2 files changed, 53 insertions(+), 10 deletions(-)
> ---
> base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
> change-id: 20251203-add-ad9211-897dc9354185
> 
> Best regards,


