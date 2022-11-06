Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF86461E2F1
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 16:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKFPXU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 10:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiKFPXS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 10:23:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A64D2C5
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 07:23:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F82260C87
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 15:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DC7C433D6;
        Sun,  6 Nov 2022 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667748196;
        bh=2stSSFQ4AztJVzQ82MMXZuTW6yPTJubbNvsvZ8PN+5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LiZstsbyD1YGpZ46YIChYQO6svfxKr9i5YwpHvVHCU67ACDAZNyNQm8tOz2/XjMhC
         LGDFO8Eryu7ym3pMmoaJ5eLZlXgetytL3vArR5FHfV0Kl/XKrl5Wv6QaEcxM1HNE25
         nzTtItJGZdIgmU66NYs4Br1K+NosN3XYs8x226e8iderPN5iMEyH0cE/a3HqPtLmWh
         pzZRD26FrU9V93uv6I6WFkOnyDQXA66aWfZdu23QOslsYOLeuenzktswI1QOUBLzTO
         wLR9vfSMGwnB6R4Cx6JrRoU0eVJ0hIkfCHdRvWIhVeygVKdYZfESggaEDqiJ7hx2x1
         gy+VJtONl4Nhw==
Date:   Sun, 6 Nov 2022 15:23:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] iio: light: vcnl4000: Don't create sysfs PM nodes for
 child
Message-ID: <20221106152307.4bfb4e49@jic23-huawei>
In-Reply-To: <20221101122151.221029-1-marten.lindahl@axis.com>
References: <20221101122151.221029-1-marten.lindahl@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 1 Nov 2022 13:21:51 +0100
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> PM runtime is enabled for the parent i2c device, but it is disabled for
> the iio child device and remains so in this driver. But as the child
> sysfs PM directory is created by default by iio_device_register =3D>
> cdev_device_add =3D> dpm_sysfs_add it doesn't bring any value exposing it
> since it won't give any usable data for the user.
>=20
> Tell dpm_sysfs to not create the PM directory for the iio device.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>

Ah this one..  +CC Sudeep who I am sure has considered such changes in other
similar cases (he did the original ones that mean this infastructure exists=
).

So, the problem here is that it drops an ABI that has existed in IIO for
a long time. I fully admit the ABI is confusing and pointless.  What
I'm not sure on is that we are entirely safe to remove it.

If we are going to do this, it shouldn't be on a per driver basis, but rath=
er
a global change for all IIO drivers with the proviso that we are relying on
the 'if no one notices an ABI change, it is fine' exception to never changi=
ng
userspace ABI.

Until now this has more or less only been used for new subsystems or where
there were warnings generated due to spurious interface usage in normal flo=
ws.

In IIO, nothing should touch these and I 'think' they don't do anything if
anyone pokes them.

Jonathan


> ---
>  drivers/iio/light/vcnl4000.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index f6c83ecaad8b..400dc1155559 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -1072,6 +1072,7 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		goto fail_poweroff;
> =20
> +	device_set_pm_not_required(&indio_dev->dev);
>  	ret =3D iio_device_register(indio_dev);
>  	if (ret < 0)
>  		goto fail_poweroff;

