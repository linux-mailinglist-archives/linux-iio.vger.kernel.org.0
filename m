Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F752C7576
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgK1VtU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgK1R6R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 12:58:17 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C908246E2;
        Sat, 28 Nov 2020 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606586257;
        bh=TysTcHn2fgrDv6ggQHwiNuDIFdGJtM1RGsXV7S/7owc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=awjqu6B87cLyKBBprTyTXkJIBAin8UTpcBvVrqfWIUtr8gzZjprqHCqaJRZCCv9Fy
         mZtwy454PnWP1zmi0Y2CEmOQeR4S9JrsBp0HFDjw7u3L/fQlr0vSwJbnnE9Aqybix3
         iHa8p8gF/08jj8bwnK722YgMzgWIT0DWmmeFt+ww=
Date:   Sat, 28 Nov 2020 17:57:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/10] dt-bindings: iio: conversion of consumer drivers
Message-ID: <20201128175732.5fdc7310@archlinux>
In-Reply-To: <20201103160756.GB1732900@bogus>
References: <20201031181242.742301-1-jic23@kernel.org>
        <20201103160756.GB1732900@bogus>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Nov 2020 10:07:56 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Oct 31, 2020 at 06:12:32PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Firstly drop the old text file as the consumer binding (and the other
> > parts of that file) are under review for inclusion in the dt-schema external
> > repo.
> > 
> > This only converts consumers that happen to also be IIO drivers.
> > Others may get done as part of SoC binding conversions or I may do a lot
> > of them at somepoint.
> > 
> > A few of the examples in existing text files used providers that were
> > documented in trivial-bindings.yaml which does not allow for
> > #io-channel-cells. I have pulled those out to their own files as part
> > of this patch set.
> > 
> > The iio-mux binding is not done as that has some dependencies and will
> > form part of some future patch set.
> > 
> > There is no explicit dependency in here on any other sets, but some
> > noise will occur in trivial-bindings.yaml if applied in a different
> > order to I happen to have them sets locally.
> > 
> > Jonathan Cameron (10):
> >   dt-bindings:iio:iio-binding.txt Drop file as content now in dt-schema
> >   dt-bindings:iio:dac:dpot-dac: yaml conversion.
> >   dt-bindings:iio:potentiometer: give microchip,mcp4531 its own binding
> >   dt-bindings:iio:adc:envelope-detector: txt to yaml conversion.
> >   dt-bindings:iio:afe:current-sense-amplifier: txt to yaml conversion.
> >   dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion. 
> >   dt-bindings:iio:adc:maxim,max1027: Pull out to separate binding doc.
> >   dt-bindings:iio:afe:voltage-divider: txt to yaml conversion
> >   dt-bindings:iio:light:capella,cm3605: txt to yaml conversion.
> >   dt-bindings:iio:potentiostat:ti,lmp91000: txt to yaml conversion.  
> 
> With the type references for properties with standard units dropped,

Done.

> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to do their magic.
Thanks,

Jonathan
