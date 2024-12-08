Return-Path: <linux-iio+bounces-13231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC39A9E86B5
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30E61884D56
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FA916DEDF;
	Sun,  8 Dec 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4SMdZPq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD320323;
	Sun,  8 Dec 2024 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733676735; cv=none; b=HAAWDcRktf0jWjcrM2PYp0sH8Ax6qkCkm0uBqnosYVBdXI8Re3YN5AoA0e22XkposPR7P9q1ZSoA9c4PgWNztlTQTVMMcS4kq1RQzqjOMaWQp9Lf5pHc8Uwdx2dkB4RY0vI0FbQBTUqR/PPC5YJNyJUox9Duf8PEkf8yaBM8XtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733676735; c=relaxed/simple;
	bh=bEBYco6/srzwb/gQhGO1rybBf+L9L5uWjd+rO+bMRf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbdHksr7qWlavNDGVvoUHI3x1U64OsVpjZkwO+G0t0wqXYTOBhfpd/7dwV5qwT/paTwZVEBq/EQZHjpu20nlGqwRScORVkA1txaFZqyLBOGoHHS0lK3paRf3p67Fxat2v6DopOOhHA1bh4yGvJgydfjh8n5KUvRGIHE/lmo3CtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4SMdZPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC4BC4CED2;
	Sun,  8 Dec 2024 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733676733;
	bh=bEBYco6/srzwb/gQhGO1rybBf+L9L5uWjd+rO+bMRf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s4SMdZPqb+sW5P5yO7g/awl5XvRH9cbqDFEz+Zn0i8Q7lHVvDWZqVDvIemGG7SDOR
	 4WdV8DPFhuq/SsFnH0y/aYWEUBAr/qjrYenRUt72mQW/ra2kQC6c6ojGNLFKmKVjS2
	 +36YQN5OyjiVNqd0D+nFrsE/3XL/MTmF5P0EchkX8v7K+PBMbS6/g0QQYoyjiiRwUp
	 VarJqlpdhGIMLvFGvr5U4bq/Ljz1lTpoNmSlTNNAYFpg1Ff2KJ/w3VWTjqEfbXjiNl
	 BL9tAGCu9/wHCTk1Dq8AbPSrAVvLd0OA5El7jWV89OYKCU2BFsmG01msFz2Xbg5Hi6
	 HtR8WMurw6RWg==
Date: Sun, 8 Dec 2024 16:52:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Antoni Pokusinski
 <apokusinski01@gmail.com>, Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Christian Eggers <ceggers@arri.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?= <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: temperature: tmp006: fix information leak
 in triggered buffer
Message-ID: <20241208165204.20b5bbd4@jic23-huawei>
In-Reply-To: <20241204-iio_memset_scan_holes-v2-1-3f941592a76d@gmail.com>
References: <20241204-iio_memset_scan_holes-v2-0-3f941592a76d@gmail.com>
	<20241204-iio_memset_scan_holes-v2-1-3f941592a76d@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Dec 2024 00:55:31 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The 'scan' local struct is used to push data to user space from a
> triggered buffer, but it has a hole between the two 16-bit data channels
> and the timestamp. This hole is never initialized.
> 
> Initialize the struct to zero before using it to avoid pushing
> uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied but dropped the stable tag.  The patch this is fixing isn't in a release
yet.

Jonathan

> ---
>  drivers/iio/temperature/tmp006.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index 0c844137d7aa..02b27f471baa 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -252,6 +252,8 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
>  	} scan;
>  	s32 ret;
>  
> +	memset(&scan, 0, sizeof(scan));
> +
>  	ret = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
>  	if (ret < 0)
>  		goto err;
> 


