Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4F325698D
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgH2Rzt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 13:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbgH2Rzt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 13:55:49 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF84204FD;
        Sat, 29 Aug 2020 17:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598723748;
        bh=B3ZaDaBru5vl5vEf35oId3DEGuxCM6aIRO30qMacVnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MLi5plXSXcpWxSY1bWxAjetsgHTPqnmCFE7imCzOa8ytaKqkXTBkcpxP7EQUv2y91
         ilsKmIj+fIzpLCZ2js/80fGV0YuYx+xhsKz9sNRRP9b7amKsawxpCP5+EDTeY+VdGG
         2HjiqJ6ZlYS0gsiVx0dzJ0ux++4IsnrDx4OCcCgE=
Date:   Sat, 29 Aug 2020 18:55:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 09/13] dt-bindings: iio: adc: ti,adc128s052 yaml
 conversion.
Message-ID: <20200829185545.73a58427@archlinux>
In-Reply-To: <20200818023034.GA2172484@bogus>
References: <20200809111753.156236-1-jic23@kernel.org>
        <20200809111753.156236-10-jic23@kernel.org>
        <20200818023034.GA2172484@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Aug 2020 20:30:34 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, 09 Aug 2020 12:17:49 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Simple binding.  Only addition to txt version is
> > as a provider of channels to other devices using the consumer
> > binding.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> > ---
> >  .../bindings/iio/adc/ti,adc128s052.yaml       | 59 +++++++++++++++++++
> >  .../bindings/iio/adc/ti-adc128s052.txt        | 25 --------
> >  2 files changed, 59 insertions(+), 25 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied

