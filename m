Return-Path: <linux-iio+bounces-5810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0BD8FC548
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A342829B5
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8218F2D5;
	Wed,  5 Jun 2024 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2Z2NuB/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F815E5A2;
	Wed,  5 Jun 2024 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574334; cv=none; b=IPd/rOfFpx/42uihGEw6JiMG0Qc4ZT971hRyeewv0G0+ZX6oHaqtVgxmYwTYmrMURIro9yZyuQhz3YKdvd+a2UdG7YFIOn0MSoEQYwREfRaW+vxJLW5HMSXv1wBvOT/6suyLoqRKIP/UjM5iS8ACdnDfMN6C3HNq/sj1G8RMFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574334; c=relaxed/simple;
	bh=73yx1cQiMoaF3qYtHAVqT2I1b91H0uUy1OQ4D4a3laU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EKaQ3+GvP7lM+PWVhNVfulQLtFbs/Rxd5BkaJ1ai3Dv62ydPz+4UyNaGNQ41cigrKbv9ot9ejT2L0lWJzHWSbp4eVtqTSCgP/C46qxS0EmtnFfIc1pnXJsCqmWk0I0s8tUVEVS7d+EspQVrs53wJeEsF6vL4CNu/kH/mq6OWwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2Z2NuB/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so7181036a12.1;
        Wed, 05 Jun 2024 00:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717574331; x=1718179131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73yx1cQiMoaF3qYtHAVqT2I1b91H0uUy1OQ4D4a3laU=;
        b=R2Z2NuB/peIqYx3bZsEpjm1EveS+8VNlH7emjm7R/VmJE/vqxjBeOgCAW0JBiwZXVH
         PdYjH5ShAbdI0BfpuXQjO3rzYpG5IOdJj7cQSpiJpWyMvnf45EcicZIDIRgLlDIQSgv0
         xqfwFMUt4jNBos3vtkRRnWaeq9xfGITyAgbAgFDeB7jc5Y2u5KlypmddyCeBGO7A6LIx
         eXBMZIqYqMnf6uKEEoJEKunmMHE0RyUbVCx4PKjsbn9qQwn+9xcP+Xi76+Qjv/OThR/l
         qKu3zed4O6rRYpkFBiynaKJWIm15xwBX7ZwQVjq0LENtS2oT9HwDE14xOYyaUuOBi+qK
         VAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574331; x=1718179131;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73yx1cQiMoaF3qYtHAVqT2I1b91H0uUy1OQ4D4a3laU=;
        b=sU2PmhCl4RJusBndkEdjODomKe7MU6IpIcm/ZSEr9FjTSF4wNlDV45Fc2HIpPTm8SJ
         o2HQDXOg03DoFaAZ16vlZEq4Q4FYCLp3mUqTohDBU1NDsyZTwh4UIYhDVq5XG3GEs2Y5
         /jPh3l4dWr+0NXzM6oy7icUdQSIahavIp3rSlpJxoUvdCUwUV+n9FZYyhd5KVFVTSgfx
         d+yEJJrN+oNfytPIzAuN7j4c2zpsaEwlVGXi+yN27o1Lp2PT4Cw9E72p6If+h4REbyG1
         1EIPlPZrixCw8onNEkQvAeOb0UrUKMXE/swPLfcm80eKwMk1LDGomwplLVM+BH9fjpSA
         720A==
X-Forwarded-Encrypted: i=1; AJvYcCVbA8Edxbo6Y4YbZlU1hCdDZhngEeIMtHaEU/cFKE6Ro20ulaxBGWKN5eZKjKXOzOi4/TaMgGT/U0326EwbFXxxbRcaQQLijw2bBQYvWz78thIFWFwzcVeRiyzFMpNBTuHnr36zo5OXeyQ8IVF1KvlIZwkdcJ2C4B9dRq0FDir/9YgnVg==
X-Gm-Message-State: AOJu0YwpmkBWGqZJ2W2A9bWZzX3+Ymj3LBk7GiqfQEletYxGp89C0SfJ
	141eqUwC/dKvOTbDvxxLCWafIlUHFMf1XTUqNnqA6jnYb+4f6KdE
X-Google-Smtp-Source: AGHT+IE5HjGVDVGG9Eq4BlP6A7hCYmxMt6EKZd+WC0B3dmq0mDthPNSg/6rPnAOjjBO+hRinBrQf4Q==
X-Received: by 2002:a17:906:2808:b0:a59:9b75:b90 with SMTP id a640c23a62f3a-a699f34a886mr104481466b.2.1717574331312;
        Wed, 05 Jun 2024 00:58:51 -0700 (PDT)
Received: from ?IPV6:2a02:2f08:a10a:2300:8e59:f160:bdc8:6311? ([2a02:2f08:a10a:2300:8e59:f160:bdc8:6311])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6866a69125sm692237966b.118.2024.06.05.00.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 00:58:50 -0700 (PDT)
Message-ID: <b8acfc85-b918-43e9-9bd3-d1da7e34d05d@gmail.com>
Date: Wed, 5 Jun 2024 10:58:49 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iio: adc: ad7192: Clean up dev
From: Alisa-Dariana Roman <alisadariana@gmail.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
References: <20240605075154.625123-1-alisa.roman@analog.com>
Content-Language: en-US
In-Reply-To: <20240605075154.625123-1-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello! I apologize for the messed up cover letter!

Please consider applying the commits in order!

Kind regards,
Alisa-Dariana Roman


