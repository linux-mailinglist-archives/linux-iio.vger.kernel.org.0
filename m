Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE68571D6
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 21:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFZTez (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 15:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZTez (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Jun 2019 15:34:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F7821726;
        Wed, 26 Jun 2019 19:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561577694;
        bh=HJ30wok6lm2G6MtsJuoh1ktza4QAqOZwpKAj/5W6ACM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FMNtPdrQxeSkwgQkopqi+QT+Z9GH3oSIW9LVekftpzsaXG8aiP8wKyFQbdn6nBFOq
         4mKKH+PSxWDF6JvVOfDt83rVg/AajnR2aUDziylQsOnSp8VL3co0nbV7frGQHs4iKf
         zkf+ZJixR4r1MBVgAYWKDC3gUqabaPnLoLC1tGzU=
Date:   Wed, 26 Jun 2019 20:34:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 4/5] dt-bindings: iio: adc: Convert ad7124
 documentation to YAML
Message-ID: <20190626203449.75e2a8ea@archlinux>
In-Reply-To: <CAL_JsqLHpT1z3O5QctG6WWB6bcOms5XYTOOrq6tK6uOZPNQtDQ@mail.gmail.com>
References: <20190625081128.22190-1-mircea.caprioru@analog.com>
        <20190625081128.22190-4-mircea.caprioru@analog.com>
        <CAL_JsqLHpT1z3O5QctG6WWB6bcOms5XYTOOrq6tK6uOZPNQtDQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Jun 2019 08:44:36 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Tue, Jun 25, 2019 at 2:12 AM Mircea Caprioru
> <mircea.caprioru@analog.com> wrote:
> >
> > Convert AD7124 bindings documentation to YAML format.
> >
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > ---
> >
> > Changelog v2:
> > - modified SPDX license to GPL-2.0 OR BSD-2-Clause
> > - added regex for a range from 0 to 15
> > - added minimum and maximum constraints for reg property
> > - set type and range of values for adi,reference-select property
> > - used items for diff-channels property
> > - set bipolar, adi,buffered-positive and negative to type: boolean
> >
> > Changelog v3:
> > - moved adi,buffered-positive and negative properties to own commit
> >
> > Changelog v4:
> > - removed old txt dt-binding
> >
> >  .../bindings/iio/adc/adi,ad7124.txt           |  75 ---------
> >  .../bindings/iio/adc/adi,ad7124.yaml          | 144 ++++++++++++++++++
> >  2 files changed, 144 insertions(+), 75 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Something a bit odd happened when trying to apply this, so I ended up doing
it rather manually.

error: cannot convert from y to UTF-8
fatal: could not parse patch

Anyhow, I think it's fine now, but would welcome any suggestion on what causes
that one?  Patch was perfectly happy with it.

Jonathan


