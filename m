Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571E578B241
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 15:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjH1Nus (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 09:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjH1Nuj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 09:50:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53790D2;
        Mon, 28 Aug 2023 06:50:37 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD1D62D8;
        Mon, 28 Aug 2023 15:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693230554;
        bh=7S6OjsrFrLZehR1jxnuEIf4wo8nA0HNbv/KFoX1W8nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBKcWuDTn55xMF11jeTOouNyzLEEBZgtnkuU3Zh0ZN7Gw3VggS/1stZO4ihpGTmcV
         QXS1Dr6LSLD+w6cDrBz6QMHV3RwnzZEDyzfuN4aImzabO4ZkOF7mQ30ZL5RUN6se4+
         cqk3QDphpv22HzhzJ17R4cxZE5hiotmoLdhSKN7A=
Date:   Mon, 28 Aug 2023 16:50:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: ti-dac5571: Sort match tables
Message-ID: <20230828135045.GM14596@pendragon.ideasonboard.com>
References: <20230818173907.323640-1-biju.das.jz@bp.renesas.com>
 <20230818173907.323640-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818173907.323640-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

Thank you for the patch.

On Fri, Aug 18, 2023 at 06:39:07PM +0100, Biju Das wrote:
> Sort ID table alphabetically by name and OF table by compatible
> for single_*bit enums.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> v2:
>  * New patch.
> ---
>  drivers/iio/dac/ti-dac5571.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index 2bb3f76569ee..efb1269a77c1 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -386,6 +386,7 @@ static void dac5571_remove(struct i2c_client *i2c)
>  }
>  
>  static const struct of_device_id dac5571_of_id[] = {
> +	{.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
>  	{.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
>  	{.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
>  	{.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
> @@ -395,12 +396,12 @@ static const struct of_device_id dac5571_of_id[] = {
>  	{.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
>  	{.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
>  	{.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
> -	{.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dac5571_of_id);
>  
>  static const struct i2c_device_id dac5571_id[] = {
> +	{"dac121c081", (kernel_ulong_t)&dac5571_spec[single_12bit] },
>  	{"dac5571", (kernel_ulong_t)&dac5571_spec[single_8bit] },
>  	{"dac6571", (kernel_ulong_t)&dac5571_spec[single_10bit] },
>  	{"dac7571", (kernel_ulong_t)&dac5571_spec[single_12bit] },
> @@ -410,7 +411,6 @@ static const struct i2c_device_id dac5571_id[] = {
>  	{"dac5573", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
>  	{"dac6573", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
>  	{"dac7573", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
> -	{"dac121c081", (kernel_ulong_t)&dac5571_spec[single_12bit] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, dac5571_id);

-- 
Regards,

Laurent Pinchart
