Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0640275B692
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jul 2023 20:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGTSWk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jul 2023 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjGTSWk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2023 14:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2137270C
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2023 11:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57FDB61BA6
        for <linux-iio@vger.kernel.org>; Thu, 20 Jul 2023 18:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0327C433C8;
        Thu, 20 Jul 2023 18:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689877357;
        bh=JCFrWF6LZF3ews/t2IZbNyQhsKNYueVeilhyycYMMLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HxBiL6KnWgVkT/sZSPrH+PkQIrB7Gfmve84KU0E+3bVAtWiJtTE8BWxHJGnYJmYMF
         0Ku86swo8eggbPQZhPetTc1axofs8JzHlOrzdI4YH+ZBU03loxMx0zxtIByQxNuqgj
         FSMLfmARqFO1ZgiSJ4sVG43EAMD2diqEYPmPts40R1Gja6egF66FYTe7kJ7Plwlrql
         2/25IupIMJK16LosFSABwgCxDr/dQ+t9MDjJcos6Oj6RXLyL2aqLl++q+xvNC5a2pO
         Qewrc5wM21FSbDxdCwLDrhPNVOb00BEltFa5v2ex15Lz9L7NN+mQ5f8dRkjnzgfuo9
         irt3UUQKbLBOw==
Date:   Thu, 20 Jul 2023 19:22:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        "kernel test robot" <lkp@intel.com>,
        "Kim Seer Paller" <kimseer.paller@analog.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [jic23-iio:testing 6/10] drivers/iio/adc/max14001.c:135:13:
 warning: result of comparison of constant 18446744073709551615 with
 expression of type 'typeof (_Generic((mask), char: (unsigned char)0,
 unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned
 short: (un...
Message-ID: <20230720192230.38958380@jic23-huawei>
In-Reply-To: <20230720191838.73473d2c@jic23-huawei>
References: <202306211545.7b6CdqsL-lkp@intel.com>
        <CAHp75VcNj-P_WCvx2Pf9sj_ir2oKf2AZ-mdTP=KHSuPY7WcjeA@mail.gmail.com>
        <769e6521-a86d-4380-b27c-2ff29b795802@app.fastmail.com>
        <20230720191838.73473d2c@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Jul 2023 19:18:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 20 Jul 2023 11:29:55 +0200
> "Arnd Bergmann" <arnd@arndb.de> wrote:
>=20
> > On Wed, Jun 21, 2023, at 10:25, Andy Shevchenko wrote: =20
> > > On Wed, Jun 21, 2023 at 10:19=E2=80=AFAM kernel test robot <lkp@intel=
.com> wrote:   =20
> > >>
> > >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.gi=
t testing
> > >> head:   25e201cc6ff270abc062e13ff912292097cb2827
> > >> commit: d3e93b67f934a477c5851d575a2278f07c6242fb [6/10] iio: adc: ma=
x14001: New driver
> > >> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive=
/20230621/202306211545.7b6CdqsL-lkp@intel.com/config)
> > >> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project=
.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> > >> reproduce: (https://download.01.org/0day-ci/archive/20230621/2023062=
11545.7b6CdqsL-lkp@intel.com/reproduce)
> > >>
> > >> If you fix the issue in a separate patch/commit (i.e. not just a new=
 version of
> > >> the same patch/commit), kindly add following tags
> > >> | Reported-by: kernel test robot <lkp@intel.com>
> > >> | Closes: https://lore.kernel.org/oe-kbuild-all/202306211545.7b6Cdqs=
L-lkp@intel.com/
> > >>
> > >> All warnings (new ones prefixed by >>):   =20
> > >
> > > Okay, you even haven't compiled your code :-(
> > > This should probably use one of the functions from bitfield.h.
> > > Like u32_encode_bits().   =20
> >=20
> > I see the warning is now in linux-next. I see it only shows up with
> > clang and not gcc, but it would be nice to address it. =20
>=20
> Sorry, I managed to forget this one was still outstanding and picked up t=
he driver.
>=20
> >  =20
> > >   =20
> > >> >> drivers/iio/adc/max14001.c:135:13: warning: result of comparison =
of constant 18446744073709551615 with expression of type 'typeof (_Generic(=
(mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed cha=
r: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned sh=
ort)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: =
(unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned lon=
g long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsign=
ed int') is always false [-Wtautological-constant-out-of-range-compare]   =
=20
> > >>            reg_data =3D FIELD_PREP(mask, val);
> > >>                       ^~~~~~~~~~~~~~~~~~~~~
> > >>    include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_=
PREP'
> > >>                    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: =
");    \
> > >>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> > >>    include/linux/bitfield.h:71:53: note: expanded from macro '__BF_F=
IELD_CHECK'
> > >>                    BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask)=
 >     \
