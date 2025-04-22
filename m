Return-Path: <linux-iio+bounces-18549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD884A97A99
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A685F3B70A5
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB32BE7A7;
	Tue, 22 Apr 2025 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gTCInamR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546C199252
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745361667; cv=none; b=giOLnqgyR8G9kd2b+qZClvp/wYztZ57TUWYCa6XxibQ6gATjE+cAgi/koGnbiWNcSVnG1gzlDq91CV4a/ergpjn+eSM2zznP44tHTBGpV11pZj0sbfsSjHZA+b1NIZ57jxsXkex2LtnhFMIz+QcaPMM4BM9UuBQXDfS7pBJstyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745361667; c=relaxed/simple;
	bh=RqxLodFgI+dJq1TKkyD+2Vyi4Zeq4ASQHoFqzh/gDgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6tga+kocnVFl+Sqy16yEGA2lm8Q7Y/0KU4maEG9xj69FmHDS6yMneHQIWOJ9d3eBqRnFN75Xitju8XIddSZDXhy1wqLYvq3SSJk8ZBw1L2g9+/964BpgGBNUhM16KCiw4sc3Pz3sGmu6lQ0ZJVq9idCBzxdTcahEFRhHKnDNBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gTCInamR; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c14235af3so3775611a34.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 15:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745361665; x=1745966465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0CU2BZNsdQalnMnKvhf/1pSUDKAtqWXZYwURN0vGgLo=;
        b=gTCInamRFsSJGbLdczgyvxDB2FDHeuX/np4uI/SFzHwmnuByicD/0QIIagJJCf02e0
         Ew49zUS4X29cnv01NeajtlGaVUzR7OrpCOzqU61szFgi6BKMcsnPpzooPuhWOuzD4rbs
         XVU2IItXjCBFO5eyAmfnuW8GzZpgx3qWY6Uiw4r2bGerFy+TacJrP6K+dt8vjqkdH3Mr
         MpVh3DhDdXLCfgZnD7VOZ9p0zo89YDomo1CZN7UptvzGv3bE1gqJxtsX5llz4Wg2ajHQ
         5MxGYYgU7RapmE0kZ5AXw3P9ik3ra5VYdM3kSnpgaF3CKKv+q2qRvHTCspAVkYq2JObq
         iLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745361665; x=1745966465;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0CU2BZNsdQalnMnKvhf/1pSUDKAtqWXZYwURN0vGgLo=;
        b=J00FxX67OvzYG2j213N46vR3cRtj+dP708c4pwqD3VlF7aLASLHDqxwZDK8XWK10WP
         FHDcXYIZ9CJYtI35KKzqMvmbv+/gOoR2zvxmExv8NN3gC/vBxUXLfVOefqexHlCqpIi8
         rOuD/2QGUXRBuTW4T1JDDk/zxrCts+xSEp43Q/shTwXEIym1j6AbhZ0dGuEptNeSFkIi
         HBjl35bOOaLR+Grw3UMZB51/ZooiqJiDcdrI0EIMDKKV/Kq/rFO6vWiGCHMcJf9qkesz
         P6SbPwsAogY1969OdR1F2v/3WoJcWk6SmkWo6nlcs95k7RrZvxP21Qi8W7qH7FVqINjA
         yLoA==
X-Forwarded-Encrypted: i=1; AJvYcCUFyftjTV1GtAVuq6eNnr46+o2f66xBE34VdwGXl5Yu+MDhi1mXhezD3Qpinr0REugzlB+WZ9Im9lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8k4yCYNOFkHj30vHWIKDriEXcgupYCYgDBqgRFyogBpYGJIrN
	/ZHT3i5krJ2xQ4Q2C+1YocDe6xhKGEiN7g2f9fSZd7LrlNbAH+oSN874HvoiHrs=
X-Gm-Gg: ASbGncsTvA9IN371vHIgiKwmTlUG2kWnZqWh0qv7F36b9zSHCO1yD/8l8TdHAh67vlm
	lYd4mg3tBJ18TBXYBKt46UY+q/x/k9HPpZFEjoscaIaf8o9oo0w64BC3BIWi5EThT+r5oBR524h
	os6dqbfzvr7MdDOja7l/yJvueTXTl8/dD/+A4F/le5UYWmn58Q3R0RSuxQpkN/ZjIOTGUpOiLAQ
	s9ao7U9fxGA0HD6F0EyMJzD0349mIjDWkC8yzk9NNOj6l/ZLs4/pjGUPlE3k0Bd2lrYa/Pja2y+
	6US69npwykx6n1ByfvbHmP+UsCnIAVBtdXxK2oxQFR3mbi8i7XaEMISIl2KKbMfz57F8X6y+nV2
	IOfMh3e1j+jbCxNe7oA==
X-Google-Smtp-Source: AGHT+IFW74VOQ4Vg2SYdWLa32CZpVY1sP9GeRo1HKg02wFCgKoCAWSnBjBlMYWitwOZHz2q8mjOBeA==
X-Received: by 2002:a05:6830:6288:b0:72b:823c:8f66 with SMTP id 46e09a7af769-7300621472cmr10397261a34.9.1745361665013;
        Tue, 22 Apr 2025 15:41:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3? ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489a8b6sm2176057a34.58.2025.04.22.15.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 15:41:04 -0700 (PDT)
Message-ID: <55f8a997-77e7-4d07-aec2-8d20f56314d0@baylibre.com>
Date: Tue, 22 Apr 2025 17:41:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] iio: adc: ad7380: use IIO_DECLARE_BUFFER_WITH_TS
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
 <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-4-3fd36475c706@baylibre.com>
 <CAHp75VdqanGpwB5raE8AmH-Tmb82N9yYmhB+k_rQtc2_Zb8HQw@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CAHp75VdqanGpwB5raE8AmH-Tmb82N9yYmhB+k_rQtc2_Zb8HQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/25 5:33 PM, Andy Shevchenko wrote:
> On Wed, Apr 23, 2025 at 1:08 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
>> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
>> and understand.
> 
> ...
> 
>> +       IIO_DECLARE_BUFFER_WITH_TS(u8, scan_data, MAX_NUM_CHANNELS * sizeof(u32))
> 
> Btw, why not DECLARE_IIO_...() as other DECLARE_*() look like?

IMHO, namespace should always go first and people who write DECLARE_NS_... are
doing it wrong. :-)

There is not existing DECLARE_IIO_ to match anyway.

> 
>> +               __aligned(IIO_DMA_MINALIGN);
> 
> Forgot to drop and use the DMA variant?
> 

oops!

