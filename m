Return-Path: <linux-iio+bounces-19431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE93DAB291F
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1291B1898C19
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA43425D202;
	Sun, 11 May 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUTFGZsf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BB25D1ED;
	Sun, 11 May 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973640; cv=none; b=Gx1mhi7zQhQopM41Shs9o6PZabvcwybcOsgfCYu5oIPvGimx5b1f1jOBUChOZVMnGYmp/hG0oqwYtow/vT1jrt8laOVy7TOK9tFm3cRAIE0LgBMXwiEFMy0kxFE669cXi/Ggn7dd7hFrOfCDh1cXsNpB5xqWHpyZyp6n5EWUwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973640; c=relaxed/simple;
	bh=qYsPB5KTJZb+XUGm4MW6ZwKZMh54o71O1hC+tg3tZWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjQjqKsv4EBSByA7CcRRhU+5nR06pW0ErUtSlyrT45YVD1po8RStMjbT3tRoJDDBw+hgjumhRbkzWDHfHEmWggq26Ui2M/baVlgCX8kykE4mKL4ZAwlKJjQYr5U/oV2ZE5G3DUNGQ7b/zZ7n8hE5QD9njVoarhrkQAckV1lBQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUTFGZsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0707C4CEE4;
	Sun, 11 May 2025 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746973639;
	bh=qYsPB5KTJZb+XUGm4MW6ZwKZMh54o71O1hC+tg3tZWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VUTFGZsfLBrHnjVnBTeej4wSPZzyPI6+32RY1g9O8Wgdp865wvZgZqUP6ZUvCJDST
	 OW9a5RdYmOw53EABLcl+/LFqcmiT5iL1+avGUChdgS2gHQHfczML3CrO2wTkJ8rz6F
	 CMazwxn5m+RtnpAo+K7dg0TAGowB8SZaK9LQU5Q11spR3ShzejqeaPM7SnJ1szITOY
	 sCNQW1pmzbbK6k2NgqwrqJMvUQ4TPg3TVB67TVoslAlYYSSfXXssVHNG27CZLSPrLb
	 3MWWCAShtdXDHPI9siix40h2m2Xw1ef67f7pd8l4hEffQk+2J/CmA2n9AKwsqWUYnu
	 zICK5ZaW1dXtg==
Date: Sun, 11 May 2025 15:27:07 +0100
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
Subject: Re: [PATCH v4 1/6] iio: backend: fix out-of-bound write
Message-ID: <20250511152707.294bc7b9@jic23-huawei>
In-Reply-To: <20250508130612.82270-2-markus.burri@mt.com>
References: <20250508130612.82270-1-markus.burri@mt.com>
	<20250508130612.82270-2-markus.burri@mt.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 May 2025 15:06:07 +0200
Markus Burri <markus.burri@mt.com> wrote:

> The buffer is set to 80 character. If a caller write more characters,
> count is truncated to the max available space in "simple_write_to_buffer".
> But afterwards a string terminator is written to the buffer at offset count
> without boundary check. The zero termination is written OUT-OF-BOUND.
> 
> Add a check that the given buffer is smaller then the buffer to prevent.
> 
> Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buffer")
> Signed-off-by: Markus Burri <markus.burri@mt.com>
I'm looking for a tag from Nuno on this one before applying.

J
> ---
>  drivers/iio/industrialio-backend.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index a43c8d1bb3d0..31fe793e345e 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
>  	ssize_t rc;
>  	int ret;
>  
> +	if (count >= sizeof(buf))
> +		return -ENOSPC;
> +
>  	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
>  	if (rc < 0)
>  		return rc;
>  
> -	buf[count] = '\0';
> +	buf[rc] = '\0';
>  
>  	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
>  


