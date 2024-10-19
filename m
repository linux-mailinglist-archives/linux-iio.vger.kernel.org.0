Return-Path: <linux-iio+bounces-10766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C339A4D14
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0925D1C21268
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632381DFD81;
	Sat, 19 Oct 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6/3tdCD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499B190688;
	Sat, 19 Oct 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336901; cv=none; b=bC/cBPhxsebf1UYVLD/dI9eEawlq3uTLhal1Ukg63rUVVDyJmCdSAP/c4KS7unD2HOG8OuWShbtdT4mb8VqI30JLVgBkJR3LzancGIjFGPi4EljIAe7H3TacdOiQJAQp7EjluXLZXlUsKImFXTT8vXKZamkJigcm3dNqRgODjZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336901; c=relaxed/simple;
	bh=SCOetsuGhfRBZ8vqKCa3ek94gu4iy9K9KCUmNwI3Mp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZME7NvGd6p8pzN3dTOK6457Rd7wCzUlJzD1cxAolOamvkow1ZaR69ZpmfY8NnmMlf/jF1dMiYfciPZG3LMZFSvneQJuTMR/wKvz/NbWxtjJvLqJEwQ3mzH5ANCOQtw2KwJVit8Zql1pcw5Wa5GMflX9c8zyLTkVtACzeo0wVX4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6/3tdCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AF5C4CEC5;
	Sat, 19 Oct 2024 11:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729336900;
	bh=SCOetsuGhfRBZ8vqKCa3ek94gu4iy9K9KCUmNwI3Mp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S6/3tdCDllu2W5eRL/wtq0TZnYHw1FbFTL/gbyLzS1DYABjzuArbWE46AWJxUlWJO
	 /w4QP20oHlSXkmCmrbWYf1W71nKAebJsso4zRFMIdPTiFudzPtSQOF+IxlTyoCqCbV
	 4LrheCa57/Dr+0q2i0IcuZYOpnsVU2DRa5Q+CGfCp9PzI3vPkBlgOKJ49e3lvMrvY8
	 EmekIKCleMqBrTNpPzP78QVqmxMj0aS+tHjneN26XF3txgnWeyQdQtUsKXLAJhXbEg
	 6wC1DEqmy6Yh2SWu6hZHifxgdO4hQNbcLr4eo1d/Kazgbt4EnSGqnBG2ZEmV2eIu/Z
	 kf2lNxyE6iusg==
Date: Sat, 19 Oct 2024 12:21:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, Karan Sanghavi
 <karansanghavi98@gmail.com>
Subject: Re: [PATCH] iio: chemical: sps30: Add Null pointer check
Message-ID: <20241019122133.13d59dfb@jic23-huawei>
In-Reply-To: <20241018-cid1593398badshift-v1-1-11550a10ff25@gmail.com>
References: <20241018-cid1593398badshift-v1-1-11550a10ff25@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 18:54:42 +0000
Karan Sanghavi <karansanghvi98@gmail.com> wrote:

> Add a Null pointer check before assigning and incrementing
> the null pointer
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

It would be a bug if rsp_size was anything other than 0 and rsp is NULL.
So this looks like a false positive as the loop will never be
entered.

How did you find it, in particular have you managed to trigger this
in the driver?

Jonathan


> ---
>  drivers/iio/chemical/sps30_i2c.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
> index 1b21b6bcd0e7..d2142e4c748c 100644
> --- a/drivers/iio/chemical/sps30_i2c.c
> +++ b/drivers/iio/chemical/sps30_i2c.c
> @@ -105,16 +105,18 @@ static int sps30_i2c_command(struct sps30_state *state, u16 cmd, void *arg, size
>  		return ret;
>  
>  	/* validate received data and strip off crc bytes */
> -	tmp = rsp;
> -	for (i = 0; i < rsp_size; i += 3) {
> -		crc = crc8(sps30_i2c_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
> -		if (crc != buf[i + 2]) {
> -			dev_err(state->dev, "data integrity check failed\n");
> -			return -EIO;
> +	if (rsp) {
> +		tmp = rsp;
> +		for (i = 0; i < rsp_size; i += 3) {
> +			crc = crc8(sps30_i2c_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
> +			if (crc != buf[i + 2]) {
> +				dev_err(state->dev, "data integrity check failed\n");
> +				return -EIO;
> +			}
> +
> +			*tmp++ = buf[i];
> +			*tmp++ = buf[i + 1];
>  		}
> -
> -		*tmp++ = buf[i];
> -		*tmp++ = buf[i + 1];
>  	}
>  
>  	return 0;
> 
> ---
> base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
> change-id: 20241018-cid1593398badshift-9c512a3b92d9
> 
> Best regards,


