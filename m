Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19864189EA
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhIZPSV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 11:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232081AbhIZPSP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 11:18:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB74B60F21;
        Sun, 26 Sep 2021 15:16:37 +0000 (UTC)
Date:   Sun, 26 Sep 2021 16:20:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, hdegoede@redhat.com, wens@csie.org,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH 0/5] iio: device-managed conversions with
 devm_iio_map_array_register()
Message-ID: <20210926162026.3447e0bd@jic23-huawei>
In-Reply-To: <20210903072917.45769-1-aardelean@deviqon.com>
References: <20210903072917.45769-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Sep 2021 10:29:12 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> This change introduces a devm_iio_map_array_register() variant for the
> iio_map_array_register() function.
> 
> And converts 4 drivers to full device-managed.
> These 4 drivers only call iio_map_array_unregister() and
> iio_device_unregister() in their remove hooks.
> 
> These 4 drivers should make a reasonably good case for introducing this
> devm_iio_map_array_register() function.
> 
> There are 7 more drivers that would use the devm_iio_map_array_register()
> function, but they require a bit more handling in the remove/unwinding
> part.
> So, those 7 are left for later.

Series applied to the togreg branch of iio.git and pushed out as testing
so 0-day can work it's magic.

Thanks,

Jonathan

> 
> Alexandru Ardelean (5):
>   iio: inkern: introduce devm_iio_map_array_register() short-hand
>     function
>   iio: adc: intel_mrfld_adc: convert probe to full device-managed
>   iio: adc: axp288_adc: convert probe to full device-managed
>   iio: adc: lp8788_adc: convert probe to full-device managed
>   iio: adc: da9150-gpadc: convert probe to full-device managed
> 
>  .../driver-api/driver-model/devres.rst        |  1 +
>  drivers/iio/adc/axp288_adc.c                  | 28 +++--------------
>  drivers/iio/adc/da9150-gpadc.c                | 27 ++--------------
>  drivers/iio/adc/intel_mrfld_adc.c             | 24 ++------------
>  drivers/iio/adc/lp8788_adc.c                  | 31 +++----------------
>  drivers/iio/inkern.c                          | 17 ++++++++++
>  include/linux/iio/driver.h                    | 14 +++++++++
>  7 files changed, 45 insertions(+), 97 deletions(-)
> 

