Return-Path: <linux-iio+bounces-16738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE55CA5CE4B
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 19:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788953ADC57
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3398263C7D;
	Tue, 11 Mar 2025 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AFCZSXaT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3782E263F32
	for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719320; cv=none; b=V/0jUltP9ayXbLKTuZ2nKYeEAZu/XAeI6MLp2RmCBhL/hRHb+M3wbiACuT9+4GKM4xn+Ih2BEtAorcwnVRhc7mrDwZ7idC7nlyILoV/q4j5AGFBN/Jxo6KRRUg8KmyTpdqOIbKQj3Tyzs+30u6fwCx2WBaDWq97+FtmFGhElSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719320; c=relaxed/simple;
	bh=I5XCp9qJNX49NXXwcpLnZPh7Rx5nzUi/B30xgqTwFyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uk7GzK+n8e6FYntXqKp0ow3iVetQOXJxWsMDvP4ie1EyQrGDQxBY7iX69y+Ka5H+NAusBZYPI5hJfXymsCBLOfoKy+lErdQlEBKCDTt+a4tmUEuWW8yetHFe2Z1AjfADKTfKJaA09ijQabORaA+oLnPg0GtJHgEnJw5llQEawFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AFCZSXaT; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72b7f553de3so269429a34.3
        for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 11:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741719314; x=1742324114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rfbsryJMtMw9RKVfoj03FY8sIyD7zgIs1aSVa+RHpaw=;
        b=AFCZSXaTicPRZiFY32JQQrq7HjWYupLJxIvA+vFF+wjMI5khx47LcxNzNZRl4eJe4V
         7WkMGVhcPnn5M2PCf+pJuTLW7r7/nGBMrYj1ID+EzYG8WgiQzuii9BfEigGuO+D1jPne
         Er0hySGkmuA0fzPJSBQud+6X3iAbi37U4B0W+bkVqksURKDY0lgI+GXLfo+z6xedk5bS
         O09Y355sJ7JCWoHIUCkj69ikFc8IV91AZHJRvphO18vVQcrRrvVLSxx8bVPA30cU255I
         ybR9Mkg3c8IQO7BOvi8qYcYtfjTJJNGiTRno8eJCoWFeNyXOpLAbDLpQ95lNvkRkOxw7
         g3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719314; x=1742324114;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfbsryJMtMw9RKVfoj03FY8sIyD7zgIs1aSVa+RHpaw=;
        b=fFVWgte8kU+FSXym81MIm8huSVHz6t6OGzqVPmKSn+PBlLA+2UgzNMy95ojT88mpNT
         767fz5NPdiBq/v97eDPaZatKD7dmrPTcZkPmrRZAibkYcbgw5u5zcie33z6qIxkRduqk
         naw7z0+K2I285RHNROskpp5sw1qK17OgySN2IQXkO5Xf1S/Nqw22w49eRW8zRN53MhhF
         GM4AXpwEZDvi5Cp6K5F3ljrHl1kmNxpvGjDJwtTsS6ipRku+EHikQl6eImXMWF6YiUg7
         ceqT32hyznMbgNlwcvMnYbIT86xO2/84a1KV7uV1j0XWrkhvLVb3xRr5JosMZIaBySqU
         oGjA==
X-Forwarded-Encrypted: i=1; AJvYcCXLbIZP64YRa9L0TY6lhtzOSzlp4i8pwxJYhd4YISiZVKya28hOihNE0xA4IV0pxSJch+6cGyBt4vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ZZoE7ja5Qw7PGzDG3M7O9RzQ5YR8qeH2DXl9Bv+dTnqAwDrd
	k8w+byBVkdxbRrEKGj/PqniBcm9X4eAO1aCzHUjKGgzrB6Rsv3bIlN/mvyiEQGU=
X-Gm-Gg: ASbGncuDpyhjOl9amaG6retj+C+XTHt4gRyt4n3S5xLr1meh47prt4DDyOJPWdA8Dhg
	1IshFPhtCBwI/V+4xz0ODowoeUbvSCWlW65FR1K8ODnFZ5Xamu7CqA/vZqyGSGBaE9kYz0sHR+I
	Fv4+OL5c0wUSiZbVh4Cw2FtSLR+JftbTX+SNbVypHL1ZHOQoogVqAcL221ijXZXPr1S3Ud/loxP
	+53P6FKCUE5bczBtQMxlui14JzlLcpJgRP5Ss/a4GbBi9oLnu5/ceTE6X3/Oyeisp38QbB4Jn8y
	ykznWTHE9MGTljsXsg1iQUGkuWXXTnpjFLwEH1M4rahihxoQOLK6GNwFBJfz6QTBfhhpA7PB5Sf
	iqVYnzg==
X-Google-Smtp-Source: AGHT+IHnPN4LViXdUj/ZgNaO9xNJya86Hv94NzxzpciX60Fq24+EfLbUPPl8b4epJY8YTFpO2bewOw==
X-Received: by 2002:a05:6830:6f47:b0:72b:99eb:7ce3 with SMTP id 46e09a7af769-72b99eb84fdmr3256405a34.18.1741719314210;
        Tue, 11 Mar 2025 11:55:14 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72b9940609asm547210a34.62.2025.03.11.11.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:55:12 -0700 (PDT)
Message-ID: <f5838943-6784-4d4b-8b4a-bf21802bdee1@baylibre.com>
Date: Tue, 11 Mar 2025 13:55:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] iio: light: as73211: Use guard() and move mode
 switch into inner write_raw fucntion
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309170633.1347476-1-jic23@kernel.org>
 <20250309170633.1347476-5-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250309170633.1347476-5-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 12:06 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> By using guard(mutex) and moving code that switches the device to config
> mode into _as73211_write_raw() the error flow is simplified.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/light/as73211.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index 37fffce35dd1..4b73ce57a3d8 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -17,6 +17,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/completion.h>
> +#include <linux/cleanup.h>

Alphabetical order?

>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/buffer.h>

