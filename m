Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B8837FD0B
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhEMSD3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 14:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231447AbhEMSD3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 14:03:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC4F461438;
        Thu, 13 May 2021 18:02:18 +0000 (UTC)
Date:   Thu, 13 May 2021 19:03:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/11] iio: cros_ec_sensors: Fix alignment of buffer in
 iio_push_to_buffers_with_timestamp()
Message-ID: <20210513190327.7ccdbbcc@jic23-huawei>
In-Reply-To: <CAPUE2uv7dX8kArmA76bLQ0DQmd=F_Obsv54KZGVcbFfC-aRC1g@mail.gmail.com>
References: <20210501171352.512953-1-jic23@kernel.org>
        <20210501171352.512953-7-jic23@kernel.org>
        <CAPUE2uv7dX8kArmA76bLQ0DQmd=F_Obsv54KZGVcbFfC-aRC1g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 1 May 2021 16:58:21 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Fixes tag is correct up to kernel stable 4.18.
> Before, the include file to fix is
> drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h:
> commit 974e6f02e27 ("iio: cros_ec_sensors_core: Add common functions
> for the ChromeOS EC Sensor Hub.") present since kernel stable 4.10.
> 
Applied with this extra info to the togreg branch of iio.git and pushed
out as testing for the autobuilders to poke at it.

This series (in it's complete form) is large enough that I'm not comfortable
rushing it in.  The bug is also rarely seen in practice so this can wait
for the next merge window.

Thanks,

Jonathan

> Reviewed-by: Gwendal Grignou <gwendal@chromium.org
> 
> On Sat, May 1, 2021 at 10:15 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The samples buffer is passed to iio_push_to_buffers_with_timestamp()
> > which requires a buffer aligned to 8 bytes as it is assumed that
> > the timestamp will be naturally aligned if present.
> >
> > Fixes tag is inaccurate but prior to that likely manual backporting needed.
> >
> > Fixes: 5a0b8cb46624c ("iio: cros_ec: Move cros_ec_sensors_core.h in /include")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  include/linux/iio/common/cros_ec_sensors_core.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> > index 7ce8a8adad58..c582e1a14232 100644
> > --- a/include/linux/iio/common/cros_ec_sensors_core.h
> > +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> > @@ -77,7 +77,7 @@ struct cros_ec_sensors_core_state {
> >                 u16 scale;
> >         } calib[CROS_EC_SENSOR_MAX_AXIS];
> >         s8 sign[CROS_EC_SENSOR_MAX_AXIS];
> > -       u8 samples[CROS_EC_SAMPLE_SIZE];
> > +       u8 samples[CROS_EC_SAMPLE_SIZE] __aligned(8);
> >
> >         int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
> >                                     unsigned long scan_mask, s16 *data);
> > --
> > 2.31.1
> >  

