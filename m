Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2378CDD7
	for <lists+linux-iio@lfdr.de>; Tue, 29 Aug 2023 22:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjH2Uv1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Aug 2023 16:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjH2UvP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Aug 2023 16:51:15 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC081BC
        for <linux-iio@vger.kernel.org>; Tue, 29 Aug 2023 13:51:12 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40c72caec5cso101301cf.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Aug 2023 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693342271; x=1693947071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeQ6PnT2X5OAN+PUcFdr1liTuB+fdgrOrVYsIp5DUEg=;
        b=n2tT3msIJWbbmG5p6x09DTwWfjI/pR5DrqDBZVEs8gBoALJRGprUq1q0+jPJoxJ1NB
         sTFwPDaR0MmpuDWqhdCMayQY8bT8t5E+EMBM9S9lJKNnjhGnoQnzAO3YCEBgWkcufaG4
         t8IEhox4vfDs1F3WXVqrut+lId++D9Nlkx5ohfMkVCVskgZHYgpq93raqhOrdrS2Vwwe
         iHAfaohYjSaSCNqi6i22VbuQGtvLf2kPCLsMXWpo3foVJhkh5BnYV+asOJ0gnB/iQJej
         ce7BjmWa/gZo0gVkMhtjO1jRNfeNOrotZw08yteBzWfsPjIbnF9KHVHt9EwDKcah3iDB
         8Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693342271; x=1693947071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeQ6PnT2X5OAN+PUcFdr1liTuB+fdgrOrVYsIp5DUEg=;
        b=cVTmyubUEXx/+8yRldn14lWewy3ogCzAwPS/g6b87XlmGSIc8DxrVP0jD3HxMihfqE
         yEGrmyYB1r+Rc8DT+1Pdpmrxu7td2CygHDd1qfVeBMS0s89yaJb/sDUdKPNS6PK8y19S
         WewEID+joPEPHk9DaacWyO5Pgru6yTKi3BXkP0bXot2so4HtjOI9T+HXmLlAkExnvNXn
         H9oBYUmkt6EoR2e0BuIH2uwSiAGR8MxbAswMZmL36gwdTGVlMIcHlU81jD5ayqhbSRuc
         1m8Db2jMIU8Ey9ZZ6ZUkGnGc3+h+t1Q/jRZ/JTP/rVu3Cntv52XQtzx+uRJsknA11Rof
         XSrw==
X-Gm-Message-State: AOJu0YwKpq+jif/y+IEQ5kmzr41s7UM3oi4PtHn6mFeuQ8g/DNGg1hBL
        Ay+q3sQ9pYBnws2LiGc51WPSYGAOMaPePDxnRHwnAw==
X-Google-Smtp-Source: AGHT+IHfwvVY+FulDFY6b/mtqjHft/EOuA9DkxgnPhQI6OKdriWUaWzbuOFOUWeZ4mpR5dNcDPzhQcFLTENXWTwM5S0=
X-Received: by 2002:a05:622a:40f:b0:3fa:3c8f:3435 with SMTP id
 n15-20020a05622a040f00b003fa3c8f3435mr316048qtx.27.1693342271616; Tue, 29 Aug
 2023 13:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230829030622.1571852-1-tzungbi@kernel.org>
In-Reply-To: <20230829030622.1571852-1-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 29 Aug 2023 13:50:59 -0700
Message-ID: <CABXOdTfSXJdAz83t-Ndu+MMVLr3KoB37HG3e8_82eE-WmSAZgg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, jic23@kernel.org,
        lars@metafoo.de, chrome-platform@lists.linux.dev,
        gwendal@chromium.org, linux-iio@vger.kernel.org,
        dianders@chromium.org, swboyd@chromium.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 28, 2023 at 8:06=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> cros_ec_sensors_push_data() reads `indio_dev->active_scan_mask` and
> calls iio_push_to_buffers_with_timestamp() without making sure the
> `indio_dev` stays in buffer mode.  There is a race if `indio_dev` exits
> buffer mode right before cros_ec_sensors_push_data() accesses them.
>
> An use-after-free on `indio_dev->active_scan_mask` was observed.  The
> call trace:
> [...]
>  _find_next_bit
>  cros_ec_sensors_push_data
>  cros_ec_sensorhub_event
>  blocking_notifier_call_chain
>  cros_ec_irq_thread
>
> It was caused by a race condition: one thread just freed
> `active_scan_mask` at [1]; while another thread tried to access the
> memory at [2].
>
> Fix it by calling iio_device_claim_buffer_mode() to ensure the
> `indio_dev` can't exit buffer mode during cros_ec_sensors_push_data().
>
> [1]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/industriali=
o-buffer.c#L1189
> [2]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/common/cros=
_ec_sensors/cros_ec_sensors_core.c#L198
>
> Cc: stable@vger.kernel.org
> Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when EC=
 supports FIFO")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes from v1(https://patchwork.kernel.org/project/linux-iio/patch/2023=
0828094339.1248472-1-tzungbi@kernel.org/):
> - Use iio_device_{claim|release}_buffer_mode() instead of accessing `mloc=
k`.
>
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/=
drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index b72d39fc2434..6bfe5d6847e7 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -190,8 +190,11 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_=
dev,
>         /*
>          * Ignore samples if the buffer is not set: it is needed if the O=
DR is
>          * set but the buffer is not enabled yet.
> +        *
> +        * Note: iio_device_claim_buffer_mode() returns -EBUSY if the buf=
fer
> +        * is not enabled.
>          */
> -       if (!iio_buffer_enabled(indio_dev))
> +       if (iio_device_claim_buffer_mode(indio_dev) < 0)
>                 return 0;
>
>         out =3D (s16 *)st->samples;
> @@ -210,6 +213,7 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_d=
ev,
>         iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
>                                            timestamp + delta);
>
> +       iio_device_release_buffer_mode(indio_dev);
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
>
