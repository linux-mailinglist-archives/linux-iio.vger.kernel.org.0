Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C8F790B9F
	for <lists+linux-iio@lfdr.de>; Sun,  3 Sep 2023 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjICLd7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Sep 2023 07:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjICLd7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2023 07:33:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7C5F2;
        Sun,  3 Sep 2023 04:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23D74CE0A38;
        Sun,  3 Sep 2023 11:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F239C433C7;
        Sun,  3 Sep 2023 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693740832;
        bh=hU/XrkQLwtTuX9PLXspmKByAuMPEEhrZQE8CCGu/PNc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MBLARwg/BlsTTKyKRUndXuGXEHvx3mmEJW8T/D039Q4EmtVWkDwFJcVgXt/CnG+vw
         iKYopKDjNW5IA4dxmGtJ93yW7PVUUwCRWX51lA9fSyjbRwr0q5EXghlyC/kTP1fVXo
         cyOatVSn0ByG/WaNew5XgdAIswO39GLEYYKBcYYnk1gEXmj+iVD60vB2tYc5L/BJIC
         vOoiDDavNcOUP90uWefFPtg+yJT2wkfX1eqMZZRk/39vbem1jIB73HGXK50OnBA6mM
         0lpBZ6U9tffahDo6cv9gv0IAtLr9GjvJ5FpNhCs4yo+wbpiRdJFhnook8kzCI7kOmC
         MvO1zkXgmZcSw==
Date:   Sun, 3 Sep 2023 12:34:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>, bleung@chromium.org,
        groeck@chromium.org, lars@metafoo.de,
        chrome-platform@lists.linux.dev, gwendal@chromium.org,
        linux-iio@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: cros_ec: fix an use-after-free in
 cros_ec_sensors_push_data()
Message-ID: <20230903123417.51d09285@jic23-huawei>
In-Reply-To: <CABXOdTfSXJdAz83t-Ndu+MMVLr3KoB37HG3e8_82eE-WmSAZgg@mail.gmail.com>
References: <20230829030622.1571852-1-tzungbi@kernel.org>
        <CABXOdTfSXJdAz83t-Ndu+MMVLr3KoB37HG3e8_82eE-WmSAZgg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Aug 2023 13:50:59 -0700
Guenter Roeck <groeck@google.com> wrote:

> On Mon, Aug 28, 2023 at 8:06=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org=
> wrote:
> >
> > cros_ec_sensors_push_data() reads `indio_dev->active_scan_mask` and
> > calls iio_push_to_buffers_with_timestamp() without making sure the
> > `indio_dev` stays in buffer mode.  There is a race if `indio_dev` exits
> > buffer mode right before cros_ec_sensors_push_data() accesses them.
> >
> > An use-after-free on `indio_dev->active_scan_mask` was observed.  The
> > call trace:
> > [...]
> >  _find_next_bit
> >  cros_ec_sensors_push_data
> >  cros_ec_sensorhub_event
> >  blocking_notifier_call_chain
> >  cros_ec_irq_thread
> >
> > It was caused by a race condition: one thread just freed
> > `active_scan_mask` at [1]; while another thread tried to access the
> > memory at [2].
> >
> > Fix it by calling iio_device_claim_buffer_mode() to ensure the
> > `indio_dev` can't exit buffer mode during cros_ec_sensors_push_data().
> >
> > [1]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/industria=
lio-buffer.c#L1189
> > [2]: https://elixir.bootlin.com/linux/v6.5/source/drivers/iio/common/cr=
os_ec_sensors/cros_ec_sensors_core.c#L198
> >
> > Cc: stable@vger.kernel.org
> > Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when =
EC supports FIFO")
> > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org> =20
>=20
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
Applied to the fixes-togreg branch of iio.git.  Note I'll be rebasing that =
tree on rc1 before
I send a pull request. So this will take a week or two to go upstream.

Thanks,

Jonathan
>=20
> > ---
> > Changes from v1(https://patchwork.kernel.org/project/linux-iio/patch/20=
230828094339.1248472-1-tzungbi@kernel.org/):
> > - Use iio_device_{claim|release}_buffer_mode() instead of accessing `ml=
ock`.
> >
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c =
b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index b72d39fc2434..6bfe5d6847e7 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -190,8 +190,11 @@ int cros_ec_sensors_push_data(struct iio_dev *indi=
o_dev,
> >         /*
> >          * Ignore samples if the buffer is not set: it is needed if the=
 ODR is
> >          * set but the buffer is not enabled yet.
> > +        *
> > +        * Note: iio_device_claim_buffer_mode() returns -EBUSY if the b=
uffer
> > +        * is not enabled.
> >          */
> > -       if (!iio_buffer_enabled(indio_dev))
> > +       if (iio_device_claim_buffer_mode(indio_dev) < 0)
> >                 return 0;
> >
> >         out =3D (s16 *)st->samples;
> > @@ -210,6 +213,7 @@ int cros_ec_sensors_push_data(struct iio_dev *indio=
_dev,
> >         iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
> >                                            timestamp + delta);
> >
> > +       iio_device_release_buffer_mode(indio_dev);
> >         return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(cros_ec_sensors_push_data);
> > --
> > 2.42.0.rc2.253.gd59a3bf2b4-goog
> > =20

