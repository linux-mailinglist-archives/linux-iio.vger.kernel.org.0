Return-Path: <linux-iio+bounces-23485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F5FB3CE7D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C501B25C41
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2062D661C;
	Sat, 30 Aug 2025 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d4kFHbRn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86621772A
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756576953; cv=none; b=tyYhv2dBaqtAMfxy3c0osu76fRJ9zZK5UPD7vlMkePGw+mlBRBPyMvwLT8E6LXa66KvKA5q+ZDntUlqP/cIyThZeDonijMal+na2MAAcpAh1JBwiKuhbvNKOkLnpK2jECTSJEcjvfUd/sxui2yh2cBYai+C5mBANkHCaHf/BznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756576953; c=relaxed/simple;
	bh=LL1hd9q8LJpTq1VIPJ6jPwhtJlsQGlDix5UjkykB4Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6ymWSbd6m+7Bbs/7kaWCDa+krlNVXx1srhZz3OHdM+tOrCfb6sWhAPjGuCElOo5fiTF8EXmLmNQ+YU4clRGHXFVOSJQdRGgZFXYrJ8egoBw71rWokYGnRXw1vYTzfgLeE5p/ZubjfOjVHSQloGQMADB0gVR/Ll+kz/hzuO5lDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d4kFHbRn; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-315a0b68314so2627890fac.0
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756576950; x=1757181750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PD2EKFpAobF4U0TIuLMjpEcO1H/Nnyn+f8Dfu+DnkNI=;
        b=d4kFHbRnKQoKXBWL1zWyAwAs9XrZhybRacslpYsfOE/8svlNjSAa8Db/NCLXxiJRfA
         J2QD4/foHnDmHwjuCSsOjuJdbemw7PsoCS5Uu6HXPTYCRCgcgnVvheVSKQyQpip6/XBP
         MXz5Fm4B1McmU3Wff8PnTJzziO8LqKydzV6W7lgjTSLztkWWi8KoF8jJh5zTod8q8sIa
         wdfUEv0LJL8woK7iGwOs86dgFktN/7oUDsaxpR4w8skkPSaKoxIEI7ZTIEdD0ImcJ/2B
         NNHGtdWgXgCxV140u8AZQooK2BGzWxAuHzVH5fzMh7d38ELATTJP4PjnOCL/xLmLDsBH
         4Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756576950; x=1757181750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD2EKFpAobF4U0TIuLMjpEcO1H/Nnyn+f8Dfu+DnkNI=;
        b=UYX+Bw4qB3++Z3UjUS27QMcua4n1jURTq8VVHQZP88/hMhVPfiu2YflywyJWlO2Qo2
         MIZDbg1fHLJRuUB+UXOlRuF+xWyY+yQ1ueAA0PU1uuglGIbrNS4rKM2QKJERDUdOxjQt
         afsPfyw2H+opl9n6s+idxLSRdbuckzIWnul82QBKuob4Tpm7HrpNvIU1hgJ7r94MmrLM
         vT43HKuuu/lXMKJtAkWfewAUHIJZsiTVRxybRCAp/STLO5afkRWbyrpnJtRp/eTiGCxT
         neD7pCfibaMPA8z5sRu9qW6G9bYOLSH/+LxTf73fz2acDQoQOANF1SIB19CozJ3R1khK
         IxtA==
X-Forwarded-Encrypted: i=1; AJvYcCVEYCNQAUnbpWWv+NqBAhKPs6fOz0sFfNA3SYfoOu6P2AQqWKsFOlsAbYX4zFQEuvyHHbOYe8r648Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQ37MD12ytw3mM5KPOK0DCFB+zuVDZLpWecL3IBzQtyo96M6D
	m6Regls8apNDOTmPNJ2euAIWz5iRMy/xFcBk5AiXNHSkrJy5rBgV6y0E1RJy7/Dk9vzwE6VE4Kz
	REvx4
