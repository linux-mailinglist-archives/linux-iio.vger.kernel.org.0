Return-Path: <linux-iio+bounces-12171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257A9C495C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 23:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9F81F25952
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 22:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6682E1BD032;
	Mon, 11 Nov 2024 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VmsTHvRC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF31BCA01
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365642; cv=none; b=D6ILUr6zQG8fT64/BTHsP09UWTrMsbS6E89fJLEz2epEXk7xIcVVn9MLhuKD7dH3B5ezmdR/EZmrkDRQAUyxxivIxNCBmfAzXXv/54G1w6vcACFNDFWc5vz1PqQBXubNrErgjpaIYdhsodIjynYoCTv2jVFWCJJfJM/illh0pKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365642; c=relaxed/simple;
	bh=GUxdK3bWrbQNduznuDLaYiQ2csEsHVvbRbbUGA4YOcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clzn+BhFv8wotIPG7y7eE+CtmpTP4XjRG47VWnqi2qFkP8GvSWzSP4GJj1yTLf/Wx7/TsxMe1ZieW7Pp+V5xABEvnUw3Jp8UtXolWJX+Djq3vE3lh9u2HEj/2rR6B+YEGTCU81WWXouq/vvTL8d7cl33/K31HX0k0Ek0QTIPemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VmsTHvRC; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71811aba576so3136490a34.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 14:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731365639; x=1731970439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qeQLVqGYO4ALLLE6OpBa6NKUVcn6gN8ZfFj0qfpOGg=;
        b=VmsTHvRCTngDbzqmvItbFrkMs4u8KzvVbvOI6Qw4gUBzPpMXutGgJBbodRuHSSA7y3
         JwdeOBB9egDRZRAqIdWG81+8pRglKUAcSr1EI4d/7go7kA7+dfFGf5cDeRFmcWxII9JO
         9kTjSHq+OXbIpk9g45HTd0D+B29yXTjA20TC8nbWP5BYQrJNtgi7CB9daZeRXguEnNSN
         u/WMJ4B92+AoYTItPZUhYTaA08W+t/l3B7EivmepKZQyMDXYzjJH/KvLbsw8QCyN0w9y
         ByZKOMV8ugWBT31R2F50RqPmbFLgzVYFYDaguj2ArRvZw6RHod3LDR2SDiL+Ck7HKEs8
         EYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731365639; x=1731970439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qeQLVqGYO4ALLLE6OpBa6NKUVcn6gN8ZfFj0qfpOGg=;
        b=UTplHRQqReImJPFui1kvRJcV78qfqWrg1jvlPvVHdAdZnk27tBLQin82FDtveLxJPb
         6T35M3YITmignqsNfZLz7i1jbQggxhXzcy+R8EIUWyqOnJbhepwzT/4zCjtd8+FJrJtg
         bLzsIotrWtM2Q4doXCFrXT7DIhcwg4qwdPS0aYUNhgf0tYY9eQp+0aZqGgtnQRwhYbtL
         wJfeHDMz2bpKGymtClwAc+WW1VGoXl8xAiRGxrlGFbk2KNM6XSF6pvEdFrXYtVedxxos
         ACYdKOYeKd+Y0YfhNu+yrHBb91F7lU+45NtHyNaQG8X0q44iFjsdbLsrtGihnPYOHzae
         zzgg==
X-Forwarded-Encrypted: i=1; AJvYcCXCxbXXANdLKBWnHk0pVTZs+F602KeZsO8EEM9zHZBW+pQHxKmFXP60+18fsFjfFbaSSsU/f9GPmbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4qooTpCoFN8xkCGclWPZw1gOouYfnkCZmGV0sAn7lVFvxHLa
	WAjHxCq7Ps5zAT31eeiiH872bvj7/bdHhdw6RDgmOLz/yo7Bwz3FM1mg1XH/vfk=
X-Google-Smtp-Source: AGHT+IFI70O9qWZLYbfZv+s3z1ZWen9vEBjFIao6aaE9nVOytwkkB4ogTBF3q06vdafFfqOS5zD5bg==
X-Received: by 2002:a05:6808:23d2:b0:3e6:4f60:407a with SMTP id 5614622812f47-3e793ebe322mr7790726b6e.4.1731365639507;
        Mon, 11 Nov 2024 14:53:59 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cc803a2sm2249913b6e.15.2024.11.11.14.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 14:53:58 -0800 (PST)
Message-ID: <f02fc95c-a2ef-494a-afbd-5af78ad1f489@baylibre.com>
Date: Mon, 11 Nov 2024 16:53:57 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] iio: trigger: stm32-timer-trigger: Add check for
 clk_enable()
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com,
 tgamblin@baylibre.com, fabrice.gasnier@st.com, lee@kernel.org,
 linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241111222310.12339-1-jiashengjiangcool@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241111222310.12339-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 4:23 PM, Jiasheng Jiang wrote:
> Add check for the return value of clk_enable() in order to catch the
> potential exception.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


