Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A78F5668D7
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jul 2022 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiGELC0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jul 2022 07:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiGELCX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jul 2022 07:02:23 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F9A2BD
        for <linux-iio@vger.kernel.org>; Tue,  5 Jul 2022 04:02:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r3so21144992ybr.6
        for <linux-iio@vger.kernel.org>; Tue, 05 Jul 2022 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sRcyYznFCmNnrzd03wHMAFc3YVrFb2+fzENEmHCUjTc=;
        b=ToLTDVQd7d0gleZwwEtrrARMwi9GPh2j7xTretoVhQCxuGHODN+WTdKBWH5CFw5Yrj
         qw8npf50yd8amq3PVrGDqButgVjmNo9R6EyOC0kmb5WdwFMDSUj1/RyFM/aMFUg58wJg
         4BB0S+xSg2fwxm9GltgKEKptqRJqI1fC0sEhg2zvA+ilVnM8KDsMGi5letzkgvMbtOz2
         Cm3BInqFzJOdzY0pI7wkO1l1cS0885trCGKnhxCHXeo5THQQ0LYuh2OwbvJvtpJle8dQ
         YsIn5FvPiAW0IjykRgkkkOtphzSCgsa2jcPQx+4tta36D4/kMU06QRcWyjqV9ZwiDz66
         gNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=sRcyYznFCmNnrzd03wHMAFc3YVrFb2+fzENEmHCUjTc=;
        b=lb9NIhhcwYeR7IXIFPl2aa9enig1+5XpgoLZD14Ed5fIQh0faEhgivIkQNqYSvs701
         6nEupPl0snzyUjQDcHNSoWxEbuFGgSUQIxhGck5AgFAAWtyfQcv8Ighm3UXvs3z2f1sJ
         OOpL39l9OnfvyjfZnROZU2hH3xQf/rBCSUA0TeT8py9ezH1yQb7aSv51rXzbM6Ey6mm5
         Zmo2WYTiK7fIMVIdpqY5gWiCITVrGEHBuHUW76pCHj9uY3WaANP1XFkSXftTkCg46G0t
         JTrVfP/NF3LoycE2uMn7CIV6FF0xp8JYsjXqx7nHJNSgjAat54GHLTK9vaqTo0dp4gGh
         FUrQ==
X-Gm-Message-State: AJIora8GwV2gNTI7xT9JIgc2ofBI25x9isJ/du4thdFxxu3RH3YWJ7JN
        YvYmsrlAMkURVKxiBBMyxlYtGZGXDX1IV/IO0GR89anTZo8F/3+w
X-Google-Smtp-Source: AGRyM1vzbDVkADc/1kxStzafb6V2ifx+urSRRGodGjEyghnU3XWa++/2k3+Y6Jd3MP7XzhXGfIW+es1heB4Rk4vnx5k=
X-Received: by 2002:a05:6902:154c:b0:66e:8254:146e with SMTP id
 r12-20020a056902154c00b0066e8254146emr1094312ybu.570.1657018940015; Tue, 05
 Jul 2022 04:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
 <1656469212-12717-3-git-send-email-u0084500@gmail.com> <CAHp75Vd2bxFA5PmjEtgAjJfCf9YZENq_fb9b2VHmMmmHdqGJSw@mail.gmail.com>
 <CADiBU384ZwKL_+i1zRL9qfVt-NLo=pnf8zrGna4Sxt+toYZdWg@mail.gmail.com>
 <CADiBU3_sU8bj29x2Qs9y9fM2YDYcKvNBkBuzfpzuCkAjSeTu+Q@mail.gmail.com>
 <CAHp75VeiuJjiPFFh0pEGGH4+UEn0g5902UhAJL93Ho2WvH0_gg@mail.gmail.com>
 <CADiBU38FbZ87EHn_UDy-rS6V2bGDdLZJOcqNZsS03MzbNaVaKA@mail.gmail.com>
 <CAHp75VfyKtFQbcJJxW8TNSHMZppM6Qgj4hxiUzLB1bSmeWBBAg@mail.gmail.com>
 <CADiBU3_fZxCigiaa8mh9bHV565Bxiyux1a1zFWmi9v6xwdZzgQ@mail.gmail.com> <CADiBU3_qL1xf+VirMxD5q3wOH_UGSpXZi6pCjX2H44zbeXBqdg@mail.gmail.com>
