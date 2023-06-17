Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11078734366
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jun 2023 21:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjFQT7O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Jun 2023 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQT7O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jun 2023 15:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6428C83
        for <linux-iio@vger.kernel.org>; Sat, 17 Jun 2023 12:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDE5961259
        for <linux-iio@vger.kernel.org>; Sat, 17 Jun 2023 19:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EC7C433C8;
        Sat, 17 Jun 2023 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687031952;
        bh=h0n+2psDcFpBRHaWvervTztT3sUVj34mHOPbwkHlmBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iVoT6LlTgnkSU2JrfT6eSRS6EfkhHWH/5BVYi1vTTSzngbeshgtwUpxY4UzoRu4pT
         Pf7qy18fQjSIFTpYYnbnAycrww2Lh0DAR5pHmWIJ2gHvEbsKaJ7S9vMtoxjsZeas03
         QqA3rLjtZmd0C+h9lDv46LjIqM2Veu5JBixeiOW3gWW9iaFF2kss671eAL/tWUuvCD
         GxoBjmlB5yf5fuE4iiJhRktE1ZMhN/jTcjYxVHQqvxRprtFYH6Bm1cBJ+gci1huirM
         Hx3b3ZmLgaLjRLRerT4JTRLgEtgxBxxY4HqyUJhYUqbgGct6wNszkgb+sdIY6kT9XP
         Qgy7aNX1NHP2w==
Date:   Sat, 17 Jun 2023 20:59:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Juno Computers USA <usa@junocomputers.com>
Subject: Re: [PATCH] iio: accel: da280: Add support for the DA217
 accelerometer
Message-ID: <20230617205906.14ef1190@jic23-huawei>
In-Reply-To: <20230613094346.162551-1-hdegoede@redhat.com>
References: <20230613094346.162551-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Jun 2023 11:43:46 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> The DA217 accelerometer is another DA280 compatible accelerometer,
> add its device-ids to the da280 driver.
> 
> Reported-by: Juno Computers USA <usa@junocomputers.com>
> Tested-by: Juno Computers USA <usa@junocomputers.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing.
Note this has missed the coming merge window so will be for the next
cycle.

Jonathan

> ---
> Note no Closes: for the Reported-by since this was reported by private email
> ---
>  drivers/iio/accel/da280.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> index 38a7d811610e..a49c4f95fe7d 100644
> --- a/drivers/iio/accel/da280.c
> +++ b/drivers/iio/accel/da280.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * IIO driver for the MiraMEMS DA280 3-axis accelerometer and
> + * IIO driver for the MiraMEMS DA217 and DA280 3-axis accelerometer and
>   * IIO driver for the MiraMEMS DA226 2-axis accelerometer
>   *
>   * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
> @@ -23,7 +23,7 @@
>  #define DA280_MODE_ENABLE		0x1e
>  #define DA280_MODE_DISABLE		0x9e
>  
> -enum da280_chipset { da226, da280 };
> +enum da280_chipset { da217, da226, da280 };
>  
>  /*
>   * a value of + or -4096 corresponds to + or - 1G
> @@ -134,7 +134,10 @@ static int da280_probe(struct i2c_client *client)
>  		chip = id->driver_data;
>  	}
>  
> -	if (chip == da226) {
> +	if (chip == da217) {
> +		indio_dev->name = "da217";
> +		indio_dev->num_channels = 3;
> +	} else if (chip == da226) {
>  		indio_dev->name = "da226";
>  		indio_dev->num_channels = 2;
>  	} else {
> @@ -166,12 +169,14 @@ static int da280_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
>  
>  static const struct acpi_device_id da280_acpi_match[] = {
> +	{"NSA2513", da217},
>  	{"MIRAACC", da280},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
>  
>  static const struct i2c_device_id da280_i2c_id[] = {
> +	{ "da217", da217 },
>  	{ "da226", da226 },
>  	{ "da280", da280 },
>  	{}

