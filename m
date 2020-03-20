Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE7418C8FA
	for <lists+linux-iio@lfdr.de>; Fri, 20 Mar 2020 09:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCTI2c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Mar 2020 04:28:32 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:34067 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCTI2c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 04:28:32 -0400
Date:   Fri, 20 Mar 2020 10:33:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584692910;
        bh=CxHfal8SbQBjhp+1WzN5a/s29vuuQMgIiuX4V/o6A5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWohorXamUKcHKoOrdFbeFQevauGWc7udAbPPIJASnZwBjIpH2TtUSK5pCtbyqpFF
         nz5LQp+//UW3qJ4C/p3kTcFCUaCH2wM8+Zgl21QPXabyb/QU5JZW5qTUcbYs0RkbRT
         HzxgXLUvT9BjdPYTh8KNFJJ1wSvJL29jbk4fs6Mm6k6s/oF6a4FoVjG4y9INCK9GKF
         EuDnFE8WF8k4Aow2tDr4dw45Uevi44pnxtvRG+646L2FXVjvQC1zq3GUHWRhkAXKNe
         vO0y6kvcGQXhnvjJJHEdFxV0Wb69uxbdXli4WFv40NYgRK9QBdIzlx83BlIEjI1D4n
         kBDpEzpwwiH8A==
From:   Alexandru Lazar <alazar@startmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Message-ID: <20200320083307.GA1871@leena.republic>
References: <20200319162937.34664-1-alazar@startmail.com>
 <20200319162937.34664-3-alazar@startmail.com>
 <2bad089fd8302ed514f673dae4ba8264b35fff16.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bad089fd8302ed514f673dae4ba8264b35fff16.camel@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > +  reg:
> > +    description: SPI chip select number for this device
> 
> Rob will probably complain that you don't need to document[add description] to
> standard attributes [like SPI's 'reg' parameter]
> Just listing it here, should be sufficient. So, you can drop the
> description.

Makes sense -- should've thought of it, considering I dropped the doc
for spi-frequency as well. My brain is still wired to the non-standard
txt docs it seems, sorry!

I'm going to make a v4 for this (I think I need to reorder the patch
series anyway -- the dt-bindings should come first) and Cc: the
dt-bindings list with as well.

Thanks again for all your help!

Best regards,
Alex
