Return-Path: <linux-iio+bounces-8536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B905F9557EC
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01E61C211CA
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098AF14A09C;
	Sat, 17 Aug 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQv6Rsy5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F2E1854;
	Sat, 17 Aug 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723899136; cv=none; b=gEKNHzz/N28QKGfPNaHIoB//T/mTMkqQgwZSIqBGHFx0ACs1gC8o33Omqj8PzfZIINesQGAFaveIC756U7mlri+1fvOFG3Er8Q8WzHhv/ENRuNkxRiPJAYE7p0ckv70PaCm0/CNlOggUgGzaiCpJcr7/2CVFyUjCOmQN/zPiPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723899136; c=relaxed/simple;
	bh=SmjSm6dPOdqbI09p+V3ZSjlCLAvjlilK7PvolZNdICU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OziYJZ6XEfGgXFR/HUp+6idacS3krL0v7fIWnDl23TeQJlaNIJ2Ox26zIETJ/MBtkKy7k1ydmbRMfoS20F+MNp7k4B6EgrPmwKUb7n2P4IHQssWycCO2YCqVc5UU/TuGw65RPhC6zxWLXk+BnfjxNO53++XfKnXrzYkUDeq8St0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQv6Rsy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEBEC116B1;
	Sat, 17 Aug 2024 12:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723899136;
	bh=SmjSm6dPOdqbI09p+V3ZSjlCLAvjlilK7PvolZNdICU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MQv6Rsy5Mi5Gkm5ZtxlQ4hCKWG7CMIOlruAt0vANygQUIGzxy1CxXFhVODYpqZ1VG
	 Vsk+WVornbRpIqXE22RatCFBEM8PhJBx9CT76yGpgeQSvfWXomr6JLvSjOc3vOfAlK
	 l7nQGFfrnVE2gcMfGaViOA9EGiCANCOcn8QwcxXsbF6GR3hCBkgYnZ5kh6K6hH1IWe
	 iG48pTcadQ5SA6OzpQz2H95yrWQbCx9XwhdgFA08LWULdDTe/120XrU8ERhsjNIQa6
	 8S5q9LiGQVlJ52NAXJKkQJHY4CXmq964DoEv+YwS/dipWspSKaQfDZ9kGr2UCq3+Du
	 X8mFJ4TyiNSCQ==
Date: Sat, 17 Aug 2024 13:52:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yasin Lee <yasin.lee.x@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: hx9023s: Fix error code in
 hx9023s_property_get()
Message-ID: <20240817135209.0682b74e@jic23-huawei>
In-Reply-To: <49b5a9bc-e5ca-43a7-a665-313eb06fbe27@stanley.mountain>
References: <49b5a9bc-e5ca-43a7-a665-313eb06fbe27@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 09:43:05 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> If we're returning because "reg >= HX9023S_CH_NUM" then set the error code
> to -ENIVAL instead of success.
> 
> Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Hi Dan,

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/hx9023s.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index fe14a62a1342..8b9f84400e00 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -598,7 +598,8 @@ static int hx9023s_property_get(struct hx9023s_data *data)
>  	device_for_each_child_node_scoped(dev, child) {
>  		ret = fwnode_property_read_u32(child, "reg", &reg);
>  		if (ret || reg >= HX9023S_CH_NUM)
> -			return dev_err_probe(dev, ret, "Failed to read reg\n");
> +			return dev_err_probe(dev, ret < 0 ? ret : -EINVAL,
> +					     "Failed to read reg\n");
>  		__set_bit(reg, &data->chan_in_use);
>  
>  		ret = fwnode_property_read_u32(child, "single-channel", &temp);


