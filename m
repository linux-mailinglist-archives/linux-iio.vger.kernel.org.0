Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA49C43D034
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243431AbhJ0SDS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 14:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243411AbhJ0SDS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 14:03:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF2BF610A0;
        Wed, 27 Oct 2021 18:00:45 +0000 (UTC)
Date:   Wed, 27 Oct 2021 19:05:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <Jonathan.Cameron@huawei.com>,
        <amitk@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2 3/3] thermal: qcom: add support for PMIC5 Gen2 ADCTM
Message-ID: <20211027190511.23f271e7@jic23-huawei>
In-Reply-To: <1635264275-12530-4-git-send-email-quic_jprakash@quicinc.com>
References: <1635264275-12530-1-git-send-email-quic_jprakash@quicinc.com>
        <1635264275-12530-4-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 26 Oct 2021 21:34:35 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Add support for PMIC5 Gen2 ADC_TM, used on PMIC7 chips. It is a
> close counterpart of PMIC7 ADC and has the same functionality as
> PMIC5 ADC_TM, for threshold monitoring and interrupt generation.
> It is present on PMK8350 alone, like PMIC7 ADC and can be used
> to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
> having ADC on a target, through PBS(Programmable Boot Sequence).
> 
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>

Drive be review as I was looking at the other bits of the series.
Personally I'd prefer to see this as 2 patches, 1st one does
the refactoring and 2nd adds the gen2 specific parts.

Jonathan


