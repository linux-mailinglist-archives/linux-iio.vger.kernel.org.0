Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283725BB88B
	for <lists+linux-iio@lfdr.de>; Sat, 17 Sep 2022 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIQNiU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Sep 2022 09:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIQNiT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Sep 2022 09:38:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EAC37F95
        for <linux-iio@vger.kernel.org>; Sat, 17 Sep 2022 06:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A845FB80D79
        for <linux-iio@vger.kernel.org>; Sat, 17 Sep 2022 13:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917FAC433D6;
        Sat, 17 Sep 2022 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663421893;
        bh=iowlPyVLgjUQqs6U64E7NkLW4faa0mRDGEMCkg0RGHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q8J77YIOUxndgHRaQCY3d37Bvw7SyEQo7TLYYYrkiJiEJWLHDRv+kPoFE3pcrhSYL
         xJDh6ViDc5UDznxzy5d2Bc+P4FxeowKQ3tuJm30cG2ZWmMq6j/Tgp8V+GVI4LHWoBg
         x/Aj/QvqMRN+SxszUbO/w20aDyPjs7OwITLRIt+umN4jippbiM9C79ROPz4eLyr7Vu
         G0VGd9G4K7z7QgzGlsAX+/oRc5QP4fapOrrx0hCMRXLfkaljT18rsa03VOYd36GJz+
         avLto/f2DMH/pyaMbfw1V1NRJpR7T8uRzYUPNyhClX3MMuN9EZf0QocrCnn8gyflIe
         N+HluPQl+x4DA==
Date:   Sat, 17 Sep 2022 14:38:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iio: dac: ad5593r: prevent use of uninitialized
 variable
Message-ID: <20220917143815.311539d8@jic23-huawei>
In-Reply-To: <20220916093307.612830-1-nuno.sa@analog.com>
References: <20220916093307.612830-1-nuno.sa@analog.com>
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

On Fri, 16 Sep 2022 11:33:07 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Properly error check the call to ad5593r_read_word() so that we do not
> end up (would be unlikely but possible) touching uninitialized data.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 53b6e3b2164c ("iio: dac: ad5593r: Fix i2c read protocol requiremen=
ts")
That's not a stable commit ID.

Normally I mostly try and keep these stable even before pushing out as non
rebasing / togreg.  This time around I want to fast forward the tree
after the current pull request merges because I need some dependencies that
are in char-misc-next for other patches.

I didn't think this through when I said I preferred a separate patch.
Anyhow, I've squashed this with the original patch.

Thanks,

Jonathan


> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/ad5593r.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
> index bb5e3fe90e89..420981e7c5c3 100644
> --- a/drivers/iio/dac/ad5593r.c
> +++ b/drivers/iio/dac/ad5593r.c
> @@ -83,10 +83,12 @@ static int ad5593r_gpio_read(struct ad5592r_state *st=
, u8 *value)
>  	int ret;
> =20
>  	ret =3D ad5593r_read_word(i2c, AD5593R_MODE_GPIO_READBACK, &val);
> +	if (ret)
> +		return ret;
> =20
>  	*value =3D (u8) val;
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static const struct ad5592r_rw_ops ad5593r_rw_ops =3D {

