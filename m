Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E6B78B30A
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjH1O06 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 10:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjH1O04 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 10:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C0DA;
        Mon, 28 Aug 2023 07:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAAB36425F;
        Mon, 28 Aug 2023 14:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A308C433C8;
        Mon, 28 Aug 2023 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693232813;
        bh=Im9uKrsuqtxYcPj8f8Es5nIyp1HOu1CADSd21ZX1pHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JNO/tLkYvlsyBq8t1LspPbgOJcOkuX3rDtVBWupKkHvcee+znosLDHXCsfBS1lYP0
         j2Bz+u8AVViRbgHvaW98WbP0iLO5Ihqm/cTXv+cyR/rhdFz3KxXcQ1d86dJPc0YHap
         CjJW3Buq0i13I2ow3eqSy5Tmav8dGmtn/3nCmk8HE07a+XSG482W7wk6/VY/HfsR+u
         AaCoEoQEC9Qow3KNGTgYMjgm922nloGvwcMcKPG9i9w97kzIjla3GEaDFCewZPsjwM
         crhNM7sTw7SjOfbYHBc4YkJfJFFcZy+pUSjPD5edfFoNL+mnN9TmlFBYHjBeV+0pu/
         kyJyI1um6Xyig==
Date:   Mon, 28 Aug 2023 15:27:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Message-ID: <20230828152712.65414a75@jic23-huawei>
In-Reply-To: <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
        <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Aug 2023 08:56:00 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> Sort OF table alphabetically by compatibles.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
I adjusted this for not taking patch 4 and applied.

Thanks,

Jonathan

> ---
> v2:
>  * New patch
> ---
>  drivers/iio/magnetometer/ak8975.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 295b7be5e36d..7cc443a86995 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -1073,8 +1073,8 @@ static const struct i2c_device_id ak8975_id[] = {
>  MODULE_DEVICE_TABLE(i2c, ak8975_id);
>  
>  static const struct of_device_id ak8975_of_match[] = {
> -	{ .compatible = "asahi-kasei,ak8975", .data = &ak_def_array[AK8975] },
>  	{ .compatible = "asahi-kasei,ak8963", .data = &ak_def_array[AK8963] },
> +	{ .compatible = "asahi-kasei,ak8975", .data = &ak_def_array[AK8975] },
>  	{ .compatible = "asahi-kasei,ak09911", .data = &ak_def_array[AK09911] },
>  	{ .compatible = "asahi-kasei,ak09912", .data = &ak_def_array[AK09912] },
>  	{ .compatible = "asahi-kasei,ak09916", .data = &ak_def_array[AK09916] },

