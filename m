Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40AE185C6D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 13:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgCOMnc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 08:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgCOMnc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 08:43:32 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E048320674;
        Sun, 15 Mar 2020 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584276210;
        bh=zr410OOjHFRl71q5vo5SEfn/1a90BFr6ScTQ3HEl7qk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NvJtxzUd7WwxZK2iBC+T3Bzjzpou0Nwk8K6NYvpBu/YOZ9f4s7+YAvGi8aijDnW6d
         28VpKNCXYBbHach0o0PjZ5c8pRSrlyYNH+JUhdAJE077OAXjwbRPTH2AqLG5cz+qK7
         ckxOjSESZTWt1Puusy8L1r5qFJTOFvgZUHtm6idQ=
Date:   Sun, 15 Mar 2020 12:43:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 7/8] iio: humidity: hts221: Make use of device
 properties
Message-ID: <20200315124327.56e31b1c@archlinux>
In-Reply-To: <20200313104955.30423-7-andriy.shevchenko@linux.intel.com>
References: <20200313104955.30423-1-andriy.shevchenko@linux.intel.com>
        <20200313104955.30423-7-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Mar 2020 12:49:54 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Device property API allows to gather device resources from different sources,
> such as ACPI. Convert the drivers to unleash the power of device property API.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

Jonathan

> ---
> v2: new patch
>  drivers/iio/humidity/hts221_buffer.c | 3 +--
>  drivers/iio/humidity/hts221_i2c.c    | 2 +-
>  drivers/iio/humidity/hts221_spi.c    | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index 5f142a44c1dd..9fb3f33614d4 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -77,7 +77,6 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
>  	struct st_sensors_platform_data *pdata = dev_get_platdata(hw->dev);
>  	struct iio_dev *iio_dev = iio_priv_to_dev(hw);
>  	bool irq_active_low = false, open_drain = false;
> -	struct device_node *np = hw->dev->of_node;
>  	unsigned long irq_type;
>  	int err;
>  
> @@ -106,7 +105,7 @@ int hts221_allocate_trigger(struct hts221_hw *hw)
>  	if (err < 0)
>  		return err;
>  
> -	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
> +	if (device_property_read_bool(hw->dev, "drive-open-drain") ||
>  	    (pdata && pdata->open_drain)) {
>  		irq_type |= IRQF_SHARED;
>  		open_drain = true;
> diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
> index 4272b7030c44..1398794e4bc7 100644
> --- a/drivers/iio/humidity/hts221_i2c.c
> +++ b/drivers/iio/humidity/hts221_i2c.c
> @@ -63,7 +63,7 @@ static struct i2c_driver hts221_driver = {
>  	.driver = {
>  		.name = "hts221_i2c",
>  		.pm = &hts221_pm_ops,
> -		.of_match_table = of_match_ptr(hts221_i2c_of_match),
> +		.of_match_table = hts221_i2c_of_match,
>  		.acpi_match_table = ACPI_PTR(hts221_acpi_match),
>  	},
>  	.probe = hts221_i2c_probe,
> diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
> index 055dba8897d2..ba1115489c2c 100644
> --- a/drivers/iio/humidity/hts221_spi.c
> +++ b/drivers/iio/humidity/hts221_spi.c
> @@ -56,7 +56,7 @@ static struct spi_driver hts221_driver = {
>  	.driver = {
>  		.name = "hts221_spi",
>  		.pm = &hts221_pm_ops,
> -		.of_match_table = of_match_ptr(hts221_spi_of_match),
> +		.of_match_table = hts221_spi_of_match,
>  	},
>  	.probe = hts221_spi_probe,
>  	.id_table = hts221_spi_id_table,