X-Gm-Gg: ASbGncsHJnrXf7aQV1/jG0Cwli+ntvibePmtGcftwKK7vqOC87gxh3r8CA6kv2pjMGB
	Zd9pwF7yucnFYTcAtpa75ie6Os7u/+ThqG/hZ4YE34ZhWj2gGnSDkT3d/aKkBl5wSt7p5/Hc73S
	83KoHLdXdmNGNVIveGQ2V1BGSdh0oCD9d+9VDLntI9e1SfQ1TH1IGoXkVts3IP2Cj5LUmnJIuCB
	mCKcKxMTMLMec+9d1g9cSdtH5zbFGhJUp5llFBZRjPSTMDbkh+JAfZPxzXMo76JApZaAq6OO5AP
	iFtbUcDIkOc5fEqqnKGaNRTPiNEXZEIQDSsEf53rb7GzhrROlNZ/Va54XZ5ybS9+3N3ItobVrIG
	qltRd2xXzObtI3TJw3EkcgMkdlXueWEY9yZkXkjV/Sz9xOyOJ6xdzFYWzy5wclBbnmtdJ+yVwhC
	bR1Looo1YODw==
X-Google-Smtp-Source: AGHT+IGSJvFvC9dcmKaGf9glwESPFKs7sboRW3GSWHC52Tz6jlzKsP6xrkD7Hc7UHEkT8qvw/3aY5Q==
X-Received: by 2002:a05:6870:c0d:b0:315:b768:bd23 with SMTP id 586e51a60fabf-319633c79a1mr1298016fac.34.1756576949951;
        Sat, 30 Aug 2025 11:02:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d? ([2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3196d2a7f3csm392769fac.8.2025.08.30.11.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 11:02:29 -0700 (PDT)
Message-ID: <033e8639-67db-4397-b8c1-d1b7774eb9fe@baylibre.com>
Date: Sat, 30 Aug 2025 13:02:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] dt-bindings: iio: adc: adi,ad4030: Add
 adi,clock-mode
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
 ahaslam@baylibre.com, sergiu.cuciurean@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <1acb071f7140c9d44ed616a9eaea00b0ee423164.1756511030.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1acb071f7140c9d44ed616a9eaea00b0ee423164.1756511030.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 7:43 PM, Marcelo Schmitt wrote:
> AD4030 and similar designs support three different options for the clock
> that frames ADC output data. Each option implies a different hardware
> configuration for reading ADC data. Document AD4030 clock mode options.
> 
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4030.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index bee85087a7b2..1e4e025b835f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -78,6 +78,18 @@ properties:
>    interrupt-names:
>      const: busy
>  
> +  adi,clock-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ spi, echo, host ]
> +    default: spi
> +    description:
> +      Describes how the clock that frames ADC data output is setup.
> +      spi  - Spi-compatible. Normal SPI operation clocking.
> +      echo - Echo-clock. Synchronous clock echoing to ease timing requirements
> +             when using isolation on the digital interface.
> +      host - Host. The Host clock mode uses an internal oscillator to clock out
> +             the data bits. In this mode, the spi controller is not driving SCLK.
> +
>  required:
>    - compatible
>    - reg

I think this would make sense as a common property in spi-peripheral-props.yaml
as this is something that is not specific to just this ADC and also requires
a supporting SPI controller with the matching wiring.

I would also tweak the names and descriptions a bit to describe how it is wired
rather than how it is used.

  spi-sclk-source:
    enum: [ controller, echo, peripheral ]
    default: controller
    description: |
      Indicates how the SCLK is wired.
      controller: The SCLK line is driven by the controller (typical SPI bus).
      echo: The SCLK line is driven by the controller and the peripheral echos
        the clock back to an input on the controller on a second line.
      peripheral: The SCLK line from the controller is not connected to the
        peripheral and an independent clock output driven by the peripheral is
        connected to an input on the controller.



