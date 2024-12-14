Return-Path: <linux-iio+bounces-13480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DE39F20AC
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 21:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB7E188561C
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A91AF0A7;
	Sat, 14 Dec 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tB6w25kT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745316419
	for <linux-iio@vger.kernel.org>; Sat, 14 Dec 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734207852; cv=none; b=DYJon242Icm2U3UzwKofOCtGjXNqPgl05IWwXAE+9dzKSoYlr2IaeH24GjqB9PmwHlY875I/DASx/4v4XF2fAvUbOIeyFNCJ9FAthbWa7Lqapg0rT9YDtRUdAzTnULaWNkukBD53jFqDnb1JGpW+Ig1l1QMphhNdJmHHoB3Tcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734207852; c=relaxed/simple;
	bh=zofDod8j+ztP7THAIYRKQRjOLssFMAflJyxP2FRPQZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lw3XFG8vApeZJHQ2SqDobuj222zA4iOY1B2Hae7myk9PFqhTIePvbzc8Ed7zwgpemfCowGtBNvAvXZBunE1+Ixgie9JZaJQnJduNkl+MW6dP8hE6WWPPc14eusaUFVMlaHu9eCukEo++Qt7wjQdiIbzi6OgOaIXb+XTenJUbqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tB6w25kT; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-29fe7ff65e6so889358fac.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Dec 2024 12:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734207848; x=1734812648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrkjOPWzOWxIOLJtRQcSvC8VCKadtMcoPJW8JEroxUE=;
        b=tB6w25kTXyEjVAJFv7LAnx5MscDaMuvhklAmSGFOW4xfo8yQZ9FINMBXbbvVDRaBOH
         lwI/v4RadsGLa0mTjYJfh3k8KUH3zOeryJQRe0h3K27bjNByC6QnxhI5zpjP77q04vf9
         bQaBg7v4ZfL80G0i0UnIlyNo/SIJ7QTsrnHa1mEnfDyyW0awlkV5qb5/7twwfdvIODs8
         4iP7xpDQzsix29evUgtAOwglu/+6In149R8uohTR939rzBXduR+K+jXsOZ+yHWv4qQVH
         SwIvTmBxiPMWbyqCRFRFBZ7K/1sisUgyb+g+/pEruuWxyX+Ka+wIPAf7084JujWwGoRD
         T5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734207848; x=1734812648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrkjOPWzOWxIOLJtRQcSvC8VCKadtMcoPJW8JEroxUE=;
        b=wpAzDHtmh5saq6R4z/TYC3FimbCzmk7ovMlZgx8YWENb8VVHiYXVHsWsdtuSVn0M9m
         2diCS79LRLpgWFkP4KIlk5wuQBKuuIb9+9EL+P3+F0zeYyWkSecujBjELqQeU6yPvgbe
         iGTEe7VgN4+iCzGX9DSKaFSVrz+YU6bOp3XmhLsi0l95a5QSPy6BCCr5Cyq+9n1YVdzl
         ARopIGz86pqsxTYjrlviXy+LXpc5Rf5LR9ezsNZyKLCHpvlQIrjOU5OgW4/6JAekEtiP
         PBvuWh3bY2dS82RtvzpeXFJeL77wT4rhHJFD2lghUMTdTaL1irnqRSmkTn1MEilE+eKD
         EYRA==
X-Forwarded-Encrypted: i=1; AJvYcCXJMSeebkPIS11346VYyr46xvyE6a35Pid02+DC1tkd9em7H0rLF8Ej8Kf2+0BsvICJa0carlGneqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz00o1R1SiJtK36fckHMHxyx/clCYN+b2z+qnoQcscUTvuwi8Rv
	tSPc11vcPvfr3hvCTkxIglZZuoT/njM2+U1xAEDpXSIt4Hqr/iKh96Tjk4cBh0Q=
X-Gm-Gg: ASbGnctH1ewxmOO9zQ6kOwdkskVwunCA6pTfcdqUDCLr1hNvJzfWYggh6z/8JMa6ypd
	6D9zlYx84w4ozc+ssdha9KY4DWmsohN/LYTPZGKeoBIDvSZlNTiJZ/iqsCm6HARuJHf/fv8ixXU
	2Qc0lM8EULTrjueNIsJqUaIshXVXLrD2F4FhpLrCaHZq9Tx06KAOrDckRfWxU0eaAdoKvucVUQ/
	/u4HZX1aMKDqa1Pp9VNUoRnmWvQBSlM77fodJxR5zveQ4KrbH7ko50hB5G8K6t9oPc+eRdcF/fF
	h2dgcEowkm2pSgbc4w==
X-Google-Smtp-Source: AGHT+IEzwHeZTPoi4etfNnGZeXD/roCPhCaM/ndaTdf2HRFNxeHbdaDaBvyiEJyZScfzW8J+9PK8yQ==
X-Received: by 2002:a05:6870:15ca:b0:29e:43ce:a172 with SMTP id 586e51a60fabf-2a3ac867f5amr3376165fac.28.1734207848013;
        Sat, 14 Dec 2024 12:24:08 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d2541725sm724169fac.12.2024.12.14.12.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 12:24:07 -0800 (PST)
Message-ID: <ebd71e3d-1902-402b-a84e-819b0976ba4b@baylibre.com>
Date: Sat, 14 Dec 2024 14:24:05 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: dac: ad5791: ldac gpio is active low
To: ahaslam@baylibre.com, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241106103824.579292-1-ahaslam@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241106103824.579292-1-ahaslam@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 4:38 AM, ahaslam@baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> On the example, the ldac gpio is flagged as active high, when in reality
> its an active low gpio. Fix the example by using the active low flag for
> the ldac gpio.
> 
> Fixes: baaa92d284d5 ("dt-bindings: iio: dac: ad5791: Add optional reset, clr and ldac gpios")
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> index 79cb4b78a88a..2bd89e0aa46b 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> @@ -91,7 +91,7 @@ examples:
>              vrefn-supply = <&dac_vrefn>;
>              reset-gpios = <&gpio_bd 16 GPIO_ACTIVE_LOW>;
>              clear-gpios = <&gpio_bd 17 GPIO_ACTIVE_LOW>;
> -            ldac-gpios = <&gpio_bd 18 GPIO_ACTIVE_HIGH>;
> +            ldac-gpios = <&gpio_bd 18 GPIO_ACTIVE_LOW>;
>          };
>      };
>  ...

Hi Jonathan, any reason this one didn't get picked up yet?

