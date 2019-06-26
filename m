Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD6857261
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 22:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFZUNi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 16:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZUNh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 16:13:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8EA32086D;
        Wed, 26 Jun 2019 20:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561580016;
        bh=0jQodpDRuAkFZgDiEgerdZvI7o/ZwZ0KSv4xKSQprD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tiV3ftktTDsuAQeR2z4Vu6D7XRs6u+SF4+yX/FgFVai8l8bUkuTUjNKxRN+hTBvVu
         aNhjRw7hskTBnc6xC++D5aSsmyL4+HvgvW4E7J1VEXO4x13+P8xYWfipHsMIrwoQ0S
         hdTU5lJgCY0k6PYgyysagmt1viul5eTn+QvL1jao=
Date:   Wed, 26 Jun 2019 21:13:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: frequency: adf4371: Add support for output
 stage mute
Message-ID: <20190626211331.6e335fe8@archlinux>
In-Reply-To: <CAL_JsqL-Pxef5oNAx5-crGxL9Q0Ph5gx2Z=KejLSq_jdgVUvbQ@mail.gmail.com>
References: <1561389236-26464-1-git-send-email-stefan.popa@analog.com>
        <CAL_JsqL-Pxef5oNAx5-crGxL9Q0Ph5gx2Z=KejLSq_jdgVUvbQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Jun 2019 13:59:49 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Jun 24, 2019 at 9:14 AM Stefan Popa <stefan.popa@analog.com> wrote:
> >
> > Another feature of the ADF4371/ADF4372 is that the supply current to the
> > RF8P and RF8N output stage can shut down until the ADF4371 achieves lock
> > as measured by the digital lock detect circuitry. The mute to lock
> > detect bit (MUTE_LD) in REG25 enables this function.
> >
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> >  .../devicetree/bindings/iio/frequency/adf4371.yaml          |  6 ++++++  
> 
> If you resend and in the future, please split bindings to separate patch.
> 
> >  drivers/iio/frequency/adf4371.c                             | 13 +++++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > index a268a9d..6db8742 100644
> > --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > @@ -32,6 +32,12 @@ properties:
> >      items:
> >        - clkin
> >
> > +  adi,mute-till-lock-en:
> > +    description:
> > +      If this property is present, then the supply current to RF8P and RF8N
> > +      output stage will shut down until the ADF4371/ADF4372 achieves lock as
> > +      measured by the digital lock detect circuitry.  
> 
> You need to define the type:
> 
> type: boolean
> 
> Maybe Jonathan will fix up.
Doh. I should have caught that.

Fixed up with
type: boolean

Hopefully I did it right

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=6e68162fcc94ec81c1656e15e6e1893fee0c309a

Thanks Rob!

Jonathan

> 
> Rob

