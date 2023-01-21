Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6671676775
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jan 2023 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjAUQpJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Jan 2023 11:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAUQpI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2023 11:45:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE50A113F1
        for <linux-iio@vger.kernel.org>; Sat, 21 Jan 2023 08:45:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 807DE60B28
        for <linux-iio@vger.kernel.org>; Sat, 21 Jan 2023 16:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D903FC433EF;
        Sat, 21 Jan 2023 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674319506;
        bh=Dm26spmtHYZ+N4EDsBvxRbnNQpyZAiz2Nw1bOPZtraI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ESrG0pxiNQfW13tdgftXkczfVj4MtjPgLk9B34qxQOqvvs73WJ1szD7yl2kC0ytmO
         HOTIld63S+HNuags2qysurfOhVoNuFSw0ugrImzA5sSXS7g7l0huytTNDK7b5H/DjH
         ktANd8AnJvtrjcwNlkmKCQ7JE91BvcQwDFMtFTZ+N7XnIo30i9JYsAfRXKLO09IrZq
         b5eouFSWF36+O8X1Jq7d3mwJjyjeDDScCKXVMGfQZ1ieTClZrG1+k4rX9tltIzsNjW
         aaGNw4GqLV0MZi1ZafB1ALNkNOLRZcjwHZCDAvcmrFvlH0qVtoLW7qeevPallGHKTE
         Te2WWQbCHr/IA==
Date:   Sat, 21 Jan 2023 16:58:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: adc: ad7791: fix IRQ flags
Message-ID: <20230121165852.5a302778@jic23-huawei>
In-Reply-To: <20230120124645.819910-1-nuno.sa@analog.com>
References: <20230120124645.819910-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Jan 2023 13:46:45 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The interrupt is triggered on the falling edge rather than being a level
> low interrupt.
>=20
> Fixes: da4d3d6bb9f6 ("iio: adc: ad-sigma-delta: Allow custom IRQ flags")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

What are the symptoms of this?  Given the ad_sigma_delta.c irq handler
disables the interrupt until after the data read is done (at which point the
level is presumably high again), I don't immediately see why the change
here has any impact - either we trigger on the fall, or on the fact it
has become low..

Or is there a board other there that only does end interrupts that is causi=
ng
problems?

Jonathan

> ---
>  drivers/iio/adc/ad7791.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index fee8d129a5f0..86effe8501b4 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -253,7 +253,7 @@ static const struct ad_sigma_delta_info ad7791_sigma_=
delta_info =3D {
>  	.has_registers =3D true,
>  	.addr_shift =3D 4,
>  	.read_mask =3D BIT(3),
> -	.irq_flags =3D IRQF_TRIGGER_LOW,
> +	.irq_flags =3D IRQF_TRIGGER_FALLING,
>  };
> =20
>  static int ad7791_read_raw(struct iio_dev *indio_dev,

