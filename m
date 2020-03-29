Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E333E196C61
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 12:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgC2KTV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 06:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbgC2KTV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Mar 2020 06:19:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D0D20732;
        Sun, 29 Mar 2020 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585477160;
        bh=zucRSTGGzuFkVabCQezWqRiMwAZFZTLz64620KT1MlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ht87FUpI68j2yRsicb5MfQNxxsKNdJueCA2Kr8EY9Gnu9vDvz/SI2nKl9yYqhb23t
         PECULlATF27BhYfK/jq22ikq8j0PkTp0/4u4EgJCxW6TU82prPIpldpekC2LpkY07r
         NaWwz/H/iSJFmPBTYSNtFMzH0g0yjYkze3E3Lqe0=
Date:   Sun, 29 Mar 2020 11:19:15 +0100
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
Message-ID: <20200329111915.0a3211bb@archlinux>
In-Reply-To: <17a99874285734496a97d271dda7368b40e88255.camel@analog.com>
References: <20200324134636.64643-1-alexandru.ardelean@analog.com>
        <20200324134636.64643-9-alexandru.ardelean@analog.com>
        <20200326185616.GA2673@bogus>
        <17a99874285734496a97d271dda7368b40e88255.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Mar 2020 19:45:39 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2020-03-26 at 12:56 -0600, Rob Herring wrote:
> > On Tue, 24 Mar 2020 15:46:36 +0200, Alexandru Ardelean wrote:  
> > > This change adds the binding doc for the AD9467 ADC.
> > > 
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > >  .../bindings/iio/adc/adi,ad9467.yaml          | 65 +++++++++++++++++++
> > >  1 file changed, 65 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > >   
> > 
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> > 
> > If a tag was not added on purpose, please state why and what changed.  
> 
> My bad. Apologies for that.
> No idea how I missed adding this. Especially since I already know that I should
> add it.
> 
> I guess I got mixed up with too many branches and not paying attention.
Fixed the missing tag from Rob and whole series applied to the togreg branch of
iio.git.  Pushed out as testing for the autobuilders to poke at it.

Exposing the dma buffer stuff to the autobuilders is great. So far the only
issue was that patch I took yesterday where we need to rethink things.
However, that's just my sanity check local build so I'm sure we broke
some obscure architecture :)

Thanks,

Jonathan


