Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A5473FD76
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jun 2023 16:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjF0OLV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jun 2023 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjF0OLQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jun 2023 10:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DE1270F;
        Tue, 27 Jun 2023 07:11:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8901E611B9;
        Tue, 27 Jun 2023 14:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF26C433C9;
        Tue, 27 Jun 2023 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687875074;
        bh=xeCPOhBMjE2CPK1AN983wnR+87uAbWSntpDZrd/CiBQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tvoMU3ZkZ6gO1+AjSp/+OnLJ1kv+57MeKLJEiUfcscWh/RFIHd9Pb1HSModFxVvnQ
         m6rs4ymZi2wmdLLWePYzO1x0moz95fhuibjuxvwqhYm4OJ7F6LEy+/0QdWm/I0p5XO
         gg85VyVj0w3/5PFGbAO3MeGBeLyk3R7RJfDOyh+kzfMhLQwI4MIIVT8asaMnl1TFlR
         gd9/KU3pt4hpsFFo5UKIry586bO6nzSF3zzrlpy0zTRsJhM5Mi31m/d6vjTGiYg6tW
         hxNibPTtvpufqhsQOtSN5XYyH13EOhky/tmgiZKI2LlxS9USVxocaQzFcjVIUC/2/d
         UhyQQqq87f3gw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so27304421fa.1;
        Tue, 27 Jun 2023 07:11:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDxwVWR5BNHS1h+20aurm3CFcOM6Y7XZPmBMLe2f3se4cNy7tJbD
        Rctz3xPS0fH4o87U3MnpatzjuZFr/XvcIp19kQ==
X-Google-Smtp-Source: ACHHUZ7eabgwGTnZp7X5eZw1EcK1Kg+YRqCE4/uAmx2u4dnbSW6zR+fnqJvmmgj4nBQ1Y9SsU86JFbtiQ2TD3+9pqCg=
X-Received: by 2002:a2e:7316:0:b0:2b6:9e58:33e4 with SMTP id
 o22-20020a2e7316000000b002b69e5833e4mr4531082ljc.4.1687875071928; Tue, 27 Jun
 2023 07:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230412111256.40013-1-okan.sahin@analog.com> <20230412111256.40013-6-okan.sahin@analog.com>
 <20230420103438.GI9904@google.com> <09eb8e4c-3e73-41f0-bf42-8ddf3c4254ec@sirena.org.uk>
 <20230421073938.GO996918@google.com> <82612171-46d7-4d82-a8fc-c7d6a99d57e9@sirena.org.uk>
 <MN2PR03MB516860989BD8ED6AC9A767FBE755A@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230621171315.GL10378@google.com> <20230626175443.GA3446604-robh@kernel.org>
 <20230627135615.GF10378@google.com>
In-Reply-To: <20230627135615.GF10378@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Jun 2023 08:10:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
Message-ID: <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC Support
To:     Lee Jones <lee@kernel.org>
Cc:     "Sahin, Okan" <Okan.Sahin@analog.com>,
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
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 27, 2023 at 7:56=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Mon, 26 Jun 2023, Rob Herring wrote:
>
> > On Wed, Jun 21, 2023 at 06:13:15PM +0100, Lee Jones wrote:
> > > On Tue, 13 Jun 2023, Sahin, Okan wrote:
> > >
> > > > >On Fri, Apr 21, 2023 at 08:39:38AM +0100, Lee Jones wrote:
> > > > >
> > > > >> I'll try anything once!
> > > > >
> > > > >> Fair warning, I think this is going to massively complicate thin=
gs.
> > > > >
> > > > >> Either we're going to be left with a situation where child-drive=
r
> > > > >> maintainers are scrabbling around looking for previous versions =
for the
> > > > >> MFD pull-request or contributors being forced to wait a full cyc=
le for
> > > > >> their dependencies to arrive in the maintainer's base.
> > > > >
> > > > >If people are resending after the MFD has gone in they really ough=
t to
> > > > >be including the pull request in the cover letter, with some combi=
nation
> > > > >of either referencing the mail or just saying "this depends on the
> > > > >signed tag at url+tag", the same way they would for any other depe=
ndency.
> > > > >
> > > > >I can't see how you applying stuff when you can slow things down T=
BH,
> > > > >the MFD bits will be applied faster and either people can pull in =
a
> > > > >shared tag or you can apply more commits on top of the existing co=
re
> > > > >driver.
> > > > >
> > > > >> I'm not sure why simply providing your Ack when you're happy wit=
h the
> > > > >> driver and forgetting about the set until the pull-request arriv=
es, like
> > > > >> we've been doing for nearly a decade now, isn't working for you =
anymore
> > > > >> but I'm mostly sure this method will be a regression.
> > > > >
> > > > >Like I said I've not been doing that, I've mostly been just applyi=
ng the
> > > > >driver when it's ready.  This might not have been so visible to yo=
u
> > > > >since it means that the regulator driver doesn't appear in the ser=
ies by
> > > > >the time the MFD settles down.  The whole "Acked-for-MFD" has alwa=
ys
> > > > >been a bit confusing TBH, it's not a normal ack ("go ahead and app=
ly
> > > > >this, I'm fine with it") so it was never clear what the intention =
was.
> > > > >
> > > > >Before I started just applying the drivers there used to be consta=
nt
> > > > >problems with things like tags going missing (which some of the ti=
me is
> > > > >the submitter just not carrying them but can also be the result of=
 some
> > > > >churn causing them to be deliberately dropped due to changes) or
> > > > >forgetting the series as you suggest and then not looking at some =
other
> > > > >very similarly named series that was also getting lots of versions=
 after
> > > > >thinking it was one that had been reviewed already.  It was all ve=
ry
> > > > >frustrating.  Not doing the tags until the dependencies have settl=
ed
> > > > >down means that if it's in my inbox it at least consistently needs=
 some
> > > > >kind of attention and that the submitter didn't drop tags or anyth=
ing so
> > > > >I know why there's no tag on it even though the version number is =
high,
> > > > >though it's not ideal either.
> > > >
> > > > Hi Mark and Lee,
> > > >
> > > > Is there anything that I need to do for this patch set. I have rece=
ived reviewed
> > > > by tag for all of them so far.
> > >
> > > Since we are so late in the day, I'm going to just apply this for v6.=
5.
> > >
> > > The remainder can then be applied, friction free, for v6.6.
> >
> > Now we have undocmented bindings in use by the driver (as pointed out b=
y
> > 'make dt_compatible_check').
> >
> > The whole series has all the acks/reviews needed for you to apply the
> > whole thing, so why not take the whole thing? Plus this series has been
> > sitting for 2 months. Not a great experience for submitters...
>
> Patches are missing Acked-by tags.
>
>   Reviewed-by !=3D Acked-by

Reviewed-by > Acked-by

>
> I cannot merge other subsystem's patches without and Acked-by.

I (and Krzysztof) give one or the other. If I'm taking a patch, then
it's neither. I'm pretty sure Mark only gives Reviewed-by when he is
not taking something.

Rob
