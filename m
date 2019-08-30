Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46314A36D7
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2019 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfH3MeV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Aug 2019 08:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbfH3MeV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Aug 2019 08:34:21 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE35B23405;
        Fri, 30 Aug 2019 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567168459;
        bh=3rrXMJtan18Re7KhSBgKrcPPLL6Q9PW+UzzWxgZVuxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D6LSqkeBH6QfYvQj7z50Sr48oxBfEwB4GIXfdJeXuSqDkR0zR03aGARZ93vGnnN1D
         rpf6VCOO/Q7IlgmozxmDoqGj8EJ5P0dvujyKQB0rI+WcUlOjzOPVf79wVsP3nncI0n
         zGozVKQ4XencXLew1kh8byGhefJ+KUuUp7juQ8Cg=
Received: by mail-qk1-f173.google.com with SMTP id g17so5938145qkk.8;
        Fri, 30 Aug 2019 05:34:19 -0700 (PDT)
X-Gm-Message-State: APjAAAXg8QuwzBrep8KzKs/IPwLY6fYFgwrhcfoxN6cOjXcPdp3pOcSA
        xGvV5o5BLTxnro4XrU081d1arby8cUbedf526w==
X-Google-Smtp-Source: APXvYqyatiuSoW8EWuTbC7p9+3HzMSiSVBIaY3duZuqWM9ddQfN7nymjPmtry1NYpS+vL/e737xtFZPFXwuYbrljx+U=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr15083639qke.223.1567168458921;
 Fri, 30 Aug 2019 05:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
 <1566876924-63608-2-git-send-email-preid@electromag.com.au>
 <a30b6dca-c598-135a-0559-1018dd5f5fde@xilinx.com> <20190829230207.GA22979@bogus>
 <b50bce2d-8819-67b1-c55c-8c2b8070a4ac@electromag.com.au>
In-Reply-To: <b50bce2d-8819-67b1-c55c-8c2b8070a4ac@electromag.com.au>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Aug 2019 07:34:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKb8cC=4HR7uVHmKt-zw32U_1u62hG4h-TnbPy=a+QZZg@mail.gmail.com>
Message-ID: <CAL_JsqKb8cC=4HR7uVHmKt-zw32U_1u62hG4h-TnbPy=a+QZZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-binding: iio: Add optional label property
To:     Phil Reid <preid@electromag.com.au>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 29, 2019 at 8:01 PM Phil Reid <preid@electromag.com.au> wrote:
>
> On 30/08/2019 07:02, Rob Herring wrote:
> > On Wed, Aug 28, 2019 at 08:09:19AM +0200, Michal Simek wrote:
> >> On 27. 08. 19 5:35, Phil Reid wrote:
> >>> This optional property defines a symbolic name for the device.
> >>>
> >>> Signed-off-by: Phil Reid <preid@electromag.com.au>
> >>> ---
> >>>   Documentation/devicetree/bindings/iio/iio-bindings.txt | 5 +++++
> >>>   1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>> index 68d6f8ce063b..ffeae5aad8b5 100644
> >>> --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> >>> @@ -18,12 +18,17 @@ Required properties:
> >>>                with a single IIO output and 1 for nodes with multiple
> >>>                IIO outputs.
> >>>
> >>> +Optional properties:
> >>> +label:                A symbolic name for the device.
> >>> +
> >>> +
> >>>   Example for a simple configuration with no trigger:
> >>>
> >>>     adc: voltage-sensor@35 {
> >>>             compatible = "maxim,max1139";
> >>>             reg = <0x35>;
> >>>             #io-channel-cells = <1>;
> >>> +           label = "adc_voltage_sensor";
> >>>     };
> >>>
> >>>   Example for a configuration with trigger:
> >>>
> >>
> >> Just for the record. This patch has been created based on initial
> >> discussion about label property. And Rob had not problem with using
> >> label in connection to ina226. https://lkml.org/lkml/2019/8/27/1213
> >
> > I didn't, but based on the name here I'm less convinced. 'label' is
> > supposed to be for needing to distinguish between more than 1 of
> > something. A name like 'adc_voltage_sensor' doesn't really.
> >
> > Rob
> >
> >
>
> That's the problem we're try to solve. Having multiple devices and try to
> determine which device is which.
> eg: Mutliple adc's.
> For example I have the same dac chip on multiple boards that do different
> things, it's difficult to id them.
>
> so label examples could be:
> label = "current_control_group1";
> label = "voltage_control_group1";
>
> Are you totally against this or is it a problem with me not being clear
> with the problem and the wording of the commit message or the example?

It's just the example is less than ideal. But it's just an example, so:

Reviewed-by: Rob Herring <robh@kernel.org>

Feel free to update the example if you respin.

Rob
