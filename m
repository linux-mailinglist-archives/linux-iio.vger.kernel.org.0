Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B082256984
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgH2RwA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgH2Rv6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:51:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B90204FD;
        Sat, 29 Aug 2020 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598723518;
        bh=TnGbPdp2KHCGj0sfu6x/mYmhNJ30Vh6BWyYRXY+9yqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fpuc0C6psxMv6kmE41EDwbjqXC/cceKDznEWQMy1Lquw2vZP7Ao1HHFgXz+x7DdPK
         6Uq5gf1nBjYqU0vAD4+Oar+DtZVypjE4wKo4gdW7cva2uM9/ZnJOxoYDrbD7++a8gC
         jgqt3zeLZT3LjxHk/St7QeIhJQZp99dC3x/CHGJc=
Date:   Sat, 29 Aug 2020 18:51:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH 05/13] dt-bindings: iio: adc: ti,adc161s626 yaml
 conversion.
Message-ID: <20200829185154.68fb213c@archlinux>
In-Reply-To: <20200818022857.GA2169563@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-6-jic23@kernel.org>
        <20200818022857.GA2169563@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 20:28:57 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 09 Aug 2020 12:17:45 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Simple conversion for this ADC driver.  Note that I haven't put
> > limits on the spi-max-sampling-frequency because the adc161s626
> > doesn't state one clearly defined value.
> > 
> > Added the #io-channel-cells property to allow for consumers.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > ---
> >  .../bindings/iio/adc/ti,adc161s626.yaml       | 51 +++++++++++++++++++
> >  .../bindings/iio/adc/ti-adc161s626.txt        | 18 -------
> >  2 files changed, 51 insertions(+), 18 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied

