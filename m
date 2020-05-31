Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6FD1E980C
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgEaOFG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaOFG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:05:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F8D20723;
        Sun, 31 May 2020 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590933905;
        bh=Q2n3PK4t8Mi2Fesp5491E0TYuqLEWg1ufhgUZV0WppQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=03UTh0FuzNlIQYXJ1g4/jt3bsAoqObJFHg473+GDU9n4L1aEQf7OmuDskylrMk1CJ
         NXclUkCt+BbMPCHs2F7+UbThB3rwNsQDBM+Nr/tIVWv4rRNtXJZh+Ei8eEHtasTLeo
         /olOD3dbiiDjliq6g0zsSHgs2WQWXTKshrgv5L3A=
Date:   Sun, 31 May 2020 15:05:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@gmail.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v4 2/5] dt-bindings: iio: imu: bmi160: add regulators
 and mount-matrix
Message-ID: <20200531150501.55a6e4c8@archlinux>
In-Reply-To: <20200529170943.GA2578764@bogus>
References: <20200525164615.14962-1-jonathan.albrieux@gmail.com>
        <20200525164615.14962-3-jonathan.albrieux@gmail.com>
        <20200529170943.GA2578764@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 May 2020 11:09:43 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, May 25, 2020 at 06:46:01PM +0200, Jonathan Albrieux wrote:
> > Add vdd-supply and vddio-supply support.
> > Add mount-matrix support.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > ---
> >  .../bindings/iio/imu/bosch,bmi160.yaml           | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> > index 0d0ef84e22b9..cfe40dbcd723 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
> > @@ -37,6 +37,17 @@ properties:
> >        set if the specified interrupt pin should be configured as
> >        open drain. If not set, defaults to push-pull.
> >  
> > +  vdd-supply:
> > +    maxItems: 1  
> 
> Supplies are always a single item, so don't need this.

Given this (and case below) were it outstanding for this patch I
fixed them up whilst applying rather than getting Jonathan to
go around again.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> > +    description: provide VDD power to the sensor.
> > +
> > +  vddio-supply:
> > +    maxItems: 1
> > +    description: provide VDD IO power to the sensor.
> > +
> > +  mount-matrix:
> > +    description: an optional 3x3 mounting rotation matrix
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -52,9 +63,14 @@ examples:
> >          bmi160@68 {
> >                  compatible = "bosch,bmi160";
> >                  reg = <0x68>;
> > +                vdd-supply = <&pm8916_l17>;
> > +                vddio-supply = <&pm8916_l6>;
> >                  interrupt-parent = <&gpio4>;
> >                  interrupts = <12 IRQ_TYPE_EDGE_RISING>;
> >                  interrupt-names = "INT1";
> > +                mount-matrix = "0", "1", "0",
> > +                               "-1", "0", "0",
> > +                               "0", "0", "1";
> >          };
> >      };
> >    - |
> > -- 
> > 2.17.1
> >   

