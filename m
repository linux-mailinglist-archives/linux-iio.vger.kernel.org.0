Return-Path: <linux-iio+bounces-10600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1299DF8C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 09:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C91C21973
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 07:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091551A76D0;
	Tue, 15 Oct 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vlXyo42h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F34189911
	for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978355; cv=none; b=t/e0uN4G0T6fJJNTLq+QZSLCPoSRmX6WK2qRSzOHwBuvgKbuuwHzuSGatl2ivr//Pt8WbVn0M/bqeUDgLs+6vlNs5+xZz+JCgmtAe0lzZ6Zi9CBgINyVWxWcd9U1GP6jtf4FM2UqNOUo3rMS0uogXciXQ7Jr8YGxvhLNDn5iVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978355; c=relaxed/simple;
	bh=7J7zXZpRU44GX8SKSGs1s23yynvZyek/0nXXuZ9sFdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib6oS7XwzFYQTwhdBc0cSYSqwl5cJ3ma9r7HdOdW0WQbZjZ7NSLQFHf+zd17GzHi64q7w7E+mN9mS04SlNLh7U4M6Rui0zYE6mLJKyif1CfRcDjClLLyXKJnX0UdGuK+6RyYP4oOBX4SaLGpkK8poGb0B42EAEg+kbeQehbyOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vlXyo42h; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4311c575172so38780155e9.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Oct 2024 00:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728978351; x=1729583151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cFnFb+LrH42QxIjJOe3wZsM4KuJLLxQvYfEBQ2uPjrQ=;
        b=vlXyo42hl6Z70p9qhm+0MnF73v74KHLcHk01bbFpUFxpnw9B6myd3jEb4+WpCvRhnX
         vl1GyWlomdRW1Vh+LBpD0aXcr6LSNs9nFouI8e7qusjRdqjxnL6kjHiEVd1OalCoK3R5
         cANlul3/gVfuKABlzcutVlzRGkMEXS4zu+xkYgGCs+NsFC6vrdeDRGZoLR36hBoDXFEH
         zAGmUzHFUtffBFr1+9iE815iWgRx1jnY6zTf5xzpXEQMrK+Cbwms4cbY8+KrikP4S56T
         FADurd4VvZ34x5Hk35VY3sV5LazLu8W7Ej6DJwVzlh23f8qxQN4/nE7IXQrVZ4xANONd
         74/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978351; x=1729583151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFnFb+LrH42QxIjJOe3wZsM4KuJLLxQvYfEBQ2uPjrQ=;
        b=heab+Hfz8JTLqcEy1Uu7l0CHJ3QAn/5alFNnsgTDPcxKkw06RtvZtM5XLCxJePAzLr
         jMBMSQ1JGWunaKvAI01M8eCCna3Df/US1wfnpEgX84g7RGYqHpdTRgplhddM+rGOsazt
         5v51oCjxa8bJdY52p0lTLBJSgsYRfJz3zNzogEv/VSyl/7WLUdBYQvGNFMA8rrv/gva+
         a6GaoUdZVxgejX+i2V+YXg2K/XdPsdFZ6T9DdO356K1VZoVa/sy8P0S8Fy0Xiux6dZeQ
         2stmgENW/JYUTfWTo0a7iZHG6/tkgXALw2sPa++Am6O1WDb2xMLg6Sht8nTQI9b+ayIS
         QsuA==
X-Forwarded-Encrypted: i=1; AJvYcCXo1Yo1L8sFOEvFru78ZjLpRvtJLoDD7NhrRQ+fpSxaDH1rhrHwDG4AECqTm6OLChuKDLP33RmaReQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdzkS+ZVA0qxZs97Csv5r+Womma0n39KEwePJ3SNGN6paasSm
	8C33+jP/yl0r8tvPOIEsu3GCbPa9KQgfrznS7/aNl4FFdLrb++w7BzPIsI/XWCY=
X-Google-Smtp-Source: AGHT+IEH0CXDBwcqGpe4FZ+Ytg+tYEpU3h2eQcK6Gy9gq6QWu8TU+YQhtn7pGv0tgv7TsPCUSjxdKw==
X-Received: by 2002:a05:6000:bd1:b0:37d:f4b:b6ab with SMTP id ffacd0b85a97d-37d5530a534mr9180012f8f.59.1728978350876;
        Tue, 15 Oct 2024 00:45:50 -0700 (PDT)
