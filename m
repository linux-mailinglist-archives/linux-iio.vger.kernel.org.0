Return-Path: <linux-iio+bounces-11527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5A89B3C47
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD8B1C21DB4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0AD1E00A0;
	Mon, 28 Oct 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQNtG1Id"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394AC185B54;
	Mon, 28 Oct 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148625; cv=none; b=iHGlOnG4sjkZ1cI4bhOjov7S3zSaM+cSiAhaFDmpCDbCfHdkNMEFDyvWw7ikZgbqC7kxkxCK2IJVeTTY1ljVF1TOTASCStDDDMJDb6LoyEJyEarKCljcZBAGB1auihPXzxXdg1zMUsnYDcQAE1IIYf7s+36XgOOBJi+GPRCdsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148625; c=relaxed/simple;
	bh=0d0bnpYrqLf1Gz1ewdv5lG608wrvqcCrLqPXxCzJmXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szACvLk3+/AoKLG5UGgPqvmPniAwEL4QWV32ncPu8S3EagDnU+e6v4t0DG4zx6xTdwm43CpfIKT64ObNBA8IxFa+Ev04KE3RefXRwdMj56pAARdIxLKjoHNJWpW4gmUBcpY5s916iDR3nyYBbasJLlD6lRyOmj8xp2Tq33Rj6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQNtG1Id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FBBC4CEC3;
	Mon, 28 Oct 2024 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730148624;
	bh=0d0bnpYrqLf1Gz1ewdv5lG608wrvqcCrLqPXxCzJmXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQNtG1Id/5lshA4iIa6GkvJGi8b+JhEqwJXetiYWHNCHmpolrKcEdb5Z1hnXnORBR
	 ZTM+kRnVU8IU0TdVKusjcYCKsXiC9HKN/axX9MJfbs8iXSNh7lX2KdTzV9PrVaxaI7
	 EXM6dNb5MvDvC+YWDdIm1SkPfIHDX2sCRQpMRlJwgd2m7yVEbulN70c3sRqP/ci4XE
	 catd2M7zLzqczRsDyogeKSWTkPljXDlOOTCEaXT4UNg0+cXCKNnI+nINJYmecTIze2
	 dFxdpzU7edfLAk1f2cexiLqGeNmvE17LMElah2HmtnIlvCtTKFTyyck/Hal/Zh1nT2
	 rB/dAnwG2XoAA==
Date: Mon, 28 Oct 2024 20:50:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <patrick.vasseur@c-s.fr>, <christophe.leroy@c-s.fr>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
 <judy.chenhui@huawei.com>, Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH] ad7923: fix array out of bounds in
 ad7923_update_scan_mode()
Message-ID: <20241028205004.2298af74@jic23-huawei>
In-Reply-To: <20241028142357.1032380-1-quzicheng@huawei.com>
References: <20241028142357.1032380-1-quzicheng@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 14:23:57 +0000
Zicheng Qu <quzicheng@huawei.com> wrote:

> In the ad7923_update_scan_mode() , the variable len may exceed the length
> of the st->tx_buf array, leading to an array overflow issue. The final
> value of len depends on active_scan_mask (an unsigned long) and
> num_channels-1 (an integer), with an upper limit of num_channels-1. In
> the ad7923_probe() function, when assigning to indio_dev->num_channels,
> its  size is not checked. Therefore, in ad7923_update_scan_mode(), since
> active_scan_mask is an unsigned long and num_channels has no set upper
> limit, an overflow might occur.
> 
> Fixes: 0eac259db28f ("IIO ADC support for AD7923")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Thanks.
This looks to be a valid bug but a wrong fix. Fairly sure the number of channels
supported has changed at somepoint (probably with addition of more parts)
and the size of tx has not increased to match.

Nuno, could you take a look?

Jonathan


> ---
>  drivers/iio/adc/ad7923.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 09680015a7ab..82b341709a64 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -170,6 +170,8 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
>  	 * skip that one.
>  	 */
>  	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels - 1) {
> +		if (len >= 4)
> +			return -EINVAL;
>  		cmd = AD7923_WRITE_CR | AD7923_CHANNEL_WRITE(i) |
>  			AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
>  			st->settings;


