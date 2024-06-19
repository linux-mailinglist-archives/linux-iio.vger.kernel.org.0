Return-Path: <linux-iio+bounces-6595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF0990F4AA
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 19:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F982817F7
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3B155386;
	Wed, 19 Jun 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1FmR4Im"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BE339A8;
	Wed, 19 Jun 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816574; cv=none; b=SKDauQ0aJbSvnkJR4J6gKXPd1zEIE6fF/b+VtKHBcA0lhOO7jT0agelnRrOO2Nv82mfI9bLgWdRFXyIBaUtsafDNKy3NFC84UEJsrAQNtRUOa9U/o0TQ+m7yEnzGUCuuE2Pi0V5Ezu3MhPyM9XFKozwi2nP27v+OkzKKAxWHX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816574; c=relaxed/simple;
	bh=PDVe6x1W7Sg6im99IZlElznaygjLXCfxFfHhjxUX5NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBsSSaBBq1jWWiF6NhJngv+oh0IyeKwGgmnnIzqgLedG4i5pazDy+0TvJAqNM+ReZ2svMiZ9FmIjWyVvyw0/zAIZB6csUEzMRSGfd85o9n0MFhNU+9sp+GQKaa6lxb3yYsOxdjthm9ESPvTWMPneaKS0YCSVm4/caOvRJWwGs70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1FmR4Im; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f44b45d6abso50950995ad.0;
        Wed, 19 Jun 2024 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718816572; x=1719421372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCyy/iTu+Rgj32SD9M0e0oNUqf2SCUNkQAcuASyXy2Y=;
        b=Z1FmR4ImULJ8sI4zxYjERU0cXSE6y3aSwpT3tlxP3gw+N+i6PjLmoF9iwcLPhXU08B
         MAjIIweuAeAt8W9mjAYdRTJG7TBCRT1Q+5yPFpEqcoK9GpJo6NQpGoq7qjUfDR6UDx0n
         V5Hlt8aLLV2YLbKyjSosK7aJBSo/WfhMrtMYMPgX6vmeKzOV0uz+XhYHncftsllnhnq1
         UKMdsrtMsHXoXda+SwjR7ej668OisJgghCjJm1KqEykN2bC3fBjrpPzKqrVBrenoCO+R
         NKwy9cUFsGnBp+AbKpzIzo28G78qMvJCdVbkOhFxDFAzQpr5mUqhzZ5jMvTOUj75yDgY
         EmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718816572; x=1719421372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCyy/iTu+Rgj32SD9M0e0oNUqf2SCUNkQAcuASyXy2Y=;
        b=hvoXFscCLdCULEsfj8qGZWTUKl6QUjrbSx/7TgPGGVI+9WRjXwFvWJoe6Fqu527OPM
         gO5cwrgEv0BbM8blfDoafAfBiVkYjs9jkK9Tmo1SGeV6EgGsxgKSq4ytacsIoZEWuUvk
         N02jD9vcgtB0tgF5GNI1aqlSQmFscw/2nXkwgHGjwaUj3TPpcne9OXsTtOOWRbg/3VEH
         MIEkzC7H7KSpzKozG9YFS0T5Wqq8BjRNL199JdKOtj8TO58bnxL+EDXS56ln9JIcrHCQ
         mtT7J1sE6HnQiH7WFQcGKEM+OcQxQA1YYXSYQ1VTTPC719IGdueyE66rDulrqN5bHfd3
         fOoA==
X-Forwarded-Encrypted: i=1; AJvYcCVSVtrjG7MywLV1Vadn2MxEhod+GH3xG3rbbiaHBc+ojeXfSJenY6fvNkpKs9qMYeQq+PkVAXKYd3kD+dwTJoCH+GFRquclTSOI0KyiFS7CbmB5HRwBHmdBGmOBZ21/y2KC/7/5m1vpygUUwQmYf8rLkdJjnPUQL0hSxzUD/imE4n9+6xUcOVwG461HN6ehphKtw18uJBFJ5mMAOD9p2w==
X-Gm-Message-State: AOJu0YywUscR6XrmQzTue58YJZkczvxD8BRsKRwXseC+l98WcoRIJJw+
	a1dWpHr1QHQiG8atrBw2cCyJpdOUu+YulI9NsyzXbsAWqst0Wnqx
