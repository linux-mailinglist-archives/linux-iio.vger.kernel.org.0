Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F206401004
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 15:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhIENhR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 5 Sep 2021 09:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhIENhQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 09:37:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25A2C600CC;
        Sun,  5 Sep 2021 13:36:10 +0000 (UTC)
Date:   Sun, 5 Sep 2021 14:39:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH 0/5] Fixes and improvements to the ADIS lib/devices
Message-ID: <20210905143933.4f492b78@jic23-huawei>
In-Reply-To: <20210903141423.517028-1-nuno.sa@analog.com>
References: <20210903141423.517028-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Sep 2021 16:14:18 +0200
Nuno Sá <nuno.sa@analog.com> wrote:

> This series adds some fixes and improvements for the ADIS library and
> devices. There are two fixes:
>  
> 1) On the library 'adis_init()' function, a call to 'adis_enable_irq()'
> was being done. That does not make sense because
> '__adis_initial_startup()' will reset the device and put the data ready
> pin in the default state. For some drivers, these could mean that we
> were leaving probe in a state different from the desired one.
> 2) The adis16480 driver was registering a managed reset action to put
> the device into sleep mode in the unbinding path. Well, not all devices
> supported by the driver support sleep mode.
>  
> The rest of the series is a minor improvement about passing the handling of
> enabling/disabling IRQs (for devices that cannot unmask the data ready
> pin) inside the library.
> 
> Nuno Sá (5):
>   iio: adis: do not disabe IRQs in 'adis_init()'
>   iio: adis: handle devices that cannot unmask the drdy pin
>   iio: adis16475: make use of the new unmasked_drdy flag
>   iio: adis16460: make use of the new unmasked_drdy flag
>   iio: adis16480: fix devices that do not support sleep mode

Hi Nuno.

Series looks good to me but I'd like it to sit on list a little longer before
I take any of it.

Would have been 'nice' to have had the two fixes at the start of the series
as they should probably go via stable whereas the 3 patches moving things
into the core are 5.16 material.

Looks like I should be fine picking two fixes up even in this order though so
not a big issue.

Thanks,

Jonathan

> 
>  drivers/iio/imu/adis.c         | 17 ++++++++++++++++-
>  drivers/iio/imu/adis16460.c    | 18 +-----------------
>  drivers/iio/imu/adis16475.c    | 19 +------------------
>  drivers/iio/imu/adis16480.c    | 14 +++++++++++---
>  drivers/iio/imu/adis_trigger.c |  4 ++++
>  include/linux/iio/imu/adis.h   |  2 ++
>  6 files changed, 35 insertions(+), 39 deletions(-)
> 

