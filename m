Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F673138E3
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 17:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhBHQHy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 11:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233959AbhBHQHc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Feb 2021 11:07:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 703C364DF0;
        Mon,  8 Feb 2021 16:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612800411;
        bh=fTuhJ5RT5eLAOUQrf/tdirgkNlz+VEc+4HXnU0SEBNY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CE+UBgTcDUlapJhqmFejcia3qaw0B8VrsoRrETcKyAGabydxD4GrGLxeuQh4z2WIV
         fEZUTK3eyBYKhdKsVYF1E09qTHQFS9rpK+bfnU5WcTgMyQTcStYiBjA8Or50Bygx3i
         P+1YFg3c1WmM/GRPnWKHhQEIJrWWfa+f4JEK5X+p4uJC7vvyk//cyBqLY++9h2ZgWh
         ZmphXs+BzmLpUhXwZE2rmbfUSSbU0Hgr8R8TFT1Ec1Ks31652+73b0yy3R61zX3+V4
         RDb1bq8r+a9PvwCpd7w5rnK2D4g6ob+0j7PXUc/F625iJ3HNs2ZUOXcWIz6lsnxOGI
         ytIzgvJv58S6w==
Received: by mail-qt1-f182.google.com with SMTP id w20so10669510qta.0;
        Mon, 08 Feb 2021 08:06:51 -0800 (PST)
X-Gm-Message-State: AOAM531PbvIWNh1HoTpcl2TbMEO9/WPrtJDz5V86miULqnODZj7Xkuwu
        BGddixzu6B17Ek55cks6W8S8D+0ZGQ5S6YWGBw==
X-Google-Smtp-Source: ABdhPJzQqyDVjzf3UbUtZdEJmP0vjWtaTKE5/EstbBlrylclBdwLqosH30kf0R50qJ8YnbDKvk1GGSZilez2wJPVCUk=
X-Received: by 2002:ac8:5c41:: with SMTP id j1mr15757118qtj.306.1612800410564;
 Mon, 08 Feb 2021 08:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20210204113551.68744-1-alexandru.tachici@analog.com>
 <20210204113551.68744-3-alexandru.tachici@analog.com> <20210206152643.53b0e01b@archlinux>
In-Reply-To: <20210206152643.53b0e01b@archlinux>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 8 Feb 2021 10:06:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+zXzqkMbq5x6GCdE_175MpTGHw3kfOKaPpuaWuAtMF-Q@mail.gmail.com>
Message-ID: <CAL_Jsq+zXzqkMbq5x6GCdE_175MpTGHw3kfOKaPpuaWuAtMF-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: ad7124: add config nodes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Tachici <alexandru.tachici@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Feb 6, 2021 at 9:26 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 4 Feb 2021 13:35:51 +0200
> <alexandru.tachici@analog.com> wrote:
>
> > From: Alexandru Tachici <alexandru.tachici@analog.com>
> >
> > Document use of configurations in device-tree bindings.
> >
> > Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
>
> Ignoring discussing in my reply to the cover letter...
>
> This is a breaking change as described.  We can't move properties
> around without some sort of fullback for them being in the old
> location.
>
> > ---
> >  .../bindings/iio/adc/adi,ad7124.yaml          | 72 +++++++++++++++----
> >  1 file changed, 57 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > index fb3d0dae9bae..330064461d0a 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > @@ -62,20 +62,19 @@ required:
> >    - interrupts
> >
> >  patternProperties:
> > -  "^channel@([0-9]|1[0-5])$":
> > -    $ref: "adc.yaml"
> > +  "^config@(2[0-7])$":
> >      type: object
> >      description: |
> > -      Represents the external channels which are connected to the ADC.
> > +      Represents a channel configuration.
> > +      See Documentation/devicetree/bindings/iio/adc/adc.txt.
>
> adc.yaml now.
>
>
> >
> >      properties:
> >        reg:
> >          description: |
> > -          The channel number. It can have up to 8 channels on ad7124-4
> > -          and 16 channels on ad7124-8, numbered from 0 to 15.
> > +          The config number. It can have up to 8 configuration.
> >          items:
> > -          minimum: 0
> > -          maximum: 15
> > +         minimum: 20
> > +         maximum: 27
>
> Number then 0-7 please rather than 20-27.

That doesn't work. It would be creating 2 address spaces at one level
with channel@0 and config@0. The way to address this is add a
'configs' node with config@N children.

My question here though is where does 20-27 come from. I suspect it's
made up which isn't good either. Addresses should also be rooted in
something in the h/w.

Rob
