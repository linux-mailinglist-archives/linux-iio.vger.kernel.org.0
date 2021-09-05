Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066E0400F58
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 13:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhIELvu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 07:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhIELvu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 07:51:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F4260FBF;
        Sun,  5 Sep 2021 11:50:42 +0000 (UTC)
Date:   Sun, 5 Sep 2021 12:54:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <alex.dewar90@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] iio: imx8qxp-adc: Add the detail for NXP
 i.MX8QuadXPlus ADC driver
Message-ID: <20210905125405.40108aaa@jic23-huawei>
In-Reply-To: <20210830172140.414-4-caihuoqing@baidu.com>
References: <20210830172140.414-1-caihuoqing@baidu.com>
        <20210830172140.414-4-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 01:21:37 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> The NXP i.MX 8QuadXPlus SOC has a new ADC IP, so add the detail for NXP
> i.MX8QuadXPlus ADC driver which includes: probe/remove/pm_ops/iio_dev.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/iio/adc/imx8qxp-adc.c | 513 ++++++++++++++++++++++++++++++++++
>  1 file changed, 513 insertions(+)
> 
> diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
> index aec1b45c8fb9..d39bf382c582 100644
> --- a/drivers/iio/adc/imx8qxp-adc.c
> +++ b/drivers/iio/adc/imx8qxp-adc.c
> @@ -20,23 +20,536 @@
>  
>  #define ADC_DRIVER_NAME		"imx8qxp-adc"
>  
> +/* Register map definition */
> +#define ADC_CTRL		0x10
Give a device specific prefix.  The chances of these shadowing naming in
some future ore header is rather high so let us prevent that now.
IMX8QXP_ADC_STAT  etc.

Naming wise it is usually good to clearly distinguish registers from field
names.  There are lots of ways to do this, but a postfix of _REG or _ADR
works well.

> +#define ADC_STAT		0x14
> +#define ADC_IE			0x18
> +#define ADC_DE			0x1c
> +#define ADC_CFG			0x20
> +#define ADC_FCTRL		0x30
> +#define ADC_SWTRIG		0x34
> +#define ADC_TCTRL(tid)		(0xc0 + tid * 4)
> +#define ADC_CMDH(cid)		(0x100 + cid * 8)
> +#define ADC_CMDL(cid)		(0x104 + cid * 8)
> +#define ADC_RESFIFO		0x300
> +#define ADC_TST			0xffc
> +
> +/* ADC bit shift */
> +#define ADC_IE_FWMIE_SHIFT		(0)

All the brackets around individual numbers are unnecessary.

Cleaner and more consistent way to define register fields is
to use masks only (BIT or GENMASK as appropriate) and then use
PREP_FIELD() and GET_FIELD() to manipulate the actual values.

