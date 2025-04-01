Return-Path: <linux-iio+bounces-17512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D475A78064
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 18:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA44188E372
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78411C6FE8;
	Tue,  1 Apr 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pi6sgHw5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE020CCF3
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524412; cv=none; b=uNxFAVfxoJwAOhEkOYNeGupiV/VB6SkQ2H7XAH0X/F0tnQUzfvI7o/+g7lxarNPiZaHpL20OGHu1NTFz/RodlPAfyVYX/tg5O6aRbJaI7/wkPwAnM2kV5dujJComj4m9XU57d53TiAvESRrIo6KdBKYHYZJJImH0zZ15fhsPCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524412; c=relaxed/simple;
	bh=+gL7pqviWCTSkJIhD8SI688Pv1X16XRWBd25qPBRg20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=red3IbOTZ1aURhwsqwMfq9isoVggKnT3VNyVFTd2VTnEjIjDToXCHmUhfzRXTtGII7ww526TaF0R3s4xk/ZK+CtnSNlHln9H6TtNk2lUSXfq4KhzchOLiXjTN6YOh6lHyhOJcmIANkNJIgycJrlQsjhDLzey6TQoYjinjUK5yFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pi6sgHw5; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2cc44c72959so409096fac.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Apr 2025 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743524410; x=1744129210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yD6imsgkoRBmKikS0REDEdzThJO/QBBTFKUjw+FE6FA=;
        b=Pi6sgHw52otpqLufj5O/uy0SJWB21oxopbZRTVpNL+5t1pao36G9Y6uSaGq86Lexk4
         VqJbKydPcJL9HvPRQ/yYa/i+KccGqcXxLSLIWIz/5wpk3ccDuUhJuJDWfnRZl4A0YGJk
         G0Cmb07GlmzMmAVyJ55EeNCVdTK4GC61+83u2cWWrVKVqyfP2AVyLJ1B0kH6VITurYOF
         HfHnWzGBVZ7jPQzWH1QSJFGFkTeV2IbOEftx2yy8GT4IMUSncbc91Ba/CCTayLdwJxFA
         TkcrUDL5DsxEbTGX8j+DxQNUad0S4s9VG62YBc5V3zRCCjg6/UbucsREaI8LEs9yU6VA
         zClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743524410; x=1744129210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yD6imsgkoRBmKikS0REDEdzThJO/QBBTFKUjw+FE6FA=;
        b=Eho2IYlab0ZQ5a50/bTGVLt4xVqLwjMcDVKVD6wXFwjoQzrG360cW9TCf65va0E23l
         nBy8QaJg3MNJyLNY66P1boGoxd6VVnNRBNpBSu8iB3NUF5suBhrtZPsHDr0BeS+l7AIi
         jwKbNLWQLCC4l1p4fbAl8opmKNSvyPBkOpI80Ig+/LrihpClj44HoV0E4/ogVz66Zo8P
         SWWOZ20247D4fPqtZKg6er9UxE+MDqV7BW+s6mYSX4vEakXAxEpoXIwK2WPmEhHTbdt0
         5POqktxuW31cPYDHDTJiehjhW1zS5Pug065WSEdWcFB1kTuz2rR8rnZW2XDhT+fVrfI6
         OKiw==
X-Forwarded-Encrypted: i=1; AJvYcCVNQUWxQkaSOPNX0et+EM1tr+HFZWiBiiVR3R4j1ma9SDnsaN+7uigEEo8ln369+AP+XDaaTRoUIsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlwx7iiEe/PCAo2k4ll1JScDs3oKTqCJyXqceOygTNnWzQEJFN
	OgvXtMa9cxmXNWWGef0QN0byhqKfrdtJcQhajDG2olo4spGjfQvgP+X0lR0ORt94/FEgOULSece
	QIEw=
X-Gm-Gg: ASbGncuaxk21Trg3X2kH4skxo2F6gk5ADUTFXfLAc+RXWjrvEtFsbb6qemnf9TLGcRO
	VHTAkF2JgNbwF1D6YnaJEfEJNuB9v38Bqq7bjebCzBJNRISuu5f+PAnqTetvBgSLiOSvLkjGLxt
	W7zNcYGoqMyeh0BgbRhmrIB74dJsf08sfP6EI+wyBoaChSQb/jXW6aG6ibTrRMkMaJYrIZ93D3F
	NCsWLbIV8kafx+6ARSrs07s33KrhKA7ZdvgS3taARnqbX80F+nLtZztYOL3I+/4hu4/GbC8mapv
	lzbOCqYrmMHyOzuze0w/4MTrbnkADH71QSS8WFQH8XJ4hM3yEF6zm6srfANmtFN2AOULw+p6Qoi
	3f1xSMQ==
X-Google-Smtp-Source: AGHT+IGRdAdsC+0OxQWe8MfCLWx67HbEd+4baPkKY8LWeRb8Ft8zVGD3dRLKm+iYNatE7FTS7a5YKQ==
X-Received: by 2002:a05:6870:4d16:b0:2a7:d8cb:5284 with SMTP id 586e51a60fabf-2cbcf4216a3mr8115424fac.7.1743524409757;
        Tue, 01 Apr 2025 09:20:09 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c86a497aedsm2345282fac.16.2025.04.01.09.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 09:20:09 -0700 (PDT)
Message-ID: <e542609d-afee-421a-87ca-18991a65a507@baylibre.com>
Date: Tue, 1 Apr 2025 11:20:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/17] dt-bindings: iio: adc: ad7768-1: document
 regulator provider property
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
 brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
 marcelo.schmitt1@gmail.com, jonath4nns@gmail.com,
 Conor Dooley <conor.dooley@microchip.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <7125eea4c3386777d2211224c73e38d8f576e4f0.1741268122.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7125eea4c3386777d2211224c73e38d8f576e4f0.1741268122.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 3:01 PM, Jonathan Santos wrote:
> The AD7768-1 provides a buffered common-mode voltage output
> on the VCM pin that can be used to bias analog input signals.
> 
> Add regulators property to enable the use of the VCM output,
> referenced here as vcm-output, by any other device.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v4 Changes:
> * replace "vcm_output" property name for "vcm-output". 
> 
> v3 Changes:
> * VCM is now provided as a regulator within the device, instead of a 
>   custom property.
> 
> v2 Changes:
> * New patch in v2.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index e2f9782b5fc8..12358ea9138a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -59,6 +59,19 @@ properties:
>        in any way, for example if the filter decimation rate changes.
>        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
>  
> +  regulators:
> +    type: object
> +    description:
> +      list of regulators provided by this controller.
> +
> +    properties:
> +      vcm-output:
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
>    reset-gpios:
>      maxItems: 1
>  
> @@ -152,6 +165,14 @@ examples:
>                  reg = <0>;
>                  label = "channel_0";
>              };
> +
> +            regulators {
> +              vcm_reg: vcm-output {
> +                regulator-name = "ad7768-1-vcm";
> +                regulator-min-microvolt = <900000>;
> +                regulator-max-microvolt = <2500000>;

Why do we have the min and max properties? Aren't these always
going to be the same for all chips? It seems unnecessary to
have to write that in the devicetree.

> +              };
> +            };
>          };
>      };
>  ...


