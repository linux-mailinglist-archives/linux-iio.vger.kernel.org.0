Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E155256E14
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgH3NZK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 09:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgH3NZH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Aug 2020 09:25:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FBF0206FA;
        Sun, 30 Aug 2020 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598793907;
        bh=k5a90CA8mBDiqDHNuojBL6VAe1oM2fD5g8H+IRg68ZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PjFXAjCCRWwAQ7jbqlBoOTGjjxzQLL/kQq3bGM0F5CAeVYlry4U3xz8eQVDf3zZhd
         FYN55dZXPob430gvVvZBlIrSImZqc8e5vg2XbtmXcKnopsXrlUEKV1Sx/dGe1dMtvz
         IkgUA9VVVHixR5jnJw9W4pLcwAWm8BT0ZTVmRsRM=
Date:   Sun, 30 Aug 2020 14:25:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oskar Andero <oskar.andero@gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: iio: adc: microchip,mcp3201 yaml
 conversion.
Message-ID: <20200830142503.7f2b3339@archlinux>
In-Reply-To: <20200818022451.GA2158889@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-2-jic23@kernel.org>
        <20200818022451.GA2158889@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 20:24:51 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, Aug 09, 2020 at 12:17:41PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Drops the deprecated compatibles without the vendor name.
> > Whilst the driver continues to support these for old dt blobs,
> > any dt bindings that are actuallly verified against this document should
> > be fixed to add the vendor name.
> > 
> > Enforces rule that spi-cpol == spi-cpha.  Is there a cleaner way to
> > do this?  
> 
> dependencies:
>   spi-cpol: [ spi-cpha ]
>   spi-cpha: [ spi-cpol ]

Great!

> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied,

Thanks,

Jonathan

> 
> > 
> > Added the #io-channel-cells property to allow for consumers.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Oskar Andero <oskar.andero@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/mcp320x.txt   | 57 ------------
> >  .../bindings/iio/adc/microchip,mcp3201.yaml   | 93 +++++++++++++++++++
> >  2 files changed, 93 insertions(+), 57 deletions(-)  

