Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65F790BCA
	for <lists+linux-iio@lfdr.de>; Sun,  3 Sep 2023 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbjICMAU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Sep 2023 08:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjICMAS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2023 08:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E4DC6
        for <linux-iio@vger.kernel.org>; Sun,  3 Sep 2023 05:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58DD660DB7
        for <linux-iio@vger.kernel.org>; Sun,  3 Sep 2023 12:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42577C433C8;
        Sun,  3 Sep 2023 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693742414;
        bh=tmuVUbQBUYUOmgJMy26iIPLEdXGxTiBBZfQQQXYsRek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q3/FUhIFOru5qP5uOkwutBSyLkPH9JexmuuvdzixTc6wqehx6FSa0Z8a/suHWgGZX
         Fy25C/QOau0MfDtwbd355KZOZCaT0xN/TJEg/vL1bW/itz0cmtk/fBwfyOxC5ehlXR
         k2ByM1JesPHAPQEtb198EdFmrme7EEXbZNx6cMY6b5PAIaxUXodIBc2b+G2P1Yp9Wm
         tR9Ph5X4xG95N0c8uWFclajRlrG8VSft1YBFkH30tq0Om/LG1vvGLuMQm3bCAxaQdC
         Q19n7bGQWA/ARwEGLtWjh3oXUn+fmE1vo3pGcDM/g313m9KG5GakT6FaqwjpPpYhAv
         7HPghJtqWl/cQ==
Date:   Sun, 3 Sep 2023 13:00:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: adc: ti-ads1015: Add edge trigger support
Message-ID: <20230903130042.6fa69ea0@jic23-huawei>
In-Reply-To: <20230831182502.154899-1-marex@denx.de>
References: <20230831182502.154899-1-marex@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 31 Aug 2023 20:25:02 +0200
Marek Vasut <marex@denx.de> wrote:

> The comparator generates an edge on the IRQ like and stays in the
> configured state until cleared. Support edge triggered IRQs as well
> as not all controllers do support level triggered IRQ.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Hi Marek,

Seems safe enough change given the latch is enabled.=20

I guess it's not really a fix, but I'd be fine with a request
for this to be added to stable if you like.

Applied to the togreg branch of iio.git and pushed out as testing
only until I can rebase on rc1.

Thanks,

Jonathan


> ---
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/adc/ti-ads1015.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 075c75a875449..addee45ed40ad 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -1047,11 +1047,13 @@ static int ads1015_probe(struct i2c_client *clien=
t)
>  			1 << ADS1015_CFG_COMP_LAT_SHIFT;
> =20
>  		switch (irq_trig) {
> +		case IRQF_TRIGGER_FALLING:
>  		case IRQF_TRIGGER_LOW:
>  			cfg_comp |=3D ADS1015_CFG_COMP_POL_LOW <<
>  					ADS1015_CFG_COMP_POL_SHIFT;
>  			break;
>  		case IRQF_TRIGGER_HIGH:
> +		case IRQF_TRIGGER_RISING:
>  			cfg_comp |=3D ADS1015_CFG_COMP_POL_HIGH <<
>  					ADS1015_CFG_COMP_POL_SHIFT;
>  			break;

