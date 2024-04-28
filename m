Return-Path: <linux-iio+bounces-4566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAB78B4B94
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0205F1C20A70
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 11:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE985813E;
	Sun, 28 Apr 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxzKWmcg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1215D480
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714305101; cv=none; b=AVLJ+qPRsBeRtUYlKnp7GDUsRUNO4zBtifjtgzVZrSlBbZTusUkbXH2C9hqJicTGTbE6Dv1zVkt/r8hVnc+6C8GgCzVCdZOuCuy9K2bXxTGkRtX2JS8M/UclCQJeEYbeS3FrU556a/U6w/xGXNnWl84ygVwd/C5oXpH2qMjvDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714305101; c=relaxed/simple;
	bh=vTf4D8s/+l7+SD8D+yawn+fJtfLcj6HVzhoH2nbIN4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5z7m0PtMLIm47M+mSXpM1ORxtjyEvDS4+cUCAjmuzBEnnoCp+bd0aFadt8RsAt5kr8qHn0TZmUFGlgU1eFomi+JddNgTyM8uFpFZHxQ1hdYFiyHVbqU8JvAR82nYI36LG//+wHR/mG5ogCEwebek0D/GURbNYsgFveGm4+HxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxzKWmcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8233EC2BBFC;
	Sun, 28 Apr 2024 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714305101;
	bh=vTf4D8s/+l7+SD8D+yawn+fJtfLcj6HVzhoH2nbIN4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DxzKWmcgDoc9VicxJp0Ea9FbT5I3P3T6FoIa8Ffr1R3+/WYJ/xRriI5MnaSzilBB6
	 YVkmOuLMTC/3RVspTdPMVF57rxitQ2THEj51bdhFRQ63rlpyrlEyWfaMYEKbNH1gJI
	 xqmoMeiQXOG6lRNevHUtnmp0xKaKT4Ktc4QLpEekrsmY2rrT9aWrjp+7+w5IkXgPtf
	 cZze/5IlNqREsCpeAcx4gFvnz2VwnCwXkEpoKUgKPdWtW/kPPqhi3Hn74XXUB+ZfIo
	 v133P5NS9Z2+T1bTC3WOLZ9UPe2q9w0/FBMYB2KFo1gHjbN8Ynjt2p4AnMpfQbS6UL
	 hjjEhIw2d3b1w==
Date: Sun, 28 Apr 2024 12:51:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Schwartz <gschwartz@usp.br>
Cc: linux-iio@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH] iio: adc: rtq6056: Use automated cleanup for mode
 handling in write_raw
Message-ID: <20240428125129.1605a09d@jic23-huawei>
In-Reply-To: <20240426200118.20900-1-gschwartz@usp.br>
References: <20240426200118.20900-1-gschwartz@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 17:01:14 -0300
Gabriel Schwartz <gschwartz@usp.br> wrote:

> Using iio_device_claim_direct_scoped() to automate mode claim and release
> simplifies code flow and allows for straight-forward error handling with
> direct returns on errors.
> 
> Signed-off-by: Gabriel Schwartz <gschwartz@usp.br>
+CC driver author.  This is a fairly recent driver, so like they are still
around.

Patch looks good so I'll apply it but if ChiYuan Huang gives a review that would
be great.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/rtq6056.c | 34 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
> index a5464737e..bcb129840 100644
> --- a/drivers/iio/adc/rtq6056.c
> +++ b/drivers/iio/adc/rtq6056.c
> @@ -520,32 +520,20 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct rtq6056_priv *priv = iio_priv(indio_dev);
>  	const struct richtek_dev_data *devdata = priv->devdata;
> -	int ret;
>  
> -	ret = iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (devdata->fixed_samp_freq) {
> -			ret = -EINVAL;
> -			break;
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		switch (mask) {
> +		case IIO_CHAN_INFO_SAMP_FREQ:
> +			if (devdata->fixed_samp_freq)
> +				return -EINVAL;
> +			return rtq6056_adc_set_samp_freq(priv, chan, val);
> +		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +			return devdata->set_average(priv, val);
> +		default:
> +			return -EINVAL;
>  		}
> -
> -		ret = rtq6056_adc_set_samp_freq(priv, chan, val);
> -		break;
> -	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		ret = devdata->set_average(priv, val);
> -		break;
> -	default:
> -		ret = -EINVAL;
> -		break;
>  	}
> -
> -	iio_device_release_direct_mode(indio_dev);
> -
> -	return ret;
> +	unreachable();
>  }
>  
>  static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] = {


