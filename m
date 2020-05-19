Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E2A1D9907
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgESOJj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgESOJj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 10:09:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F52C08C5C0;
        Tue, 19 May 2020 07:09:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z72so3767530wmc.2;
        Tue, 19 May 2020 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ieDlz4aqwf0/0wrYIdBm1ppFOEhF3MtntEZgJd2AFUQ=;
        b=AzO4lgXA6CB3e3NLyn+DtxyUqjJoYHxyOUXN0dw6fzOpuWudf7FfzlAc7rePX/9O8+
         hPFohHOk2lBHgSq84/hvvbjnTNKWhhlpXy3Ij8CrpGPqQvu6f2ZBnINYR+GCDNIZk0Sh
         FsciBfnhcbnol75ghooeA1wUrSlfFAfQ2mROThdihhSZOSBJUDkTCxtQEoikGgcrTYTs
         8s6Qt1ZRpJniok3AZuJOv5McRtEpiVglLYgNTsyc8tAhF52npbSkDLQbANtRCW+zk9A3
         YzzJwTidx51bMNLKkbGBiNhqYkm8Uh0Hjb3/pCJhT6muzU3ihTwubxr1oFHAinQlrs/k
         hX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ieDlz4aqwf0/0wrYIdBm1ppFOEhF3MtntEZgJd2AFUQ=;
        b=cVtE2C1SUcSEa9bfiRYJUBX5C6rAWuQ+WlPMHQg2asP4d8jMUufoaAF94IIdtMP1/T
         k6tDjV41ndkEwx8tbd1TAyIT4w6noa4Q9JSFlRv0gTgCrP61CaxEoS+N9aHAZEOI+Flq
         yEnPf/cHuqzvWK56Ln/wrnRZsF6vtBL9JMAWuYbiDmDVygcZUvyOd83VPkNarDScGz/r
         QqMwg1MW5xLo15ff+fK7MUt5lFMgfd4W4skfuXI7wJNOuXXdY6PWbDLLSACXjuXBKJow
         9b3ZL6/G/ng97GHq/GfQH/rqfik4na5xbX/nDbQt2WPVAj/s9612cSMQoAHi8/KM8fLJ
         1x8Q==
X-Gm-Message-State: AOAM5333WiISY5No2/u6vJFJJ7rE1WHwf2m+8QE6q3yw7eUIG8jj9k/6
        LKJ7uU8mCtKj/ChWodWtdMw=
X-Google-Smtp-Source: ABdhPJy7q9J16sCXJITd75eu5Jgw4zyATN/KHypDzge1JYnzEhWsFG83oZ0nCxKHOdwZEF+q2bY4Hw==
X-Received: by 2002:a05:600c:14c6:: with SMTP id i6mr5618622wmh.58.1589897377165;
        Tue, 19 May 2020 07:09:37 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id x5sm22255722wro.12.2020.05.19.07.09.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 07:09:33 -0700 (PDT)
Date:   Tue, 19 May 2020 16:09:30 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: magnetometer: ak8975: add gpio
 reset support
Message-ID: <20200519140930.GC30573@ict14-OptiPlex-980>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-3-jonathan.albrieux@gmail.com>
 <20200519132354.GB4623@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519132354.GB4623@gerhold.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 03:23:54PM +0200, Stephan Gerhold wrote:
> On Tue, May 19, 2020 at 02:43:52PM +0200, Jonathan Albrieux wrote:
> > Add reset-gpio support.
> > 
> > Without reset's deassertion during ak8975_power_on(), driver's probe fails
> > on ak8975_who_i_am() while checking for device identity for AK09911 chip.
> > 
> > AK09911 has an active low reset gpio to handle register's reset.
> > AK09911 datasheed says that, if not used, reset pin should be connected
> 
> datasheed -> datasheet
>

Will fix that soon
 
> > to VID. This patch emulates this situation.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/magnetometer/ak8975.yaml          | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> > index 86e3efa693a8..a82c0ff5d098 100644
> > --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> > +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> > @@ -37,6 +37,9 @@ properties:
> >    mount-matrix:
> >      description: an optional 3x3 mounting rotation matrix
> >  
> > +  reset-gpio:
> > +    description: an optional pin needed for AK09911 to set the reset state
> 
> Maybe add a comment that this should be "usually active low".
> 
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -53,6 +56,7 @@ examples:
> >              reg = <0x0c>;
> >              gpios = <&gpj0 7 0>;
> >              vdd-supply = <&ldo_3v3_gnss>;
> > +            reset-gpio = <&msmgpio 111 1>;
> 
> Same here, reset-gpio = <&msmgpio 111 GPIO_ACTIVE_LOW>,
> would be more clear.
> 
> >              mount-matrix = "-0.984807753012208",  /* x0 */
> >                             "0",                   /* y0 */
> >                             "-0.173648177666930",  /* z0 */
> > -- 
> > 2.17.1

Thank you for the suggestions, will work on them,

Best regards,
Jonathan Albrieux
