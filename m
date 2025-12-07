Return-Path: <linux-iio+bounces-26888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF64CAB6A5
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 125AF300698E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6E9230BF6;
	Sun,  7 Dec 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFT2FQ39"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E826561D;
	Sun,  7 Dec 2025 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765121482; cv=none; b=LfhCyDziGmC6UZtEO52Nve6osQ4y6TNeuUyG8dJODTPi39Wxvq+mVadaFgsjg+4TTCnqr+2QscFp78POyA4LubQ4y+QPj+6FLLXaUtEGR8SlQ0Fb+NjcaFNYO6XIl8flMNS8PPzWgnqSh6CbJldHQwlc0aoVRgGqcx0PdHJ8TAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765121482; c=relaxed/simple;
	bh=YP6CESObNB5r6yVFIdYwMFXtwmTCICGItV9Xenj7tJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnO9iHPAwd1inT5F2qxqwU+PYF8WPYvnbdfmuC19AJ27aSw60CSqmctKGpPMGy5th29y6NwPgbF3NyDRHbBK5F44CwqECyHjxHzPspdlgBey6XTu+1fyTUN37V3RLhg2sBNTaGOn6h0aZsR/prUvOi81Q2gv9XPbATzQPuxB+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFT2FQ39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713BCC4CEFB;
	Sun,  7 Dec 2025 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765121481;
	bh=YP6CESObNB5r6yVFIdYwMFXtwmTCICGItV9Xenj7tJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pFT2FQ39+MwZZTeaTozdwrH6EgVLPRIyfmiik6VaK/6UiSekhZ+EOzNbwy04ufMOE
	 FF/Fc02TC4Z2Dr7bNo/+9KWbtLYf3yM1gUJcHnbtvY4WNnJs3Ge/QpLYPzjG8GEl37
	 U7aRxWeWLPlaivTTxru7RLnBig6b73jY5Pu8Jyo8LI/uJ6KeTs50tUp6SZcb4Tgrox
	 5QKoQ0g0AAs4qVk6b+rdxoXGQNYMfVkqSfRYo/GWAA4Ka7hCViRNXsc61THQCp8Rla
	 8nNj//CEjDNwq+EpcOqhKc3At/OuU+aEmxtEVVQFr1w68tVO8gRHA/s7XQDYeap0tE
	 owmGGJ7/Wl0/A==
Date: Sun, 7 Dec 2025 15:31:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 5/9] iio: imu: st_lsm6dsx: remove event_threshold
 field from hw struct
Message-ID: <20251207153113.20c97fa9@jic23-huawei>
In-Reply-To: <20251201100018.426749-6-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
	<20251201100018.426749-6-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 11:00:14 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> This field is used to store the wakeup event detection threshold value.
> When adding support for more event types, some of which may have different
> threshold values for different axes, storing all threshold values for all
> event sources would be cumbersome. Thus, remove this field altogether, and
> read the currently configured value from the sensor when requested by
> userspace.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 +--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 4200e5231950..b27a833d5107 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -79,6 +79,7 @@ enum st_lsm6dsx_hw_id {
>  #define ST_LSM6DSX_MAX_TAGGED_WORD_LEN	((32 / ST_LSM6DSX_TAGGED_SAMPLE_SIZE) \
>  					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
>  #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
> +#define st_lsm6dsx_field_get(mask, reg)	((reg & mask) >> __ffs(mask))

I'm not going to fuss too much about this as expectation is that
this will be replaced soon anyway with a generic version but convention
would be to (reg) & (mask) to avoid precedence of operator problems if
there are any in the parameters passed.  The generic version will I guess also deal
with avoiding multiple evaluation of mask.

Anyhow, doesn't matter here given the simple user.

Applied.

Jonathan

