Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9201A6884F9
	for <lists+linux-iio@lfdr.de>; Thu,  2 Feb 2023 17:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjBBQ6i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Feb 2023 11:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjBBQ6f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Feb 2023 11:58:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC92E712C6
        for <linux-iio@vger.kernel.org>; Thu,  2 Feb 2023 08:58:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5567B82746
        for <linux-iio@vger.kernel.org>; Thu,  2 Feb 2023 16:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8E5C433D2;
        Thu,  2 Feb 2023 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675357112;
        bh=MTBLO8QeX9QlSx+MmBQA2E2AsMlbftPfUcV0K9rd42w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VFWqdxWQ/nP+FqXYfvS+34iZnwPmda64gqQ1U4fNfYcoTrgDXZDgbgIZb8zFcpOqh
         dUmvrBg54VidBxW6Kgs1rsU1Ji6DNKhGc7nVnQGTQPDskp6OSUOAEXGlEWevLCF/7n
         dWbVk6Xstrfh0mfwTp1Crp91W07yBxjdCWKQ6K0Sca3sb1fOXa/jJwPxq3KVbc+R8P
         ZRhT1L9rAGj5y56kklRyZToFdMOedUL8bMpBAVZw2oVVIDYsT7c5zpXqtbnO4MK67F
         oeKhIov2De9Caw4GtDUY6oPd1G+8uD+jvUvENfQg0qdg1QA7qF3cLxVYCjeE43rnXN
         iNi6Hma4YUr3A==
Date:   Thu, 2 Feb 2023 17:12:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v3] iio: light: vcnl4000: Fix WARN_ON on uninitialized
 lock
Message-ID: <20230202171230.009bd13a@jic23-huawei>
In-Reply-To: <Y9kiM768ZSkuK+Mk@smile.fi.intel.com>
References: <20230131140109.2067577-1-marten.lindahl@axis.com>
        <Y9kiM768ZSkuK+Mk@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Tue, 31 Jan 2023 16:14:11 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Jan 31, 2023 at 03:01:09PM +0100, M=C3=A5rten Lindahl wrote:
> > There are different init functions for the sensors in this driver in
> > which only one initializes the generic vcnl4000_lock. With commit
> > e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle pow=
er")
> > the vcnl4040 sensor started to depend on the lock, but it was missed to
> > initialize it in vcnl4040's init function. This has not been visible
> > until we run lockdep on it:
> >=20
> >   DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> >   at kernel/locking/mutex.c:575 __mutex_lock+0x4f8/0x890
> >   Call trace:
> >   __mutex_lock
> >   mutex_lock_nested
> >   vcnl4200_set_power_state
> >   vcnl4200_init
> >   vcnl4000_probe
> >=20
> > Fix this by initializing the lock in the probe function instead of doing
> > it in the chip specific init functions. =20
>=20
> Fine now, thanks!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> > Fixes: e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when tog=
gle power")
> > Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
Applied to the fixes-togreg branch and marked for stable.

Thanks,

Jonathan

> > ---
> >=20
> > v3:
> >  - Trimmed backtrace in commit message even more
> >  - New line before mutex_init
> >=20
> > v2:
> >  - Trimmed backtrace in commit message
> >  - Have 12 digit sha-1 id in Fixes tag
> >  - Make the lock initialization in probe instead of in _init function
> >=20
> >  drivers/iio/light/vcnl4000.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index cc1a2062e76d..69c5bc987e26 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -199,7 +199,6 @@ static int vcnl4000_init(struct vcnl4000_data *data)
> > =20
> >  	data->rev =3D ret & 0xf;
> >  	data->al_scale =3D 250000;
> > -	mutex_init(&data->vcnl4000_lock);
> > =20
> >  	return data->chip_spec->set_power_state(data, true);
> >  };
> > @@ -1197,6 +1196,8 @@ static int vcnl4000_probe(struct i2c_client *clie=
nt)
> >  	data->id =3D id->driver_data;
> >  	data->chip_spec =3D &vcnl4000_chip_spec_cfg[data->id];
> > =20
> > +	mutex_init(&data->vcnl4000_lock);
> > +
> >  	ret =3D data->chip_spec->init(data);
> >  	if (ret < 0)
> >  		return ret;
> > --=20
> > 2.30.2
> >  =20
>=20

