Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594996F32FC
	for <lists+linux-iio@lfdr.de>; Mon,  1 May 2023 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjEAPgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 May 2023 11:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjEAPga (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2023 11:36:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A610C3
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 08:36:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C760C61BFD
        for <linux-iio@vger.kernel.org>; Mon,  1 May 2023 15:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A589CC433EF;
        Mon,  1 May 2023 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682955389;
        bh=ID0umOrtXJytQgW+qErHyOAl5ePYmGdgJIZIsRNo6kc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BHeQNvwryAuqG3BlJf10W3MFj7SjjJHog1mye2fdk4K3xZqKNwMRvifNNuqoplSmu
         Ycml6fHJywg9qGN7gdGhmQdM68ibId9Yf4RzZjbXG5NXF7/JQ437kF0fZEO6f+NuOG
         HxVj4AKIlS6QKATTKXB1njo3dp35Gusynoujr5ud+J46G/duR1ApNDV0AgXz3aD4pM
         Jaha/6eadLS3YVq/Xg8KJC4bg75eEWxPIyem8YcB+gSvFzHkxwvXuIRv0dXXvex/mO
         UTtLK3DK+8D86RHS+ZKnaHq6H32TnGQMed/jCgcgmqKtRsNYuqdfmskypb/Nh3a0B1
         zn7+7N2Eub/Kg==
Date:   Mon, 1 May 2023 16:52:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Denis Ciocca <denis.ciocca@st.com>,
        Marius Hoch <mail@mariushoch.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Mario Tesi <mario.tesi@st.com>
Subject: Re: [PATCH] iio: accel: st_accel: Fix invalid mount_matrix on
 devices without ACPI _ONT method
Message-ID: <20230501165214.34fe66a1@jic23-huawei>
In-Reply-To: <CACRpkdbdt4eNt17gSzObihHwQPaXR+PzrkPKf78aSVZO12Lp=A@mail.gmail.com>
References: <20230416212409.310936-1-hdegoede@redhat.com>
        <822cff64-f7f8-b998-1b8e-5ada542b86b7@mariushoch.de>
        <20230423114855.1596fe0c@jic23-huawei>
        <CACRpkdbdt4eNt17gSzObihHwQPaXR+PzrkPKf78aSVZO12Lp=A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 24 Apr 2023 09:59:47 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Apr 23, 2023 at 12:33=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
>=20
> > Linus, that's one of yours.  Could you also take a glance at this. =20
>=20
> Heh it should really be looked after by Denis Ciocca or Mario Tesi I thin=
k.
> I don't know if ST MEMS has an official Linux contact point, but I would
> like to nudge them to get one :)

Always good to get input from Denis or Mario.
>=20
> However it looks good to me.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Meh, I consider this one obvious enough that the current set of eyes
would probably have noticed if it was horribly broken.

Applied to the fixes-togreg branch of iio.git and marked for stable.

There's about a week left before rc1 so time for people to scream if
I'm wrong :)

Jonathan

>=20
> Yours,
> Linus Walleij

