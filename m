Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B912C53D7B2
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiFDQRN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiFDQRN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:17:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8360E9;
        Sat,  4 Jun 2022 09:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09009B8069F;
        Sat,  4 Jun 2022 16:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C90BC385B8;
        Sat,  4 Jun 2022 16:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654359428;
        bh=nEeYiTSlxMDI3AR9zD/fk/tTDhm5zXZl+9DwgfzGx1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k9iUw47bArfPZ8VYa1vl2OYlMy/BBqu/NBW0bFQU5SPKpHeMVgiUrSenKlR4BxSSI
         6i4R0RN5X3eQ5tARbabz7tM+gEBZL0k3Rfj4PBtyJzk3mwL3U0RuELBnE5YDD8YD6y
         JL6TpQnkJ6JO8TA4sC+cNVd51Xdl7WWZjK27wJktMrVQMwQDIgJ3et/3pw16fUOBdw
         JwjxeGbFqgDWrvcJ//g18exWFckakIi1ciNMUA50YqqCDCnEnYp+6o0DwtDfbXukJ0
         TLe3z51scpl5tsrQOZgkt7udfRsgMogoXYO48XWfVdY5NJXRFrzySfx9iXv5uprlUi
         J9eAipDgMj/Jg==
Date:   Sat, 4 Jun 2022 17:26:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 10/10] iio: sx9360: Add pre-charge resistor setting
Message-ID: <20220604172610.1f895c6f@jic23-huawei>
In-Reply-To: <20220429220144.1476049-11-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
        <20220429220144.1476049-11-gwendal@chromium.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Apr 2022 15:01:44 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add ability to set the precharge internal resistance from the device
> tree.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Applied.  Thanks,

Jonathan

> ---
> Changes since v4:
> - Added missing tests when property is not found.
> 
> Changes since v3:
> - Added Review tags.
> 
> Changes since v2:
> - Change kOhms into ohms.
> 
> Changes since v1:
> - Suffix field with kOhms unit.
> 
>  drivers/iio/proximity/sx9360.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index 3ebb30c8a4f61..d9a12e6be6ca6 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -51,6 +51,8 @@
>  #define SX9360_REG_GNRL_REG_2_FREQ(_r)  (SX9360_FOSC_HZ / ((_r) * 8192))
>  
>  #define SX9360_REG_AFE_CTRL1		0x21
> +#define SX9360_REG_AFE_CTRL1_RESFILTIN_MASK GENMASK(3, 0)
> +#define SX9360_REG_AFE_CTRL1_RESFILTIN_0OHMS 0
>  #define SX9360_REG_AFE_PARAM0_PHR	0x22
>  #define SX9360_REG_AFE_PARAM1_PHR	0x23
>  #define SX9360_REG_AFE_PARAM0_PHM	0x24
> @@ -671,7 +673,7 @@ static const struct sx_common_reg_default sx9360_default_regs[] = {
>  	{ SX9360_REG_GNRL_CTRL1, 0x00 },
>  	{ SX9360_REG_GNRL_CTRL2, SX9360_REG_GNRL_CTRL2_PERIOD_102MS },
>  
> -	{ SX9360_REG_AFE_CTRL1, 0x00 },
> +	{ SX9360_REG_AFE_CTRL1, SX9360_REG_AFE_CTRL1_RESFILTIN_0OHMS },
>  	{ SX9360_REG_AFE_PARAM0_PHR, SX9360_REG_AFE_PARAM0_RSVD |
>  		SX9360_REG_AFE_PARAM0_RESOLUTION_128 },
>  	{ SX9360_REG_AFE_PARAM1_PHR, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
> @@ -722,6 +724,17 @@ sx9360_get_default_reg(struct device *dev, int idx,
>  
>  	memcpy(reg_def, &sx9360_default_regs[idx], sizeof(*reg_def));
>  	switch (reg_def->reg) {
> +	case SX9360_REG_AFE_CTRL1:
> +		ret = device_property_read_u32(dev,
> +				"semtech,input-precharge-resistor-ohms",
> +				&raw);
> +		if (ret)
> +			break;
> +
> +		reg_def->def &= ~SX9360_REG_AFE_CTRL1_RESFILTIN_MASK;
> +		reg_def->def |= FIELD_PREP(SX9360_REG_AFE_CTRL1_RESFILTIN_MASK,
> +					   raw / 2000);
> +		break;
>  	case SX9360_REG_AFE_PARAM0_PHR:
>  	case SX9360_REG_AFE_PARAM0_PHM:
>  		ret = device_property_read_u32(dev, "semtech,resolution", &raw);

