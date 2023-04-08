Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876676DBA0B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Apr 2023 12:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjDHKVu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Apr 2023 06:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDHKVp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2023 06:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2F1026B
        for <linux-iio@vger.kernel.org>; Sat,  8 Apr 2023 03:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CCD960AC0
        for <linux-iio@vger.kernel.org>; Sat,  8 Apr 2023 10:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE6BC433EF;
        Sat,  8 Apr 2023 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680949260;
        bh=IMjB/iBdmVhDk8wW7B5WUDd6TW2LDcDNFlY+rRIXgCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SyLSHzoK9tj9NsI9GZwtNFQaua4Usc5FPgRVDOjvy3dTzndb+PCQRl3eAaC6JUuQJ
         0bPdGfhZac5UXtzOxZqWO52qfh00V9RzArYtTRktupJAm3o3/20btsTn2Wy7aH7zg6
         zo5dIdvcQ28OOfdbpvwaFXobXfuVvzh/LkwO7Rd05PCxRoXI1uVhV7K9pUNChV4coW
         1Xwtib9HpHY967zjdG/vRNaEQppt+bQ5Kwk0LFYqf6HzGb88l5ckl+flT4uYDQjaI0
         Vqtw9tvGIa+NC93mWBVx5krcSTPCoXdxPyT8bKzjrNgnYs2MigDKGu2YidrKqBPwXj
         mJueGedpXd+nA==
Date:   Sat, 8 Apr 2023 11:36:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     alexandru.tachici@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] ad7192 driver: fix null pointer dereference in
 probe when populating adc input ranges
Message-ID: <20230408113616.7a9e887e@jic23-huawei>
In-Reply-To: <CAPJMGm4FkOmQkQ3H00kNR_gUCu7mAUiQS7OPi4jGEBccLEVv=A@mail.gmail.com>
References: <CAPJMGm4GDVdAmwB4sHVkg78UhtVpmbCL6KT8-KbEY7cRSD5UZg@mail.gmail.com>
        <20230401152827.179d1a01@jic23-huawei>
        <CAPJMGm4FkOmQkQ3H00kNR_gUCu7mAUiQS7OPi4jGEBccLEVv=A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Apr 2023 08:57:07 +0200
Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:

> On Sat, Apr 1, 2023 at 4:13=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Mon, 27 Mar 2023 22:02:48 +0200
> > Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:
> > =20
> > > Fix ad7192.c NULL pointer dereference in ad7192_setup() when accessing
> > > indio_dev structure while populating input rages, causing a kernel
> > > panic.
> > > Fixed by calling spi_set_drvdata after indio_dev is allocated.
> > >
> > > Pointer to indio_dev structure is obtained via spi_get_drvdata() at
> > > the beginning of function ad7192_setup(), but the
> > > spi->dev->driver_data member is not initialized here, hence a NULL
> > > pointer is returned.
> > >
> > > By comparing every other iio adc driver, whenever there is a call to
> > > spi_get_drvdata() there is also one to spi_set_drvdata() within probe
> > > function.
> > > It should also be noted that the indio_dev structure is accessed just
> > > to get the number of bits for the converter, and no other driver calls
> > > spi_get_drvdata within probe.
> > > After the patch is applied the system boots correctly and the ADC is
> > > mapped within sysfs. =20
> >
> > I'd prefer to fix this by changing the ad7192_setup() to take the
> > struct iio_dev (available at it's call site) and avoid the dance
> > that is currently going on entirely.
> > Drop the struct ad7192_state *st parameter and get that via
> > st =3D iio_priv(indio_dev);
> >
> > Thanks,
> >
> > Jonathan
> > =20
>=20
> Fix NULL pointer dereference in ad7192_setup() (ad7192.c) when accessing
> indio_dev structure while populating input rages, causing a kernel panic.
>=20
> Changed ad7192_setup() signature to take pointer to struct
> iio_dev, and got ad7192_state pointer via st =3D iio_priv(indio_dev);
>=20
> Fixes: bd5dcdeb3fd0 iio: adc: ad7192: convert to device-managed functions
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Looks good. If you haven't already (I'm behind with emails)
please send this out as a full patch etc so it gets correctly picked up
by patchwork / b4 etc.

Thanks

Jonathan

> ---
> V1 -> Revised after suggestions from Jonathan, removed Reviewed-by
>  since the entire patch changed its content.
>=20
>  drivers/iio/adc/ad7192.c | 6 +++---
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -380,9 +380,9 @@ static int ad7192_of_clock_select(struct ad7192_state=
 *st)
>      return clock_sel;
>  }
>=20
> -static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
> +static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *n=
p)
>  {
> -    struct iio_dev *indio_dev =3D spi_get_drvdata(st->sd.spi);
> +    struct ad7192_state *st =3D iio_priv(indio_dev);
>      bool rej60_en, refin2_en;
>      bool buf_en, bipolar, burnout_curr_en;
>      unsigned long long scale_uv;
> @@ -1073,7 +1073,7 @@ static int ad7192_probe(struct spi_device *spi)
>          }
>      }
>=20
> -    ret =3D ad7192_setup(st, spi->dev.of_node);
> +    ret =3D ad7192_setup(indio_dev, spi->dev.of_node);
>      if (ret)
>          return ret;
>=20

