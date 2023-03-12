Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49226B677E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 16:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCLP0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCLP0f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 11:26:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175CE3B65F
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 08:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6087ECE0B11
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 15:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7960C433D2;
        Sun, 12 Mar 2023 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678634790;
        bh=0XFY8Pb8FbZ5qZGKPTLEAtGUUuclwFUr5/bUvyfDDqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iQSz/hLZ7PF9wxi6CCHfdlu1+MFzDbxG0hpVNHWxbEWnb/a/Tljzw1n+AX81aVYAq
         17bA04bVTsSyO9HmHO5itITDEfDeyqpOKgBtxM55GTdU+0Bmknoh2jaff2S5/9cRQF
         w5GR3SDL4dWgNoP0pexOnzStGr+XvMjGcjNUwkAF2Zn1aWKBrfjmWe6SeDThSDYFLG
         TrwTMCXgucRMYFq6/oopb/9rS5VIg16L9CzlSHF9xXpcMd4HexR1wvWy+6vbPGOh3+
         aNYq4paDIn69wJtKTHLlywUSYZ8H2x3gQjr3H0P3gWkPQzRrYCCTkEjkRRZYHU/qKH
         D7p6i3wnbJEmw==
Date:   Sun, 12 Mar 2023 15:26:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: adc: max11410: fix read_poll_timeout() usage
Message-ID: <20230312152636.2baee309@jic23-huawei>
In-Reply-To: <CY4PR03MB24888E9F4583FA53C7D8076596B59@CY4PR03MB2488.namprd03.prod.outlook.com>
References: <20230307095303.713251-1-nuno.sa@analog.com>
        <CY4PR03MB24888E9F4583FA53C7D8076596B59@CY4PR03MB2488.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Thu, 9 Mar 2023 12:37:54 +0000
"Tilki, Ibrahim" <Ibrahim.Tilki@analog.com> wrote:

> > Even though we are passing 'ret' as stop condition for
> > read_poll_timeout(), that return code is still being ignored. The reason
> > is that the poll will stop if the passed condition is true which will
> > happen if the passed op() returns error. However, read_poll_timeout()
> > returns 0 if the *complete* condition evaluates to true. Therefore, the
> > error code returned by op() will be ignored.
> >=20
> > To fix this we need to check for both error codes:
> >  * The one returned by read_poll_timeout() which is either 0 or
> > ETIMEDOUT.
> >  * The one returned by the passed op().
> >=20
> > Fixes: a44ef7c46097 ("iio: adc: add max11410 adc driver")
> > Signed-off-by: Nuno S=C3=83=C2=A1 <nuno.sa@analog.com> =20
>=20
> Acked-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
>=20
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

>=20
> > ---
> >  drivers/iio/adc/max11410.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
> > index 237b2ce3f264..6af829349b4e 100644
> > --- a/drivers/iio/adc/max11410.c
> > +++ b/drivers/iio/adc/max11410.c
> > @@ -414,13 +414,17 @@ static int max11410_sample(struct max11410_state =
*st, int *sample_raw,
> >  		if (!ret)
> >  			return -ETIMEDOUT;
> >  	} else {
> > +		int ret2;
> > +
> >  		/* Wait for status register Conversion Ready flag */
> > -		ret =3D read_poll_timeout(max11410_read_reg, ret,
> > -					ret || (val & MAX11410_STATUS_CONV_READY_BIT),
> > +		ret =3D read_poll_timeout(max11410_read_reg, ret2,
> > +					ret2 || (val & MAX11410_STATUS_CONV_READY_BIT),
> >  					5000, MAX11410_CONVERSION_TIMEOUT_MS * 1000,
> >  					true, st, MAX11410_REG_STATUS, &val);
> >  		if (ret)
> >  			return ret;
> > +		if (ret2)
> > +			return ret2;
> >  	}
> > =20
> >  	/* Read ADC Data */
> > @@ -851,17 +855,21 @@ static int max11410_init_vref(struct device *dev,
> > =20
> >  static int max11410_calibrate(struct max11410_state *st, u32 cal_type)
> >  {
> > -	int ret, val;
> > +	int ret, ret2, val;
> > =20
> >  	ret =3D max11410_write_reg(st, MAX11410_REG_CAL_START, cal_type);
> >  	if (ret)
> >  		return ret;
> > =20
> >  	/* Wait for status register Calibration Ready flag */
> > -	return read_poll_timeout(max11410_read_reg, ret,
> > -				 ret || (val & MAX11410_STATUS_CAL_READY_BIT),
> > -				 50000, MAX11410_CALIB_TIMEOUT_MS * 1000, true,
> > -				 st, MAX11410_REG_STATUS, &val);
> > +	ret =3D read_poll_timeout(max11410_read_reg, ret2,
> > +				ret2 || (val & MAX11410_STATUS_CAL_READY_BIT),
> > +				50000, MAX11410_CALIB_TIMEOUT_MS * 1000, true,
> > +				st, MAX11410_REG_STATUS, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ret2;
> >  }
> > =20
> >  static int max11410_self_calibrate(struct max11410_state *st) =20

