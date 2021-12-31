Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546C948225C
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbhLaFvD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhLaFvD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:51:03 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6432C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:51:02 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x6so31651255iol.13
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6wjteSIqldq/uDrTxnRM+0VEx0c30QlgsIBFGPLrG0=;
        b=UCJ+hQLnlakql1kY6QrD8NYdXkcnpu2WQn5XCMsbuZdiMpy7pgI8RqITKiySk43bZx
         7d3sZrDkIT8rJ7staIqjqlLDGGiXiD6Z2UpFBwVtoP6p3DqCn2yg7ScUxZUUEMxl3hnz
         s7FIeXfW3ec8olidobmccl/jTsdFGkGl+/a8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6wjteSIqldq/uDrTxnRM+0VEx0c30QlgsIBFGPLrG0=;
        b=vranFtYvPvb61XV6fb82p7Jwo/e1RwM3ghraqk6XkMnKzuRC20CrzcIpvWfWrCxuPK
         7ZOgr1rDVzylL9pGeEAJ2O/C0qKiE7cCF9HmKDTZ/wLF/STXxAYcZ7ICuxyo6Ih4+OPk
         PpybFenQd04YTYRFpZXzYvp1rgZWAUSlMi6mv5+9gH67p/qqYOysQb7iKx1K3nd1agJO
         CE1AwDrfV7qrADdywRXg+Iv4G58DUeMl3RnykH+CODAi9NBZuqkTsSy1vitqSGL5ytHZ
         bTNnoOhQFJQeFN04UmPByvikPj5u01nc+k3oDVGbGMWogKppaIQ/A3iz9Ai7zfi/TcUA
         rksQ==
X-Gm-Message-State: AOAM532mBBFtMxwZeELNcLyxpyZPKoESK5QRi7Gdu/SMTrHFUQ1JfN8P
        PrBjK1UKNce/X78vtw7iDLBVvMhWbuLJQuSajiJAVPV+wk8Akg==
X-Google-Smtp-Source: ABdhPJz8g2cY/8TX0znvVTINUxSlyJFbE44o2D0RdqxTkv3XxFr7iL/RWyd7eTV/j01gmCgmBEmdeHc4GEEGBuAbCvA=
X-Received: by 2002:a05:6602:3422:: with SMTP id n34mr15021351ioz.7.1640929862273;
 Thu, 30 Dec 2021 21:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-17-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-17-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:50:50 -0800
Message-ID: <CAPUE2uu-QL4wN9_PSKqax9Suxv4JWG71AHa29-SrMH8aFO5fTw@mail.gmail.com>
Subject: Re: [PATCH 16/16] iio:accel:dmard09: Tidy up white space around {} in
 id table
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Previously inconsistent with a space after { but not before }.
> Tidy that up to avoid providing a bad example that might get
> copied into other drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/accel/dmard09.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
> index e6e28c964777..53ab6078cb7f 100644
> --- a/drivers/iio/accel/dmard09.c
> +++ b/drivers/iio/accel/dmard09.c
> @@ -126,7 +126,7 @@ static int dmard09_probe(struct i2c_client *client,
>  }
>
>  static const struct i2c_device_id dmard09_id[] = {
> -       { "dmard09", 0},
> +       { "dmard09", 0 },
>         { },
>  };
>
> --
> 2.34.1
>
