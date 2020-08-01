Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00201235372
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHAQi2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 12:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgHAQi2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 12:38:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 153B72076B;
        Sat,  1 Aug 2020 16:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596299908;
        bh=r649co9p+XhIKZBQjo9j5tTTlrprBKGEZMoUhETMPIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EGL4OFPgc3Sw2FOWZbBlkawzjG2Qj41s+alZ0uQv2Q15eYmiX19vyWSEjIuMp/PrX
         Hk6GCYO9fGnqawEpWWB2mCgo7KojCexGGwYhRwaMVUHpzGQNk8+owloWauRJImNdcK
         1oieCLcN4hzzJc99lryOFSdUaoD8lP2aWWs5HU5s=
Date:   Sat, 1 Aug 2020 17:38:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: maxim,max11100 yaml
 conversion
Message-ID: <20200801173824.154249bc@archlinux>
In-Reply-To: <20200723212159.GA880514@bogus>
References: <20200722171224.989138-1-jic23@kernel.org>
        <20200722171224.989138-2-jic23@kernel.org>
        <20200723212159.GA880514@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jul 2020 15:21:59 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 22 Jul 2020 18:12:22 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Straight forward conversion for this SPI ADC.
> > Added limits on spi-max-frequency from datasheet (0.1 to 4.8MHz)
> > 
> > Cc: Jacopo Mondi <jacopo@jmondi.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  .../devicetree/bindings/iio/adc/max11100.txt  | 18 -------
> >  .../bindings/iio/adc/maxim,max11100.yaml      | 49 +++++++++++++++++++
> >  2 files changed, 49 insertions(+), 18 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan


