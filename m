Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD8591BED
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 18:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiHMQIm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 12:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiHMQIl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 12:08:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83667DEFD
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 09:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DBABB80688
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 16:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0AEC433D6;
        Sat, 13 Aug 2022 16:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660406918;
        bh=nEMYYLF0TpNV/Jh8EpznLfbNWzUr8wk5IcVyV0PZniw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZBcadL+E2y4Aontp271MfUIwDL7OOIzDeG3hBzncizd34KV0MilJNYWs+ONDn4HDq
         /r2FT2PkrPcSR/I1Ce/mu0emSrbwvaYkH1bI2bK5yl6Tlt0SwQEDhgHIY9grl2WD8/
         lZH9Frgsej3A785yfkct7/JlPUicp1W1JKPHv5tED8/69jah9V2OsZX15YI/WCvYyS
         s8HfsSDHEGEq2gZDgUEeP94VROFb1Bay8NApzvi4Ozd9aEtj0lIYdb7htLdBFVfoAI
         aCJToqJCbtRB1Z20mzAnmETJh6aLwlO61S7eKRFTQUvU5ABV3hSnPnhwpFzilArrRX
         1Sljw/zUvVoEQ==
Date:   Sat, 13 Aug 2022 17:19:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 04/13] iio: adc: ingenic-adc: Benefit from
 devm_clk_get_prepared() to simplify
Message-ID: <20220813171904.3331721d@jic23-huawei>
In-Reply-To: <20220809053740.wtjkzrjzujc6gdry@pengutronix.de>
References: <20220808204740.307667-1-u.kleine-koenig@pengutronix.de>
        <20220808204740.307667-4-u.kleine-koenig@pengutronix.de>
        <CAHp75Vf=ab3AYn+9dys7vDOr7yBY0cdquE0bMVdZmSk31b5KKw@mail.gmail.com>
        <20220809053740.wtjkzrjzujc6gdry@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 9 Aug 2022 07:37:40 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hello Andy,
>=20
> On Mon, Aug 08, 2022 at 11:01:39PM +0200, Andy Shevchenko wrote:
> > On Mon, Aug 8, 2022 at 10:47 PM Uwe Kleine-K_nig
> > <u.kleine-koenig@pengutronix.de> wrote: =20
> > >
> > > Make use of devm_clk_get_prepared() to replace some code that effecti=
vely
> > > open codes this new function. =20
> >=20
> > Copy'n'paste typo in the Subject. =20
>=20
> Good catch, thanks. I fixed it in my private tree, so it will be fixed
> on resend. The Subject is now:
>=20
> 	iio: adc: ingenic-adc: Benefit from devm_clk_get_prepared() to simplify
>=20
> Will wait a while for that though, maybe Jonathan will take
> care when applying without me resending. I also adapted the subject of
> this reply, I wonder if that does more good or more harm :-)

I tweaked it whilst applying to be as above.

Thanks,

Jonathan

>=20
> Best regards
> Uwe
>=20

