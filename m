Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7633E4FAF11
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 18:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiDJQwU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbiDJQwS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 12:52:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BBD13F14;
        Sun, 10 Apr 2022 09:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C3E86112F;
        Sun, 10 Apr 2022 16:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE02C385A1;
        Sun, 10 Apr 2022 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649609406;
        bh=lZPE+OeVGho9/MsXezYadGxibCtHR7leSyeCe+qHDP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WzuVHgYazvHNRT7R+Y9AUY4W+YDxexGWwm1r9e+QosXAM1l/F57WgzSsOjxRJ2jvX
         4Z4+7+GLrUSXfrCHudCLd9H2trn2GLvluW8wC4EPXVsZMzJayXYUBPMkrBbTa16w6q
         Gvv7AMnURt+Ur27xKpHT227Ht6F6KHlkYrOMU1lLak+uH5WGw28ohaG1J4eOdKjN6i
         lF4KkLqEkDZsAR7SrvrwIkbQv122L7TGLiB8LYPJ1YtUyEBs5QchL1fVwjQ8SPZH9M
         oJTgvswR7b+dbhW5OI14W7Y6SxhtTROvYkORqjNb5GWBfAsRY9TYXbhadxuK9CEuRX
         Nm0rGVjFH96/g==
Date:   Sun, 10 Apr 2022 17:57:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio:dac:ad3552r: Fix an IS_ERR() vs NULL check
Message-ID: <20220410175756.29f7a1b2@jic23-huawei>
In-Reply-To: <PH0PR03MB6786CFA5554F79CCC3BA6FAF99E59@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220404114244.GA19201@kili>
        <PH0PR03MB6786CFA5554F79CCC3BA6FAF99E59@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Apr 2022 12:34:25 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Dan Carpenter <dan.carpenter@oracle.com>
> > Sent: Monday, April 4, 2022 1:43 PM
> > To: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan
> > Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org; Sa, Nuno
> > <Nuno.Sa@analog.com>; kernel-janitors@vger.kernel.org
> > Subject: [PATCH] iio:dac:ad3552r: Fix an IS_ERR() vs NULL check
> >=20
> > [External]
> >=20
> > The fwnode_get_named_child_node() function does not return error
> > pointers.  It returns NULL.  Update the check accordingly.
> >=20
> > Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

>=20
> >  drivers/iio/dac/ad3552r.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> > index 97f13c0b9631..59f49b7564b2 100644
> > --- a/drivers/iio/dac/ad3552r.c
> > +++ b/drivers/iio/dac/ad3552r.c
> > @@ -809,10 +809,10 @@ static int
> > ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
> >=20
> >  	gain_child =3D fwnode_get_named_child_node(child,
> >  						 "custom-output-range-
> > config");
> > -	if (IS_ERR(gain_child)) {
> > +	if (!gain_child) {
> >  		dev_err(dev,
> >  			"mandatory custom-output-range-config
> > property missing\n");
> > -		return PTR_ERR(gain_child);
> > +		return -EINVAL;
> >  	}
> >=20
> >  	dac->ch_data[ch].range_override =3D 1;
> > --
> > 2.20.1 =20
>=20

