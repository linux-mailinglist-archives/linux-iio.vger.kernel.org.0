Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC06F937F
	for <lists+linux-iio@lfdr.de>; Sat,  6 May 2023 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjEFSEt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 May 2023 14:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEFSEs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 May 2023 14:04:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F1150FD
        for <linux-iio@vger.kernel.org>; Sat,  6 May 2023 11:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D7E9609FF
        for <linux-iio@vger.kernel.org>; Sat,  6 May 2023 18:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3255C433EF;
        Sat,  6 May 2023 18:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683396286;
        bh=I1MijWNxyXyqex1NCPpZlVK1VDtdWQuftGubG9soG/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ol4UDf+hDjQWHwrwyTp47BFSndozehemtspEdwPlhcteQH728zEDNgVob4FmiFRUY
         Jd5yaJfqMTQZjc+pbzrHE8dWxlo1vKjYh+AK+fW0G+n3va+qcCpN3JqqfPdJtoUBxP
         6taQ2KvPRQZdkQ+ugPm2yuBD638wA67vM0Le0FhXDVyyHNGtK36ltyrZp4PSK5DYKT
         m+M7Yo6bAvinN8EaBr0gV3dzJlm0TQLt9ebd+NwbHBw7pXQT+coUBHVFj14aLHh2aE
         Rdjq4HgLDusBiwBZwvRwiZEBkG2rrPtF4j0n7gefnhxTDz5ZygyhPrzzUKuuIl0/D5
         pY12W52h+8qyQ==
Date:   Sat, 6 May 2023 19:20:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, <alexandre.torgue@foss.st.com>,
        <nuno.sa@analog.com>, Fabrice GASNIER <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v3 2/2] iio: adc: stm32-adc: skip adc-channels setup if
 none is present
Message-ID: <20230506192039.36104088@jic23-huawei>
In-Reply-To: <29974337-d4a0-e295-ed0f-59f6f27576fe@foss.st.com>
References: <20230503162029.3654093-1-sean@geanix.com>
        <20230503162029.3654093-2-sean@geanix.com>
        <29974337-d4a0-e295-ed0f-59f6f27576fe@foss.st.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 4 May 2023 13:41:24 +0200
Olivier MOYSAN <olivier.moysan@foss.st.com> wrote:

> Hi Sean,
> 
> Thanks for your update
> You can add my: Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
Please keep RB on a separate line as it makes it easier for scripts to find
it (e.g. b4)  I wasn't clear on whether RB applied to both patches or just
this one, so I went with safe option and only applied it to this one.

Both patches applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> 
> BRs
> Olivier
> 
> On 5/3/23 18:20, Sean Nyekjaer wrote:
> > If only adc differential channels are defined driver will fail with
> > stm32-adc: probe of 48003000.adc:adc@0 failed with error -22
> > 
> > Fix this by skipping the initialization if no channels are defined.
> > 
> > This applies only to the legacy way of initializing adc channels.
> > 
> > Fixes: d7705f35448a ("iio: adc: stm32-adc: convert to device properties")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > Changes since v1:
> > - Ignore extra channel for timestamps in PIO mode
> > - Use single ended count in channel creation (Thanks Olivier Moysan)
> > 
> > Changes since v2:
> > - Avoid calling device_property_read_u32_array with num_se 0 (Thanks Olivier Moysan)
> > 
> >   drivers/iio/adc/stm32-adc.c | 42 ++++++++++++++++++++-----------------
> >   1 file changed, 23 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > index 14524c1b5583..f7613efb870d 100644
> > --- a/drivers/iio/adc/stm32-adc.c
> > +++ b/drivers/iio/adc/stm32-adc.c
> > @@ -2038,6 +2038,7 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
> >   	struct stm32_adc_diff_channel diff[STM32_ADC_CH_MAX];
> >   	struct device *dev = &indio_dev->dev;
> >   	u32 num_diff = adc->num_diff;
> > +	int num_se = nchans - num_diff;
> >   	int size = num_diff * sizeof(*diff) / sizeof(u32);
> >   	int scan_index = 0, ret, i, c;
> >   	u32 smp = 0, smps[STM32_ADC_CH_MAX], chans[STM32_ADC_CH_MAX];
> > @@ -2064,29 +2065,32 @@ static int stm32_adc_legacy_chan_init(struct iio_dev *indio_dev,
> >   			scan_index++;
> >   		}
> >   	}
> > -
> > -	ret = device_property_read_u32_array(dev, "st,adc-channels", chans,
> > -					     nchans);
> > -	if (ret)
> > -		return ret;
> > -
> > -	for (c = 0; c < nchans; c++) {
> > -		if (chans[c] >= adc_info->max_channels) {
> > -			dev_err(&indio_dev->dev, "Invalid channel %d\n",
> > -				chans[c]);
> > -			return -EINVAL;
> > +	if (num_se > 0) {
> > +		ret = device_property_read_u32_array(dev, "st,adc-channels", chans, num_se);
> > +		if (ret) {
> > +			dev_err(&indio_dev->dev, "Failed to get st,adc-channels %d\n", ret);
> > +			return ret;
> >   		}
> >   
> > -		/* Channel can't be configured both as single-ended & diff */
> > -		for (i = 0; i < num_diff; i++) {
> > -			if (chans[c] == diff[i].vinp) {
> > -				dev_err(&indio_dev->dev, "channel %d misconfigured\n",	chans[c]);
> > +		for (c = 0; c < num_se; c++) {
> > +			if (chans[c] >= adc_info->max_channels) {
> > +				dev_err(&indio_dev->dev, "Invalid channel %d\n",
> > +					chans[c]);
> >   				return -EINVAL;
> >   			}
> > +
> > +			/* Channel can't be configured both as single-ended & diff */
> > +			for (i = 0; i < num_diff; i++) {
> > +				if (chans[c] == diff[i].vinp) {
> > +					dev_err(&indio_dev->dev, "channel %d misconfigured\n",
> > +						chans[c]);
> > +					return -EINVAL;
> > +				}
> > +			}
> > +			stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> > +						chans[c], 0, scan_index, false);
> > +			scan_index++;
> >   		}
> > -		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
> > -					chans[c], 0, scan_index, false);
> > -		scan_index++;
> >   	}
> >   
> >   	if (adc->nsmps > 0) {
> > @@ -2307,7 +2311,7 @@ static int stm32_adc_chan_fw_init(struct iio_dev *indio_dev, bool timestamping)
> >   
> >   	if (legacy)
> >   		ret = stm32_adc_legacy_chan_init(indio_dev, adc, channels,
> > -						 num_channels);
> > +						 timestamping ? num_channels - 1 : num_channels);
> >   	else
> >   		ret = stm32_adc_generic_chan_init(indio_dev, adc, channels);
> >   	if (ret < 0)  

