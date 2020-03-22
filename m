Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47E018E7E9
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 10:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCVJsi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 05:48:38 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:54420 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgCVJsh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 05:48:37 -0400
Date:   Sun, 22 Mar 2020 11:53:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1584870516;
        bh=J4ujSFGKW/BsnCG6daJcAT/8BbwmSK0Gy/ZQWPeikZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jX2WrrSfIA0QmlOIU3KGsv6p/zu6Uz30YPOEUrhmAbDYi+hC09DJpsLOul3JM7DUq
         EkSQgXvpVYAbqJj6bdgJ6FbKMClkLquZfVANgfX4+KoWqcrm7E/123gDpkgQcSioUi
         fj4PCpIkQcVy2YyM4nShcs9NQZ5XcIQDhWhIZRlQLssKpvT0UmhYThzcoI8fcR7JtC
         31VSq4GdguNYImwtqOowGyI5yTWTBJVSBKSeDvdFKZOIpE9hwbYaWvOxtxnpVyVKdl
         OUK9Z0RkB6ZRY40wm7w3NWbH6kKzKd0+3EjU55dh2OAWYm940ACJ7syYVMOs+/vg9U
         ibA8YBx5JKMNA==
From:   Alexandru Lazar <alazar@startmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add MAX1241 device tree
 bindings in documentation
Message-ID: <20200322095317.GA3099@leena.republic>
References: <20200320150114.9297-1-alazar@startmail.com>
 <20200320150114.9297-2-alazar@startmail.com>
 <20200321173412.52548ef1@archlinux>
 <20200321193541.GA16892@leena.republic>
 <1e51c4079222858410e9fe94c9d7f21d99abfe15.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e51c4079222858410e9fe94c9d7f21d99abfe15.camel@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Yep.
> Jonathan refers to Vdd input/pin [on the chip] which is different from Vref [REF
> pin].
> Not all drivers define Vdd.
> Some call it AVdd.
> 
> [...]
> 
> It's an idea to add it, and that can give control to the driver to power-up the
> ADC, by defining a regulator [vdd-supply] in the device-tree.

Hmm... I don't know how useful this would be for the 124x family (I
doubt anyone who needs one of these will power it from its own,
independent supply), but it's a pretty harmless change. I can't think of
any reason to say no :-).

Thanks,
Alex
