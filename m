Return-Path: <linux-iio+bounces-27634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AC6D11B7D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 11:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2FC3305EE7E
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2FB27703E;
	Mon, 12 Jan 2026 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1MAv9wr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E5026A0A7
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212253; cv=none; b=AxAeylN6ciZnNmv7BZdKhuno3Y3SGUT03+sxKqyEbm6DF1Ep6ZahLvBrGf9RDZszTak0UvK5NnePgmfi8/BnwXdFHnFySIFztvvLqfwTE/hGGJdApW2qEHTP+YnCBi3Qlx+45cmg0Zy9aKGIK5wHQkR8QlFw8aYPUxM67pMTDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212253; c=relaxed/simple;
	bh=oqOGXbeDIQlNePE/yiwJ+NT0kXzbdHkFX5Jkw1SZilw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHufo+jdBOjPRXekGPei6x1qDr7KB7J7WIkOQEapo1VFOMc0V21yfwN3gS0hSClXCdrZQtA2Qe9q2Rgni39A4VCE+aQwR4ZH/HmssIU5Jcs0UOn9i3t7Cl1cIuH84bK4KQYkOj4SrbU9r5HfW172E9sQ5pmL6hxWHLhJHOXgEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1MAv9wr; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4f34c5f2f98so69454021cf.1
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 02:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768212248; x=1768817048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5hiBX/EJmbP0rFvOH8HeLIh3uhucig2oXB0fSc8NSg=;
        b=N1MAv9wr2GKPAbiYalM/ultWNNHRnItPp5uXKvCM9nkvAzQFdm99JkOJgc33VhPz1V
         ibfz65ZZuDO5Q64juKemL+byXnTxxmBaqh6NpWTEYeutm99LwhE4t0L1IjKPo5I6DNZK
         yDsg1alLvf+bcgzaDP/IQuQr7ZCKORbG5WY4yyRoeleYUijEUSRze7dROPJ5+GCepI+/
         WR7ZTH+369iyj2ABChPQoETsUQKDQ19Pl26Vn9SG+8ekLchPlJgNlZg/96+zI1T36I6z
         xwlh2MOOSc1e5gQ3sdFPCNY2S+Jse9CZh246KE0DfIHACdcwtxABH6KKStG+hBW8Ssdq
         uLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768212248; x=1768817048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5hiBX/EJmbP0rFvOH8HeLIh3uhucig2oXB0fSc8NSg=;
        b=WDDlHVbc355tLhelQHWLx7IYi+J9lTP15/DSiALJxFiKVyLZHlca3XHqDtexA03XV5
         uQ2IEF840DneKnryH1lujmPzlnQUE89tkIIhvUNyzk6NnxpCu2/GRsHyMFR8vcMp9cL6
         bUQcXecivB6OPlvHpWy3PvX4XPyTzrXpH6g9EKxknVXNq5hZqus7nBsGHDLTGCoDMbvQ
         gRuYUTLXxLlJb6lMudSkAPrGOqtB4f40yhGtjXA/0l1aagXIPpnY3TSQz3UYL6OP3Rtv
         nb+u7okVR40Z/wRzzB2mc2TrqY528edrRq+HtJtxKRtFQChWbWbSKgRYLtPMLJy61wvd
         YfgA==
X-Forwarded-Encrypted: i=1; AJvYcCWJTf3fXdMehRMSZohNQHjXxWuWFfSqWi6RvGV+s79Zcdsp/v+ZjzTpEP0Ee3tOoIOuk+gRo6sRo1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbAmSuY7stO0LFsdYT2y5Jxu9IyxXRCsHS9UJ+I19k6IZzpQ8
	MnTEYFL0Xj8crTnpKoqNkLwQsIh7t7vMgzDmejxK/5a65IU9EHMg946U
X-Gm-Gg: AY/fxX5VPjBPxqKfNkgNLX3leTdiOV63yROrd1xJiPOgyMwiGXIS9kP+qc81P8ER0U5
	ipRWRGJ8gukzUbo3r1V2BUFHG9CJX/dvdywLV2/RHn8liQOyFPckMW+o/gK6X1oxlFxjx1wL07f
	gAPelDI7azUfqLbVRdzEiqTT/8FGJWHf/pzFiDxuH47SVqo6yddEP9b2SfTaxG4+SyPyPx2gvS1
	V8lD6TM/RvBO3lZgekqtKSfgennGV4m+szE15EwYVueZdrfwuGqeCpXFHh3RU2jIC7QhG/GJY2Z
	vxcdRDFUIQWB1Z5i8kiU8Bv8cioOZPXfb45IRNT837WFn2T1SbZEcyF3Ud+cq1NdP0Kky4sjcPb
	ECr+xIM7aCglC69r+jUP6kZ/k4PGxchaZ+Y3ashFjQk431bO2NcdWPbaZEkqIIxIuU9hsIfepPp
	M8Lg3TyMAtRuSbAAKxHoSK09p5Z3rzH7OJB3tbYOaxAXUrU9bLgOaej7cuR2djxR59PdYOqA5KX
	SlX
X-Google-Smtp-Source: AGHT+IGB5QJeG8ku54AAK1oYhHpchOQzwcbI7Eq/Mwh+iHar9n885imDNGmU7We54FoKXl1Rmirvqg==
X-Received: by 2002:a05:622a:114f:b0:4f1:cab1:9d3c with SMTP id d75a77b69052e-4ffb4a264c8mr245124531cf.57.1768212248319;
        Mon, 12 Jan 2026 02:04:08 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e627absm119541151cf.30.2026.01.12.02.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:04:07 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 12 Jan 2026 10:04:02 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: frequency: add adf41513
Message-ID: <7ck6vexpeak47kob7niupkdg3nbyvp4nab7rqmz6niq4frf64y@tjnph6hno32z>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-1-23d1371aef48@analog.com>
 <20260109-translucent-violet-smilodon-ed1917@quoll>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-translucent-violet-smilodon-ed1917@quoll>

On 26/01/09 09:13AM, Krzysztof Kozlowski wrote:
> On Thu, Jan 08, 2026 at 12:14:50PM +0000, Rodrigo Alencar wrote:
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        pll@0 {
> > +            compatible = "adi,adf41513";
> > +            reg = <0>;
> > +            spi-max-frequency = <10000000>;
> > +            clocks = <&ref_clk>;
> > +            avdd1-supply = <&vdd_3v3>;
> > +            avdd2-supply = <&vdd_3v3>;
> > +            avdd3-supply = <&vdd_3v3>;
> > +            avdd4-supply = <&vdd_3v3>;
> > +            avdd5-supply = <&vdd_3v3>;
> > +            vp-supply = <&vdd_3v3>;
> > +
> > +            adi,power-up-frequency-mhz = <12000>;
> > +            adi,charge-pump-current-microamp = <2400>;
> > +            adi,phase-detector-polarity-positive-enable;
> > +        };
> > +    };
> 
> One example - more complete, so the next one - is enough. They do not
> differ.
>

Not sure I undestood this message:
- are those examples 'enough' as the second one is 'more complete'?
- do I need to change the second example to be 'more complete',
  because 'they do not differ'?
- do I need to create 'one example' 'more complete', apart from the existing ones?
 
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        pll@0 {
> > +            compatible = "adi,adf41513";
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Best regards,
> Krzysztof
> 

kind regards,

Rodrigo Alencar

