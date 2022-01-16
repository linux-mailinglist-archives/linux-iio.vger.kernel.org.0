Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776D748FDED
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jan 2022 17:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiAPQsm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jan 2022 11:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiAPQsl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jan 2022 11:48:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0ABC061574
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 08:48:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE62260F34
        for <linux-iio@vger.kernel.org>; Sun, 16 Jan 2022 16:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B094DC36AE9;
        Sun, 16 Jan 2022 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642351720;
        bh=GmlPsHQ1lj8ZTZHEpkg9DWgFtob/ZV+U4gLalCdgk5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SjTaEiWKNze/KCXTc0fF9ESkUAeVrlk1NvU1UuCvrH8cyu20lWgwnRcnXZge09n5i
         PU+fq+FfZkO7qcNZewSRyGwEBgN4L8dYBGd9K4l9dEyZzh2RbRGaYYMRYALtqOQkiL
         k2DITqKy3yYozF9EiEdNGJ3aBgBuQ3G+/1VUbL/K1jwdP5TV6dcgkJRQRooYKYAah2
         DkArfLXQhYzMLZwkcriqLcI5fGX9AYeoVmu48TavB4Qn21bEmmczWPH8FF9VICQy+A
         V6DxGbEN4GSQ1vgMx5S0nThDKmzwP0hfQhJLqIP7/LsRxEwwpoU9t2fY2S0Xq6rpz0
         19kQ9d49CrrWA==
Date:   Sun, 16 Jan 2022 16:54:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/13] iio: Use sysfs_emit()
Message-ID: <20220116165440.07a3c1de@jic23-huawei>
In-Reply-To: <20211216185217.1054495-1-lars@metafoo.de>
References: <20211216185217.1054495-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Dec 2021 19:52:04 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> I started the sysfs_emit() conversion during the last end-of-year break
> starting with the IIO core. It is end-of-year break again, so here is a bit
> more.
> 
> This series contains conversions for simple users which all follow the
> pattern of `return sprintf(....)` or similar. The series also only covers
> cases where the attributes are completely custom and can not be converted
> to use iio_read_raw or iio_read_available. These other cases will be
> handled seperately by converting them to use the IIO APIs rather than
> device attributes. But this requires a bit more validation work than the
> simple straigh forward conversions.
> 

Applied with tweaks as mentioned in replies to individual patches.

Thanks,

Jonathan

> Lars-Peter Clausen (13):
>   iio: core: Use sysfs_emit()
>   iio: dmaengine-buffer: Use sysfs_emit()
>   iio: ad7192: Use sysfs_emit()
>   iio: ad9523: Use sysfs_emit()
>   iio: as3935: Use sysfs_emit()
>   iio: ina2xx-adc: sysfs_emit()
>   iio: lm3533: Use sysfs_emit()
>   iio: max31856: Use sysfs_emit()
>   iio: max31865: Use sysfs_emit()
>   iio: max9611: Use sysfs_emit()
>   iio: ms_sensors: Use sysfs_emit()
>   iio: scd4x: Use sysfs_emit()
>   iio: sps30: Use sysfs_emit()
> 
>  drivers/iio/adc/ad7192.c                           | 4 ++--
>  drivers/iio/adc/ina2xx-adc.c                       | 2 +-
>  drivers/iio/adc/max9611.c                          | 2 +-
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 +-
>  drivers/iio/chemical/scd4x.c                       | 2 +-
>  drivers/iio/chemical/sps30.c                       | 2 +-
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c     | 4 ++--
>  drivers/iio/frequency/ad9523.c                     | 2 +-
>  drivers/iio/industrialio-buffer.c                  | 4 ++--
>  drivers/iio/industrialio-core.c                    | 2 +-
>  drivers/iio/light/lm3533-als.c                     | 6 +++---
>  drivers/iio/proximity/as3935.c                     | 4 ++--
>  drivers/iio/temperature/max31856.c                 | 4 ++--
>  drivers/iio/temperature/max31865.c                 | 4 ++--
>  14 files changed, 22 insertions(+), 22 deletions(-)
> 

