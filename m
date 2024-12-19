Return-Path: <linux-iio+bounces-13646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C179F7E0E
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5111889A35
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E5222616C;
	Thu, 19 Dec 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNwQcxT9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F08225797;
	Thu, 19 Dec 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622065; cv=none; b=qQqHafTIY26t9BiwmvRDjTnfYiC34PoLxoj9khq6y1fD1qtoUtqr8c4UMy3122QZThnk5pumELoenXEUqgKlO9fHDQmui5ZBTlshbVQiQoagMwXeqB3Al6nesPSVdfARyKuqXdvHcyVPVaeXTZnHIZRy6/SvxrdX1Zf3Q8yejsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622065; c=relaxed/simple;
	bh=lqyLaI1PkhatCtqJfvWPSVVAWWUcMYBipsOrGKdwZyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxCN6MK6JpC9abYXXYFeZrXGYkJkQ59LzY+LdNPnFfve/rjbCHDy6oxvYgaxPXkyvW/QDYKADzrdtjToPMANFr9o9Ed1VKwcpcvfiN9IYbp7VV1FnrOLIDaaO3ORpUCXUqorxP5m1EZ9m4xmNTTFBpYKyF7fMf3Icu0sPsEMzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNwQcxT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3D0C4CECE;
	Thu, 19 Dec 2024 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734622064;
	bh=lqyLaI1PkhatCtqJfvWPSVVAWWUcMYBipsOrGKdwZyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QNwQcxT9oTC0g/hUAAItMAFky7Gdq+CpZQeh7pt9OKbEfVT6gDEL90Jo1JO0fOrA+
	 phBhCVGjMRKR+OdaZh/G8qDdUzbKqwrDyhRNXDWE2O7PJXngVF4+CCLW+eJBroC8u5
	 HWyD8K5afr1gfRAXD6oI807vZ+KcS5vrDGAfYHEdZ6dmihlgLmpaetdQu2lBp837+P
	 HdQxGJIUGY6IjT/K6To8zU7WNdLAjVxgyN/1cwyWWYppsoUTRpoOujgp3tXQG8oyeD
	 PzN9g5Ze+/mT7AXSh/YXqKdMkFZW8FaOLdK9SO5fU18tbvSTErKPQC5T27eb2uWJ7S
	 1y/xKXHqcrftw==
Date: Thu, 19 Dec 2024 15:27:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5624r: Drop docs of missing members
Message-ID: <20241219152737.2417b24a@jic23-huawei>
In-Reply-To: <Z2KFC7ZBwmM69Qb4@mva-rohm>
References: <Z2KFC7ZBwmM69Qb4@mva-rohm>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 10:17:15 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The documentation for struct ad5624r_state contains members that are (no
> longer?) part of the structure.
> 
> Remove unnecessary docs.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Applied. Thanks,
> ---
>  drivers/iio/dac/ad5624r.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5624r.h b/drivers/iio/dac/ad5624r.h
> index 8c2ab6ae855b..098fb5a7683d 100644
> --- a/drivers/iio/dac/ad5624r.h
> +++ b/drivers/iio/dac/ad5624r.h
> @@ -42,10 +42,8 @@ struct ad5624r_chip_info {
>  
>  /**
>   * struct ad5624r_state - driver instance specific data
> - * @indio_dev:		the industrial I/O device
>   * @us:			spi_device
>   * @chip_info:		chip model specific constants, available modes etc
> - * @reg:		supply regulator
>   * @vref_mv:		actual reference voltage used
>   * @pwr_down_mask	power down mask
>   * @pwr_down_mode	current power down mode


