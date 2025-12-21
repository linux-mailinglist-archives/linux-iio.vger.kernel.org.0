Return-Path: <linux-iio+bounces-27286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CC4CD4402
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A52183007263
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E82622A4F6;
	Sun, 21 Dec 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5xegl/h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F807FBA2;
	Sun, 21 Dec 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766342316; cv=none; b=NLfI/XGorXEvLun280HYPV2iR0DfbF22932lUM+OlWwyq+BktuhuS/QksoMGozkDT4jLZwI+SDtPQcYp6fD0jlXRd+NvzV0c974gzaX9Tbm0mW9oRpn8wEg/s3PvpYY/8DxJHfpNW+J0K1rxcN8eczLzC0NzwA31xZbc990wycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766342316; c=relaxed/simple;
	bh=Th3NJJR5FkK4GrvgG839c+aHNT7nt7QUbMU4WC4wQ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyQs4PVojjxHdGnjfalcfTzL5p3HS4Ur3Ia7y9LL0SI4AZmrPEW6bEXukVc66P86bCzVMQ5SoTw/uYlil/FD8TDtdQLTut3xIJwnV9N/SMW8Xfv7pP5NaZwkfMODHzejJvTQ2PN5zsjtA4Qn3PZ7dRexn9cEvwyl61DF7+hzhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5xegl/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB1AC4CEFB;
	Sun, 21 Dec 2025 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766342315;
	bh=Th3NJJR5FkK4GrvgG839c+aHNT7nt7QUbMU4WC4wQ/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K5xegl/h//R5+nOhWt2eFdHEfs2IWyqeIwLBtu4DARSRiA6lfebOnp5y4s3No2jjY
	 9pxzqbSGBb2awu5wwSeQa9lq1cHyfc69LFkdZguxXXAT8sI2Eair9QC7FPEam7y/Eb
	 6CDQ3zH6e4Ba2h5r9KsFBb+/vlftev3k8P7ofWPCHHs/geri/e9ePz7636VwXOr6lW
	 C0Pm2xtg+LKfYeeg6HhMZOL5lIvdFmNhn9nTDNqWCM8zYohEHhFRi8DHnVCEOXK3lJ
	 ClR7SzFI3f54NLA47TwNw6yQ9Ui8iUYa1QrkeZ3q0V7MlqhHPTrZqmakdlJvPRSqiZ
	 pYvWnR3kDhh0Q==
Date: Sun, 21 Dec 2025 18:38:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andreas Klinger
 <ak@it-klinger.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 12/14] iio: pressure: mprls0025pa: fix interrupt flag
Message-ID: <20251221183826.3050247c@jic23-huawei>
In-Reply-To: <20251218-mprls_cleanup-v1-12-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
	<20251218-mprls_cleanup-v1-12-b36a170f1a5c@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Dec 2025 13:05:54 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Interrupt falling/rising flags should only be defined in the device tree.
> 
> Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Gah. We shoudn't have let this slip through in 2023.
Some old drivers have done this for many years and for those we definitely
can't be sure there aren't boards with it set wrong in DT that will see
a regression with this fix.

For a 2023 driver, maybe we can gamble that no one has broken DT (where this
would annoyingly be a regression).  One other question below.


> ---
>  drivers/iio/pressure/mprls0025pa.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> index 243a5717b88f..fc04988b9437 100644
> --- a/drivers/iio/pressure/mprls0025pa.c
> +++ b/drivers/iio/pressure/mprls0025pa.c
> @@ -14,6 +14,7 @@
>  #include <linux/bits.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
> +#include <linux/interrupt.h>
>  #include <linux/math64.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> @@ -404,9 +405,7 @@ int mpr_common_probe(struct device *dev, const struct mpr_ops *ops, int irq)
>  
>  	if (data->irq > 0) {
>  		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> -				       IRQF_TRIGGER_RISING,
> -				       dev_name(dev),
> -				       data);
> +				       IRQF_ONESHOT, dev_name(dev), data);
IRQF_ONESHOT addition here needs a separate explanation. Might well be correct
but it's not related to your patch description.

>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  					  "request irq %d failed\n", data->irq);
> 


