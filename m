Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4A35EE80
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 09:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347823AbhDNHfr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 03:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349734AbhDNHfq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Apr 2021 03:35:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4ACC06175F
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:35:24 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c17so13159188pfn.6
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsh0lRmBfheV+1XDeSTyGAItl7zKR9zDXRMyX4d3yH4=;
        b=Ja/DEshr58vivWSvHqM7tuaChK+tdbQMVEYpmQeSg/JWLUlPIyGI42/NX45FJkDxGx
         rEmpkpxPT4a71qZA9iV/l9LKsPC6mG/lXFxiv7foDR6xGTmhGWLV6pcdMWwb4us1lfP+
         hrWGhi2vY5Q/etTs6IjwPhAOeOKp3Z7i+N1EsBNB90y7lLQnZGH18o+ZQz+ipP7JWGcg
         Jeh42ldAJ5kjBcJNnRVCyZhrtiPk1gwQHpoTuULh3ICCfayRgavF0o+MusTmVpDPGQzM
         Ca8XuxeCFxScwXivngiX92fzLcZPZGQsIHttNnuCa8B1SaZ7nvO++AD8VyJk//AqGC9o
         1ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsh0lRmBfheV+1XDeSTyGAItl7zKR9zDXRMyX4d3yH4=;
        b=DBCexxg34poWKa9QoUCdKSS1u+vxvjY876nsyVue02ltvKbarzO6S+AIIBcmZavqn8
         s1eKJvAjgO93qrTCumwMGmtc7F2tYpyAVrnEf93B7C49NWDUgDCJjPewOYKa9HeFNba8
         u2xfg3eDU3nc3WlHupb+3VKHPS0wpjYgmZmsJYqC62LHzd3HIiCJaJ57+Gi9PssTutzs
         jXkIrcLJp9utGfEnegXo6viKjcZ4SHmDrVYHnSIVHjNA0sLLThRon6B+mr8Vb5I5oPkW
         MBLHd+xBi2WuoC0eeptci8LaRiD853CJJ4ksYXjYQ4Gf3n0K6enyyKK4SIrObe8nBGvA
         uwNA==
X-Gm-Message-State: AOAM5331VVYvnJkmT54b+3biGGt1Tv7dUvaJFFEcaJAJauf1GBFxMGOG
        UHXBsFJvyBsVsmSxUdsf1RuUEGWl0fz7C1Z5a4EwKfdJYRdrUDYr
X-Google-Smtp-Source: ABdhPJzz4HBEdca3UVbTRhu4eW3bmOsbMvl90ZX9LbtODEGSZaueskJTUwt6WBYFwjbYJpSJlWMWoG7mdVoo+ug1sRw=
X-Received: by 2002:a65:6645:: with SMTP id z5mr35489101pgv.273.1618385724120;
 Wed, 14 Apr 2021 00:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210413112105.69458-1-nuno.sa@analog.com> <20210413112105.69458-7-nuno.sa@analog.com>
In-Reply-To: <20210413112105.69458-7-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 14 Apr 2021 10:35:13 +0300
Message-ID: <CA+U=DsrsbZ_jGcXuo=mMXHs10Um5uvk4rsgs5BCWHNCZVgAdeA@mail.gmail.com>
Subject: Re: [PATCH 6/7] iio: adis_buffer: don't push data to buffers on failure
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 13, 2021 at 5:45 PM Nuno Sa <nuno.sa@analog.com> wrote:
>
> There's no point in pushing data to IIO buffers in case 'spi_sync()'
> fails.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 7ab15c08889f..73790b71102b 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -146,9 +146,10 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>         }
>
>         ret = spi_sync(adis->spi, &adis->msg);
> -       if (ret)
> +       if (ret) {
>                 dev_err(&adis->spi->dev, "Failed to read data: %d", ret);
> -
> +               goto irq_done;
> +       }

This also has some issue with not unlocking the &adis->state_lock.

>
>         if (adis->data->has_paging) {
>                 adis->current_page = 0;
> --
> 2.31.1
>
