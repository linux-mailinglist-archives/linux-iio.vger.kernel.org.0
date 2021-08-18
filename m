Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19A3F0986
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 18:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhHRQr5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 12:47:57 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46689 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhHRQr4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Aug 2021 12:47:56 -0400
Received: by mail-ot1-f44.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso4792682ott.13;
        Wed, 18 Aug 2021 09:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j0COdwY+LwNbiT05EEFfsZ6YGMRmfOmxQE25nJ5E1X8=;
        b=J1mjRuQ2l8qrIUJyY9a8EOKxxX4ynyo3nulIpNRCIjO3dwZA1uMLCdnZIlVtfHjSMw
         +l/QYqhyHXbCoR60aYXcoXCnq3riuBATRflmmGXinqQNymzL+xrRaRSuuCr2Lai6+s9Z
         V2UN1i/FPXtpNNuuxN/gX6BRD9dee5QOyjo1Ll4ViCPG3cgV0mOCJ/Pf9AnLxikCMyfI
         m52i+aDQSZBZjln0Wi1xGVfgW/ntjxh2WW9JJ6yfJSqaq4F4kGKVj4YYVDHc6V5V4rUT
         BwojlQdlSGKAkzDFrOjIWQUaOaUazsJo1hkseqetnKSIQUNGtzr0ijZafzw7Hx1hKKVI
         YLSw==
X-Gm-Message-State: AOAM532VoSAJllp0K2R9CLu9XA8rLAy9gN2BK1h7plkkYe0TqDAxbxrv
        zfZ5Uw4zxGsOuKKPCXOF2g==
X-Google-Smtp-Source: ABdhPJzkg2lx1H4O5RvVHGlK3kWAC1/6V0FqV1zP65jVBbxk/Lpw/pHyxl8g+jNVT6EOmlqL09rayw==
X-Received: by 2002:a9d:6848:: with SMTP id c8mr7835204oto.364.1629305241740;
        Wed, 18 Aug 2021 09:47:21 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m15sm122245oiw.18.2021.08.18.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 09:47:21 -0700 (PDT)
Received: (nullmailer pid 2741413 invoked by uid 1000);
        Wed, 18 Aug 2021 16:47:20 -0000
Date:   Wed, 18 Aug 2021 11:47:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Document
 senseair,sunrise CO2 sensor
Message-ID: <YR05mNB9LDoeotkj@robh.at.kernel.org>
References: <20210817154951.50208-1-jacopo@jmondi.org>
 <20210817154951.50208-2-jacopo@jmondi.org>
 <YRvo5qCWrBT1x7V+@smile.fi.intel.com>
 <20210818072943.zgj6nibmvpnd2ffu@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818072943.zgj6nibmvpnd2ffu@uno.localdomain>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 18, 2021 at 09:29:43AM +0200, Jacopo Mondi wrote:
> Hi Andy,
> 
> On Tue, Aug 17, 2021 at 07:50:46PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 17, 2021 at 05:49:50PM +0200, Jacopo Mondi wrote:
> > > Add documentation for the Senseair Sunrise 006-0-0007 CO2 NDIR sensor.
> >
> > > +  ndry-gpios:
> > > +    description: Phandle to the GPIO line connected to the nDRY pin. Active low.
> > > +
> > > +  en-gpios:
> > > +    description: Phandle to the GPIO line connected to the EN pin. Active high.
> >
> > Not sure you have to mention polarity. It can be changed on PCB level easily
> > and this bindings won't satisfy those (valid) changes.
> 
> Well, one can indeed invert the signal on the PCB, it's weird I see most of
> the bindings reporting the pin's active polarity though...
> 
> I'll drop it.

I'd keep it. It's documenting the pin on the h/w. You can prefix with 
'Typically' if you want.

Rob
