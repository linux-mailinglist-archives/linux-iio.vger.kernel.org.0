Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E76A5036D1
	for <lists+linux-iio@lfdr.de>; Sat, 16 Apr 2022 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiDPNpa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Apr 2022 09:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiDPNp3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2022 09:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA587F9F95
        for <linux-iio@vger.kernel.org>; Sat, 16 Apr 2022 06:42:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D26CC60F18
        for <linux-iio@vger.kernel.org>; Sat, 16 Apr 2022 13:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8559C385A1;
        Sat, 16 Apr 2022 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650116576;
        bh=h0xZUrOiApwKOTsvZzc7ODsVl0/pagsca8z2IrDeYXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aeOhUMZSCbIT4nTnELp1VubkrAHa3pb34lJlHYQjNu+pnjmK3xGEYXdW243IBdM15
         ELpbda2xFnnCjSsaJUaW85Tg1lNDLB+21vxpWHAnZHxRKcA0whaR92VgD2Od1ufW8j
         u2V2RLWVIXTi6vz0dXsucTQtsFBFOc5pMIRmxGmZbgXyBjh6uMDEbZ5MKrkNL87qjY
         92DG9z0u0Lcfu986CN3HvjUnVLhEushKGlLjsz7uOEZKO4Hr6Fm0r39DIxWDqS4Z3v
         uLdu16FJY1DTvhRg7CSy+MRkbKhjyVhZDDCrs29kvCiqDw720Uqz2SIbADVgqgWvpx
         nuR/YbHrvyuIQ==
Date:   Sat, 16 Apr 2022 14:50:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: ltc2688: fix voltage scale read
Message-ID: <20220416145054.117a6dc1@jic23-huawei>
In-Reply-To: <20220411095919.163-1-nuno.sa@analog.com>
References: <20220411095919.163-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Apr 2022 11:59:19 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Properly set *val2 (and not not overwrite *val) to correctly return
> IIO_VAL_FRACTIONAL_LOG2.
>=20
> Fixes: 832cb9eeb9312 ("iio: dac: add support for ltc2688")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ltc2688.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
> index d249fa28202c..937b0d25a11c 100644
> --- a/drivers/iio/dac/ltc2688.c
> +++ b/drivers/iio/dac/ltc2688.c
> @@ -298,7 +298,7 @@ static int ltc2688_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
> =20
> -		*val =3D 16;
> +		*val2 =3D 16;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		ret =3D regmap_read(st->regmap,

