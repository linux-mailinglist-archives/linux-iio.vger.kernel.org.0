Return-Path: <linux-iio+bounces-14735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01588A231A6
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 17:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E253A7562
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2C71EBA19;
	Thu, 30 Jan 2025 16:16:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182ED322B;
	Thu, 30 Jan 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253773; cv=none; b=WgeExucPvMASYjF4jwUcTtFtqbogfZ/02sbY0/l3tThFoJ47XtdsWUXasW2EHPbLNwFCFMRVdy14fZtLFaZ5Jrt5lVdyMmLr2xDJowcPL0ToLyy3PFw38pAJFtfdH1b2j+PjfO2U+nrvtekJoXLRyqE7DZCcJQT6nUvv5eE4LQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253773; c=relaxed/simple;
	bh=Tbs3hb+PLJ8gGkI6hjrRBbzVJ2ayt0TZX5Dv/HBbtxo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TY7JWZ+cq0dbojhbwQh9+awzdkSC81FDKRSGyvOBJOJLHpvTB7DPUVw3h6RZ6VHd9EaKRVAbTPEWLk3VYeEkAGI15B5t0flM9eor93W0pVk7edVP+g3cRFW6iR/dnj/KPhnHrhpRoa5F71hHhWFqkBwLKNDzZdlqE0lgG38woIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkPJK31vmz6K5pk;
	Fri, 31 Jan 2025 00:15:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 91AD2140D1D;
	Fri, 31 Jan 2025 00:16:08 +0800 (CST)
Received: from localhost (10.195.245.124) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 17:16:07 +0100
Date: Thu, 30 Jan 2025 16:16:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: <0044dd4b-01ce-4ca0-9855-8c239b9bfb6f@baylibre.com>, Jonathan Santos
	<Jonathan.Santos@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lars@metafoo.de>, <Michael.Hennerich@analog.com>,
	<marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 02/16] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250130161606.0000514c@huawei.com>
In-Reply-To: <a6e57474-6eff-4f7b-8204-8137f95a33e7@baylibre.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	<f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com>
	<0044dd4b-01ce-4ca0-9855-8c239b9bfb6f@baylibre.com>
	<Z5jx9mJdi3Zh7Mx6@JSANTO12-L01.ad.analog.com>
	<a6e57474-6eff-4f7b-8204-8137f95a33e7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 28 Jan 2025 09:56:37 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/28/25 9:04 AM, Jonathan Santos wrote:
> > On 01/27, David Lechner wrote:  
> >> On 1/27/25 9:11 AM, Jonathan Santos wrote:  
> >>> Add a new trigger-sources property to enable synchronization across
> >>> multiple devices. This property references the main device (or
> >>> trigger provider) responsible for generating the pulse to drive the
> >>> SYNC_IN of all devices in the setup.
> >>>
> >>> In addition to GPIO synchronization, The AD7768-1 also supports
> >>> synchronization over SPI, which use is recommended when the GPIO
> >>> cannot provide a pulse synchronous with the base MCLK signal. It
> >>> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> >>> a command via SPI to trigger the synchronization.
> >>>
> >>> SPI-based synchronization is enabled in the absence of adi,sync-in-gpios
> >>> property. Since adi,sync-in-gpios is not long the only method, remove it
> >>> from required properties.
> >>>
> >>> While at it, add description to the interrupt property.
> >>>
> >>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> >>> ---
> >>> v2 Changes:
> >>> * Patch added as replacement for adi,sync-in-spi patch.
> >>> * addressed the request for a description to interrupts property.
> >>> ---
> >>>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 22 +++++++++++++++++--
> >>>  1 file changed, 20 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> >>> index 3ce59d4d065f..3e119cf1754b 100644
> >>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> >>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> >>> @@ -26,7 +26,17 @@ properties:
> >>>    clock-names:
> >>>      const: mclk
> >>>  
> >>> +  trigger-sources:
> >>> +    description:
> >>> +      References the main device responsible for synchronization. In a single
> >>> +      device setup, reference the own node.
> >>> +    maxItems: 1  
> >>
> >> We probably actually need 2 here. One for /SYNC_IN and one for a GPIO3 pin
> >> acting as the /START signal.
> >>  
> >>> +
> >>>    interrupts:
> >>> +    description:
> >>> +      Specifies the interrupt line associated with the ADC. This refers
> >>> +      to the DRDY (Data Ready) pin, which signals when conversion results are
> >>> +      available.
> >>>      maxItems: 1
> >>>  
> >>>    '#address-cells':
> >>> @@ -46,6 +56,8 @@ properties:
> >>>        sampling. A pulse is always required if the configuration is changed
> >>>        in any way, for example if the filter decimation rate changes.
> >>>        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> >>> +      In the absence of this property, Synchronization over SPI will be
> >>> +      enabled.  
> >>
> >> Isn't /SYNC_OUT connected to /SYNC_IN required for synchronization over SPI?
> >>
> >> If yes, instead of adding this text, I would make the binding have:
> >>  
> > 
> > Yes, but the synchronization over SPI is enabled in the absence of the GPIO.
> > The trigger-sources property would indicate if the sync provider is the
> > own device or not. As i said below, maybe i misunderstood.
> >   
> >> oneOf:
> >>   - required:
> >>       - trigger-sources
> >>   - required:
> >>        - adi,sync-in-gpios
> >>  
> > 
> > Wouldn't be simpler to consider the absence of sync-in-gpio? this way we
> > have less changes in the ABI.  
> 
> Maybe it is me that missed something, but if I'm reading the datasheet
> correctly, then sync over SPI only works if /SYNC_IN is wired to /SYNC_OUT.
> And the chip isn't going to work correctly without some sort of sync. So we
> need something wired to /SYNC_IN no matter what.
> 
> In any case, the DT bindings should just say how the chip is wired up and not
> dictate how the driver should behave. So what I was going for with this is to
> have the bindings say that something has to be wired to /SYNC_IN and we can
> leave it up to the driver to decide what to do with this information.

