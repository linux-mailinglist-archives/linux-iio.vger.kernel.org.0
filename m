Return-Path: <linux-iio+bounces-5700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB418D876F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467F6286028
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0F2136995;
	Mon,  3 Jun 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTgiQNnx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D84A0A;
	Mon,  3 Jun 2024 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433268; cv=none; b=C/OdzdzrDv0aaDoQ8MPITVpVD5QhDyXtzL2es/w7IHBF4YdiVxRmoJVFYjSeYyV9EJP0/wXZqLPYahOSrNvPDQNQmbBrarhc4rul2kadOExbH+6oI/mRaJ7oEH431DjonHTQ6hzAPt3oQoMj2QoJqieGg3sJbanvwpc+0yI9Ww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433268; c=relaxed/simple;
	bh=tcsYbpsClbDP7W64qXiViyfHY/uLsnMu8lYBzHjvMW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BP7bgYk4eMAr1QEiML/pjWHh9xcq0Hgq57JzuZxGO9Q+1GVw3ilRSomkvlvS2LPrpCQw1DJXEG6KPxAie8EEhQUcjlsx+O/2a70d0O86ljH87nD9md8LICdqv7CfuHJugSePU9q6KASsSaGAIorsbxgZYVIoqwf3AbPNiDalX0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTgiQNnx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42115de211aso5743305e9.2;
        Mon, 03 Jun 2024 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717433265; x=1718038065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2K2x6wRyZJXzetpmcBmeg4at5V4dSutinzh+c8KxFdU=;
        b=bTgiQNnxB7nX20v6NHYlfcQ/Qp3sVwBiwVdGTwZEk2ZU9LwU6eUKvQnFsDWYeTRXrD
         sdhhnMRgIRxT81JDcIs8VD5gkbyQNzqMRKaKhiZyxZW/4w8b0LWBmhk+PURHF9ho0a3f
         paXlKaOLVBckdI21lEVCiwfeQLdsVU7FU/U4tgLQ1uE8/ZZrmXmJyNVMKiJdaXakQBcc
         V7CflhrthfIKmzu+hg9raUFD56HL0JBLzZfMil2qVJ4TDS2CGM1fvSAvE4UfGsV/jGMO
         ownSNnOcm5zo4dKiIegcwWlt7/YpPjmWaglqqroEK/XXQcYCdM4AbX9xUnqoUic+CViU
         Wsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717433265; x=1718038065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2K2x6wRyZJXzetpmcBmeg4at5V4dSutinzh+c8KxFdU=;
        b=XWpOpX5d94o3LB4Hy7pD7f9CldvWAF85bnaDN4NXchT8u83e3GY2WFt8S8FXwjKEoQ
         JhvmIPYyNIyklzZJSoA99La/fovgf4yIVDAOjKFSZOkHQwkVS8QObD3942DEgEyVH5QU
         lvEIuR7jyAwKttZUlsEYgs03ESQhjymPmaebZHU7zQqIX//oCYYmIAmpWqSRP/4y25Sr
         IqoDhVoT8xsi4ohygnLQFJOKLdiM6DI5w4yqjEmKweuxrg5QkWp00hmpbSsjoL8Gb9w1
         zVop3mRpV2AEhWECLNodiSB4J3fEF9ua/siqaopZnsfXepdrPyZ4Pof76PR5QdbjLooc
         8JLw==
X-Forwarded-Encrypted: i=1; AJvYcCXVE9PIO/OqUI6yb29VGNLrRqqjeTiurZ1+uYyyIMYT9s3aQ3QjY/WYjbcaaFAsz23vcPuZBnKGaSTrHDwXvQyMMsVw5EzU+g/CZZd6uEZDv+ZyBm4X0ojYFG4ezbCDjQGsgAmdog==
X-Gm-Message-State: AOJu0YzNNPfELLjJpl/jR484ndq5KSwBvCiQxEl9z+vqCJtubP9FaMRJ
	Baq/tRXy30Tfs8htBkS3vYQhezkZEKT9mfaWB1eu9dZUa0TVoUDv3EQqWw==
X-Google-Smtp-Source: AGHT+IGQkiS+qgnQgwMl3BMAYdUelaFUvRGyti9wZfuLl3wYbfZQtWiHoNEAwwnqvObBQE9zFLF7Uw==
X-Received: by 2002:a05:600c:1d27:b0:421:29b4:533b with SMTP id 5b1f17b1804b1-4212e00487emr77921295e9.0.1717433264921;
        Mon, 03 Jun 2024 09:47:44 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421292205ccsm145572875e9.4.2024.06.03.09.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 09:47:44 -0700 (PDT)
Message-ID: <33c7d977-dfb0-4386-bbd7-5327fd4e798f@gmail.com>
Date: Mon, 3 Jun 2024 17:47:43 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add maintainer for ROHM BH1745
To: Mudit Sharma <muditsharma.info@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
 <20240603162122.165943-3-muditsharma.info@gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20240603162122.165943-3-muditsharma.info@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 17:21, Mudit Sharma wrote:
> Add myself as maintainer for ROHM BH1745 colour sensor driver.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> ---
> v1->v2:
> - No changes
> 
>   MAINTAINERS | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6c90161c7bf..945873321fef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19407,6 +19407,13 @@ S:	Supported
>   F:	drivers/power/supply/bd99954-charger.c
>   F:	drivers/power/supply/bd99954-charger.h
>   
> +ROHM BH1745 COLOUR SENSOR
> +M:	Mudit Sharma <muditsharma.info@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
> +F:	drivers/iio/light/bh1745.c
> +
>   ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
>   M:	Tomasz Duszynski <tduszyns@gmail.com>
>   S:	Maintained

Looks good to me,

Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
-- 
Kind regards,
Ivan Orlov


