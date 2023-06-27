Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9745073FDDC
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jun 2023 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjF0Ocl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jun 2023 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjF0OcX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jun 2023 10:32:23 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04281994
        for <linux-iio@vger.kernel.org>; Tue, 27 Jun 2023 07:32:21 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-440d1ba5662so1220056137.2
        for <linux-iio@vger.kernel.org>; Tue, 27 Jun 2023 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687876341; x=1690468341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cG7mmaozMpgjvuV6CWQPP9vpxK9PhxWUqBms3Di/VFs=;
        b=vcPfT4UGkqo0ZtlkTl38Bs2RKevnc83rsLOxmDwcrqxCQ+TWPfkuIbQSHZOm00Z0Tw
         /vM33MfnFbI0yeOCv8ar2dXQyFsuKL70v3/4C4UDqARdh2hcH8OvPUxhTQkB/5KyD+AD
         kLxIZ+HK96wHM3ZSlTWn/jbUuWukQcVXLeFEVlsvh/kkLMNuC8kousG3lZnSGbcr48Zd
         MEJXNuvT/GTlcqB9lw1CJGEPBuiKcIERn7Vw/48LoN6M5K7bgo9o0Y6zHKX2YQcLK8Os
         ocuV6wx81XXMmh81U5ZWmvS07Gv40a3cfMZKnGru+znZ2FYWkpCUaVb62soUwuG/oIoZ
         nxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876341; x=1690468341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG7mmaozMpgjvuV6CWQPP9vpxK9PhxWUqBms3Di/VFs=;
        b=O8Wb108LUgH7uhrT4kh6baqNfx71Vx6lQWHsNqV7cw7VR2WE7WzyjI4mLCaSUmwO2d
         3mbgNiJhg33QUV2BdjV6HuySKNDO/pHbCRj/O2IXfKRy9xAENEuYkIEjNL4l+YixP6Y2
         uFGjFeYEYIIyAM12Q7a/B66/I0mwSuXGMAgZQFCokvscV0+lZYzzmlPl0ofUG8fYhQjH
         WKEqgMqtSa7TgwFoSw8x02StbYzS3euKyoHAFj+yjfWKl3b4mPMD2dJ0FMc4DUNWgzsb
         JrHfl+uG+GGnm7bTymjDGjydt9qpZgbdvU4xDkbuWwYmBn07BNFN0mxNFPcANrxup5nl
         0Rtg==
X-Gm-Message-State: AC+VfDwCSnq+Ieu4fnOWx0RoIs/lqBHzAimE4fTFyKNDkVItL9FJfv/a
        5DP1xyz7ttP/D4zTzpjopv1P3A==
X-Google-Smtp-Source: ACHHUZ5PL5UWrDyfdKFy+qMZ9t0tjcMI6cC9i+p63jD0y6e7ilyV6u4r7dhDFBX0ZNbWreqJZ37dOA==
X-Received: by 2002:a67:ce91:0:b0:443:5632:66de with SMTP id c17-20020a67ce91000000b00443563266demr2498101vse.16.1687876340847;
        Tue, 27 Jun 2023 07:32:20 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id m12-20020a67d58c000000b004435c659092sm1164404vsj.5.2023.06.27.07.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:32:20 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:32:17 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, "Sahin, Okan" <Okan.Sahin@analog.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <ZJry8QTka8m6ag/j@fedora>
References: <20230412111256.40013-6-okan.sahin@analog.com>
 <20230420103438.GI9904@google.com>
 <09eb8e4c-3e73-41f0-bf42-8ddf3c4254ec@sirena.org.uk>
 <20230421073938.GO996918@google.com>
 <82612171-46d7-4d82-a8fc-c7d6a99d57e9@sirena.org.uk>
 <MN2PR03MB516860989BD8ED6AC9A767FBE755A@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230621171315.GL10378@google.com>
 <20230626175443.GA3446604-robh@kernel.org>
 <20230627135615.GF10378@google.com>
 <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0AHAXhl6gnWOf1AZ"
Content-Disposition: inline
In-Reply-To: <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--0AHAXhl6gnWOf1AZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 08:10:59AM -0600, Rob Herring wrote:
> On Tue, Jun 27, 2023 at 7:56=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
> >
> > On Mon, 26 Jun 2023, Rob Herring wrote:
> >
> > > On Wed, Jun 21, 2023 at 06:13:15PM +0100, Lee Jones wrote:
> > > > On Tue, 13 Jun 2023, Sahin, Okan wrote:
> > > >
> > > > > >On Fri, Apr 21, 2023 at 08:39:38AM +0100, Lee Jones wrote:
> > > > > >
> > > > > >> I'll try anything once!
> > > > > >
> > > > > >> Fair warning, I think this is going to massively complicate th=
ings.
> > > > > >
> > > > > >> Either we're going to be left with a situation where child-dri=
ver
> > > > > >> maintainers are scrabbling around looking for previous version=
s for the
> > > > > >> MFD pull-request or contributors being forced to wait a full c=
ycle for
> > > > > >> their dependencies to arrive in the maintainer's base.
> > > > > >
> > > > > >If people are resending after the MFD has gone in they really ou=
ght to
> > > > > >be including the pull request in the cover letter, with some com=
bination
> > > > > >of either referencing the mail or just saying "this depends on t=
he
> > > > > >signed tag at url+tag", the same way they would for any other de=
pendency.
> > > > > >
> > > > > >I can't see how you applying stuff when you can slow things down=
 TBH,
