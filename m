Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29F4E0241
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 12:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfJVKmv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 06:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfJVKmu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 06:42:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8AF20B7C;
        Tue, 22 Oct 2019 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571740969;
        bh=ZB9rkiPisn/IuTUY/IajVYEn36xXAxtTFPGll20+in0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OdV5Vo1PSD3rGRuhst7NVuiD22RPXWZYfAgluI/6TQ0nSv5YtjsfwEHFyILMgH03H
         5e3zfmIUDIBMDD/F18zEZh7DnTsv7tUba/HMK2DwWKXI4kh4ujHtrdtvg706auEyar
         7CB1lrPekMzC5pIC7hV7/63Cxjb9hlcKcNvCKI0g=
Date:   Tue, 22 Oct 2019 11:42:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 10/18] platform: chrome: sensorhub: Add FIFO support
Message-ID: <20191022114243.1eaf19c1@archlinux>
In-Reply-To: <CAPUE2uuaFQYXKhn+b6tW6tXWQECeix3pt3+KnMbyXgvx-Qoa1Q@mail.gmail.com>
References: <20191021055403.67849-1-gwendal@chromium.org>
        <20191021055403.67849-11-gwendal@chromium.org>
        <20191021172727.0fa9918e@archlinux>
        <CAPUE2uuaFQYXKhn+b6tW6tXWQECeix3pt3+KnMbyXgvx-Qoa1Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...
> > > + * @sensor_hub : Sensor Hub object
> > > + */
> > > +int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
> > > +{
> > > +     struct cros_ec_dev *ec = sensorhub->ec;
> > > +     int ret;
> > > +
> > > +     /* Retrieve FIFO information */
> > > +     sensorhub->msg->version = 2;
> > > +     sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
> > > +     sensorhub->msg->outsize = 1;
> > > +     sensorhub->msg->insize =
> > > +             sizeof(struct ec_response_motion_sense_fifo_info) +
> > > +             sizeof(u16) * CROS_EC_SENSOR_MAX;
> > > +
> > > +     ret = cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     /*
> > > +      * Allocate the full fifo.
> > > +      * We need to copy the whole FIFO to set timestamps properly *
> > > +      */
> > > +     sensorhub->fifo_size = sensorhub->resp->fifo_info.size;
> > > +     sensorhub->ring = devm_kcalloc(sensorhub->dev, sensorhub->fifo_size,
> > > +                     sizeof(*sensorhub->ring), GFP_KERNEL);
> > > +     if (!sensorhub->ring)
> > > +             return -ENOMEM;
> > > +
> > > +     sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] =
> > > +             cros_ec_get_time_ns();  
> >
> > Hmm. Is the IIO standard timestamp selection attribute being exposed?
> > If so this is going to be confusing as we aren't obeying the selection
> > of clock from that..  
> 
> You're right, I did not find an elegant solution.
> cros_ec_get_time_ns() is an inline version of ktime_get_boottime_ns
> aka iio_get_time_ns( with indio_dev->clock_id set to  CLOCK_BOOTTIME).
> But I can not call iio_get_time_ns() here, as I don't have a
> indio_dev. Besides, sensors could have a different
> current_timestamp_clock attribute. I will convert in the callback
> routine (cros_ec_sensors_push_data() by adding an offset
> (iio_get_time_ns(indio_dev) - cros_ec_get_time_ns())
> >  

If you can special case that (perhaps adding some functionality to IIO)
to not do anything if both are CLOCK_BOOTTIME that would be great.

Thanks,

Jonathan

