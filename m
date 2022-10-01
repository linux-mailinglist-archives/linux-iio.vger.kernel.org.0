Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAAC5F1E73
	for <lists+linux-iio@lfdr.de>; Sat,  1 Oct 2022 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJARnz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Oct 2022 13:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJARnu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2022 13:43:50 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0422509
        for <linux-iio@vger.kernel.org>; Sat,  1 Oct 2022 10:43:48 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id j8so4710936qvt.13
        for <linux-iio@vger.kernel.org>; Sat, 01 Oct 2022 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BVwqJJ+mZiKSxFSeUZO+7zrH1+FHwwhD3golEmbbd2A=;
        b=ygnxlUP+fQ/bixWMa+pWc2qSlRAGNPHg12Oih67c6Rd84wONBTzO5CiiBFg0CHWXBP
         NEwATWHYsCX/P7rOTLkL8mNCJiVYiEFGV+IZqTkAdUIIhi8qKLaugLtQXG2iNbmBFE8W
         XJ8Z5TJu/erIhenaWFbXdNO21au7RZ9iv/nDNwCFstYCuq9R3PgER1t4drKMABhCEShq
         MMWhsKxgj7WBgU2cZrrQjw9CaGZKrBA2yyHRq7hGIUXXljSL4EF50VPRTAV/AsoiaRci
         ae80CXk+3ofmzdIVWp889mT+etaBws9stIUq8VtZqD2/jcWXTLqiSe25z+VFkVwOxuWz
         plaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BVwqJJ+mZiKSxFSeUZO+7zrH1+FHwwhD3golEmbbd2A=;
        b=Xixz4lqhr52bt7a0HDAi4MKH/GuGySIS4NB5WHaMAbSNLI19RrR7Ba1DPRrueLzvit
         m07kD+YBtHpL5tx9EOOUFWLz661i2pV/nB47DisezDg7A4l3lI4l0FPV6ccciUIq9e4a
         86IuQrVoZWK9lj8ivpJ1x3plXRP6uLmamQuJaoxOvs8HAUHNVzzOIN+8M6tkmcY3mj6s
         PWvo5ia+lauGR+4M6GyKT6OWXgkUHqEp1SH1DwIKtSHNRVe+vPlJYcwzHVNle2XomxQK
         IK1wWxSA9+NWGmrU1xCKK6Oq3pnSgpyQNAlnEjeDHyCGIGK/QRq4c+kMFjBLvPeClZKn
         rjIg==
X-Gm-Message-State: ACrzQf3ohzaT6dtaJdij0v9hAB7KrQ2C27PbnpzzoyNHtJQ8uihx1MWW
        SjDhUzdPhHc8y/Wn0Vme2+j+kQ==
X-Google-Smtp-Source: AMsMyM7VndfNVTNEe93pBgRrgyxKkYAomOcS1tqtDi0eS3dKmWvBkKLypUNNnf7T9Nu4ca8bD4tCIQ==
X-Received: by 2002:ad4:4ee6:0:b0:4b1:80a5:49e3 with SMTP id dv6-20020ad44ee6000000b004b180a549e3mr1940183qvb.67.1664646227167;
        Sat, 01 Oct 2022 10:43:47 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a415300b006ce60f5d8e4sm6387517qko.130.2022.10.01.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 10:43:46 -0700 (PDT)
Date:   Sat, 1 Oct 2022 13:43:44 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <wbg@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Message-ID: <Yzh8ULruBgN1tf+L@fedora>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzd0YAWG/W9RNLQA@ishi>
 <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzhzZiZYEKuVX3eZ@fedora>
 <OS0PR01MB5922421ED17EEF758C6C319586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+5J+JJlLnn4OQztr"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922421ED17EEF758C6C319586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--+5J+JJlLnn4OQztr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 01, 2022 at 05:12:56PM +0000, Biju Das wrote:
> > > > You can then control the phase selection using a top-level Counter
> > > > device extension (e.g. /sys/bus/counter/devices/counter0/phase)
> > that
> > > > configures whether you're in 16-bit phase or 32-phase counting
> > mode.
> > >
> > > So I need to introduce a new sysfs called phase. Use that one for
> > > Selecting the external clock pin for phase counting mode.
> > > Please correct me if I am wrong??
> > >
> > > Hardware supports 4 pins for phase counting mode,
> > >
> > > MTCLKA Input External clock A input pin (MTU1/MTU2 phase counting
> > mode
> > > A phase input) MTCLKB Input External clock B input pin (MTU1/MTU2
> > > phase counting mode B phase input) MTCLKC Input External clock C
> > input
> > > pin (MTU2 phase counting mode A phase input) MTCLKD Input External
> > > clock D input pin (MTU2 phase counting mode B phase input)
> > >
> > > For MTU1, it is fixed MTCLKA and MTCLKB.
> > > But for MTU2, it can be either 0-{ MTCLKA, MTCLKB} or 1 - { MTCLKC ,
> > > MTCLKD} On reset it is set to { MTCLKC , MTCLKD}.
> > >
> > > Cheers,
> > > Biju
> >=20
> > It doesn't need to be named "phase" specifically, but it seems like a
> > new sysfs file will be necessary in order to select the proper phase
> > counting mode.
> >=20
> > Are these MTCLK signals the quadrature A and B Signals you defined in
> > the counter driver?
>=20
> Yes, that is correct.
>=20
> Cheers,
> Biju

You should define a Signal then for each of the four MTCLK inputs.
Create synapse arrays for each Count respectively; e.g. Count 0 will
have Synapses for MTCLKA and MTCLKB, but Count 1 will probably need
Synapses for all four Signals (the action mode for two of them will be
COUNTER_SYNAPSE_ACTION_NONE depending on the configuration set).

What is the configuration when 32-bit phase counting mode is selected?
Does MTCLKA and MTCLKB serve as the counting signals in this case, with
overflows on the MTU1 register incrementing the MTU2 register?

William Breathitt Gray

--+5J+JJlLnn4OQztr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYzh8UAAKCRC1SFbKvhIj
K384AQCg+5i2BlAc5aBMMoVp8hL28Jm/7uJBvvfEONCCbqWzVwEA6IxGEGQNXreD
TEIlRDmRIAlLZ2Z8YxGRpwloSCrHxQI=
=0pjL
-----END PGP SIGNATURE-----

--+5J+JJlLnn4OQztr--
