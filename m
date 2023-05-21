Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5047C70AF92
	for <lists+linux-iio@lfdr.de>; Sun, 21 May 2023 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjEUScj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 May 2023 14:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjEURnB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2023 13:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F351733
        for <linux-iio@vger.kernel.org>; Sun, 21 May 2023 10:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42FAE60F0F
        for <linux-iio@vger.kernel.org>; Sun, 21 May 2023 17:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B33C433D2;
        Sun, 21 May 2023 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684690814;
        bh=P4sV80L/x7n0lVUJd85OjC4pmF2PCWr79mlVTIPXw6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cjS7+0jP4sjfuYsaIYZ1ehAfOEYiqA3qiYvzIUFTywNSvazVbIGJS/6jlk8acjLkg
         oklPHZJE63a4Zjo06NhUlCf5v2j2VEiF1bHf1sl1lqRwexjRp5s644XsJatr41YqmG
         qzZBeCK6N0S4qeocC71/AXwDY34p+1lgP+P8MkJ4oumXMrrZTXO4PJ32H7frM/9R4e
         BsoFl7PQRn/7XVdxiCaHuh124Mkga/8iLL1zmMveCoTKpj/QFVL59taqZAjuR4tEuT
         rmcgft/oNHdRQIBa1rq+oAySvvq3T7w8bOBuNfk9KJokqHmwaMqS6JmJCZ641JxlaG
         KE+JpwlV8kMiQ==
Date:   Sun, 21 May 2023 18:56:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        kernel@pengutronix.de
Subject: Re: [PATCH] iio: Switch i2c drivers back to use .probe()
Message-ID: <20230521185625.5b2ce65d@jic23-huawei>
In-Reply-To: <20230520171300.mwtdml3lkwd3cvwi@pengutronix.de>
References: <20230515205048.19561-1-u.kleine-koenig@pengutronix.de>
        <20230520164340.25360292@jic23-huawei>
        <20230520171300.mwtdml3lkwd3cvwi@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 May 2023 19:13:00 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello Jonathan,
>=20
> On Sat, May 20, 2023 at 04:43:40PM +0100, Jonathan Cameron wrote:
> > On Mon, 15 May 2023 22:50:48 +0200
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> >  =20
> > > After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> > > call-back type"), all drivers being converted to .probe_new() and then
> > > 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") con=
vert
> > > back to (the new) .probe() to be able to eventually drop .probe_new()=
 from
> > > struct i2c_driver.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
 =20
> > Some fuzz due to other patches being queued up already, but otherwise
> > LGTM and applied to the togreg branch of iio.git which is initially pus=
hed
> > out as testing for 0-day to give it a whirl. =20
>=20
> Looks good, thanks!
>=20
> Your tree has a few new drivers that still use .probe_new(). To convert
> these we'd need:
>=20
> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> index feb57cb99aa4..502946bf9f94 100644
> --- a/drivers/iio/light/opt4001.c
> +++ b/drivers/iio/light/opt4001.c
> @@ -457,7 +457,7 @@ static struct i2c_driver opt4001_driver =3D {
>  		.name =3D "opt4001",
>  		.of_match_table =3D opt4001_of_match,
>  	},
> -	.probe_new =3D opt4001_probe,
> +	.probe =3D opt4001_probe,
>  	.id_table =3D opt4001_id,
>  };
>  module_i2c_driver(opt4001_driver);
> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu=
27008.c
> index adac4cd8d905..489902bed7f0 100644
> --- a/drivers/iio/light/rohm-bu27008.c
> +++ b/drivers/iio/light/rohm-bu27008.c
> @@ -1016,7 +1016,7 @@ static struct i2c_driver bu27008_i2c_driver =3D {
>  		.of_match_table =3D bu27008_of_match,
>  		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>  	},
> -	.probe_new =3D bu27008_probe,
> +	.probe =3D bu27008_probe,
>  };
>  module_i2c_driver(bu27008_i2c_driver);
> =20
> diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mp=
rls0025pa.c
> index 06f40e47c68e..30fb2de36821 100644
> --- a/drivers/iio/pressure/mprls0025pa.c
> +++ b/drivers/iio/pressure/mprls0025pa.c
> @@ -436,7 +436,7 @@ static const struct i2c_device_id mpr_id[] =3D {
>  MODULE_DEVICE_TABLE(i2c, mpr_id);
> =20
>  static struct i2c_driver mpr_driver =3D {
> -	.probe_new	=3D mpr_probe,
> +	.probe		=3D mpr_probe,
>  	.id_table	=3D mpr_id,
>  	.driver		=3D {
>  		.name		=3D "mprls0025pa",
>=20
> At some point I'd need to address these. What is your preferred way to
> handle these? I can send a proper follow up patch, you can squash the
> above diff into be8e2ed93211 ... just tell me your preference. If you
> don't I will send a patch at some point.

Good point. I wasn't paying attention.  Some of these at least are after
your patch in my tree, so I've fixed those up at introduction rather than
messing around with a follow on patch.

I squashed the opt4001 into this patch as that driver is now upstream.

So should all look good now.  I'll probably miss some more later in the
series though so if you notice, do point them out! Takes a while for
my review brain to pick up on function name changes ;)

New version of testing pushed out just now.

Thanks,

Jonathan


=09
>=20
> Best regards
> Uwe
>=20

