Return-Path: <linux-iio+bounces-10151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8539E991091
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 22:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6FBD1C22F7E
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897D231C96;
	Fri,  4 Oct 2024 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IEpU7hOs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A5231C8C
	for <linux-iio@vger.kernel.org>; Fri,  4 Oct 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073641; cv=none; b=Vihn/JktTjmaGAz1DpJXIcuHCUVMxTvuDKuO/b9QuBFpiSRVK+PU6BfFN1UUYQAFEricowKa653XEmyIBOKaEc6LWGdaeet4n3RqJq/IHO0Ewr+US3lGjwIT2w+/bEFfgMoKJimG63fRIdbPP9WsYD59/OsBTv0TK8Z+Q+DrqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073641; c=relaxed/simple;
	bh=87zyUbMDCvZYIboVQ9XiY5te2PMtHviTll9I3vRMnwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMUcKdSY3GAhLsDsxuC1yIzvIIZq/BPtf2PK6Az0SgedNV7uKwLdyDDHsLxkBHv5o/6EfQpp10vIaMVshrD4DaD5I8EUZhm4pemXiOYumGLWTAQuJ3ygFFe31JtCJIvRfO9i5BtY6shmV4DGJzhkbOrFr+0v2XGUoTo8ufBXKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IEpU7hOs; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-710d5d9aac1so1233685a34.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Oct 2024 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728073637; x=1728678437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0lkN+owePYzX9OUPqu1bePV5kRPtGDKpTuT6etmjHWc=;
        b=IEpU7hOsFumSdrkbY/b7VbPNm8Za86mfRyAhG0Kj0zePgEh2H6rwtbxaMg2C43hU5m
         H3ZCx+vb/tiQLz5v/8cxVZs/cB5jkJ83qph1rmQq+x5LLZpOrMVipdboc7C5/fzsNHFH
         4jPCaCLF7myyRLPHG9uzQGJAJXghenomW4XuUCax0CbLRO85Ct4CV8g1w8S9jkkb5xjY
         Q+hY+BFEyMQaNh2bM1Vm6egAlfCW4rw//1jYuZoLRBdK3tdmksB50EVvFwR4Yl51WYit
         FtsU9D46KXmQwCFxJ+SI9nNGRunG/XC5DObRJB2ZpN5zWUILBYrN40V4Kvlu6hJUGag+
         nkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728073637; x=1728678437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lkN+owePYzX9OUPqu1bePV5kRPtGDKpTuT6etmjHWc=;
        b=uYGgvPG1vdqm3fjq24UCR/4Gq2LEXL6133JlWVOqV/JS9aUg5uokES7qIvlQboSiQk
         U0kh7Uer+yogaIB3+A25wr2b20vmExgg+geBUPQjDvnOowofKv28+jlzjWkjJeJP+zvS
         NizTVIrXgkniGZwturYI6J4uxrjuxrTGNW+UanOwtsW5sRg6WqZrVqIYmIE2tiHNzlxT
         ZLQEmWqeovQKBJFcDfkf5NVp8cCtpG41diDigoAfMYAlEzI0/Y1674LZjmjfetvG2Q+P
         flKhSsDJR4ePTtr5BXF5MjhzQEudubhPXxc7s4OrGTmVVHsvCwtaY6pUXpoOTOeLaKWI
         EfKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj1Kz1Ooi9p7RIvpohgs6N9OIsOhBHWPc+L5lAsewTWTWm0L/0PE3vkCqWwLP0iDJJsJBUQ3RH7GA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9fwBN1SxvPPtr20pB6ac90LD7LIrbcqj4ef8C+hCwHBVWQuaO
	1PSsczvjvYg9VNoLfbWpPd8X0//WQ7Gq6rk/+oiCOONIMMLrHIciQr7SqVDnnho=
X-Google-Smtp-Source: AGHT+IF38+AB8lQEzZFWow7y7JkOMI+37u5HHOA5yhKxOY45jtr3wcA+I3RYof+fxU0yKggg1RIz2A==
X-Received: by 2002:a05:6830:4107:b0:70f:36ff:ed09 with SMTP id 46e09a7af769-7154e982ceemr3038335a34.28.1728073637198;
        Fri, 04 Oct 2024 13:27:17 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7155686d999sm166514a34.75.2024.10.04.13.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 13:27:16 -0700 (PDT)
Message-ID: <f4cc471a-b602-48d8-8323-15efcd602814@baylibre.com>
Date: Fri, 4 Oct 2024 15:27:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cleanup: add conditional guard helper
To: Dan Williams <dan.j.williams@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-cxl@vger.kernel.org, fabio.maria.de.francesco@linux.intel.com
References: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
 <20241001-cleanup-if_not_cond_guard-v1-1-7753810b0f7a@baylibre.com>
 <67002737aad27_10a0a29425@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <67002737aad27_10a0a29425@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 12:34 PM, Dan Williams wrote:
> [ add Fabio ]
> 
> David Lechner wrote:
>> Add a new if_not_cond_guard() macro to cleanup.h for handling
>> conditional guards such as mutext_trylock().
>>
>> This is more ergonomic than scoped_cond_guard() for most use cases.
>> Instead of hiding the error handling statement in the macro args, it
>> works like a normal if statement and allow the error path to be indented
>> while the normal code flow path is not indented. And it avoid unwanted
>> side-effect from hidden for loop in scoped_cond_guard().
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> Hi David,
> 
> When you update this to the if_not_guard() name can you also add Fabio as a
> co-developer? His work [1] contributed to eliciting the response from Linus,
> and then this patch takes the novel additional step to create an "if ()" macro.
> 
> Thanks for pushing this forward!
> 
> [1]: http://lore.kernel.org/20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com

Sure, I didn't dig deep enough to find that patch, but basically
the same idea. :-)



