Return-Path: <linux-iio+bounces-21184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC263AEFB34
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 15:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8B016D3FE
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B347E2459C7;
	Tue,  1 Jul 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wL876O+1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7906275AED
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378012; cv=none; b=byO2jsJ2s3uRQ8pzVQjP1/kNGe6ZY0zlVMjr2TCAJjkVHgxRUUXkF4fKNg/hkoESkFI5VUv425SENw5mzXN3AeaH1j47D7tL+pzDZnKjQvMq9oVfiAy/S0WBII8WDCusdMVStHVkvNVHX/xEdZFCcAevo+sbq+Kn22ZnkNGsc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378012; c=relaxed/simple;
	bh=V81NFUMfJ+mUE+a8e02h/KVMMTf6ar5ykGTXcYIsHTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLhW74Fu1A8E7Rn8SehbVPnBKgF9dBAt8dwTWAS7ux6cDeISBxPDRrIzIoPjhGdX4XXo6g+pJ64kbgbRpqBBz/9g85uF3xAR0dEhiBdY+X7pWBKfWhIi5q6jUbRgcL1Uz7ziZj3rcoe4HoRp9AGzz2SwEst1U/+jpBBZIxodAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wL876O+1; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2ea35edc691so1342648fac.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751378010; x=1751982810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxytrCpc62k1MJCjbRCCIhFdchEXxF2W+J08NfrIMAI=;
        b=wL876O+1K7JhCMvjejoMSqmfGfWuYlk5fRKorCdw3WyysrL8wbs5rHTZlErEQLvE53
         G5rPpXOqWbBv6K6bVfFdKr1rBCMlHqHWBGwNUF+4xRI3ShIFtRUeagIHzt7ZSQL0O7W5
         lCvhKnToZut1Pun68OXQx7DvU2WRl/rBCgoWrzsuGbND5IZFGQi7GQEcUba3lD2njgpT
         RVKwkFxzlVeVOmRAkMYPoiZDP5S8y8kT41A6r5Zn8Q/hjakf5bcCYuciMguCRqUw8/Y0
         A/bN/n8k+n0S+UoVxYIpu73KFvG0xXI7YMeqZMtbVb7wXXrjbt3kMCmJNTVeQUNc/fRB
         Havw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751378010; x=1751982810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxytrCpc62k1MJCjbRCCIhFdchEXxF2W+J08NfrIMAI=;
        b=TU6tylAVEpeGZ+Y+RgZgOIPsOJ5ghlgiSgACgBRVvAn+/XL+VTqRngnn/nVevfGBYM
         R8+AdKd64fgLQmsTPJo67UzLa7AaNyKKTVUUrq5IwRRkpU4b2ziOJt6hSUQUqbHHztrI
         NMTit5uwpnKGKCn3+skN+sI4hdIe1vd9FD71o9uv1cju6jMfA+8lw3X3imX72sDHwunM
         u9Qiw4Rcsq18GCICFTLrLeZSvWDIGo8DXLumlVlHYtc6BDDTHCrf0dDk6+RRXJMSfDKF
         jDFFD1ceEUeCScM1+vXyRpHbuIPm1pA7/0tZvsvbFY5Ngc/2n2rIDflvj+KxpYBCp+5H
         l7aw==
X-Forwarded-Encrypted: i=1; AJvYcCW1X3SONizRqFA6PouBw805AvBfDS0Gd65wEqVBxZVseFztarUyP4Te3VI3UAv5OiBzZK0fY/Lta9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+bcDPcpQosm7DneC+2Np/2N25GhuUL56VlyusNoNGHXqfK8r8
	SLDnBx/hApFIa3g5RaW5AJSFHYJ2xPHTcfMJQQF/ITq0e75Yq6gSh/77jR8JqwUqJq0=