> +#define ADC_CTRL_FIFO_RESET_SHIFT	(8)
> +#define ADC_CTRL_SOFTWARE_RESET_SHIFT	(1)
> +#define ADC_CTRL_ADC_ENABLE		(0)
> +#define ADC_TCTRL_TCMD_SHIFT		(24)
> +#define ADC_TCTRL_TDLY_SHIFT		(16)
> +#define ADC_TCTRL_TPRI_SHIFT		(8)
> +#define ADC_TCTRL_HTEN_SHIFT		(0)
> +#define ADC_CMDL_CSCALE_SHIFT		(8)
> +#define ADC_CMDL_MODE_SHIFT		(7)
> +#define ADC_CMDL_DIFF_SHIFT		(6)
> +#define ADC_CMDL_ABSEL_SHIFT		(5)
> +#define ADC_CMDL_ADCH_SHIFT		(0)
> +#define ADC_CMDH_NEXT_SHIFT		(24)
> +#define ADC_CMDH_LOOP_SHIFT		(16)
> +#define ADC_CMDH_AVGS_SHIFT		(12)
> +#define ADC_CMDH_STS_SHIFT		(8)
> +#define ADC_CMDH_LWI_SHIFT		(7)
> +#define ADC_CMDH_CMPEN_SHIFT		(0)
> +#define ADC_CFG_PWREN_SHIFT		(28)
> +#define ADC_CFG_PUDLY_SHIFT		(16)
> +#define ADC_CFG_REFSEL_SHIFT		(6)
> +#define ADC_CFG_PWRSEL_SHIFT		(4)
> +#define ADC_CFG_TPRICTRL_SHIFT		(0)
> +#define ADC_FCTRL_FWMARK_SHIFT		(16)
> +#define ADC_FCTRL_FWMARK_MASK		(0x1f << 16)
> +#define ADC_FCTRL_FCOUNT_MASK		(0x1f)
> +
> +/* ADC PARAMETER*/
> +#define ADC_CMDL_CHANNEL_SCALE_FULL		(0x3f)
> +#define ADC_CMDL_SEL_A_A_B_CHANNEL		(0)
> +#define ADC_CMDL_STANDARD_RESOLUTION		(0)
> +#define ADC_CMDL_MODE_SINGLE			(0)
> +#define ADC_CMDH_LWI_INCREMENT_DISABLE		(0)
> +#define ADC_CMDH_CMPEN_DISABLE			(0)
> +#define ADC_PAUSE_ENABLE			(0x80000000)
> +#define ADC_TCTRL_TPRI_PRIORITY_HIGH		(0)
> +
> +#define ADC_TCTRL_HTEN_HARDWARE_TIRGGER_DISABLE	(0)
> +
> +#define MAX_CMD (8)
> +#define MAX_TRIG (8)
> +
> +#define ADC_TIMEOUT		msecs_to_jiffies(100)
> +
> +struct imx8qxp_adc_trigger_ctrl {
> +	u32 tcmd;

I'll guess from the shifts above that these are larger than they
would be if reflecting actual possible values. Please use u8 etc
as appropriate.  Or just store these as caches of the registers and use
GET_FIELD and PREP_FIELD to manipulate them.

Mind you, so far I don't know what they are for ;)

> +	u32 tdly;
> +	u32 tpri;
> +	u32 hten;
> +};
> +
> +struct imx8qxp_adc_cmd_l {
> +	u32 scale;
> +	u32 mode;
> +	u32 diff;
> +	u32 absel;
> +	u32 adch;
> +};
> +
> +struct imx8qxp_adc_cmd_h {
> +	u32 next;
> +	u32 loop;
> +	u32 avgs;
> +	u32 sts;
> +	u32 lwi;
> +	u32 cmpen;
> +};
> +
> +struct imx8qxp_adc_cfg {
> +	u32 pwren;
> +	u32 pudly;
> +	u32 refsel;
> +	u32 pwrsel;
> +	u32 tprictrl;
> +};
> +
> +struct imx8qxp_adc {
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct clk *clk;
> +	struct clk *ipg_clk;
> +
> +	u32 vref_uv;
> +	u32 value;
> +	u32 channel_id;
> +	u32 trigger_id;
As mentioned below, a lot of this doesn't seem to be necessary to cache in here.
If we can keep it local in the driver, that would be better.
> +	u32 cmd_id;
> +
> +	struct regulator *vref;
> +	struct imx8qxp_adc_cmd_l adc_cmd_l[MAX_CMD + 1];
> +	struct imx8qxp_adc_cmd_h adc_cmd_h[MAX_CMD + 1];
> +	struct imx8qxp_adc_trigger_ctrl adc_trigger_ctrl[MAX_TRIG + 1];
> +	struct imx8qxp_adc_cfg adc_cfg;
> +	struct completion completion;
> +};
> +
> +#define IMX8QXP_ADC_CHAN(_idx) {				\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = (_idx),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +}
> +
> +static const struct iio_chan_spec imx8qxp_adc_iio_channels[] = {
> +	IMX8QXP_ADC_CHAN(0),
> +	IMX8QXP_ADC_CHAN(1),
> +	IMX8QXP_ADC_CHAN(2),
> +	IMX8QXP_ADC_CHAN(3),
> +	IMX8QXP_ADC_CHAN(4),
> +	IMX8QXP_ADC_CHAN(5),
> +	IMX8QXP_ADC_CHAN(6),
> +	IMX8QXP_ADC_CHAN(7),
> +};
> +
> +static void imx8qxp_adc_feature_prepare(struct imx8qxp_adc *adc)
> +{
> +	u32 i;
> +
> +	adc->trigger_id = 0;
> +	adc->cmd_id = 0;
> +	adc->channel_id = 0;
> +
> +	for (i = 0; i < MAX_CMD + 1; i++) {
> +		adc->adc_cmd_l[i].scale = 1;
> +		adc->adc_cmd_l[i].mode = 0;
> +		adc->adc_cmd_l[i].diff = 0;
> +		adc->adc_cmd_l[i].absel = 0;
> +		adc->adc_cmd_l[i].adch = 0;
> +		adc->adc_cmd_h[i].next = 0;
> +		adc->adc_cmd_h[i].loop = 0;
> +		adc->adc_cmd_h[i].avgs = 0;
> +		adc->adc_cmd_h[i].sts = 0;
> +		adc->adc_cmd_h[i].lwi = 0;
> +		adc->adc_cmd_h[i].cmpen = 0;
> +	}
> +
> +	for (i = 0; i < MAX_TRIG; i++) {
> +		adc->adc_trigger_ctrl[i].tcmd = 0;
> +		adc->adc_trigger_ctrl[i].tdly = 0;
> +		adc->adc_trigger_ctrl[i].tpri = 0;
> +		adc->adc_trigger_ctrl[i].hten = 0;
> +	}
> +
> +	adc->adc_cfg.pwren = 0;
> +	adc->adc_cfg.pudly = 0;
> +	adc->adc_cfg.refsel = 0;
> +	adc->adc_cfg.pwrsel = 0;
> +	adc->adc_cfg.tprictrl = 0;
> +}
> +
> +static void imx8qxp_adc_reset(struct imx8qxp_adc *adc)
> +{
> +	u32 ctrl;
> +
> +	/*software reset, need to clear the set bit*/
> +	ctrl = readl(adc->regs + ADC_CTRL);
> +	ctrl |= 1 << ADC_CTRL_SOFTWARE_RESET_SHIFT;
> +	writel(ctrl, adc->regs + ADC_CTRL);
> +	udelay(10);
> +	ctrl &= ~(1 << ADC_CTRL_SOFTWARE_RESET_SHIFT);
> +	writel(ctrl, adc->regs + ADC_CTRL);
> +
> +	/* reset the fifo */
> +	ctrl |= 1 << ADC_CTRL_FIFO_RESET_SHIFT;
> +	writel(ctrl, adc->regs + ADC_CTRL);
> +}
> +
> +static void imx8qxp_adc_reg_config(struct imx8qxp_adc *adc)
> +{
> +	u32 adc_cfg, adc_tctrl, adc_cmdl, adc_cmdh;
> +	u32 t_id, c_id;
> +
> +	adc_cfg = adc->adc_cfg.pwren << ADC_CFG_PWREN_SHIFT |
> +		  adc->adc_cfg.pudly << ADC_CFG_PUDLY_SHIFT |
> +		  adc->adc_cfg.refsel << ADC_CFG_REFSEL_SHIFT |
> +		  adc->adc_cfg.pwrsel << ADC_CFG_PWRSEL_SHIFT |
> +		  adc->adc_cfg.tprictrl << ADC_CFG_TPRICTRL_SHIFT;

Lots of FIELD_PREP(), or as I mention above perhaps just put these
directly in place at the point of setting the values in adc->xxx
rather than leaving it to where you write them.
 
> +	writel(adc_cfg, adc->regs + ADC_CFG);
> +
> +	t_id = adc->trigger_id;
> +	adc_tctrl = adc->adc_trigger_ctrl[t_id].tcmd << ADC_TCTRL_TCMD_SHIFT |
> +		    adc->adc_trigger_ctrl[t_id].tdly << ADC_TCTRL_TDLY_SHIFT |
> +		    adc->adc_trigger_ctrl[t_id].tpri << ADC_TCTRL_TPRI_SHIFT |
> +		    adc->adc_trigger_ctrl[t_id].hten << ADC_TCTRL_HTEN_SHIFT;
> +	writel(adc_tctrl, adc->regs + ADC_TCTRL(t_id));
> +
> +	c_id = adc->cmd_id - 1;
> +	adc_cmdl = adc->adc_cmd_l[c_id].scale << ADC_CMDL_CSCALE_SHIFT |
> +		   adc->adc_cmd_l[c_id].mode << ADC_CMDL_MODE_SHIFT |
> +		   adc->adc_cmd_l[c_id].diff << ADC_CMDL_DIFF_SHIFT |
> +		   adc->adc_cmd_l[c_id].absel << ADC_CMDL_ABSEL_SHIFT |
> +		   adc->adc_cmd_l[c_id].adch << ADC_CMDL_ADCH_SHIFT;
> +	writel(adc_cmdl, adc->regs + ADC_CMDL(c_id));
> +
> +	adc_cmdh = adc->adc_cmd_h[c_id].next << ADC_CMDH_NEXT_SHIFT |
> +		   adc->adc_cmd_h[c_id].loop << ADC_CMDH_LOOP_SHIFT |
> +		   adc->adc_cmd_h[c_id].avgs << ADC_CMDH_AVGS_SHIFT |
> +		   adc->adc_cmd_h[c_id].sts << ADC_CMDH_STS_SHIFT |
> +		   adc->adc_cmd_h[c_id].lwi << ADC_CMDH_LWI_SHIFT |
> +		   adc->adc_cmd_h[c_id].cmpen << ADC_CMDH_CMPEN_SHIFT;
> +	writel(adc_cmdh, adc->regs + ADC_CMDH(c_id));
> +}
> +
> +static void imx8qxp_adc_mode_config(struct imx8qxp_adc *adc)
> +{
> +	u32 cmd_id, trigger_id, channel_id;
> +
> +	channel_id = adc->channel_id;
> +	cmd_id = adc->cmd_id - 1;

Call the local variable something different as it's clearly not
what would be thought of as cmd_id elsewhere in the driver.

> +	trigger_id = adc->trigger_id;
> +
> +	/* config the cmd */
> +	adc->adc_cmd_l[cmd_id].scale = ADC_CMDL_CHANNEL_SCALE_FULL;
> +	adc->adc_cmd_l[cmd_id].mode = ADC_CMDL_STANDARD_RESOLUTION;
> +	adc->adc_cmd_l[cmd_id].diff = ADC_CMDL_MODE_SINGLE;
> +	adc->adc_cmd_l[cmd_id].absel = ADC_CMDL_SEL_A_A_B_CHANNEL;
> +	adc->adc_cmd_l[cmd_id].adch = channel_id;
> +
> +	adc->adc_cmd_h[cmd_id].next = 0;
> +	adc->adc_cmd_h[cmd_id].loop = 0;
> +	adc->adc_cmd_h[cmd_id].avgs = 7;
> +	adc->adc_cmd_h[cmd_id].sts = 0;
> +	adc->adc_cmd_h[cmd_id].lwi = ADC_CMDH_LWI_INCREMENT_DISABLE;
> +	adc->adc_cmd_h[cmd_id].cmpen = ADC_CMDH_CMPEN_DISABLE;
> +
> +	/* config the trigger control */
> +	adc->adc_trigger_ctrl[trigger_id].tcmd = adc->cmd_id;
> +	adc->adc_trigger_ctrl[trigger_id].tdly = 0;
> +	adc->adc_trigger_ctrl[trigger_id].tpri = ADC_TCTRL_TPRI_PRIORITY_HIGH;
> +	adc->adc_trigger_ctrl[trigger_id].hten = ADC_TCTRL_HTEN_HARDWARE_TIRGGER_DISABLE;
> +
> +	/* ADC configuration */
> +	adc->adc_cfg.pwren = 1;
> +	adc->adc_cfg.pudly = 0x80;
> +	adc->adc_cfg.refsel = 0;
> +	adc->adc_cfg.pwrsel = 3;
> +	adc->adc_cfg.tprictrl = 0;
> +
> +	imx8qxp_adc_reg_config(adc);
> +}
> +
> +static void imx8qxp_adc_fifo_config(struct imx8qxp_adc *adc)
> +{
> +	u32 fifo_ctrl, interrupt_en;
> +
> +	fifo_ctrl = readl(adc->regs + ADC_FCTRL);
> +	fifo_ctrl &= ~ADC_FCTRL_FWMARK_MASK;
> +	/* set the watermark level to 1 */
> +	fifo_ctrl |= 0 << ADC_FCTRL_FWMARK_SHIFT;
FIELD_PREP()

> +	writel(fifo_ctrl, adc->regs + ADC_FCTRL);
> +
> +	/* FIFO Watermark Interrupt Enable */
> +	interrupt_en = readl(adc->regs + ADC_IE);
> +	interrupt_en |= 1 << ADC_IE_FWMIE_SHIFT;
FIELD_PREP()

> +	writel(interrupt_en, adc->regs + ADC_IE);
> +}
> +
> +static void imx8qxp_adc_disable(struct imx8qxp_adc *adc)
> +{
> +	u32 ctrl;
> +
> +	ctrl = readl(adc->regs + ADC_CTRL) & ~(1 << ADC_CTRL_ADC_ENABLE);

~BIT(ADC_CTRL_ADC_ENABLE) or appropriate FIELD_PREP

> +	writel(ctrl, adc->regs + ADC_CTRL);
> +}
> +
> +static int imx8qxp_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = adc->dev;
> +
> +	u32 channel;
> +	u32 ctrl;
> +	long ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		pm_runtime_get_sync(dev);
> +
> +		mutex_lock(&indio_dev->mlock);
Please do not use mlock directly.  If you are protecting driver local data
(so stuff in iio_priv()) or hardware resources define your own local lock
in iio_priv() with well documented scope.

