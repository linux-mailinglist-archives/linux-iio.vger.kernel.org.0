Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B094383A8
	for <lists+linux-iio@lfdr.de>; Sat, 23 Oct 2021 14:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhJWMi5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Oct 2021 08:38:57 -0400
Received: from www381.your-server.de ([78.46.137.84]:45344 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhJWMi5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Oct 2021 08:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=+DXyU0+A1K4Yk4h5NF0BizlYXPX/5gWoz3YLyiDN71I=; b=TCpyhHXqJN6rsz9paEiCP6jk7I
        uT4oM7tmbyuUhBJYSO6MkXcz+APO+f73qU0E6ROltlI9gf7dGafZYldfJdqm6p7TbhD3nIXXcJkIE
        8E4UElLtInVQ/wK6QzisZeFwElcvWw6LaUCTPGifmjbkhjPb4Zn23IUgczipnWoofoNEYtnTIcd0U
        vLfrhC2m+X//Tgz7+ijqtZS7hPW4ZJFt08BHcR3fInz9n+oFGTyyWGHmwILCSqfnVRYoR/qh+SSYv
        p3S2xekHNFvTOP2zyTplvnOuA2WeoskhmX3+t+/waIdRKyt+VfFSzMp1K0UDRbcBmtjZYelwLeNEZ
        jMLvFAnA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1meGGI-0004wr-37; Sat, 23 Oct 2021 14:36:34 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1meGGH-000OCE-RT; Sat, 23 Oct 2021 14:36:33 +0200
Subject: Re: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        pmeerw@pmeerw.net, devicetree@vger.kernel.org
Cc:     Manish Narani <manish.narani@xilinx.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
 <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ec3f42f0-741d-65ab-fb02-fdbd97925560@metafoo.de>
Date:   Sat, 23 Oct 2021 14:36:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26331/Sat Oct 23 10:18:59 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/19/21 5:20 PM, Anand Ashok Dumbre wrote:
> [....]
> +struct ams {
> +	void __iomem *base;
> +	void __iomem *ps_base;
> +	void __iomem *pl_base;
> +	struct clk *clk;
> +	struct device *dev;
> +	/* check kernel doc above */
> +	struct mutex lock;
> +	/* check kernel doc above */
Do we need this comment?
> +	spinlock_t intr_lock;
> +	unsigned int alarm_mask;
> +	unsigned int masked_alarm;
> +	u64 intr_mask;
> +	int irq;
The irq field is only ever used in the probe function. Could be made a 
local variable.
> +	struct delayed_work ams_unmask_work;
> +};
> [...]
>
> +static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
> +{
> +	int i;
> +	unsigned long long scan_mask;
> +	struct ams *ams = iio_priv(indio_dev);
> +
> +	/*
> +	 * Enable channel sequence. First 22 bits of scan_mask represent
> +	 * PS channels, and next remaining bits represent PL channels.
> +	 */
> +
> +	/* Run calibration of PS & PL as part of the sequence */
> +	scan_mask = 0x1 | BIT(AMS_PS_SEQ_MAX);
> +	for (i = 0; i < indio_dev->num_channels; i++)
> +		scan_mask |= BIT_ULL(indio_dev->channels[i].scan_index);

There are channels with a scan index > 63. These need to be skipped here 
to avoid undefined behavior. UBSAN is reporting an error here.
> [...]
> +	if (ams->pl_base) {
> +		/* put sysmon in a soft reset to change the sequence */
> +		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +				  AMS_CONF1_SEQ_DEFAULT);
> +
> +		/* configure basic channels */
> +		scan_mask = FIELD_GET(AMS_PL_SEQ_MASK, scan_mask);
> +		writel(FIELD_GET(AMS_REG_SEQ0_MASK, scan_mask),
> +		       ams->pl_base + AMS_REG_SEQ_CH0);
> +		writel(FIELD_GET(AMS_REG_SEQ2_MASK, scan_mask),
> +		       ams->pl_base + AMS_REG_SEQ_CH2);
> +		writel(FIELD_GET(AMS_REG_SEQ1_MASK, scan_mask),
> +		       ams->pl_base + AMS_REG_SEQ_CH1);
Hm, the ordering is a bit strange here: 0, 2, 1.
> +
> +		/* set continuous sequence mode */
> +		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +				  AMS_CONF1_SEQ_CONTINUOUS);
> +	}
> +}
> +
>
> +
> [...]
> +
> +static int ams_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask)
> +{
> +	struct ams *ams = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&ams->lock);
> +		if (chan->scan_index >= (AMS_PS_SEQ_MAX * 3)) {
This AMS_PS_SEQ_MAX * 3 really deserves a define. AMS_CTRL_SEQ_BASE or 
something like that.
> +			ret = ams_read_vcc_reg(ams, chan->address, val);
> +			if (ret) {
> +				mutex_unlock(&ams->lock);
> +				return -EINVAL;
> +			}
> +			ams_enable_channel_sequence(indio_dev);
> +		} else if (chan->scan_index >= AMS_PS_SEQ_MAX)
> +			*val = readl(ams->pl_base + chan->address);
> +		else
> +			*val = readl(ams->ps_base + chan->address);
> +		mutex_unlock(&ams->lock);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (chan->address) {
> +			case AMS_SUPPLY1:
> +			case AMS_SUPPLY2:
> +			case AMS_SUPPLY3:
> +			case AMS_SUPPLY4:
> +				*val = AMS_SUPPLY_SCALE_3VOLT;
> +				break;
> +			case AMS_SUPPLY5:
> +			case AMS_SUPPLY6:
> +				if (chan->scan_index < AMS_PS_SEQ_MAX)
> +					*val = AMS_SUPPLY_SCALE_6VOLT;
> +				else
> +					*val = AMS_SUPPLY_SCALE_3VOLT;
> +				break;
> +			case AMS_SUPPLY7:
> +			case AMS_SUPPLY8:
> +				*val = AMS_SUPPLY_SCALE_6VOLT;
> +				break;
> +			case AMS_SUPPLY9:
> +			case AMS_SUPPLY10:
> +				if (chan->scan_index < AMS_PS_SEQ_MAX)
> +					*val = AMS_SUPPLY_SCALE_3VOLT;
> +				else
> +					*val = AMS_SUPPLY_SCALE_6VOLT;
> +				break;
For the PL the range of supply 7 to 10 depends on the CONFIG_REG4 and 
can be either 3V or 6V. Might be worth checking that register, rather 
than hardcoding the value.
> +			case AMS_VCC_PSPLL0:
> +			case AMS_VCC_PSPLL3:
> +			case AMS_VCCINT:
> +			case AMS_VCCBRAM:
> +			case AMS_VCCAUX:
> +			case AMS_PSDDRPLL:
> +			case AMS_PSINTFPDDR:

This is missing AMS_VCCAMS, AMS_VREFP, AMS_VREFN. They all use the 3V scale.

The only ones on a 1V scale are the external channels.

Maye it is easier to write this as

     case AMS_VP_VN:
     case AMS_REG_VAUX ... AMS_REG_VAUX(15):
         *val = AMS_SUPPLY_SCALE_1VOLT;
         break;
     default:
         *val = AMS_SUPPLY_SCALE_3VOLT;
         break;

> +				*val = AMS_SUPPLY_SCALE_3VOLT;
> +				break;
> +			default:
> +				*val = AMS_SUPPLY_SCALE_1VOLT;
> +				break;
> +			}
> +			*val2 = AMS_SUPPLY_SCALE_DIV_BIT;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case IIO_TEMP:
> +			*val = AMS_TEMP_SCALE;
> +			*val2 = AMS_TEMP_SCALE_DIV_BIT;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		/* Only the temperature channel has an offset */
> +		*val = AMS_TEMP_OFFSET;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> [...]
>
> +static int ams_init_module(struct iio_dev *indio_dev, struct device_node *np,
> +			   struct iio_chan_spec *channels)
> +{
> +	struct ams *ams = iio_priv(indio_dev);
> +	int num_channels = 0;
> +
> +	if (of_device_is_compatible(np, "xlnx,zynqmp-ams-ps")) {
> +		ams->ps_base = of_iomap(np, 0);
No unmap anywhere in the driver. Same for the other base addresses.
> [...]
> +
> +	return num_channels;
> +}
> [...]
> +static int ams_probe(struct platform_device *pdev)
> +{
> [...]
> +	ams->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(ams->clk))
> +		return PTR_ERR(ams->clk);
> +	clk_prepare_enable(ams->clk);
> +	devm_add_action_or_reset(&pdev->dev, ams_clk_disable_unprepare,
> +				 ams->clk);
Needs to check for errors. Same for other users of 
devm_add_action_or_reset().
> +
> +	INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);
> +	devm_add_action_or_reset(&pdev->dev, ams_cancel_delayed_work,
> +				 &ams->ams_unmask_work);
> +
> +	ret = ams_init_device(ams);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize AMS\n");
> +		return ret;
> +	}
> +
> +	ret = ams_parse_dt(indio_dev, pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failure in parsing DT\n");
> +		return ret;
> +	}
> +
> +	ams_enable_channel_sequence(indio_dev);
> +
> +	ams->irq = platform_get_irq(pdev, 0);
> +	if (ams->irq == -EPROBE_DEFER) {
What about other errors? E.g. if the interrupt is not specified int he 
devicetree we'll pass the invalid irq number to request_irq().
> +		ret = -EPROBE_DEFER;
> +		return ret;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, ams->irq, &ams_irq, 0, "ams-irq",
> +			       indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register interrupt\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +
> +	return ret;
> +}
