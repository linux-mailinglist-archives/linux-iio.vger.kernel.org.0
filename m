Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43878AEA1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 13:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjH1LSw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 07:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjH1LSc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 07:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC421E7;
        Mon, 28 Aug 2023 04:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E7564240;
        Mon, 28 Aug 2023 11:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26201C433C8;
        Mon, 28 Aug 2023 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693221508;
        bh=nwEcIEaZCU/zYimFreKcUbCz0b8Bh6kQnkG4GrvYRyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SgEqxTp/lc93Y9tVV5fdsEHGrr7+L/M/0hd1re748saiBBuR784H6w2Fs2wyDG8z8
         nxkGQ425ycQoDV4tovVIwD58OOLyq5dxTrP7Dtd6ezcN1/UYq9Ilr+H1bzMmIfg5X5
         rCLSRGNjMJZngMDXBKPPNddFFS4coHHLbQv8KFJ0vU1At1OQnaPKkHY8iELM/UH8sn
         QHhXs3VP+3ThWI3ZmZKJqjs825hvpZ/E8q7lIuFwoUQXyPZPy8rVS2UBqKrGV8JKwg
         9sRKbWqNmuXYc5/OGTxroFHRH+tXGiiK+LTxbTxBgD2zZk0FDyRWNn3uBszu5znAYZ
         B988031vO11hw==
Date:   Mon, 28 Aug 2023 12:18:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2] iio: pressure: ms5637: Use i2c_get_match_data()
Message-ID: <20230828121850.0eeda36e@jic23-huawei>
In-Reply-To: <20230818190819.339020-1-biju.das.jz@bp.renesas.com>
References: <20230818190819.339020-1-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Aug 2023 20:08:19 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Replace device_get_match_data() and id lookup for retrieving match data
> by i2c_get_match_data().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Seems a little odd that the 5803 is only in the of_device_id table, but
this patch doesn't (and shouldn't) change that.

Applied to the togreg branch of iio.git but only pushed out as testing
until I can rebase that branch on rc1 in 2 weeks time or so.

Thanks,

Jonathan

> ---
> v1->v2:
>  * Added Rb tag from Andy
>  * Drooped id variable removal from commit description.
> ---
>  drivers/iio/pressure/ms5637.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
> index 9b3abffb724b..ac30d76285d1 100644
> --- a/drivers/iio/pressure/ms5637.c
> +++ b/drivers/iio/pressure/ms5637.c
> @@ -144,7 +144,6 @@ static const struct iio_info ms5637_info = {
>  
>  static int ms5637_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id = i2c_client_get_device_id(client);
>  	const struct ms_tp_data *data;
>  	struct ms_tp_dev *dev_data;
>  	struct iio_dev *indio_dev;
> @@ -159,10 +158,7 @@ static int ms5637_probe(struct i2c_client *client)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (id)
> -		data = (const struct ms_tp_data *)id->driver_data;
> -	else
> -		data = device_get_match_data(&client->dev);
> +	data = i2c_get_match_data(client);
>  	if (!data)
>  		return -EINVAL;
>  

