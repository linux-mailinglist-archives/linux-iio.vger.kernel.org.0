Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0028257210
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 21:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFZT5T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 15:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFZT5S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 15:57:18 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19E9208E3;
        Wed, 26 Jun 2019 19:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561579038;
        bh=q12cfSX3v0F0JuCJ9BQvHQk8sKqwyAEk8RPAz/s1X9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vFmZ8XyvBSTh0e4KGxZnWfJUJBTl52Jy3tKafpiQVOKeo53HxB7gw3DLeX3U56mkn
         Yn5UXbTeXJyS8KXRFH88cfvZwVfNgfJxL9y/+k45LCX6ycyV0XlVBjmJsurojk+/jn
         FMdpofFkWGfCRh+5b6AATgEDg15V/nFqMa6Q4xMU=
Received: by mail-qk1-f176.google.com with SMTP id r6so2769366qkc.0;
        Wed, 26 Jun 2019 12:57:17 -0700 (PDT)
X-Gm-Message-State: APjAAAWc/9MwVeldfaEEvzL0FkDRHx4xqKCy45QA1nDe/NPYEbv4qeu7
        PuesP6cF+diyvk8F/BNNKMWLtHAm6PCjIYXavQ==
X-Google-Smtp-Source: APXvYqxWJVDIHYSGBPAIUGuAsvePBZ2Zo8IfE2R8hma+X0FdLE7O6BP+V2buEQYTKH74a/mdpKX7KTRDXIQcCn8P8VY=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr5663458qkl.254.1561579037272;
 Wed, 26 Jun 2019 12:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190625081128.22190-1-mircea.caprioru@analog.com>
 <20190625081128.22190-4-mircea.caprioru@analog.com> <CAL_JsqLHpT1z3O5QctG6WWB6bcOms5XYTOOrq6tK6uOZPNQtDQ@mail.gmail.com>
 <20190626203449.75e2a8ea@archlinux>
In-Reply-To: <20190626203449.75e2a8ea@archlinux>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 26 Jun 2019 13:57:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ4Jf0F4jxz2ufH-j3Mxp_B3=CiLfedP+4bneQ=V1AXNQ@mail.gmail.com>
Message-ID: <CAL_JsqJ4Jf0F4jxz2ufH-j3Mxp_B3=CiLfedP+4bneQ=V1AXNQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/5] dt-bindings: iio: adc: Convert ad7124
 documentation to YAML
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 26, 2019 at 1:34 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 26 Jun 2019 08:44:36 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
>
> > On Tue, Jun 25, 2019 at 2:12 AM Mircea Caprioru
> > <mircea.caprioru@analog.com> wrote:
> > >
> > > Convert AD7124 bindings documentation to YAML format.
> > >
> > > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > > ---
> > >
> > > Changelog v2:
> > > - modified SPDX license to GPL-2.0 OR BSD-2-Clause
> > > - added regex for a range from 0 to 15
> > > - added minimum and maximum constraints for reg property
> > > - set type and range of values for adi,reference-select property
> > > - used items for diff-channels property
> > > - set bipolar, adi,buffered-positive and negative to type: boolean
> > >
> > > Changelog v3:
> > > - moved adi,buffered-positive and negative properties to own commit
> > >
> > > Changelog v4:
> > > - removed old txt dt-binding
> > >
> > >  .../bindings/iio/adc/adi,ad7124.txt           |  75 ---------
> > >  .../bindings/iio/adc/adi,ad7124.yaml          | 144 ++++++++++++++++++
> > >  2 files changed, 144 insertions(+), 75 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> Something a bit odd happened when trying to apply this, so I ended up doing
> it rather manually.
>
> error: cannot convert from y to UTF-8
> fatal: could not parse patch
>
> Anyhow, I think it's fine now, but would welcome any suggestion on what causes
> that one?  Patch was perfectly happy with it.

Looks like an error in the mail header:

Content-Type: text/plain; charset="y"

Rob
