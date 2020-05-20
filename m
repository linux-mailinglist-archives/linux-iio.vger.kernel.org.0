Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A7C1DABB0
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 09:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgETHLj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 03:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgETHLi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 03:11:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBF6C061A0E;
        Wed, 20 May 2020 00:11:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s1so2567358qkf.9;
        Wed, 20 May 2020 00:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4kMZwt7hLj0a0i78rLlrC0uhyzE2he9fQ+UceU6WqVc=;
        b=KosTd6/JNSn15SEyXSlM87oFPIIUNoIGfb3SOSCY0mfuaVmzGUIWJgQIuHWIi02EJJ
         8ycptt0cK0I4ZRZU8XuMnv7nmS+a+oyz0TQr/4hwmXGVg7/rPxDAvlMEsWxvwyO0Re7G
         zq47tEdzIf1mKQhR2LbgaYf6dUmftwV0/SwoNJrX8EfMsJJyZhozxKd7VtrtzVRDJ1gF
         uHNdr+EGuePQ5x/T9wU0FrthRtvKUpdZT/P9e5EqptEcEseac87DnWo+uwNaWyIoSOEc
         WIaW5p9RN+3wXrev+zPH+lMJZqK3k6kguQTFGRM9jzd2H2XL558hI/Q/BJ/jqdY4MIwH
         JpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4kMZwt7hLj0a0i78rLlrC0uhyzE2he9fQ+UceU6WqVc=;
        b=cPMa9xqV9hsKoFGqBeCiTHM3PtgN07XYuh7C5KLjE4LyaYIOptfNYi39rJZarIvf4j
         519RTW8dAQWkLsgXYpD9SrZPdVDRg22S37QAprxQ9yLwLg0AaHgBMg5t8si14qydUV2F
         +Q/iud4remjsMRNY6fkuNf1WQXnIVk8jqAfnMnB2zXamVFGgCPeR5wJfsUJmTGWZDW+h
         S9ygudIM15UQ0PZVh3ICDxEq9GlZWXM0yrzmSq8G75v25LUfJ37AJMG9omnpS3N0wK0p
         uk0dZi5VzVjyz4dt/GZomHV16Cfz3GCQbfLWj0h1BinXduHk521XkbrSstHHYLV7RXrO
         FAeQ==
X-Gm-Message-State: AOAM533DSiF2jMndq5sev+FcFoDfn04V7/7TNaCZIls7CzONrtbpz/ZE
        8uB2HZILNwR37zscnaInze0pt4eNyHk=
X-Google-Smtp-Source: ABdhPJypTB9RDD9OIz7alG1vAOP0vhgAKYJB8Leb0qiiTKLILFiMl3L9tpHdEABTuAmo0RhHFy0AcQ==
X-Received: by 2002:a37:7904:: with SMTP id u4mr3267987qkc.297.1589958697405;
        Wed, 20 May 2020 00:11:37 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id l2sm1541908qkd.57.2020.05.20.00.11.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 00:11:36 -0700 (PDT)
Date:   Wed, 20 May 2020 09:11:33 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: imu: bmi160: add regulators and
 mount-matrix
Message-ID: <20200520071133.GC3361@ict14-OptiPlex-980>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-3-jonathan.albrieux@gmail.com>
 <20200519185159.00001bd1@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519185159.00001bd1@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 06:51:59PM +0100, Jonathan Cameron wrote:
> On Tue, 19 May 2020 09:50:58 +0200
> Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> 
> > Add vdd-supply and vddio-supply support.
> > Add mount-matrix support.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> 
> A few minor comments inline.
> 
> > ---
> >  .../devicetree/bindings/iio/imu/bmi160.yaml   | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > index 6b464ce5ed0b..5b13af7a209f 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/bmi160.yaml
> > @@ -46,6 +46,21 @@ properties:
> >        set if the specified interrupt pin should be configured as
> >        open drain. If not set, defaults to push-pull.
> >  
> > +  vdd-supply:
> > +    maxItems: 1
> > +    description: |
> > +      an optional regulator that needs to be on to provide VDD power to
> > +      the sensor.
> 
> They aren't optional.  Whether we specify them or rely on stub regulators
> being provided because they aren't controllable is the optional bit.
> That's clearly defined by them not being in the required list below.
> So say something li.e
> 
>    description: |
>       provide VDD power to the sensor.
>

Oh ok thank you, will work on that

> > +
> > +  vddio-supply:
> > +    maxItems: 1
> > +    description: |
> > +      an optional regulator that needs to be on to provide the VDD IO power to
> > +      the sensor.
> > +
> > +  mount-matrix:
> > +    description: an optional 3x3 mounting rotation matrix
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -61,9 +76,15 @@ examples:
> >          bmi160@68 {
> >                  compatible = "bosch,bmi160";
> >                  reg = <0x68>;
> > +                vdd-supply = <&pm8916_l17>;
> > +                vddio-supply = <&pm8916_l6>;
> >                  interrupt-parent = <&gpio4>;
> >                  interrupts = <12 1>;
> >                  interrupt-names = "INT1";
> > +                mount-matrix = "0", "1", "0",
> > +                               "-1", "0", "0",
> > +                               "0", "0", "1";
> > +                };
> >          };
> >    - |
> >      // Example for SPI
> 
> 
