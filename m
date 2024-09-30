Return-Path: <linux-iio+bounces-9927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1898A4BA
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 15:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41101C214F7
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A518F2FF;
	Mon, 30 Sep 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g64jguXx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F76F18E755
	for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702603; cv=none; b=GQM96lm6nAvIeoX3yeiwdYes3In8edKuiiLvreaVd2Ms1T7p7mZz1CwUb2rj4HMyhLdHzDUYsmgwnOiokwvjhgPS9JeZN2VCSs2in4FWvyjLp0lIs+iVCqj+BMqPdB9KsTWnorqVc7qZHHOyCt7nUWowIX9gM37w972QU0vr134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702603; c=relaxed/simple;
	bh=TD5nsJEO87s8k15pJJrLLdvtzc8HdILshvqRAPu3kAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D70mnYnQzvWq2hElWbfWaLOIcuU3jSg3UHSbdpTiwzJeG1bUD/lDLn7rMqOmt6qgL1/hpj6i6pJA0J8Vp3mhOR/ILQlxNQe3CxlikwzU6sW21XY7vQHqhQVJmMtxqqF3Bzy1OyIxcJpWRi4udfiv8L8kRPEGUc6BHWlFH7xQlpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g64jguXx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so1011813f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727702599; x=1728307399; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v8aALHVnZj1Kp+N4c6fFSVc1huPgsI4DOtpW2kykrY4=;
        b=g64jguXxrFj/734g8eHUKL3zTQVWyivAt8qgBBMOwr6TDAcR1GL4O0k/KpIXUeoQhC
         1QFnD4IaJwk4vqbBDixmUpXmm9PWrWkK6DR3Cncl5XLOdvfDVnDs0gG6k4+QZAUr9x79
         uQKunLhv93SKag8rkDE8AIYbvRoBoubmqQluUAV5eQ0mIoE31ERBzHsLaX8a8htpQ45N
         UKLWQ3MWh6FRMSgULRlQTrAUCyY6cG30TEW6Op3RNwuIiyDPxqymbt9C0LzLJRmV+1Jw
         doM8bfOk8fQwepZ5QNg3dK8Wc8YTVe9WIVMdMr2yebGhen930xGi+anVA8KubsX7+FJV
         lAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727702599; x=1728307399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8aALHVnZj1Kp+N4c6fFSVc1huPgsI4DOtpW2kykrY4=;
        b=nXC0Ff4OBHEAO3tJDPv+PBRhzleCKfxoo6GyCIY2wKsMeX7/54H3xquvHT28vWBrBJ
         zqwPae7Rioh5ZmBf1c0clFiKjMqMiil9WL0TgzWp6fLWvxf2hV/v37ZoTgD3gZmRAHZ8
         R8IEKdk511+73wtO/11TP9JBCHSWff3LxeZ93MCwFjuW/bqO8lrru3zOY1IvMF6FPShZ
         tOJMNH5ovNBo3Rd6DJG5TvxCTwFFU489VTfiOJGtKMXEwvMJeusK6R+frF5n8BCpUuFA
         OD4zZ9WGQmBh+csxxdDEz2g93B+9DWI5ehmhhj4hNC4K/p2dGH1LETeOwtoV/Nale/6X
         CAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVycqCrIZ3z7OFpI7QpeEyVxbciLpxjLNXQXOOuCCHzNC3BF/rOjdXTlbofb20pRdcWobeLpHijoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94RvSyiWTf+Q4h76Z0XFtpzrza/Ovl4kfxskNH59AxhCBepPc
	9WWn+cqH/lRaZ7x4NrTs4JjjqIKia4zORLymtPXximew9HQamQCPIvAQmzXDQdA=
X-Google-Smtp-Source: AGHT+IHs02Fza2CNc5aFVwiEkAswoCvL6JOoeoOrkQlEDKsHm8sb372RONuAEAd/1L9QHIHl5Tej6w==
X-Received: by 2002:a05:6000:1246:b0:378:81aa:2653 with SMTP id ffacd0b85a97d-37cd5a69379mr9913107f8f.9.1727702598417;
        Mon, 30 Sep 2024 06:23:18 -0700 (PDT)
