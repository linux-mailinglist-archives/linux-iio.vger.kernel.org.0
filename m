Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC04407924
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhIKPmO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 11:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232450AbhIKPmN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 11:42:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D8161205;
        Sat, 11 Sep 2021 15:40:56 +0000 (UTC)
Date:   Sat, 11 Sep 2021 16:44:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 0/7] add internal channels support
Message-ID: <20210911164428.023953c4@jic23-huawei>
In-Reply-To: <20210908155452.25458-1-olivier.moysan@foss.st.com>
References: <20210908155452.25458-1-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 8 Sep 2021 17:54:45 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> This patchset adds support of ADC2 internal channels VDDCORE, VREFINT and VBAT
> on STM32MP15x SoCs. The generic IIO channel bindings is also introduced here
> to provide this feature. The legacy channel binding is kept for backward compatibility.

Before I actually look at the patch, general naming comment.
Please make sure that the driver / device name appears in the cover letter title
and all the patches.  It makes it much easier for people to find the code relevant
to them.

Thank,

Jonathan

> 
> Olivier Moysan (7):
>   dt-bindings: iio: adc: add generic channel binding
>   dt-bindings: iio: adc: add nvmem support for vrefint internal channel
>   iio: adc stm32-adc: split channel init into several routines
>   iio: adc: stm32-adc: add support of generic channels binding
>   iio: adc: stm32-adc: add support of internal channels
>   iio: adc: stm32-adc: add vrefint calibration support
>   iio: adc: stm32-adc: use generic binding for sample-time
> 
>  .../bindings/iio/adc/st,stm32-adc.yaml        | 108 ++++-
>  drivers/iio/adc/stm32-adc-core.h              |   8 +
>  drivers/iio/adc/stm32-adc.c                   | 418 ++++++++++++++++--
>  3 files changed, 482 insertions(+), 52 deletions(-)
> 

