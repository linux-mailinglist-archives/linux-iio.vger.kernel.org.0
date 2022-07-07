Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4156A8B3
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jul 2022 18:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiGGQzk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Jul 2022 12:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiGGQzj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jul 2022 12:55:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27441D335
        for <linux-iio@vger.kernel.org>; Thu,  7 Jul 2022 09:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53D5462451
        for <linux-iio@vger.kernel.org>; Thu,  7 Jul 2022 16:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB3EC3411E;
        Thu,  7 Jul 2022 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657212937;
        bh=LT8YLOy27ve1wNMS3ukRQEHgRiHTMw+8RnNrw7KvIgE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WzC7TIzb3e8/x/b8RgkWzZpBpZupZHRHphd3sZ4TIW4n6MuDtg/0MJ7nDQcsLf1uQ
         6DBmvuLYcFN6Pd7FgNRMvkNorZgOvthSi9Dn79ftP1rv0bIoT5lmgYNyS9u05/AduT
         9W0w8QxTPM3DmtHl5vCs7Acx78fapPHQ7rNa5NWhgOgH5HJjrW+senBQrSv2h58yEY
         IMyOy4BY6rBTdWL2b++jqQen5NP8KtR6RTYBAwhIsUW/vaQiZodTPZKFBN0Ek6suxg
         2nGILCtRffn0rIgJ9bXq+8ZAnJec24TixxDcksXY7R+g771Yr8Qb2ZiQLFAjqeTBrU
         ZtXTneuWtwfVQ==
Date:   Thu, 7 Jul 2022 18:05:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ChiYuan Huang <u0084500@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: Add rtq6056 support
Message-ID: <20220707180521.5492a288@jic23-huawei>
In-Reply-To: <CAHp75VdM-Z_q8eCrpN_DC3GrRKt-UPCYNnw0VP0bj6zUcqtp5w@mail.gmail.com>
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
        <1656469212-12717-3-git-send-email-u0084500@gmail.com>
        <CAHp75Vd2bxFA5PmjEtgAjJfCf9YZENq_fb9b2VHmMmmHdqGJSw@mail.gmail.com>
        <CADiBU384ZwKL_+i1zRL9qfVt-NLo=pnf8zrGna4Sxt+toYZdWg@mail.gmail.com>
        <CADiBU3_sU8bj29x2Qs9y9fM2YDYcKvNBkBuzfpzuCkAjSeTu+Q@mail.gmail.com>
        <CAHp75VeiuJjiPFFh0pEGGH4+UEn0g5902UhAJL93Ho2WvH0_gg@mail.gmail.com>
        <CADiBU38FbZ87EHn_UDy-rS6V2bGDdLZJOcqNZsS03MzbNaVaKA@mail.gmail.com>
        <CAHp75VfyKtFQbcJJxW8TNSHMZppM6Qgj4hxiUzLB1bSmeWBBAg@mail.gmail.com>
        <CADiBU3_fZxCigiaa8mh9bHV565Bxiyux1a1zFWmi9v6xwdZzgQ@mail.gmail.com>
        <CADiBU3_qL1xf+VirMxD5q3wOH_UGSpXZi6pCjX2H44zbeXBqdg@mail.gmail.com>
        <CAHp75VdM-Z_q8eCrpN_DC3GrRKt-UPCYNnw0VP0bj6zUcqtp5w@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Jul 2022 13:01:43 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jul 5, 2022 at 12:33 PM ChiYuan Huang <u0084500@gmail.com> wrote:
> > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=885=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:30=E5=AF=AB=E9=81=93=EF=BC=
=9A =20
>=20
> ...
>=20
> > Sorry to bother you by the personal mail. =20
>=20
> No problem asking this in ML, it's normal development process.
> Moreover it's good that others may browse mail archives and find the
> answers. Private mails won't help in that sense. Hence Cc'ing mailing
> list again.
>=20
> > I try to put the 'align' in timestamp member.
> > checkpatch.pl show me the below warning.
> >
> > WARNING: Missing a blank line after declarations
> > #448: FILE: drivers/iio/adc/rtq6056.c:448:
> > + u16 vals[RTQ6056_MAX_CHANNEL];
> > + int64_t timestamp __aligned(8);
> >
> > WARNING: externs should be avoided in .c files
> > #448: FILE: drivers/iio/adc/rtq6056.c:448:
> > + int64_t timestamp __aligned(8);
> >
> > total: 0 errors, 2 warnings, 651 lines checked =20
>=20
> You may run `git grep -n 'align(8)'
>=20
> > Does it mean that I only can put the align for the whole struct? =20
>=20
> It means that checkpatch is full of false positives.

I fixed some of those in the past by fixing checkpatch, but I guess
not all of them...

>=20
> Btw, use s64 as a type for timestamp as it's more common.
>=20
> 1. Jonathan, shan't we unify this across the IIO drivers? It seems
> they are using (besides s64): int64_t, u64.

Should all be s64. Tidying that up would be good (be careful, there
are a few hardware timestamps where the format is defined by the
hardware though!)

>=20
> 2. Also:
>=20
> drivers/iio/light/vcnl4000.c:911:       u16 buffer[8] __aligned(8)
For these, what are you proposing changing?  Moving the __aligned earlier?

The oddity of all this lot is that the timestamp isn't at a fixed
location. It depends on what channels are enabled.  Hence we can't
enforce things via a more readable structure.

>=20
> drivers/iio/light/vcnl4035.c:106:       u8 buffer[ALIGN(sizeof(u16),
> sizeof(s64)) + sizeof(s64)]  __aligned(8);
>=20
> drivers/iio/light/si1145.c:190: u8 buffer[24] __aligned(8);
>=20
> // misplaced aligned()
> drivers/iio/adc/mt6360-adc.c-265-               u16 values[MT6360_CHAN_MA=
X];
> drivers/iio/adc/mt6360-adc.c-266-               int64_t timestamp;
> drivers/iio/adc/mt6360-adc.c:267:       } data __aligned(8);

This one is indeed a bug.

>=20
> drivers/iio/adc/stm32-adc.c:250:        u16
> buffer[STM32_ADC_MAX_SQ + 4] __aligned(8);
>=20
> drivers/iio/adc/mxs-lradc-adc.c:119:    u32
> buffer[10] __aligned(8);
>=20
> drivers/iio/adc/ti-adc0832.c:37:        u8 data[24] __aligned(8);
>=20
> drivers/iio/adc/ti-ads124s08.c:108:     u32
> buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u32)] __aligned(8);
>=20
> drivers/iio/amplifiers/ada4250.c:304:   u8 data[2] __aligned(8) =3D {};
>=20
> drivers/iio/chemical/atlas-sensor.c:95: __be32 buffer[6] __aligned(8);
>=20
> drivers/iio/health/afe4403.c:79:        s32 buffer[8] __aligned(8);
>=20
> drivers/iio/health/afe4404.c:95:        s32 buffer[10] __aligned(8);
>=20
> drivers/iio/imu/adis16475.c:107:        __be16
> data[ADIS16475_MAX_SCAN_DATA] __aligned(8);
>=20
> drivers/iio/imu/adis16480.c:174:        __be16
> data[ADIS16495_BURST_MAX_DATA] __aligned(8);
>=20
> drivers/iio/imu/bmi160/bmi160.h:19:     __le16 buf[12] __aligned(8);
>=20
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:568:     u8
> iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
>=20
> // ??? haven't checked context
> drivers/iio/light/acpi-als.c:65:        s32
> evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);
>=20
> drivers/iio/light/si1145.c:190: u8 buffer[24] __aligned(8);
>=20
> drivers/iio/magnetometer/rm3100-core.c:82:      u8
> buffer[RM3100_SCAN_BYTES] __aligned(8);
>=20
> drivers/iio/potentiostat/lmp91000.c:75: u32 buffer[4] __aligned(8);
>=20
> drivers/iio/pressure/mpl3115.c:160:     u8 buffer[16] __aligned(8);
>=20
> drivers/iio/proximity/isl29501.c:941:   u32 buffer[4] __aligned(8) =3D
> {}; /* 1x16-bit + naturally aligned ts */
>=20
>=20
> need conversion.
>=20
> 3. Why do we need explicit garbage in the code? :-)

If I recall correctly, because the hardware explicitly writes garbage into
that location during the read (it probably claims it's status flags
of some such, but as far as we are concerned it's garbage).

Note there is a nice comment just above this structure explaining why :)

Jonathan

>=20
> drivers/iio/light/rpr0521.c-204-                __le16 channels[3];
> drivers/iio/light/rpr0521.c-205-                u8 garbage;
> drivers/iio/light/rpr0521.c:206:                s64 ts __aligned(8);
>=20

