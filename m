Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7067270E49
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgISOBk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 10:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgISOBk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 10:01:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C0642100A;
        Sat, 19 Sep 2020 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600524099;
        bh=fe57gEa2Zq4SyopnYBq/8NJ3wE5UXDqdduV0rjSHCU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ctUyA3Q3q8i2G9/2oy0JcGdSLJvos4GVWCAhuWAQ8cZfuvzNfwDz2c0auc1l7maa2
         CFX1ybZNfqjTvQFVLll3Lg+xvhhIFsleMOrP/5umtvPz+2T6zltgv5zttEAa8GjivT
         NAER/1RfofGlb61EfgFtcUTFhjnuONc79Rxmk29c=
Date:   Sat, 19 Sep 2020 15:01:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/20] dt-bindings:iio:adc:nuvoton,nau7802 yaml
 conversion
Message-ID: <20200919150134.676e5b3e@archlinux>
In-Reply-To: <20200915190616.GA2321912@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
        <20200909175946.395313-8-jic23@kernel.org>
        <20200915190616.GA2321912@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 13:06:16 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 09 Sep 2020 18:59:33 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > A simple conversion from txt file to yaml.  I added the #io-channel-cells
> > property as optional to allow the channels of this ADCs to be used
> > to provide services to other drivers, for example if an analog
> > accelerometer is connected.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  .../bindings/iio/adc/nuvoton,nau7802.yaml     | 50 +++++++++++++++++++
> >  .../bindings/iio/adc/nuvoton-nau7802.txt      | 18 -------
> >  2 files changed, 50 insertions(+), 18 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied with updated email addresses as Alexandre requested.

Thanks,

Jonathan


