Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FED342D5C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 15:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCTOfJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 10:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhCTOer (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Mar 2021 10:34:47 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C033661960;
        Sat, 20 Mar 2021 14:34:44 +0000 (UTC)
Date:   Sat, 20 Mar 2021 14:34:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] iio:cros_ec_sensors: Fix a wrong function name in
 kernel doc.
Message-ID: <20210320143441.4da84139@jic23-huawei>
In-Reply-To: <e0d1caa8-785b-6789-3f8c-08ae5eafca4b@collabora.com>
References: <20210313145341.116088-1-jic23@kernel.org>
        <e0d1caa8-785b-6789-3f8c-08ae5eafca4b@collabora.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Mar 2021 11:35:44 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi Jonathan,
> 
> Thank you for fix this.
> 
> On 13/3/21 15:53, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > cros_ec_sensors_read_data_unsafe() had wrong function name in kernel-doc
> > This shows up with W=1 builds.
> > 
> > No fixes tag because I don't want to waste time on this being
> > backported.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index f8824afe595e..ed9dd0ad5c03 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -559,7 +559,7 @@ static int cros_ec_sensors_read_until_not_busy(
> >  }
> >  
> >  /**
> > - * read_ec_sensors_data_unsafe() - read acceleration data from EC shared memory
> > + * cros_ec_sensors_read_data_unsafe() - read acc data from EC shared memory  
> 
> 
> nit: Wouldn't be better to maintain the word 'acceleration' instead of replacing
> for 'acc'. It is less than 100 characters in total so should be fine.

I've put it back whilst applying.

> 
> In any case:
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied. Thanks,

Jonathan

> 
> >   * @indio_dev:	pointer to IIO device
> >   * @scan_mask:	bitmap of the sensor indices to scan
> >   * @data:	location to store data
> >   

