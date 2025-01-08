Return-Path: <linux-iio+bounces-14037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6263EA06688
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 21:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E133A161F
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 20:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34420371F;
	Wed,  8 Jan 2025 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ejBmbgoL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CD1F9F4B
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369006; cv=none; b=HZha+CZhoVZe5cCLPnrA3Y3NLFRp5DSSqFU60+N9hujRV3qTP9k1sNIkCl3O5mdMxkAF1JBUR6h5wwihRYdmm6zZ42zPMRweinCQV9tFjGinhxuhhLQ6E1dif1jndLGM4TuWFgTH6l9uX5NoxOlKWB8okSe+F/VUQyNheszMhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369006; c=relaxed/simple;
	bh=Lw5rU+NglZOWa0E7G6JTz+PmQ7ZQS+wqtD71Kb85YU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8QLA3ZGJ6IQG07WK8eKwYJR13YYYP71etTQv29+9Rys86geG5tbcimpAk/v823AHYXgejHVeERPj4UR5mXJHxRHAiQX83IJdkXgZnVNC0ecr/dNJIS3N/jE9thLPEP4HIAIif2t0kBnFOrF6S6GgHnQE0pCUoucKuQIXZ2owU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ejBmbgoL; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb9101419cso108533b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 12:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736369004; x=1736973804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOnlbWdm8MLO/mvmzUuC0fDQsKMvE3v8m4PGv6tTsVo=;
        b=ejBmbgoLJUHyyd3tM5qaPmlwFGbgZ9Ue8qmly9rF1h37MEPuNDvhr/lu/eGjvhYF12
         sojDa5S4cvqUSj0jzq0n49H5pcsILXAxVPmrEJ0xym9VZrIai1SDEqACQskwdSZUtbuS
         63z0RNHkii6HJAjeAmaAxWHMJDtxgKzqBHiL1k3M4IwizrWlir89XSOrWttR0D1TuKdN
         qr+Qgd/r3Hg8DtkXWABk6aJCJzCKwiciAlMW/9/RNY9q5ZEcs8qn/E5Rt/A0ROufLIqc
         hKNqbuoXm4G+arURrR4wQR3pbCz38d26+S6BQvFWIet3xE7S6CA/xWe4XQntX5ZIjHl+
         h31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736369004; x=1736973804;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOnlbWdm8MLO/mvmzUuC0fDQsKMvE3v8m4PGv6tTsVo=;
        b=l+TPpbeX/ftv9CiNUvthDnn1zJR0q8J1sgESDfokY3dCxMRL3GShUhivH1jpCw4Rja
         KQEiof4ofjJpu60FSbRujqakDyr2Q9L65QjnuJ3lBgvzGV/lq+Kl+I/GeU2tjwhmT4UR
         xQcqXi5FoEzYATBSTRAvwjrR11/S+FHvfj6Syjm/aCBDBkXBMDQo1fNOy8rikVzAEZBn
         6cvNvGcNzjcQSpI6kKki8yv16wocyXGIuN3AuRO1OBYxjOY3sSF3J3GJhwkBd8dKXZZN
         q0CFXDXt5zEsdqL7JHA8Hd7RsEMtTHyZuTTZwUg3Uai0gHII9AY+jztJmrwWkjDvL80+
         sWpA==
X-Forwarded-Encrypted: i=1; AJvYcCXwwWBucLQYL+kJMZ4t0Zgld9XoASHeaeO3rUHj6sGm3+e8GksfRDf7zGUBhGyOJwoYlhw3XC2VCD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTTBZRjZ2TD4sWsyfY9WwA4AKpLWXjP+qcqZLTLk+/i9e9hrxj
	I799M3wTRgsh4pEZ3rVcZGDmUY69OV7HmWLAbwWlih4Tr52aRscmt0HITPUD+Mw=
X-Gm-Gg: ASbGncu6wCPNAvmojYb785vmCyISjOs0c3kKZBfACTmchwhweV652BPixtR7w4MIBdT
	lLC9rPcbztl9g0o9Txp0cyDN1liyai31MRF0Xoc9hE7BLKfin2ZYDF5KkPGvHZdMrnGRv2r7uNx
	7eytkRjQrUkdFKx7mvYMK6jh3GjIl6zTNORTaiP2qkQKxTqdHJxddXLhIHJW9LqMCI7dx7Vsf9K
	Y03nuyHub3dD1caa7xbxRwjm6UJzsjyL4H/yxgF8WnA8r5/WfaPV7ckp804xsvzalCFtOovR4dV
	Dx15R5L3WXDfds21sg==
X-Google-Smtp-Source: AGHT+IHZQTydffoMLMGFSuLVu3iR+r4PZsv88PGYtk2GLXya8RF9Gf48BD4Iw9dxlWsQuyCYrVvu/g==
X-Received: by 2002:a05:6808:1a1a:b0:3eb:39f5:de8b with SMTP id 5614622812f47-3ef2eda1cf2mr2487942b6e.32.1736369003998;
        Wed, 08 Jan 2025 12:43:23 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece25014dcsm11642547b6e.26.2025.01.08.12.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 12:43:23 -0800 (PST)
Message-ID: <2c43b7a8-1005-4364-83fd-b2a06cb18a25@baylibre.com>
Date: Wed, 8 Jan 2025 14:43:22 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] iio: dac: ad3552r-common: fix ad3541/2r ranges
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-1-2dac02f04638@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-1-2dac02f04638@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix ad3541/2r voltage ranges to be as per ad3542r datasheet,
> rev. C, table 38 (page 57).
> 
> The wrong ad354xr ranges was generating erroneous Vpp output.
> 
> In more details:
> - fix wrong number of ranges, they are 5 ranges, not 6,
> - remove non-existent 0-3V range,
> - adjust order, since ad3552r_find_range() get a wrong index,
>   producing a wrong Vpp as output.
> 
> Retested all the ranges on real hardware, EVALAD3542RFMCZ:
> 
> adi,output-range-microvolt (fdt):
> <(000000) (2500000)>;   ok (Rfbx1, switch 10)
> <(000000) (5000000)>;   ok (Rfbx1, switch 10)
> <(000000) (10000000)>;  ok (Rfbx1, switch 10)
> <(-5000000) (5000000)>; ok (Rfbx2, switch +/- 5)
> <(-2500000) (7500000)>; ok (Rfbx2, switch -2.5/7.5)
> 
> Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


