Return-Path: <linux-iio+bounces-24169-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFF4B59BBA
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 17:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0741C1BC2DBE
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 15:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5731A315C;
	Tue, 16 Sep 2025 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Uf9uWLSm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6023AB8F
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035301; cv=none; b=SmW473RTET2mLT+eF8wXI5dUX3XXAbzTBQG6Fb10TszD3M09MB8pNN0w/cVhG58wBPJ8rfLtylGiRsPKC63pP0OVNv4zLOr4Uk8idPdDdrIFWuk8MnrCfQFGwToBTKf3yjf6wWkJZOoTZFHTOnlXmocsdUa/VhbjX9T28KwAMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035301; c=relaxed/simple;
	bh=yMmIPhxzCHiujCLC93yUulSj03dbgF3K8hp313sB11s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxFq4cnQiJwLVHh6z0NcHAA4o025H1TL8+GWnRmPDUpo/AYOQPcbT7h3myghbe2zqT9fHRrTRa4tH0rX5JH+wFNye+G2uluQr9ja9t2Ck/qHtIa2/Avs2NYMdWxWu19mDwLevmxYC9BOb7R8mlcWElfSnqtTUF0yjC5uy4nuz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Uf9uWLSm; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-62189987b54so3117607eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758035297; x=1758640097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VyxsRgwzT4WdBEZrPds7tFrERwbS24Tu8hrZOF5hOk=;
        b=Uf9uWLSmKe5L7hqyoMxADwXupTmT/AA9LPc3Vp3GKVRw+vPO8lL6EEe735P06P9IiY
         VfGffOEH9NGKytZZkPBFdeuZoWJzft+9VG93LeJ1QQWb8bsl0792YeMtQXpxRIVm98Ma
         bxMYaXCHI3AGdxdnjWWcfFoD0g4L3A8HaylmGxvXDZCwBQ2RUpgcIqLJrmV99oH5fxAU
         wN8QoGtZywGHpyyiArtDFUUcys6Df3dmmcSDUc160gr/CX2a7pyvV+9MiPOOReM1c8Tr
         pLnWJ3L9tngf5rlah5XwyjOl42kw3hSjbhZYwlQ+gJwZkDGOtWH8eFgoPJQji+qQi1Rk
         h2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035297; x=1758640097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VyxsRgwzT4WdBEZrPds7tFrERwbS24Tu8hrZOF5hOk=;
        b=Z3Tm+Fe/3xIcygwgamHK4NsZ6gPEjL/MJsjrU2EhEIuNPdhBb1sXv64k1EOzslzwRs
         ZKp1gITeiE7ibi91bZYdqO4d2X5Q2EboTzvagcjoRar5h8BHaaGRFz3cJ5X6bAyV39Dj
         FdtV4ZGG+XQJQuZWBMCfYtINWMVUoKeMS55Cgv1cAhSARRFWenz3lG5Izh9o1cmQZDnl
         0BaeSnDfJqsTPepBO046TORm/kwFqucBObKKJsC22k+DOcl1rLlT2FUxaCVBM9dhF1LN
         Zmh5omCe29xUHPdUnuQEBEZY7Y0p1m0BoiIDC3amYa3YQILTa+2Tj7XYi0zBrkD1oxRo
         MrAA==
X-Forwarded-Encrypted: i=1; AJvYcCUde0sJd3sNNbrx3CxB8m6kWEpuiCKn3O69RnHgM3CB+fvhljk+Gd+G08ihmUJDfRn6aWNwdGCXOZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvTUMWKwDRnxwA1vsmkyHbAvw4Ehds2tl/a3L0GDEZobZP5S7
	LgjxibDSiGlROKs5S1JYoFs8HyY4o/MdXPqeL09xIy9Jsfg/ncYPUvT9spe1wV5w0YU=
