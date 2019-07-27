Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB25977C41
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 00:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfG0WGT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 18:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbfG0WGT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 18:06:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD8E20578;
        Sat, 27 Jul 2019 22:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564265178;
        bh=IvZ5ojWI/o/dpGfV+DTZirjc64k4N1vc166A/o35xx4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b7/a63w6WGXXC+YOE/87rvCsl6PSlpU4QOzarXINET8Nt6MIWYFatBDzj5lvEQI/N
         Xg/I1+Nt3KwRkvCfTmCEGNHhGSYEdHNryEKMZjjoDucYvKe/NDZZL1P81Vcw17zTvR
         sLzjqpc6xN7KSgfKxhCmqQWYmFoN73TkPbjBRRrI=
Date:   Sat, 27 Jul 2019 23:06:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        dianders@chromium.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] iio: cros_ec_accel_legacy: Fix incorrect channel
 setting
Message-ID: <20190727230613.67333b28@archlinux>
In-Reply-To: <20190715231454.189459-3-gwendal@chromium.org>
References: <20190715231454.189459-1-gwendal@chromium.org>
        <20190715231454.189459-3-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Jul 2019 16:14:52 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> INFO_SCALE is set both for each channel and all channels.
> iio is using all channel setting, so the error was not user visible.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 46bb2e421bb9..ad19d9c716f4 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -319,7 +319,6 @@ static const struct iio_chan_spec_ext_info cros_ec_accel_legacy_ext_info[] = {
>  		.modified = 1,					        \
>  		.info_mask_separate =					\
>  			BIT(IIO_CHAN_INFO_RAW) |			\
> -			BIT(IIO_CHAN_INFO_SCALE) |			\
>  			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
>  		.ext_info = cros_ec_accel_legacy_ext_info,		\

