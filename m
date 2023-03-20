Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEA66C1C22
	for <lists+linux-iio@lfdr.de>; Mon, 20 Mar 2023 17:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjCTQkm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Mar 2023 12:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjCTQjx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2023 12:39:53 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1D3CA16
        for <linux-iio@vger.kernel.org>; Mon, 20 Mar 2023 09:35:11 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t9so13753998qtx.8
        for <linux-iio@vger.kernel.org>; Mon, 20 Mar 2023 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679330108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3wG6rEfzY3a/pPPHxhzV3pI6TX/R3uM7yxw4I2R1k0=;
        b=ZTEeMKkZFBFtosRuB5/lHIz1G5ZdZXcNwFy+JH2tMAIPpYPcCVjDJuAZux352izzsc
         8N3GrVNhOwS7mHH5maW9qck7A1QTMdHpK/+LS9PYxMV61XY+Mk4BH9taKrFriVtQ1eRi
         faZnkukqj3dDci3nv8RbQByxS1Dn7ACcTrtPXE/zhPitn9mV58LuS9dcLrHTtA9U/g4k
         QQROYpbpWoUbKeWfk415iEPuflomY6Os6VwrZuEXcuhvHV2ycFH9Pbay6OVwx9DwG2UM
         ZkvBCVNp4tA+z3oDurzuBnNLf/HpU2fCSJe4aOOWa/3kxqeQZIJ8qW0JRyx/6KZ1x3Hy
         ZxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679330108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3wG6rEfzY3a/pPPHxhzV3pI6TX/R3uM7yxw4I2R1k0=;
        b=eX5Qu6R8yalbZqesQLdwMBA5EpsIN+kZQ3ZkwV1VE0mFjvAVLZivu1PjqD2aQ846zk
         umqXvOVM0/z1Gd+ldg5IY12JqTr0IDC1vIQnlP3086p8yPHN+VoQD2X3Gy80LJqertyF
         ffiNk7uzKAw1JqX6w/4i7J87nZcemeSJuXepTumu1tONU5RxiLWw5u5ChDULR+taj//i
         PoGVeOUIs/ViQIWwow1aTTV0wBdQhBbiqv7BaCBDi+lrTXRH9DILp0Knb5gWkF0kBA57
         z11f00aWs+ccqbxTdBY4xOLUlI0SBDyQWfypUq7FMupyUUhRLmB4MdeBq+ZjHvwrlKMT
         9Kig==
X-Gm-Message-State: AO0yUKWqObOmwKWE29eil0fJcapZ8X1DHrpiCm2KF+1ur0ZzNOkR9FKr
        AScZLBQmCMYAV3/VxSxk74ywPsYzY8buy6Ah26s=
X-Google-Smtp-Source: AK7set+xax6n8qp1G3k+YetjEstKFTYXkszcVMuMHXBSmSur5d4Z36t55MigotMfZf4+7+0o/ODrQg==
X-Received: by 2002:a05:622a:156:b0:3bf:ce2f:576c with SMTP id v22-20020a05622a015600b003bfce2f576cmr28848579qtw.66.1679330108375;
        Mon, 20 Mar 2023 09:35:08 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id w5-20020ac86b05000000b003b9bca1e093sm6832663qts.27.2023.03.20.09.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:35:07 -0700 (PDT)
Date:   Mon, 20 Mar 2023 12:35:05 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: addac: stx104: Migrate to the regmap API
Message-ID: <ZBiLOWI+0JIWv6BC@fedora>
References: <20230319202256.352939-1-william.gray@linaro.org>
 <ZBiBBJOmjOAHGUn0@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mo70mDQ9Y5gMfduf"
Content-Disposition: inline
In-Reply-To: <ZBiBBJOmjOAHGUn0@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Mo70mDQ9Y5gMfduf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 05:51:32PM +0200, Andy Shevchenko wrote:
> On Sun, Mar 19, 2023 at 04:22:56PM -0400, William Breathitt Gray wrote:
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver.
>=20
> ...
>=20
> > -/**
> > - * struct stx104_iio - IIO device private data structure
>=20
> I believe this...
>=20
> > - * @chan_out_states:	channels' output states
> > - * @reg:		I/O address offset for the device registers
> > - */
>=20
> > -struct stx104_iio {
>=20
> ...and this can be left here. With that the diff won't be too disrupted.

You're right Andy, I'll adjust this in v2 so the diff becomes clearer
(along with some bitfield API adjustments).

William Breathitt Gray

--Mo70mDQ9Y5gMfduf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZBiLOQAKCRC1SFbKvhIj
K4mhAP0X4e0URt1B/OmADC0I6wHTfGwBjKH5mtvHT1WW1wuHigEA61l1xgzekaCf
trv33LQPL/2RPR54pEiYhuTyf6u/+gw=
=KM3F
-----END PGP SIGNATURE-----

--Mo70mDQ9Y5gMfduf--
