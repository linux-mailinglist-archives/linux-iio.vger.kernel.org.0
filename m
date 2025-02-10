Return-Path: <linux-iio+bounces-15299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E96A2FB13
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 21:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15797A1AD3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 20:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B0119F47E;
	Mon, 10 Feb 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I07Jfy4K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D60F26460F
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220693; cv=none; b=nj6yAfKAT4TkNRvwbnOxAzergfY5FA0fZviKgdBb+pz1Hdgr1nGXnpSe0fx1+4WGZHfJaWQl/lv8QHN6xXs67Tahdn65SMX+YlXfsFVYYnCup1WrDLN851dj64LQiebtWO58/XbrZxG3Y8to/aFOhlsu8nAua2JoUPjCsH5HkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220693; c=relaxed/simple;
	bh=9Tts8bN+Vg2rVmzEoo3WT6QiqIuEvhCfD+wFxC4C/Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcVNM5sUqxxRgFIk2lYR6LoYD+UVwTk1jfvnblwVfVL7dFkkB+hcXqsn3dKxinSGKy1BK3wj4CUILiibcgFHhxG23qjlFYyIjvfScCPyyATvx+sqNfqtoU3YUW6Uy868nYtj5lVtqEIw5329RoP1kKOkVzOHXtPXIAIVIj6Yn3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I07Jfy4K; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-726ccb2126bso1214960a34.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 12:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739220690; x=1739825490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pK7AXEk3/gHFbkZZyPXrZYFNc/hvV4Yc2BS6Eez02IA=;
        b=I07Jfy4Kjq2r6YSoOVR26jWRn+Bn8cPqLaX6uFnLJASNQNaxDP6TGtjdzbQ+H/WkbL
         nBbG6paq+YUXNhxkSVpZE9O+1wGJvJsuFfSTkn7iqlKqxAFe8zn4kuHvEss1dsDQAO+6
         27LZ4pJH5OwNK3bQuzB8APCd4MZFvyv/JOPNeoKDiToMHpeVFZ28KQ1FAuaAUClHXBAj
         jsCmwX/4x93UA1DUnJDYtnVvtc2LTnch6LrBxFj042F/Yeu2LwcoGHcjao9maqZNB/Q5
         fGC+vkOA1w5o5uNXlq8KvAh8323Ye41eSi1eIera4MMhTf0y/AX25Qm2ETlZBCNY+MFk
         Jy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739220690; x=1739825490;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pK7AXEk3/gHFbkZZyPXrZYFNc/hvV4Yc2BS6Eez02IA=;
        b=g6ZxXKDC3W+Mq4QyC3ZbEe8/2S2EpHv3t6Lsf4JKG9f3npbCbX0n19RliMyXQ0K0RJ
         9+vd5e9AVxQcAoE9eauYh2svrECJcL3G1gjprlTgeDEQ3I/5chy3qmz/+59fhDjUqQFW
         utL1TUKdR2/mpr4/iLi9xDmgaor+s/HR/uxQptMp9h5hsCL3m2SsaaNbAUufwOtl0aLi
         g0Lp7kNlPUqId/muOcMWYg2GI/rA+o7tod4oO+SUWX5uN1x1tYOSTuVPe59SXM+SXv2u
         AUQP0P98gl5WaCq27F+43flbw+gHvu+0h/vZ83QPiCEKzQjn0gtpLrI7KooFvm1yHwzK
         ZxdQ==
X-Gm-Message-State: AOJu0Yzp5aLfA5ODTehjNlz2Q2q23y57elEuf4RFJSiSve3j+cS3VFRn
	ZlXjvHbu1sE7K87FOxSF/LahVFw3boCTp2gZhwjFFFwuCztZXzuLER8OqrUlOs0=
X-Gm-Gg: ASbGncv8bVz3mzYYQIa3Obaa+O4Mv46otgRAm6Wjs6qKGGoIjB6EYgzYpPFpsTJuJsN
	PBalWfj2WYHmp8t0J7kKDdlBzBd5e2+C5+c0/nr1fUx+x3fm6voUkq0voOqOL8UTUCMVfE5Z5iQ
	b0olNHGMQa3zkK6FqAI5DsdqunHdGASUd8PDgRI9pRKMm7aTzx/1jU4yMJtJoo/b0RncHRRsiww
	7SqA18oE2vvcAmyIx+RWCos5BMZRXJdK3qSi2yCMPZ9f2QeU+iy/td4IQfAEF9w/qJxozGShfQb
	JbJk9kkI1qucSKDmT4txwvrIsHDfmVOGHEAugIp0h2L+Mtz1KccK
X-Google-Smtp-Source: AGHT+IFXJEk9MmUBU7EcXTekFZ1M/oOWVBHRM0C0GSQlAeJ7h505gqEEuTCNxJAioGvI8djE5kEKCg==
X-Received: by 2002:a05:6830:3917:b0:71d:ed5f:f181 with SMTP id 46e09a7af769-726b88957c6mr9514423a34.22.1739220690448;
        Mon, 10 Feb 2025 12:51:30 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726afa4fa41sm2598776a34.68.2025.02.10.12.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 12:51:30 -0800 (PST)
Message-ID: <425af129-f13d-44d5-8d49-c928265d635f@baylibre.com>
Date: Mon, 10 Feb 2025 14:51:29 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iio: adc: ad4695: add oversampling support
To: Trevor Gamblin <tgamblin@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250109-ad4695-oversampling-v2-0-a46ac487082c@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250109-ad4695-oversampling-v2-0-a46ac487082c@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 12:47 PM, Trevor Gamblin wrote:
> Add driver logic and documentation for the oversampling feature of the
> AD469x parts from Analog Devices. For now, this only works with offload
> support, and takes advantage of that mode's higher performance to make
> oversampling possible on multiple channels with varying sampling
> frequencies. Some significant rework of the driver had to be done in
> order to conditionally support this feature, including use of
> iio_scan_types to help determine the appropriate spi message
> configurations depending on oversampling ratio.
> 
> This series depends on David's recent SPI engine changes for adding
> offload support:
> 
> https://lore.kernel.org/all/20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com/
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

Tested-by: David Lechner <dlechner@baylibre.com>


