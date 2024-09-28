Return-Path: <linux-iio+bounces-9811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42457988F99
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AD51F216C3
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00418872C;
	Sat, 28 Sep 2024 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcwM8TAd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A9D1885B7;
	Sat, 28 Sep 2024 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727533413; cv=none; b=V8eVSlLEa/H1c2PRPOkyEM5sO6eQ7/IVWaARyxibUoYg2XdIrSZQQRawR8MYn/klu34+iOjxSn3S3YSjdXu2wmOMWohBPsWPy+iefH4qBMyFm7kQ2vTVUbpRVSvW9FYU8T4GyRZ2txHnW2rB8378GxcwiISiCGfSJkkzzYuMKhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727533413; c=relaxed/simple;
	bh=vETVdzpFTgtzgearedU8ZcNNOdx77yL2ot4guI4zHgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1cSG/MDfKY+eIsALlSzjHMmYiFoK2z7h/sN513fozxmycTyb77LFgjZRMtB1+kVk286Qd5d/kpwuuc8mD1pQ0WOk2SqHzRyPbPu2USPRcUm14msIjXjKJ9ADXHHh940b/lDtdJ6ANZ9iCQh6Gxvd09HaGnlju+6kWqhRQV4eq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcwM8TAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77067C4CEC3;
	Sat, 28 Sep 2024 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727533412;
	bh=vETVdzpFTgtzgearedU8ZcNNOdx77yL2ot4guI4zHgo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kcwM8TAd7gxkWE0rbC4u45mh93b1kQHSDfAR9PehOdW9rK43xsB6mv9T2Xs084TKW
	 iUThp/4Vxsu3A1QQ5FtcFp+59Wj/ZyQSM7Pi/snGvcx5sgfGvSEkv3iejSytTN+HnK
	 Ubn5iDOz2ClBxkbZMy+ZK5mtksyrbqaHWajHvMnU5UFYGUT3ygU5/zkWHH1rRRjutE
	 pdsNU+XtTkb/760DGR6xb14UxtzazwZMmcBxNQ5Nusd5mk9WMFwlEIAHcqsl1/Lu6l
	 XTx6FBlIvy+YG9PPdV8Zsj+35qCx/dhipRRmPv8f9eAwTs5N/qFKi6HS8Hsv8WBl+y
	 G+QRNimE396ZQ==
Date: Sat, 28 Sep 2024 15:23:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Jagath Jog J <jagathjog1996@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Denis Benato <benato.denis96@gmail.com>,
 linux-iio@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] iio: bmi323: Drop CONFIG_PM guards around runtime
 functions
Message-ID: <20240928152324.5c03fb3e@jic23-huawei>
In-Reply-To: <20240910-iio-bmi323-remove-config_pm-guards-v1-1-0552249207af@kernel.org>
References: <20240910-iio-bmi323-remove-config_pm-guards-v1-1-0552249207af@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 10:22:54 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> When building with clang and CONFIG_PM disabled (such as with s390), it
> warns:
> 
>   drivers/iio/imu/bmi323/bmi323_core.c:121:27: warning: variable 'bmi323_reg_savestate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
>     121 | static const unsigned int bmi323_reg_savestate[] = {
>         |                           ^~~~~~~~~~~~~~~~~~~~
>   drivers/iio/imu/bmi323/bmi323_core.c:133:27: warning: variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
>     133 | static const unsigned int bmi323_ext_reg_savestate[] = {
>         |                           ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> These arrays have no references outside of sizeof(), which will be
> evaluated at compile time. To avoid these warnings, remove the CONFIG_PM
> ifdef guard and use the RUNTIME_PM_OPS macro to ensure these functions
> always appear used to the compiler, which allows the references to the
> arrays to be visible as well. This results in no difference in runtime
> behavior because bmi323_core_pm_ops is only used when CONFIG_PM is set
> with the pm_ptr() macro.
> 
> Fixes: b09999ee1e86 ("iio: bmi323: suspend and resume triggering on relevant pm operations")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Applied to the fixes togreg branch of iio.git.
I'll rebase that tree on rc1 once available then send a pull request with this
in.

Thanks,

Jonathan

> ---
> NOTE: The second warning will still be visible without this change as
> well:
> 
> https://lore.kernel.org/20240909-iio-bmi323-fix-array-ref-v1-1-51c220f22229@kernel.org/
> 
> Technically, the blamed change for that fix is somewhat responsible for
> this issue as well but I believe the one I assigned was the real culprit
> because this diff should have been in that change.
> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index 671401ce80dcf947b7b64ea3af112d2a42ca5501..1d1405d37c5adb2717fc27d6b22540da50dea6d4 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -2172,7 +2172,6 @@ int bmi323_core_probe(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(bmi323_core_probe, IIO_BMI323);
>  
> -#if defined(CONFIG_PM)
>  static int bmi323_core_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> @@ -2293,11 +2292,9 @@ static int bmi323_core_runtime_resume(struct device *dev)
>  	return iio_device_resume_triggering(indio_dev);
>  }
>  
> -#endif
> -
>  const struct dev_pm_ops bmi323_core_pm_ops = {
> -	SET_RUNTIME_PM_OPS(bmi323_core_runtime_suspend,
> -			   bmi323_core_runtime_resume, NULL)
> +	RUNTIME_PM_OPS(bmi323_core_runtime_suspend,
> +		       bmi323_core_runtime_resume, NULL)
>  };
>  EXPORT_SYMBOL_NS_GPL(bmi323_core_pm_ops, IIO_BMI323);
>  
> 
> ---
> base-commit: 5ba0cb92584ba5e107c97001e09013c1da0772a8
> change-id: 20240910-iio-bmi323-remove-config_pm-guards-5707958e0ac1
> 
> Best regards,


