Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5310F426C26
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 15:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhJHN6I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 09:58:08 -0400
Received: from smtp2.axis.com ([195.60.68.18]:22061 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234049AbhJHN6H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 09:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633701372;
  x=1665237372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=me75zdxB12WIuwzb16S9PBlfZIdHjvMQdZm15J1RVJw=;
  b=iewVfZwwi86xOSCxPH4qYYP2E0udq9O4CtjLZQV9ytrHXD5ER7x15mei
   EJNzIGvZUzSybgx+R8q2lnXbP3rR815acRqAdi9CIZUrhQCkkmecl8wmm
   hdEpzcXwb1M33wWEKRf6cuYord5tefqpWar2NFTVATvfw+gWZEXDV16nz
   nhGmm2H2yL90RHxSRZRbCJDoylWLnzyE55T7DM01fAbXLJlx2WVgLcs0W
   BTMV125CnGX9exsjwnjU8AfDWux5o3iljIsfIhEAz1HGPnfXqP3LhbnBV
   abtblKotk7GbVe5IcqHfar9wV+Mp1NbBEgDdn48p2Uz0sjwWodWjufMx9
   g==;
Date:   Fri, 8 Oct 2021 15:56:10 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh@kernel.org>
CC:     kernel <kernel@axis.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peda@axentia.se" <peda@axentia.se>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: io-channel-mux: Add property
 for settle time
Message-ID: <20211008135610.GA16402@axis.com>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
 <20211007134641.13417-3-vincent.whitchurch@axis.com>
 <1633661172.633248.1409599.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1633661172.633248.1409599.nullmailer@robh.at.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 08, 2021 at 04:46:12AM +0200, Rob Herring wrote:
> On Thu, 07 Oct 2021 15:46:40 +0200, Vincent Whitchurch wrote:
> > Hardware may require some time for the muxed analog signals to settle
> > after the muxing is changed.  Allow this time to be specified in the
> > devicetree.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml  | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.

Yes, these are not new warnings.

> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1537724
> 
> 
> adc0mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml
> 
> adc10mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml
[...]

I think the fix for these is to add a "#io-channel-cells": const 1 to
the schema.

> envelope-detector-mux: channels: ['', '', 'sync-1', 'in', 'out', 'sync-2', 'sys-reg', 'ana-reg'] has non-unique elements
> 	arch/arm/boot/dts/at91-tse850-3.dt.yaml

This one looks like an error in that particular devicetree.
