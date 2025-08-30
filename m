Return-Path: <linux-iio+bounces-23496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4137B3CED5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 20:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A0B189C14E
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE002DAFA4;
	Sat, 30 Aug 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q+A+ZUAn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8962D9EE7
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579520; cv=none; b=SRfhAXqZWOF0WuqTuhVopYMqxhK10VQCAsqVAUkBS7huWFlnsS1AonhzEBRZ9pG3dejzIGabF0s1TDcFj3Zfa6ouMAyg9L+7Fem2LsoV1daHeAXMzc9GS14vSSulXxGDIx7LF6NXnnM5hTXHe3wlQtLC4iW0jwdl0QGaNPJDNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579520; c=relaxed/simple;
	bh=A6/ow0zfZVWRQiTl9Wxuq88PZFNMRCn7+IJy+ae1z5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuFOUjfxESTMxTVhk4i7DeKFbatByfgJIJwUBvOmpxoeIQ+hkBBOKPQrRf+N7mqW57hSwxvRqNQPJ6TJ/mPtEHNqLb4AgBCyvVmR2jl8Ssy70nHqMGtNJxI4JSggsVZ90Ab616PIK/qCtip7yCskx/1QWWp0z7A/JSzxC6yInFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q+A+ZUAn; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30ccec928f6so1578954fac.3
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 11:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756579516; x=1757184316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPiezsjLUnzBqGwDjKVX6a94n9N1zDOYr4AgH99/0TU=;
        b=q+A+ZUAnPa3pIOgcgoNUaVcb6gueKaPfPJaZRh/PdLJ9Kq91g54ZZhXivvUYVVDqYj
         +lrFA7UuPKZsdLwDBfMSaPSSMLZ+3WUhQ+1OxW94rYBNugHdDypN5i4O3+wFIe6UoiI+
         BT1+06ct/n6zz/uNfjlr5Dv8foYHn8D7FDa1BBVFDDEaqm5vAn3mpZQQXoWtYeagX+Ox
         FwUe3IJNq2Ftc0gMw9mEs8zyx22YSaDGWfPuetowzOfXeWaU+6Fqhj80b1D+ZhcbkB6k
         2X4Jq7yBmghfUmBkyccZi7Kab5qtuQY6mvaxM5dp4fI5zDHuh2NVsEpzpvbx5aQD/MW9
         K40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756579517; x=1757184317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPiezsjLUnzBqGwDjKVX6a94n9N1zDOYr4AgH99/0TU=;
        b=upPXwob7OFwYYVwSoc9AsLMhKAIXwtasgKKsFh+/KQKydAfgW4RA2d+BiPNsnWKcNU
         QDbRjDuibTLM3jnLNrCf7win2/s4nc4dFrks7Jy2zSV7+qyarCKkx2LRbIzaXZ++xvH/
         ciGxlkLF6byZ78N872sl0yMTXkcBGTizS+Q+hIS+wljKEKhzU4e4Q6aPLbrVHf2G47Xj
         THZZUi6tLbLR+9sr4pCiHZlhbbQfLZ6zrG7/22CzQZC8q5q6SwJOJTVMQqH+xc2lGg1p
         01iChy7iKLctGPXDzotjeyIDNbMNwcIuTgl+qqRGVPM6ZK0LfUM6BEFj/8b6FmN5GkP7
         G/5g==
X-Forwarded-Encrypted: i=1; AJvYcCUzScwyj/e9o7Dxvw9k5O60vbgaFNEwhSEytA/axMBONLPxw9aoCBd3IWEabF5f3MjdD7TG0YynwA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgk7bkjuQWvJpm+WfqTp7CeCLCgWsp7s/oKOBcXoWK62n0zQc1
	j6uOHylmFWxQIMSibTYz8JRaDSvH4z/0I1Os4ZoYhgUwgwWAoQAUuUERcN6K5BntMcM=
