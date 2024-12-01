Return-Path: <linux-iio+bounces-12916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876D29DF5A1
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C852280EB4
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFA91C57B1;
	Sun,  1 Dec 2024 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCsgRWSo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB618A932;
	Sun,  1 Dec 2024 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057895; cv=none; b=ZDEBYLrL2cs7+Ipql5WQb7qtrXE5BATKAQhrwfEM7ffFNWsUzjVYVY2hgdwtc7JRX//2qcQdXhZA8O4tLaGkuB3sMb4LTVzFCw2hqa73dvh4sAio1pm9kglZXXB1rjZqXUu0EVIzK8SAL+1Be7L16Bvn5V4gWZCO23+FXNXM7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057895; c=relaxed/simple;
	bh=mFTkYjF9lZCa/vu703tNRRGVkcI+D0SERlF9fk5559E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQV0x7NMpryLAnvm3DGT9YI2Hvl9R7yXkOlcBDTqoWtnN000tSxZk3xcuJH1GIgANeY6HOz7bMadlwlF4u3eZ6jAwXM5LM6+pqgWX44MxsXxZV9UwxufDV5+8mYWtmNfqccvotkztmgWqw2v3WVENMHaTzb2ze6DHUtsgycJP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCsgRWSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCFFC4CECF;
	Sun,  1 Dec 2024 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733057895;
	bh=mFTkYjF9lZCa/vu703tNRRGVkcI+D0SERlF9fk5559E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aCsgRWSoOGNK3PxMRpqs/JTbysuInYwCW4wtV2NLTaXyCRO1J7DIBhRpWjGgXMu3s
	 5nxKisIptPNeXJ5uENYCR018w1yhuIFe31Yy5CF23nQI10FoAQN13aKQ67xm4hMcUj
	 HDO3yTMfMZLhyvu9MnZk5dZdzszaIv9KTmobXiChWoc5lE78F7TTaN4nGwijdvbEJu
	 XhdAhPB+CcYyrLAF97lLI1324gjOHWf7x60S5DGb6RbnaZ/GYxLakOcwn9wb/te5Ud
	 Yl53A12RCuO9lD+BD9z45RTI3H3AWoI6TMSb5HmvTFxw+dr3WOsDerQGc5CoOCztSx
	 f/wIGf+HM+N+g==
Date: Sun, 1 Dec 2024 12:58:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kuldeep Pisda <pisdak79@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: palmas: Fix typo in threshold calculation
 comment
Message-ID: <20241201125807.2b3ea19a@jic23-huawei>
In-Reply-To: <20241123112757.63928-1-pisdak79@gmail.com>
References: <20241123112757.63928-1-pisdak79@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Nov 2024 11:27:57 +0000
Kuldeep Pisda <pisdak79@gmail.com> wrote:

> Fix a typo in the GPADC threshold calculation documentation where
> "paramenters" was incorrectly written instead of "parameters".
> 
> Signed-off-by: Kuldeep Pisda <pisdak79@gmail.com>
Hi. I already have a patch queued that fixes this up.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/palmas_gpadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 203cbbc70719..67d567ee21b4 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -456,7 +456,7 @@ static int palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
>   *   raw high threshold = (ideal threshold + INL) * gain error + offset error
>   *
>   * The gain error include both gain error, as specified in the datasheet, and
> - * the gain error drift. These paramenters vary depending on device and whether
> + * the gain error drift. These parameters vary depending on device and whether
>   * the channel is calibrated (trimmed) or not.
>   */
>  static int palmas_gpadc_threshold_with_tolerance(int val, const int INL,


