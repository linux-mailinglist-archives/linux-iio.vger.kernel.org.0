Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5972E427145
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbhJHTPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 15:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhJHTPf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 15:15:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C21D61038;
        Fri,  8 Oct 2021 19:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633720420;
        bh=AC8mlvl5rpF4l6tOqjjPamQgwiRioSA2m1qyyv95PCQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dk6yvwYY35lLQNJOG6jJoBC18AUEpzfo7iIUP9XGBBjLELZYLKT6Jm9RnH05rrPnY
         Ft1jaVk8qJ3cmjAuI9NUEwSJH3FMjclwv667zC09NslNOQMdbVpZI753XwRKYdGtqn
         prNNDc9CE9a3Lf5m3gokvzKKS3fxwtEeP+/RV0Dh4R89CIvw63OH689QO6NIbe0cxI
         HAfth3XHvI75Vzd2beCbPov9yVPhPGEliZwp37faJkA38ng9zeiw06BTWpId87rUvU
         AuUWOwEE/76FBPnjxHV5Z3BSHW91aE3rfGgKiUDvAmXf9zrmODwYO/gblboRVK7cin
         9EjDnI1PLv+dw==
Received: by mail-ed1-f48.google.com with SMTP id x7so38184871edd.6;
        Fri, 08 Oct 2021 12:13:39 -0700 (PDT)
X-Gm-Message-State: AOAM531sbuBKiV0yi+7/aHHeTm1kNz7WgkFaDDn5trp1kuNHQHm3Sphg
        w7ir88Eh4NczedmPizGKWM93Zd4zUx1wjpgu9Q==
X-Google-Smtp-Source: ABdhPJzQEW4du5+j1cLnAV3kaaQAC/63eZPYU9De08b8WapQk+yA6t4Vce3DmKIB2uMz/mCtM0KTzCGtvMz+GzFQzfg=
X-Received: by 2002:a05:6402:27d2:: with SMTP id c18mr8693395ede.271.1633720418392;
 Fri, 08 Oct 2021 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
 <20211007134641.13417-3-vincent.whitchurch@axis.com> <1633661172.633248.1409599.nullmailer@robh.at.kernel.org>
 <20211008135610.GA16402@axis.com> <d794e44d-e67a-e51e-93b0-9b23edba2e21@axentia.se>
In-Reply-To: <d794e44d-e67a-e51e-93b0-9b23edba2e21@axentia.se>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Oct 2021 14:13:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKPFnNsX6g2GWFaF3ntb7mfCt4+YxFtv_JfMt2mp1s+mg@mail.gmail.com>
Message-ID: <CAL_JsqKPFnNsX6g2GWFaF3ntb7mfCt4+YxFtv_JfMt2mp1s+mg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: io-channel-mux: Add property for
 settle time
To:     Peter Rosin <peda@axentia.se>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        kernel <kernel@axis.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 8, 2021 at 10:27 AM Peter Rosin <peda@axentia.se> wrote:
>
> On 2021-10-08 15:56, Vincent Whitchurch wrote:
> > On Fri, Oct 08, 2021 at 04:46:12AM +0200, Rob Herring wrote:
> >> On Thu, 07 Oct 2021 15:46:40 +0200, Vincent Whitchurch wrote:
> >>> Hardware may require some time for the muxed analog signals to settle
> >>> after the muxing is changed.  Allow this time to be specified in the
> >>> devicetree.
> >>>
> >>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> >>> ---
> >>>  .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml  | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>
> >> Running 'make dtbs_check' with the schema in this patch gives the
> >> following warnings. Consider if they are expected or the schema is
> >> incorrect. These may not be new warnings.
> >
> > Yes, these are not new warnings.
> >
> >> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> >> This will change in the future.
> >>
> >> Full log is available here: https://patchwork.ozlabs.org/patch/1537724
> >>
> >>
> >> adc0mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> >>      arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml
> >>
> >> adc10mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> >>      arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml
> > [...]
> >
> > I think the fix for these is to add a "#io-channel-cells": const 1 to
> > the schema.
>
> Agreed.
>
> >> envelope-detector-mux: channels: ['', '', 'sync-1', 'in', 'out', 'sync-2', 'sys-reg', 'ana-reg'] has non-unique elements
> >>      arch/arm/boot/dts/at91-tse850-3.dt.yaml
> >
> > This one looks like an error in that particular devicetree.
> >
> The double '' is intentional; this mux is 8-way but only 6 legs are
> connected, with the first two unused. I don't know how or where to make
> changes to dodge the warning. I don't want to put names on things that
> do not exist, and the iio-mux driver is using empty names as a hint to
> not configure any child channel for those indices that have empty names.
> If e.g. channels 0-5 are in use, then this is not a problem since you
> can just end early with 6 names instead of 8, but alas, channels 2-7
> was what the hw-crowd fancied in this case.

There's a specific string type for this: non-unique-string-array

Unfortunately, no way to say unique or empty strings.

Rob
