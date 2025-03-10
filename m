Return-Path: <linux-iio+bounces-16698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE0AA5A46D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F2516F902
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A701DE2AD;
	Mon, 10 Mar 2025 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP+Xdh33"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725FA2AE66;
	Mon, 10 Mar 2025 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637450; cv=none; b=E4O/ES3Cy/CqB/YH92BhT2DttXjbQyYMKBQBKS64SWBiFOyT15zaxiTpjFDW7yNZA3WF24Dj/pBoVWKUltuHpsjGDzUwVL3/c2m+0ZuDBsngad7eAmajRZ9g16rwVGrU1jFA/TlVbQ+Uvo1rKYiYoepxBEylsm4x11ZihnygNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637450; c=relaxed/simple;
	bh=YCidwkOf/4nqRNk0rsw+7UAt6a1E1LiTz9KuaxwUN7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMWHKGWGo7a97WFGMlwZzk+hTnLitPqjaUR27Mmh6XGgaY5CPPE4B9PDEJ9D/UUpsfcyNwP3nBR91QSlfZ47yy+bRof143qmx/uX2ffKKlYnC2+1+OMPLjquofX8ghM5hy93fzeIuKEZ5UR1hBs49vaTqVc/xAnGNGAZMPOB8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP+Xdh33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF16C4CEE5;
	Mon, 10 Mar 2025 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741637449;
	bh=YCidwkOf/4nqRNk0rsw+7UAt6a1E1LiTz9KuaxwUN7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HP+Xdh33WuAuziPpOWZuXXDZDqN1q5WOkUdMRJPyRQxodxPStAVUB9brjIkKR1PNg
	 pYQG9X1caVZtPXQ47LwPPopNUyM7M16rFXwd+Aw3t1JzP2Q6r9OUUuZPFgn5wSbGKA
	 60sY18c0rkn7OIHp0hIseeNOrXIA/AAZheBF95nEFF3UB8zOLLSCrSSXqeSxcChRXt
	 XC1HiB/bwV32m/C9fZaj4Y0Ae8cgpcXN0Z6VumocZ1XQDBiwlvHZ6hM5qxxLF4ZQpb
	 RGEloHiBzFE1cJ86JWBW3c050yC0wXR5BaaNsnbpo3mpIQlutygjHglGjUbItmuIgb
	 Wxr7YezeRDTew==
Date: Mon, 10 Mar 2025 20:10:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 cosmin.tanislav@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 1/1] iio: accel: adxl367: fix setting odr for
 activity time update
Message-ID: <20250310201042.0e8f06d7@jic23-huawei>
In-Reply-To: <20250309193515.2974-1-l.rubusch@gmail.com>
References: <20250309193515.2974-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Mar 2025 19:35:15 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Fix setting the odr value to update activity time based on frequency
> derrived by recent odr, and not by obsolete odr value.
> 
> The [small] bug: When _adxl367_set_odr() is called with a new odr value,
> it first writes the new odr value to the hardware register
> ADXL367_REG_FILTER_CTL.
> Second, it calls _adxl367_set_act_time_ms(), which calls
> adxl367_time_ms_to_samples(). Here st->odr still holds the old odr value.
> This st->odr member is used to derrive a frequency value, which is
> applied to update ADXL367_REG_TIME_ACT. Hence, the idea is to update
> activity time, based on possibilities and power consumption by the
> current ODR rate.
> Finally, when the function calls return, again in _adxl367_set_odr() the
> new ODR is assigned to st->odr.
> 
> The fix: When setting a new ODR value is set to ADXL367_REG_FILTER_CTL,
> also ADXL367_REG_TIME_ACT should probably be updated with a frequency
> based on the recent ODR value and not the old one. Changing the location
> of the assignment to st->odr fixes this.
> 
> Fixes: cbab791c5e2a5 ("iio: accel: add ADXL367 driver")
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
Change log missing, but I assume it's just the Fixes tag.
If so, I would have been fine with that just being in a reply
to the v1. Anyhow, new patch is fine too so applied to the
fixes-togreg branch of iio.git.  I may well queue this up for
the merge window rather than send another pull request this cycle.

Thanks

Jonathan


>  drivers/iio/accel/adxl367.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index add4053e7a02..0c04b2bb7efb 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -601,18 +601,14 @@ static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
>  	if (ret)
>  		return ret;
>  
> +	st->odr = odr;
> +
>  	/* Activity timers depend on ODR */
>  	ret = _adxl367_set_act_time_ms(st, st->act_time_ms);
>  	if (ret)
>  		return ret;
>  
> -	ret = _adxl367_set_inact_time_ms(st, st->inact_time_ms);
> -	if (ret)
> -		return ret;
> -
> -	st->odr = odr;
> -
> -	return 0;
> +	return _adxl367_set_inact_time_ms(st, st->inact_time_ms);
>  }
>  
>  static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)


