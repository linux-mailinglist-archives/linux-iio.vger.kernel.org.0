Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2F1418914
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 15:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhIZNoG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 09:44:06 -0400
Received: from mx22.baidu.com ([220.181.50.185]:42616 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231723AbhIZNoE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 09:44:04 -0400
Received: from BC-Mail-Ex21.internal.baidu.com (unknown [172.31.51.15])
        by Forcepoint Email with ESMTPS id E044879521FF6EFDDC9A;
        Sun, 26 Sep 2021 21:42:24 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex21.internal.baidu.com (172.31.51.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sun, 26 Sep 2021 21:42:24 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 26
 Sep 2021 21:42:24 +0800
Date:   Sun, 26 Sep 2021 21:42:23 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] iio: imx8qxp-adc: Add driver support for NXP
 IMX8QXP ADC
Message-ID: <20210926134223.GA605@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210925020555.129-1-caihuoqing@baidu.com>
 <20210925020555.129-2-caihuoqing@baidu.com>
 <20210926124137.0121a68d@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210926124137.0121a68d@jic23-huawei>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex10.internal.baidu.com (10.127.64.33) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 26 9月 21 12:41:37, Jonathan Cameron wrote:
> On Sat, 25 Sep 2021 10:05:45 +0800
> Cai Huoqing <caihuoqing@baidu.com> wrote:
> 
> > The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add
> > driver support for this ADC.
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Hi Jonathan
Thanks for your feedback.
> Hi Cai Huoqing,
> 
> Having had a 'final' read through of the driver, I am basically happy
> to merge this after Fabio has had time for another look (plus anyone else
> who wishes to of course!) 
> 
> There were a few minor things inline though that I'll tidy up whilst applying.
Feel free to fix these directly.
> If you do a v7 for some other reason please sort these out as well.
Sure, if v7 is needed for other issue, I will add these changes BTW.

Many thanks,
Cai

> 
> Thanks,
> 
> Jonathan
> 
> ...
> 
> > +#define IMX8QXP_ADR_ADC_TCTRL(tid)	(0xc0 + tid * 4)
> > +#define IMX8QXP_ADR_ADC_CMDH(cid)	(0x100 + cid * 8)
> > +#define IMX8QXP_ADR_ADC_CMDL(cid)	(0x104 + cid * 8)
> 
> In macros, it is always a good idea to put brackets around
> any use of parameters so as to avoid potential odd issues
> due to operator precedence.
> 
> (0xc0 + (tid) * 4)
> 
> > +#define IMX8QXP_ADR_ADC_RESFIFO		0x300
> > +#define IMX8QXP_ADR_ADC_TST		0xffc
> 
> ...
> 
> > +
> > +struct imx8qxp_adc {
> > +	struct device *dev;
> > +	void __iomem *regs;
> > +	struct clk *clk;
> > +	struct clk *ipg_clk;
> > +	struct regulator *vref;
> > +	struct mutex lock;
> 
> A lock should have documentation to identify what it's precise scope is.
> I can add
> 
> /* Serialise ADC channel reads */
> above the lock definition whilst applying if you aren't doing a v7 for
> other reasons.
> 
> > +	struct completion completion;
> > +};
> ...
> 
> 
> > +
> > +static irqreturn_t imx8qxp_adc_isr(int irq, void *dev_id)
> > +{
> > +	struct imx8qxp_adc *adc = dev_id;
> > +
> 
> Really minor, but the blank line here doesn't help readability much and
> is inconsistent with the rest of the driver.  I might remove this whilst
> applying if nothing else comes up.
> 
> > +	u32 fifo_count;
> > +
> > +	fifo_count = FIELD_GET(IMX8QXP_ADC_FCTRL_FCOUNT_MASK,
> > +			       readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL));
> > +
> > +	if (fifo_count)
> > +		complete(&adc->completion);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> ...
