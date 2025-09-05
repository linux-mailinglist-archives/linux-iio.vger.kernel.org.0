Return-Path: <linux-iio+bounces-23791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BE5B45F8E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C3B7A6956
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF32F30B538;
	Fri,  5 Sep 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KVM/5kj5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43418302177
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092001; cv=none; b=Wwti7wgBp5eens3xNx9EguuPlrFXUV1mp+QyifiOEn1Dj65INwvz8K26gH62Fd4ayvJyP44MdAR751UUGU97NV8Yo/rbmbJ5Zgwt5LYopD/NtJC0TDfxtSU+qyDoQPr214vSrAXIlzXEou49IIwVC5kKGb9lXlT3v0NoqkncNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092001; c=relaxed/simple;
	bh=QkflFLOyAsxpNTIsEZguoI9ZFg/E7isbqn/iXildXS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dr8JduC3+5kJ4+546VurSOSII63bpzl5AvluknvN+Aeo0BdTOtbdCCKmJncjnBIofg8plBiJfJsVTVcB70bpXeZpE+cAfngv0zggmwZa2UKPnv5pkJAYKw/xYaNdb60PJL3ftGtmKHXQAus40CY3b4vKEaq3tjIdEggzpd3hTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KVM/5kj5; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-746d7c469a8so1155614a34.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757091998; x=1757696798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anFqxnxyI7swraoxgwxGeFgFBlwXlIQh106TWK0o5QM=;
        b=KVM/5kj5+ItiYgoroUyJ+4HQYO/s4jPuEdhWYjiAUwJciP9vtsfgK1cpt6VoatWU4S
         KKpV7icHjs2OVfnd6sSvleSMfbO7LRJjs//iGM+cg8389x+gHCFxnLbcUjKv9YqniaVA
         Q2HpjmT38+qmJTU0g8lxtNzGCNxfQq5JPUTFzZMieeFdHV55dIfOV5bPwS2XRxp6tIwj
         8uGgwYqR7JZEQpC5g+cW+tRzc5KxiMR7+hGy+czZYo3HUjzVy6VSJlPkjIAsXsWrm5OI
         7yKWSUs8t9HGVsnT3okvBIISEhVNW9BTcE4eSQIU5bX309/19gcQ4Yoo3qXqGes3ZTZ6
         eWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091998; x=1757696798;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anFqxnxyI7swraoxgwxGeFgFBlwXlIQh106TWK0o5QM=;
        b=jIf3u/eZzIs3cdAl1eg3JjIfTFw/OcfocKCJnxiKUs++hkdY5kzRNWn0Zo2Dv7H+sw
         Lp7CutnUp7K9BXA2N3Y2J4jGec0PAzUdPFmTncctDhzQlvWWt+CNrF0NzWS5v7Pm9PbH
         GdN3jD1ek1190ptY+Gh8+Mt+Ctqzwn1BVC1qDG198dXm102/fGNTx/jZ1bBBTbGD+DdD
         +Z0HXt5EfMrI+FXz7H7LrfsBiM+nDKgeoWVUzPxPbmnvhBtba+ghBd9GPp5DPxcJ8Qgd
         7HPVmsZumdkcWVEYIx8p1+AiK66Qltm1u6x1wtvHRLzgbFFEfx4hix4G50UYYeND+z1w
         YaVw==
X-Forwarded-Encrypted: i=1; AJvYcCU8L5tvmz8+/4/hkggVYzIzJrLRYm9S/ddJdtsPni0lqTnQ4kAuEb+NVwgWVXAb3T+/CUqVFPmmjog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDDkux1QpEjbWdIh8xY/O544S2ts9JK3wxlWPG4z2qoqG8YT2
	56G+VDNIU9tUgSQg+YRRJQ1wEYZ6FqRCHBzVYlCZOKn7kJjpFeeMKQV97I5fSNE7M0M=
