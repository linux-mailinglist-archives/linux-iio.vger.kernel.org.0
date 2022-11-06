Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9597E61E4DB
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 18:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiKFRYB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 12:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKFRXh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 12:23:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8448C30;
        Sun,  6 Nov 2022 09:22:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3706760C91;
        Sun,  6 Nov 2022 17:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0225C433D6;
        Sun,  6 Nov 2022 17:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667755375;
        bh=/2kzaA+b8Jgqw1DZYFYV1wS3t52IySX4aUNpVTL5RP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BaxAVJ7fr1BeQFzpk9LcjnyuPYqOxRVKWoH+Lls7ChQCYnizQ6dHAVy/rjvZaz0XI
         pKkKBU3cYHM7iqOLGppkDio+SBHRzvTXyE7J2BtKCAdthNbLxot37xBWQzLkN/hKEf
         Kcr8aJnLnhmWKHClEEij2txVOaH61cRaVx0FK/jMo4VlPllkuZz7j4PuaI+52Ddp4h
         iZKb78GiSUDI87k5WHqJvTHP5+ZpnyaQr06UBwVLdfzAu+TpwfFqC504lCUykZ6C04
         bB2do6cwwVrH0Xek7qVOQqMn2P/y+ixG0E9HfOB0V7CV+/ixEcbZtGcQHQYZiACVUQ
         IryyqrxzTTWxg==
Date:   Sun, 6 Nov 2022 17:22:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: core: Introduce i2c_client_get_device_id
 helper function
Message-ID: <20221106172249.30241713@jic23-huawei>
In-Reply-To: <bb8d7f33c6b9e960d542c3951101587b4ddfaef6.1667750698.git.ang.iglesiasg@gmail.com>
References: <cover.1667750698.git.ang.iglesiasg@gmail.com>
        <bb8d7f33c6b9e960d542c3951101587b4ddfaef6.1667750698.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun,  6 Nov 2022 17:42:24 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Introduces new helper function to aid in .probe_new() refactors. In order
> to use existing i2c_get_device_id() on the probe callback, the device
> match table needs to be accessible in that function, which would require
> bigger refactors in some drivers using the deprecated .probe callback.
>=20
> This issue was discussed in more detail in the IIO mailing list.
>=20
> Link: https://lore.kernel.org/all/20221023132302.911644-11-u.kleine-koeni=
g@pengutronix.de/
> Suggested-by: Nuno S=C3=A1 <noname.nuno@gmail.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Trivial comment inline - otherwise lgtm
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

>=20
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index b4edf10e8fd0..920676e62c22 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -2236,6 +2236,21 @@ int i2c_get_device_id(const struct i2c_client *cli=
ent,
>  }
>  EXPORT_SYMBOL_GPL(i2c_get_device_id);
> =20
> +/**
> + * i2c_client_get_device_id - get the driver match table entry of a devi=
ce
> + * @client: the device to query. The device must be bound to a driver or
> + *	    the function oopses.

Maybe don't state what happens otherwise if something changes to make it
instead do something else unfortunate, this comment will need updating.
"The device must be bound to a driver."


> + *
> + * Returns a pointer to the matching entry if found, NULL otherwise.
> + */
> +const struct i2c_device_id *i2c_client_get_device_id(const struct i2c_cl=
ient *client)
> +{
> +	const struct i2c_driver *drv =3D to_i2c_driver(client->dev.driver);
> +
> +	return i2c_match_id(drv->id_table, client);
> +}
> +EXPORT_SYMBOL_GPL(i2c_client_get_device_id);
> +
>  /* ----------------------------------------------------
>   * the i2c address scanning function
>   * Will not work for 10-bit addresses!
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index f7c49bbdb8a1..d84e0e99f084 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -189,6 +189,7 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const s=
truct i2c_client *client,
>  					      u8 *values);
>  int i2c_get_device_id(const struct i2c_client *client,
>  		      struct i2c_device_identity *id);
> +const struct i2c_device_id *i2c_client_get_device_id(const struct i2c_cl=
ient *client);
>  #endif /* I2C */
> =20
>  /**