If the aim is to prevent racing with IIO core state changes, then use
iio_device_claim_direct().  That only applies if the driver supports buffered
mode as otherwise you won't get state changes.

> +		reinit_completion(&adc->completion);
> +
> +		channel = chan->channel & 0x07;
> +		adc->channel_id = channel;
> +		adc->cmd_id = 1;
> +		adc->trigger_id = 0;
> +		imx8qxp_adc_mode_config(adc);

Why not pass channel, cmd_id and trigger_id into this function rather than using
state in iio_priv() for them?  I checked adc->channel_id and it is only used
in that function so you should not have it in the iio_priv() structure at all.
For the others I haven't checked but would guess similar?

> +
> +		imx8qxp_adc_fifo_config(adc);
> +
> +		/* adc enable */
> +		ctrl = readl(adc->regs + ADC_CTRL) | (1 << ADC_CTRL_ADC_ENABLE);
> +		writel(ctrl, adc->regs + ADC_CTRL);
> +		/* adc start */
> +		writel(1 << adc->trigger_id, adc->regs + ADC_SWTRIG);
> +
> +		ret = wait_for_completion_interruptible_timeout
> +				(&adc->completion, ADC_TIMEOUT);

Readabilty of this line is hurt by it being broken up so as long as it is under 100 chars
I'd prefer it one line.