I was seeing this more like an optional clock / supply etc.
If we don't provide it we assume the driver knows what to do.

So in this case lack of sync in routing off to another device means
to me it is connected to sync out.

I don't mind the self trigger thing if it fits nicely in the binding
though as we are using a trigger that is provided for other chips anyway.

So wired to sync in of this chip and potentially sync in of another
N chips.


> 
> >   
> >>>  
> >>>    reset-gpios:
> >>>      maxItems: 1
> >>> @@ -57,6 +69,9 @@ properties:
> >>>    "#io-channel-cells":
> >>>      const: 1
> >>>  
> >>> +  "#trigger-source-cells":
> >>> +    const: 0
> >>> +
> >>>  required:
> >>>    - compatible
> >>>    - reg
> >>> @@ -65,7 +80,8 @@ required:
> >>>    - vref-supply
> >>>    - spi-cpol
> >>>    - spi-cpha
> >>> -  - adi,sync-in-gpios
> >>> +  - trigger-sources
> >>> +  - #trigger-source-cells
> >>>  
> >>>  patternProperties:
> >>>    "^channel@([0-9]|1[0-5])$":
> >>> @@ -99,7 +115,7 @@ examples:
> >>>          #address-cells = <1>;
> >>>          #size-cells = <0>;
> >>>  
> >>> -        adc@0 {
> >>> +        adc0: adc@0 {
> >>>              compatible = "adi,ad7768-1";
> >>>              reg = <0>;
> >>>              spi-max-frequency = <2000000>;
> >>> @@ -109,6 +125,8 @@ examples:
> >>>              interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> >>>              interrupt-parent = <&gpio>;
> >>>              adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;  
> >>
> >> Don't we need to drop adi,sync-in-gpios here? I don't think we would have two
> >> things connected to /SYNC_IN at the same time.
> >>  
> > 
> > I guess i misunderstood the use of trigger-sources. I thought it would
> > indicate the trigger provider or main device. Like if it points to other
> > device we should use it to drive the SYNC_IN of all devices.
> > 
> > Then what happens if the trigger-sources points to other node? we would't be
> > able to driver the SYNC_IN in case of any configuration change?  
> 
> I think you understand the trigger-source bindings correctly. 
> 
> The driver doesn't have to support everything that the DT bindings allow. This
> series is big enough already, so we can defer figuring out how to implement
> triggers other than the loopback case later. :-) We just want to make the DT
> bindings as complete as we can now.
> 
> >   
> >>> +            trigger-sources = <&adc0>;
> >>> +            #trigger-source-cells = <0>;
> >>>              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> >>>              clocks = <&ad7768_mclk>;
> >>>              clock-names = "mclk";  
> >>  
> 
> 
> 


