Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26DC527135
	for <lists+linux-iio@lfdr.de>; Sat, 14 May 2022 15:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiENN3j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 May 2022 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiENN3i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2022 09:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D78220F7C
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 06:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C901060ECF
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 13:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A316C340EE;
        Sat, 14 May 2022 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652534976;
        bh=1vOgg+/NuV2jHQhL6tWSBzN/1JrW/CyTWVA2Zp2GFu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZVC1UIqSA5VmP9nn4D9UheJ/2jL/gSGAugLqRGPtH1Lxpt9k49Xx6wbATKpltJ6nl
         X5wBRJFgwLiPINRPT/O9MUvXnd7CaQidwNsqCyR6Q+PhU6ZC5YgN3DpQBogs7HbBz2
         neHPoFXmjzhsh1J7je6QzYoNWvER9oKgfYYNNCU+mu3jpOIbPvSupthhIyIBaW0GQ1
         I1UBvmb6rArjT1Sc5CPUlkUAELl6XJ8yM6L7Mk0gTtwmzT/uUQH7Dh75Eo7w/++zXL
         x5g8c66O7g82/SVhHFa/s6KoRY0RrMnydtYbCKnYvt8ELRYjgInYo4A5ntB7MLzG9i
         V1wqqRty8vJjw==
Date:   Sat, 14 May 2022 14:38:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] io:health:afe4404: Remove duplicated error reporting in
 .remove()
Message-ID: <20220514143812.1d2325e6@jic23-huawei>
In-Reply-To: <20220514130432.304674-1-u.kleine-koenig@pengutronix.de>
References: <20220514130432.304674-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Sat, 14 May 2022 15:04:32 +0200
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> Returning an error value in an i2c remove callback results in an error
> message being emitted by the i2c core, but otherwise it doesn't make a
> difference.
>=20
> As afe4404_remove() already emits an error message on failure and the
> additional error message by the i2c core doesn't add any useful
> information, change the return value to zero to suppress this message.
>=20
> This patch is a preparation for making i2c remove callbacks return void.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied.

Like the others this will sit in testing until I can rebase the togreg
branch.

Thanks,

Jonathan

> ---
> Hello,
>=20
> this is similar to the patches I sent recently.
> (https://lore.kernel.org/linux-iio/20220430081607.15078-1-u.kleine-koenig=
@pengutronix.de/)
> Just missed this driver when I intended to address this problem type for
> all of drivers/iio/.
>=20
> Best regards
> Uwe
>=20
>  drivers/iio/health/afe4404.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index aa9311e1e655..1bb7de60f8ca 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -591,10 +591,8 @@ static int afe4404_remove(struct i2c_client *client)
>  		iio_trigger_unregister(afe->trig);
> =20
>  	ret =3D regulator_disable(afe->regulator);
> -	if (ret) {
> +	if (ret)
>  		dev_err(afe->dev, "Unable to disable regulator\n");
> -		return ret;
> -	}
> =20
>  	return 0;
>  }
>=20
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17

