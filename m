Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7F5301665
	for <lists+linux-iio@lfdr.de>; Sat, 23 Jan 2021 16:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbhAWPf5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Jan 2021 10:35:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbhAWPf5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Jan 2021 10:35:57 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5EF23331;
        Sat, 23 Jan 2021 15:35:15 +0000 (UTC)
Date:   Sat, 23 Jan 2021 15:35:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dan Robertson <dan@dlrobertson.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
Message-ID: <20210123153511.1802a15a@archlinux>
In-Reply-To: <CACRpkdbFgskpPUoVK7bU1EyChEvD4e9WHhvcUJh4e1UUO2WFdA@mail.gmail.com>
References: <20210119124622.9490-1-mike.looijmans@topic.nl>
        <20210119124622.9490-2-mike.looijmans@topic.nl>
        <CACRpkdbFgskpPUoVK7bU1EyChEvD4e9WHhvcUJh4e1UUO2WFdA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Jan 2021 23:38:48 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> Hi Mike,
> 
> thanks for your patch!
> 
> I have a comment about PM:
> 
> On Tue, Jan 19, 2021 at 1:46 PM Mike Looijmans <mike.looijmans@topic.nl> wrote:
> 
> > The BMI088 is a combined module with both accelerometer and gyroscope.
> > This adds the accelerometer driver support for the SPI interface.
> > The gyroscope part is already supported by the BMG160 driver.
> >
> > Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>  
> (...)
> 
> > +static int bmi088_accel_set_power_state_on(struct bmi088_accel_data *data)
> > +{
> > +       struct device *dev = regmap_get_device(data->regmap);
> > +       int ret;
> > +
> > +       ret = pm_runtime_get_sync(dev);
> > +       if (ret < 0) {
> > +               pm_runtime_put_noidle(dev);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int bmi088_accel_set_power_state_off(struct bmi088_accel_data *data)
> > +{
> > +       struct device *dev = regmap_get_device(data->regmap);
> > +       int ret;
> > +
> > +       pm_runtime_mark_last_busy(dev);
> > +       ret = pm_runtime_put_autosuspend(dev);
> > +
> > +       return ret < 0 ? ret : 0;
> > +}  
> 
> I'm not sure you should wrap the pm_runtime calls like this.
> I think it is better to inline them.
> 
> Next, I think it is better to let suspend/resume, i.e. system PM
> reuse runtime PM since you're implementing that. This is why
> we invented PM runtime force resume and force suspend.

Here the driver is turning more off for full suspend than in the
runtime path.  If that results in significant extra delay then
it's not appropriate to have that in the runtime suspend path.

Maybe the simplification of not doing the deeper power saving
mode is worth the extra power cost or extra delay, but
I'm not yet convinced.

I'll hold off on applying v7 though whilst we discuss this.

J

> 
> Here are some drivers that I implemented using that model:
> drivers/iio/gyro/mpu3050-core.c
> drivers/iio/accel/kxsd9.c
> drivers/iio/magnetometer/ak8974.c
> 
> The short summary is:
> - Only implement runtime suspend/resume.
> - SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>    pm_runtime_force_resume)
> - In probe() enable runtime PM with autosuspend:
>   pm_runtime_get_noresume(dev);
>   pm_runtime_set_active(dev);
>   pm_runtime_enable(dev);
>   pm_runtime_set_autosuspend_delay(dev, NNNN);
>   pm_runtime_use_autosuspend(dev);
>   pm_runtime_put(dev);
> - In remove() disable it like this:
>   pm_runtime_get_sync(dev);
>   pm_runtime_put_noidle(dev);
>   pm_runtime_disable(dev);
> - Any time the driver needs the hardware, call:
>   pm_runtime_get_sync(dev);
> - As soon as you're done using the hardware call:
>   pm_runtime_mark_last_busy(dev);
>   pm_runtime_put_autosuspend(dev);
> 
> The system PM will just hook into the same callbacks and suspend
> the hardware using the existing runtime PM hooks.
> 
> This works fine in my drivers and saves some complexity and avoids
> bugs.
> 
> Yours,
> Linus Walleij

