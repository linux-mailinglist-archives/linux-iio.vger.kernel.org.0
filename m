Return-Path: <linux-iio+bounces-9564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941CB979177
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6E1282D31
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E4A1CF7CC;
	Sat, 14 Sep 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw1A3pI8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40236522F;
	Sat, 14 Sep 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726324196; cv=none; b=bZcww36dG5py3dRkqd9crwAUhdo4CQhwXTLtUN+FsIRLTWX4cs9ksrEeIyBHUi5SVTzEz+m+xTBLLiw0LivS51rfClF34RQuhz/tiYXBry/XrADM+ut1l36901d5sKqzLgIzaq5+JOuLLsq3KEytSBTwUU3z0TecLiUU5g6aff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726324196; c=relaxed/simple;
	bh=4pu9bWu3WEmUF77Qrb/iAzIqmkm/mqPD0zPdI3Rah9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lS9E/1thsosprBVqTz5g8lDQl4wor5t+obZUxGTG9dGwwcawkiXthbyxW6euvFbPhCaCTIEnraoG7A2MvscMKAWHg4POHzlo4lrZoOm5llAwKK5M+Ioc45YAf0A1aYNuwYk9GawUIK4kuRUYeI19MX11x0Q60DFS2pCY34okfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw1A3pI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFF3C4CEC0;
	Sat, 14 Sep 2024 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726324195;
	bh=4pu9bWu3WEmUF77Qrb/iAzIqmkm/mqPD0zPdI3Rah9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qw1A3pI8JgggWpesh4BDP/lf/3nAHGDt2Bsmi7QaViUyTp8S7mWJ4k8IWF8kGLfYG
	 73Lk0DGKLuj9LkNftuYJTrQPQyfglwSoyAR83vY1N/mKYH3klyiZfim0apYhwmPXeN
	 ZXVMY6vs8lharzEx5Qfnqn7ycOQJSLxpDDOR+rfS/zpB9znwp/WfXk3cCiauWbJs3v
	 w6/VFZ075noM0INRlLhMYAYxfCpCDW+m/y7nzj0TUaAgR9NAiYPsxy1RbjiRWze56z
	 PLWaehWdSOwunNWHy19Y2/Fd25oF5FQignzynQTA81mghwSpeMVLXtBU7rKuHV+6ds
	 i0OtGPwBq6ubg==
Date: Sat, 14 Sep 2024 15:29:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] tools/iio: Add memory allocation failure check for
 trigger_name
Message-ID: <20240914152948.1f9927c2@jic23-huawei>
In-Reply-To: <20240912032846.2914-1-zhujun2@cmss.chinamobile.com>
References: <20240912032846.2914-1-zhujun2@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 20:28:46 -0700
Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:

> Added a check to handle memory allocation failure for `trigger_name`
> and return `-ENOMEM`.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
I queued this up already but seems I forgot to say so!

Sorry about that. It is on my testing branch until I can rebase on rc1
when that becomes available.

Thanks,

Jonathan

> ---
>  tools/iio/iio_generic_buffer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 0d0a7a19d6f9..9ef5ee087eda 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -498,6 +498,10 @@ int main(int argc, char **argv)
>  			return -ENOMEM;
>  		}
>  		trigger_name = malloc(IIO_MAX_NAME_LENGTH);
> +		if (!trigger_name) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
>  		ret = read_sysfs_string("name", trig_dev_name, trigger_name);
>  		free(trig_dev_name);
>  		if (ret < 0) {


