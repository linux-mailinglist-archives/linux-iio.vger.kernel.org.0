Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0C51AFBF
	for <lists+linux-iio@lfdr.de>; Wed,  4 May 2022 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378405AbiEDUyI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 May 2022 16:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378412AbiEDUxz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2022 16:53:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5352DD7
        for <linux-iio@vger.kernel.org>; Wed,  4 May 2022 13:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 040B3B8293F
        for <linux-iio@vger.kernel.org>; Wed,  4 May 2022 20:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E66FC385A5;
        Wed,  4 May 2022 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651697415;
        bh=L3umyqF+qlV4aDkA6vfR8MIaNI2Eb92s5S/0yr3FKSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C0luMHE5w1vpxv/+iV6F/nNNp05ghnhCV6AQPOAeJbobHIq/f9GQZJLUOm9eTZyQP
         4TRJUZNGIJzhcuj6i1t8B9CzgQtx+T77d60wOQS9iIrrPLjqv3IvP5eX3kK1H7YaoD
         g1mhU5rETroMy/w58otkyCX8ins5QQqLpAA506PkqRaXgWJNuLvkshmcWFOkf5YA0J
         Z9TpBLz3DXpHZNeP/Uj9apL4P5CnVnKMRoZ4ofXlc4bEMLefC/XVdnbiDuYYN/AUli
         IvGzzkA7w73/zhIycMeNa8fSMcfaIFKS28YpkBAqp0ZHt0tC34ndsw7Wrae6O6yrue
         /h4EIg5ZTPvcA==
Date:   Wed, 4 May 2022 21:58:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 8/9] iio:light:stk3310: Remove duplicated error
 reporting in .remove()
Message-ID: <20220504215835.15becc2b@jic23-huawei>
In-Reply-To: <20220502073755.rku3yv6il5efew2x@pengutronix.de>
References: <20220430081607.15078-1-u.kleine-koenig@pengutronix.de>
        <20220430081607.15078-9-u.kleine-koenig@pengutronix.de>
        <20220502073755.rku3yv6il5efew2x@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 May 2022 09:37:55 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello,
>=20
> On Sat, Apr 30, 2022 at 10:16:06AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Returning an error value in an i2c remove callback results in an error
> > message being emitted by the i2c core, but otherwise it doesn't make a
> > difference. The device goes away anyhow and the devm cleanups are
> > called.
> >=20
> > As stk3310_set_state() already emits an error message on failure and the
> > additional error message by the i2c core doesn't add any useful
> > information, change the return value to zero to suppress this message.
> >=20
> > This patch is a preparation for making i2c remove callbacks return void.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/iio/light/stk3310.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> > index 1d02dfbc29d1..95a98af08b8a 100644
> > --- a/drivers/iio/light/stk3310.c
> > +++ b/drivers/iio/light/stk3310.c
> > @@ -627,9 +627,12 @@ static int stk3310_probe(struct i2c_client *client,
> >  static int stk3310_remove(struct i2c_client *client)
> >  {
> >  	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > +	int ret;
> > =20
> >  	iio_device_unregister(indio_dev);
> > -	return stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
> > +	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
> > +
> > +	return 0;
> >  } =20
>=20
> I just found a fixup in my tree that drops the
>=20
> 	+	int ret;
>=20
> that I failed to squash in before sending.
>=20
> Jonathan: Tell me if you want to fixup yourself when you apply, or if
> you prefer a v2. If the latter, only for this patch or the whole series?

I'll fix it up when applying..

Thanks for letting me know.

Jonathan

>=20
> Best regards
> Uwe
>=20

