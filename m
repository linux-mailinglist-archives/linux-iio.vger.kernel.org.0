Return-Path: <linux-iio+bounces-19855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56EAC3363
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77ED7A30DE
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658EA1E5734;
	Sun, 25 May 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MssJ1DTl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC151E493C;
	Sun, 25 May 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748165023; cv=none; b=t+/fMcpvBOQTxCV4UoWrpmR2h8lsi4noeZx7G8zq72Dy6AbYk8/ajhwT9dx04z50LqOzwVVBkChUnOyx0Wcjo32dYAlQFrixfVPmf9nAyQeUD9CXIyIhQwW+YbPTkHKIjMBRHZXnHTH8ZlajwkU9Fn9S9u4+n4WHakD6s5nU2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748165023; c=relaxed/simple;
	bh=8xJ/4cJzkengF8ieK0oPHmswKBr0WzC4IkIOgHiz8OY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnFJa5PLJOJy0uegTPa398ySi9tWC73Nvzh79thqfwokZQSH5kGunpwFUOS6ETg1ft5kS4nNrvm/tgp7GPfzJTq+5JMCNteQ91A2zwqAFbtzhAzz5oVHqhqKCnPOsQcmm69+xTDGlhnw0zb+1nKPcC0uLR8i/mApBXagcG3Brow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MssJ1DTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD81C4CEED;
	Sun, 25 May 2025 09:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748165022;
	bh=8xJ/4cJzkengF8ieK0oPHmswKBr0WzC4IkIOgHiz8OY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MssJ1DTlorerzrvBZ0h4vsvrIEFfdcrfkqEUa2npxXjrdxEMK7wbDqdR5lHNfNcLD
	 tu0B7WAPk+NpFWNPAreGfoyUJ8JJ9O2pvIkTJ9CfYSmibOjh/DGPYhGP067DDmnnzy
	 yppRkwTZAED4PSUxIkMUbyeTWL1keMWrSPcSTanp/PrmuNHhK5p8QRusrfjBJhzvJv
	 1793QewmP6CGsO0FjgNnWhIBD3WYK9SFox4uzhaV2eb3yfZBFY6cB7ooxROezwGjDb
	 dnyXiZeM1qQKpNat8UKWUaOOV5FP+Yzo5E6Ff6BCxQW7BWAB0zyUANLZOWOTJikBuI
	 jdvyzQ2bRHfiQ==
Date: Sun, 25 May 2025 10:23:31 +0100
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
Message-ID: <20250525102331.46a4d778@jic23-huawei>
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
> ---
Applied to the fixes-togreg branch of iio.git.

I'd still like some more eyes on this if anyone has time though as
experience teaches me that subtle tweaks to string manipulation end
conditions are easy places to make mistakes!

I'll not be pushing out as non rebasing until I rebase on rc1 anyway
so we have time.

Thanks,

Jonathan

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


