Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A965041885D
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 13:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhIZLj0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 07:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhIZLj0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 07:39:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1ED061038;
        Sun, 26 Sep 2021 11:37:47 +0000 (UTC)
Date:   Sun, 26 Sep 2021 12:41:37 +0100
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
Message-ID: <20210926124137.0121a68d@jic23-huawei>
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
Hi Cai Huoqing,

Having had a 'final' read through of the driver, I am basically happy
to merge this after Fabio has had time for another look (plus anyone else
who wishes to of course!) 

There were a few minor things inline though that I'll tidy up whilst applying.
If you do a v7 for some other reason please sort these out as well.

Thanks,

Jonathan

...

> +#define IMX8QXP_ADR_ADC_TCTRL(tid)	(0xc0 + tid * 4)
> +#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x100 + cid * 8)
> +#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x104 + cid * 8)

In macros, it is always a good idea to put brackets around
any use of parameters so as to avoid potential odd issues
due to operator precedence.

(0xc0 + (tid) * 4)

> +#define IMX8QXP_ADR_ADC_RESFIFO		0x300
> +#define IMX8QXP_ADR_ADC_TST		0xffc

...

> +
> +struct imx8qxp_adc {
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct clk *clk;
> +	struct clk *ipg_clk;
> +	struct regulator *vref;
> +	struct mutex lock;

A lock should have documentation to identify what it's precise scope is.
I can add

/* Serialise ADC channel reads */
above the lock definition whilst applying if you aren't doing a v7 for
other reasons.

> +	struct completion completion;
> +};
...


> +
> +static irqreturn_t imx8qxp_adc_isr(int irq, void *dev_id)
> +{
> +	struct imx8qxp_adc *adc = dev_id;
> +

Really minor, but the blank line here doesn't help readability much and
is inconsistent with the rest of the driver.  I might remove this whilst
applying if nothing else comes up.

> +	u32 fifo_count;
> +
> +	fifo_count = FIELD_GET(IMX8QXP_ADC_FCTRL_FCOUNT_MASK,
> +			       readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL));
> +
> +	if (fifo_count)
> +		complete(&adc->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
...
