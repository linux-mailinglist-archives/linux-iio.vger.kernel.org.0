Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60F3A47EB
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFKRfn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:35:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhFKRfn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:35:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E8B4613CF;
        Fri, 11 Jun 2021 17:33:42 +0000 (UTC)
Date:   Fri, 11 Jun 2021 18:35:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 00/10] iio: accel: bmc150: Add support for
 BMA253/BMA254
Message-ID: <20210611183537.40adbfed@jic23-huawei>
In-Reply-To: <20210611080903.14384-1-stephan@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Jun 2021 10:08:53 +0200
Stephan Gerhold <stephan@gerhold.net> wrote:

> The Bosch BMA253 accelerometer is very similar to both BMA254 and BMA255.
> The current situation is very confusing: BMA254 is supported by the bma180
> driver, but BMA255 is supported by the bmc150-accel driver.
> 
> It turns out the bma180 and bmc150-accel drivers have quite some overlap,
> and BMA253/BMA254 would be a bit better supported in bmc150-accel
> (which has support for the motion trigger/interrupt).
> 
> This series adds BMA253 support to bmc150-accel and also moves BMA254
> over to bmc150, removing some unnecessary code from the bma180 driver.
> 
> In v2 I also sneaked in a small fix for the scale table of BMA222
> to simplify backporting for the stable people.
After cheating a bit and pulling the dependency across from my fixes-togreg
branch (along with the other patches that were there), I can now apply this.

So applied to the fixes-togreg branch of iio.git and pushed out as testing
for 0-day to have a quick poke at it before I let this going into linux-next.

Thanks,

Jonathan

> 
> ---
> Changes in v3:
>   - Add new "iio: accel: bmc150: Clarify combo modules in Kconfig" patch
>   - Sort "one-line" chip name lists as well, not just multi-line ones
> 
> v2: https://lore.kernel.org/linux-iio/20210610122126.50504-1-stephan@gerhold.net/
> Changes in v2:
>   - Add new "iio: accel: bmc150: Fix bma222 scale unit" patch at the
>     beginning so the stable people can backport it without conflicts
>   - Add Reviewed-by: from Hans and Andy for all previous patches
>   - Add patch 3 and 4 to have all the chip lists in a consistent order
>   - Fix last patch to also drop BMA254 from the file header in bma180.c
> 
> v1: https://lore.kernel.org/linux-iio/20210610095300.3613-1-stephan@gerhold.net/
> 
> Stephan Gerhold (10):
>   iio: accel: bmc150: Fix bma222 scale unit
>   iio: accel: bmc150: Clarify combo modules in Kconfig
>   iio: accel: bmc150: Drop misleading/duplicate chip identifiers
>   iio: accel: bmc150: Drop duplicated documentation of supported chips
>   iio: accel: bmc150: Sort all chip names alphabetically / by chip ID
>   dt-bindings: iio: accel: bma255: Document bosch,bma253
>   iio: accel: bmc150: Add device IDs for BMA253
>   dt-bindings: iio: bma255: Allow multiple interrupts
>   dt-bindings: iio: accel: bma180/bma255: Move bma254 to bma255 schema
>   iio: accel: bma180/bmc150: Move BMA254 to bmc150-accel driver
> 
>  .../bindings/iio/accel/bosch,bma180.yaml      |  3 +-
>  .../bindings/iio/accel/bosch,bma255.yaml      |  9 +-
>  drivers/iio/accel/Kconfig                     | 11 ++-
>  drivers/iio/accel/bma180.c                    | 92 +++----------------
>  drivers/iio/accel/bmc150-accel-core.c         | 87 ++++++------------
>  drivers/iio/accel/bmc150-accel-i2c.c          | 52 +++++------
>  drivers/iio/accel/bmc150-accel-spi.c          | 31 ++++---
>  drivers/iio/accel/bmc150-accel.h              | 10 --
>  8 files changed, 98 insertions(+), 197 deletions(-)
> 

