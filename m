Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8CF197D07
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgC3Nfs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 09:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbgC3Nfs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Mar 2020 09:35:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63EDC20757;
        Mon, 30 Mar 2020 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585575347;
        bh=mpEf7NQVYYvCdUG6heXAB6Ng6mW+GJ24w6fwdkL20GU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bjjMLzKCuXkABe8htMvwdDaKYBYq/YwHYEzf81lxMyl1OwfoszaeMmodLD7w925HE
         LPiu/Kfu+/BCT1sT2VCsk+l5DgeVzGNhcrqfqSnS65K4j4/JBrm7h0XAkgZ2HX/3Nx
         kPPAss31wk+vBgTwCAS5Ev+PmnkPJt7JVMkuTwxA=
Date:   Mon, 30 Mar 2020 14:35:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Grozav, Andrei" <Andrei.Grozav@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Nagy, Laszlo" <Laszlo.Nagy@analog.com>,
        "Csomortani, Istvan" <Istvan.Csomortani@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Costina, Adrian" <Adrian.Costina@analog.com>
Subject: Re: [PATCH v13 8/8] dt-bindings: iio: adc: add bindings doc for
 AD9467 ADC
Message-ID: <20200330143541.189ba0ad@archlinux>
In-Reply-To: <20200329111915.0a3211bb@archlinux>
References: <20200324134636.64643-1-alexandru.ardelean@analog.com>
        <20200324134636.64643-9-alexandru.ardelean@analog.com>
        <20200326185616.GA2673@bogus>
        <17a99874285734496a97d271dda7368b40e88255.camel@analog.com>
        <20200329111915.0a3211bb@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 Mar 2020 11:19:15 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 26 Mar 2020 19:45:39 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
> > On Thu, 2020-03-26 at 12:56 -0600, Rob Herring wrote:  
> > > On Tue, 24 Mar 2020 15:46:36 +0200, Alexandru Ardelean wrote:    
> > > > This change adds the binding doc for the AD9467 ADC.
> > > > 
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > > ---
> > > >  .../bindings/iio/adc/adi,ad9467.yaml          | 65 +++++++++++++++++++
> > > >  1 file changed, 65 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > > >     
> > > 
> > > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > > there's no need to repost patches *only* to add the tags. The upstream
> > > maintainer will do that for acks received on the version they apply.
> > > 
> > > If a tag was not added on purpose, please state why and what changed.    
> > 
> > My bad. Apologies for that.
> > No idea how I missed adding this. Especially since I already know that I should
> > add it.
> > 
> > I guess I got mixed up with too many branches and not paying attention.  
> Fixed the missing tag from Rob and whole series applied to the togreg branch of
> iio.git.  Pushed out as testing for the autobuilders to poke at it.
> 
> Exposing the dma buffer stuff to the autobuilders is great. So far the only
> issue was that patch I took yesterday where we need to rethink things.
> However, that's just my sanity check local build so I'm sure we broke
> some obscure architecture :)

0-day found some issues in the series..  Note I think this is the list that
hasn't been human sanity checked yet so can be 'interesting'.

drivers/iio/adc/ad9467.c:288:13: warning: Checking if unsigned expression 'r_clk' is less than zero. [unsignedLessThanZero]
r_clk = clock_round_rate that can indeed return a negative (long)
I've dropped the unsigned given we check for negative so this should be safe.

drivers/iio/adc/ad9467.c:381:7: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
Missing error check. I've added it. Please sanity check in the testing branch.


drivers/iio/adc/adi-axi-adc.c:158:18: warning: The scope of the variable 'ctrl' can be reduced. [variableScope]
This one is silly.  Sure you could reduce the scope, but there is little risk in not doing so given all the
function contains is one loop.

drivers/iio/adc/adi-axi-adc.c:354:32: warning: Redundant assignment of 'conv' to itself. [selfAssignment]
This one is real. Fixed up. conv = conv = st->...

drivers/iio/adc/adi-axi-adc.c:355:9: warning: The scope of the variable 'ret' can be reduced. [variableScope]
Again, somewhat silly. 

So I've ignored 2 of them.  We 'could' fix these but until I get the feeling
the kernel coding style has actually changed to specify this rather than it
being a matter of taste I'm not particularly inclined to do so.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 

