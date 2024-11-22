Return-Path: <linux-iio+bounces-12493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 339B89D6127
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B887FB2160C
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 15:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50569148FE1;
	Fri, 22 Nov 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ql+z6/BF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA46A009
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288466; cv=none; b=YIlbEpqokepydGoS4pqp550m0qhL1WwxD4PopUnLk5eELkYewKHiIXnNAldhz7J9F1DbOAuj6pYmd3gI8zrvktNhb7eJxUHVknHc01ToyXJ1E8ij5GLus8fjsCk0wgk3Y1RsGshgZeFit0jRrgDotrWoZN6ldLaL4rmfPawlvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288466; c=relaxed/simple;
	bh=O52olxiNLzvwCavQPnCWKjCXgwM4DfuDJpPiYlMQjl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ef3Zk65U13CS/1bwx2Ffo6AJXSnOE+mVxRV8pOrqROXaqbmDOFepwmh9eJLy4UvGqzQ1i8EPlJ2Mj/Gu5i9b7hQ9RfxUs7dPOD7iTvLwwq4LXwAj/6zS/EViuRC4uPdRXhOX3MCbBWJA6EUxbFG0HB12GCQ9E4wTCuU256JZkwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ql+z6/BF; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e5f9712991so1223212b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 07:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732288462; x=1732893262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0kYbhDTXa5oXk2p/WNmgQ8jaLJoIT51c3/cNZ/jqLOw=;
        b=Ql+z6/BFordlYJtqI7PJwASnrsNlImP+HEW5ngrCXHk3rSrUbdNIfv3/gb0+OGSRWA
         SFXbyODgOZXd0ul+6odDaoWpVBPD9FvFEMZUW57V3whiCtmioreR2YtTcTfvRJ/hGgi+
         dBBnwzJayoB3i1/NsObLIRgObfq8qVaEUjlhPWuz37aqfEJfb1O/iLunyECCQYrepVT8
         jEEPH712V8P8Hs9q6Xh09REZpqluvttfzPMejLyafIHpcVsHb0o50txaX0Bvk8vCXGPr
         7QRSgGNE/WZazOugpv9G9HXYwHJGF9K47WNWGL30WMw9uJaFuEyZpdDwN/FH34KnXdn9
         VByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288462; x=1732893262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0kYbhDTXa5oXk2p/WNmgQ8jaLJoIT51c3/cNZ/jqLOw=;
        b=fq6uDAhJaLB/gHf0G53a7BmZEmN0nWLgcI4sTXO+Rn8qeKD8qhDjxy6pzA8ZrltMh1
         5GCo7gIf9J6XszWwhpaRXnBG64K/T/f8iQixowOEs+4DJda+iOODSmFWYxd5TNOTaNwB
         1m2eLYndLarna7Y397poanCM3LVlFtvu44r1/OG0cJVZBzN2LgmVQatmfXhfHtjJdieb
         dM23kRYx7d33OfFQj+1mArTPeQeZ9vHc87/8NlWy6SMTW/yFbL2xnLBcKB4w5HOHRKnd
         8FsDg1ilec5hu/c2R3jhef/4PKGv0UbYwZekfx2quXMCJ4dnAfd6V+Fu5J+qKDaUL1/a
         IXNw==
X-Forwarded-Encrypted: i=1; AJvYcCWbTvjUH0m5PUFOU/YrMlJe04aBgmxleONfh7aigMacvVRtNQ33Xc6IWKLNyYme1IxiKHwAZxbwt4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/lb/6CiMZeEn3ytBcVxPQt8FGBFq60U4Oy4SByLcpiSGBt8Rg
	vffV2a7Vt4BI0/IJt/nSlJ6aQpO5u4LKCySalXvk+Slxrzuevtm8NGdpWfdGGPw=
X-Gm-Gg: ASbGncvbA40kifpOWjdyYNC+rN1uNFMAD+KQRTENZlQ6EID30KXq4gLQ9SivKnww0rn
	GVCZcCH1yHnGURKaen4kAgrgmJYYmnsAV82LfQIPVP4JNocm/V5TzyEqKpWvTSusZDV3W7SaSBx
	9/9vLoOnQ0eekefdW7ZFsCTw53KqtjmvVVydt2Xi40DKryJm/6I1ZjW03kcVy1y8WaaCdD/I9vu
	eZZAcLOYZr+5OG+4pckypwqTRMGAiIpBaAz/fAGTivmInBsqMK8GCC0tz8qxJF1YibC7h1+U2Lm
	svCpHzZxTuY=
X-Google-Smtp-Source: AGHT+IHi1rbSajXISZpz552EDve4VmtmCu4DfZDFFolYonGEJ4upZPSFhBmFT5ICL+5rkfSQRI8SeA==
X-Received: by 2002:a05:6808:14cd:b0:3e3:cf8b:27b3 with SMTP id 5614622812f47-3e9158089cemr3116963b6e.10.1732288461797;
        Fri, 22 Nov 2024 07:14:21 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e914e8a3b0sm402924b6e.19.2024.11.22.07.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:14:20 -0800 (PST)
Message-ID: <afbb5d4d-8715-4544-b372-be23811eebd0@baylibre.com>
Date: Fri, 22 Nov 2024 09:14:18 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] iio: adc: ad7124: Don't create more channels
 than the driver can handle
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Dumitru Ceclan <dumitru.ceclan@analog.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-13-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241122113322.242875-13-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/22/24 5:33 AM, Uwe Kleine-König wrote:
> The ad7124-4 and ad7124-8 both support 16 channel registers and assigns
> each channel defined in dt statically such a register. While the driver
> could be a bit more clever about this, it currently isn't and specifying
> more than 16 channels yields broken behaviour. So just refuse to bind in
> this situation.

The ad7124-4 datasheet I am looking at says that it only has registers
CONFIG_0 to CONFIG_7, so do we need to limit those chips to 8 channels?
> 
> Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  drivers/iio/adc/ad7124.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 8d94bc2b1cac..5352b26bb391 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -821,6 +821,16 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
>  	if (!st->num_channels)
>  		return dev_err_probe(dev, -ENODEV, "no channel children\n");
>  
> +	/*
> +	 * The driver assigns each logical channel defined in the device tree
> +	 * statically one channel register. So only accept 16 such logical
> +	 * channels to not treat CONFIG_0 (i.e. the register following
> +	 * CHANNEL_15) as an additional channel register. The driver could be
> +	 * improved to lift this limitation.
> +	 */
> +	if (st->num_channels > AD7124_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels defined\n");
> +
>  	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
>  			    sizeof(*chan), GFP_KERNEL);
>  	if (!chan)


