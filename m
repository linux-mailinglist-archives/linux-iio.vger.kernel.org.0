Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0FAB22759
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfESQ5W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 12:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfESQ5W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 12:57:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C32E521743;
        Sun, 19 May 2019 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558263634;
        bh=N2AfJUm5S/n9kNq0ukcJ2NfhgtOc6Fh2mApK13sY1b0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SfbqQ7URvAiUBaaGq9YorAgNZZLsiTxuY5c9iLHuYslS1D7htpDvUt3W57XB0XUoH
         0zjJ5/Zn7wODiPbFk+6Y6AZPCjsSKyhLMq0tDxtQQqeAEL7ooS1e4Q1o+OeXJ63eH3
         dODoRh9i8LZw9gAe42T6vDok5ihEq3zYXmkwhELo=
Date:   Sun, 19 May 2019 12:00:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Subject: Re: [PATCH v2] staging: iio: adis16240: add device to module device
 table
Message-ID: <20190519120029.1da8f41c@archlinux>
In-Reply-To: <20190518214434.23660-1-lucasseikioshiro@gmail.com>
References: <20190518214434.23660-1-lucasseikioshiro@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 May 2019 18:44:34 -0300
Lucas Oshiro <lucasseikioshiro@gmail.com> wrote:

> Add a of_device_id struct and MODULE_DEVICE_TABLE call, in order to add
> device-tree support for this driver.
> 
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
> Co-developed-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>

Hi Lucas, Rodrigo,

The description isn't 100% accurate but it's close enough.
Ever since devicetree was introduced, there has been a fallback mode for
i2c and spi devices in which, in the absence of either a devicetree match table
or an ACPI one, an attempt is made to match against the older i2c_device_id
table entries.

So it'll 'work' for devicetree bindings without this patch, but by a less
controlled route and one that doesn't allow for the possibility of
multiple manufacturers using the same part number.

Hence these are good changes to make.  Simplifying the description to enabling
devicetree probing is fine though.

Under drivers/spi.c, devices probed via a device tree binding use:
of_register_spi_device (applied to all children of an spi bus, so the slave
devices).  This calls of_modalias_node which performs a copy of the
compatible without the manufacturer ID into the modalias field.
Later, spi_match_device is called, which first attempts
of_driver_match_device which I think does the precise match.

If that fails, it tries ACPI, and failing that it falls back to matching
the modalias against the id_table entries.   Thus it can still
work without these entries but they do make it simpler and more consistent.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan


> ---
>  drivers/staging/iio/accel/adis16240.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index b80e0d248b0f..8c6d23604eca 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -435,6 +435,12 @@ static int adis16240_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id adis16240_of_match[] = {
> +	{ .compatible = "adi,adis16240" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, adis16240_of_match);
> +
>  static struct spi_driver adis16240_driver = {
>  	.driver = {
>  		.name = "adis16240",