> +
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_sync_autosuspend(dev);
> +
> +		if (ret == 0) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return -ETIMEDOUT;
> +		}
> +		if (ret < 0) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return ret;
> +		}
> +
> +		*val = adc->value;
As mentioned below, why not do the register read here rather than caching it before
calling complete()?

> +		mutex_unlock(&indio_dev->mlock);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		adc->vref_uv = regulator_get_voltage(adc->vref);
Why cache it? Use a local variable.

> +		*val = adc->vref_uv / 1000;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = clk_get_rate(adc->clk) / 3;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t imx8qxp_adc_isr(int irq, void *dev_id)
> +{
> +	struct imx8qxp_adc *adc = (struct imx8qxp_adc *)dev_id;
> +
> +	u32 fifo_count;
> +
> +	fifo_count = readl(adc->regs + ADC_FCTRL)
> +			& ADC_FCTRL_FCOUNT_MASK;

One line as still well under 80 chars.  As mentioned above, FIELD_GET()
preferred as means the reviewer / reader doesn't need to go check this
mask is from bit 0 upwards.

> +
> +	if (fifo_count) {
> +		adc->value = (readl(adc->regs + ADC_RESFIFO) & 0xffff) >> 3;
> +		complete(&adc->completion);

Why do the adc->value read here rather than in the completion?
If there is a potential race I'd expect it to also affect adc->value


> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int imx8qxp_adc_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +				  unsigned int writeval, unsigned int *readval)
> +{
> +	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = adc->dev;
> +
> +	if (!readval || reg % 4 || reg > ADC_TST)
> +		return -EINVAL;
> +
> +	pm_runtime_get_sync(dev);
> +
> +	*readval = readl(adc->regs + reg);
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_sync_autosuspend(dev);
> +
> +	return 0;
> +}
> +
> +static const struct iio_info imx8qxp_adc_iio_info = {
> +	.read_raw = &imx8qxp_adc_read_raw,
> +	.debugfs_reg_access = &imx8qxp_adc_reg_access,
> +};
> +
>  static int imx8qxp_adc_probe(struct platform_device *pdev)
>  {
> +	struct imx8qxp_adc *adc;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &pdev->dev;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev) {
> +		dev_err(dev, "Failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	adc = iio_priv(indio_dev);
> +	adc->dev = dev;
> +
> +	adc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(adc->regs))
> +		return PTR_ERR(adc->regs);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	adc->clk = devm_clk_get(dev, "per");
> +	if (IS_ERR(adc->clk)) {
> +		ret = PTR_ERR(adc->clk);
> +		dev_err(dev, "Failed getting clock, err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	adc->ipg_clk = devm_clk_get(dev, "ipg");
> +	if (IS_ERR(adc->ipg_clk)) {
> +		ret = PTR_ERR(adc->ipg_clk);
> +		dev_err(dev, "Failed getting clock, err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	adc->vref = devm_regulator_get(dev, "vref");
> +	if (IS_ERR(adc->vref)) {
> +		ret = PTR_ERR(adc->vref);
> +		dev_err(dev,
> +			"Failed getting reference voltage, err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&adc->completion);
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->info = &imx8qxp_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = imx8qxp_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(imx8qxp_adc_iio_channels);
> +
> +	ret = devm_request_irq(dev, irq, imx8qxp_adc_isr, 0, dev_name(dev), adc);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
> +		return ret;
> +	}
> +
> +	imx8qxp_adc_feature_prepare(adc);
> +	imx8qxp_adc_reset(adc);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		imx8qxp_adc_disable(adc);
> +		dev_err(dev, "Couldn't register the device.\n");
> +		return ret;
> +	}
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 50);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);
> +
>  	return 0;
>  }
>  
>  static int imx8qxp_adc_remove(struct platform_device *pdev)
>  {
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = adc->dev;
> +
> +	pm_runtime_get_sync(dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	imx8qxp_adc_disable(adc);
> +
> +	pm_runtime_disable(dev);

Looks racey.  Would expect runtime_disable() before
the device is finally turned off with adc_disable() and
then decrement the reference counter.

> +	pm_runtime_put_noidle(dev);
> +
>  	return 0;
>  }
>  
>  static int imx8qxp_adc_runtime_suspend(struct device *dev)
>  {
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> +
> +	imx8qxp_adc_disable(adc);
> +
> +	clk_disable_unprepare(adc->clk);
> +	clk_disable_unprepare(adc->ipg_clk);
> +	regulator_disable(adc->vref);
> +
>  	return 0;
>  }
>  
>  static int imx8qxp_adc_runtime_resume(struct device *dev)
>  {
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regulator_enable(adc->vref);
> +	if (ret) {
> +		dev_err(dev, "Can't enable adc reference top voltage, err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(adc->clk);
> +	if (ret) {
> +		dev_err(dev, "Could not prepare or enable clock.\n");
> +		regulator_disable(adc->vref);
Use a pattern like

	goto err_disable_reg;

etc and have a single error handling block at the end of the function.

> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(adc->ipg_clk);
> +	if (ret) {
> +		dev_err(dev, "Could not prepare or enable clock.\n");
> +		clk_disable_unprepare(adc->clk);
> +		regulator_disable(adc->vref);
> +		return ret;
> +	}
> +	imx8qxp_adc_reset(adc);
> +
>  	return 0;
>  }
>  

