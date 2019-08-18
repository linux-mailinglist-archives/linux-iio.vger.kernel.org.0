Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030B091903
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 20:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfHRSqd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 14:46:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfHRSqd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 14:46:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3BA7206C1;
        Sun, 18 Aug 2019 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566153992;
        bh=fQMh+y+VvLmh0mVYWuKBZ8MFRC6Z4rUi+KbsYjoEQX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HxBqBuWx6oj0XEKw1ZTGd88jnkGkmOq18hrCF1Y5HvcqQzhed2dFCA2BE63MRUTqr
         qDh542bAGuE6x06Sn1JUG1iMymBG8eR/yCUNAgm7RTpRNMic0U5VFxQIr4MALytwuE
         Tiz7PkaXA+CcYLR4NOD+LJTQHgnvL/4paHNRnUp0=
Date:   Sun, 18 Aug 2019 19:46:27 +0100
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
Subject: Re: [PATCH V3 4/4] dt-bindings: iio: adc: ad7192: Add binding
 documentation for AD7192
Message-ID: <20190818194627.4bc9571a@archlinux>
In-Reply-To: <CAL_JsqKONxFbS-nUMc1c=-9HcXCrOVmOOfn9htKOJOjAS6HCKg@mail.gmail.com>
References: <20190814073150.4602-1-mircea.caprioru@analog.com>
        <20190814073150.4602-4-mircea.caprioru@analog.com>
        <CAL_JsqKONxFbS-nUMc1c=-9HcXCrOVmOOfn9htKOJOjAS6HCKg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Aug 2019 20:39:04 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Wed, Aug 14, 2019 at 1:32 AM Mircea Caprioru
> <mircea.caprioru@analog.com> wrote:
> >
> > This patch add device tree binding documentation for AD7192 adc in YAML
> > format.
> >
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > ---
> > Changelog V2:
> > - remove description from spi and interrupt properties
> > - changed the name of the device from ad7192 to adc in the example
> >
> > Changelog V3:
> > - added semicolon at the end of the dt example
> >
> >  .../bindings/iio/adc/adi,ad7192.yaml          | 121 ++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

For some reason, this patch gave me a git error based on encoding. 
I applied it by hand instead and all seemed fine.  Not sure why
that happened!

Applied to the togreg branch of iio.git and pushed out as testing
so the autobuilders can play with it.

Thanks,

Jonathan

