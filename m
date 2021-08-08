Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB83E3B32
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhHHPt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 11:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhHHPt1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 11:49:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA92A6044F;
        Sun,  8 Aug 2021 15:49:05 +0000 (UTC)
Date:   Sun, 8 Aug 2021 16:51:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v2 0/4] iio: accel: bmc150: Add support for INT2 and
 BMC156
Message-ID: <20210808165155.161ecfcb@jic23-huawei>
In-Reply-To: <20210802155657.102766-1-stephan@gerhold.net>
References: <20210802155657.102766-1-stephan@gerhold.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Aug 2021 17:56:53 +0200
Stephan Gerhold <stephan@gerhold.net> wrote:

> This series makes it possible to set up interrupts with the BMC150 driver
> on boards where only the INT2 pin is connected (and not INT1). This is
> particularly always the case for BMC156 since for some reason it only
> has the INT2 pin and not the INT1 pin.
> 
> These changes were already partially discussed here:
> https://lore.kernel.org/linux-iio/YMOphuXSoODIVX06@gerhold.net/

Hopefully one of us or someone else will come back to this and
figure out a clean solution to generic fw support for getting named IRQs.
In the meantime this will be fine for this particular driver.

Some fun to look forwards to ;)

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it and see what we missed.

Thanks,

Jonathan

> 
> Changes in v2:
>   - PATCH 1/4: Clarify order of "interrupts" with "interrupt-names"
>   - PATCH 4/4: Wrap a long line, clarify BOSCH_UNKNOWN with a comment
> 
> v1: https://lore.kernel.org/linux-iio/20210719112156.27087-1-stephan@gerhold.net/
> 
> Stephan Gerhold (4):
>   dt-bindings: iio: accel: bma255: Add interrupt-names
>   dt-bindings: iio: accel: bma255: Add bosch,bmc156_accel
>   iio: accel: bmc150: Make it possible to configure INT2 instead of INT1
>   iio: accel: bmc150: Add support for BMC156
> 
>  .../bindings/iio/accel/bosch,bma255.yaml      | 34 +++++++-
>  drivers/iio/accel/Kconfig                     |  5 +-
>  drivers/iio/accel/bmc150-accel-core.c         | 78 +++++++++++++++----
>  drivers/iio/accel/bmc150-accel-i2c.c          | 10 ++-
>  drivers/iio/accel/bmc150-accel-spi.c          | 10 ++-
>  drivers/iio/accel/bmc150-accel.h              | 20 ++++-
>  6 files changed, 134 insertions(+), 23 deletions(-)
> 

