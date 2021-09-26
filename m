Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89C1418950
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhIZOKZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 10:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhIZOKY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 10:10:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCC6460724;
        Sun, 26 Sep 2021 14:08:45 +0000 (UTC)
Date:   Sun, 26 Sep 2021 15:12:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] iio: imx8qxp-adc: Add driver support for NXP
 IMX8QXP ADC
Message-ID: <20210926151234.2b7b728b@jic23-huawei>
In-Reply-To: <20210925020555.129-2-caihuoqing@baidu.com>
References: <20210925020555.129-1-caihuoqing@baidu.com>
        <20210925020555.129-2-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Sep 2021 10:05:45 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add
> driver support for this ADC.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Hi.  My local build tests throw up a "set but unused" warning which made me take
another look.  I've fixed as commented below.  Shout if that was not the right fix!



> +
> +static void imx8qxp_adc_reg_config(struct imx8qxp_adc *adc, int channel)
> +{
> +	u32 adc_cfg, adc_tctrl, adc_cmdl, adc_cmdh;
> +
> +	/* ADC configuration */
> +	adc_cfg = FIELD_PREP(IMX8QXP_ADC_CFG_PWREN_MASK, 1) |
> +		  FIELD_PREP(IMX8QXP_ADC_CFG_PUDLY_MASK, 0x80)|
> +		  FIELD_PREP(IMX8QXP_ADC_CFG_REFSEL_MASK, 0) |
> +		  FIELD_PREP(IMX8QXP_ADC_CFG_PWRSEL_MASK, 3) |
> +		  FIELD_PREP(IMX8QXP_ADC_CFG_TPRICTRL_MASK, 0);
> +	writel(adc_cfg, adc->regs + IMX8QXP_ADR_ADC_CFG);
> +
> +	/* config the trigger control */
> +	adc_tctrl = FIELD_PREP(IMX8QXP_ADC_TCTRL_TCMD_MASK, 1) |
> +		    FIELD_PREP(IMX8QXP_ADC_TCTRL_TDLY_MASK, 0) |
> +		    FIELD_PREP(IMX8QXP_ADC_TCTRL_TPRI_MASK, IMX8QXP_ADC_TCTRL_TPRI_PRIORITY_HIGH) |
> +		    FIELD_PREP(IMX8QXP_ADC_TCTRL_HTEN_MASK, IMX8QXP_ADC_TCTRL_HTEN_HW_TIRG_DIS);
> +	writel(adc_cfg, adc->regs + IMX8QXP_ADR_ADC_TCTRL(0));
adc_tctrl I assume?  I've changed it to that so shout if that was not what was intented.

> +
> +	/* config the cmd */
> +	adc_cmdl = FIELD_PREP(IMX8QXP_ADC_CMDL_CSCALE_MASK, IMX8QXP_ADC_CMDL_CHANNEL_SCALE_FULL) |
> +		   FIELD_PREP(IMX8QXP_ADC_CMDL_MODE_MASK, IMX8QXP_ADC_CMDL_STANDARD_RESOLUTION) |
> +		   FIELD_PREP(IMX8QXP_ADC_CMDL_DIFF_MASK, IMX8QXP_ADC_CMDL_MODE_SINGLE) |
> +		   FIELD_PREP(IMX8QXP_ADC_CMDL_ABSEL_MASK, IMX8QXP_ADC_CMDL_SEL_A_A_B_CHANNEL) |
> +		   FIELD_PREP(IMX8QXP_ADC_CMDL_ADCH_MASK, channel);
> +	writel(adc_cmdl, adc->regs + IMX8QXP_ADR_ADC_CMDL(0));
> +
> +	adc_cmdh = FIELD_PREP(IMX8QXP_ADC_CMDH_NEXT_MASK, 0) |
> +		   FIELD_PREP(IMX8QXP_ADC_CMDH_LOOP_MASK, 0) |
> +		   FIELD_PREP(IMX8QXP_ADC_CMDH_AVGS_MASK, 7) |
> +		   FIELD_PREP(IMX8QXP_ADC_CMDH_STS_MASK, 0) |
> +		   FIELD_PREP(IMX8QXP_ADC_CMDH_LWI_MASK, IMX8QXP_ADC_CMDH_LWI_INCREMENT_DIS) |
> +		   FIELD_PREP(IMX8QXP_ADC_CMDH_CMPEN_MASK, IMX8QXP_ADC_CMDH_CMPEN_DIS);
> +	writel(adc_cmdh, adc->regs + IMX8QXP_ADR_ADC_CMDH(0));
> +}
> +
