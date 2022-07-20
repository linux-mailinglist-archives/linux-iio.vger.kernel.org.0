Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDA57B3C2
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jul 2022 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiGTJYq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jul 2022 05:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbiGTJYo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2022 05:24:44 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E57E4D152
        for <linux-iio@vger.kernel.org>; Wed, 20 Jul 2022 02:24:42 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id r24so6306800qtx.6
        for <linux-iio@vger.kernel.org>; Wed, 20 Jul 2022 02:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=CnzhhNtJDWCgWALBDXZofoZTlHHRw14TCvwhMPGsBwo=;
        b=GYrTayH+1D8/0rDVhvA2BQ/ttvCx6rTvjEesouHmkch1R/xo2PcTmTMrFAS5fvEr3F
         2PlI06U9Z70R/2nXtYhStssbGIPDLT53NoW81QTJ1UXw06yDuBIFhvZs1Pr5SmbOUZVl
         +hw4sn0uk1R4/dxNQo4lGdRAKDLDOHpaobax4ylHL1xdMqz07T8fV0ZdbCD0/7AWb5fu
         UkrlPSyex6Mom5EuPIMMVubUxzl8inLXn8eCooe+u2oZbxhdpqoT3g3BYOT4t1S3kHiW
         v3WN5N6HGoMNvs6T/n17KYGDW04GcaeA1ugYK256sFa4W4ZnPVfFcyX/32zZB6hHamFS
         YI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=CnzhhNtJDWCgWALBDXZofoZTlHHRw14TCvwhMPGsBwo=;
        b=21KvKVaZjkksOIzyJP3220XTo//aFL2NaxREcTrfy7DQiBbO3XBOT2jL7246IIGr/+
         7YP8sLrkNzBHvjl6OJZR3W9vnJQy4wISgkKpCTKLjYzT0nXxIyH+NFCsVrpKg3I38Mq1
         bgoAuxSAPPfq7589IlggoSJDuuTXXaP0Jm10JPqPoCL4dC8s8fadaPAH1izopUeYrQxG
         Wnz1uLGMFiJh2e6FH2SXfU5C8CSBmwBIj2Vn3BbuKU82hYAP6Y+bKqEA8en6M5PRAgu2
         EnnS2mXJXIj0+l/KSdLLCFv0PtFj3vJtxH9ng0oHxK1SMWUxzS5ydLdSPExI0cJVK6MX
         RHAg==
X-Gm-Message-State: AJIora9yNzgJv4EXjXrPvXO0J+W5hPVePvtLbOPUq6USmmmoLQ6jrZz2
        yHp8CMOlXE8+McrWWc6vyz8=
X-Google-Smtp-Source: AGRyM1tk2Y88+cuVaXlKg99iJLfwkEKiRd8zNJoYqoZWhYh8HfmQg0Yix9rgKt1PsqTTIlf7brZRoA==
X-Received: by 2002:ac8:5753:0:b0:31e:eb8e:6c5b with SMTP id 19-20020ac85753000000b0031eeb8e6c5bmr11671822qtx.630.1658309081687;
        Wed, 20 Jul 2022 02:24:41 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id e25-20020ac86719000000b0031ec38da567sm12661680qtp.0.2022.07.20.02.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 02:24:41 -0700 (PDT)
Message-ID: <1fa1dda81b17cc9d40d9916bed68ea4eab7dfcdf.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: adc: add max11410 adc driver
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, Nuno.Sa@analog.com,
        Nurettin.Bolucu@analog.com, andy.shevchenko@gmail.com
Date:   Wed, 20 Jul 2022 11:25:39 +0200
In-Reply-To: <20220719145932.96-2-Ibrahim.Tilki@analog.com>
References: <20220707174739.21fe67ea@jic23-huawei>
         <20220719145932.96-2-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2022-07-19 at 14:59 +0000, Ibrahim Tilki wrote:
> > On Thu, 7 Jul 2022 08:31:24 +0000
> > Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:
> >=20
> > > Adding support for max11410 24-bit, 1.9ksps delta-sigma adc which
> > > has 3 differential reference and 10 differential channel inputs.
> > > Inputs and references can be buffered internally. Inputs can also
> > > be amplified with internal PGA.
> > >=20
> > > Device has a digital filter that is controlled by a custom sysfs
> > > attribute.
> > > User has four options to choose from: fir50/60, fir50, fir60 and
> > > sinc4.
> > > Digital filter selection affects sampling frequency range so
> > > driver
> > > has to consider the configured filter when configuring sampling
> > > frequency.
> > >=20
> > > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > > Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> >=20
> > Hi Ibrahim,
> >=20
> > As you probably expect, quite a bit of the feedback inline is about
> > the
> > custom sysfs attribute. I think we need to fit that more closely to
> > the current
> > filter ABI.=C2=A0 It's not a perfect fit however, but I make some
> > suggestions inline.
> >=20
> > thanks,
> >=20
> > Jonathan
> >=20
>=20
> Hi Jonathan,
>=20
> Thanks for the review, I've resolved most of the items and will send
> v3 soon after
> I perform some more tests with the hardware. In the meantime I have
> some questions inline.
>=20
> Regards,
> Ibrahim
>=20
> ...
>=20
> > > +static int max11410_read_reg(struct max11410_state *st,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 unsigned int reg,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int *val)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 data[3];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (max11410_reg_size(reg)=
 =3D=3D 3) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D regmap_bulk_read(st->regmap, reg, data, 3);
> >=20
> > Ah. There is a fun corner here.=C2=A0 SPI bulk reads in general
> > require DMA safe buffers (basically they need to be on the heap,
> > not the
> > stack and we need to enforce that nothing else shares a cacheline
> > with them).
> > Now, last time I checked regmap happens to always end up using a
> > safe bounce
> > buffer, but it's not documented as such and there is no guarantee
> > it will continue
> > to do so.=C2=A0 We checked this with the maintainer a while back and th=
e
> > answer
> > was to always use DMA safe buffers with bulk accesses.
> > Whilst that might have changed, I've not heard anything about it
> > doing so.
> >=20
>=20
> So I guess having this would solve dma alignment and the leak issue
> in max11410_trigger_handler
> and the data field can be shared between?
>=20
> struct max11410_state {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0int data ____cacheline_aligned;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0s64 ts __aligned(8);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} scan;
> };
>=20

Just a note on this one... You want to use 'IIO_DMA_MINALIGN' and
not ____cacheline_aligned.


https://lore.kernel.org/linux-iio/20220508175712.647246-1-jic23@kernel.org/


- Nuno S=C3=A1


