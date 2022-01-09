Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CD84888C7
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jan 2022 11:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiAIKyK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jan 2022 05:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiAIKyK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2022 05:54:10 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CA7C06173F
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 02:54:09 -0800 (PST)
Received: from [81.101.6.87] (port=35364 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6Vpr-00058z-Qg; Sun, 09 Jan 2022 10:54:08 +0000
Date:   Sun, 9 Jan 2022 11:00:00 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v6 1/3] iio: proximity: Add sx9360 support
Message-ID: <20220109110000.56f66c3c@jic23-huawei>
In-Reply-To: <20220101203800.290387-2-gwendal@chromium.org>
References: <20220101203800.290387-1-gwendal@chromium.org>
        <20220101203800.290387-2-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  1 Jan 2022 12:37:58 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> A simplified version of SX9324, it only have one pin and
> 2 phases (aka channels).
> Only one event is presented.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
Series applied but I got a build warning which lead me to take another look
at he below code.

...

> +static int sx9360_set_samp_freq(struct sx_common_data *data,
> +				int val, int val2)
> +{
> +	int ret, reg;
> +	__be16 buf;
> +
> +	reg = val * 8192 / SX9360_FOSC_HZ + val2 * 8192 / (SX9360_FOSC_MHZ);
> +	buf = cpu_to_be16(val);
I've changed this to cpu_to_be16(reg) which I'm assuming was the intent.

> +	mutex_lock(&data->mutex);
> +
> +	ret = regmap_bulk_write(data->regmap, SX9360_REG_GNRL_CTRL1, &buf,
> +				sizeof(buf));
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
