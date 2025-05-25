Return-Path: <linux-iio+bounces-19856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE6BAC3368
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A171890FE7
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F31E5B64;
	Sun, 25 May 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuK2HLae"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5503211;
	Sun, 25 May 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748165227; cv=none; b=CwGSnto+I8OAoQVsBIdeHu/NHmOcnsP9MaDGcHMCyir7xqOIa6IdvinuPc3Z2a61lXfcf2Rt/PptdjY0qEdlo8mNQwtrQ4NfVKAKRL1yVeyBItOG/nme4GW8z45bKBmIYjWpNjsrZUT0FlOjdVngwYVo7iLYBeVb2PBcWVrIF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748165227; c=relaxed/simple;
	bh=Htcbn+KyEsVVp9c2bRKjfXUW1dKWwN+XtF2ZkuOSr8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+ev01c2rj7RGLa0RIdELJy+q2qXPWCivshtgd4ee8QQwqoElHsE/hsefa2pQKhKcRtbd2dHJsfDJVFxWgYlC8zfJt9Zxl5snK4cM3OzX4ca21iVlrn3ZkpmRBGj+PLvRvjacTmiRnuxNP8unjrYnOt50E2ecg4w/UjTdXYp0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuK2HLae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5C3C4CEEA;
	Sun, 25 May 2025 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748165224;
	bh=Htcbn+KyEsVVp9c2bRKjfXUW1dKWwN+XtF2ZkuOSr8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VuK2HLaem2onVHwfS8qW+RYrrZ3YEYH9fCNhLpOtyJCgi5rX+wzQmmYY55MV/pNnE
	 fWzsBoHhWwYLw3j74ptI4dXHQZOHdLI4Yaofv82l9FgMrLEOjpoZrUXFO/xMJK59i+
	 ebUdLMBFw+uZa2NTzDf0fn5wan9jKVyN8ZnY6glM9ctLTsytwn691J5IFCauLOwdlU
	 /Zr0lnXQdt5TPYe8kSUvx0+iBWsA3Q+XOT5oB+XFFejUlIGlB8h1vq6mU2eHBde/lt
	 832OJP59vPr7QOR3+KlFQ1WtE8HhrDwBm6dXTfdNxY1JWK7oQxrq1BUBIZaYYAI2gA
	 OIAPGtJtcDNsw==
Date: Sun, 25 May 2025 10:26:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Jacek
 Lawrynowicz <jacek.lawrynowicz@linux.intel.com>, Maciej Falkowski
 <maciej.falkowski@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, Markus Burri <markus.burri@bbv.ch>
Subject: Re: [PATCH v4 3/6] iio: fix potential out-of-bound write
Message-ID: <20250525102654.5b761490@jic23-huawei>
In-Reply-To: <20250508130612.82270-4-markus.burri@mt.com>
References: <20250508130612.82270-1-markus.burri@mt.com>
	<20250508130612.82270-4-markus.burri@mt.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 May 2025 15:06:09 +0200
Markus Burri <markus.burri@mt.com> wrote:

> The buffer is set to 20 characters. If a caller write more characters,
> count is truncated to the max available space in "simple_write_to_buffer".
> To protect from OoB access, check that the input size fit into buffer and
> add a zero terminator after copy to the end of the copied data.
> 
> Signed-off-by: Markus Burri <markus.burri@mt.com>
I added
Fixes: 6d5dd486c715 ("iio: core: make use of simple_write_to_buffer()")

If it predates that we'll need a manual backport anyway. If you have time to
take a look at that Markus that would be great.

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index b9f4113ae5fc..ebf17ea5a5f9 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -410,12 +410,15 @@ static ssize_t iio_debugfs_write_reg(struct file *file,
>  	char buf[80];
>  	int ret;
>  
> +	if (count >= sizeof(buf))
> +		return -EINVAL;
> +
>  	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
>  				     count);
>  	if (ret < 0)
>  		return ret;
>  
> -	buf[count] = '\0';
> +	buf[ret] = '\0';
>  
>  	ret = sscanf(buf, "%i %i", &reg, &val);
>  