Received: from dfj (host-79-50-238-21.retail.telecomitalia.it. [79.50.238.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc40f94sm847346f8f.106.2024.10.15.00.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 00:45:50 -0700 (PDT)
Date: Tue, 15 Oct 2024 09:44:22 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <imlhddzkf5eefr64n73pgtbvyax54746v6wzlwngryzzwrbw4h@uaaom7tbod5m>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com>
 <a27eb208-0fa1-45cc-bb0c-18a03b6cce4e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a27eb208-0fa1-45cc-bb0c-18a03b6cce4e@baylibre.com>

On 14.10.2024 16:13, David Lechner wrote:
> On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add a new compatible and related bindigns for the fpga-based
> > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > 
> > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > mainly to reach high speed transfer rates using a QSPI DDR
> > (dobule-data-rate) interface.
> > 
> > The ad3552r device is defined as a child of the AXI DAC, that in
> > this case is acting as an SPI controller.
> > 
> > Note, #io-backend is present because it is possible (in theory anyway)
> > to use a separate controller for the control path than that used
> > for the datapath.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 56 ++++++++++++++++++++--
> >  1 file changed, 53 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > index a55e9bfc66d7..2b7e16717219 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > @@ -19,11 +19,13 @@ description: |
> >    memory via DMA into the DAC.
> >  
> >    https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> > +  https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> >  
> >  properties:
> >    compatible:
> >      enum:
> >        - adi,axi-dac-9.1.b
> > +      - adi,axi-ad3552r
> >  
> >    reg:
> >      maxItems: 1
> > @@ -36,7 +38,14 @@ properties:
> >        - const: tx
> >  
> >    clocks:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    items:
> > +      - const: s_axi_aclk
> > +      - const: dac_clk
> >  
> >    '#io-backend-cells':
> >      const: 0
> > @@ -47,7 +56,16 @@ required:
> >    - reg
> >    - clocks
> >  
> > -additionalProperties: false
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: adi,axi-ad3552r
> > +    then:
> > +      $ref: /schemas/spi/spi-controller.yaml#
>   +      properties:
>   +        clocks:
>   +          minItems: 2
>   +        clock-names:
>   +          minItems: 2
>   +      required:
>   +        clock-names
>   +    else:
>   +      properties:
>   +        clocks:
>   +          maxItems: 1
>   +        clock-names:
>   +          maxItems: 1
> 
> We could make the checking of clocks more strict to show
> the intent:
> 
> adi,axi-dac-9.1.b only has 1 clock and clock-names is optional.
> 
> adi,axi-ad3552r always has 2 clocks and clock-names is required.
>
is this really necessary ? At v.6 would not fix things
not reallyh necessary.
 
> > +
> > +unevaluatedProperties: false
> >  
> >  examples:
> >    - |
> > @@ -57,6 +75,38 @@ examples:
> >          dmas = <&tx_dma 0>;
> >          dma-names = "tx";
> >          #io-backend-cells = <0>;
> > -        clocks = <&axi_clk>;
> > +        clocks = <&clkc 15>;
> > +        clock-names = "s_axi_aclk";
> > +    };
> > +
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    axi_dac: spi@44a70000 {
> > +        compatible = "adi,axi-ad3552r";
> > +        reg = <0x44a70000 0x1000>;
> > +        dmas = <&dac_tx_dma 0>;
> > +        dma-names = "tx";
> > +        #io-backend-cells = <0>;
> > +        clocks = <&clkc 15>, <&ref_clk>;
> > +        clock-names = "s_axi_aclk", "dac_clk";
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        dac@0 {
> > +            compatible = "adi,ad3552r";
> > +            reg = <0>;
> > +            reset-gpios = <&gpio0 92 GPIO_ACTIVE_HIGH>;
> > +            io-backends = <&axi_dac>;
> > +            spi-max-frequency = <66000000>;
> > +
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            channel@0 {
> > +                reg = <0>;
> > +                adi,output-range-microvolt = <(-10000000) (10000000)>;
> > +            };
> > +        };
> >      };
> >  ...
> > 
> 

Regards,
Angelo

