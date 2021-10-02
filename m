Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F72C41FD00
	for <lists+linux-iio@lfdr.de>; Sat,  2 Oct 2021 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbhJBQON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Oct 2021 12:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233451AbhJBQON (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Oct 2021 12:14:13 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E880B61A03;
        Sat,  2 Oct 2021 16:12:24 +0000 (UTC)
Date:   Sat, 2 Oct 2021 17:16:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 3/4] drivers: iio: chemical: Add support for
 Sensirion SCD4x CO2 sensor
Message-ID: <20211002171622.0f5d34d7@jic23-huawei>
In-Reply-To: <20211001070254.3940795-4-roan@protonic.nl>
References: <20211001070254.3940795-1-roan@protonic.nl>
        <20211001070254.3940795-4-roan@protonic.nl>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  1 Oct 2021 09:02:53 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> This is a driver for the SCD4x CO2 sensor from Sensirion. The sensor is
> able to measure CO2 concentration, temperature and relative humdity.
> The sensor uses a photoacoustic principle for measuring CO2 concentration.
> An I2C interface is supported by this driver in order to communicate with
> the sensor.
> 
> Signed-off-by: Roan van Dijk <roan@protonic.nl>
Hi Roan,

Looks like you sent out wrong version or similar as the trigger_handler
won't work as you have it here.  Otherwise looks good to me.

...

> +static irqreturn_t scd4x_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct scd4x_state *state = iio_priv(indio_dev);
> +	struct {
> +		uint16_t data[3];
> +		int64_t ts __aligned(8);
> +	} scan;
> +	int ret;
> +	uint16_t buf[3];
> +
> +	memset(&scan, 0, sizeof(scan));
> +	mutex_lock(&state->lock);
> +	ret = scd4x_read_poll(state, buf);

scan->data and drop the local variable buf as unused.

If I've interpreted the intent right here I'm happy to make this tweak
whilst applying.  If you prefer to send a v5 with it fixed up that is
fine as well.


> +	mutex_unlock(&state->lock);
> +	if (ret)
> +		goto out;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
...
