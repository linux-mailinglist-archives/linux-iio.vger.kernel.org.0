Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8B320BD0
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 17:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhBUQlT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 11:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhBUQlT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 11:41:19 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7736661493;
        Sun, 21 Feb 2021 16:40:36 +0000 (UTC)
Date:   Sun, 21 Feb 2021 16:40:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     kholk11@gmail.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [RESEND] [PATCH 1/2] iio: adc: qcom-spmi-vadc: Use right
 ratiometric range for 8998,660,845
Message-ID: <20210221164032.0271952a@archlinux>
In-Reply-To: <20201129131233.4a8f7119@archlinux>
References: <20200926171835.27154-1-kholk11@gmail.com>
        <20201129131233.4a8f7119@archlinux>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 29 Nov 2020 13:12:33 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 26 Sep 2020 19:18:34 +0200
> kholk11@gmail.com wrote:
> 
> > From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> > 
> > The ratiometric range for MSM8998, SDM630/636/660 and SDM845 is 1875mV
> > instead of the standard 1800mV: address this by adding a new compatible
> > "qcom,spmi-vadc-8998" and assigning the different range to the machines
> > declaring this one.
> > 
> > Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>  
> 
> @Bjorn
> 
> Could you take a quick look at this pair of patches.  It's been sat in
> my queue waiting for appropriate review for rather too long!
> (mainly because I've been rather lax in checking on status of older
> series really - sorry about that :(

I still have these marked as outstanding.  Please take a look.

Thanks,

Jonathan

> 
> Thanks
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/qcom-spmi-vadc.c   | 10 +++++++++-
> >  drivers/iio/adc/qcom-vadc-common.h |  1 +
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> > index b0388f8a69f4..59a94ea7bf78 100644
> > --- a/drivers/iio/adc/qcom-spmi-vadc.c
> > +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> > @@ -101,6 +101,7 @@ struct vadc_channel_prop {
> >   * @dev: pointer to struct device.
> >   * @base: base address for the ADC peripheral.
> >   * @nchannels: number of VADC channels.
> > + * @ratio_range: ratiometric range for ref points.
> >   * @chan_props: array of VADC channel properties.
> >   * @iio_chans: array of IIO channels specification.
> >   * @are_ref_measured: are reference points measured.
> > @@ -114,6 +115,7 @@ struct vadc_priv {
> >  	struct device		 *dev;
> >  	u16			 base;
> >  	unsigned int		 nchannels;
> > +	unsigned int		 ratio_range;
> >  	struct vadc_channel_prop *chan_props;
> >  	struct iio_chan_spec	 *iio_chans;
> >  	bool			 are_ref_measured;
> > @@ -355,7 +357,7 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
> >  	u16 read_1, read_2;
> >  	int ret;
> >  
> > -	vadc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE;
> > +	vadc->graph[VADC_CALIB_RATIOMETRIC].dx = vadc->ratio_range;
> >  	vadc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
> >  
> >  	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
> > @@ -885,6 +887,11 @@ static int vadc_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (of_device_is_compatible(node, "qcom,spmi-vadc-8998"))
> > +		vadc->ratio_range = VADC_RATIOMETRIC_RANGE_8998;
> > +	else
> > +		vadc->ratio_range = VADC_RATIOMETRIC_RANGE;
> > +
> >  	irq_eoc = platform_get_irq(pdev, 0);
> >  	if (irq_eoc < 0) {
> >  		if (irq_eoc == -EPROBE_DEFER || irq_eoc == -EINVAL)
> > @@ -918,6 +925,7 @@ static int vadc_probe(struct platform_device *pdev)
> >  
> >  static const struct of_device_id vadc_match_table[] = {
> >  	{ .compatible = "qcom,spmi-vadc" },
> > +	{ .compatible = "qcom-spmi-vadc-8998" },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, vadc_match_table);
> > diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
> > index 17b2fc4d8bf2..b10d5fd59034 100644
> > --- a/drivers/iio/adc/qcom-vadc-common.h
> > +++ b/drivers/iio/adc/qcom-vadc-common.h
> > @@ -16,6 +16,7 @@
> >  
> >  #define VADC_ABSOLUTE_RANGE_UV			625000
> >  #define VADC_RATIOMETRIC_RANGE			1800
> > +#define VADC_RATIOMETRIC_RANGE_8998		1875
> >  
> >  #define VADC_DEF_PRESCALING			0 /* 1:1 */
> >  #define VADC_DEF_DECIMATION			0 /* 512 */  
> 

