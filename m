Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6564F06F
	for <lists+linux-iio@lfdr.de>; Fri, 16 Dec 2022 18:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiLPRgf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Dec 2022 12:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiLPRge (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Dec 2022 12:36:34 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019F013E8B
        for <linux-iio@vger.kernel.org>; Fri, 16 Dec 2022 09:36:33 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id i20so3226436qtw.9
        for <linux-iio@vger.kernel.org>; Fri, 16 Dec 2022 09:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4pssHlaurFy+yHylp1RetjEoSDxyKlWcye0Bd6YO+PM=;
        b=sSDTcVL7SWkVVYAAG359XTSNuOodfZHOvXklEoxMmZ6qcv9rkVm3I2sxVHrv84InIP
         Nj/hD11glEBI0iToWAUq94Y4KYGK7ScRckmOIqpihPpr2UG5fIIyn4WNMmyq5uviu063
         gdICBNWPel1bFf2aaEWoG5EdaPi6uN+DhAh8nEd7XtElaqmAdhIZlVKRKbyol6Vb7HhR
         QTh0gL/QeeGri/0mzayefrvpkxX4N13mssIW8OY+czlhvCL37+BoIDNbEYcJ3TVdYT2/
         uOJdpC7r4u6hfrTPpz8wIQUK9ggfPUyKAUFzjCU/bpSJrrVrO25GKiTpjBk8AFNXVwtt
         Np+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pssHlaurFy+yHylp1RetjEoSDxyKlWcye0Bd6YO+PM=;
        b=Rs+5iGndDEU5l18KLXsQifHk0Wzwx5F0hqWVTZxdV952wEeIH4/kye2sZGyNPaXxQs
         HsgRL90Pzo9y1Qx6p9TTvzlstu5BlzjCjzB68cLc2qXQ5PrnGOSgumLRUxZmAGaLJMRG
         2o/iCrne4dbUi113cJHa2iPem16eLNl1iJ0R34UIboFWky1AIf11QJ34QHGL8njR1lYQ
         ZzElByXvP8YIXKnlFdjmxYSWhA2uo/3CeCRs10Kw6x89ucfqPO7dMM+ebSlf8mDJdWPy
         RLTBjoBbNGajamme19IUS6h433eYVqbatER5jTABTaDgHsCzu8j3ZcxyNFPYT2TbbG2k
         VRcw==
X-Gm-Message-State: ANoB5pkp6LRg8V92fbv6Z3bVMZWGnZx/bAHolzLcwvRoHYLGfUY3s5Gn
        Gmzsdg9N5Qa26PAskTFBk1Njaw==
X-Google-Smtp-Source: AA0mqf7RD4ApYh6V7fu5AVdjcuL66DWwzIMynb+vUwR3m01LUu6yNWASW5Rsa4PwDXCOdEIQ5r03DQ==
X-Received: by 2002:a05:622a:1652:b0:3a8:1600:e60f with SMTP id y18-20020a05622a165200b003a81600e60fmr42770503qtj.14.1671212192141;
        Fri, 16 Dec 2022 09:36:32 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b24-20020ac844d8000000b0035badb499c7sm1650729qto.21.2022.12.16.09.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:36:31 -0800 (PST)
Date:   Fri, 16 Dec 2022 12:34:53 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y5ysPT3wrc7h9x2T@fedora>
References: <20221214103136.2493474-1-biju.das.jz@bp.renesas.com>
 <20221214103136.2493474-5-biju.das.jz@bp.renesas.com>
 <Y5yWdiAsMIUn9ehm@fedora>
 <OS0PR01MB5922FB904619669BE9DD85A086E69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Y5ynT6h/cZwXcMxz@fedora>
 <OS0PR01MB5922D9A52A0A6D01B73503D686E69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o6A1WOe2R6/9cfaY"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922D9A52A0A6D01B73503D686E69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--o6A1WOe2R6/9cfaY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2022 at 05:24:02PM +0000, Biju Das wrote:
> Hi William Breathitt Gray,
>=20
> > Subject: Re: [PATCH v9 4/5] counter: Add Renesas RZ/G2L MTU3a counter d=
river
> >=20
> > On Fri, Dec 16, 2022 at 05:00:30PM +0000, Biju Das wrote:
> > > > Hello Biju,
> > > >
> > > > Do you need to take the ch->lock before checking ch->is_busy to
> > > > ensure it does not change?
> > >
> > > priv->count_is_enabled[count->id]-> true means channel is held by cou=
nter.
> > > So pwm won't be able to change the state ch->is_busy.
> > >
> > > priv->count_is_enabled[count->id]-> false and if there is contention
> > > priv->for ch->busy
> > > whoever is first calling rz_mtu3_request_channel() will get the chann=
el.
> > > among pwm_request and counter_enable.
> > >
> > > So I think it is safe here. Please correct me if I am missing somethi=
ng.
> > >
> > > static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
> > > {
> > > 	bool is_idle;
> > >
> > > 	mutex_lock(&ch->lock);
> > > 	is_idle =3D !ch->is_busy;
> > > 	if (is_idle)
> > > 		ch->is_busy =3D true;
> > > 	mutex_unlock(&ch->lock);
> > >
> > > 	return is_idle;
> > > }
> >=20
> > Okay seems safe then. If the respective count_is_enabled will only be t=
rue
> > when the respective channel is held by the counter, is there a need to =
check
> > ch->is_busy, or would checking count_is_enabled alone suffice?
>=20
> We still can configure below properties before enabling the count.
> That can be done only when ch->is_busy =3D false or ch->is_busy=3D true a=
nd count_is_enabled.
> That is channel is used by the counter.
>=20
> /sys/bus/counter/devices/counterX/external_input_phase_clock_select
> /sys/bus/counter/devices/counterX/long_word_access_ctrl_mode
> /sys/bus/counter/devices/counterX/count2/count
> /sys/bus/counter/devices/counterX/count2/ceiling
>=20
> Cheers,
> Biju

I see what you mean now, we'll need to check ch->is_busy regardless and
not just the count_is_enable state. That should be fine then, thanks for
explaining.

William Breathitt Gray

--o6A1WOe2R6/9cfaY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY5ysPQAKCRC1SFbKvhIj
K3BjAQCQVhy6SLf8LTRbw6I9NAXok8+Z0oTHxLOKkXM09bdy7QEAp2EDtXC/diiM
lOYzfBTqC7C9NeBG3zqmdsksI6ADsQA=
=k6Sp
-----END PGP SIGNATURE-----

--o6A1WOe2R6/9cfaY--
