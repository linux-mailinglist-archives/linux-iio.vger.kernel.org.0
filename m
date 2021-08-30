Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD44A3FB5F1
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 14:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhH3MYV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 08:24:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232442AbhH3MYV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 08:24:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC01E61154;
        Mon, 30 Aug 2021 12:23:24 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:26:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 00/10] iio: adc: at91-sama5d2_adc: add support for
 sama7g5
Message-ID: <20210830132636.16dde030@jic23-huawei>
In-Reply-To: <20210824115441.681253-1-eugen.hristev@microchip.com>
References: <20210824115441.681253-1-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 14:54:31 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Hi,
> 
> This series adds support for sama7g5.
> 
> The sama7g5 is slightly different from sama5d2, but has the same basic
> operations. The register map is a bit different, so, I added some primitives
> to differentiate between the two classes of hardware blocks (sama5d2-sam9x60
> and sama7g5).
> 
> Sama7g5 has 16 channels ADC, no resistive touch, and extra features
> (FIFOs, better oversampling , not implemented yet).
> 
> It is a rework of the series initially sent here:
> https://marc.info/?l=linux-iio&m=161461656807826&w=2
> 
> I reworked this according to review by Jonathan, meaning that first I created
> a no-op patch that will convert the driver to a more platform specific data
> dedicated type of driver. This adds various structures that hold things like
> register layout and channel information.
> After this I created few patches that implement the main differences between
> sama7g5 and older products: the end-of-conversion new register. I added
> helper functions to make code more easy to read and more simple.
> One the last patches adds the layout and channels for sama7g5.
> At this moment in linux-next, the DT for sama7g5 and sama7g5ek is present,
> and the last patches add and enable this node in DT for this board.
> 
> Eugen
0-8 applied with the minor tweak mentioned in a reply to relevant patch.

I'll assume 9-10 will got via normal soc related tree.

Note that I'm queuing these up for the merge window after this one now
(5.16).

Thanks,

Jonathan

> 
> 
> 
> Eugen Hristev (10):
>   dt-bindings: iio: adc: at91-sama5d2: add compatible for sama7g5-adc
>   iio: adc: at91-sama5d2_adc: initialize hardware after clock is started
>   iio: adc: at91-sama5d2_adc: remove unused definition
>   iio: adc: at91-sama5d2_adc: convert to platform specific data
>     structures
>   iio: adc: at91-sama5d2-adc: add support for separate end of conversion
>     registers
>   iio: adc: at91-sama5d2_adc: add helper for COR register
>   iio: adc: at91-sama5d2_adc: add support for sama7g5 device
>   iio: adc: at91-sama5d2_adc: update copyright and authors information
>   ARM: dts: at91: sama7g5: add node for the ADC
>   ARM: dts: at91: sama7g5ek: enable ADC on the board
> 
>  .../bindings/iio/adc/atmel,sama5d2-adc.yaml   |   1 +
>  arch/arm/boot/dts/at91-sama7g5ek.dts          |   8 +
>  arch/arm/boot/dts/sama7g5.dtsi                |  16 +
>  drivers/iio/adc/at91-sama5d2_adc.c            | 586 ++++++++++++------
>  4 files changed, 425 insertions(+), 186 deletions(-)
> 

