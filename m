Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A63DABA6
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 21:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhG2TKg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 15:10:36 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:43683 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhG2TKf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 15:10:35 -0400
Received: by mail-il1-f169.google.com with SMTP id x7so3649158ilh.10;
        Thu, 29 Jul 2021 12:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/jVC4lwu9NX1+RcKppSwkG4HOUyiiRAlyHtWepGRS2k=;
        b=DFWVaO6stxA1LWftLpJm6hN6DYJj6hlYBNInAek3NpWkyMBxEGW4kjxPV3zaVGuUMX
         f07Pg8HLnW8Qza1KP7rbRGyxJknXcQZb+dzz5RVqTHSbCfyrhjRQFQoPjeVQDNhe/bDS
         Xn/sfacdKghhPbW6rvQgJrUOsnBKhh3NQdLOqlZsl/6nH54cbYYeTWQzZ6nMkA5raXor
         OZrgC0+HUAiLDCwEQTQVgq0fEDRzVwc7SmaGBnHJBBY0T+aEDfBw7KODCXT+8sPyZti4
         qZ1KwHvitS1kCufaGO4LFtglPuAnnBswoRonwqFBkKSS09MkX5Itw8uloOmLi+Hvw+eN
         mW/Q==
X-Gm-Message-State: AOAM5312u7pzQMowcsc9Fv3ZTtuV3evx9h7gqQoPPaROrLiBplI+enCc
        00Xy6xVoUkM7Fmxez6MH0Q==
X-Google-Smtp-Source: ABdhPJz1H5DLok2GNP4C+G2IaZNKJoTioK4hfjVitG2bUuKNB2mkJ2P2wG29aSyVvSHnz+3m5UTXXg==
X-Received: by 2002:a92:d8d1:: with SMTP id l17mr4667124ilo.187.1627585831972;
        Thu, 29 Jul 2021 12:10:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r198sm2916970ior.7.2021.07.29.12.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:10:31 -0700 (PDT)
Received: (nullmailer pid 707339 invoked by uid 1000);
        Thu, 29 Jul 2021 19:10:29 -0000
Date:   Thu, 29 Jul 2021 13:10:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH 2/4] dt-bindings: iio: accel: bma255: Add
 bosch,bmc156_accel
Message-ID: <YQL9JSmpYq7Ht4FS@robh.at.kernel.org>
References: <20210719112156.27087-1-stephan@gerhold.net>
 <20210719112156.27087-3-stephan@gerhold.net>
 <20210724170318.771cbeeb@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724170318.771cbeeb@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 24, 2021 at 05:03:18PM +0100, Jonathan Cameron wrote:
> On Mon, 19 Jul 2021 13:21:54 +0200
> Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > BMC156 is very smilar to BMC150, but it has only one accelerometer
> > interrupt pin. It would make sense if only INT1 was exposed but someone
> > at Bosch was crazy and decided to only have an INT2 pin.
> > 
> > In this case, it does not make sense if the first interrupt pin is
> > treated as INT1 (since that pin does not exist). Add a note to the
> > bindings that the first interrupt pin is treated as INT2 for BMC156.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  .../bindings/iio/accel/bosch,bma255.yaml       | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > index 897a1d808ef5..f7848e4a7b29 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > @@ -26,6 +26,7 @@ properties:
> >        - bosch,bma255
> >        - bosch,bma280
> >        - bosch,bmc150_accel
> > +      - bosch,bmc156_accel
> >        - bosch,bmi055_accel
> >  
> >        # bma180 driver in Linux
> > @@ -49,6 +50,9 @@ properties:
> >        the second (optional) interrupt listed must be the one connected to the
> >        INT2 pin (if available). The type should be IRQ_TYPE_EDGE_RISING.
> >  
> > +      BMC156 does not have an INT1 pin, therefore the first interrupt pin is
> > +      always treated as INT2.
> 
> We 'could' enforce any name present for the bmc156 to be INT2, but we probably
> still want the fallback you have in the driver to handle the case of
> not interrupt-name provided.
> 
> Rob, do you think it's worth the complexity for this corner case?

No.

Rob
