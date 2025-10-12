Return-Path: <linux-iio+bounces-25012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE5BD0ACF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 21:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F873AF6CD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808771EFF8D;
	Sun, 12 Oct 2025 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXdWD8Ep"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967D3B186;
	Sun, 12 Oct 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760296615; cv=none; b=Ty0iwXty0MtmXfyxRMjDuCHhzSvAQv0gjbq18+2qYlGJJDy3BZ9+nHCIFS47onmQmYhRV++vAIEClQfvVLpygpOW4xut8aEvHsmO20NsuFebfT3gDToz8uJsdMJCnF/1RhppnY5q76XJIWh2T1cdsQ4wRhBjOGuJM6dj8Vd+YHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760296615; c=relaxed/simple;
	bh=p4LReXJLkCUF05IVDLOsrblyrtMt9Pdpec76Y3W/9YE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHIVWSG31QzWmlKNhF9lOZaZwqDNX21NECIz3of+ohCiKZpJ8CnP3GPP0SmCzpJDCclyHVzmD29BtJ1E8m0kHDJ0ZT+jiqpvqfOnjw3mmu+P2Cw9mabAbpwzzmpcdb7JJZ6OeTzhfvBDc+TfwDOQbbSxZO+hcnYh5b7lMVIHGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXdWD8Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02061C4CEE7;
	Sun, 12 Oct 2025 19:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760296614;
	bh=p4LReXJLkCUF05IVDLOsrblyrtMt9Pdpec76Y3W/9YE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IXdWD8Ep7U/HmffCnrnBYTbNAJxtjTYJqXLNBsnTXd3vUuiArARiXnogq8ZDq2DF1
	 +c7q76kADP715obStN/BbnhPsXwkkEIMOqASftB2LhNrAVhC3QS/i+qQxKbukhjaoX
	 WUplBe+MFPc6963/FcR0CGVDammdI6pL8ep8GAKlPAUeYT187Oiq6/JWooW+cEEHA6
	 CxyRxhiM1mU1VmmzoD0flmgKRYdgHFvRIYfYdGxk/i18Zvry4dK95Bzuwn3eQZsKx3
	 ueFosN2i2fXAHJ+PndkcElG0Dme86KYOVpI9OMQCMucAQbCbBTjGxpDlYwHtD2P3Bn
	 DniZHl+m8+BTw==
Date: Sun, 12 Oct 2025 20:16:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] iio: adc: ti_am335x_adc: Limit step_avg to valid range
 for gcc complains
Message-ID: <20251012201647.7e7869ad@jic23-huawei>
In-Reply-To: <1208d71f952e3bb85076d229e5fc1b21e2735567.1760166576.git.xiaopei01@kylinos.cn>
References: <1208d71f952e3bb85076d229e5fc1b21e2735567.1760166576.git.xiaopei01@kylinos.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Oct 2025 15:10:51 +0800
Pei Xiao <xiaopei01@kylinos.cn> wrote:

> FIELD_PREP() checks that a value fits into the available bitfield, add a
> check for step_avg to fix gcc complains.
> 
> which gcc complains about:
>   drivers/iio/adc/ti_am335x_adc.c: In function 'tiadc_step_config':
>   include/linux/compiler_types.h:572:38: error: call to
> '__compiletime_assert_491' declared with attribute error: FIELD_PREP: value
> too large for the field include/linux/mfd/ti_am335x_tscadc.h:58:29: note:
> in expansion of macro 'FIELD_PREP'
>     #define STEPCONFIG_AVG(val) FIELD_PREP(GENMASK(4, 2), (val))
>                                 ^~~~~~~~~~
> drivers/iio/adc/ti_am335x_adc.c:127:17: note: in expansion of macro 'STEPCONFIG_AVG'
> 	stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1)

A bit irritating but fair enough that the compiler would have to see a long way to know
that it always fits.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510102117.Jqxrw1vF-lkp@intel.com/
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 99f274adc870..45bdd57bfdc2 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -123,7 +123,7 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  
>  		chan = adc_dev->channel_line[i];
>  
> -		if (adc_dev->step_avg[i])
> +		if (adc_dev->step_avg[i] && adc_dev->step_avg[i] < STEPCONFIG_AVG_16)

why < rather than <=?

STEPCONFIG_AVG_16 is the default.

>  			stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
>  				     STEPCONFIG_FIFO1;
>  		else


