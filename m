Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60E71E25EB
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgEZPrC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 11:47:02 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:34038 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728303AbgEZPrB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 11:47:01 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QFc07m031285;
        Tue, 26 May 2020 17:46:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=b4wjkm6Iy2b2Lpx8W3eFEs6QIfIzRY7QOu/YTAOG5RA=;
 b=M9QJgbKVx5NiL1aLnuBuNOQYcTiRnBZCjSPwdlyDWxqhCBIileZ0yicHoeWDopWPCbtq
 +HdwPUcvogz8DKoUiMPlasibINLFgL0lRZ0mYFIRfSGiV4nb18RX22mYtoadiAA0uqgM
 X/lve2MVKCx7y/L6wKzfrvT/SsW2AgJFHqPd7swybFvHQKDXKv2JGWIxMr1SbqR3mWQ6
 Wumwg+h8orYs2n5Um+ciHX9DQlx+4xqxj2KSakfbTBW8E5y2YX4Egm8RbH5YLvFDJHGv
 KMyO8kiA44cxe+l178n43BuQpwEhj1YBdCwzMEyl2OYmSK2dmeKK700d1f9vlRA1NIfW VQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316sa20jss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 17:46:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 08D80100034;
        Tue, 26 May 2020 17:46:43 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DAF162B7630;
        Tue, 26 May 2020 17:46:43 +0200 (CEST)
Received: from [10.211.14.197] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 17:46:42 +0200
Subject: Re: [PATCH v3] iio: stm32-adc: remove usage of iio_priv_to_dev()
 helper
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <olivier.moysan@st.com>
References: <20200525090720.72696-1-alexandru.ardelean@analog.com>
 <20200526134448.7328-1-alexandru.ardelean@analog.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <cc5dc422-d1a6-ab95-a1c3-a8e0b38a145a@st.com>
Date:   Tue, 26 May 2020 17:46:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526134448.7328-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/26/20 3:44 PM, Alexandru Ardelean wrote:
> We may want to get rid of the iio_priv_to_dev() helper. The reason is that
> we will hide some of the members of the iio_dev structure (to prevent
> drivers from accessing them directly), and that will also mean hiding the
> implementation of the iio_priv_to_dev() helper inside the IIO core.
> 
> Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
> may not be fast anymore, so a general idea is to try to get rid of the
> iio_priv_to_dev() altogether.
> The iio_priv() helper won't be affected by the rework, as the iio_dev
> struct will keep a reference to the private information.
> 
> For this driver, not using iio_priv_to_dev(), means reworking some paths to
> pass the iio device and using iio_priv() to access the private information.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Changelog v2 -> v3:
> - update doc-strings; warnings show-up during build with W=1 arg
> 
> Changelog v1 -> v2:
> - converted to pass reference to IIO device in function hooks (vs
>   reference
>   to adc private data)
> 
>  drivers/iio/adc/stm32-adc.c | 118 +++++++++++++++++++-----------------
>  1 file changed, 63 insertions(+), 55 deletions(-)

Hi Alexandru,

Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Thanks,
Fabrice

> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index ae622ee6d08c..1dd97ec5571c 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -162,10 +162,10 @@ struct stm32_adc_cfg {
>  	struct stm32_adc_trig_info	*trigs;
>  	bool clk_required;
>  	bool has_vregready;
> -	int (*prepare)(struct stm32_adc *);
> -	void (*start_conv)(struct stm32_adc *, bool dma);
> -	void (*stop_conv)(struct stm32_adc *);
> -	void (*unprepare)(struct stm32_adc *);
> +	int (*prepare)(struct iio_dev *);
> +	void (*start_conv)(struct iio_dev *, bool dma);
> +	void (*stop_conv)(struct iio_dev *);
> +	void (*unprepare)(struct iio_dev *);
>  	const unsigned int *smp_cycles;
>  };
>  
> @@ -538,10 +538,11 @@ static void stm32_adc_set_res(struct stm32_adc *adc)
>  
>  static int stm32_adc_hw_stop(struct device *dev)
>  {
> -	struct stm32_adc *adc = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  
>  	if (adc->cfg->unprepare)
> -		adc->cfg->unprepare(adc);
> +		adc->cfg->unprepare(indio_dev);
>  
>  	if (adc->clk)
>  		clk_disable_unprepare(adc->clk);
> @@ -551,7 +552,8 @@ static int stm32_adc_hw_stop(struct device *dev)
>  
>  static int stm32_adc_hw_start(struct device *dev)
>  {
> -	struct stm32_adc *adc = dev_get_drvdata(dev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	int ret;
>  
>  	if (adc->clk) {
> @@ -563,7 +565,7 @@ static int stm32_adc_hw_start(struct device *dev)
>  	stm32_adc_set_res(adc);
>  
>  	if (adc->cfg->prepare) {
> -		ret = adc->cfg->prepare(adc);
> +		ret = adc->cfg->prepare(indio_dev);
>  		if (ret)
>  			goto err_clk_dis;
>  	}
> @@ -579,7 +581,7 @@ static int stm32_adc_hw_start(struct device *dev)
>  
>  /**
>   * stm32f4_adc_start_conv() - Start conversions for regular channels.
> - * @adc: stm32 adc instance
> + * @indio_dev: IIO device instance
>   * @dma: use dma to transfer conversion result
>   *
>   * Start conversions for regular channels.
> @@ -587,8 +589,10 @@ static int stm32_adc_hw_start(struct device *dev)
>   * conversions, in IIO buffer modes. Otherwise, use ADC interrupt with direct
>   * DR read instead (e.g. read_raw, or triggered buffer mode without DMA).
>   */
> -static void stm32f4_adc_start_conv(struct stm32_adc *adc, bool dma)
> +static void stm32f4_adc_start_conv(struct iio_dev *indio_dev, bool dma)
>  {
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
>  	stm32_adc_set_bits(adc, STM32F4_ADC_CR1, STM32F4_SCAN);
>  
>  	if (dma)
> @@ -605,8 +609,10 @@ static void stm32f4_adc_start_conv(struct stm32_adc *adc, bool dma)
>  		stm32_adc_set_bits(adc, STM32F4_ADC_CR2, STM32F4_SWSTART);
>  }
>  
> -static void stm32f4_adc_stop_conv(struct stm32_adc *adc)
> +static void stm32f4_adc_stop_conv(struct iio_dev *indio_dev)
>  {
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
>  	stm32_adc_clr_bits(adc, STM32F4_ADC_CR2, STM32F4_EXTEN_MASK);
>  	stm32_adc_clr_bits(adc, STM32F4_ADC_SR, STM32F4_STRT);
>  
> @@ -615,8 +621,9 @@ static void stm32f4_adc_stop_conv(struct stm32_adc *adc)
>  			   STM32F4_ADON | STM32F4_DMA | STM32F4_DDS);
>  }
>  
> -static void stm32h7_adc_start_conv(struct stm32_adc *adc, bool dma)
> +static void stm32h7_adc_start_conv(struct iio_dev *indio_dev, bool dma)
>  {
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	enum stm32h7_adc_dmngt dmngt;
>  	unsigned long flags;
>  	u32 val;
> @@ -635,9 +642,9 @@ static void stm32h7_adc_start_conv(struct stm32_adc *adc, bool dma)
>  	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTART);
>  }
>  
> -static void stm32h7_adc_stop_conv(struct stm32_adc *adc)
> +static void stm32h7_adc_stop_conv(struct iio_dev *indio_dev)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	int ret;
>  	u32 val;
>  
> @@ -652,9 +659,9 @@ static void stm32h7_adc_stop_conv(struct stm32_adc *adc)
>  	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR, STM32H7_DMNGT_MASK);
>  }
>  
> -static int stm32h7_adc_exit_pwr_down(struct stm32_adc *adc)
> +static int stm32h7_adc_exit_pwr_down(struct iio_dev *indio_dev)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	int ret;
>  	u32 val;
>  
> @@ -690,9 +697,9 @@ static void stm32h7_adc_enter_pwr_down(struct stm32_adc *adc)
>  	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_DEEPPWD);
>  }
>  
> -static int stm32h7_adc_enable(struct stm32_adc *adc)
> +static int stm32h7_adc_enable(struct iio_dev *indio_dev)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	int ret;
>  	u32 val;
>  
> @@ -713,9 +720,9 @@ static int stm32h7_adc_enable(struct stm32_adc *adc)
>  	return ret;
>  }
>  
> -static void stm32h7_adc_disable(struct stm32_adc *adc)
> +static void stm32h7_adc_disable(struct iio_dev *indio_dev)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	int ret;
>  	u32 val;
>  
> @@ -730,12 +737,12 @@ static void stm32h7_adc_disable(struct stm32_adc *adc)
>  
>  /**
>   * stm32h7_adc_read_selfcalib() - read calibration shadow regs, save result
> - * @adc: stm32 adc instance
> + * @indio_dev: IIO device instance
>   * Note: Must be called once ADC is enabled, so LINCALRDYW[1..6] are writable
>   */
> -static int stm32h7_adc_read_selfcalib(struct stm32_adc *adc)
> +static int stm32h7_adc_read_selfcalib(struct iio_dev *indio_dev)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	int i, ret;
>  	u32 lincalrdyw_mask, val;
>  
> @@ -774,12 +781,12 @@ static int stm32h7_adc_read_selfcalib(struct stm32_adc *adc)
>  
>  /**
>   * stm32h7_adc_restore_selfcalib() - Restore saved self-calibration result
> - * @adc: stm32 adc instance
> + * @indio_dev: IIO device instance
>   * Note: ADC must be enabled, with no on-going conversions.
>   */
> -static int stm32h7_adc_restore_selfcalib(struct stm32_adc *adc)
> +static int stm32h7_adc_restore_selfcalib(struct iio_dev *indio_dev)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	int i, ret;
>  	u32 lincalrdyw_mask, val;
>  
> @@ -847,12 +854,12 @@ static int stm32h7_adc_restore_selfcalib(struct stm32_adc *adc)
>  
>  /**
>   * stm32h7_adc_selfcalib() - Procedure to calibrate ADC
> - * @adc: stm32 adc instance
> + * @indio_dev: IIO device instance
>   * Note: Must be called once ADC is out of power down.
>   */
> -static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
> +static int stm32h7_adc_selfcalib(struct iio_dev *indio_dev)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	int ret;
>  	u32 val;
>  
> @@ -903,7 +910,7 @@ static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
>  
>  /**
>   * stm32h7_adc_prepare() - Leave power down mode to enable ADC.
> - * @adc: stm32 adc instance
> + * @indio_dev: IIO device instance
>   * Leave power down mode.
>   * Configure channels as single ended or differential before enabling ADC.
>   * Enable ADC.
> @@ -912,30 +919,31 @@ static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
>   * - Only one input is selected for single ended (e.g. 'vinp')
>   * - Two inputs are selected for differential channels (e.g. 'vinp' & 'vinn')
>   */
> -static int stm32h7_adc_prepare(struct stm32_adc *adc)
> +static int stm32h7_adc_prepare(struct iio_dev *indio_dev)
>  {
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	int calib, ret;
>  
> -	ret = stm32h7_adc_exit_pwr_down(adc);
> +	ret = stm32h7_adc_exit_pwr_down(indio_dev);
>  	if (ret)
>  		return ret;
>  
> -	ret = stm32h7_adc_selfcalib(adc);
> +	ret = stm32h7_adc_selfcalib(indio_dev);
>  	if (ret < 0)
>  		goto pwr_dwn;
>  	calib = ret;
>  
>  	stm32_adc_writel(adc, STM32H7_ADC_DIFSEL, adc->difsel);
>  
> -	ret = stm32h7_adc_enable(adc);
> +	ret = stm32h7_adc_enable(indio_dev);
>  	if (ret)
>  		goto pwr_dwn;
>  
>  	/* Either restore or read calibration result for future reference */
>  	if (calib)
> -		ret = stm32h7_adc_restore_selfcalib(adc);
> +		ret = stm32h7_adc_restore_selfcalib(indio_dev);
>  	else
> -		ret = stm32h7_adc_read_selfcalib(adc);
> +		ret = stm32h7_adc_read_selfcalib(indio_dev);
>  	if (ret)
>  		goto disable;
>  
> @@ -944,16 +952,18 @@ static int stm32h7_adc_prepare(struct stm32_adc *adc)
>  	return 0;
>  
>  disable:
> -	stm32h7_adc_disable(adc);
> +	stm32h7_adc_disable(indio_dev);
>  pwr_dwn:
>  	stm32h7_adc_enter_pwr_down(adc);
>  
>  	return ret;
>  }
>  
> -static void stm32h7_adc_unprepare(struct stm32_adc *adc)
> +static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
>  {
> -	stm32h7_adc_disable(adc);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +
> +	stm32h7_adc_disable(indio_dev);
>  	stm32h7_adc_enter_pwr_down(adc);
>  }
>  
> @@ -1160,7 +1170,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>  
>  	stm32_adc_conv_irq_enable(adc);
>  
> -	adc->cfg->start_conv(adc, false);
> +	adc->cfg->start_conv(indio_dev, false);
>  
>  	timeout = wait_for_completion_interruptible_timeout(
>  					&adc->completion, STM32_ADC_TIMEOUT);
> @@ -1173,7 +1183,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  	}
>  
> -	adc->cfg->stop_conv(adc);
> +	adc->cfg->stop_conv(indio_dev);
>  
>  	stm32_adc_conv_irq_disable(adc);
>  
> @@ -1227,8 +1237,8 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
>  
>  static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
>  {
> -	struct stm32_adc *adc = data;
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = data;
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	const struct stm32_adc_regspec *regs = adc->cfg->regs;
>  	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
>  
> @@ -1240,8 +1250,8 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
>  
>  static irqreturn_t stm32_adc_isr(int irq, void *data)
>  {
> -	struct stm32_adc *adc = data;
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = data;
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  	const struct stm32_adc_regspec *regs = adc->cfg->regs;
>  	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
>  
> @@ -1514,7 +1524,7 @@ static int __stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	if (!adc->dma_chan)
>  		stm32_adc_conv_irq_enable(adc);
>  
> -	adc->cfg->start_conv(adc, !!adc->dma_chan);
> +	adc->cfg->start_conv(indio_dev, !!adc->dma_chan);
>  
>  	return 0;
>  
> @@ -1547,7 +1557,7 @@ static void __stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	struct device *dev = indio_dev->dev.parent;
>  
> -	adc->cfg->stop_conv(adc);
> +	adc->cfg->stop_conv(indio_dev);
>  	if (!adc->dma_chan)
>  		stm32_adc_conv_irq_disable(adc);
>  
> @@ -1891,7 +1901,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	indio_dev->info = &stm32_adc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
>  
> -	platform_set_drvdata(pdev, adc);
> +	platform_set_drvdata(pdev, indio_dev);
>  
>  	ret = of_property_read_u32(pdev->dev.of_node, "reg", &adc->offset);
>  	if (ret != 0) {
> @@ -1905,7 +1915,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  
>  	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, stm32_adc_isr,
>  					stm32_adc_threaded_isr,
> -					0, pdev->name, adc);
> +					0, pdev->name, indio_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to request IRQ\n");
>  		return ret;
> @@ -1989,8 +1999,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  
>  static int stm32_adc_remove(struct platform_device *pdev)
>  {
> -	struct stm32_adc *adc = platform_get_drvdata(pdev);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct stm32_adc *adc = iio_priv(indio_dev);
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	iio_device_unregister(indio_dev);
> @@ -2012,8 +2022,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  #if defined(CONFIG_PM_SLEEP)
>  static int stm32_adc_suspend(struct device *dev)
>  {
> -	struct stm32_adc *adc = dev_get_drvdata(dev);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  
>  	if (iio_buffer_enabled(indio_dev))
>  		__stm32_adc_buffer_predisable(indio_dev);
> @@ -2023,8 +2032,7 @@ static int stm32_adc_suspend(struct device *dev)
>  
>  static int stm32_adc_resume(struct device *dev)
>  {
> -	struct stm32_adc *adc = dev_get_drvdata(dev);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	int ret;
>  
>  	ret = pm_runtime_force_resume(dev);
> 
