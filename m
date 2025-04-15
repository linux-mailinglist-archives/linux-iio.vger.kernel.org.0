Return-Path: <linux-iio+bounces-18147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA0DA8AA00
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 23:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021F9189B354
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDDE24E4C1;
	Tue, 15 Apr 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3D93o1mW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01A221DA7
	for <linux-iio@vger.kernel.org>; Tue, 15 Apr 2025 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752158; cv=none; b=KFRI/X/a4NapkQnzWmY6A8xPsnTisSwAppNFwgJjLdkHJDjy9JBBnWlRGo5JC3PruDBse6ogYF63k3de02Zityz+etrDXM/sgDKz1J7xyrXqs0E+4GffPMmFrQk7UHg4ATRWR2Xl9kq5c6g+fuofS5uVKC+ZzzojdStBky+/wRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752158; c=relaxed/simple;
	bh=sezKOxqdZwL0UPA9Nc1wZMu3XrcscN+StmeGN/bzCgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGXSsSeo0/1Nrf9KPeY4f5wN/V/AcHqi/jNVPu2+QF0BCE2oc3xa0R3V/bwsXN5d2FvbF3nvkmbRtVhfCI1FZo3oXBRqtpn43edHvmCPaS8wfpq8wR3Kj64y7ness0h5E/sHKJMZ5jLZBEV1tTbaXzgpJPncT9ggp1bP8rL8TTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3D93o1mW; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so1801434fac.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Apr 2025 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744752155; x=1745356955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lZucg4YTWzLc3CaeiVcocOFzBfkAYF6dSNq9mdvqrs=;
        b=3D93o1mWLYHF2VT6GtJXPWSMViPK5hOF2xJWfJU9zvJmiFJQEtCYdP8thD9+b0JTtD
         POmPlgi7+1/ODmgPv7LcDvr7qpkHzYRcMuhBSnDyuPyHS5kiL/igXrq7T3zqmhSGDqsv
         dF0thHsW/dYoK1Ymnz6ldRPhfMrs+PVskqMD8WDNJ4gJWG4FaeOG1O+hyGxA9bvO0Z44
         nZXnyX/Un80+wJsuwlfiM/e97YzHuARshYZfN6eg5NBCwERghUokihMAVPz/KHxnh4sb
         hm206ARnaoPgIi5QZmZLMJXqHG4Mgusksx9BGyibQWQmmQaa0Dz3iAsjGDrLqdzL8NM/
         QK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744752155; x=1745356955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lZucg4YTWzLc3CaeiVcocOFzBfkAYF6dSNq9mdvqrs=;
        b=JGxwl/b7ZO0YmXK5hhtiefNWxUBrQtGnvZz/WljNHb1Q8U2SIutYtm4bPZhf8J1NCA
         qffh6X07/LAKFaALCeEDNNTtrxwM4t/Wu1CcMZdhvNjOoVbImWcoVPa1I4op+9Yig1K1
         Eeq5AD99QTSk+eQqsDjDkZwl2ZaiuWr6yPxS8Se2Lmjxym9Ls/5P9haG7V9Th5CbeZ7q
         01vwK0IM+SMoULwuIvewricmOkm033I52gB9gR41kgezhcqfu63dA4cAJI98W//FViCH
         aDtO8SHFysOE5LV/dfDMtYaD2m12glOvzzbOxu2e8ovcPg58+h+h/ofCsnshYNB90muQ
         zZng==
X-Gm-Message-State: AOJu0YxREvHNwwRJuMO+s3MJVDsLQpVc/GuUroYdYbeAFZoMJAAFdQvl
	ofNC+YX7ht+Ner1LvK13dGYtBgWQwiMu06emy8pkdETuoNVoKilux2rZTry05+M=
X-Gm-Gg: ASbGncuHh1QhmI6uAMYC8ulywW3gozyXo7AI7KEtR5Zt7AuaVqVxgf+pOGtdlMEIe4x
	7K2jRcR3VO6ceHMsMN2gwxRJf1KptRVdJdfxkfnnN7IcZhLbNJ9ktJDopWhW3vxtgY/t36RVBct
	fIuHBA5IZ5Rkj/8f2nPf8iLslQgdL7P7n63XOnkgJm5gJCuF5m2d7XfHRo3iCnO2WTEedvFMbfV
	ekoMOwTpmRoXfYymbAALNLop3/PmAJlXUR/yva9OIwdfLhK/kZ9VAgcXtndHZooNuYHo5nLYRxj
	TPmOFj6XlK9+7hocDBrBb1dsSIBg+oUzkYi/oc/U4+7OAfTtsI8SggRd+9gr+azsFECfU7H0ldP
	/XUGWL0l/sMZrefs8bw==
X-Google-Smtp-Source: AGHT+IFDG8Sk/beG6HmPnDcmjdM56e4d71cRvdogswXByTIOWxtYfPY6H8ZVH3v0VrqRfJawQavcTQ==
X-Received: by 2002:a05:6870:ed86:b0:29e:3bea:7e67 with SMTP id 586e51a60fabf-2d4c3e2d482mr539150fac.38.1744752155259;
        Tue, 15 Apr 2025 14:22:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:87d2:86ee:7312:f611? ([2600:8803:e7e4:1d00:87d2:86ee:7312:f611])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73e4d7e2sm2573855a34.45.2025.04.15.14.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 14:22:34 -0700 (PDT)
Message-ID: <22858e4f-db8e-4c97-8551-a1934a9f2fe7@baylibre.com>
Date: Tue, 15 Apr 2025 16:22:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad4000: Avoid potential double data word read
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt1@gmail.com
References: <8f765cfd6e93fad4e755dd95d709b7bea2a388e2.1744718916.git.marcelo.schmitt@analog.com>
 <CAHp75VendQGLdpggySS3mX6M2YSeS70bvE8yg7sp_LNGDS-Scg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75VendQGLdpggySS3mX6M2YSeS70bvE8yg7sp_LNGDS-Scg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/15/25 1:02 PM, Andy Shevchenko wrote:
> On Tue, Apr 15, 2025 at 3:21 PM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
>>
>> Currently, SPI-Engine offload module always sends 32-bit data elements to
>> DMA engine. Appropriately, when set for SPI offloading, the IIO driver uses
>> 32 storagebits for IIO ADC channel buffer elements. However, setting SPI
>> transfer length according to storagebits (32-bits in case of offload) can
>> lead to unnecessarily long transfers for ADCs that are 16-bit or less
>> precision. Adjust AD4000 single-shot read to run transfers of 2 bytes when
>> that is enough to get all ADC data bits.
> 
> ...
> 
>>         xfers[1].rx_buf = &st->scan.data;
>> -       xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
>> +       xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
> 
> But wouldn't be logical to have
> 
>        xfers[1].len = BITS_TO_BYTES(chan->scan_type.realbits);
> 
> ?
> 

No, SPI expects 1, 2 or 4 bytes, never 3. If realbits is 18, we
need len = 4.

It would have to be:

	xfers[1].len = roundup_pow_of_two(BITS_TO_BYTES(chan->scan_type.realbits));

But that gets too long for 1 line, so I prefer what Marcelo wrote.

Maybe an idea for another day:

#define SPI_LEN_FOR_BITS(bits) roundup_pow_of_two(BITS_TO_BYTES(bits))

There are a couple of places in spi/ that could use this and several
iio drivers.

