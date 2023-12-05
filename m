Return-Path: <linux-iio+bounces-624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E34D804B0E
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 08:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF367281639
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 07:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE6C168CD;
	Tue,  5 Dec 2023 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leRYyA/F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C60B111
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 23:21:05 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so29163231fa.3
        for <linux-iio@vger.kernel.org>; Mon, 04 Dec 2023 23:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701760863; x=1702365663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAFOw1ZYfyFzZPlMQaMrshgLwtTPLz3BabU4hC7j1aY=;
        b=leRYyA/F+gtJTq/D9LA1AitlzXEqWhpvMX1Gk4bV0Igf+nb4sha4ms9o+eqR1pXZdK
         pDfLNRe+9HxrkDcl0U99MC0cIb5f+FytrPiMNOWT7wnnde1y+0YWrqXZLhhrjk683iwK
         DJ8CVGbssoga29s1xZyTKZjLwsvaFwZhAgk7s9pH9VgOR9BKnXdGZZodJW0I6wS/I5H/
         gPbf6l5QgOt7648dE7tYKbkz/oxBHIH2wxHwqg2Lj9X3CMvZVF/z2qwp2bfd93s02ao0
         1pTtsOHY4eMZCDxkke/5xyiJPPNoqypERMGCaFAA/TnOjbBpoebSZVz5LTbwfRTnm/m9
         oLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701760863; x=1702365663;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GAFOw1ZYfyFzZPlMQaMrshgLwtTPLz3BabU4hC7j1aY=;
        b=qJbEjVz7X8zDIqdrupvhWTLv+ufDm8XdPhhCvS10IQJ1hvsZv6DKhoYPf0tM8NgQwc
         mjovzt4sHTx8Aj+YFJej1GwCMjSPfUXFEbrNu/rXSlfChSQOI1784VoZRKDiZVhglJMU
         GhBNCglQvvx4j3kbCCN5cFBUXdkcy5kYCf7qqFXtUdRe1oaYigGR5dKbGwqjeeo/aNmB
         b11WAw7DjeSdVBMMuyR0MRW1zXy51b2TIx35heoTXKExFDAo3+A2Hkd/fmMwks/YEuqX
         8+ZBvKqCuQ7eQfFlpXxWlG2O3GamwpMHu3NZOXcpL8dvasuLYkb8tb1KjJ/jgaT8lcWy
         eiKQ==
X-Gm-Message-State: AOJu0YzHdjj4QCx5VGHkHf2xp3nmMp77hHwess6GnWDryeEsx9NOTzOm
	QB+YYMydzwnKbsgv6nfHDvs=
X-Google-Smtp-Source: AGHT+IF0q+u1mPqaSXq9QwBoULTgu0HK5ebUa3xzj0ijYDyUyUng/tQrhB0pUVpVZR7VTMf2uKWv5w==
X-Received: by 2002:a2e:8397:0:b0:2c9:f68f:685e with SMTP id x23-20020a2e8397000000b002c9f68f685emr1293958ljg.79.1701760863208;
        Mon, 04 Dec 2023 23:21:03 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id o5-20020a05651c050500b002ca0abab79bsm407378ljp.4.2023.12.04.23.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 23:21:02 -0800 (PST)
Message-ID: <26aa7753-c597-4e5d-afd3-a407e5605335@gmail.com>
Date: Tue, 5 Dec 2023 09:21:02 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: isl76682: Space consistency
Content-Language: en-US, en-GB
To: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20231205012246.104503-1-marex@denx.de>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231205012246.104503-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/23 03:22, Marek Vasut wrote:
> Add missing space between { } to be consistent with the other { } .
> No functional change.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: linux-iio@vger.kernel.org
> ---
>   drivers/iio/light/isl76682.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
> index 15a68609985b6..a17970fb3758e 100644
> --- a/drivers/iio/light/isl76682.c
> +++ b/drivers/iio/light/isl76682.c
> @@ -328,7 +328,7 @@ static int isl76682_probe(struct i2c_client *client)
>   
>   static const struct i2c_device_id isl76682_id[] = {
>   	{ "isl76682" },
> -	{}
> +	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, isl76682_id);
>   

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


