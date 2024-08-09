Return-Path: <linux-iio+bounces-8339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC78794CB14
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 09:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC592831FE
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 07:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EDB172BB9;
	Fri,  9 Aug 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAFU0zOa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1117BA2;
	Fri,  9 Aug 2024 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187969; cv=none; b=ku8m9k3ybuDRRMSUjGMYqYnwU7/Epa4ipvFtJLdMX2At5L6pnRzuoy+/OWDhRKl7I+UB1TdUwzHYulVAA0l8qrumwqMFRa/Eggg0VqAMQ5GV6a4wLSNh0AVttqr7Y82bnZvePvq0CQJy4+wvb5g0C7OVAOjvsIU5zZarVJkCMpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187969; c=relaxed/simple;
	bh=oqyCFkrC2GFxWJXkElWgKcvd7lEdRkKXUB/pBL7diuM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RVUci2eRJ+wvnit5BkmxH3jHdox3tc61ZPk3fjQ7YXuAAptWfwoTZyEA1aQIfqOPReg6jq64xG0C5Kw66rnLjTpbbYmKK8axQbFkhiBi7o1V/uapxO/bGG3OJpTTSo2c77cw6pYLi9NeTk3/eYuIJBPueJu5Fc704UT8K0Rmf7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAFU0zOa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428e3129851so12440075e9.3;
        Fri, 09 Aug 2024 00:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723187967; x=1723792767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP6ushgnIPrkP08Qb9zI4t4A3mRRpyVIC0onCpnbQLk=;
        b=aAFU0zOacL3RSlUJHseNTuOa6AY038IxJC7bGa+07+/j5l3wiB4/u072z1iZ5JYbFf
         VEzIN32aJjtVHsKgZp9WKgDZ0nzu9yMZPW6WgbEbNW2foG+LMbjulstWpxp7Y7oUWLeK
         gBftFkLHjhT0pZDTzIbdRXguxdGlDHn3OoPB4jSPUZF7Q+TgFVkSu9H2rRe6vIOomzew
         EFBjkPbA1L7NSITG4CV4SNWFzMpl83ZrPbKEuEEoGFAF6CY6EibuZatmz1c81+H+wago
         WN+d4DNWOM+LsYNxzqVmOOTlCf7MCXCJOnFvOjzlJaDq8gWp6sj4udwhFno4MIjR8aNW
         hi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723187967; x=1723792767;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wP6ushgnIPrkP08Qb9zI4t4A3mRRpyVIC0onCpnbQLk=;
        b=D51mR/hQVjr4+WLQoowKRCAKrgshDZWySWhTgel4QkQ8gfcMJT2qaNRd0jzicNbiIG
         +r38vVcM7y/LOA1fl3ryF67WAVRnvXScwCW/ZYWUBdyrKSUTmYBFbRhF8YVeS0T2VWpR
         QR0GEoMXjm7WmCK/SCsyBl3xbFXLJd/LY0GvclLPEN+T++aOiTmQ1VQHrGDbbu1e14eE
         ItIpW7Q9dmJigUY9LTh+V6F9vGufLmoJIGIkxGl0ZIBn6eJOyEg+u+oia5yaW2CIPSa0
         JxcxnGBzbJEn8iPOvDmtrNRI4g7r8Z4ja04kcQn3zdHoGPew505Qrolad4Qm1iLyjYd/
         T0cA==
X-Forwarded-Encrypted: i=1; AJvYcCVi1eL1p5ZZaDyMnAhDWrsmUVkaguQ9BNvxe4ezGWzWMrjtABWoFpXBZdrc5Zcu482TP2RcCHHrcLMH7X/qb/qqI8OhF1kC+Z93sAgaI8jrsiNXttirqzpXq6Bu0tm2jcBUmelWvXS8djZf5Pu7F7JBttTOgqEk8mcFI4BxRMpeKfgMQlJDHkEC
X-Gm-Message-State: AOJu0YxMAmhHp44/HjQrSszqoNq/b+exj6anYp0CYQZwYLFFsNUS5hw4
	xFSUabwjNMwpUCcNOyiZWrjMPn9Qcd2jQIuSJ23IThq+wO6b6QVx
X-Google-Smtp-Source: AGHT+IErd1gqYViL5s39KvxwkEFHjbBo4qIm58Rtgsbxc4Kdbu2fl7hLx1QSmXAibbhYE1Ri1gcxEQ==
X-Received: by 2002:a05:600c:204a:b0:427:ff7a:79e with SMTP id 5b1f17b1804b1-429c3a1c4fcmr3536935e9.16.1723187966012;
        Fri, 09 Aug 2024 00:19:26 -0700 (PDT)
Received: from localhost (host-87-20-57-122.retail.telecomitalia.it. [87.20.57.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74a698sm63055845e9.21.2024.08.09.00.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:19:25 -0700 (PDT)
Date: Fri, 09 Aug 2024 09:19:24 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, 
 Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
Message-ID: <66b5c2fc7a0ae_133d370b6@njaxe.notmuch>
In-Reply-To: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
Subject: Re: [PATCH] iio: adc: pac1921: add missing error return in probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Dan Carpenter wrote:
> This error path was intended to return, and not just print an error.  The
> current code will lead to an error pointer dereference.
> 
> Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/iio/adc/pac1921.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index d04c6685d780..8200a47bdf21 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client *client)
>  
>  	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
>  	if (IS_ERR(priv->regmap))
> -		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> -			      "Cannot initialize register map\n");
> +		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> +				     "Cannot initialize register map\n");
>  
>  	devm_mutex_init(dev, &priv->lock);
>  
> -- 
> 2.43.0
> 

The intent was indeed to return the error. Thanks for catching it.
Acked-by: Matteo Martelli <matteomartelli3@gmail.com>

Thanks,
Matteo Martelli

