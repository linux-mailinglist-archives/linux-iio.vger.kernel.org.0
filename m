Return-Path: <linux-iio+bounces-23831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E5CB47A0F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA52F17E37C
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 09:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C871221DB6;
	Sun,  7 Sep 2025 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEHE/eQ7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54621D5B0;
	Sun,  7 Sep 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757237540; cv=none; b=iVt0Nw1Llx1ahl2+maxMlZndXlRk0aXQztv+XDGLg1mvkbB/DMRQGYnlwNo8wF7Q3dh5O/hTWFknhr65Y0kYpYBLxBVLP9fj53uvaALIHwTlVtEbjoDNfx2SoWFqinqaGodqt43iybgNjsViw+Tg9c+GEuVwem8D78NS/gHAn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757237540; c=relaxed/simple;
	bh=/NHf1vUbI+10bDKKbH/ivJk3l0Zj95OGpnSOOpjwd5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ux/rWWxOt3arh3nf5aBZeJos4zoje6uLKhQZyTZ9ZDxU+1occQ4WE+XCJ5yowI0wWQTqe9OFSWHy4uSU5a3PqWqmp0PldbgUvvp3Mv7ZJVbrkxWA4sAkJuvr1NEQg9aylJm9vhxnScO7U0L5UxI3AEFXFTDVy92DXOm8LExDXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEHE/eQ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3518BC4CEF0;
	Sun,  7 Sep 2025 09:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757237540;
	bh=/NHf1vUbI+10bDKKbH/ivJk3l0Zj95OGpnSOOpjwd5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hEHE/eQ7DSPINeTR/ZNRluy/UBMS9OPDefwKgnz04oJKVedATK8DHF0jkAAb7qe0O
	 AKM05nnygn9Qe/5RoV9B96Mn3mHFEDbn2+flQ0Xpoqz6IX5crwgrQ5LyEjVR8PQC1P
	 zHJGpkbAd0etUxabggRJGbZYjMQiNg0C1wHXXdAdi/pWAz1zHybVojSyE/SruRE9V4
	 JpXGsJzY8hxv1FbU79Dw1uEkGDrRTbqFGVKsWlMLsDEl9oEsYiduTCihTSdZIjmknR
	 Gkqt9dddPz5sNyDqVrcKUQ+tGhuBzYlbKQflkz9hUWnwm2o7IWlkCiJ+cDl1YHrtvQ
	 6k3lxl/GHAbBg==
Date: Sun, 7 Sep 2025 10:32:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, linux-iio@vger.kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: pci: mg4b: use aligned_s64
Message-ID: <20250907103211.0b4b1ff6@jic23-huawei>
In-Reply-To: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-1-55996f077a02@baylibre.com>
References: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-0-55996f077a02@baylibre.com>
	<20250905-media-pci-mfb4-iio-trigger-improvements-v1-1-55996f077a02@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Sep 2025 14:06:19 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use aligned_s64 for IIO timestamp field instead of explicit __align().
> This is the convention used throughout the IIO subsystem. No functional
> change.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Closes: https://lore.kernel.org/linux-iio/20250724115610.011110fb@jic23-huawei/
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/media/pci/mgb4/mgb4_trigger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
> index d7dddc5c8728e81c6249b03a4cbf692da15a4ced..bed8bbd4bc595d1d131b9919c6f3b705e43ba3c4 100644
> --- a/drivers/media/pci/mgb4/mgb4_trigger.c
> +++ b/drivers/media/pci/mgb4/mgb4_trigger.c
> @@ -17,6 +17,7 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/pci.h>
>  #include <linux/dma/amd_xdma.h>
> +#include <linux/types.h>
>  #include "mgb4_core.h"
>  #include "mgb4_trigger.h"
>  
> @@ -90,7 +91,7 @@ static irqreturn_t trigger_handler(int irq, void *p)
>  	struct trigger_data *st = iio_priv(indio_dev);
>  	struct {
>  		u32 data;
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
>  	} scan = { };
>  
>  	scan.data = mgb4_read_reg(&st->mgbdev->video, 0xA0);
> 


