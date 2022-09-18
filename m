Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB35BBEB1
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 17:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIRPdt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIRPds (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 11:33:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BE51AF0D;
        Sun, 18 Sep 2022 08:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76AD3B80E4F;
        Sun, 18 Sep 2022 15:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A6AC433D6;
        Sun, 18 Sep 2022 15:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663515225;
        bh=yTfmFSAnZLXn9BbwGI+IzTH627rEDnJKQQ7GjV3lwEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GJCOJOs8N0qh3RAysLC0xJ9Zh/Vq2lwBjvnaDUUSnGNpytymmdqZ67aaxLgw2aphX
         bocqCvvIPGcR11ccAoj2Bz2suDS43+xfMmlrVzKwlcv/4gL3nVz+uwy11RLpocCZcv
         gVGiEPLsMTwEmZa3B8SH42dmnA0xH+Dwv8fO+s5gKptLPMNhuJVbxQZcQT+NTanykR
         570BdQh+JWIaLPksJzEKYIwLhI9USQmnsTKvf2AyB8nuQ4QXnsPUK4vfBE/bakzqPB
         yUlDbSnvE+Q/o/SJXxeetv7vibwkZUCifzHL+p8jCRrgam9lBqU0gCk17g0tjcosvH
         mY1CwoQPux7hQ==
Date:   Sun, 18 Sep 2022 16:33:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/3] ad7923 fixes and full range support
Message-ID: <20220918163348.6b681e57@jic23-huawei>
In-Reply-To: <20220912081223.173584-1-nuno.sa@analog.com>
References: <20220912081223.173584-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Sep 2022 10:12:20 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> This patchset adds important fixes for some of the variants supported by =
the
> driver with respect with raw and buffered reads. On top of this way, adds
> a new firmware property to be able to support all the scales supported by
> the hardware.

Applied.

Thanks,

Jonathan

>=20
> v2:
>=20
> [1/3]
>  * Calculate shift using 12 - realbits.
>=20
> [2/3]
>  * Use a boolean property and change the code accordingly.
>=20
> [3/3]
>  * Use a boolean property (adi,range-double).
>=20
> Nuno S=C3=A1 (3):
>   iio: adc: ad7923: fix channel readings for some variants
>   iio: adc: ad7923: support extended range
>   dt-bindings: iio: adi,ad7923: add adi,range-double property
>=20
>  .../devicetree/bindings/iio/adc/adi,ad7923.yaml       |  4 ++++
>  drivers/iio/adc/ad7923.c                              | 11 +++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>=20

