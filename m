Return-Path: <linux-iio+bounces-18087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C6A886E3
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7631942AAD
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F3F274FF2;
	Mon, 14 Apr 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Lx4a5OGA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E925DCFE
	for <linux-iio@vger.kernel.org>; Mon, 14 Apr 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642749; cv=none; b=Is6IixGxInZsYAiZeSsRMQDzjMOWQuJULbdnwvX+qNBfPmXbwiedVhrILcZJk9crrSGtPbOYuRKG+QBc9inz2nuO2tc8OnxjPZBH9w5BQ1aDaqd3ehwVN8U8ksGvDRpWLiKP/uZtYQ03pwyaxrahQs0x431VQJGy1Co8qXAE9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642749; c=relaxed/simple;
	bh=x8T8uwj/TLGIU0lF+Fq0pjFkLdrbonvSm35PpZ00zz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bV8UEeYek+je6fzj3dBS1+OIT/bOnW3K/mcE3nRMzVbNWi8Y3mSf0IW0YHDyyFjjTCHjQvfNDhLfdVCKxgVQFXtXieSYwE93GPdpYGgYjAkhvJnEuJKlgEj7t4JF51S28T4z0LhokJMGYUi8ADbLGhVEHbxNmNMjUF9/aDtdxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Lx4a5OGA; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c1419f73eso2775838a34.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Apr 2025 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744642746; x=1745247546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTu/tTBiLDnLTo19OmaQLQq2DdZvvnanifk4lVRIq1Y=;
        b=Lx4a5OGAN9/Wf1napXhNyDcYomwPRaOVCyVQbaj0bXa2zSxDFnRIFmpGRUwuOqE9VO
         6cmWfN0mR+El0gG72xwmkO+1/hAuMkV+36MH4UBqgY9t5lOITLd3BtecbiZnUhSuSAeb
         ztPLzQ6xc0WSqYiSBcueOAuKe4jQbtcMe0RWY8lXWlKyqZOBVMwrNiGZZ2Comp7y75ET
         NEVYutaqGa7/5XjcoDlV7vCUmmIdGZ6PB9rmiuWb7TBeLoJK0C9KZ5yvTBmEkmM5qQL5
         Ju1ESoVCDly3fF/TMtsA0bfr/ZnPUHSHAmB+Um7+lVfYINKWpkHPIY235DGtQbh/juOu
         XaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642746; x=1745247546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTu/tTBiLDnLTo19OmaQLQq2DdZvvnanifk4lVRIq1Y=;
        b=GfDDNETHyQno3BeLflnmBFXEuxfgzF6jBLxu8zNoXyigRJ7iqhA2Fo/UGmg1xgCcdc
         TeIPR37mnIzocMxUCPTKHGEEozwG7gR2OJcMwyo4H15rkIn7Pzmou2FkMTKZQun78Mh8
         t4DByI3d1glOXv4S28yardOFmmWp2n8tbOTF9mkKJgeO3FxvNFoeUD0XXUf9ur5bcxVA
         VVIWhHS74Wx6A+DZ67jM+pymktdjABa8ctUBwGJ64iRk+5KIfwEFbOVSBd1s/tFIqHSA
         2pxsPIcMhjHT0hst36VZakEvmyoUrJQgG1QPcRfliXrv+CYhSlpCIcaDji11bC/jBzYr
         N+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHvtYcfuxaet7+L0rR+FTgDIPEwGmnSiR3yBvGnzEOsNRAnNmyHjAUBJwmFYgXoSwXtKkyzIKjNKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7Q5POcDbsZwFjmIk33BbjSq+W3vep8yUJiWUCPrH4Grc9pr3
	QN2kl8pTdAEI1wBtyK8YGGAgicv9aO6WxN4nDTdqTk2L0C7meVJ9Sdcka3OvRkk=
X-Gm-Gg: ASbGncvQZK1fMFMP6IORPFw2X36gVRsWdzNJOJniBSwpfrRUptZCCBMCxqpXSzgRflY
	5N38tOD2YAqWWQ8EvQxKz+IONpKqn0EN1suyDZUsbC9PiMyPPhY54eqcP/kUWlol07sGUabFBOY
	Ybtth7YJRa8804isZ5Bb7x7J/wx+oxzYcyGTLs6wATFM6GRMAxHk/bFDI9Tw82OVFfW2/0I2QOD
	3zz13wJdTZd8FfzD9YVKqhvhmw6DGOTcRP9aYekGAwIIDiVHRzRAiA4u9JgEoEl2CxNm0aBNeIY
	9cmV3vjnv3kRdHupjP3PpuWEqzvfQNGK4qHnOAiSW9hJUd1Z+71oH6CzXe3K1MSFk4tEyaXJ5oZ
	2JGIjEFVFGD4nynsMqqRS13P48eyk
X-Google-Smtp-Source: AGHT+IF1glTK7Rxcw8wLI6vS9cuIAF6Jejh7PaHmK35pumQJ1AqOK5QhIhTv8QqFc965AKmemYt/Rg==
X-Received: by 2002:a05:6830:6209:b0:72a:1222:9e8a with SMTP id 46e09a7af769-72e863c607fmr7034537a34.14.1744642746453;
        Mon, 14 Apr 2025 07:59:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:442c:b496:9db4:da43? ([2600:8803:e7e4:1d00:442c:b496:9db4:da43])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73d8ee4esm2029688a34.39.2025.04.14.07.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 07:59:06 -0700 (PDT)
Message-ID: <0b1b428d-9ad0-4581-a13a-88f4ffd6c4e3@baylibre.com>
Date: Mon, 14 Apr 2025 09:59:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: Correct conditional logic for store mode
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: gshahrozui@gmail.com, skhan@linuxfoundation.org,
 kernelmentees@lists.linuxfoundation.org
References: <20250414140901.460719-1-gshahrouzi@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250414140901.460719-1-gshahrouzi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 9:09 AM, Gabriel Shahrouzi wrote:
> The mode setting logic in ad7816_store_mode was reversed due to
> incorrect handling of the strcmp return value. strcmp returns 0 on
> match, so the `if (strcmp(buf, "full"))` block executed when the
> input was not "full".
> 
> This resulted in "full" setting the mode to AD7816_PD (power-down) and
> other inputs setting it to AD7816_FULL.
> 
> Fix this by checking it against 0 to correctly check for "full" and
> "power-down", mapping them to AD7816_FULL and AD7816_PD respectively.
> 

Sounds like we need a Fixes: tag here that reference the commit
that introduced the bug.

> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---