X-Gm-Gg: ASbGncueGLy/W3bVUM1dJE/x68tEHE4SfWGXoYpRPJzz8sij7EbSDQaHmWrMrddQIJE
	JbShKBj9xXDYNloLLamXmMy32bEcTBeqNYLAOn5PRq/SJmv7clnblAmUg+PFjpdcBPe8YYDd2eM
	C1dKMYRxjtuL3bZvjDHaKVXhL1oP+WWJF3s7V3t6ROpaJfwH33UeB5UZQQE2SPk82x7FU5obmdB
	GOygEWQD4a26wQfgo/NG5zgw6mGDDLzbHBErhDzcAe3XnrguEGUPfLj4t+xBUiS3882RKEqtFBF
	ImKUKh9kBinEG43z7/LYpDeAr+4hJp5i0auYXXcKSeDmZ0R8JI4nefz0opzZObVekXOnksW6cWI
	SLx26ToNZkTXDQI2c7Ua7m6Osb8jd8iroC1lQIZz3vu1VezrehCh/RvJ9dQ13mF7C2fm5aKO4dg
	E=
X-Google-Smtp-Source: AGHT+IFbaLaefbFuTwBnBZB5B64hmkV14poQrqqnj/+jrHHe5Qend6k64W8dMu0a3pnSETsE0eaV5w==
X-Received: by 2002:a05:6808:159b:b0:439:adcd:9e83 with SMTP id 5614622812f47-43b8d8a279emr7619487b6e.21.1758035296903;
        Tue, 16 Sep 2025 08:08:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a1:e065:6248:ef8b? ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b828d31c0sm3270184b6e.1.2025.09.16.08.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 08:08:16 -0700 (PDT)
Message-ID: <6a1b7294-25b4-4363-87d7-2e91c9c1b157@baylibre.com>
Date: Tue, 16 Sep 2025 10:08:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com>
 <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com> <20250915211321.47865d3d@jic23-huawei>
 <c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
 <20250916090206.02f601be@jic23-huawei>
 <14d3dc56-c6cf-464a-9a57-2a7a6afe8af9@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <14d3dc56-c6cf-464a-9a57-2a7a6afe8af9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/16/25 3:14 AM, Matti Vaittinen wrote:
> On 16/09/2025 11:02, Jonathan Cameron wrote:
>> On Tue, 16 Sep 2025 07:52:07 +0300
>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>>> On 15/09/2025 23:13, Jonathan Cameron wrote:
>>>> On Mon, 15 Sep 2025 17:12:34 +0300
>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>>   
>>>>> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:
> 
>>>> --- a/drivers/iio/adc/rohm-bd79112.c
>>>> +++ b/drivers/iio/adc/rohm-bd79112.c
>>>> @@ -454,12 +454,18 @@ static int bd79112_probe(struct spi_device *spi)
>>>>           data->read_xfer[1].rx_buf = &data->read_rx;
>>>>           data->read_xfer[1].len = sizeof(data->read_rx);
>>>>           spi_message_init_with_transfers(&data->read_msg, data->read_xfer, 2);
>>>> -       devm_spi_optimize_message(dev, spi, &data->read_msg);
>>>> +       ret = devm_spi_optimize_message(dev, spi, &data->read_msg);
>>>> +       if (ret < 0)
>>>> +               return dev_err_probe(dev, ret,
>>>> +                                    "Failed to optimize SPI read message\n");
>>>>      
>>>
>>> I am not really sure under what conditions the
>>> devm_spi_optimize_message() could fail. It might be enough to print a
>>> warning and proceed, but I don't think returning is a problem either.
>>
>> No. Don't proceed on an unexpected failure whatever it is.  That's
>> storing up problems that may surface in a weird way later that is much
>> harder to debug.
> 
> Just a generic note, not disagreeing in this case.
> 
> I have had similar discussions before - and I have been on the both sides of the table. Hence, I don't have as strong stance on this as you. On some situations it is better to just try proceeding as aborting the operation brings no sane corrective actions but just reduces a device unusable.
> 
> On the other hand, as you say, usually bailing out loud and early is the best way to pinpoint the problem and get things fixed.
> 
> I still think that logging a warning should be a decent hint for someone doing the debugging.
> 
> Well, as I said, returning here is Ok for me - thanks for taking care of it! :)
> 
> Yours,
>     -- Matti

For devm_spi_optimize_message() specifically, there is no
point to continue after an error. The call of this will
just be deferred until the first SPI transfer and the same
error will happen again. If there is an error, it means there
is a programmer error and the SPI message is malformed
(or could be memory allocation failure). So better to fail
early anyway.