> > >>                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~^~~~~~~
> > >>    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD=
_BUG_ON_MSG'
> > >>    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
> > >>                                        ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~=
~~~
> > >>    include/linux/compiler_types.h:397:22: note: expanded from macro =
'compiletime_assert'
> > >>            _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
> > >>            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
> > >>    include/linux/compiler_types.h:385:23: note: expanded from macro =
'_compiletime_assert'
> > >>            __compiletime_assert(condition, msg, prefix, suffix)
> > >>            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >>    include/linux/compiler_types.h:377:9: note: expanded from macro '=
__compiletime_assert'
> > >>                    if (!(condition))                                =
       \
> > >>                          ^~~~~~~~~
> > >>    1 warning generated.   =20
> >=20
> > It looks like the problem is the use of FIELD_PREP() with a variable
> > 'val' instead of a constant. I tried marking the function __always_inli=
ne
> > so the compiler can see the actual value ('1') that gets passed in
> > as a constant, but that did not change anything.
> >=20
> >=20
> > It also looks suspicious that the value first gets read from the=20
> > register and then replaced with the FIELD_PREP() output, while the
> > original value gets discarded. Is this intentional? =20
>=20
> There are a lot of other fields in that register, so unlikely this was th=
e intent.
> A number of them default to non 0 as well.
>=20
> >=20
> >         ret =3D max14001_read(st, reg_addr, &reg_data);
> >         if (ret)
> >                 return ret;
> >         reg_data =3D FIELD_PREP(mask, val);
> >         ret =3D max14001_write(st, reg_addr, reg_data);
> >=20
> >=20
> > I have managed to shut up the warning by rearranging the code like:
> >=20
> > diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
> > index 18ace09601985..f2ce8f8947982 100644
> > --- a/drivers/iio/adc/max14001.c
> > +++ b/drivers/iio/adc/max14001.c
> > @@ -117,11 +117,9 @@ static int max14001_write_verification_reg(struct =
max14001_state *st,
> > =20
> >  static int max14001_reg_update(struct max14001_state *st,
> >                                 unsigned int reg_addr,
> > -                               unsigned int mask,
> > -                               unsigned int val)
> > +                               unsigned int reg_data)
> >  {
> >         int ret;
> > -       unsigned int reg_data;
> > =20
> >         /* Enable SPI Registers Write */
> >         ret =3D max14001_write(st, MAX14001_WEN, MAX14001_WRITE_WEN);
> > @@ -132,8 +130,6 @@ static int max14001_reg_update(struct max14001_stat=
e *st,
> >         if (ret)
> >                 return ret;
> > =20
> > -       reg_data =3D FIELD_PREP(mask, val);
> > -
> >         ret =3D max14001_write(st, reg_addr, reg_data);
> >         if (ret)
> >                 return ret;
> > @@ -299,7 +295,7 @@ static int max14001_probe(struct spi_device *spi)
> > =20
> >                 /* select external voltage reference source for the ADC=
 */
> >                 ret =3D max14001_reg_update(st, MAX14001_CFG,
> > -                                         MAX14001_CFG_EXRF, 1);
> > +                                         FIELD_PREP(MAX14001_CFG_EXRF,=
 1));
> > =20
> >                 if (ret < 0)
> >                         return ret; =20
>=20
> I'd prefer to just drop this reg_update function entirely.  Put the call =
inline
> so that we can use FIELD_PREP() directly rather than (after fixing the pr=
obably bug)
> passing in both the value and the mask.
>=20
> >=20
> > but it looks like there is still a bug in max14001_reg_update(),
> > so I'd prefer Kim Seer Paller to revisit this issue and submit
> > a properly tested patch. =20
>=20
> Absolutely agree.   If it's outstanding in few weeks though we can go
> with an educated 'guess' for the fix but I'd really rather not if Kim
> can post a fix in the meantime.
>=20
On closer inspection of my inbox, there are other reported problems that
need resolving so I'll do a rebase and drop the driver until this stuff is =
resolved.

Jonathan

> Jonathan
>=20
> >=20
> >        Arnd =20
>=20

