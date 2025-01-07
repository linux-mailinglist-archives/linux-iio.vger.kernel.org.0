Return-Path: <linux-iio+bounces-14004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D62A04DB0
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100B67A2694
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C054E1F63D4;
	Tue,  7 Jan 2025 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LSC53ugx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA081E493C
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293171; cv=none; b=agRqNbJuziUy1vbZ80FMdpZ0D6PRZj0XkQ3WEXCg6XegWyYlrAVR4J6Et5HLBBiqabkumyQZLczDmWvzzNmONDyoAvzNB95H6Av/dAjThTs3A25mfd6YBcd0yvnNnMVHvN8bRmmRLOFeraPCJtXZ23kLR9pu7mzEwExYlDr+lJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293171; c=relaxed/simple;
	bh=FSV9Z5hx4Z1dGvFGaSVdGoaHslLzkpvoMYIjvjlDIz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+0HhX7qUjgoZ/KvcyND53LulsEZbMRvpCjg5yTuI19X33CfCFz5Xxi2YDVUuLFd3tnPtyJk8wn8HAkCKRCLzBXC0sN71ibGawTlGJdjRAwPauKWQlBpB6QbTXFRH9qOdg6Xmt73TrcbbpZQDGHDjZey1wkB8ksGymXRFBkP0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LSC53ugx; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71e2dccdb81so10589891a34.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736293167; x=1736897967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAQHiQqSouPrkvzwP1M1BN23WdXiYODfQljxHvZJVpM=;
        b=LSC53ugxfm30XZiNjWPxkha8b2DtjwBb4zLJlt/HeqwTUL8UAMi1el5fjzRhk9Nx9m
         rkZ8lfNUDT1BctvM+koNyVpd1q8iHE++orgzNTtb2EHRnxV4XuEtvGf9qqzXOGCazFJ5
         KQof5Hiym/PV2iHqecMZweI1yiMah+wGSJ0goMqs+02H5uudTxdDO98tA1MpAIcwUnP6
         EJ8sAbCfwcddJI8FY7z794JZq6uludFVYhW1fAsqKS3IByByhpBfw42FZY8S9Bloes/c
         B2m0WvT4BuQ8aeDODSY/z58huUuP/8V422Fr7tqHsm2iTxfuAKFU2y4v2egNXbfGgbJ1
         b9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293167; x=1736897967;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAQHiQqSouPrkvzwP1M1BN23WdXiYODfQljxHvZJVpM=;
        b=aWLd6bl/gwtfnzbZkTFFJpL8ehsxqpHPeLTgvW7FBjEorRVqp+lBV2+d5Y4G7W+7yO
         4gIedYlTP80nXWmpFqIei59Dklr71KL0DGEKclDX8rg9kkJCzmekWXIM6o//sp7Gy1Jw
         yj6ddpGUf6mG7HaxsO9U/y+3TeQSJ3OITk7rSSDP0++LPJv+ckCc3tSmoNU+1XoBx+VR
         nFWAXpMpIdm7X9dlxBUKyG91gu4Hwp4R6WeWnDTKJ8nzng+cE5jh95yJwBSjtfhjnMnJ
         GMJVinw9Ojp/5spQUbDu8e9cEg8c+udzjEIN2J9QpM9gBuc60nB6a+0ChPIRhVa5nYBq
         2J1w==
X-Forwarded-Encrypted: i=1; AJvYcCVJdTlzBY/qeiWySCh87clAweLRQvkNi5iobft/JrovK2XoDpzGS2e/pLZ6i6B6d5iqntrOjayLxUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0AewBY6KY+DxCaVTYS3syDoIbjGk/vlAHYQ96kM0jFrjDGogK
	ivRiLUv00tOrIUYKZDvncJl3YN6HZ/j9NEQydckM+YSeUg4ilGW0NmCVijDPTY8=
X-Gm-Gg: ASbGnct+czdByjb/xYJ6JRSVvuT/rrqixqZnsbWTr05xJ1cguun19fb0mI4BY/pYfg3
	SPbbM/qY+JmD64qfHKQzvrGA/GkEtySwfcjIkGwbCncy31etQOvQKwK8HtKzfp0ANsSrmM8/son
	PrVK608gAfhKRq1xiDtkVGytbbTXRFayZLyvq6B/jiYgqMXT1bsdc4jub7sXPiF3yKP3a6+PKWl
	8fBdhIZfNX1FE9gBkogHM4WoujMvcHqN39Dp5OiVvymKGH6qLMIU0Q7SBrfbhehGa3qPfG9owXD
	G31w0I/4kdOi0PiZgg==
X-Google-Smtp-Source: AGHT+IEOj8KZeV0uki/W4ZvDbZRrzQA7rnv4j1WMYyJAcEJHaCprcG7dhx8f+/AWKtyu41ZXIsgnBg==
X-Received: by 2002:a05:6830:601a:b0:717:d558:ca70 with SMTP id 46e09a7af769-721e2e306e6mr537190a34.7.1736293167033;
        Tue, 07 Jan 2025 15:39:27 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc9764170sm11099389a34.3.2025.01.07.15.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:39:25 -0800 (PST)
Message-ID: <a466ef57-a4be-4175-b17f-872712354dbf@baylibre.com>
Date: Tue, 7 Jan 2025 17:39:24 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/15] iio: adc: ad7768-1: Fix conversion result sign
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <e521bb5cb60d413edbcd1ea582fd81073218eaf5.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <e521bb5cb60d413edbcd1ea582fd81073218eaf5.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:25 AM, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The ad7768-1 is a fully differential ADC, meaning that the voltage
> conversion result is a signed value. Since the value is a 24 bit one,
> stored in a 32 bit variable, the sign should be extended in order to get
> the correct representation.
> 
> Also the channel description has been updated to signed representation,
> to match the ADC specifications.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


