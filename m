Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19EF75B4AE5
	for <lists+linux-iio@lfdr.de>; Sun, 11 Sep 2022 01:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIJXk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Sep 2022 19:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIJXkZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2022 19:40:25 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4E4F67E
        for <linux-iio@vger.kernel.org>; Sat, 10 Sep 2022 16:40:24 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s18so897576qtx.6
        for <linux-iio@vger.kernel.org>; Sat, 10 Sep 2022 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GelCYvPBwhHEw5qL0NRdEzEzTuKVLCHfKnJgtyVK9+Q=;
        b=XUbbJDaClUnJmdtzeFQJ/5QIQtHnxH9gwAf24NtYTCJaFm0sTcWDAGoPKj5QYv0JJ5
         B88Gag2s52fE+4VKCFsqL5KzNU+vV1+VwH1Fb2IENHdfHtuBM0L5HQMX7Jwp7V4LSqv8
         GcAHFIxGmjoWNU/1wp9wMC3J9uWW9VR6xEJJvzosTLZ7pBYTMN5+H3z1rucY9NIhm6+x
         1czwQ3f1A6PQ54AVseSRodoD7BIKQkcFkblP+6eF62rTebaCWOxIGojlHBldMhcdA2zH
         l7gl/SCIm3QQTGR34Z11AWfHbPNoOYNbNabOZnYfz73HOlq+aPSKw7z63GWH0HYmzCDF
         h/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GelCYvPBwhHEw5qL0NRdEzEzTuKVLCHfKnJgtyVK9+Q=;
        b=bHzaHXLsX3bgxacvg1I4HPv7cpsW7KSOGCyclhLP9inLFXedu3k7K1R6IOPR24DjD2
         KP9fkgnR8RFUE3r+ZEkw2GtX3Bt5tZ+RjQthKNVTXw5kLcXc7zHERzx1sEUHn5MDaDbn
         kLFXztyWrsqrsBeGFimiwlNZRPOm5iG0o/Exig3mQmZVMxJPaLnfsMjsuX40V0W5RWld
         baGXNYBILd1eH0jCZV5Kg90+wAodtTpQMr+jIl+PnV2MpuAFfyLcppxNkOl04wZepGS1
         C6bE4bp84BNhUU4ROx9OO+H1JIRUB9kQ6qoH0j9MgvxUffCCas0MXcUNuuMAkZDM6Kdn
         x25A==
X-Gm-Message-State: ACgBeo3o5+xwYyNaf5uwQmg6DgkcNGxfL0VN/gqBOj3ZIorWWAzJHm0o
        1FIXYeEz8tykIrWuq3aqc0hu4A==
X-Google-Smtp-Source: AA6agR7tdzGhsWS0gu3oSTLaymIzw3xQen05cFW7UgFpY/k8qOuFhQ4D9p3uBhlMzcKsRIr4ESRivA==
X-Received: by 2002:a05:622a:5c7:b0:344:8f29:5374 with SMTP id d7-20020a05622a05c700b003448f295374mr17318416qtb.447.1662853223536;
        Sat, 10 Sep 2022 16:40:23 -0700 (PDT)
Received: from ishi ([2600:1700:5668:ac50::42])
        by smtp.gmail.com with ESMTPSA id w9-20020ac843c9000000b0034502695369sm3310045qtn.54.2022.09.10.16.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 16:40:23 -0700 (PDT)
Date:   Sat, 10 Sep 2022 19:40:21 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, fabien.lahoudere@collabora.com,
        gwendal@chromium.org, enric.balletbo@collabora.com,
        bleung@chromium.org, groeck@chromium.org, jic23@kernel.org,
        david@lechnology.com, robertcnelson@gmail.com
Subject: Re: [RFC PATCH 2/2] counter: Introduce the COUNTER_COMP_ARRAY_U64
 component type
Message-ID: <Yx0gZXvZX7Os2f0q@ishi>
References: <cover.1661785438.git.william.gray@linaro.org>
 <31a35481813ec26949018888253278a634998a92.1661785438.git.william.gray@linaro.org>
 <82ec09fd-a940-cae6-f793-1bb903190664@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SVgqqGCgr8ExcmSD"
Content-Disposition: inline
In-Reply-To: <82ec09fd-a940-cae6-f793-1bb903190664@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--SVgqqGCgr8ExcmSD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2022 at 04:41:16PM +0200, Julien Panis wrote:
>=20
>=20
> On 29/08/2022 17:17, William Breathitt Gray wrote:
> > The COUNTER_COMP_ARRAY_U64 Counter component type is introduced to
> > enable support for Counter array components. With Counter array
> > components, exposure for buffers on counter devices can be defined via
> > new Counter array component macros. This should simplify code for driver
> > authors who would otherwise need to define individual Counter components
> > for each array element.
> >=20
> > Three Counter array component macros are introduced::
> >=20
> >          COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _length)
> >          COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _length)
> >          COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _length)
>=20
> Hi William,
>=20
> I have 2 comments :
>=20
> 1) What about ENUM ? I guess that it will not be possible to handle ARRAY=
 of
> ENUM ?
> =A0=A0=A0 That would be useful for polarity0/1/2/3 in my ECAP driver
> =A0=A0=A0 (something like COUNTER_COMP_SIGNAL_ARRAY_ENUM for instance)
>=20
> 2) I made some tests with COUNTER_COMP_COUNT_ARRAY_U64
> =A0=A0=A0=A0=A0=A0=A0 COUNTER_COMP_COUNT_ARRAY_U64("capture", ecap_cnt_ca=
p_read, NULL,
> ECAP_NB_CEVT)
> =A0=A0=A0 I can get consistent data value when using 'cat captureX' linux
> commands.
> =A0=A0=A0 But I get weird values when using watches from userspace applic=
ation
> code (I will send my test results to you).
>=20
> Julien Panis

I have an idea that might work for supporting enum types, so I'll try to
implement support for that in v2. I was also able to track down the bug
you found so I'll have that fixed as well.

William Breathitt Gray

--SVgqqGCgr8ExcmSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYx0gZQAKCRC1SFbKvhIj
K/5lAP9r6caRdRfG+OCSEGPGWpGgz991ELuJCsYVwlZWIxqXfgEA2N+aDzsizaex
lmvM0bTrCjEsDdWuxeeKiE/Org4B0wM=
=/rSA
-----END PGP SIGNATURE-----

--SVgqqGCgr8ExcmSD--