X-Google-Smtp-Source: AGHT+IFN6ZzW+EYZcLINoXOjKKuRVNBPYCeqYeRfUtLufjNP5tnpECbgvisRvGRDtPqhH3MaSsFOmQ==
X-Received: by 2002:a17:902:ec83:b0:1f7:414:d687 with SMTP id d9443c01a7336-1f9aa468225mr36186415ad.67.1718816570993;
        Wed, 19 Jun 2024 10:02:50 -0700 (PDT)
Received: from localhost ([2804:30c:96b:f700:cc1d:c0ae:96c9:c934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f15149sm119839705ad.218.2024.06.19.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:02:50 -0700 (PDT)
Date: Wed, 19 Jun 2024 14:04:14 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] dt-bindings: iio: adc: Add AD4000
Message-ID: <ZnMPjtj1ZhOzKeps@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <34a16c6e513b32bc6111b695e1c8b467bd6993d9.1718749981.git.marcelo.schmitt@analog.com>
 <38f99355-0186-4c2f-912a-cb03d6e4823c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f99355-0186-4c2f-912a-cb03d6e4823c@baylibre.com>

On 06/19, David Lechner wrote:
> On 6/18/24 6:12 PM, Marcelo Schmitt wrote:
> > Add device tree documentation for AD4000 series of ADC devices.
> > 
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> 
> Datasheets URLs are listed in the patch, so probably don't need them
> in the commit message too.

okay, removed them for v5.

> 
...
> 
> There are data sheets listed for adaq400x but no compatibles.

Ah, that's correct. I missed
      - const: adi,adaq4001
      - const: adi,adaq4003

thanks
> 
...
> > +
> > +  adi,gain-milli:
> > +    description: |
> > +      The hardware gain applied to the ADC input (in milli units).
> > +      The gain provided by the ADC input scaler is defined by the hardware
> > +      connections between chip pins OUT+, R1K-, R1K1-, R1K+, R1K1+, and OUT-.
> > +      If not present, default to 1000 (no actual gain applied).
> > +    $ref: /schemas/types.yaml#/definitions/uint16
> 
> Any particular reason why this needs to be uint16 instead of the more
> common uint32?

The values fit into 16 bits and Nuno asked to make it a 16-bit property.

> 
> > +    enum: [454, 909, 1000, 1900]
> > +    default: 1000
> > +
...
> > +  # The configuration register can only be accessed in '3-wire' mode
> > +  - if:
> > +      not:
> > +        properties:
> > +          adi,spi-mode:
> > +            contains:
> > +              enum:
> > +                - single
> 
> adi,spi-mode is not an array and we are only checking for one value,
> so this could be simplified to:
> 
>   properties:
>     adi,spi-mode:
>       const: single
> 
ok, changed to do the check that way.

...
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        /* Example for a AD devices */
> 
> Comments are a bit redundant since it says "examples:" above and
> the type of the chip in the compatible string.
> 
I like the comments. I think it makes clear we have AD and ADAQ devices but ok,
removing them for v5.

> > +        adc@0 {
> > +            compatible = "adi,ad4020";
> > +            reg = <0>;
> > +            spi-max-frequency = <71000000>;
> > +            vdd-supply = <&supply_1_8V>;
> > +            vio-supply = <&supply_1_8V>;
> > +            ref-supply = <&supply_5V>;
> > +            cnv-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
> > +        };
> > +    };
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        /* Example for a ADAQ devices */
> > +        adc@0 {
> > +            compatible = "adi,adaq4003";
> > +            reg = <0>;
> > +            spi-max-frequency = <80000000>;
> > +            vdd-supply = <&supply_1_8V>;
> > +            vio-supply = <&supply_1_8V>;
> > +            ref-supply = <&supply_5V>;
> > +            adi,high-z-input;
> > +            adi,gain-milli = /bits/ 16 <454>;
> > +            adi,spi-mode = "single";
> > +        };
> > +    };