In-Reply-To: <CADiBU3_qL1xf+VirMxD5q3wOH_UGSpXZi6pCjX2H44zbeXBqdg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 13:01:43 +0200
Message-ID: <CAHp75VdM-Z_q8eCrpN_DC3GrRKt-UPCYNnw0VP0bj6zUcqtp5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add rtq6056 support
To:     ChiYuan Huang <u0084500@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 5, 2022 at 12:33 PM ChiYuan Huang <u0084500@gmail.com> wrote:
> ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=885=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:30=E5=AF=AB=E9=81=93=EF=BC=9A

...

> Sorry to bother you by the personal mail.

No problem asking this in ML, it's normal development process.
Moreover it's good that others may browse mail archives and find the
answers. Private mails won't help in that sense. Hence Cc'ing mailing
list again.

> I try to put the 'align' in timestamp member.
> checkpatch.pl show me the below warning.
>
> WARNING: Missing a blank line after declarations
> #448: FILE: drivers/iio/adc/rtq6056.c:448:
> + u16 vals[RTQ6056_MAX_CHANNEL];
> + int64_t timestamp __aligned(8);
>
> WARNING: externs should be avoided in .c files
> #448: FILE: drivers/iio/adc/rtq6056.c:448:
> + int64_t timestamp __aligned(8);
>
> total: 0 errors, 2 warnings, 651 lines checked

You may run `git grep -n 'align(8)'

> Does it mean that I only can put the align for the whole struct?

It means that checkpatch is full of false positives.

Btw, use s64 as a type for timestamp as it's more common.

1. Jonathan, shan't we unify this across the IIO drivers? It seems
they are using (besides s64): int64_t, u64.

2. Also:

drivers/iio/light/vcnl4000.c:911:       u16 buffer[8] __aligned(8)

drivers/iio/light/vcnl4035.c:106:       u8 buffer[ALIGN(sizeof(u16),
sizeof(s64)) + sizeof(s64)]  __aligned(8);

drivers/iio/light/si1145.c:190: u8 buffer[24] __aligned(8);

// misplaced aligned()
drivers/iio/adc/mt6360-adc.c-265-               u16 values[MT6360_CHAN_MAX]=
;
drivers/iio/adc/mt6360-adc.c-266-               int64_t timestamp;
drivers/iio/adc/mt6360-adc.c:267:       } data __aligned(8);

drivers/iio/adc/stm32-adc.c:250:        u16
buffer[STM32_ADC_MAX_SQ + 4] __aligned(8);

drivers/iio/adc/mxs-lradc-adc.c:119:    u32
buffer[10] __aligned(8);

drivers/iio/adc/ti-adc0832.c:37:        u8 data[24] __aligned(8);

drivers/iio/adc/ti-ads124s08.c:108:     u32
buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u32)] __aligned(8);

drivers/iio/amplifiers/ada4250.c:304:   u8 data[2] __aligned(8) =3D {};

drivers/iio/chemical/atlas-sensor.c:95: __be32 buffer[6] __aligned(8);

drivers/iio/health/afe4403.c:79:        s32 buffer[8] __aligned(8);

drivers/iio/health/afe4404.c:95:        s32 buffer[10] __aligned(8);

drivers/iio/imu/adis16475.c:107:        __be16
data[ADIS16475_MAX_SCAN_DATA] __aligned(8);

drivers/iio/imu/adis16480.c:174:        __be16
data[ADIS16495_BURST_MAX_DATA] __aligned(8);

drivers/iio/imu/bmi160/bmi160.h:19:     __le16 buf[12] __aligned(8);

drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:568:     u8
iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);

// ??? haven't checked context
drivers/iio/light/acpi-als.c:65:        s32
evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);

drivers/iio/light/si1145.c:190: u8 buffer[24] __aligned(8);

drivers/iio/magnetometer/rm3100-core.c:82:      u8
buffer[RM3100_SCAN_BYTES] __aligned(8);

drivers/iio/potentiostat/lmp91000.c:75: u32 buffer[4] __aligned(8);

drivers/iio/pressure/mpl3115.c:160:     u8 buffer[16] __aligned(8);

drivers/iio/proximity/isl29501.c:941:   u32 buffer[4] __aligned(8) =3D
{}; /* 1x16-bit + naturally aligned ts */


need conversion.

3. Why do we need explicit garbage in the code? :-)

drivers/iio/light/rpr0521.c-204-                __le16 channels[3];
drivers/iio/light/rpr0521.c-205-                u8 garbage;
drivers/iio/light/rpr0521.c:206:                s64 ts __aligned(8);

--=20
With Best Regards,
Andy Shevchenko
