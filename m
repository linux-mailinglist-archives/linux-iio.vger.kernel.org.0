Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F846D31B7
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 17:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDAPAn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjDAPAm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 11:00:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4311FD15;
        Sat,  1 Apr 2023 08:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B092608C4;
        Sat,  1 Apr 2023 15:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4A4C4339C;
        Sat,  1 Apr 2023 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680361229;
        bh=tBvxCKnC7dkXLKyIXibho57HiZ0ol0RWN0+BvHDt4p0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SAmu/zhFfEg1yLPiIxmglcKEg/mXs22MZ04hbs4Zm9XPMahPrRLvvLzgjOrxiAOOO
         DHMplbNYPGfri5r+nnRb4J9BjgH6sKr8dEPQVMbtmlChhHPAdIfro4CovQXv+wxTdt
         Qss9u+/ZXlX/8/JpjBRatzk4dnLuhjGFRWhI7pbnPA7YRhzdQcqiUZGrswJBBoshVt
         RCAPBnKh6VpJZ4BQT+VG/vIH7ZySXcV5IAlaUG89OMuiNVnGQgdLIhPhHBOCc/4fVr
         aadOXkiq4g5gqHZJuP0iIdQ4oCmwIKr9cpyQkc7Rtf5gAdlr41/yxfPcx5sNo4JQ0a
         8mi6XpF0U7ofw==
Date:   Sat, 1 Apr 2023 16:15:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, devicetree@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] dt-bindings: iio: st-sensors: Fix repeated text
Message-ID: <20230401161537.687e6ff8@jic23-huawei>
In-Reply-To: <CACRpkdbM_Dron8irHbP77MW2=Yq6o2MAUdYSTE1jcfSHsXZfQg@mail.gmail.com>
References: <20230329074614.1037625-1-linus.walleij@linaro.org>
        <23b2de4b-1198-bfcc-fd74-285da9af4fb3@linaro.org>
        <CACRpkdbM_Dron8irHbP77MW2=Yq6o2MAUdYSTE1jcfSHsXZfQg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Mar 2023 10:39:08 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Wed, Mar 29, 2023 at 10:25=E2=80=AFAM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>=20
> > Please drop the autogenerated scripts/get_maintainer.pl CC-entries from
> > commit msg (Jonathan's, Lars', Rob's, mine, DT list). There is no single
> > need to store automated output of get_maintainers.pl in the git log. It
> > can be easily re-created at any given time, thus its presence in the git
> > history is redundant and obfuscates the log.
> >
> > If you need it for your own patch management purposes, keep it under the
> > --- separator. =20
>=20
> Oh yeah I've seen that people do this these days, just (old) bad habits.
>=20
> I am trying to use b4 for this going forward, it always does the right th=
ing.
>=20
> Thanks!
> Linus Walleij

Applied with suggested tweaks.

Thanks,

Jonathan
