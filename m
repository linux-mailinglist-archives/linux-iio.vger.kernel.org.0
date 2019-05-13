Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3AA1BBD7
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2019 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfEMRZU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 May 2019 13:25:20 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38902 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfEMRZU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 May 2019 13:25:20 -0400
Received: by mail-oi1-f196.google.com with SMTP id u199so9957826oie.5;
        Mon, 13 May 2019 10:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d0iLbtZzmYoVAPbjQTYLL9twcU59loeNQIQfMnUhkqo=;
        b=jkMD/vCP41ZPJwxochwBj3ilEHABK8bQTslIjQV77q5KT2PDcFt8Q44P07vKVEpsBh
         08CUP+Fz28t7lJg7qOOKt7B5U/wb3FpDL6/V29tM4k0BgbpbhXcmeokxaotZx0at6tJD
         69C94ZTrblS4bYOkWFO8Bs8IrACpMBXk0Hi3wEqJPUnkdxYu47wGK/LxnZPfyLxPlRQV
         z/hRXMiZ5A59VwG1bbdqj1KXNg8Ft09LgnAotV5N/zrJFBgN6E27VSAR0G4JS10OqLpk
         j+A5CQInlA8aIRNa2O9XfdLUHoDLzvMIrx4spYuFEz8TM1WAzigyVDqh6zSoDEuGw5eG
         CdRw==
X-Gm-Message-State: APjAAAX3rMQvGugBwkTdfwDIDS57nmcdBweETdVweHdw+uWU9Os5Cri/
        Fa1O1n8aiJ0meTRudIxLSA==
X-Google-Smtp-Source: APXvYqw6lh5d9lYMNWlfNBmVFNQ4Tdmmm6IISzTsWxcwNAQ5yJhaKXqyJCTgZjPekvsZEooxcbaP3w==
X-Received: by 2002:aca:add3:: with SMTP id w202mr176421oie.126.1557768319223;
        Mon, 13 May 2019 10:25:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h64sm5358393oif.4.2019.05.13.10.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 10:25:18 -0700 (PDT)
Date:   Mon, 13 May 2019 12:25:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC][PATCH] dt-bindings: iio: accel: add adi,adxl345.yaml
 binding
Message-ID: <20190513172517.GA1637@bogus>
References: <20190506114610.28083-1-alexandru.ardelean@analog.com>
 <CAL_JsqL-jKM-qpawVoaLaqTpZhqNNFmgAOjv_azSwOU6zFS08g@mail.gmail.com>
 <fdf60ff605e040ef24ae10c1e0b3b522de6ef9ab.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf60ff605e040ef24ae10c1e0b3b522de6ef9ab.camel@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 06, 2019 at 02:29:54PM +0000, Ardelean, Alexandru wrote:
> On Mon, 2019-05-06 at 09:17 -0500, Rob Herring wrote:
> > [External]
> > 
> > 
> > On Mon, May 6, 2019 at 6:46 AM Alexandru Ardelean
> > <alexandru.ardelean@analog.com> wrote:
> > > 
> > > This patch adds a YAML binding for the Analog Devices ADXL345 I2C/SPI
> > > accelerometer.
> > > 
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > > 
> > > And now for the RFC part.
> > > Normally, I would dig into source-code to try to figure this out, but
> > > at
> > > this point-in-time, I am low on time/energy to do this.
> > > And maybe this helps trigger a discussion about this.
> > > 
> > > Apologies if this has been coverted on the devicetree mailing list, but
> > > at least we'd get some coverage on the IIO list (with this).
> > > 
> > > The ADXL345 device (as others) supports both I2C & SPI interfaces.
> > > 
> > > Question1: do we write 2 YAML files, or 1 ? I was looking at Zephyr
> > > (for
> > > some ideas/reference) but it seems to me that the YAML DT binding
> > > format is
> > > different than this one ? They write 2 files for ADXL372 (1 for SPI, 1
> > > for
> > > I2C).
> > > 
> > > Question1-a: one thing is that SPI requires some props to be `required`
> > > that would not be required for the I2C binding. This could be solved by
> > > doing 2 files, but if doing 1 YAML file, is there a way to do
> > > conditional
> > > `required` ? i.e. property is required if `SPI` ? not sure how to check
> > > for
> > > SPI vs I2C, it would be interesting (at some point) to somehow enforce
> > > SPI/I2C bindings correctness.
> > 
> > The challenge here is there's not really any way for the schema to
> > know which bus it is. The only ways to know this are knowing all
> > possible spi or i2c controller compatibles or using the parent node
> > name (which hasn't been strictly enforced). In order to get this
> > information available to the schema, we'd need to add the information
> > to the node. We do this with '$nodename'. We could add a '$bus'
> > property for example. The tools would have to understand different
> > buses and things like I2C muxes complicate doing that.
> > 
> > Once you have something like $bus available, you could either have 2
> > files with a custom 'select' that checks compatible and $bus or we
> > could have 1 file using if/then/else keywords. However, we don't yet
> > support if/then/else json-schema that was added in draft7, but that's
> > being worked on by Maxime Ripard.
> > 
> > However, for this case, I'd just not worry about the issue. Really,
> > spi-cpha and spi-cpol should not be required. If only 1 mode is
> > supported, the driver can know that. IOW, it is implied by the
> > compatible strings.
> > 
> > 
> > > Question2: `make dt_binding_check` seems to generate only the first
> > > example. Is this known behavior, or do I need to take something else
> > > into
> > > consideration ?
> > 
> > That's correct. I haven't figured out how to do a variable number of
> > examples in kbuild.
> 
> Then, would it be fine to have multiple examples, and wait for this to pop-
> in the YAML dt stuff at a later point in time ?
> Or, just 1 example ?

I've now fixed this by extracting each example into a sub-node in the 
generated dts file, so multiple examples are fine now. The only 
restriction is labels can't be repeated.

Rob
