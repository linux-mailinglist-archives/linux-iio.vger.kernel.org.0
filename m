Return-Path: <linux-iio+bounces-14005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE9A04DB5
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB483A4AEE
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431B3273F9;
	Tue,  7 Jan 2025 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z7HBq2nj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C619CD07
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293218; cv=none; b=Nxq47D5GBTyMkbHhDPFDxAfN0jZeg7+C8sGd0GMYU8fBm6aIOKzU7RYvbx62827W3J0dkZpJhP73OjZ2HG8Hr5Si1q0VOdfPcoFg2s+jWeS6NLmn04qmCCmd6da0j3ay+heMpjxuiPn1M/H6DNt1DiY+L1vRaH9ST/Nqx1ZgZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293218; c=relaxed/simple;
	bh=jfTpOGKr0wQcc2L8f69AZ9dp6NW5ajddeQBm1nraAXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkhOArLYe9IG+75HFu4tdMoa+Pmabfa8ZB4swt5Dc/41V2f46Hw2VPB3q5JnvTul1LwNXw3CC2hTp4uakPaTmNaSe7zA0q2eAT6IUd6VjW9mIKQSB4gUqVPfoDQEVfh+4k+Bk+cjY8tLZn5ljM/Z4fWgLfyyidaK9LQCOa8Om2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z7HBq2nj; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e1597e3b4so4681355a34.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736293214; x=1736898014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O2Eas7BrmzjhcA+ZrXqMVkpxsT7oX0umexUKB4e1IpE=;
        b=z7HBq2njBu1jHNG84Mcv87i+tp8KqdQw3ZGmC5ibgNdSVyGEHB9MoOwu3cS2kfuUmJ
         t7PZWUPj4YB0J9rv5rQ7Qy+lxJrJ49GP2iXeLiwm01tSzJe0eQkRNqofNgSXko/yrfIF
         eBmBU7H1gLB/x3ecSBPSc2IaOBk8HWbtFmUPdOPx54c+DnlXozcdspwAkH/JkYVhhlEp
         d2Yn8UdpWzLVl3lf6EMe5bUcKY0zzX//+pRQR0t41N2E/Ry2/N3PaZnldynP4C5RU2Yd
         OO6/suk3O0N+FWiW7Hs9hky8miqmeYBwRS+niZ91CiCA18Z3vwOJ6a0t22AbsJZuHDCP
         OjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293214; x=1736898014;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2Eas7BrmzjhcA+ZrXqMVkpxsT7oX0umexUKB4e1IpE=;
        b=pd3a1G7nlX+adJjHZ8qAYIoAC/OZX/rHlayMV186WU8j7M9du74uKTIDv7ZulBAQEC
         stOIoDh4iyqa+rHoeE0P2pIEikeA2l310v8/C7Gynii9rCwZlv0lpsSqjxp8yY1J70T/
         LT6gVmeS6AWMHIELxoBFIF+CmGS46bWcAVwS5Fb9F2vq4RXF5hOnpFvFYUw0rlOOnjRs
         uWXpoOyt1+1tSLr7BQJKnFD5rVPBUinNgk2XCC+b8YMo9D4CA9Wvpyb0n5eMutov2FGR
         ySLF1Su4fwntHm3Y4Bloho9Luu+JVKdHglQyFRLp2oH30d5uMiaYEQO7TS3e4BLtdqU5
         hwAw==
X-Forwarded-Encrypted: i=1; AJvYcCVMpf6RkOlq0eZsQI8ioed8ZPkbqIkOZ0m2zfOHuDMzI3A7bFQJM67JwrA3lLiJ9ru9Zhw7GOESa2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyef2itfa4Rp/pcHq2EXNXDCiiOTh2orZ0mSm4jIraQyo3A4qNT
	cuMcl1lsjhgl3QQwRtK+n72EmvKNdWOTx1eW0IclB16R7jeF6rtQkGrmlGmjNg4=
X-Gm-Gg: ASbGncv3FtMkroe5ouKH6dRBQaASAmLwJN1uFXe66bComSstf1F6m4xDuRAOWLcaMmE
	40o6kL7SD/us2uFjMQuGwu7urqnKEr78GMqsK8ipNMwQLc58f0PYyD19DPfxkNN6UWEmMDwM+Ly
	N21hu7zpWuNji1dpB0ENGOrcmAEjeTMDn/5zLccXGx8Jbz0GmlXhLdoV8C/sZdWomx6kFs33hMZ
	scmZ98sTe0uPK7zZpZ0L7IcYTgLKpfMQvTIlGC+D+igEW8YCRevhZVik/NvRfN87Mx9ZwYT7PPy
	r/RRZcY96oFuQhIyyQ==
X-Google-Smtp-Source: AGHT+IGtfDHNF/ydxld0CqCusHeQ1otA7hAtxou0jX/2OQsW5XxImqkiWOhjS8YyReikmH/jReFxKw==
X-Received: by 2002:a05:6830:61c7:b0:718:7c3:f86a with SMTP id 46e09a7af769-721e2dfcb59mr638050a34.6.1736293214168;
        Tue, 07 Jan 2025 15:40:14 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc97dc94dsm10555741a34.34.2025.01.07.15.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:40:13 -0800 (PST)
Message-ID: <4449ec60-08cd-4074-ba0b-95603864a458@baylibre.com>
Date: Tue, 7 Jan 2025 17:40:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] iio: adc: ad7768-1: set MOSI idle state to high
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <714ff48341753de0509208e3c553b19c1c43e480.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <714ff48341753de0509208e3c553b19c1c43e480.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:25 AM, Jonathan Santos wrote:
> All supported parts require that the MOSI line stays high
> while in idle.
> 
> Configure SPI controller to set MOSI idle state to high.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index c3cf04311c40..463a28d09c2e 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -574,6 +574,15 @@ static int ad7768_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> +	/*
> +	 * The ADC SDI line must be kept high when
> +	 * data is not being clocked out of the controller.
> +	 * Request the SPI controller to make MOSI idle high.
> +	 */
> +	spi->mode |= SPI_MOSI_IDLE_HIGH;
> +	ret = spi_setup(spi);
> +	if (ret < 0)
> +		return ret;
>  	st->spi = spi;
>  
>  	st->vref = devm_regulator_get(&spi->dev, "vref");

Very few SPI controllers currently have the SPI_MOSI_IDLE_HIGH capability flag
set in Linux right now (whether they actually support it or not), so this could
break existing users.

The datasheet says:

	When reading back data with CS held low, it is recommended that SDI
	idle high to prevent an accidental reset of the device where SCLK is
	free running (see the Reset section).

And the reset section says:

	When CS is held low, it is possible to provide a reset by clocking
	in a 1 followed by 63 zeros on SDI, which is the SPI resume command
	reset function used to exit power-down mode.

Since the largest xfer we do is 3 bytes before deasserting CS, I don't think
we have any risk of accidentally resetting right now.

If we ever do implement a data read of more than 64 bits without toggling CS,
then we could just set the TX data to be all 0xFF and have the same effect
without requiring the SPI controller to support SPI_MOSI_IDLE_HIGH.

