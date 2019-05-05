Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACEB140C0
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2019 17:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfEEPqo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 May 2019 11:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEPqo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 May 2019 11:46:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE4F206DF;
        Sun,  5 May 2019 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557071203;
        bh=K1Yl/knFZHbhEKmc3KgI5F6e3pNiwOCS7nqtUtOobsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iwrMLLRrB0gAO3INpoVysF+3daEzc/mq+4ngiYoBYpSQulNVUc1Y2JPpDFfpXLk1k
         alHdOsTjP3QNQzOmhMjwW95M80NZTfuOWEo3CjGWwDXMHmSFu2jfBPRRlRKOHKPdwU
         mqHP7v/kkTDfCKiGLr2LfLaHIlWqkgK3jZMwSK0c=
Date:   Sun, 5 May 2019 16:46:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, broonie@kernel.org,
        cychiang@chromium.org, tiwai@suse.com, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 01/30] mfd: cros_ec: Update license term
Message-ID: <20190505164637.579ffb11@archlinux>
In-Reply-To: <20190503220233.64546-2-gwendal@chromium.org>
References: <20190503220233.64546-1-gwendal@chromium.org>
        <20190503220233.64546-2-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 May 2019 15:02:04 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Update to SPDX-License-Identifier, GPL-2.0
> 
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Nitpick. There are a few other trivial changes in here, that the description
should probably mention.  I doubt anyone really cares though given
how trivial the other comment changes are.

Jonathan

> ---
>  include/linux/mfd/cros_ec_commands.h | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 43bee4f7d137..6fa508643da3 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -1,25 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Host communication command constants for ChromeOS EC
>   *
>   * Copyright (C) 2012 Google, Inc
>   *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * The ChromeOS EC multi function device is used to mux all the requests
> - * to the EC device for its multiple features: keyboard controller,
> - * battery charging and regulator control, firmware update.
> - *
> - * NOTE: This file is copied verbatim from the ChromeOS EC Open Source
> - * project in an attempt to make future updates easy to make.
> + * NOTE: This file is auto-generated from ChromeOS EC Open Source code from
> + * https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
>   */
>  
> +/* Host communication command constants for Chrome EC */
> +
>  #ifndef __CROS_EC_COMMANDS_H
>  #define __CROS_EC_COMMANDS_H
>  

