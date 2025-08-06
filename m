Return-Path: <linux-iio+bounces-22345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A0FB1C8E3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF71C18A46AB
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56AC292B3E;
	Wed,  6 Aug 2025 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0YiNXtpX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4052918DB
	for <linux-iio@vger.kernel.org>; Wed,  6 Aug 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494833; cv=none; b=nziQgCg0Zxa1LyE5vg1jjYNFAxIkVn568ev2ILNQf5iA1EBhDCXgAA3TUQRAGhQF4yQWGw42wHd91WuWYtZah6k3Gc3Bhc7l2t/k/Jpt2ExD86eDWa//glAfjwF/cgbt3hUGYUnNObGWGfg1me6WL6tp5nfjvWfQ4FgctQyhPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494833; c=relaxed/simple;
	bh=EeT0WZ+eBX99CaEowyMa9N2mX+gmwtjO7hXeuDnKxuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwGREda/Dyj7xsxJSZrx9+cYzIWgEp3OFg+k2tDCa+f9B2h1OvzqeAqeER9510Emx0gRTKNv0vAUsyUOdKAkEHdzY+xmWJncpUGzE4uLRc14iGWIEV1RhY6BLU2gOeYkBOGz/qmGWNdixJHZIs5xhS9JJQ/iQP5wWfxenXfngbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0YiNXtpX; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-302fdd379faso37403fac.1
        for <linux-iio@vger.kernel.org>; Wed, 06 Aug 2025 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754494831; x=1755099631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQBK2IwZMWMMUUwJMnG9AhYt75ddXd1X11p/6lNi7YY=;
        b=0YiNXtpXyXS8PligcuC5QUGPyxYekO0MR1myGMYbzkoCRf62UD6EAEbrJerysnqBTt
         Op2XJyoY7Dv2fsQKp0nm7wNTLMJ3YAJasgfvc2P0SgHgDXVAtWhidEBB9YXRFiPSGO3H
         BbZ398zPn7VnM+LUFUkvZVf/njgGhaDtk4hEk/FcfNwaiNRCwgJrsPndYPPahPxbBJ6o
         QNPoXcP8qAaZsKwLwKbTQNQ+m1EYC5jDexAh2ivEOs5+439TDVVr6ebrKZaxhZZyWsO4
         alah97UWv9zqpJ/1+s967abxekZvyWIsB5qdNUDImZ+ZsKITIJ27ELrIi5+R+J7Z6hS9
         mgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494831; x=1755099631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQBK2IwZMWMMUUwJMnG9AhYt75ddXd1X11p/6lNi7YY=;
        b=Sxv14c7sJlCBaX8lzN7uLvGP2C2F75OAVJ/qC6pgvSnnsHJH3/AioFdFh3215W7MmV
         zgPPYBN4BjGDZsbr2Kbg3XsmdBwDksEdlBAjUqpIukqJqKl+PEV4zO9gBIOeRHtPiO2f
         i5l/8Y+QoN7vqKWwd5WN2573lVIslxAnLW3D0Q8THUQFWblXLmsNBVRi3uJXpwEIZFLD
         W1C9BwgmMXqlWNAJy5slkIvT81E+lwpbYwXBrbSnzKKxMIBJyNGQoDGJb46U0tCY+Mc4
         uyv3p7e9ufZnKbprzj/Wii+VWu3l17S4QaOvdpsv+Gvy4W5OuYG3IvBQ+eA48OJFNDWL
         gSTw==
X-Gm-Message-State: AOJu0YxiacPYlJD3UPDLV8JjyPZCJqQQ7ODCNPYRjqkZElqJpWr9l8gN
	8uJ8rMcJ0/PWOCEBXpqISC8s06Xk14MThRPIhkxxpflgOoMtubtPEK7mjPxZk/XfUm4=
X-Gm-Gg: ASbGncsJz6MdikDdHtMW3li8vTJCfCQvEeyVM4HRK2g7+v01NV6BYU1bgYS5Eq1C6AE
	t4oJ2YSo5NjQkwXaBS51zKQnweHwKN4pGHhr6USLkacIg32cU1EBtp/aQDF6LM8xg9LAgjCPzRH
	ciO1H018E+dGrbJmto/PYzpQlnyFigypGwcop7KJiHmn6Vbrvw7LQVJiUhMzr670rfuzsE8IIpk
	p1W0A39c+2ts6G+dH4cK5hk8iCl73Oi4J5n6yaG31ZsLgZnT2agZqQCsU9dwa+HUh9dFTDMgfkv
	chADquVaCE8haOlq0iRbs9U4b7fYQCjZS6Rfw+KKHMWSuPFhAIj2fK/2T32PThjrRKIGMmzy5nD
	wI2NCXaVhKNqzlYvnmnk4nN43Wd6A2PNCJKt0/8BzMK2/UwHNKh7yjdzKLMf9Esq3KHdYcjfnvf
	Q=
X-Google-Smtp-Source: AGHT+IGyhhBDynpJJBPXpYSNWmJwFA6wI2gd1r9MWG+zv3b0rnP9HU9ECWIyhKY0YTr/FgxMV5AtGw==
X-Received: by 2002:a05:6871:7583:b0:30b:d2f7:5dca with SMTP id 586e51a60fabf-30be2ce6df9mr2375124fac.35.1754494830642;
        Wed, 06 Aug 2025 08:40:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d? ([2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-742f6a3fb1csm1211295a34.37.2025.08.06.08.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:40:29 -0700 (PDT)
Message-ID: <29bac7ef-c9b2-4e37-b4a9-08a0120e6083@baylibre.com>
Date: Wed, 6 Aug 2025 10:40:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: adc: ad799x: reference voltage capability
To: Stefano Manni <stefano.manni@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250806090158.117628-1-stefano.manni@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250806090158.117628-1-stefano.manni@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 4:01 AM, Stefano Manni wrote:
> This patch series refactors 6b104e7895ab16b9b7f466c5f2ca282b87f661e8
> in order to add the capability of the chip to have an
> external reference voltage into the chip_info struct.
> And so avoid ugly conditional checks on the chip id.
> 
> In addition the AD7994 is marked to have the external
> reference voltage as well.
> 
> Stefano Manni (2):
>   iio: adc: ad799x: add reference voltage capability to chip_info
>   iio: adc: ad799x: add reference voltage to ad7994
> 
>  drivers/iio/adc/ad799x.c | 45 +++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 

Something to keep in mind if you send more patches: this
should have been [PATCH v2] with a link to (implicit) v1 [1].

[1]: https://lore.kernel.org/linux-iio/20250805142423.17710-1-stefano.manni@gmail.com/

