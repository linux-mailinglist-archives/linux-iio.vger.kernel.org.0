Return-Path: <linux-iio+bounces-7055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37B91CE9A
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 20:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297CB1C20825
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1507813213C;
	Sat, 29 Jun 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe4S1yqT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD855660
	for <linux-iio@vger.kernel.org>; Sat, 29 Jun 2024 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719686662; cv=none; b=udzbbr8D77EgopVRSiikcYk+/J5oqSXp1p9mQ20ofQZijB12JOFR5KIbnok7bbiCVIZ/tWh7EE3zxKDbkpIaJBXXK8WyveW2d/88Qjpu28MG/mEcUjvRjA4xmXWdAupr2agyEQwBjjRfKFLpWJw2fO96wSBnLsx38Ziwk/cDWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719686662; c=relaxed/simple;
	bh=sy2L1O9DsdS/vQPtVILarD8O6DY1O03ipM0/Wq1g9ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzgRqJcvVYtfJyzy1hGmcD6k0C8G/Sa4wFwvGzswXBqo2e5cMp5BUSiJ1Gr+daA2W1bndFdG6dc0xVU1TsGjXWH/XIG81XLFxCF0t/2Uj8Hu+MXjqffSOQYG3Z4SHhq4eLNyh2g0NH/YZOHFxpLp4azWAZu9HUDKDrop76lEE80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe4S1yqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDCEC2BBFC;
	Sat, 29 Jun 2024 18:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719686662;
	bh=sy2L1O9DsdS/vQPtVILarD8O6DY1O03ipM0/Wq1g9ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qe4S1yqTlmbVBzs0rF30vYsi5Guw7uBCWdMBcl/JM7KgISnFLf9+q4Yijk8MvH8ey
	 2Pkl4SKzDBZ9YjdgjDP8LD1JciIRf1fIn/EnRVqIc2b8YO9aZnIECC8SmKAMQesRIp
	 a3dim5zQXO0xJDNBvFodB4bR/YjxbGoxjq/9+FwHZXhmv4vrE30g+LWXJx69T5uwSE
	 cHoGW0UA5TbqpccKjSIBcK9zud2nhK9Th5M3RZokEh+G3RrCcQtVIUMUgFRcsh6a7c
	 b73xODCUxs5W1g4D/1+kJDmn2ATS9ev0CyTzYx9cB5UVmA++B/gDs+zWIcGX32rr0D
	 ftCyeU2IJUwQQ==
Date: Sat, 29 Jun 2024 19:44:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH] iio: st_sensors: relax WhoAmI check in
 st_sensors_verify_id()
Message-ID: <20240629194416.535953ff@jic23-huawei>
In-Reply-To: <20240625082800.62305-1-kauschluss@disroot.org>
References: <20240625082800.62305-1-kauschluss@disroot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 13:57:55 +0530
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> Hard matching against the WhoAmI values isn't ideal for using devices
> which are compatible with existing ones. Instead of raising an error,
> issue a warning instead, thus allowing the driver to continue probing.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
LGTM.  I've +CC'd a few more people who might take a look.

In meantime I'll queue it up.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a look and see what we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index c77d7bdcc121..c69399ac6657 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -606,10 +606,9 @@ int st_sensors_verify_id(struct iio_dev *indio_dev)
>  		}
>  
>  		if (sdata->sensor_settings->wai != wai) {
> -			dev_err(&indio_dev->dev,
> +			dev_warn(&indio_dev->dev,
>  				"%s: WhoAmI mismatch (0x%x).\n",
>  				indio_dev->name, wai);
> -			return -EINVAL;
>  		}
>  	}
>  


