Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48C025692B
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 18:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgH2QvJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 12:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgH2QvI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 12:51:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFAC420791;
        Sat, 29 Aug 2020 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598719868;
        bh=+4y/zm7LOZ5NDYCgf6voOuYKjfVaIocA+7p7h19uZnk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gm/PrC51rewIoHxwXQHWLdHyJmVEf1wm0AGQbgH6kniR8iJAiAO+B0kCQBND5oCij
         GzvtD+zuCx4fRnGHbG27O9YsuDag8ZdcN3j2Ry7p8sJsohpv7dImPfdbgLbR5QLUrK
         X3E9s7Rvf7G7U2SwqeBqlrBfjCIpO2pafF7eV98I=
Date:   Sat, 29 Aug 2020 17:51:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     robh+dt@kernel.org, dragos.bogdan@analog.com,
        darius.berghe@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: gyro: adxrs290: Add debugfs register access
 support
Message-ID: <20200829175104.62142a31@archlinux>
In-Reply-To: <20200825124711.11455-4-nish.malpani25@gmail.com>
References: <20200825124711.11455-1-nish.malpani25@gmail.com>
        <20200825124711.11455-4-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Aug 2020 18:17:11 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Extend support to read/write byte data from/to the device using
> debugfs iio interface.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
Hi Nishant,

I'm always a bit unsure on whether I want drivers to provide this
interface, as it isn't something that should be of much use once
initial driver debugging is done.

However, the patch is good so if you want to add it fair enough.
I'll pick it up once patches 1 and 2 are ready.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/adxrs290.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> index 25046590761e..b0050cdd2b90 100644
> --- a/drivers/iio/gyro/adxrs290.c
> +++ b/drivers/iio/gyro/adxrs290.c
> @@ -435,6 +435,24 @@ static int adxrs290_read_avail(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int adxrs290_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			       unsigned int writeval, unsigned int *readval)
> +{
> +	struct adxrs290_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!readval)
> +		return adxrs290_spi_write_reg(st->spi, reg, writeval);
> +
> +	ret = spi_w8r8(st->spi, ADXRS290_READ_REG(reg));
> +	if (ret < 0)
> +		return ret;
> +
> +	*readval = ret;
> +
> +	return 0;
> +}
> +
>  static int adxrs290_data_rdy_trigger_set_state(struct iio_trigger *trig, bool state)
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> @@ -547,6 +565,7 @@ static const struct iio_info adxrs290_info = {
>  	.read_raw = &adxrs290_read_raw,
>  	.write_raw = &adxrs290_write_raw,
>  	.read_avail = &adxrs290_read_avail,
> +	.debugfs_reg_access = &adxrs290_reg_access,
>  };
>  
>  static int adxrs290_probe_trigger(struct iio_dev *indio_dev)

