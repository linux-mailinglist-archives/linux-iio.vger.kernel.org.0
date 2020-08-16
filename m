Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270062456E4
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHPJGN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgHPJGL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 05:06:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 231D820674;
        Sun, 16 Aug 2020 09:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597568771;
        bh=sLTrk29w8sWp36dVVCk7HEcGXkeBCP2WGfbK/X0/MwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nmGYN/kA3mdfQ5bBz8E3lxioQWQuGJFuV11hmsYSjKbTnmWQhawKihviIWrwwTott
         Qmgch3BCz6csRTESRZrbtk8UNUVDmT1I0GcRDxnNSdPomB2YWejZK0U0gttQKuaziy
         3TvJGaxE6vvgHYy7XX0CRqCouAFFi40+B92r4/lA=
Date:   Sun, 16 Aug 2020 10:06:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 08/13] dt-bindings: iio: adc: ti,adc12138 yaml
 conversion.
Message-ID: <20200816100607.15b01c3a@archlinux>
In-Reply-To: <20200812162907.GA2323853@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-9-jic23@kernel.org>
        <20200812162907.GA2323853@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Aug 2020 10:29:07 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 09 Aug 2020 12:17:48 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Simple binding conversion.  Only addition was #io-channel-cells to
> > allow for potential consumers of the channels on this device.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> >  .../bindings/iio/adc/ti,adc12138.yaml         | 85 +++++++++++++++++++
> >  .../bindings/iio/adc/ti-adc12138.txt          | 37 --------
> >  2 files changed, 85 insertions(+), 37 deletions(-)
> >   
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Error: Documentation/devicetree/bindings/iio/adc/ti,adc12138.example.dts:26.34-35 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:330: Documentation/devicetree/bindings/iio/adc/ti,adc12138.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1334: dt_binding_check] Error 2
> 
> 
> See https://patchwork.ozlabs.org/patch/1342594
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 
Not sure how I missed this one in testing. It is a missing include.
I don't propose to resend the series though until more comments are in.

Thanks,

Jonathan


