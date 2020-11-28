Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA0B2C749D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388224AbgK1Vtc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387420AbgK1TH1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Nov 2020 14:07:27 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B2A246CC;
        Sat, 28 Nov 2020 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606581572;
        bh=noFCBd4nTh2GdZ4T+8oNdS+9TrApdROYtx/lAjMcsAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ySX/gR4gf4f/DaHfs91hZ1bb9j2YaSoTRfhHZ9itoWj+lMX5csFvT2EL4Tlx8WnZg
         EDHK0N9w1n5my1Glwj/xPyeyj+1tT2zBg1rTJgTBF/Kl5dLI65RUMJEg0FFIisV9TA
         Wpogfn58e1UFRQDB37BzoVkoCmbNXTHET/DfAeCs=
Date:   Sat, 28 Nov 2020 16:39:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/3] dt-bindings:iio:adc: Convert generic ADC channel
 binding to yaml
Message-ID: <20201128163928.4ef2a43a@archlinux>
In-Reply-To: <20201103023146.GA692453@bogus>
References: <20201031182423.742798-1-jic23@kernel.org>
        <20201103023146.GA692453@bogus>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Nov 2020 20:31:46 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Oct 31, 2020 at 06:24:20PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This channel binding is not yet that heavily used, though that will slowly
> > change now we have a standard binding.  There are more properties coming
> > for this binding in the near future.
> > 
> > This series converts the channel binding itself then leverages it to
> > reduce repitition and improve consistency in a couple of drivers.
> > 
> > One thing to note is that we have similar defintion for DACs but so
> > far there are no generic properties.
> > 
> > Jonathan Cameron (3):
> >   dt-bindings:iio:adc: convert adc.txt to yaml
> >   dt-bindings:iio:adc:adi,ad7124: Use the new adc.yaml channel binding
> >   dt-bindings:iio:adc:adi,ad7292: Use new adc.yaml binding for channels.  
> 
> For the series:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Series applied with just that small addition to patch 1.

Thanks,

Jonathan

> 
> > 
> >  .../devicetree/bindings/iio/adc/adc.txt       | 23 -----------
> >  .../devicetree/bindings/iio/adc/adc.yaml      | 38 +++++++++++++++++++
> >  .../bindings/iio/adc/adi,ad7124.yaml          | 14 +++----
> >  .../bindings/iio/adc/adi,ad7292.yaml          |  8 ++--
> >  4 files changed, 47 insertions(+), 36 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.yaml
> > 
> > -- 
> > 2.28.0
> >   