X-Gm-Gg: ASbGncueatXPiDzP2xCPD+Tu1DwDvzSBVagUzozw1l70qMbsGTNpHRcYLPe2eSXKA1B
	ldqB/k4c+4d6IrfE2qLm6xahZamVDNxNZ3mzRLR2i/QlMn0kKq3ixi25cLx9CrDaH6fH2nFU3PG
	PjHtnsjR3nW3Sim7/CKME4EspnNkWmV6AyX9TLFbr/64tDGalbE2Oc88kCAQSzX80M+ey5wv7ZE
	q4vLVV2axj7vpIi27PgQSPr48nnc5NP/fb5KwU4Izn1bpTDXsK6zP/aGlTfG7ova7XFC3dCO5V0
	9vbnRkTsC5o1GdmCK0lQkOF2jN8WWazTdCn8kyIX9gJS9Ht4bLIQId9MZzhcMWzg65UqYmXTr7Z
	OC/zVwU/RZfVjLd5o4TpdsGlazckGN7GJKggFWpP3268Tf9cKg6+8WCb6/jqQ4GzxQza0+4qhej
	0=
X-Google-Smtp-Source: AGHT+IGv9C+6T4KddzZvtjmPR5YaSWFbXjOWucy8kEyzoY7r1q/BobV4qLWBoksIlhBWe9W/PezVCA==
X-Received: by 2002:a05:6808:1809:b0:437:df8f:699b with SMTP id 5614622812f47-437f7ce0b66mr1214908b6e.14.1756579516610;
        Sat, 30 Aug 2025 11:45:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d? ([2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437fff0819dsm20451b6e.14.2025.08.30.11.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 11:45:16 -0700 (PDT)
Message-ID: <bf2a2ef0-0ae0-4a57-a3be-e0062190da42@baylibre.com>
Date: Sat, 30 Aug 2025 13:45:15 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216 and
 ADAQ4224
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
 ahaslam@baylibre.com, marcelo.schmitt1@gmail.com
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <31584fd69731bf75967a0fa75302bd7402f6705f.1756511030.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <31584fd69731bf75967a0fa75302bd7402f6705f.1756511030.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 7:45 PM, Marcelo Schmitt wrote:
> ADAQ4216 and ADAQ4224 are similar to AD4030 except ADAQ devices have a PGA
> (programmable gain amplifier) that scales the input signal prior to it
> reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> and A1) that set one of four possible signal gain.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> The PGA doc was inspired on ad7191 dt-binding and uses the same properies (but
> with different values) to describe the hardware.
> 
>  .../bindings/iio/adc/adi,ad4030.yaml          | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index 9adb60629631..36fd2aa51922 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -19,6 +19,8 @@ description: |
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4030-24-4032-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4216.pdf
> +  * https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4224.pdf
>  
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> @@ -31,6 +33,8 @@ properties:
>        - adi,ad4630-24
>        - adi,ad4632-16
>        - adi,ad4632-24
> +      - adi,adaq4216
> +      - adi,adaq4224
>  
>    reg:
>      maxItems: 1
> @@ -64,6 +68,27 @@ properties:
>        The Reset Input (/RST). Used for asynchronous device reset.
>      maxItems: 1
>  
> +  pga-gpios:
> +    description:
> +      A0 and A1 pins for gain selection. For devices that have PGA configuration
> +      input pins, pga-gpios should be defined if adi,gain-milli is absent.
> +    minItems: 2
> +    maxItems: 2
> +
> +  adi,pga-value:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Should be present if PGA control inputs are pin-strapped. The values
> +      specify the gain per mille. For example, 333 means the input signal is
> +      scaled by a 0.333 factor (i.e. attenuated to one third of it's original
> +      magnitude). Possible values:
> +      Gain 333 (A1=0, A0=0)
> +      Gain 556 (A1=0, A0=1)
> +      Gain 2222 (A1=1, A0=0)
> +      Gain 6667 (A1=1, A0=1)
> +      If defined, pga-gpios must be absent.
> +    enum: [333, 556, 2222, 6667]
> +

It looks like these chips have some different power supplies
as well. E.g. V_DDH, VDD_FDA, VSS_FDA, VLDO. And there is only
REFIN, no REF.

>    pwms:
>      description: PWM signal connected to the CNV pin.
>      maxItems: 1
> @@ -120,6 +145,20 @@ allOf:
>      then:
>        properties:
>          adi,dual-data-rate: false
> +  # ADAQ devices require a gain property to indicate how hardware PGA is set
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adaq4216
> +              - adi,adaq4224

Could use pattern instead:

		pattern: ^adi,adaq

> +    then:
> +      oneOf:
> +        - required:
> +            - adi,pga-value
> +        - required:
> +            - pga-gpios

  	else:
	  adi,pga-value: false
	  pga-gpios: false

>  
>  unevaluatedProperties: false
>  


