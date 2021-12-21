Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A460C47C07A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Dec 2021 14:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhLUNLw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Dec 2021 08:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUNLw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Dec 2021 08:11:52 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5E8C061574;
        Tue, 21 Dec 2021 05:11:52 -0800 (PST)
Date:   Tue, 21 Dec 2021 21:11:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1640092309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oprC6AqEZlljn0whAPn3fKd+gyRj8zLKxcVCNMVOEWk=;
        b=KnfFQwdVIAt5Vea137fPlU1OSK3PIlKgUY8Pel9OyjFANc9X1rJNBKMUYqrHf/zRGxNMU+
        VPQl6BnNL88QDhDelE36NR31bF7DevlQzE0fPEHlnxz+81z05pFLOa8SGizoh+zbHOfzec
        MotC2WF7quAR5fGuMLty1iLuahHPgFU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     haibo.chen@nxp.com
Cc:     jic23@kernel.org, robh+dt@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, shawnguo@kernel.org, festevam@gmail.com
Subject: Re: [PATCH 1/2] MAINTAINERS: add imx7d/imx6sx/imx6ul/imx8qxp and
 vf610 adc maintainer
Message-ID: <20211221131124.GA23836@chq-T47>
References: <1640073000-32629-1-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1640073000-32629-1-git-send-email-haibo.chen@nxp.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21 12月 21 15:49:59, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Add myself as imx7d/imx6sx/imx6ul/imx8qxp and vf610 adc maintainer.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> 
> ---
> 
> First, thanks Cai Huoqing upstream the i.MX 8QXP ADC driver, really appreciate!
> 
> For some unknown issue, I miss all imx8qxp adc related mail threads,
> now I actively maintain all i.MX ADC downstream drivers, so add myself
> here as maintainer, and make sure I can be cc/to when there is any new patch.
> 
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c87a3f5e302a..210bded08641 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13792,11 +13792,23 @@ F:	drivers/gpu/drm/imx/dcss/
>  
>  NXP i.MX 8QXP ADC DRIVER
>  M:	Cai Huoqing <cai.huoqing@linux.dev>
> +M:	Haibo Chen <haibo.chen@nxp.com>
> +L:	linux-imx@nxp.com
This driver is based on the work of Haibo Chen <haibo.chen@nxp.com>,
it's ok to add this, here.

Reviewed-by: Cai Huoqing <cai.huoqing@linux.dev>

Thanks,
Cai
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
>  F:	drivers/iio/adc/imx8qxp-adc.c
>  
> +NXP i.MX 7D/6SX/6UL AND VF610 ADC DRIVER
> +M:	Haibo Chen <haibo.chen@nxp.com>
> +L:	linux-iio@vger.kernel.org
> +L:	linux-imx@nxp.com
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
> +F:	Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> +F:	drivers/iio/adc/imx7d_adc.c
> +F:	drivers/iio/adc/vf610_adc.c
> +
>  NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
>  M:	Jagan Teki <jagan@amarulasolutions.com>
>  S:	Maintained
> -- 
> 2.25.1
> 
