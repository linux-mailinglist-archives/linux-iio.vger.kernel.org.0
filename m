Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6363A1DF1
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 22:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFIUJn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 16:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFIUJl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 16:09:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD9496139A;
        Wed,  9 Jun 2021 20:07:44 +0000 (UTC)
Date:   Wed, 9 Jun 2021 21:09:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan.Cameron@huawei.com, alexandru.tachici@analog.com,
        linux@deviqon.com
Subject: Re: [PATCH v4 00/12] ad_sigma_delta: convert all drivers to
 device-managed
Message-ID: <20210609210935.062e0c68@jic23-huawei>
In-Reply-To: <20210513120752.90074-1-aardelean@deviqon.com>
References: <20210513120752.90074-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 May 2021 15:07:40 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> Well, for lack of a better title that's what this series does.
> It merges Jonathan's patches from:
>   * https://lore.kernel.org/linux-iio/20210508182319.488551-1-jic23@kernel.org/
>     Patch 3/3 was a polished a bit with my comments from that review and also
>     to use the devm_ad_sd_setup_buffer_and_trigger() function.
>   * https://lore.kernel.org/linux-iio/20210509114118.660422-1-jic23@kernel.org/
>     Added only to base the conversion to devm_
> 
> The AD Sigma Delta family of ADC drivers share a lot of the logic in the
> ad_sigma_delta lib-driver.
> 
> This set introduces a devm_ad_sd_setup_buffer_and_trigger() call, which
> aims to replace the 'ad_sd_{setup,cleanup}_buffer_and_trigger()' pair.
> 
> This helps with converting the AD7780, AD7791, AD7793 and AD7192
> drivers use be fully converted to device-managed functions.

Remainder of series applied to the togreg branch of iio.git and pushed out
as testing for 0-day to poke at it.

Thanks,

Jonathan

> 
> Changelog v3 -> v4:
> * https://lore.kernel.org/linux-iio/20210512174914.10549-1-aardelean@deviqon.com/
> * patch 'iio: adc: ad7192: handle zero Avdd regulator value'
>   is now 'iio: adc: ad7192: handle regulator voltage error first'
>   - now checking the regulator_voltage() return first for an error
> 
> Changelog v2 -> v3:
> * https://lore.kernel.org/linux-iio/20210511071831.576145-1-aardelean@deviqon.com/
> * patch 'iio: adc: ad7192: handle zero Avdd regulator value as error'
>   is now 'iio: adc: ad7192: handle zero Avdd regulator value'
>   essentially just doing a simple 'if (voltage_uv >= 0)' check now
> 
> Changelog v1 -> v2:
> * https://lore.kernel.org/linux-iio/20210510125523.1271237-1-aardelean@deviqon.com/
> * add my S-o-b tags on all patches; with @deviqon.com email
>   - Note: I'm a little unsure about the correctness of these tags; there
>     are a few mixed-in, with Reviewed-by & Signed-off-by; I'm fine if
>     Jonathan tweaks these as needed;
> * added patch 'iio: adc: ad7192: handle zero Avdd regulator value as error'
> * all Fixes patches should be now at the beginning of the series
> 
> Alexandru Ardelean (8):
>   iio: adc: ad7192: handle regulator voltage error first
>   iio: adc: ad_sigma_delta: introduct
>     devm_ad_sd_setup_buffer_and_trigger()
>   iio: adc: ad7793: convert to device-managed functions
>   iio: adc: ad7791: convert to device-managed functions
>   iio: adc: ad7780: convert to device-managed functions
>   iio: adc: ad7192: use devm_clk_get_optional() for mclk
>   iio: adc: ad7192: convert to device-managed functions
>   iio: adc: ad_sigma_delta: remove
>     ad_sd_{setup,cleanup}_buffer_and_trigger()
> 
> Jonathan Cameron (4):
>   iio: adc: ad7124: Fix missbalanced regulator enable / disable on
>     error.
>   iio: adc: ad7124: Fix potential overflow due to non sequential channel
>     numbers
>   iio: adc: ad7192: Avoid disabling a clock that was never enabled.
>   iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop
>     remove()
> 
>  drivers/iio/adc/ad7124.c               | 84 +++++++++-------------
>  drivers/iio/adc/ad7192.c               | 98 +++++++++++---------------
>  drivers/iio/adc/ad7780.c               | 38 +++-------
>  drivers/iio/adc/ad7791.c               | 44 ++++--------
>  drivers/iio/adc/ad7793.c               | 53 ++++----------
>  drivers/iio/adc/ad_sigma_delta.c       | 82 ++++++++-------------
>  include/linux/iio/adc/ad_sigma_delta.h |  4 +-
>  7 files changed, 144 insertions(+), 259 deletions(-)
> 

