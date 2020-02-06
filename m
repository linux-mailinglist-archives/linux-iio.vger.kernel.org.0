Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CCA15415D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 10:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgBFJsA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 04:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgBFJsA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 04:48:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1665A214AF;
        Thu,  6 Feb 2020 09:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580982479;
        bh=xef0NCCx1xDO991dmmH0lH5zawrBefpc+/7wIhEa6sE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sT1Mrad9YkKc7DYosnsyDiIIcC1z7twiQ/TdNNfXC1ON5BNkEPGhMS0pPO/v2dbkw
         H9CfF/3Ly7E5A0YKZWy9JqwOeFfYjdjd7BFPL+++3SHbaaU1l0/A0oDAUTjal3TQ6Z
         IRytbgIXcWypFlL909QW+R3PlD4bZEndMMs5OHG8=
Date:   Thu, 6 Feb 2020 09:47:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5 V2] iio: adc: ad7192: move out of staging
Message-ID: <20200206094756.52fe8bc0@archlinux>
In-Reply-To: <20200205171511.25912-1-alexandru.tachici@analog.com>
References: <20200202162215.50915c83@archlinux>
        <20200205171511.25912-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Feb 2020 19:15:06 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This series of patches aim to move the ad7192 ADC from staging
> into mainline.
> 
> 1. Makes probe fail in case get_voltage returns an error.
> 
> 2. Changed the iio_chan_spec talbes in order to set the required
> attributes at compile time.

tables

> 
> 3. Removed spi_device_id table and moved ID_* in of_Device_id table.
> 
> 4. Updates inline sysfs docs.
> 
> 5. Full-diff patch to move the ad7192 out of staging.

Couple of process things.  Seems you have this thread with an
in reply to set to a different thread.

1) Obviously helps if it's the right thread ;)
2) Don't do it anyway.   Threads get very deep if we take a few versions
   for a driver so much better to just rely on naming and start a new
   thread for each version.

Jonathan

> 
> Alexandru Tachici (5):
>   staging: iio: adc: ad7192: fail probe on get_voltage
>   staging: iio: adc: ad7192: modify iio_chan_spec array
>   staging: iio: adc: ad7192: removed spi_device_id
>   Documentation: ABI: testing: ad7192: update sysfs docs
>   staging: iio: adc: ad7192: move out of staging
> 
>  .../ABI/testing/sysfs-bus-iio-adc-ad7192      |   17 +-
>  MAINTAINERS                                   |    8 +
>  drivers/iio/adc/Kconfig                       |   12 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ad7192.c                      | 1043 +++++++++++++++++
>  .../iio/Documentation/sysfs-bus-iio-ad7192    |   20 -
>  drivers/staging/iio/adc/Kconfig               |   12 -
>  drivers/staging/iio/adc/Makefile              |    1 -
>  drivers/staging/iio/adc/ad7192.c              | 1022 ----------------
>  9 files changed, 1075 insertions(+), 1061 deletions(-)
>  create mode 100644 drivers/iio/adc/ad7192.c
>  delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
>  delete mode 100644 drivers/staging/iio/adc/ad7192.c
> 

