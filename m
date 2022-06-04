Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A1953D7A6
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbiFDQM2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiFDQM1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:12:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383F2F393;
        Sat,  4 Jun 2022 09:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79AD8B8069F;
        Sat,  4 Jun 2022 16:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E8C34119;
        Sat,  4 Jun 2022 16:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654359144;
        bh=I8VlVQXjXLlp2GgiRWf6bxeQeuPAX7TTyjidHlAX0W8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nnCMDimlMCnE712voSSEiSnrEN9JFTac4EnpnJ2Q/bWz/1zk8lNO8m+H4bCdZxzYv
         Qoxcc1C/zg5ECvySrx3p3iEyxZkzicegcaaVMx+NPhRczja0K7+QLFKtQh29CRq6tf
         8y2K56jJ82W2JLuL5EfPKm/dYicbX6pnalswyWcnqCznLROBoomIVLVdjoiZIPukPP
         GAGgjaXM7+0+QZ1P+CjwaF775rMvLr8Og9NB5gdp5j+f6Bn9mx8mkO9dHkZdJ8Hblg
         WVWWp2m1w40GwhFZ0cAwlA5XbQz6fwgSVx6+yJCUInJcSWnJTmElwhfW+uzMEHGpo2
         3xPAIpZJ4rVPA==
Date:   Sat, 4 Jun 2022 17:21:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 04/10] iio: sx9324: Add precharge internal resistance
 setting
Message-ID: <20220604172126.1871be4d@jic23-huawei>
In-Reply-To: <20220429220144.1476049-5-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
        <20220429220144.1476049-5-gwendal@chromium.org>
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

On Fri, 29 Apr 2022 15:01:38 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add ability to set the precharge internal resistance from the device
> tree.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Applied
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
> - Split patch in 2.
> 
>  drivers/iio/proximity/sx9324.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index a7d9a53692a6d..8eec73f7641ee 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -72,6 +72,7 @@
>  #define SX9324_REG_AFE_CTRL8		0x2c
>  #define SX9324_REG_AFE_CTRL8_RESERVED	0x10
>  #define SX9324_REG_AFE_CTRL8_RESFILTIN_4KOHM 0x02
> +#define SX9324_REG_AFE_CTRL8_RESFILTIN_MASK GENMASK(3, 0)
>  #define SX9324_REG_AFE_CTRL9		0x2d
>  #define SX9324_REG_AFE_CTRL9_AGAIN_1	0x08
>  
> @@ -893,6 +894,18 @@ sx9324_get_default_reg(struct device *dev, int idx,
>  		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL4_RESOLUTION_MASK,
>  					   raw);
>  		break;
> +	case SX9324_REG_AFE_CTRL8:
> +		ret = device_property_read_u32(dev,
> +				"semtech,input-precharge-resistor-ohms",
> +				&raw);
> +		if (ret)
> +			break;
> +
> +		reg_def->def &= ~SX9324_REG_AFE_CTRL8_RESFILTIN_MASK;
> +		reg_def->def |= FIELD_PREP(SX9324_REG_AFE_CTRL8_RESFILTIN_MASK,
> +					   raw / 2000);
> +		break;
> +
>  	case SX9324_REG_ADV_CTRL5:
>  		ret = device_property_read_u32(dev, "semtech,startup-sensor",
>  					       &start);

