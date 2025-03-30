Return-Path: <linux-iio+bounces-17367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CA0A75B63
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100E6188BB33
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B311D89FD;
	Sun, 30 Mar 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="texjM4v4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC91F949;
	Sun, 30 Mar 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743355639; cv=none; b=Lqyi4zEKdNuD55LhSb3jPrbxekKHmjxNSQ4z1VuMnszhcW7PBdQVYenu7glacZBVbMZpajOtELCCDr0nuTYn8fqJZEpq3G4cn81sNGTnlippemKCqJYTkDXxxAmxrn9meZry8SKEWTcbtH9DQH6w7LDaZlHyEtEh5xN7IBflmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743355639; c=relaxed/simple;
	bh=WzHZklL3ktxrRi/XcJJ96lMGw9PyI16CB2Xy6Yj0bdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOVJPf4FSNY4asc1DJNoejnz1wzMedn74utMTUSG11kktZMuAfTfEkvrKEE7N9PbjY7YBNSH7nrEL5bKe7fFOtVeuCug0zfZ+auWFM+kBSFJ/OLH0e0wpGxvVMRIkJQjko2j1FZnX3DzUfTBlc0kB1efa+nD4eNqTHwR4aNoOh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=texjM4v4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A84C4CEDD;
	Sun, 30 Mar 2025 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743355638;
	bh=WzHZklL3ktxrRi/XcJJ96lMGw9PyI16CB2Xy6Yj0bdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=texjM4v4sP5r5sg7CpdRKzqkYKSXtWwbtpwKRkfaU4ukkBpgWgxGRIKgv+lZPc4FM
	 IyerZCcjKqxifiHLP0Avv1azTtYrEuZvZL4ujKhrWKmir4JCdcIcd+VUUHJDPMmAY9
	 KvSUHLRRyoQVccgCqy8KnoLo+pqRtuN2X4KGw+8u+DcmXNnklgyPKCjbVy+y/gP6Mh
	 9NUDbAW9BjP1svaYH+gkJNLCo+pCEz8ToSlEpfqOHfHaLD4EN+rVNf6AtbuX593694
	 J1RPgJEwabTkOypsdonQhoDg6dum9V/P7AR5ZyYDJ3GfDl1emV8Z+r5U8KHHmv4nvh
	 P8MZfq/oZASYQ==
Date: Sun, 30 Mar 2025 18:27:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] iio: light: al3010: Remove DRV_NAME definition
Message-ID: <20250330182710.4ce400ae@jic23-huawei>
In-Reply-To: <20250319-al3010-iio-regmap-v2-3-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
	<20250319-al3010-iio-regmap-v2-3-1310729d0543@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 21:59:42 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> The driver name should be passed directly.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
Also things I'd generally not worry too much about in existing code.
Given they are part of a larger series though I'll take them.
Applied 3-4

> ---
>  drivers/iio/light/al3010.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> index 4c2fd88ab32cd73f4735b0fa3014af084037c94d..7fe91049b55e57558aef69d088d168437a6819ec 100644
> --- a/drivers/iio/light/al3010.c
> +++ b/drivers/iio/light/al3010.c
> @@ -22,8 +22,6 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> -#define AL3010_DRV_NAME "al3010"
> -
>  #define AL3010_REG_SYSTEM		0x00
>  #define AL3010_REG_DATA_LOW		0x0c
>  #define AL3010_REG_CONFIG		0x10
> @@ -184,7 +182,7 @@ static int al3010_probe(struct i2c_client *client)
>  	data->client = client;
>  
>  	indio_dev->info = &al3010_info;
> -	indio_dev->name = AL3010_DRV_NAME;
> +	indio_dev->name = "al3010";
>  	indio_dev->channels = al3010_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(al3010_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -224,7 +222,7 @@ MODULE_DEVICE_TABLE(of, al3010_of_match);
>  
>  static struct i2c_driver al3010_driver = {
>  	.driver = {
> -		.name = AL3010_DRV_NAME,
> +		.name = "al3010",
>  		.of_match_table = al3010_of_match,
>  		.pm = pm_sleep_ptr(&al3010_pm_ops),
>  	},
> 


