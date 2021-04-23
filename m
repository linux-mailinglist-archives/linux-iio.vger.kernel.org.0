Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44070368DF1
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 09:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhDWHfN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 03:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHfM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Apr 2021 03:35:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BB9C061574
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:34:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so4049827pjb.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Apr 2021 00:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iSe0RyMcfjwv5x8H5oUC9pebXswZgLBzJX5WsyGcNs=;
        b=WICdqb336n921vEjCLh+bM0dSPl5uFe1R+yScHxkTgNLbQy0jOiy5ub2vAZiiebdHX
         GJgBq+4A4UhbhPSsbKyDoFG8E0IoNgYWRn1c54It+Rs9PQkkVIU2hdze1sO8uJA2nbII
         1E36QhQswvFoS9qeRAYF5FasB2qKRvMW/cU7wpOEuhovlTevx8kvvT7eVK+REab4YOpH
         PejO2NC8IWc/E0Juzgw7OlAhTU65L6+NtBTdss/0F31EWKX2baBrUsj4DQvzuV+tuZMq
         /HkmjEzpRK6kdMLGlhkA6TkdJYZR7AFybAqEb9TkHRGXTWdQG/FYZsP0Kj5ynTLgwKp6
         NGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iSe0RyMcfjwv5x8H5oUC9pebXswZgLBzJX5WsyGcNs=;
        b=Hpa/kGvSXmC4ObLlQRjPdFLXplSIW944/Nl3QrsQBQXpR08jDW0H5K20xr3Rmk/k6c
         tLrg7DC1QrhyxlnK58/uTAvaJ/9qKaKatJ8jalPimYHSXU67/BeaJQyfTSuXedrnlW4V
         v1dORG9jmZqm3iOsxDkf2a1VQZgv/zfNqvBauJFa3ERJjhlr/6chXq1kmr5ejjatAfuB
         guj/MfnHZOcDPoYZMuOfM4TaL7IJRmNkRM8u26yCaW5sYsrIU1cWv1RuvEiUHFljV781
         dEZEc8JifvCBA0XhcaezHxyOtSGND6XHCPjpquLXmfhsM9cX/kmDMF0JZKJWzUq/ve6z
         zDTQ==
X-Gm-Message-State: AOAM530/TwY31ubaJPCqOqB0yIrDIikd6KQY9jL3j7EROchGGnYTnoPt
        yiYeCvHtwEJ2/+VOVUP7afq+UdhRINh7kPhkhbk=
X-Google-Smtp-Source: ABdhPJxvdZW/iPzPihJLFBSQ82D7ogSSmLTzRel0lXBmh15hN8IbL5TaYZNOc2knbVDhUNJwdhEfCK8oBAG49T5QLrU=
X-Received: by 2002:a17:90a:d352:: with SMTP id i18mr4489645pjx.19.1619163275306;
 Fri, 23 Apr 2021 00:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210422101911.135630-1-nuno.sa@analog.com> <20210422101911.135630-8-nuno.sa@analog.com>
In-Reply-To: <20210422101911.135630-8-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 23 Apr 2021 10:34:24 +0300
Message-ID: <CA+U=DsqOFY1JbffqOjhcqFQzjeC3sEQc=gHF-AgZwuyfxsandA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] iio: adis: add burst_max_speed_hz variable
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 22, 2021 at 1:17 PM Nuno Sa <nuno.sa@analog.com> wrote:
>
> Typically, in burst mode, the device cannot operate at it's full spi
> speed. Hence, the spi transfers for burst mode have to take this into
> account. With this change we avoid a potential race with the spi core as
> drivers were 'hacking' the device 'max_speed_hz' directly in the
> trigger handler.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 4 ++++
>  include/linux/iio/imu/adis.h  | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index dda367071980..82239da2f441 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -51,9 +51,13 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
>         adis->xfer[0].tx_buf = tx;
>         adis->xfer[0].bits_per_word = 8;
>         adis->xfer[0].len = 2;
> +       if (adis->data->burst_max_speed_hz)
> +               adis->xfer[0].speed_hz = adis->data->burst_max_speed_hz;
>         adis->xfer[1].rx_buf = adis->buffer;
>         adis->xfer[1].bits_per_word = 8;
>         adis->xfer[1].len = burst_length;
> +       if (adis->data->burst_max_speed_hz)
> +               adis->xfer[1].speed_hz = adis->data->burst_max_speed_hz;
>
>         spi_message_init(&adis->msg);
>         spi_message_add_tail(&adis->xfer[0], &adis->msg);
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index f9b728d490b1..cf49997d5903 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -55,6 +55,7 @@ struct adis_timeout {
>   *                     this should be the minimum size supported by the device.
>   * @burst_max_len:     Holds the maximum burst size when the device supports
>   *                     more than one burst mode with different sizes
> + * @burst_max_speed_hz:        Maximum spi speed that can be used in burst mode
>   */
>  struct adis_data {
>         unsigned int read_delay;
> @@ -83,6 +84,7 @@ struct adis_data {
>         unsigned int burst_reg_cmd;
>         unsigned int burst_len;
>         unsigned int burst_max_len;
> +       unsigned int burst_max_speed_hz;
>  };
>
>  /**
> --
> 2.31.1
>
