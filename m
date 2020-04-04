Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7A19E6D3
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 19:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgDDRp1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Apr 2020 13:45:27 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:49656 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgDDRp1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Apr 2020 13:45:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C5250FB03;
        Sat,  4 Apr 2020 19:45:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PRs-DEyCgI-x; Sat,  4 Apr 2020 19:45:22 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9ED44414D7; Sat,  4 Apr 2020 19:45:21 +0200 (CEST)
Date:   Sat, 4 Apr 2020 19:45:21 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Tomas Novotny <tomas@novotny.cz>,
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
Message-ID: <20200404174521.GA24709@bogon.m.sigxcpu.org>
References: <cover.1585134362.git.agx@sigxcpu.org>
 <f0ad40351d7ab12f79d2c29f738443514ae0fb76.1585134362.git.agx@sigxcpu.org>
 <20200329102526.1ee85e96@archlinux>
 <20200331214517.GA24128@bogus>
 <20200404160127.1ef9d1ac@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200404160127.1ef9d1ac@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
On Sat, Apr 04, 2020 at 04:01:27PM +0100, Jonathan Cameron wrote:
> On Tue, 31 Mar 2020 15:45:17 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Sun, Mar 29, 2020 at 10:25:26AM +0100, Jonathan Cameron wrote:
> > > On Wed, 25 Mar 2020 12:09:06 +0100
> > > Guido Günther <agx@sigxcpu.org> wrote:
> > >   
> > > > This value indicates when userspace should consider an object
> > > > near to the sensor/device.
> > > > 
> > > > Signed-off-by: Guido Günther <agx@sigxcpu.org>  
> > > 
> > > I'm fine with this.  Note for Rob or other DT people.
> > > 
> > > This is a new generic binding hence no vendor prefix.  
> > 
> > Then document in a common place.
> 
> Ok. 
> 
> I guess we need to create a proximity specific binding file.
> 
> Documentation/devicetree/bindings/iio/proximity.yaml
> 
> Guido, could you do a v4 adding such a file.  For now I think
> this is pretty much all that is proximity specific.

I did a Documentation/devicetree/bindings/iio/common.yaml:

https://source.puri.sm/guido.gunther/linux-imx8/commit/8b91f0b7fa76ca4b2f3cdc251411829f71f8d810

so we can add new properties there and move iio-bindings.txt over.

Does that work as well? If so I'll send out a v4.
Cheers,
 -- Guido


> 
> At somepoint we should convert the subsystem wide iio-bindings.txt
> but not today!
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > > 
> > > I will ideally want review of both the dt patches though
> > > before applying.  As we've missed the merge window anyway
> > > there is no particular rush.
> > > 
> > > Thanks,
> > > 
> > > Jonathan
> > >   
> > > > ---
> > > >  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml    | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> > > > index 21ef2eb7a205..ac9e3bb6a505 100644
> > > > --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> > > > @@ -25,6 +25,13 @@ properties:
> > > >    reg:
> > > >      maxItems: 1
> > > >  
> > > > +  near-level:  
> > 
> > Perhaps proximity-near-level instead.
> 
> Makes sense.
> 
> > 
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description:
> > > > +      Raw proximity values equal or above this level should be
> > > > +      considered 'near' to the device (an object is near to the
> > > > +      sensor).
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > > @@ -40,6 +47,7 @@ examples:
> > > >        light-sensor@51 {
> > > >                compatible = "vishay,vcnl4200";
> > > >                reg = <0x51>;
> > > > +              near-level = <220>;
> > > >        };
> > > >    };
> > > >  ...  
> > >   
> 
