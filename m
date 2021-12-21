Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E2047C027
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 13:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhLUMys (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Dec 2021 07:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbhLUMys (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Dec 2021 07:54:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838F8C061574
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 04:54:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D57B6020F
        for <linux-iio@vger.kernel.org>; Tue, 21 Dec 2021 12:54:48 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 763DCC36AE2;
        Tue, 21 Dec 2021 12:54:45 +0000 (UTC)
Date:   Tue, 21 Dec 2021 13:00:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: proximity: Add sx9360 support
Message-ID: <20211221130019.36b12ac2@jic23-huawei>
In-Reply-To: <20211218002705.3099096-2-gwendal@chromium.org>
References: <20211218002705.3099096-1-gwendal@chromium.org>
        <20211218002705.3099096-2-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Dec 2021 16:27:03 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> A simplified version of SX9324, it only have one pin and
> 2 phases (aka channels).
> Only one event is presented.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes since v3:
> - Remove "reference" as a new modifier: it is not needed, indexed
>   channels and labels are used instead.
> - Use dev_get_drvdata to access iio device structure.
> - Use already calculated local variable
> - Use default: clause to return when possible.
> 
> Changes since v2:
> - Fix issues reported during sx9324 driver review:
>   - fix include with iwyu
>   - Remove call to ACPI_PTR to prevent unused variable warning.
> - Fix panic when setting frequency to 0.
> - Add offset to decipher interrupt register
> - Fix default register value.
> 
> Changes since v1:
> - Remove SX9360_DRIVER_NAME
> - Simplify whoami function
> - Define WHOAMI register value internally.
> - Handle negative values when setting sysfs parameters.
> 
>  drivers/iio/proximity/Kconfig  |  14 +
>  drivers/iio/proximity/Makefile |   1 +
>  drivers/iio/proximity/sx9360.c | 816 +++++++++++++++++++++++++++++++++
>  3 files changed, 831 insertions(+)
>  create mode 100644 drivers/iio/proximity/sx9360.c
> 
Hi Gwendal,

A few trivial things that I'd just have tidied up whilst applying except
that this is dependent on the earlier series anyway so I can't apply yet.

> +
> +/*
> + * Each entry contains the integer part (val) and the fractional part, in micro
> + * seconds. It conforms to the IIO output IIO_VAL_INT_PLUS_MICRO.
> + *
> + * The frequency control register holds the period, with a ~2ms increment.
> + * Therefore the smallest frequency is 4MHz / (2047 * 8192),
> + * The fastest is 4MHz / 8192.
> + * The interval is not linear, but given there is 2047 possible value,
> + * Returns the fake increment of (Max-Min)/2047
> + *

Trivial, but this blank line doesn't add anything so please remove.

> + */
> +static const struct {
> +	int val;
> +	int val2;
> +} sx9360_samp_freq_interval[] = {
> +	{0, 281250},  /* 4MHz / (8192 * 2047) */
> +	{0, 281250},
> +	{448, 281250},  /* 4MHz / 8192 */
> +};
> +
...


> +static int sx9360_read_label(struct iio_dev *iio_dev, const struct iio_chan_spec *chan,
> +			     char *label)
> +{
> +	return snprintf(label, PAGE_SIZE, "%s\n", sx9360_channel_labels[chan->channel]);

Trivial but preference for sysfs_emit()
(Andy noted this for the other driver in a more complex case so I did a quick
search for repeats)

> +}
> +


...

> +
> +static const struct dev_pm_ops sx9360_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sx9360_suspend, sx9360_resume)
> +};

static SIMPLE_DEV_PM_OPS(sx9360_pm_ops, sx9360_suspend, sx9360_resume);


