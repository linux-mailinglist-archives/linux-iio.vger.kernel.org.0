Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA0D2D8D3B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 14:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406828AbgLMNZ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 08:25:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406755AbgLMNZ7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 08:25:59 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FEB820575;
        Sun, 13 Dec 2020 13:25:17 +0000 (UTC)
Date:   Sun, 13 Dec 2020 13:25:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: accel: bma255: Fix bmc150/bmi055
 compatible
Message-ID: <20201213132514.00d7ffff@archlinux>
In-Reply-To: <20201209181739.GA708144@robh.at.kernel.org>
References: <20201202083551.7753-1-stephan@gerhold.net>
        <20201209181739.GA708144@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Dec 2020 12:17:39 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 02 Dec 2020 09:35:51 +0100, Stephan Gerhold wrote:
> > The bmc150-accel-i2c.c driver has an "_accel" suffix for the
> > compatibles of BMC150 and BMI055. This is necessary because BMC150
> > contains both accelerometer (bosch,bmc150_accel) and magnetometer
> > (bosch,bmc150_magn) and therefore "bosch,bmc150" would be ambiguous.
> > 
> > However, the binding documentation suggests using "bosch,bmc150".
> > Add the "_accel" suffix for BMC150 and BMI055 so the binding docs
> > match what is expected by the driver.
> > 
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Fixes: 496a39526fce8 ("iio: accel: bmc150-accel: Add DT bindings")
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the fixes-togreg branch of iio.git which is now based on stuff
queued up for the merge window. I'll send a pull not long after rc1.

Thanks,

Jonathan


