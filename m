Return-Path: <linux-iio+bounces-9572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E919791B3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DE8BB231D4
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A271D0485;
	Sat, 14 Sep 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alX5hJiH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0BC1CDA13;
	Sat, 14 Sep 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726325847; cv=none; b=sYDdc3ZpmYsL0ICWVIB5jPrc3/7gKLLD3+onZgxnIiBTlqRFZUYmqwTyybMEiFYPhUApc/pJaxkj8aFWrxhaGxdH0vBPPFFLrhDJ4R5kMkdHc4RUowdHWEEHOm+BheDUKqnW7AUH32si2x8kWx1VFcyDtfHkSpZzTrxAV7pofUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726325847; c=relaxed/simple;
	bh=YJLimP2J6JK+q2Uak3H10zsnV8/PjiDN2FEMxtkUFq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejHLCizR58e8LTjC7yN+eskFN1qJe25HbsLRQZU09keY4cnYwdhgLOFuCwafnrbN/ejky3UYAlh4gXKTYaRUj+0/Wzv89dU7vmYBCzgBF2eyaylRhh5pqGmMvXiVtPw5mT3HamrTXWtq9OcpcSPAD/YwVE2sD1tC7l+FZcYZ5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alX5hJiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E147C4CEC0;
	Sat, 14 Sep 2024 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726325846;
	bh=YJLimP2J6JK+q2Uak3H10zsnV8/PjiDN2FEMxtkUFq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=alX5hJiHfQgKUyzy1qszGTpqARYWcake18C9reF9dkwuB7gv4HYTRuL61niedYYVj
	 E1+tM4v5j1Ys/JGO628O/jslcY2JW57kSXVmCFSj9GWQ5a+McBxbwohMFle+J8sYag
	 QKzpRuS4pjl+bZmsFAeSZDY1ee/WN2YGghdo6h51aT57gkwZ5XMpB+zE2K6LbqeuHE
	 gBbcaKqwyrTrTWOyNE3nizItI+ghe/Tf+lg67nNOtQ1Zz0in4KoQsk/kTJv6jdw4Sm
	 YhaWNhqSIZt3SLS677Sb0mGmoyJJDjzMvbt/4pbS+B6k4d01eZNi/7PM1BiOOQEQKj
	 Qk+MSP5o3tIBg==
Date: Sat, 14 Sep 2024 15:57:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/7] iio: light: veml6030: update sensor resolution
Message-ID: <20240914155716.09496630@jic23-huawei>
In-Reply-To: <20240913-veml6035-v1-5-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
	<20240913-veml6035-v1-5-0b09c0c90418@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 15:19:00 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The driver still uses the sensor resolution provided in the datasheet
> until Rev. 1.6, 28-Apr-2022, which was updated with Rev 1.7,
> 28-Nov-2023. The original ambient light resolution has been updated from
> 0.0036 lx/ct to 0.0042 lx/ct, which is the value that can be found in
> the current device datasheet.
> 
> Update the default resolution for IT = 100 ms and GAIN = 1/8 from the
> original 4608 mlux/cnt to the current value from the "Resolution and
> maximum detection range" table (Application Note 84367, page 5), 5376
> mlux/cnt.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Interesting.  So does the datasheet say this was fixing an error, or
is there any chance there are different versions of the chip out there?

Also, should we treat this as a fix?  I think we probably should given
we don't really want stable kernels to have wrong data being reported.
If so, please reply with a fixes tag.

Jonathan

> ---
>  drivers/iio/light/veml6030.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 5d4c2e35b987..d5add040d0b3 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -779,7 +779,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
>  
>  	/* Cache currently active measurement parameters */
>  	data->cur_gain = 3;
> -	data->cur_resolution = 4608;
> +	data->cur_resolution = 5376;
>  	data->cur_integration_time = 3;
>  
>  	return ret;
> 


