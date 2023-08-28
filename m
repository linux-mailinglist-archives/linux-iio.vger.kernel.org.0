Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9096A78AEF7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 13:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjH1LhC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjH1Lgq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 07:36:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45501EB
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 04:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEA5A615C7
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 11:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D19C433C9;
        Mon, 28 Aug 2023 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693222603;
        bh=by+MaeO5GuK7DM4tZJzdgIDjb5NAIuK2OEgPY0/Dqg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MdnJVgpQC+D2ojyxmXZY4XtToX7sahX2UcYIMpHPemVIh13zTgqM25snAbumhkREF
         MscuwWqoPA5GQZE7vfJ+2TqLtufaJoCwXKIQvrJ8SNh86QX++H+QOzZrrfvzao6bSK
         7lAG157+pKIqUoaB6ItPw/3k2PYvZlwa5iRPehdT6NimbsemoiV8wQ3K9Y4cCi4bM5
         Vt3/Cs8hM8jTffoSJ/pM2FnQVUCQiaHD4nZr3k1xAJwb/JSUjrZtqr6EL3Qd/h5YIK
         iNr+LyBD2HqlCzj7aUgTEsR6eSiHc96GvNFc8a0tsIH0d0O5jiFSYuq2v4haeDV+Vp
         vXzGLGZb2vPfg==
Date:   Mon, 28 Aug 2023 12:37:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Phil Elwell <phil@raspberrypi.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: Fix NULL pointer exception
Message-ID: <20230828123703.3ff768e5@jic23-huawei>
In-Reply-To: <CACRpkdb6fo9YCZ+fC9VP4p+D8QC_eoTJ0vK51RPmC21x=UwRgg@mail.gmail.com>
References: <20230811155829.51208-1-phil@raspberrypi.com>
        <CACRpkdb6fo9YCZ+fC9VP4p+D8QC_eoTJ0vK51RPmC21x=UwRgg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Aug 2023 19:38:09 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Aug 11, 2023 at 5:58=E2=80=AFPM Phil Elwell <phil@raspberrypi.com=
> wrote:
>=20
> > The bmp085 EOC IRQ support is optional, but the driver's common probe
> > function queries the IRQ properties whether or not it exists, which
> > can trigger a NULL pointer exception. Avoid any exception by making
> > the query conditional on the possession of a valid IRQ.
> >
> > Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC=
 interrupt")
> > Signed-off-by: Phil Elwell <phil@raspberrypi.com> =20
>=20
> Looks like a logic mistake.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
I've applied this locally but given my tree is currently ahead of its
parent ready for the merge to happen, I won't push this out until
char-misc-next has been merged upstream.

Thanks,

Jonathan

>=20
> Yours,
> Linus Walleij

