Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C919A104
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 23:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgCaVpV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 17:45:21 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36104 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgCaVpU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 17:45:20 -0400
Received: by mail-il1-f196.google.com with SMTP id p13so20975736ilp.3;
        Tue, 31 Mar 2020 14:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OKro9uAXHnB0is9bdTO7JG0JsIX+rngJzFGMCECx088=;
        b=hTDEzxBecnNqb4HJ2u1B85VEXZSkaaDz0XCHMi+Xb8Q0rvF8nYHhVpo02NwUpIiUqw
         jxl0PDlgb3igk9Drb2pfIpPlZs4/2LtKQ3l/FGBfSviUC896BYi8hLKiSLKpToW3qDM2
         Fz/VGYz4yYqmsunBFBKQLiDNVf9lruIdqZ2DJCM69LICnNJFZPGwF9OxfJMfbytgZrvn
         kP63QZzfWy/8Z/70yLc/qJEg8Oet8g8Td1bqQAEkOqUTC9f9CZtPK4sWhRK/EP4AgceA
         NWufpCmzEf3xqrIswyt9nCb+GNMQt7WoaUSgjxlwUIMODi55DazW87Ku+70s//aMoXNC
         AIRw==
X-Gm-Message-State: ANhLgQ3hDb7tr46vtsXHHAYGdmSf7HF3JBYDNzzDYmgo60nwsPIuW3FO
        RoFFQMLy3dO3F6PhsN4Kvg==
X-Google-Smtp-Source: ADFU+vtJXEMat76W7wSOsLcZpVmb1igoGAxsDoAPotNAhqZth57H315EwJzR6CYpEMJdFqAP7k/Ctg==
X-Received: by 2002:a92:3203:: with SMTP id z3mr18241920ile.136.1585691119666;
        Tue, 31 Mar 2020 14:45:19 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g78sm34429ild.36.2020.03.31.14.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:45:18 -0700 (PDT)
Received: (nullmailer pid 26487 invoked by uid 1000);
        Tue, 31 Mar 2020 21:45:17 -0000
Date:   Tue, 31 Mar 2020 15:45:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Tomas Novotny <tomas@novotny.cz>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: light: vcnl4000: Add near-level
Message-ID: <20200331214517.GA24128@bogus>
References: <cover.1585134362.git.agx@sigxcpu.org>
 <f0ad40351d7ab12f79d2c29f738443514ae0fb76.1585134362.git.agx@sigxcpu.org>
 <20200329102526.1ee85e96@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200329102526.1ee85e96@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 29, 2020 at 10:25:26AM +0100, Jonathan Cameron wrote:
> On Wed, 25 Mar 2020 12:09:06 +0100
> Guido Günther <agx@sigxcpu.org> wrote:
> 
> > This value indicates when userspace should consider an object
> > near to the sensor/device.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> I'm fine with this.  Note for Rob or other DT people.
> 
> This is a new generic binding hence no vendor prefix.

Then document in a common place.

> 
> I will ideally want review of both the dt patches though
> before applying.  As we've missed the merge window anyway
> there is no particular rush.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml    | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> > index 21ef2eb7a205..ac9e3bb6a505 100644
> > --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> > +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> > @@ -25,6 +25,13 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  near-level:

Perhaps proximity-near-level instead.

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Raw proximity values equal or above this level should be
> > +      considered 'near' to the device (an object is near to the
> > +      sensor).
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -40,6 +47,7 @@ examples:
> >        light-sensor@51 {
> >                compatible = "vishay,vcnl4200";
> >                reg = <0x51>;
> > +              near-level = <220>;
> >        };
> >    };
> >  ...
> 
