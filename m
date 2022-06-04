Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98AA53D782
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiFDPhC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbiFDPhA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 11:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8814E0F
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 08:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AE1560E15
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 15:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746E8C385B8;
        Sat,  4 Jun 2022 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654357015;
        bh=gsA9isNneEdpcRNXo7mfOuZjiHFYjGOZ9n5tfmqnq+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sEW5etFs1S2yDWZm9iPMEBNt41Tnlm7TJQol7jT/EkJP6w4wNJ5msU52BM47QuTSc
         Lmcw8eDtcbeP3wDP0QGKNB62c4gTbveruKhPJtHDO1YZkTizceh4/GyERX87JxkTH3
         eFMY/r8b4RlNECxRu2BrXG2iFGx/Z5i3rcxVIoCkVG3e9OjkKizQIiobec/NqoEBud
         a0Zq/Yx9d8sTVthuUGou49ei8WGQFN2x8GFHBVoo0SpPE+jtMUrNtuYFTSRD9/CQOT
         3xrsH3ydrLkJmyCnwmJ53S+iYDpvHmwB9S32BAgwOndrXrZkp9gtMUV3qkBVc5TwSe
         RkcH3I1aGzgyA==
Date:   Sat, 4 Jun 2022 16:45:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/5] iio: adc: adi-axi: Move exported symbols into
 IIO_ADI_AXI namespace.
Message-ID: <20220604164557.7314be83@jic23-huawei>
In-Reply-To: <PH0PR03MB6786A1AE7B59F663C9F263A9993E9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220220173701.502331-1-jic23@kernel.org>
        <20220220173701.502331-5-jic23@kernel.org>
        <PH0PR03MB6786A1AE7B59F663C9F263A9993E9@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Feb 2022 09:26:36 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, February 20, 2022 6:37 PM
> > To: linux-iio@vger.kernel.org
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>
> > Subject: [PATCH 4/5] iio: adc: adi-axi: Move exported symbols into
> > IIO_ADI_AXI namespace.
> >=20
> > [External]
> >=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Avoid unnecessary pollution of the global symbol namespace by
> > moving library functions in to a specific namespace and import
> > that into the drivers that make use of the functions.
> >=20
> > For more info:
> > https://urldefense.com/v3/__https://lwn.net/Articles/760045/__;!!A
> > 3Ni8CS0y2Y!qj7laM0qKDhsEb1sYjTacTG-
> > mo7keClzXaoXpymZHqh9LV3hfXIgR01onST88w$
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20

Applied.  I was waiting on someone hopefully looking at the rest of
the series, but as that hasn't happened yet, might as well pick this
one up!

Thanks,

Jonathan
