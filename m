Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA1D235379
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHAQmG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 12:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgHAQmG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 12:42:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 776572076B;
        Sat,  1 Aug 2020 16:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596300125;
        bh=VPnKDKBM2c9X0gK5H6tFP49Oguva7jYJ0CVWJsY2AXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pLbZCThqWBonlmEyu0WQ43puo66r4RArabiHZutQVWuSZBPFVFpjlgnPbLGGTKCIh
         q6Gx0GLb60XHnTTP8cC8lP8CMNRmZ70OWD0ZHAQs11IfYSST4pCk6oKrDqiddZP5ci
         XjMTpAKaKqlM6masTCBq0V+kvx5ADK58snOqSxTw=
Date:   Sat, 1 Aug 2020 17:42:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: maxim,max9611 yaml
 conversions
Message-ID: <20200801174201.5e499044@archlinux>
In-Reply-To: <20200723212231.GA881485@bogus>
References: <20200722171224.989138-1-jic23@kernel.org>
        <20200722171224.989138-4-jic23@kernel.org>
        <20200723212231.GA881485@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Jul 2020 15:22:31 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 22 Jul 2020 18:12:24 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Straight forward conversion of this binding for this
> > current sense amplifier and ADC.
> > 
> > Cc: Jacopo Mondi <jacopo@jmondi.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  .../devicetree/bindings/iio/adc/max9611.txt   | 27 ----------
> >  .../bindings/iio/adc/maxim,max9611.yaml       | 49 +++++++++++++++++++
> >  2 files changed, 49 insertions(+), 27 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Thanks

Applied with additionalProperties line added.

Jonathan

