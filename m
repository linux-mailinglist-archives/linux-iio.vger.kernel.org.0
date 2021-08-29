Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2463C3FAD04
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 18:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhH2QFa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 12:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235680AbhH2QF3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 12:05:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8284B60E73;
        Sun, 29 Aug 2021 16:04:34 +0000 (UTC)
Date:   Sun, 29 Aug 2021 17:07:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: chemical: Document
 senseair,sunrise CO2 sensor
Message-ID: <20210829170749.199ff1af@jic23-huawei>
In-Reply-To: <20210822160444.upjcnsbncyk63x3s@uno.localdomain>
References: <20210820133821.159239-1-jacopo@jmondi.org>
        <20210820133821.159239-2-jacopo@jmondi.org>
        <1629488772.355778.3663899.nullmailer@robh.at.kernel.org>
        <20210822160444.upjcnsbncyk63x3s@uno.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Aug 2021 18:04:44 +0200
Jacopo Mondi <jacopo@jmondi.org> wrote:

> On Fri, Aug 20, 2021 at 02:46:12PM -0500, Rob Herring wrote:
> > On Fri, 20 Aug 2021 15:38:19 +0200, Jacopo Mondi wrote:  
> > > Add documentation for the Senseair Sunrise 006-0-0007 CO2 NDIR sensor.
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
> > > ---
> > > v1->v2:
> > > - Add maxItems to -gpios properties as suggested by Rob
> > > - Add a label to the device node in the example as suggested by Rob
> > >  
> 
> Labels cannot contain '-'.
> 
> I'll make this
> 
>         sunrise: co2-sensor@68

Why label at all?  Might be handy on a real board, but example doesn't need it.

Jonathan

> 
> My bad and sorry for not running dt_binding_check, I thought the
> changes were trivial enough.
> 
> Thanks
>    j
> 
> > > ---
> > >  .../iio/chemical/senseair,sunrise.yaml        | 53 +++++++++++++++++++
> > >  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> > >  2 files changed, 55 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
> > >  
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Error: Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.example.dts:23.21-22 syntax error
> > FATAL ERROR: Unable to parse input tree
> > make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.example.dt.yaml] Error 1
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1419: dt_binding_check] Error 2
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.ozlabs.org/patch/1519042
> >
> > This check can fail if there are any dependencies. The base for a patch
> > series is generally the most recent rc1.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit.
> >  

