Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C646804D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 18:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfGNQxK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 12:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728125AbfGNQxK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:53:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9992B20820;
        Sun, 14 Jul 2019 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563123189;
        bh=+uH1r3GOWbQp/hdEIcrzYyH/9+YEt9MgbiJzE04G4Ys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZnJyJ2SBg7Gp3262x5SXGIexj1q4I5p7OaVRbnKX+3T4V4Macw+rkUq4HGP/UAlQy
         dRfWx3n13RTsNU9CFpenF1ZaAVYPFiigHwVSyZ+BQ7JLBUZJ4gAvxq35cjSPiB8Wr3
         R8WzerOUgRV3BmrmfsDiiEWm1o+zOR9yvzQ6tGYE=
Date:   Sun, 14 Jul 2019 17:53:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        dianders@chromium.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: cros_ec_accel_legacy: Fix incorrect channel
 setting
Message-ID: <20190714175304.54709186@archlinux>
In-Reply-To: <20190628191711.23584-3-gwendal@chromium.org>
References: <20190628191711.23584-1-gwendal@chromium.org>
        <20190628191711.23584-3-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Jun 2019 12:17:09 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> INFO_SCALE is set both for each channel and all channels.
> iio is using all channel setting, so the error was not user visible.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
This one I am going to take because it is stand alone and I have some other
fixes queued up for a pull request in a week or so anyway.

I'm unconvinced this isn't uservisible in general, though perhaps
userspace code won't use it.

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

