Return-Path: <linux-iio+bounces-10738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9704A9A454C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 19:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5530C288FB8
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94320400A;
	Fri, 18 Oct 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNo2AeDP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA014900E;
	Fri, 18 Oct 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273873; cv=none; b=La7Pp4UXL2LjXXgdlO7BGOSpOK+XOk4oUrri2bSGBmls2yQs5pS7WX7sxOE4cM15zF0QEZmqg0wWCsuVLqscJHDc9y8atD88Fl8ItiX4Qvd1Wvw1S8Eoq2J17n+HiCnLikLEuZo34Ue2noyp7aXqG8cykfWlMC/i9kilRrgbW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273873; c=relaxed/simple;
	bh=0YBB4cxyd4T5kF4Mwqn6y2w38xHnops4H4HPNt9JZtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipcRimKKo3xrc5cBRHAQ5offVy0tl2ITl0s/6WLo/I9A80DxTJeXMbgvBkefgq2JSx4KyOrCkdiGrp4qT1GabyOrsFHTKzVDo7cqII4A+i+59lIO22ojWvdoaMnficrxtVUvA9QvAjNNgAFMQNZnGwZ5B8lmD/B/K3jTJ66+sJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNo2AeDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02417C4CEC3;
	Fri, 18 Oct 2024 17:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273873;
	bh=0YBB4cxyd4T5kF4Mwqn6y2w38xHnops4H4HPNt9JZtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cNo2AeDP/eT0MZKDbrULHMJbVvgWOdBBne3cUifVh3NkQywOUfVygur5SXolN4btb
	 FYU2Jqys992vxxb2VXemMgBC2YnBggNIijkSqOgL0HqV0rlnIhKZEv3avTmOQ9dqP3
	 SCgkTxbg7Gu5+9FgR3ewe22TWp3tHxJPJPuhHe0G8eEce7r/XbcbFNN589T3hGkSAt
	 2m9Bph6hS0If2BG2mxvyUtAA1aRH+vcm32HeTyk64qpLIVuLtANCyxW4eqsnpANyZj
	 RpaF2uFKI7ZRqDttI0c0J2ecM8T8RJ6X1lP+P/RQs5iBlM8THt90rteAs20Oi3T19B
	 IX8mrjrrqo04w==
Date: Fri, 18 Oct 2024 18:51:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Hans de Goede <hdegoede@redhat.com>, Justin
 Weiss <justin@justinweiss.com>
Subject: Re: [PATCH v1 1/1] iio: gyro: bmg160: Drop most likely fake ACPI
 IDs
Message-ID: <20241018185105.41a2db06@jic23-huawei>
In-Reply-To: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
References: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 17:57:32 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The commits in question do not proove that ACPI IDs exist.
> Quite likely it was a cargo cult addition while doing that
> for DT-based enumeration. Drop most likely fake ACPI IDs.
> 
> The to be removed IDs has been checked against the following resources:
> 1) DuckDuckGo
> 2) Google
> 3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
> This gives no useful results in regard to DSDT, moreover, the official
> vendor IDs in the registry for Bosh are BSG and BOSC.
> 

I'm nervous about Bosch drivers in the wild given recent report
from Justin
https://lore.kernel.org/linux-iio/87jzeboi3g.fsf@justinweiss.com/

Justin, I couldn't find the driver you were referring to for the bmi160,
is it online somewhere?

Also if you have other bosch drivers could you check for these + bmc150
IDs Andy is proposing dropping in:

https://lore.kernel.org/linux-iio/20241018145805.2181682-1-andriy.shevchenko@linux.intel.com/


> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/gyro/bmg160_i2c.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
> index 672d0b720f61..a81814df5205 100644
> --- a/drivers/iio/gyro/bmg160_i2c.c
> +++ b/drivers/iio/gyro/bmg160_i2c.c
> @@ -39,8 +39,6 @@ static void bmg160_i2c_remove(struct i2c_client *client)
>  
>  static const struct acpi_device_id bmg160_acpi_match[] = {
>  	{"BMG0160", 0},
> -	{"BMI055B", 0},
> -	{"BMI088B", 0},
>  	{},
>  };
>  


