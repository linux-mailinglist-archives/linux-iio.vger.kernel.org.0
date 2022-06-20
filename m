Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86C35524EB
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 22:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiFTUBM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 16:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFTUBL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 16:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D991CB0F
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 13:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B1826165A
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 20:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BD7C3411B;
        Mon, 20 Jun 2022 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655755269;
        bh=og1nf8zR9WFzNGW4XGzNuCAvcdmYIjHMDBbdsycQtWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W/InKpF+cVYWNcF4klV/WtypPJkuDoZf7bSpJitSd6ChiRspIDBPUxe9z37HuQR1s
         hroYyKtlHqK0LxV/UeNuzCUCy4r+l4EHZuQrDvWO60I3Z7UAP6hYNVYQLy3uIM/fcK
         nXnOgE1xE5Yk+Huxzx/FY6NTFEf2UHid2TIZ/sCBrTRNpZkRhuVMtjjIJDUiPKVnUT
         VGhhrmwhL9MDXAOapppKHHTfwfNUiCthRpr1f1a8O8YU6ezePuPbAWInwxgj5g8PK7
         IpPaB+aQftTLvPYwAMTtsARbTLBN7F4ryKe20lFUhJLKE326+yAA7rOx3zVNQTKvRB
         ujyFOf6CHuzSw==
Date:   Mon, 20 Jun 2022 21:01:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 11/17] iio: core: Introduce _inputoffset for
 differential channels
Message-ID: <20220620210103.30504288@jic23-huawei>
In-Reply-To: <CAHp75VfCydyRKzbzS5Wpsqcm+fiNrz7EWm=+buct=Fe4m9X8bQ@mail.gmail.com>
References: <20220619185839.1363503-1-jic23@kernel.org>
        <20220619185839.1363503-12-jic23@kernel.org>
        <CAHp75Vdf3aWaeT17cxsm=a7LUSpc1LnoMGkRQS8O_3ftufprLg@mail.gmail.com>
        <20220620191307.7f8fefa7@jic23-huawei>
        <CAHp75VfCydyRKzbzS5Wpsqcm+fiNrz7EWm=+buct=Fe4m9X8bQ@mail.gmail.com>
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

On Mon, 20 Jun 2022 20:35:57 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jun 20, 2022 at 8:13 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 20 Jun 2022 01:20:08 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
>=20
> ...
>=20
> > So to try and explain what this is doing in more depth.
> >
> > This is basically applying a negative offset X to both the P(ostitive) =
and
> > N(egative) lines. Hence
> >
> > measured capacitance =3D (P - X) - (N - X)
> >                      =3D P - N
> >
> > the aim of X being to keep the signal hitting some internal point on
> > the device within a range that is measurable.
> >
> > The relevant text on the datasheet is:
> >
> > "The CAPDAC can be understood as a negative capacitance
> > connected internally to the CIN pin."
> >
> > "Each of the two input capacitances CX and CY between the EXC
> > and CIN pins must be less than 4 pF (without using the
> > CAPDACs) or must be less than 21 pF and balanced by the
> > CAPDACs. Balancing by the CAPDACs means that both
> > CX=E2=80=93CAPDAC(+) and CY=E2=80=93CAPDAC(=E2=80=93) are less than 4 p=
F."
> >
> > So basically if you have both sides of the differential pair
> > that are too large (>4 pF) then you can drag them together
> > down to that range by adding negative capacitance. =20
>=20
> Ah, in a long wording it's "measurement window offset". Dunno how to
> make it shorter.
> Also, 0-point on the axis in math.
>=20
Hmm. Both good descriptions so I'll add something along these lines
to the description.

Characters are cheap aren't then? :)

in_capacitanceY-capacitanceZ_zero_point
isn't too bad - will think more.  No connection to offset which is
what it would be for a single ended channel though...

Jonathan

