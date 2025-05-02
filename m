Return-Path: <linux-iio+bounces-19008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96B3AA793E
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 20:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF85188D7E6
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39F1BD517;
	Fri,  2 May 2025 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7yforOH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0941AAC;
	Fri,  2 May 2025 18:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210151; cv=none; b=Srm59kgofNwqKnWf+XNxdw6kD8qJsnaE2kGsr58LHI4a5MgL9O+bSYhrzMb2b1LIc90okCWrfGd/pIj6GMvwH8I3vcOX+A7QM9cX3IF2Ks2dbJrsoFCxoQpzDZr07m0SkebXL+CKSV3Gk8H8KZ3ip1iEGgmPXP+iE8si2LWSwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210151; c=relaxed/simple;
	bh=6J7/uRIuLsGRl3+yn6EaUPLpqCsoENhZNpl6V9Vmzk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aY4HzA63O8ym54QRknOnkmYMaD0gAr7wyyQOXrHItH21QUIrAzpqbi9NqzBDFDkV6/JxlqiZvV9ftKFY969NJwkCPw18TYAh1lUsqW84TKjfNqaLWrStVterx2thrQEs38AD1PajBiGDAQRWstKfS3mWHxmY3LlVhW4V1gEyF/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7yforOH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-acbb48bad09so410503066b.0;
        Fri, 02 May 2025 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746210146; x=1746814946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6J7/uRIuLsGRl3+yn6EaUPLpqCsoENhZNpl6V9Vmzk4=;
        b=L7yforOHZl57lLjL4jjUtHZwmTBa9RtIFtojEilq74tZd9eUvDqDmsjpLpEyIsdMsR
         xmknZ79XxPU+XzKbaH2Q6NR1NvEyXaI5vWNIDwZvMg/CvFx8qyZ5bGEF8Yf7OyizWpkI
         xijYrtPlFN1WYMTxnycGZlnqt1fNvPnODoTa3HqEsCCr8o+WMNSjwr/U757oxpVoE7/0
         JmpcatbZersdYCZNVNqr5mbaMwxF4XKBFcmpmLG7glAaNr+1qZE5ulvhXX+JSSGJxGty
         UgZOjER6KF1Vkk56AD2Z2HwIGPT89PIUelpIz6aUwftqNW1l4FCoE688t/8S8mkHigc1
         CBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746210146; x=1746814946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6J7/uRIuLsGRl3+yn6EaUPLpqCsoENhZNpl6V9Vmzk4=;
        b=XYyS1l/zT01KKwEPVOq83+YDEfNv1KmFCGqVOcIm9r31uZ0Pb0snEcQeqoEnuFB917
         3xl1gbQYQBv3egz2xiqvNUKwG+gxZ2gOdEgw5KS/U05Hhs4jmjAt45saN0WsvuJLC0LI
         ceUXE1NSPJ5AyRF/8KcVBS/Dk4BrJbb8FtY9V6FTZ2ChhqgaS8WCUGnlphZa4PgcdT3b
         QPyVJaPHL7WjRd7xxpl0RXJxKAlPDxq2P6HCeDggqnUWSnyh5qUg/mfr5p/X2hyIyy7M
         tUmjHDjFc9djexFX6ItJLkMEBZABqblW0EErKjrlz1nFkXRS+WwWe5NqffJ5tDs7UU10
         PbVw==
X-Forwarded-Encrypted: i=1; AJvYcCVJBMQYKAakXGkX+iYk8EuroBDdtBN4r12WxvdNxNYaVv4lqFeKESMYg4rVMTZDUbeeQbuUKAVKt1fhD/qG@vger.kernel.org, AJvYcCXA0GW2cMFMzVx8l38B/mSKBsKq/vNN4KV27zSzPxEBbbIsvUPJwZ6IFs9SzYKnNHXTmGtHHhojXpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh350Ei+QlzbcEJBJfUMU3+wM3PGA1BGUJ6F6bm8zKZqZzCh77
	OMNO2SWK4EQKpyYh7TwMt+yUkpOVYHCPKJ9YkviL/HkbXlnG84h55bKEmQ86JDe3U6JizBMqxb7
	E29S3B+fvbMjWJgDRWpLPmwFMECjjibxC
X-Gm-Gg: ASbGncshjvt9G2xGSMOej/mjN/evJ93/V57PoGj/201fkDbckHMjUWCmYlWY7Ob+KNx
	YKFq0g9eK2vzRolhlvu9I9Zq9pm9vIrTwgKzGakksXb0UyYR0ntwM82tw+hJ9N+KdLEM2wMPXT2
	e8FhTnUSm87jY9Vhyz+7AwgA==
X-Google-Smtp-Source: AGHT+IEAoGMcKAG453+qDN/enhkMBwUIrSB02oOrWBQTElxchm0fov7SknM8MCfXmwipvwvMTuTBtfswcPOhsEjhiSc=
X-Received: by 2002:a17:907:1c1b:b0:ac7:ed72:3426 with SMTP id
 a640c23a62f3a-ad17aefb38fmr392003666b.40.1746210145422; Fri, 02 May 2025
 11:22:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-iio-adc-ad7606_spi-fix-offload-scan-mask-check-v2-1-e70c6d71baa3@baylibre.com>
In-Reply-To: <20250502-iio-adc-ad7606_spi-fix-offload-scan-mask-check-v2-1-e70c6d71baa3@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 2 May 2025 21:21:49 +0300
X-Gm-Features: ATxdqUFLPd4jdoc55Mq5GSKJPyX2j1AIDOCJP2PIvDaL4AY2JKzpIjlMSVOEmYw
Message-ID: <CAHp75VdtoxGu1qv7i6uhuPhAeVF7OUF3d5trxqcmupC+ZeAf0A@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7606_spi: add offload scan mask check
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 6:42=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> Validate the scan mask when SPI offloading is being used.
>
> Since this family of ADCs is simultaneous sampling, there isn't a way
> to selectively disable channels when reading sample data. (Technically,
> AD7616 has a sequencer so could have some control, but that is for

so it could

> another day).
>
> For "regular" IIO triggered buffer reads, this isn't a problem and the
> IIO core will demux the data and ignore data from disabled channels.
> However, since SPI offloading is done completely in hardware, we don't
> have a way to do the same. So before this patch, if less than all
> channels were enabled, the data would be misplaced in the buffer.
>
> By adding a check in update_scan_mode, we can fail to enable the buffer
> instead of having bad data returned to userspace.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