X-Gm-Gg: ASbGncsfTPyU/FFvndzuar6Fz5FDwwJg3DmjjCaM1o3hMTcmp7I9cvmku4LadbuR4pF
	2fCO0aySDW7wkDCewWVrT1Pw1AiK8HmrIznNoIaNTRLw4Ch+HBhYhkbSwKMnNTl1s2REmqqAV+y
	EpjCMQgjcoSmE/NC8kzB0275ja6cC5uxg7Ct4zPwrluk5Ny7rh1XkQounYLmAZ5vdUlNoQCZjXI
	ahL8Zb5OYVqqpbc7l9gGpCakBH6ATLeJUcYHZ37LOSgFoN2Gh6CSAGys272YiCFBKElW7Rwb4ip
	qKoS8SPFR+jnyux0XR7zn5RoD+EaZCBNBb8sjhqs41oxiHR+ZMj8DcZQOpPQiHUkgOzRwiDXO+S
	oKMGb1juMk5fUP7wbjz5UJTgE6ulp+SESk1xcXoQ=
X-Google-Smtp-Source: AGHT+IEeLp6iDhItR5Y2D19m+ylI47glnT/8a7E8Ytbkuo8eMEH+v17nazXRudRC6L4a35mzZvpHEQ==
X-Received: by 2002:a05:6870:455:b0:2d6:2a40:fbe7 with SMTP id 586e51a60fabf-2efed4305a2mr12022011fac.6.1751378004996;
        Tue, 01 Jul 2025 06:53:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:86fc:b3bf:2a91:5479? ([2600:8803:e7e4:1d00:86fc:b3bf:2a91:5479])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb00c48asm2120701a34.27.2025.07.01.06.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:53:24 -0700 (PDT)
Message-ID: <ca2c719b-6798-4bb0-ab73-98d1fc5adcb1@baylibre.com>
Date: Tue, 1 Jul 2025 08:53:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] iio: accel: adxl313: add buffered FIFO watermark
 with interrupt handling
To: Lothar Rubusch <l.rubusch@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250622122937.156930-1-l.rubusch@gmail.com>
 <20250622122937.156930-4-l.rubusch@gmail.com>
 <20250628181643.0ce0ed51@jic23-huawei>
 <CAFXKEHYS2rRYtPShU-yyEetQQoo+EbCscjUUGcWdWJQA2UwiYA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAFXKEHYS2rRYtPShU-yyEetQQoo+EbCscjUUGcWdWJQA2UwiYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 2:23 AM, Lothar Rubusch wrote:
> On Sat, Jun 28, 2025 at 7:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On Sun, 22 Jun 2025 12:29:32 +0000
>> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>>
>>> Cover the following tasks:
>>> - Add scan_mask and scan_index to the IIO channel configuration. The
>>> scan_index sets up buffer usage. According to the datasheet, the ADXL313
>>> uses a 13-bit wide data field in full-resolution mode. Set the
>>> signedness, number of storage bits, and endianness accordingly.
>>>
>>> - Parse the devicetree for an optional interrupt line and configure the
>>> interrupt mapping based on its presence. If no interrupt line is
>>> specified, keep the FIFO in bypass mode as currently implemented.
>>>
>>> - Set up the interrupt handler. Add register access to detect and
>>> evaluate interrupts. Implement functions to clear status registers and
>>> reset the FIFO.
>>>
>>> - Implement FIFO watermark configuration and handling. Allow the
>>> watermark level to be set, evaluate the corresponding interrupt, read
>>> the FIFO contents, and push the data to the IIO channel.
>>>
>>> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>> Hi Lothar,
>>
> 
> Hi Jonathan, there's still one thing about this patch [PATCH v6 3/8],
> I wanted to address:
> 
>         struct mutex    lock; /* lock to protect transf_buf */
> +       u8 watermark;
>         __le16          transf_buf __aligned(IIO_DMA_MINALIGN);
> +       __le16          fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
>  };
> 
> Is this correct usage of the IIO_DMA_MINALIGN? My intention here is to
> have transf_buf and fifo_buf[...] aligned with the IIO_DMA_MINALIGN.
> 
> Sorry, I should have asked this earlier. I saw the sensor operating,
> but I'm unsure if perhaps DMA usage is setup correctly. Perhaps you
> could drop me a line of feedback here?
> 
> Best,
> L

Assuming that transf_bus and fifo_buf aren't used at the same time,
which seems unlikely, this looks correct.

As an example of what could be problematic would be if the driver
wrote to transf_buf while fifo_buf was being used for a SPI DMA
read. Then, when the DMA operation was done, it could write over
transf_buf with the old value from when the DMA operation started
because it was in the same memory cache line as fifo_buf.

