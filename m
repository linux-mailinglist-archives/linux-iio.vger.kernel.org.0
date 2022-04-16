Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAFF5036E0
	for <lists+linux-iio@lfdr.de>; Sat, 16 Apr 2022 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiDPN4G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Apr 2022 09:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiDPN4F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2022 09:56:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1FF3D1F2
        for <linux-iio@vger.kernel.org>; Sat, 16 Apr 2022 06:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 469E1B82420
        for <linux-iio@vger.kernel.org>; Sat, 16 Apr 2022 13:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3058C385A1;
        Sat, 16 Apr 2022 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650117210;
        bh=eSk324J0H9ialpe5FTCYTFdNF3XTU8amm+ZpJmVMT2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XKLVAzIWvYxk2/t0w+uyRdxsRnfPB69Tgtn16HzjjrvNpqVdRBpAF7YQEVz1qhi8K
         7O38Md3SMppTUSA9AyuO+c3LWj953eznf+1eMMzSYgE5o5JW+t9N1cYErjsPq0xR/9
         hxHx3oYXgTTL95GKRIoTvLzOz5bKSuBkdqhCGA3/tJQsxWcKKddDkf55vjOiXzY9Iq
         n6/TgghaC4xUK7RHqr6ashPDTTDDNwaKQMiE+Evo/NRCV/SWOvAOIAypcBCUSpGORO
         hf4dx1wWzRsbVEszU2yu6F5Qa2YeKlv82cmEp3g36xADrSexzAYvCs6mLCyAORX6HX
         fixOgj2lcCAxA==
Date:   Sat, 16 Apr 2022 15:01:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: dac: ltc2688: fix voltage scale read
Message-ID: <20220416150128.1980889d@jic23-huawei>
In-Reply-To: <20220412124916.61-1-nuno.sa@analog.com>
References: <20220412124916.61-1-nuno.sa@analog.com>
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

On Tue, 12 Apr 2022 14:49:16 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Properly set *val2 (and not overwrite *val) to correctly return
> IIO_VAL_FRACTIONAL_LOG2.
>=20
> Fixes: 832cb9eeb9312 ("iio: dac: add support for ltc2688")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Dropped v1 and applied this instead. =20

If you detect an issue with a patch you have sent yourself, it is helpful
to reply to that patch to make it clear there will be a v2.
I don't always catch up with all my email in one sitting so can end up
pushing the wrong versions out....

Thanks,

Jonathan

> ---
> v2:
>  * Fixed repeated "not" in commit description and tweaked patch subject
> to match the preferred format.
>=20
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

