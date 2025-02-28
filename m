Return-Path: <linux-iio+bounces-16210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C9A4A616
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 23:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2DF1776DE
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 22:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027051DED48;
	Fri, 28 Feb 2025 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kL77e3Mw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AE1DE4C7
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782494; cv=none; b=qfjwZ9Rn1BCVm8fzUZEZxb5snG9KxtHrmeX8qGFrnjSy/eJixgYxLy33KLH7QZ1+Hy4uPysHjiUBwZg5qE7eQGD4I29anilElu4jj8pUTF7czxQjknTpyLCXtl1Fm/qjMgdgUdTzWHPW9casbm71JGTtgdCitGQ518jWr3l7G+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782494; c=relaxed/simple;
	bh=FLBHwO+nFllKVwfKJACF4L2HeRUbXtlCor+SO7tOf+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rd5DxX13IsHUGauNj36iD74luMcR9iKI7v0q9stkChVW5DIcgB3dqguMd3SqU2mKRbTTzeUcHRo2tsuAphdvdUS/o3cxUF/8tQMDKj2paqmNdCaHx+IduDqoygNYK1qS4bXaiz+pWCdgecnr1iFqqKjuxuXlAEJuwZEUEOdjWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kL77e3Mw; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fcd509468eso1172479eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 14:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740782492; x=1741387292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9VA0oblCg0Xc+d3Sx56RfFjCCmOWiRbgOPbTv313JQ=;
        b=kL77e3MwsaRLeH+6oezvDPr6jgHY9ZebP82Heqs0OFRIMLkftOrqlbaSAPnA3sxwQd
         6+ic/j2xMkY3a4uVmOViPSAzAtXXZdYFuY9FzwBge3/3OqM67PMAhUTaJvpW25DVwAiS
         PMj/PNA8pRhxQdjd6N4UgJYQ+FOR7JZ2Bg6fZDXpAh640wxXx59lWq7qQ9U6N2b3SoSL
         cdyzvTAfjWh+/OzmCcyhhJ2PvJbU6xtL49/niJYuCRd7/RQNEi0jnU9lGghh9ohwG7gx
         6S7WC7x0uFc/JF23M+tf9r7aO7i9NR85zZWcUfiMRNYSqTn4qkedhEv/GElu5pKGoQun
         slDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782492; x=1741387292;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9VA0oblCg0Xc+d3Sx56RfFjCCmOWiRbgOPbTv313JQ=;
        b=nXDc0/BSkR2sBzs5aH73ocMagVxrTigWX9tTbaajGy91v/lpCj2NepOTAUN1U2HLGr
         yA7HRlLkOKxd7+vLWKEWvel9N8kuugQr5YwiEqUsu1GQ074Jo9hF4MMbuTbq7q1Ui9i8
         4xW5rsakiiYfTA8LwOLPaYhXT0W6HNDXhf725QFrEmHCAzTe/1TV2go1rEPSYzOCxC8r
         PaMzwj12KVgDaqTHZ87EGjSa8eAd+T57l9HPiuG5pzs4uMjr4vOW8HLwwK9h4u1T7lrj
         NlKYeGjP15hT10dgVO1xb98ZGykyTkDqbULVl1JyNnlg2UG+7yUaRXNKwX3qzpod4bPL
         0XhA==
X-Gm-Message-State: AOJu0YyH8G3VR3Fsa6/VKDR/3uQDrXX1l7yUPQmb0pFcWnPWZA/RYRaK
	/z3FbNaIICqFMibiCaKWVIju4Pzdje4s4CiML+IxMSbo3Xx8+L/mTctv8QJQeV0=
X-Gm-Gg: ASbGncsRJHaqNYlwGXN8MtarUVvge75ty5Oovc+aaQa1PPPa9AULcun2WKeD1Ixj2+h
	GtqwJM78E8dxFFoScygCedvlkm71pADd9EHMSyHXmDSGlihtfQMvGtL6oOYXgY45fmPy+NtoWS+
	HHxBT5xVA8c5/mpxPFTUeGXUEiHFCyV8jNZEPzfmh9h9+GRAU7HLQXajXoSgcIjxO76+8fhy0B4
	VLy6ZwR+oHECvza0J58xteE6R7Q2UtETRuMxhmyJSSfyq9JIbLtyTP+BP/RGIH9giH3DRzpjHhW
	+jbPgm4u33+3jVi+noC5OHWg5fKrE01PZPPtUD742pFxw1tBJI9chJgJ+83JLE4aoM+EHNE5wNs
	96XtrYw==
