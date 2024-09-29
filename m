Return-Path: <linux-iio+bounces-9890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D4989684
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1411F2213D
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162842BAEF;
	Sun, 29 Sep 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm5C3eh2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889F29CFB
	for <linux-iio@vger.kernel.org>; Sun, 29 Sep 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630869; cv=none; b=soRQHzTPkx3REjq+KqJSQt5FKNzKnUfRw4ON+PhIybJJltKb3o/mRmySdXeXIIx/H8gQko3Q9Iwl3JXjRjPxaNrjEk7Ye7EHVC0mw4OiAdh3CR2RVB5id0gHKcdDsqdpfQ7wDM6KSnXBCYbFfJo5a5qtLG2ljUnHYveLGB9M+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630869; c=relaxed/simple;
	bh=q3xNA2Fcxk80ZFJf+bwn/CrqouZQOYuJRypron1z/L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnuH47R9iW2cR20XHocDJpV+iQda7SsrqtWYxM4opkJTQlpPIgkAEZAh5T9EJg08nzKeSRnPYrFWaOADKBGPGovhCKw6kGaeEE/hz6s4AEPQugefhqm4cpJ1PdtEv0RfBUumZUYKcb/GHbuJCCSNp7ieHAnlC6hcn5XBvxwJCzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm5C3eh2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d3cde1103so500643766b.2
        for <linux-iio@vger.kernel.org>; Sun, 29 Sep 2024 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727630866; x=1728235666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHFDRJOHtAeR54iUIkHXlKvs/1JHVJA5+qrH2Z0HcKc=;
        b=bm5C3eh2KMOaE2nt+/J5T4nriqUYnXWvVxG7+g9Pw81Bhlse7Ka5DWkhfWITsJw996
         OygqKFwo6EKlrb73AK4I3ANLmlpMdGwpXBiioQBIOLEjr64XSea8z8eHe2ZymZ6uZ62j
         482AJu6c3V87L+uHVrxeIhyzwUoUdIpdKBKsaf+CQ9FOM9thysN8Vg0zchGSlzPUmQ/z
         ZBzD4vIcrAsLZUr3zFoI4vqc4htL+x0mvU91eM2C8Sz1wlyRNN8tnHE0ZwwBVEh+N4Qf
         +ZcpbtKOABxBSpk18rfgnLeueIno+G1PecaThOhOfd1BvOtne0c2h2Sn92AnHhRQODQi
         YIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727630866; x=1728235666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHFDRJOHtAeR54iUIkHXlKvs/1JHVJA5+qrH2Z0HcKc=;
        b=Sc10xelt0GSNncJWaS4CGg0hoYqo+9nzI3uG2+7NN26zo//VNLfV8DPZCU4vzeHk4j
         RLrPFIzMHsGtlVpbp6hSxtFWCOcP9d9U7wLS0S0E3WpCMQI3Aqyn6qynz/KzL5pViIVe
         2wOFVmHH2EeDoD12ESFvnrlZmrsXzIGZzx5Voabsa+aTuPFxRBk2PGYbcpFqe3eOcnsH
         i90jh9LDjG2yvx2YehrtUlE5bjqmJ5Lzp+vKVpz5ouPrNQoVXK1yEkh5wn9YaveWX6Ev
         0spVwCWbV824BldBB3NokK4x15KL1SaPQEoRhVokXDKuM5lKMzQtdhLW9rOJwdtxK6rl
         NVcA==
X-Forwarded-Encrypted: i=1; AJvYcCWc0ya9O8rn/uZ+b8jXTL9EIS5YkJyJnnWdBO4HoONXqRr/Lj6L+9O/6NUqmShLkmsvxfNdUFQWC7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwszKr+wwq5mEzPyyCb8vffzG7TBW95uPcITowQVglaYMtqCHZT
	PhPpclzfxSC0xrE9YzEvcGlafLLNWn+jRTw28l7Yg4fqvldCCcl5
X-Google-Smtp-Source: AGHT+IHnex5aHPNAGWTzIYuHLY9HlzNAhPOuFtqY3CRdvcZwneC5SmdVNrOv9HWcat4Lr1LEBUpTTg==
X-Received: by 2002:a17:907:7e85:b0:a8d:1284:6de5 with SMTP id a640c23a62f3a-a93c49042e6mr981635466b.14.1727630865845;
        Sun, 29 Sep 2024 10:27:45 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:e2c0:9a60:64a8:717a? (2a02-8389-41cf-e200-e2c0-9a60-64a8-717a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e2c0:9a60:64a8:717a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2777209sm402873466b.44.2024.09.29.10.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 10:27:45 -0700 (PDT)
Message-ID: <a46869c6-57ce-456d-89ca-7bf01bcc2681@gmail.com>
Date: Sun, 29 Sep 2024 19:27:43 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: sdp500: Add missing select CRC8
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Petar Stoykov <pd.pstoykov@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 kernel test robot <lkp@intel.com>
References: <20240929172105.1819259-1-jic23@kernel.org>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240929172105.1819259-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/09/2024 19:21, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Fix:
>    sh4-linux-ld: drivers/iio/pressure/sdp500.o: in function `sdp500_probe':
>>> drivers/iio/pressure/sdp500.c:130:(.text+0xe8): undefined reference to `crc8_populate_msb'
>    sh4-linux-ld: drivers/iio/pressure/sdp500.o: in function `sdp500_read_raw':
>>> drivers/iio/pressure/sdp500.c:74:(.text+0x200): undefined reference to `crc8'
> 
> by adding missing select.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409271341.0dhpXk7G-lkp@intel.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/pressure/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index ce369dbb17fc..df65438c771e 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -253,6 +253,7 @@ config MS5637
>  config SDP500
>  	tristate "Sensirion SDP500 differential pressure sensor I2C driver"
>  	depends on I2C
> +	select CRC8
>  	help
>  	  Say Y here to build support for Sensirion SDP500 differential pressure
>  	  sensor I2C driver.

A good example where just including the header is not enough. I bet this
is not the first time that something similar happens with CRC8, let
alone before sending upstream :)

Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

