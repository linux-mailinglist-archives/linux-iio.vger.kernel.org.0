Return-Path: <linux-iio+bounces-12088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA469C2E19
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703B11F21B8A
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465E61990B7;
	Sat,  9 Nov 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHL6qMb6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258B233D6B;
	Sat,  9 Nov 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165411; cv=none; b=X3jvzbaPdcAfhq6OtrTVRtHY5xiYMSLD9qa0vvthGGLC+LjAfWNz6jm4uEvktXSCExyf4NbKEzKutgZSJBsbgNjXC4UR+S+xcamqt+yc8+cp50g1AKGusg4aVpCknmjL1BzjgBZCBLDrLql9cP5aUK1RKYck2Py31JglwZm+NdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165411; c=relaxed/simple;
	bh=EXT/Hr8H1uClY9YwJej/y3rLcg3RbWDHKELZLF8UgOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhwZXhqxZpnwFx36O1+Gf2bTxi9ool6yBlOYk8OAHw6TC7F1xmRAW7xcnB0Sc/LLRei0oeiJzqWIFBeKgQsp6kEQr2DVi3vFLVqf0Pxg0G5KUvVE5/PZBzjInjCoayVCt6gNTYO8ec4HLk2LlQJfeEyhryB2X8S2QLZMUqIncCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHL6qMb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91579C4CECE;
	Sat,  9 Nov 2024 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731165410;
	bh=EXT/Hr8H1uClY9YwJej/y3rLcg3RbWDHKELZLF8UgOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GHL6qMb6x/Zv/rsd1Mc9Qlf7oUfHAw6CgzKoTidJIN+CkK79u4o1kBiCGUlEJd+SA
	 NDfeJGfYyc51sTNcN4WvH+qs9X9z7mwskzCYniW5Nfrxcf4XbA9YgxgJ5i0Z6N0grr
	 c6XaRF2HLubJxRhoMYiUjfIu2buWOVGhFdPyYnf0DQAf9ghaei8fMZW7pRvQhaveGF
	 N8axeuMFwA3UFhVo/uWbujkGQKWzdKdcGAC5mNeiw9j21lm570+MTkL060ct0gRpDn
	 4MIoqi6/mpLTpf3XYd2674VZ+y0oiELVU2qQeTWdY5JFQT2EBg0D9h3oN6DwU6yyrV
	 XmZXsFsW6WbEA==
Date: Sat, 9 Nov 2024 15:16:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: lsm6dsx: Use i3cdev_to_dev to get device
 pointer
Message-ID: <20241109151643.4e4608bf@jic23-huawei>
In-Reply-To: <20241109145430.3702482-1-linux@roeck-us.net>
References: <20241109145430.3702482-1-linux@roeck-us.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 Nov 2024 06:54:30 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> I3C client drivers should not include linux/i3c/master.h. Use
> i3cdev_to_dev() to get the device pointer from struct i3c_device
> to be able to avoid that include.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Applied to the testing branch of iio.git. I'll be rebasing that
on 6.13-rc1 once available and then push out as togreg for linux-next
to pick up.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> index 3b0c8b19c448..207dcc0ad988 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> @@ -9,7 +9,6 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/i3c/device.h>
> -#include <linux/i3c/master.h>
>  #include <linux/slab.h>
>  #include <linux/regmap.h>
>  
> @@ -30,15 +29,16 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
>  	};
>  	const struct i3c_device_id *id = i3c_device_match_id(i3cdev,
>  							    st_lsm6dsx_i3c_ids);
> +	struct device *dev = i3cdev_to_dev(i3cdev);
>  	struct regmap *regmap;
>  
>  	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&i3cdev->dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
> +		dev_err(dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return st_lsm6dsx_probe(&i3cdev->dev, 0, (uintptr_t)id->data, regmap);
> +	return st_lsm6dsx_probe(dev, 0, (uintptr_t)id->data, regmap);
>  }
>  
>  static struct i3c_driver st_lsm6dsx_driver = {


