Return-Path: <linux-iio+bounces-1956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3926783EE35
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 17:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6DE1C20F3F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570DD2942D;
	Sat, 27 Jan 2024 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tskV5rc0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A225764
	for <linux-iio@vger.kernel.org>; Sat, 27 Jan 2024 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706371574; cv=none; b=JU62oxlHEeFM4TVDu2VPpZm6LCyqbZfEPk8pT1dRNkiKexulVRquhEX0d5j3hGryWME5OUX24xJJlMeEao5nU9NgNWZXtfwBNI6MWsDKVxfakPvqS0htulGTGfgcU1D0Urkcie0DcXFpn5RKwQxJ+cahQB/o/Y3oD56/Nm47Rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706371574; c=relaxed/simple;
	bh=tDtmMlU2Fw4Q5pW4HnVyIHwbrfUvIbCfiu2WeuH5K9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEuIUiTaHGZeKdbLUr5GnRWo9JeE3njrjswCdGfXpoIQG84lCEFAsq4j5hJRdc68pStlI7CNsgEwJaKQVoWwkzaZpwoszo8zwhu1P6b3icP4htCRitoVpg2OpP6yVvJ1SNcC7rjzBUewyzDpw0aTe0b0W4FMTguLqiyLxXdHSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tskV5rc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F386DC43141;
	Sat, 27 Jan 2024 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706371573;
	bh=tDtmMlU2Fw4Q5pW4HnVyIHwbrfUvIbCfiu2WeuH5K9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tskV5rc03E1Ku3/MjcYZtPr7RE25lZ9NMQg+z1FJQ5QX1nq5JYD/kIlZxYDywj09G
	 oZldn4smrFqQaqKM18Zbig93YEXwNltNdex4QICnGH4uumGtp/zrnoz88E7mpj29Ni
	 fW9ynzwPw2JZOr1SVw+AXZ8pb/hFXrrrJnTWO+HQ7ZAC0uBui1WCmtNauO6V/kdRfT
	 snzoT/8T4GyWpUJFtDgx2eIgzDcY5FMTKqtlLrP6Am1gPYi/Mk2veQVv3wb5M7jyvq
	 dvKzFGTfVPWVudaTCJx3BT7QtbdWiOo9hM4XBAhdtINlQpJOcmougxQoqWsObtW6mv
	 8Dt6TECwbDziA==
Date: Sat, 27 Jan 2024 16:06:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Schiller <david.schiller@jku.at>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] staging: iio: ad5933: fix type mismatch regression
Message-ID: <20240127160600.3d76e013@jic23-huawei>
In-Reply-To: <20240122134916.2137957-1-david.schiller@jku.at>
References: <20240122134916.2137957-1-david.schiller@jku.at>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 14:49:17 +0100
David Schiller <david.schiller@jku.at> wrote:

> Commit 4c3577db3e4f ("Staging: iio: impedance-analyzer: Fix sparse
> warning") fixed a compiler warning, but introduced a bug that resulted
> in one of the two 16 bit IIO channels always being zero (when both are
> enabled).

> 
> This is because int is 32 bits wide on most architectures and in the
> case of a little-endian machine the two most significant bytes would
> occupy the buffer for the second channel as 'val' is being passed as a
> void pointer to 'iio_push_to_buffers()'.
> 
> Fix by defining 'val' as u16. Tested working on ARM64.
> 
> Fixes: 4c3577db3e4f ("Staging: iio: impedance-analyzer: Fix sparse warning")
> Signed-off-by: David Schiller <david.schiller@jku.at>

Applied to the fixes-togreg branch of iio.git and marked for stable.

Note that if you happen to fancy doing some cleanup of this driver, it should
just be returning them big endian (and describing the channels
as such) which would simplify the code and remove the need for this
temporary buffer.

> ---
> So apparently this has gone unnoticed for over eight years. It appears
> that I'm one of only a handful of Linux people with access to AD5933:
> https://lore.kernel.org/linux-iio/20230606113013.00000530@Huawei.com/

I would love us to have emulation in place for devices like this but
even if say roadtest lands upstream, it will be a while before we
have enough tests in place to pick up this sort of error in a little used
(as you've discovered) driver.

Thanks,

Jonathan



> 
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 793918e1c45f..b682d0f94b0b 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -608,7 +608,7 @@ static void ad5933_work(struct work_struct *work)
>  		struct ad5933_state, work.work);
>  	struct iio_dev *indio_dev = i2c_get_clientdata(st->client);
>  	__be16 buf[2];
> -	int val[2];
> +	u16 val[2];
>  	unsigned char status;
>  	int ret;
>  


