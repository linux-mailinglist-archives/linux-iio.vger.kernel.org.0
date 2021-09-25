Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AEC4182DE
	for <lists+linux-iio@lfdr.de>; Sat, 25 Sep 2021 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbhIYOwd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Sep 2021 10:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234173AbhIYOwd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Sep 2021 10:52:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4030610CF;
        Sat, 25 Sep 2021 14:50:56 +0000 (UTC)
Date:   Sat, 25 Sep 2021 15:54:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/9] iio: common: cros_ec_sensors: simplify getting
 .driver_data
Message-ID: <20210925155445.1edf4752@jic23-huawei>
In-Reply-To: <716533b5-380d-be72-b45e-d9909f09286b@collabora.com>
References: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
        <20210920090522.23784-7-wsa+renesas@sang-engineering.com>
        <716533b5-380d-be72-b45e-d9909f09286b@collabora.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 23 Sep 2021 11:16:47 +0200
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> Hi Wolfram,
> 
> On 20/9/21 11:05, Wolfram Sang wrote:
> > We should get 'driver_data' from 'struct device' directly. Going via
> > platform_device is an unneeded step back and forth.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>  
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> I'm fine to pick this patch through chrome-platform tree if Jonathan is fine, or
> can go through his tree.

Fine by me, though a suggestion follows to take this a little further than done here.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

It's not something that ever bothered me that much, but we have had debates in
the past about whether there are semantic issues around this sort of cleanup
as it mixes

platform_set_drvdata() with device_get_drvdata()

Whilst they access the same pointer today, in theory that isn't necessarily
always going to be the case in future and it isn't necessarily apparent
to the casual reader of the code.

In this particular case you could tidy that up by using device_set_drvdata() in
the first place, but then to keep things consistent there is one other place
where platform_get_drvdata is used in a devm_add_action_or_reset() callback.
That one is also easily fixed though if we want to be consistent throughout.

Jonathan

> 
> I plan also to pick patch  "[PATCH 8/9] platform: chrome: cros_ec_sensorhub:
> simplify getting .driver_data"
> 
> Thanks,
>   Enric
> 
> > ---
> > 
> > Build tested only. buildbot is happy.
> > 
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 28bde13003b7..b2725c6adc7f 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -831,8 +831,7 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
> >  
> >  static int __maybe_unused cros_ec_sensors_resume(struct device *dev)
> >  {
> > -	struct platform_device *pdev = to_platform_device(dev);
> > -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> >  	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> >  	int ret = 0;
> >  
> >   