> > > > > >the MFD bits will be applied faster and either people can pull i=
n a
> > > > > >shared tag or you can apply more commits on top of the existing =
core
> > > > > >driver.
> > > > > >
> > > > > >> I'm not sure why simply providing your Ack when you're happy w=
ith the
> > > > > >> driver and forgetting about the set until the pull-request arr=
ives, like
> > > > > >> we've been doing for nearly a decade now, isn't working for yo=
u anymore
> > > > > >> but I'm mostly sure this method will be a regression.
> > > > > >
> > > > > >Like I said I've not been doing that, I've mostly been just appl=
ying the
> > > > > >driver when it's ready.  This might not have been so visible to =
you
> > > > > >since it means that the regulator driver doesn't appear in the s=
eries by
> > > > > >the time the MFD settles down.  The whole "Acked-for-MFD" has al=
ways
> > > > > >been a bit confusing TBH, it's not a normal ack ("go ahead and a=
pply
> > > > > >this, I'm fine with it") so it was never clear what the intentio=
n was.
> > > > > >
> > > > > >Before I started just applying the drivers there used to be cons=
tant
> > > > > >problems with things like tags going missing (which some of the =
time is
> > > > > >the submitter just not carrying them but can also be the result =
of some
> > > > > >churn causing them to be deliberately dropped due to changes) or
> > > > > >forgetting the series as you suggest and then not looking at som=
e other
> > > > > >very similarly named series that was also getting lots of versio=
ns after
> > > > > >thinking it was one that had been reviewed already.  It was all =
very
> > > > > >frustrating.  Not doing the tags until the dependencies have set=
tled
> > > > > >down means that if it's in my inbox it at least consistently nee=
ds some
> > > > > >kind of attention and that the submitter didn't drop tags or any=
thing so
> > > > > >I know why there's no tag on it even though the version number i=
s high,
> > > > > >though it's not ideal either.
> > > > >
> > > > > Hi Mark and Lee,
> > > > >
> > > > > Is there anything that I need to do for this patch set. I have re=
ceived reviewed
> > > > > by tag for all of them so far.
> > > >
> > > > Since we are so late in the day, I'm going to just apply this for v=
6.5.
> > > >
> > > > The remainder can then be applied, friction free, for v6.6.
> > >
> > > Now we have undocmented bindings in use by the driver (as pointed out=
 by
> > > 'make dt_compatible_check').
> > >
> > > The whole series has all the acks/reviews needed for you to apply the
> > > whole thing, so why not take the whole thing? Plus this series has be=
en
> > > sitting for 2 months. Not a great experience for submitters...
> >
> > Patches are missing Acked-by tags.
> >
> >   Reviewed-by !=3D Acked-by
>=20
> Reviewed-by > Acked-by
>=20
> >
> > I cannot merge other subsystem's patches without and Acked-by.
>=20
> I (and Krzysztof) give one or the other. If I'm taking a patch, then
> it's neither. I'm pretty sure Mark only gives Reviewed-by when he is
> not taking something.
>=20
> Rob

It does seem a bit ambiguous whether an "Acked-by" indicates a
"Reviewed-by + acceptance of the changes" or just a brief look-over with
acceptance of the changes. FWIW the documentation does use the word
"reviewed" when describing Acked-by. [^1]

However, I would argue that a Reviewed-by has a implicit acceptance of
the changes: why else provide a Reviewed-by line for the commit message
if you fundamentally disagree with the changes being merged? So a
Reviewed-by given by a maintainer should be seen as approval for those
changes to be merged.

William Breathitt Gray

[^1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l#when-to-use-acked-by-cc-and-co-developed-by

--0AHAXhl6gnWOf1AZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZJry8QAKCRC1SFbKvhIj
K0jEAP9974kvrI9EFi93M1mev2jyw0EIBa2A6hH29WtCU3EifQD/UW4lnOzD+057
JcMn4YE0jSwdW5rjQuznd4HlPpZbJQ8=
=Ukkt
-----END PGP SIGNATURE-----

--0AHAXhl6gnWOf1AZ--
