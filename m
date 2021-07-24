Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172923D4890
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 18:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhGXPld (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 11:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGXPlc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 11:41:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A00B60E78;
        Sat, 24 Jul 2021 16:22:00 +0000 (UTC)
Date:   Sat, 24 Jul 2021 17:24:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <raltherr@google.com>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v1 0/7] Add support for ast2600 ADC
Message-ID: <20210724172432.50478f0e@jic23-huawei>
In-Reply-To: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
References: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Jul 2021 16:06:00 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch serials make aspeed_adc.c can support ast2600.
> In additional,
> patch #6 is used to improve the adc accurate and 
> patch #7 is used to fix the clock issue in the original code.
> 
> Billy Tsai (7):
>   dt-bindings: iio: adc: rename the aspeed adc yaml
>   dt-bindings: iio: adc: Binding ast2600 adc.
>   iio: adc: aspeed: completes the bitfield declare.
>   iio: adc: aspeed: Allow driver to support ast2600
>   iio: adc: aspeed: Add func to set sampling rate.
>   iio: adc: aspeed: Add compensation phase.
>   iio: adc: aspeed: Fix the calculate error of clock.

Hi Billy,

Small process note.  If you resend for some reason and the original series
has no reply, it is helpful to people if you just send a reply yourself
to say there is a v2. In the past I've occasionally applied wrong versions
when someone does this!

Thanks,

Jonathan

> 
>  ...speed,ast2400-adc.yaml => aspeed,adc.yaml} |  23 +-
>  drivers/iio/adc/aspeed_adc.c                  | 313 ++++++++++++++----
>  2 files changed, 266 insertions(+), 70 deletions(-)
>  rename Documentation/devicetree/bindings/iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml} (53%)
> 

