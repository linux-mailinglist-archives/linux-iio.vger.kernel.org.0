Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2F24FAF25
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 19:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiDJREz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240707AbiDJREs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 13:04:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD059A4D
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 10:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48D94B80E42
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 17:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0885C385A4;
        Sun, 10 Apr 2022 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649610155;
        bh=5AQwNT0klAA7HNBAlR/+bQ0OjLs/pMl5PIQAp9zgXLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p23Cl8nK3Vok57e0w1SxyYzhHXrWDv60c80ectn9sB/kOuQQ7SaS5i2e9NWh4l4Q9
         fPvsgmVL4Z5kDZfb1GSiPiQkZgUwZPg2Nr9Yh0ihCigTLWI8LP9PfECWlHttrnlSmq
         zxOkg28/8CkjDTAr2XIy/u+2kbJ9h+kOZZv9tf9m9oS4Ohpb1EsBBzzFmZyUs5MO4s
         8nPGJyYQSIp0T8zEJLlT4zguw/qbxPftb8mz7wOxLfNUF8B9sQ8rioBzih6M+vtmqc
         vvhI88Kx/kut00XeFDXRAoX+eC5uAGtAei6OzJmdaGkxsUpfgX+M4lWLZMxJcsYn9d
         cxAnDUzEIl/bw==
Date:   Sun, 10 Apr 2022 18:10:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Fawzi Khaber <fawzi.khaber@tdk.com>
Subject: Re: [PATCH v2] iio: imu: inv_icm42600: Fix I2C init possible nack
Message-ID: <20220410181026.6cd0d569@jic23-huawei>
In-Reply-To: <20220404084650.17377-1-jmaneyrol@invensense.com>
References: <20220404084650.17377-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon,  4 Apr 2022 10:46:50 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

=46rom should be Fawzi as the first author of the patch.
Use=20
git commit --amend --author=3D"Fawzi Khaber <fawzi.khaber@tdk.com>"
To reset it appropriately - or confirm you are fine with me
tweaking that whilst applying.

>=20
> This register write to REG_INTF_CONFIG6 enables a spike filter that
> is impacting the line and can prevent the I2C ACK to be seen by the
> controller. So we don't test the return value.
>=20
> Signed-off-by: Fawzi Khaber <fawzi.khaber@tdk.com>
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
I should have raised this last time...

Fixes tag needed if I'm going to take this through my fixes
branch / mark it for stable etc.

If you don't mind it going the slow way and not getting backported
then I can take it without.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_i2c.c
> index 33d9afb1ba91..01fd883c8459 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -18,12 +18,15 @@ static int inv_icm42600_i2c_bus_setup(struct inv_icm4=
2600_state *st)
>  	unsigned int mask, val;
>  	int ret;
> =20
> -	/* setup interface registers */
> -	ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
> +	/*
> +	 * setup interface registers
> +	 * This register write to REG_INTF_CONFIG6 enables a spike filter that
> +	 * is impacting the line and can prevent the I2C ACK to be seen by the
> +	 * controller. So we don't test the return value.
> +	 */
> +	regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG6,
>  				 INV_ICM42600_INTF_CONFIG6_MASK,
>  				 INV_ICM42600_INTF_CONFIG6_I3C_EN);
> -	if (ret)
> -		return ret;
> =20
>  	ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INTF_CONFIG4,
>  				 INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY, 0);

