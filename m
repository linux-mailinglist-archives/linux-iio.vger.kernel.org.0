Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD962A1ACA
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 22:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgJaVgI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 17:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJaVgH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2020 17:36:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBDDC0617A6
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2020 14:36:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z17so11149510iog.11
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2020 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqiiJZ1Jn+duZvhe/kUIlmnyEO4OpOKe0K3m+hAK0iM=;
        b=KkMCNU8fRz3Re1k67t8bOoaMojFl37v+t+zbRzrtWiYkjjY2KWfL2tbAkIeITPbPSL
         P3YVFlPvT7vxflpJZRLx6VyWSCtKpwaQkYq8fzm/pb9CPKLdMtetkxsLWIbaJjjlpShE
         YGQAxj7qb+tz9LBATgri8YcBjQnyI9iEIqtKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqiiJZ1Jn+duZvhe/kUIlmnyEO4OpOKe0K3m+hAK0iM=;
        b=P2lxS4hjuFa8UcnGof2jRXnWhxb1Ht5aGjL1LqBdMoQNmFqjNf0eQthSg4c4quyR5w
         v2kWlHPmQOUNchZJsNZjZAVfslsRBiQG2chPl+I8zKx0zN6cocoJGt3cQ0hPaaIe2DVZ
         2MtILB55TCAvixxLAHcwhEsi6nx3PNKREAT6g7TQugg+Ya03maf20c9tp2ULW8xhz94y
         6aqNZ1rmZyeScgE45fTkWJT5IGSmkDGnjXN0LJqtST58EyULtABW/C7ZUCtFZkJgGURA
         vFpJv88I+3dHolr4S1uAw/ofZimHh7rqmXKrWT+O8Ae78sJwI7dvXJNWC4BXRlm87rwd
         Z9hg==
X-Gm-Message-State: AOAM532N4IiTCU5aAb2hZavo3dnlQmdeAWr+Nve5I5E+iXrEQAt6fFkt
        lo13IgTFXQhOjiUJb2vEr1FCqpWPvKigParrsvxCVg==
X-Google-Smtp-Source: ABdhPJy2e2hCfFbsSsmelvBJuBk7YsXrTsAF+RYBohnCKiwJpz9/sV6IQhpeUbRdr6ofJ1x3uXW0UIdoCL/U+SUcmuU=
X-Received: by 2002:a6b:b28d:: with SMTP id b135mr1422938iof.95.1604180166734;
 Sat, 31 Oct 2020 14:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201031184854.745828-1-jic23@kernel.org> <20201031184854.745828-15-jic23@kernel.org>
 <CAJCx=gmwc=a8F5ytYajKbA_QjkVHwJxn4xpeNb==v7AuDGZb-A@mail.gmail.com>
In-Reply-To: <CAJCx=gmwc=a8F5ytYajKbA_QjkVHwJxn4xpeNb==v7AuDGZb-A@mail.gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 31 Oct 2020 14:35:56 -0700
Message-ID: <CAJCx=gmf_PTTGMwY174CZj56JnFmYhBW0CmfXSMp_paR06fhXg@mail.gmail.com>
Subject: Re: [PATCH 14/46] dt-bindings:iio:light:avago,apds9960: txt to yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <mranostay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 31, 2020 at 2:33 PM Matt Ranostay
<matt.ranostay@konsulko.com> wrote:
>
> On Sat, Oct 31, 2020 at 11:51 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Very simple binding that we could move into trivial-devices.yaml
> > with a small loss of documentation.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Matt Ranostay <mranostay@gmail.com>
>
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

Actually still Acked-by but could you change my email below to my Konsulko one?

Thanks,

Matt

> > ---
> >  .../bindings/iio/light/apds9960.txt           | 21 ---------
> >  .../bindings/iio/light/avago,apds9960.yaml    | 44 +++++++++++++++++++
> >  2 files changed, 44 insertions(+), 21 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/light/apds9960.txt b/Documentation/devicetree/bindings/iio/light/apds9960.txt
> > deleted file mode 100644
> > index c53ddb81c4aa..000000000000
> > --- a/Documentation/devicetree/bindings/iio/light/apds9960.txt
> > +++ /dev/null
> > @@ -1,21 +0,0 @@
> > -* Avago APDS9960 gesture/RGB/ALS/proximity sensor
> > -
> > -https://www.avagotech.com/docs/AV02-4191EN
> > -
> > -Required properties:
> > -
> > -  - compatible: must be "avago,apds9960"
> > -  - reg: the I2c address of the sensor
> > -  - interrupts : the sole interrupt generated by the device
> > -
> > -  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> > -  node bindings.
> > -
> > -Example:
> > -
> > -apds9960@39 {
> > -       compatible = "avago,apds9960";
> > -       reg = <0x39>;
> > -       interrupt-parent = <&gpio1>;
> > -       interrupts = <16 1>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
> > new file mode 100644
> > index 000000000000..eae8c7327c0f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/avago,apds9960.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Avago APDS9960 gesture/RGB/ALS/proximity sensor
> > +
> > +maintainers:
> > +  - Matt Ranostay <mranostay@gmail.com>
> > +
> > +description: |
> > +  Datasheet at https://www.avagotech.com/docs/AV02-4191EN
> > +
> > +properties:
> > +  compatible:
> > +    const: avago,apds9960
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        light-sensor@39 {
> > +            compatible = "avago,apds9960";
> > +            reg = <0x39>;
> > +            interrupt-parent = <&gpio1>;
> > +            interrupts = <16 1>;
> > +        };
> > +    };
> > +...
> > --
> > 2.28.0
> >
