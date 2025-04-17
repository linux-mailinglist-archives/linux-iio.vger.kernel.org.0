Return-Path: <linux-iio+bounces-18200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724A7A9227D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902DB167D4A
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B8254867;
	Thu, 17 Apr 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I08ChHFl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5BF253F04
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906662; cv=none; b=mDHqOu4JcM3mTPKZOY/LkSVp9SHCtGXhXdHLh1sKdlQ1xUm2B10B2M6OY83MQHUSQj5+bq8QatF9OThAAlOBaIdFTHZkOu7qn6zUbQXM8PU+DO9hSs+vncdQ7FyDx4hh8NyHui5bib3OpSR5dzFoZX+3wkQZCCX/lClX+WDcyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906662; c=relaxed/simple;
	bh=YdyGYQvJPxptB7Ud1K9823h/vEclrujKLrEKCBQa44w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jh+fha7b+rKBKL0yJqsLsocYyEOKK0/r0PTl5WZbLEwCPuRdNrC3xNUFMsGaNOEhg3E9sgr2GOQZSfYCSpdUS9VWVB5DWoTxCpfOgOg/FH8gMdz7ru4Mx2V3PPZwTm2su/3dMcmQb8mjjsjUFyRwtkfgoLeqa0pg8h+9uGiqPc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I08ChHFl; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60288fd4169so461405eaf.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 09:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744906659; x=1745511459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJ86ga6RjrBQ4jtVg7iGsvEs2Pk/5xuTneiTlVnUO0k=;
        b=I08ChHFl421jGUWX3hDKOeCEnaE2W6myEHnSc/t5arLr/NjtnLLOb/6WQqjUeLO1lN
         Ykzpa0tDs7OOL15YMenVo6fimibiO27iVp3tNFmKtoUFjNTDPBRpv2Y1JNkY6uspB8rE
         m+D3e7Glzdtpc0Hpe+UmFVcXFgjM1XsSIM9f6wlVC4Eh6VC1kD6suIBnKgt6SPFQUTT0
         7V2vzSKFf1+MJiEG8R2g1iQzw5S2aX47IKFPAudL5k9x7ZkzC/0Gpgt+E5V4tf7ChoR2
         mJK50Oyb9CZx27ZbOcCUL/focZmNQTZt6VXq1L8c9Rj6NEGyaFtlO58rQYBKWgDXOvRq
         em2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744906659; x=1745511459;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ86ga6RjrBQ4jtVg7iGsvEs2Pk/5xuTneiTlVnUO0k=;
        b=GALMrVX0dt5jxNy3D4xVzrhYVA8GiPZoR/0mXx4CCsSPk+C0ebwqEV6awtAgfi94N0
         r6DPp3pzNvlBzHwV7E/r/3xM4Vzec/41y70LT1ghKGEeuOEbVK5UksElzopisiaPlVhs
         8+/7rQ698PqKH8YskkVRodTZu18lQfCz/WLnNi+6MBZiREADOwCmYub2w1keBUj/yWzB
         1NAoRYk6NGwLa/IKtO6yTLRJ2+3tUqAhpVRKbDbDTnzMlLoMnxJE85c10aQuEt8vjn/T
         SmLVBsvUjxgJlKcoLDUpQvNrJJOJz5m+0Y8QQDK4NF+t/QrTW4hn0mJ1KOtMH/1X5JnW
         Qo8g==
X-Forwarded-Encrypted: i=1; AJvYcCUl2WrroHZupwwfvxIx1ykHcNtWGV7nnJLQVanLmD+3lkHzcaH7I18Us4gDwhY1BCFCWi5SehPeceA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySgdmtFSV0IcO0F/jgpk4hjBO2tHrZ7koK6G8+ple3dAmYsRCO
	tBa3vvPMlbysu/lpDHDnaekLFHTjSNwJHdIVy2vCI+IBiityYCM+tiE6+G32njdPw1zB+iGk/iu
	eOyE=
X-Gm-Gg: ASbGncucIKoBbt6VajTlT03zS6FmPK8TSUwoo7T3h3FTY8KuwiqoV9qDSVEvbsfZP9C
	JZ7DLTmyiz+QrZxIz+dtZec4pd0H4dbDhlF2vpT8Tw5x8zEG83NScBznIa9kI6H1aE2T/KiaQFy
	BREN4BiQQtDOw+Y42ZVNzcwu7FY82Jc9DZGUrwSq2IquUNMGj4b3BTxBJDQRecSg8OXyVidOGa2
	CRC2exiTr47EtkIeGgUH1eAYz2LSk+aLyPJT6psIuOqfk0UsoRvdJ7I5Bi2yv3srzgPEVYVysxp
	4uuzxyqxsza5wfARy0UglhmG9pmm62aA1enXoF/Ph7EZhLvyab0L03op7GMZirPhpjzzDAWgOst
	/ibGtdiVKN5jnpqnLLA==
X-Google-Smtp-Source: AGHT+IGBBgE75fsVkLXxYoZqV19j+mS6o4e4vTLZSbr9DKTQoVtLZ0+RYC5g8QIKrdP0fbpy7FLYJQ==
X-Received: by 2002:a05:6820:1e13:b0:604:6b0:c259 with SMTP id 006d021491bc7-604a931e696mr3952610eaf.4.1744906659563;
        Thu, 17 Apr 2025 09:17:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee? ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff6aacf5sm12896eaf.39.2025.04.17.09.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 09:17:39 -0700 (PDT)
Message-ID: <cd50b4eb-ef6c-4842-88cd-932042ca2629@baylibre.com>
Date: Thu, 17 Apr 2025 11:17:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: frequency:: Remove unused parameter from data
 documentation
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>, gregkh@linuxfoundation.org,
 jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
References: <20250417143220.572261-1-gshahrouzi@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250417143220.572261-1-gshahrouzi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 9:32 AM, Gabriel Shahrouzi wrote:
> The AD9832 driver uses the Common Clock Framework (CCF) to obtain the
> master clock (MCLK) frequency rather than relying on a frequency value
> passed from platform data.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.h | 1 -
>  1 file changed, 1 deletion(-)
> 
Please include the driver name in your patch subjects. Otherwise readers will
assume that this is something that affects all IIO frequency drivers. I noticed
you are doing this on all of the patches you are sending, not just this one.


[PATCH] iio: frequency: ad9832: Remove unused parameter from data documentation

