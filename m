Return-Path: <linux-iio+bounces-16594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D018A585D5
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F13165790
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5631DE3DC;
	Sun,  9 Mar 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D76ipwiY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1AE14D2BB;
	Sun,  9 Mar 2025 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741538009; cv=none; b=JU+7NidGhvBZQ7Kow1B+FISBTJQhR1lLqBpxCF2p9ncOHqRCgJ8OAGYs7Isd/WlOTYTUofAZxspzBNibqgUqKeMPt+K1DdInY5SA9S8xUPwQ4JkYhnzHXiezjRNl1OZQOvCADElWUrlJI1o6ky/VoFSTExw9C/G/lIq6k5C3U6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741538009; c=relaxed/simple;
	bh=Zztye7osbKSDVX0Aq3QCaQF2fuBA//3UomuaLn6hre4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJDMyog/Gih5Kt4mfKF/lTwvGnsoQiiHb035Woeb53TnQoXoGbaxymfYiYJI0HIZNwXOXOYwOiAn96nrL91GdtN7vNAdnU7Nw18nVkUYhiU62YQbpreZWruNhZNh3XD2rbic0WnrK1RaQ8znKaJwF9qYxWcvf9MbkttBSd1Rifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D76ipwiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFADC4CEE3;
	Sun,  9 Mar 2025 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741538009;
	bh=Zztye7osbKSDVX0Aq3QCaQF2fuBA//3UomuaLn6hre4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D76ipwiYrndJBhozCz+qQKLlsECtiYUxEIlm3pAEhWU5ehzXHv65Psjwd0bMvT4q7
	 isTsS7XW8JVoWzjnDIdrrilUgxJNJDVW3tQNpiuaNyErZllCOJSS+pEXcRqz0nUmcN
	 7Udo3qYj6p8qDv2ZATuUvtd0QZw1cNf9+RHJIAsXew1oAU6mwuUeswCfe1IlH1WYbM
	 lmLfXewqIlcvBHIbx3+taUfw4YYCjXssux+Plz5NsssrqlrHttx+TQmhQGL2jfsRxs
	 b4QRxHq7ljw83qYTHh7jnjockzNdOya5wKNkl3bgdoBKCR0mareztTKYFdLrqHHjuF
	 ZUjVcKJ5OI2EA==
Date: Sun, 9 Mar 2025 16:33:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: light: al3000a: Use DRV_NAME
Message-ID: <20250309163322.331b6a36@jic23-huawei>
In-Reply-To: <20250308-al3010-iio-regmap-v1-2-b672535e8213@ixit.cz>
References: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
	<20250308-al3010-iio-regmap-v1-2-b672535e8213@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 08 Mar 2025 21:00:59 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> Sync syntax with other similar drivers.

Sorry no. This is a syntax I am against and frequently request people to not
use in drivers.

The  main reason is there is no explicit reason the two locations you use it
in here should use the same string.  Using a define makes that implication
and I'd prefer that we did not.  Note that if they were required to be the
same then a define would make sense.

I want to look at the code and see the string directly in these locations
rather than go look for a define that adds nothing.

Jonathan




> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  drivers/iio/light/al3000a.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
> index e2fbb1270040f43d9f0a97838861818a8eaef813..e1fa4543f336cec61140b5c44d3794df1fa485cd 100644
> --- a/drivers/iio/light/al3000a.c
> +++ b/drivers/iio/light/al3000a.c
> @@ -13,6 +13,8 @@
>  
>  #include <linux/iio/iio.h>
>  
> +#define AL3000A_DRV_NAME "al3000a"
> +
>  #define AL3000A_REG_SYSTEM		0x00
>  #define AL3000A_REG_DATA		0x05
>  
> @@ -148,7 +150,7 @@ static int al3000a_probe(struct i2c_client *client)
>  				     "failed to get vdd regulator\n");
>  
>  	indio_dev->info = &al3000a_info;
> -	indio_dev->name = "al3000a";
> +	indio_dev->name = AL3000A_DRV_NAME;
>  	indio_dev->channels = al3000a_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(al3000a_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -195,7 +197,7 @@ MODULE_DEVICE_TABLE(of, al3000a_of_match);
>  
>  static struct i2c_driver al3000a_driver = {
>  	.driver = {
> -		.name = "al3000a",
> +		.name = AL3000A_DRV_NAME,
>  		.of_match_table = al3000a_of_match,
>  		.pm = pm_sleep_ptr(&al3000a_pm_ops),
>  	},
> 