X-Google-Smtp-Source: AGHT+IEceEwYejaDDNX0Vuw40LNIKav7t/w6trGAq65H0rdXXXH9+Wnxu7YXOtX/U2cJOjXP8F/3TQ==
X-Received: by 2002:a05:6820:151a:b0:5fd:a01:4834 with SMTP id 006d021491bc7-5feb3668d88mr3486224eaf.7.1740782491972;
        Fri, 28 Feb 2025 14:41:31 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaad43e80sm788380eaf.35.2025.02.28.14.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 14:41:30 -0800 (PST)
Message-ID: <8db96db5-c258-4c42-a70a-56fdf24ecdc6@baylibre.com>
Date: Fri, 28 Feb 2025 16:41:29 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
To: David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-8-david@protonic.nl>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250227162823.3585810-8-david@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 10:28 AM, David Jander wrote:
> Add device-tree bindings for simple Linux Motion Control devices that
> are based on 1 or 2 PWM outputs.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  .../bindings/motion/motion-simple-pwm.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml b/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
> new file mode 100644
> index 000000000000..409e3aef6f3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/motion/motion-simple-pwm.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/motion/motion-simple-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple PWM based motor controller

I think it has been said many times before, in DT, there is no such thing as
a simple device! It will be much more future-proof if we write bindings for
actual individual motor controller chips than try to generalize all in a single
binding. The chip you gave as an example is far from the simplest H-bridge I
have seen!

> +
> +maintainers:
> +  - David Jander <david@protonic>
> +
> +description: |
> +   Simple motor control device based on 1 or 2 PWM outputs
> +
> +properties:
> +  compatible:
> +    enum:
> +      - motion-simple-pwm

This should be e.g. ti,drv8873-q1. This device has much more pins that is given
in these bindings.

If we find more devices that have similar functionality/pinout we can add them
to the same bindings, but we will likely find that trying to cram all H-bridges
into a single binding is too much.

For starters, every H-bridge chip is going to have one or more power supplies.
ti,drv8873-q1 would need dvdd-supply and vm-supply properties for the DVDD and
VM pins.

Many have inputs for disabling the chip, e.g. for power management. And some
have outputs to indicate faults.

The TI DRV8873 in particular has an nSLEEP, DISABLE, nOL, SR, MODE and nITRIP
inputs in addition to the IN1 and IN2 that would be connected to the PWMs.
So we would have properties for all of these to either say how the pin is
hardwired or a *-gpios property if it needs to be controlled by the driver.

The fault output would generally be an interrupts property.

The IPROPI1 and IPROPI2 output pins look like they would be connected to an
ADC, so it would make sense to have an io-channels property show that
connection.

This chip also has a SPI interface. So it needs to have the possibility of
being a SPI peripheral node.

And even if the Linux driver doesn't implement all of these features, we still
want the DT bindings to be as complete as possible, so we shouldn't be leaving
these out, at least for the trivial ones where there is an obvious correct
binding (which I think is the case for most of what I suggested).

> +
> +  pwms:
> +    maxItems: 2
> +
> +  pwm-names:
> +    maxItems: 2

Specifying what is wired up to the IN pins can be tricky. Using two PWMs is
the most sensible. But I've also seen devices where there was a single PWM
gated by two gpios. And for very basic H-bridges, there might not even be a
PWM. Just gpios to turn it on or off.

> +
> +  motion,pwm-inverted:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, this flag indicates that the PWM signal should be inverted.
> +      The duty-cycle will be scaled from 100% down to 0% instead 0% to 100%.
> +
> +required:
> +  - compatible
> +  - pwms
> +
> +allOf:
> +  - $ref: /schemas/motion/common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // This example shows how to use the TI DRV8873 or similar motor controllers
> +    // with this driver
> +    motion-simple-pwm0 {
> +      compatible = "motion-simple-pwm";
> +      pwms = <&hpdcm0_pwm 0 50000 0>,
> +             <&hpdcm0_pwm 1 50000 0>;
> +      pwm-names = "left", "right";
> +      motion,pwm-inverted;


> +      motion,speed-conv-mul = <3600>;
> +      motion,speed-conv-div = <100000>;
> +      motion,acceleration-conv-mul = <3600>;
> +      motion,acceleration-conv-div = <100000>;

This H-bridge controller doesn't have any kind of speed sensors that I can see
so these properties don't make sense to me. The H-bridge can control the voltage
sent to the motor, but there are more variables involved to convert voltage to
speed. It isn't a constant.

> +    };