>  
>  struct adc_tm5_chip;
> +struct adc_tm5_channel;
> +
> +struct adc_tm5_data {
> +	const u32	full_scale_code_volt;
> +	unsigned int	*decimation;
> +	unsigned int	*hw_settle;

Indenting in here is inconsistent.
Personally I'd just stop bothering with the lining everything up.

> +	int (*disable_channel)(struct adc_tm5_channel *channel);
> +	int (*configure)(struct adc_tm5_channel *channel, int low,
> +					int high);

Why the line break?  It's under 80 chars without it.

> +	irqreturn_t (*isr)(int irq, void *data);
> +	char *irq_name;
> +	int gen;
> +};
>  
>  /**
>   * struct adc_tm5_channel - ADC Thermal Monitoring channel data.
> @@ -100,6 +167,12 @@ struct adc_tm5_chip;
>   * @prescale: channel scaling performed on the input signal.
>   * @hw_settle_time: the time between AMUX being configured and the
>   *	start of conversion.
> + * @decimation: sampling rate supported for the channel.
> + * @avg_samples: ability to provide single result from the ADC
> + *	that is an average of multiple measurements.
> + * @high_thr_en: channel upper voltage threshold enable state.
> + * @low_thr_en: channel lower voltage threshold enable state.
> + * @meas_en: recurring measurement enable state
>   * @iio: IIO channel instance used by this channel.
>   * @chip: ADC TM chip instance.
>   * @tzd: thermal zone device used by this channel.
> @@ -110,6 +183,11 @@ struct adc_tm5_channel {
>  	enum adc_tm5_cal_method	cal_method;
>  	unsigned int		prescale;
>  	unsigned int		hw_settle_time;
> +	unsigned int		decimation;	/* For Gen2 ADC_TM */
> +	unsigned int		avg_samples;	/* For Gen2 ADC_TM */
> +	bool			high_thr_en;		/* For Gen2 ADC_TM */
> +	bool			low_thr_en;		/* For Gen2 ADC_TM */
> +	bool			meas_en;		/* For Gen2 ADC_TM */
>  	struct iio_channel	*iio;
>  	struct adc_tm5_chip	*chip;
>  	struct thermal_zone_device *tzd;
> @@ -123,9 +201,12 @@ struct adc_tm5_channel {
>   * @channels: array of ADC TM channel data.
>   * @nchannels: amount of channels defined/allocated
>   * @decimation: sampling rate supported for the channel.
> + *      Applies to all channels, used only on Gen1 ADC_TM.
>   * @avg_samples: ability to provide single result from the ADC
> - *	that is an average of multiple measurements.
> + *      that is an average of multiple measurements. Applies to all
> + *      channels, used only on Gen1 ADC_TM.
>   * @base: base address of TM registers.
> + * @adc_mutex_lock: ADC_TM mutex lock.

Not very informative.  What is it protecting access to?
Ah. I see this one has already been commented on by Dmitry

>   */
>  struct adc_tm5_chip {
>  	struct regmap		*regmap;
> @@ -136,14 +217,15 @@ struct adc_tm5_chip {
>  	unsigned int		decimation;
>  	unsigned int		avg_samples;
>  	u16			base;
> +	struct mutex		adc_mutex_lock;
>  };
>  

...

> +
> +static int32_t adc_tm5_gen2_conv_req(struct adc_tm5_chip *chip)
> +{
> +	int ret = 0;

No need to initialise as set in all paths.

> +	u8 data = 0;
> +	unsigned int count;
> +
> +	data = ADC_TM_GEN2_EN;
> +	ret = adc_tm5_write(chip, ADC_TM_GEN2_EN_CTL1, &data, 1);
> +	if (ret < 0) {
> +		pr_err("adc-tm enable failed with %d\n", ret);

General mix of pr_err and dev_err.  Should all be dev_err unless
they aren't associated with a particular device for some reason.

> +		return ret;
> +	}
> +
> +	data = ADC_TM_GEN2_CFG_HS_FLAG;
> +	ret = adc_tm5_write(chip, ADC_TM_GEN2_CFG_HS_SET, &data, 1);
> +	if (ret < 0) {
> +		pr_err("adc-tm handshake failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	data = ADC_TM_GEN2_CONV_REQ_EN;
> +	ret = adc_tm5_write(chip, ADC_TM_GEN2_CONV_REQ, &data, 1);
> +	if (ret < 0) {
> +		pr_err("adc-tm request conversion failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * SW sets a handshake bit and waits for PBS to clear it
> +	 * before the next conversion request can be queued.
> +	 */
> +
> +	for (count = 0; count < ADC_TM_GEN2_POLL_RETRY_COUNT; count++) {
> +		ret = adc_tm5_read(chip, ADC_TM_GEN2_CFG_HS_SET, &data, sizeof(data));
> +		if (ret < 0) {
> +			pr_err("adc-tm read failed with %d\n", ret);
> +			return ret;
> +		}
> +
> +		if (!(data & ADC_TM_GEN2_CFG_HS_FLAG))
> +			return ret;
> +		usleep_range(ADC_TM_GEN2_POLL_DELAY_MIN_US,
> +			ADC_TM_GEN2_POLL_DELAY_MAX_US);
> +	}
> +
> +	pr_err("adc-tm conversion request handshake timed out\n");
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int adc_tm5_gen2_disable_channel(struct adc_tm5_channel *channel)
> +{
> +	struct adc_tm5_chip *chip = channel->chip;
> +	int ret;
> +	u8 val;
> +
> +	mutex_lock(&chip->adc_mutex_lock);
> +
> +	channel->meas_en = false;
> +	channel->high_thr_en = false;
> +	channel->low_thr_en = false;
> +
> +	ret = adc_tm5_read(chip, ADC_TM_GEN2_CH_CTL, &val, sizeof(val));
> +	if (ret < 0) {
> +		pr_err("adc-tm block read failed with %d\n", ret);

Why pr_err rather then dev_err?

> +		goto disable_fail;
> +	}
> +
> +	val &= ~ADC_TM_GEN2_TM_CH_SEL;
> +	val |= FIELD_PREP(ADC_TM_GEN2_TM_CH_SEL, channel->channel);
> +
> +	ret = adc_tm5_write(chip, ADC_TM_GEN2_CH_CTL, &val, 1);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "adc-tm channel disable failed with %d\n", ret);
> +		goto disable_fail;
> +	}
> +
> +	val = 0;
> +	ret = adc_tm5_write(chip, ADC_TM_GEN2_MEAS_IRQ_EN, &val, 1);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "adc-tm interrupt disable failed with %d\n", ret);
> +		goto disable_fail;
> +	}
> +
> +
> +	ret = adc_tm5_gen2_conv_req(channel->chip);
> +	if (ret < 0)
> +		dev_err(chip->dev, "adc-tm channel configure failed with %d\n", ret);
> +
> +disable_fail:
> +	mutex_unlock(&chip->adc_mutex_lock);
> +	return ret;
> +}
> +

...

>  
> +static const struct adc_tm5_data adc_tm5_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.decimation = (unsigned int []) { 250, 420, 840 },
> +	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
> +					 1000, 2000, 4000, 8000, 16000, 32000,
> +					 64000, 128000 },
> +	.disable_channel = adc_tm5_disable_channel,
> +	.configure = adc_tm5_configure,
This might all look nicer if split into two patches.
1st of which does the various structure moves and addes the callbacks for the
TM5.  2nd of which introduces the gen2 version of everything.

Patch 1 would be a noop which is usually easy to tell, and patch 2 would be
clean addition of new code.

> +	.isr = adc_tm5_isr,
> +	.irq_name = "pm-adc-tm5",
> +	.gen = ADC_TM5,
> +};
> +