Received: from dfj (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6488sm9100192f8f.46.2024.09.30.06.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:23:17 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:22:01 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
Message-ID: <h7ajn5c7f4d7xtjd6jwayen2v5go2vyciwfebikoxlnksodvd2@4dph5nxigi56>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
 <gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
 <418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
 <e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
 <0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
 <fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
 <c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
 <28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
 <20240929115919.0318034c@jic23-huawei>
 <ae4cfdfb9880e0a833c105fcb9e9442ef04f461b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae4cfdfb9880e0a833c105fcb9e9442ef04f461b.camel@gmail.com>

On 30.09.2024 09:20, Nuno Sá wrote:
> On Sun, 2024-09-29 at 11:59 +0100, Jonathan Cameron wrote:
> > On Sat, 28 Sep 2024 14:20:29 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > 
> > > On 25/09/2024 13:55, Nuno Sá wrote:
> > > > On Wed, 2024-09-25 at 09:22 +0200, Krzysztof Kozlowski wrote:  
> > > > > On 24/09/2024 14:27, Nuno Sá wrote:  
> > > > > > On Tue, 2024-09-24 at 10:02 +0200, Krzysztof Kozlowski wrote:  
> > > > > > > On 23/09/2024 17:50, Angelo Dureghello wrote:  
> > > > > > > > Hi Krzysztof,
> > > > > > > > 
> > > > > > > > On 22/09/24 23:02, Krzysztof Kozlowski wrote:  
> > > > > > > > > On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo Dureghello
> > > > > > > > > wrote:  
> > > > > > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > > > > > 
> > > > > > > > > > There is a version AXI DAC IP block (for FPGAs) that provides
> > > > > > > > > > a physical bus for AD3552R and similar chips, and acts as
> > > > > > > > > > an SPI controller.
> > > > > > > > > > 
> > > > > > > > > > For this case, the binding is modified to include some
> > > > > > > > > > additional properties.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > > > > > ---
> > > > > > > > > >   .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 42
> > > > > > > > > > ++++++++++++++++++++++
> > > > > > > > > >   1 file changed, 42 insertions(+)
> > > > > > > > > > 
> > > > > > > > > > diff --git
> > > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > > > > > > > index 41fe00034742..aca4a41c2633 100644
> > > > > > > > > > ---
> > > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > > > > > > > +++
> > > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > > > > > > > @@ -60,6 +60,18 @@ properties:
> > > > > > > > > >       $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > > >       enum: [0, 1, 2, 3]
> > > > > > > > > >   
> > > > > > > > > > +  io-backends:
> > > > > > > > > > +    description: The iio backend reference.
> > > > > > > > > > +      An example backend can be found at
> > > > > > > > > > +       
> > > > > > > > > > https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> > > > > > > > > > +    maxItems: 1
> > > > > > > > > > +
> > > > > > > > > > +  adi,synchronous-mode:
> > > > > > > > > > +    description: Enable waiting for external synchronization
> > > > > > > > > > signal.
> > > > > > > > > > +      Some AXI IP configuration can implement a dual-IP
> > > > > > > > > > layout,
> > > > > > > > > > with
> > > > > > > > > > internal
> > > > > > > > > > +      wirings for streaming synchronization.
> > > > > > > > > > +    type: boolean
> > > > > > > > > > +
> > > > > > > > > >     '#address-cells':
> > > > > > > > > >       const: 1
> > > > > > > > > >   
> > > > > > > > > > @@ -128,6 +140,7 @@ patternProperties:
> > > > > > > > > >             - custom-output-range-config
> > > > > > > > > >   
> > > > > > > > > >   allOf:
> > > > > > > > > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > > > > >     - if:
> > > > > > > > > >         properties:
> > > > > > > > > >           compatible:
> > > > > > > > > > @@ -238,4 +251,33 @@ examples:
> > > > > > > > > >               };
> > > > > > > > > >           };
> > > > > > > > > >       };
> > > > > > > > > > +
> > > > > > > > > > +  - |
> > > > > > > > > > +    axi_dac: spi@44a70000 {
> > > > > > > > > > +        compatible = "adi,axi-ad3552r";  
> > > > > > > > > That is either redundant or entire example should go to the
> > > > > > > > > parent
> > > > > > > > > node,
> > > > > > > > > if this device is fixed child of complex device (IOW,
> > > > > > > > > adi,ad3552r
> > > > > > > > > cannot
> > > > > > > > > be used outside of adi,axi-ad3552r).  
> > > > > > > > 
> > > > > > > > ad3552r can still be used by a generic "classic" spi
> > > > > > > > controller (SCLK/CS/MISO) but at a slower samplerate, fpga
> > > > > > > > controller only (axi-ad3552r) can reach 33MUPS.  
> > > > > > > 
> > > > > > > OK, then this is just redundant. Drop the node. Parent example
> > > > > > > should
> > > > > > > contain the children, though.  
> > > > > > > >  
> > > > > > > > >  
> > > > > > > > > > +        reg = <0x44a70000 0x1000>;
> > > > > > > > > > +        dmas = <&dac_tx_dma 0>;
> > > > > > > > > > +        dma-names = "tx";
> > > > > > > > > > +        #io-backend-cells = <0>;
> > > > > > > > > > +        clocks = <&ref_clk>;
> > > > > > > > > > +
> > > > > > > > > > +        #address-cells = <1>;
> > > > > > > > > > +        #size-cells = <0>;
> > > > > > > > > > +
> > > > > > > > > > +        dac@0 {
> > > > > > > > > > +            compatible = "adi,ad3552r";
> > > > > > > > > > +            reg = <0>;
> > > > > > > > > > +            reset-gpios = <&gpio0 92 0>;  
> > > > > > > > > Use standard defines for GPIO flags.  
> > > > > > > > 
> > > > > > > > fixed, thanks
> > > > > > > >  
> > > > > > > > > > +            io-backends = <&axi_dac>;  
> > > > > > > > > Why do you need to point to the parent? How much coupled are
> > > > > > > > > these
> > > > > > > > > devices? Child pointing to parent is not usually expected,
> > > > > > > > > because
> > > > > > > > > that's obvious.  
> > > > > > > > 
> > > > > > > > 
> > > > > > > > "io-backends" is actually the way to refer to the backend module,
> > > > > > > > (used already for i.e. ad9739a),
> > > > > > > > it is needed because the backend is not only acting as spi-
> > > > > > > > controller,
> > > > > > > > but is also providing some APIs for synchronization and bus setup
> > > > > > > > support.  
> > > > > > > 
> > > > > > > 
> > > > > > > But if backend is the parent, then this is redundant. You can take
> > > > > > > it
> > > > > > > from the child-parent relationship. Is this pointing to other
> > > > > > > devices
> > > > > > > (non-parent) in other ad3552r configurations?
> > > > > > >  
> > > > > > 
> > > > > > The backend is a provider-consumer type of API. On the consumer side
> > > > > > (which
> > > > > > is the
> > > > > > driver the child node will probe on), we need to call
> > > > > > devm_iio_backend_get()
> > > > > > to get
> > > > > > the backend object (which obviously is the parent). For that, 'io-
> > > > > > backends'
> > > > > > is being  
> > > > > 
> > > > > You described the driver, so how does it matter? Driver can call
> > > > > get_backend_from_parent(), right? Or get_backend_from_fwnode(parent)?  
> > > > 
> > > > Well yes, just stating what the framework (also in terms of bindings) is
> > > > expecting. Of course that on the driver side we can paper around it the
> > > > way we
> > > > want. But my main point was that we can only paper around it if we use
> > > > code that
> > > > is meant not to be used.
> > > > 
> > > > And, FWIW, I was (trying) replying to your comment
> > > > 
> > > > "You can take it from the child-parent relationship"
> > > > 
> > > > Again, we can only do that by introducing new code or use code that's not
> > > > meant
> > > > to be used. The way we're supposed to reference backends is by explicitly
> > > > using
> > > > the proper FW property.
> > > > 
> > > > Put it in another way and a completely hypothetical case. If we have a spi
> > > > controller which happens to export some clock and one of it's peripherals
> > > > ends
> > > > up using that clock, wouldn't we still use 'clocks' to reference that
> > > > clock?  
> > > 
> > > I asked how coupled are these devices. Never got the answer and you are
> > > reflecting with question. Depends. Please do not create hypothetical,
> > > generic scenarios and then apply them to your one particular opposite case.
> > 
> > I'll throw a possible clarifying question in here.  Could we use this
> > device with a multimaster SPI setup such that the control is on a conventional
> > SPI controller (maybe a qspi capable one), and the data plane only goes
> > through
> > a specific purpose backend?  If so, then they are not tightly coupled and
> > the reference makes sense.  Putting it another way, the difference between
> > this case and all the prior iio-backend bindings is the control and dataplanes
> > use the same pins.  Does that have to be the case at the host end?  If it
> > does,
> > then the reference isn't strictly needed and this becomes a bit like
> > registering a single device on an spi bus or an i2c bus depending on who
> > does the registering (which is down to the parent in DT).
> > 
> 
> So, we currently have two drivers (with a new one being added in this series)
> for the same device:
> 
> 1) A SPI one tied to a typical spi controller. This is the "low speed"
> implementation and does not use backends;
> 2) The new platform device that is connected like this to the backend.
> 
> So yes, my understanding (but Angelo should know better :)) is that they are
> tightly coupled. Putting it in another way, the new platform device is very much
> specific to this parent (and yeah, this is a very special usecase where control
> and data planes are controlled by the IIO backend) and should not exist with it.

ad3552r device can be coupled to the axi-ad3552r controller or to a generic 
spi controler.

We have actually 2 drivers, SPI and platform (for AXI controller, in this patch).

Scenario 1 (SPI):
ad3522r can hypotetically work with whatever simple spi controller that can
read/write registers in raw mode. On simple SPI (CS, SCLK, MOSI), due to ad3552r
chip limitation of 66Mhz clock, the maximum 33MUPS (16 bit samples) cannot be
reached. Some QSPI DDR controller seems to be around, in that case, ad3552r
may work extending the SPI driver. 

Scenario 2 (AXI):
From an hardware-only point ov view axi-ad3552r IP acts as QSPI+DDR controller
plus some additional features for stream synchronization.
From a sowftware point of view, really different from a spi controller driver.
It's just a backend with APIes that can be called from the child driver.


> 
> - Nuno Sá
> 

Regards,
Angelo

-- 

  o/ QW5nZWxvIER1cmVnaGVsbG8=
   www.kernel-space.org
    e: angelo at kernel-space.org
      c: +39 388 8550663
       

