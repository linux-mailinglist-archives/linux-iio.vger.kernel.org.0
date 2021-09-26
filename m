Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC1418896
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 14:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhIZMVD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 08:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhIZMVD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 08:21:03 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB1760F4B;
        Sun, 26 Sep 2021 12:19:23 +0000 (UTC)
Date:   Sun, 26 Sep 2021 13:23:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v3 0/7] iio: adc: stm32-adc: add internal channels
 support
Message-ID: <20210926132313.16c7a356@jic23-huawei>
In-Reply-To: <20210924083410.12332-1-olivier.moysan@foss.st.com>
References: <20210924083410.12332-1-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Sep 2021 10:34:03 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> This patchset adds support of ADC2 internal channels VDDCORE, VREFINT and VBAT
> on STM32MP15x SoCs. The generic IIO channel bindings is also introduced here
> to provide this feature. The legacy channel binding is kept for backward compatibility.

Hi Olivier,

I had a read through and am happy with how this looks now.
I'll leave it on the list for a while longer because Rob may well want to take
a final look at patch 1.

Obviously input from other people also welcome!

If it looks like I have forgotten it in a few weeks feel free to poke me.

Thanks,

Jonathan

> 
> Changes in v2:
> - Add 'deprecated' to channels legacy properties in ADC bindings
> - Add set/clr service for common registers, to make code more generic in
>   internal channels enable/disable services.
> - Expose vrefint channel as a processed channel to return
>   the actual value of vrefp.
> - Minor code improvements
> 
> Changes in v3:
> - fix vrefint sampling time check.
> 
> Olivier Moysan (7):
>   dt-bindings: iio: stm32-adc: add generic channel binding
>   dt-bindings: iio: stm32-adc: add nvmem support for vrefint internal
>     channel
>   iio: adc: stm32-adc: split channel init into several routines
>   iio: adc: stm32-adc: add support of generic channels binding
>   iio: adc: stm32-adc: add support of internal channels
>   iio: adc: stm32-adc: add vrefint calibration support
>   iio: adc: stm32-adc: use generic binding for sample-time
> 
>  .../bindings/iio/adc/st,stm32-adc.yaml        | 108 ++++-
>  drivers/iio/adc/stm32-adc-core.h              |   8 +
>  drivers/iio/adc/stm32-adc.c                   | 426 ++++++++++++++++--
>  3 files changed, 487 insertions(+), 55 deletions(-)
> 

