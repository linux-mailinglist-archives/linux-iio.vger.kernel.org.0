Return-Path: <linux-iio+bounces-21943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA80B1083E
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53959175FBC
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E0626A1CC;
	Thu, 24 Jul 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ+u4mhH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758826A0AF;
	Thu, 24 Jul 2025 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354579; cv=none; b=lvdzX1sIgSE7wBpVFs+S0ucfJVjrARZT13HTWgg+XKr09v3tvnTRGNmRl0YOdoEVv1IsJdd7H8bRQiHiQLqjC4mzPOrtztpXCUWTM/BetUfFyGum3wJiZsij33nD8wFUnLzKbtJiAG/VfeoQommce9Wi49oAde2j9u5vvCMUs04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354579; c=relaxed/simple;
	bh=rgiACCebwwXARJfSecMLQ8xdK1fgeasDAZabRPSLw3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QL+bZEZDsNlDrlIasmzVxg39PHabhifZo9WxAOz1x9qkzatpndQ5A/BzE/cWkgxLhOljx+DimZNSVFGFTeHHexe8Upui/1wwxEpJ+M/WXZz4rs6XVOl3hV7B3ok1Has0cirdcbdwy8h+EMnIaJFXG5i6+YGh8dl1VdtFNZ6C3uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ+u4mhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8760EC4CEEF;
	Thu, 24 Jul 2025 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753354578;
	bh=rgiACCebwwXARJfSecMLQ8xdK1fgeasDAZabRPSLw3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJ+u4mhHv6W6sej1JQMkNABmBBJgCJmWjmnK7cbe92wE3QmOLkKBJxpaPq+7J64jY
	 pYte3uOSNl+WIjlbFqB3qT2MYBzdsRUasv5f6hm8FA9GNowtUm7Uh0q4+kPH6VBi6F
	 syOZ3WCnb///PHB5HuhSMUzfGwiw8B8v2kJhWYM4UdcGZwziI0psYc6DBs4TnWRZNj
	 TkO0RPsAq/PJPAHnJcGsK+p1LYUtOuywN3+pOQzcNtRgELYpxpUTIuqY1VkgHSp1t9
	 D15bKCR6mwHfmBXq/TI/5atjVoIU2tcCzcUeqpW/OKTlyxVYXMEu30nniCwLne+7gN
	 EOac73RRCplKA==
Date: Thu, 24 Jul 2025 11:56:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] media: pci: mg4b: fix uninitialized iio scan data
Message-ID: <20250724115610.011110fb@jic23-huawei>
In-Reply-To: <20250722-media-pci-mg4b-fix-uninitialized-iio-scan-data-v1-1-5b236115264a@baylibre.com>
References: <20250722-media-pci-mg4b-fix-uninitialized-iio-scan-data-v1-1-5b236115264a@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 17:05:46 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix potential leak of uninitialized stack data to userspace by ensuring
> that the `scan` structure is zeroed before use.
> 
> Fixes: 0ab13674a9bd ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/media/pci/mgb4/mgb4_trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
> index 923650d53d4c82e87b542f87c3a0fbf6170dadc8..d7dddc5c8728e81c6249b03a4cbf692da15a4ced 100644
> --- a/drivers/media/pci/mgb4/mgb4_trigger.c
> +++ b/drivers/media/pci/mgb4/mgb4_trigger.c
> @@ -91,7 +91,7 @@ static irqreturn_t trigger_handler(int irq, void *p)
>  	struct {
>  		u32 data;
>  		s64 ts __aligned(8);

If you don't mind doing a follow up can change that to aligned_s64
and switch to iio_push_to_buffers_with_ts()

If not the second one at least will get swept up with other conversions
shortly and the aligned_s64 is just a nice to have.



> -	} scan;
> +	} scan = { };
>  
>  	scan.data = mgb4_read_reg(&st->mgbdev->video, 0xA0);
>  	mgb4_write_reg(&st->mgbdev->video, 0xA0, scan.data);
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250722-media-pci-mg4b-fix-uninitialized-iio-scan-data-2dce1574d1e9
> 
> Best regards,