X-Gm-Gg: ASbGnctRGIFkFWxOrLGn8QcrfUwamFUq+/j3MBK2yxY9LfBoiTeoVaKTRl93CtqrvW/
	hvTXb6+AandzhA8TS4XYsSZ6rUnyqyWQj8lB6muCpWqK8jF5x+rGvO76H/EQ5pDtyZSHq17O1b6
	1OXoxX8HcQP7rcRvBoeynBeTFEPKBf+IbwBrD54oG78Dio2LZkQTu0aQMA/yt0wt1SwA5QOjbmR
	YyPP8zyL1aUbgWOShjS/mZak/0mqc64C0twcs3ovLSqqFVisDTqI4efSOdpBwM014y6cDb2r7HP
	+Fa0bUUi8rmxECsdXLuisWXsRyjs7irw4DbfXSXYOCOVQnpRAXXrqqBPMN4vVaCyCb/3QiNYXA4
	Mm0H0unp1Fx+PDqaKO4iya6o1GMj3Mrbb+2YAnUi+uQ/StPGytXHcByMcNmHXdKD8W2ytfvKekv
	j5fOX/ALU=
X-Google-Smtp-Source: AGHT+IG7ghMIe2cxnj+pk3rXW2GvzmcdmR1NSgHSvJ5AtFFp4f+XYMewwsOhZYccj4QGq4HyHz8QTg==
X-Received: by 2002:a05:6808:152a:b0:438:3ae6:d5ab with SMTP id 5614622812f47-4383ae6d6f3mr3823162b6e.41.1757091998124;
        Fri, 05 Sep 2025 10:06:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437ffed9f15sm3544740b6e.10.2025.09.05.10.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:06:37 -0700 (PDT)
Message-ID: <5d387011-7560-48ac-8f92-bfe0fda7e71e@baylibre.com>
Date: Fri, 5 Sep 2025 12:06:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: ad7768-1: add new supported
 parts
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
 <46842d4cf2c1149bd64188f94c60ce5e4f3b2beb.1757001160.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <46842d4cf2c1149bd64188f94c60ce5e4f3b2beb.1757001160.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/25 4:49 AM, Jonathan Santos wrote:
> Add compatibles for supported parts in the ad7768-1 family:
> 	ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1
> 
> Add property and checks for AFF gain, supported by ADAQ7767-1
> and ADAQ7769-1 parts:
> 	adi,aaf-gain-bp
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v3 Changes:
> * Renamed adi,gain-milli to adi,aaf-gain-bp. Now it represents basis points
>   (one hundredth of a percent) as suggested by Krzysztof. Description was
>   adjusted.
>   Note: permille (1/1000) was also suggested as unit for this property.
> 
> v2 Changes:
> * adi,aaf-gain property renamed to adi,gain-milli. Description was 
>   simplified.
> * default value add to adi,gain-milli.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 44 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index c06d0fc791d3..c2ad8e585586 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -4,18 +4,26 @@
>  $id: http://devicetree.org/schemas/iio/adc/adi,ad7768-1.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Analog Devices AD7768-1 ADC device driver
> +title: Analog Devices AD7768-1 ADC family
>  
>  maintainers:
>    - Michael Hennerich <michael.hennerich@analog.com>
>  
>  description: |
> -  Datasheet at:
> -    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
> +  Analog Devices AD7768-1 24-Bit Single Channel Low Power sigma-delta ADC family
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7767-1.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7768-1.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/adaq7769-1.pdf

Only adding one property seems a bit incomplete give that the ADAQs have
significantly more pins that the regular ADC.

E.g different/more power supplies; gain-gpios, fda-gpios (or don't allow
gpio-controller if we can assume GAINx and FAx are always wired to back to the
ADC and not coming from somewhere else).

>  
>  properties:
>    compatible:
> -    const: adi,ad7768-1
> +    enum:
> +      - adi,ad7768-1
> +      - adi,adaq7767-1
> +      - adi,adaq7768-1
> +      - adi,adaq7769-1
>  
>    reg:
>      maxItems: 1
> @@ -58,6 +66,19 @@ properties:
>      description:
>        ADC reference voltage supply
>  
> +  adi,aaf-gain-bp:
> +    description: |
> +       Specifies the gain applied by the Analog Anti-Aliasing Filter (AAF)
> +       to the ADC input in basis points (one hundredth of a percent).
> +       The hardware gain is determined by which input pin(s) the signal goes
> +       through into the AAF. The possible connections are:
> +       * For the ADAQ7767-1: Input connected to IN1±, IN2± or IN3±.
> +       * For the ADAQ7769-1: OUT_PGA pin connected to IN1_AAF+, IN2_AAF+,
> +         or IN3_AAF+.
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +    enum: [1430, 3640, 10000]
> +    default: 10000
> +

