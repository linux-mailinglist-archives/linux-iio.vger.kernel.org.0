Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF3B406E8D
	for <lists+linux-iio@lfdr.de>; Fri, 10 Sep 2021 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhIJP63 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Sep 2021 11:58:29 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:46860 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232438AbhIJP62 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Sep 2021 11:58:28 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18AF0HsG024013;
        Fri, 10 Sep 2021 17:56:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=YHy5/s5iKfTYpUoh5deACaw49hjgKNKHhYQQsSz7L8k=;
 b=NQk5J5LEFsXPhCJEawoO0Doh+BEXubJt3HHBmiEE8hFK7IxUuVnsYNOS+KvSmPARIvD1
 WixNL1+ZQCHIktK0k7wsKDx1v/2SFWKCyrSzXW+y1bRen3RRbhB7BRrE+0hJ2YSa6xnO
 7LNS2WwYKA6jGph7K/H04TJVEKC+kK5lTI45Abd3HFMiO7YkD/IqRr11kayvXJ5OnanD
 VlJ41Kxt8TaRe4yl8dyCuzBq4Z4cCEQ2uxZPGAI96oRl+K9hAErYMpv2oFYq88W2XWT7
 7uie14b/+WeZ5kEkDJKJK6M1HsJQZV6Bg4py2QURFZz1vZUGaODfralqVz99/hpXcYA/ Rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b09mdr6yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Sep 2021 17:56:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F123410002A;
        Fri, 10 Sep 2021 17:56:46 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BB16B22179B;
        Fri, 10 Sep 2021 17:56:46 +0200 (CEST)
Received: from lmecxl0577.lme.st.com (10.75.127.45) by SFHDAG1NODE3.st.com
 (10.75.127.3) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 10 Sep
 2021 17:56:45 +0200
Subject: Re: [PATCH 4/4] iio: adc: stm32-dfsdm: add scale and offset support
To:     Jonathan Cameron <jic23@kernel.org>
References: <20200204101008.11411-1-olivier.moysan@st.com>
 <20200204101008.11411-5-olivier.moysan@st.com>
 <20200208161847.76c7d6e8@archlinux>
 <8400827e-5f3d-ad3f-99c8-986934b1a7b8@st.com>
 <20200214131113.70aa36b8@archlinux>
 <5b2e74a0-71bd-46d0-0096-b33ff17f780b@st.com>
 <20200214151011.20111e8c@archlinux>
 <AM9PR10MB43558CEB8DAE7F373E9E7A5DF9D69@AM9PR10MB4355.EURPRD10.PROD.OUTLOOK.COM>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
Message-ID: <78f4e4b9-ef4c-982f-7cd3-8d3052d99150@foss.st.com>
Date:   Fri, 10 Sep 2021 17:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <AM9PR10MB43558CEB8DAE7F373E9E7A5DF9D69@AM9PR10MB4355.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-10_06,2021-09-09_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 9/10/21 4:05 PM, Olivier MOYSAN wrote:
> 
> 
> 
> ST Restricted
> 
> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: vendredi 14 février 2020 16:10
> To: Olivier MOYSAN <olivier.moysan@st.com>
> Cc: robh+dt@kernel.org; mark.rutland@arm.com; knaack.h@gmx.de; lars@metafoo.de; devicetree@vger.kernel.org; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; pmeerw@pmeerw.net; linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 4/4] iio: adc: stm32-dfsdm: add scale and offset support
> 
> On Fri, 14 Feb 2020 14:49:18 +0000
> Olivier MOYSAN <olivier.moysan@st.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 2/14/20 2:11 PM, Jonathan Cameron wrote:
>>> On Tue, 11 Feb 2020 15:19:01 +0000
>>> Olivier MOYSAN <olivier.moysan@st.com> wrote:
>>>   
>>>> Hi Jonathan,
>>>>
>>>> On 2/8/20 5:18 PM, Jonathan Cameron wrote:
>>>>> On Tue, 4 Feb 2020 11:10:08 +0100
>>>>> Olivier Moysan <olivier.moysan@st.com> wrote:
>>>>>      
>>>>>> Add scale and offset attributes support to STM32 DFSDM.
>>>>>>
>>>>>> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
>>>>> Hmm. I can't remember this history of this but we've kind of ended
>>>>> up backwards wrt to other consumer drivers.
>>>>>
>>>>> In some sense this is similar to the analog gyroscopes.  In those
>>>>> the consumer driver is the gyroscope which is consuming the raw
>>>>> readings from an ADC connected to the channel.  This results in us
>>>>> getting readings reported by the gyroscope driver.
>>>>>
>>>>> Here we have a sigma delta convertor consuming the pulse train
>>>>> from a sigma delta device.  So the channels are reported by the
>>>>> sigma delta receiver, whereas i think the nearest equivalent to
>>>>> the analog voltage outputing gyroscopes would have been if we had
>>>>> reported the channel values at the sigma delta converter.
>>>> The DFSDM driver is currently used as a consumer of the sd modulator.
>>>> The scale and offset values of the channels are already computed by
>>>> the DFSDM driver, and provided by this driver to the IIO ABI.
>>>> However, the DFSDM has no voltage reference, so it has to retrieve
>>>> it from sd-modulator channels, for the scale factor computation.
>>>>
>>>>                                        scale  offset
>>>>                                          ^      ^
>>>>                                          |      |       IIO ABI
>>>> +-------------------------------------------------------------+
>>>>             +---------------+          +-------------+
>>>>             |sd driver      |          |DFSDM driver |
>>>>             +---------------+          +-------------+
>>>> +-------------------------------------------------------------+
>>>>                                                             HW
>>>>             +---------------+          +-------------+
>>>> +------->+ sd-modulator  +--------->+ DFSDM +-------->
>>>> analog   +------+--------+          +-------------+ output input
>>>> ^
>>>>                    | vref
>>>>                    +
>>>>
>>>>
>>>> Is it the topology your are expecting ?
>>> It's not the one we'd expect if we are aligning with similar cases
>>> elsewhere in IIO.  For example, if we attach an analog accelerometer
>>> to an ADC, we report the accel channels on the accelerometer not the
>>> ADC.  The equivalent would be to see the DFSDM as providing a
>>> conversion service to the SD device which is actually executing the
>>> measurement and has the input channels.
>>>
>>>
>>>            scale  offset  raw
>>>              ^      ^      ^
>>>              |      |      |                              IIO ABI
>>>    +-------------------------------------------------------------+
>>>              +---------------+          +-------------+
>>>              |sd driver      |          |DFSDM driver |
>>>              +---------------+          +-------------+
>>>    +-------------------------------------------------------------+
>>>                                                              HW
>>>              +---------------+          +-------------+
>>>    +------->+ sd-modulator  +--------->+ DFSDM +-------->
>>>    analog   +------+--------+          +-------------+ output
>>>    input           ^
>>>                     | vref
>>>>                    +
>>>>   
>> Thanks for your clarification.
>> ok, moving to this logic is a significant change.
>> I need to evaluate further the impact on the dfsdm driver.
> 
> Understood!  If we can't do it without potentially breaking users then such is life.
> 
> Jonathan
> 

I come back to this old, but still valid topic.
You mentioned the example of analog gyroscopes in a previous message.
Looking at gyroscope drivers, I found rcar-gyroadc driver which shows 
requirements similar to dfsdm needs:
https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/adc/renesas%2Crcar-gyroadc.yaml

rcar-gyroadc driver main characterisitics:
- the parent device (gyroadc) is a consumer of sub devices (SPI ADCs)
- the channels are populated from the sub devices
- the iio device is associated to the parent device


I took the example of gyroadc to reconsider dfsdm topology and explore 
some variants according to IIO devices use.

1) current topology: one IIO device per SD modulator and one iio device 
per DFSDM filter
     The DFSDM is used as a consumer of SD modulator through the hw
     consumer API.
     * cons
         - SD modulator and DFSDM filter have their own channel
         specification.
         - DFSDM retrieves channels scale information from SD
         modulator to initialized its channels
         - SD modulator IIO sysfs interface is useless

+------------+     +-------+     +---------+  sysfs
| sd0 iiodev | --> | chan0 | --> | filter0 | ------->
+------------+     +-------+     +---------+
   |                                ^
   | sysfs                          |
   v                                |
                                    |
                                    |
                                    |
+------------+     +-------+       |
| sd1 iiodev | --> | chan1 | ------+
+------------+     +-------+
   |
   | sysfs
   v


2) "conversion service" topology: one IIO device per SD modulator
     * cons
         - Data transfers: in this case the converted data from
         DFSDM filter have to be sent back to SD modulator to be 	
	available on sysfs interface.
         - Scan mode: this topology seems not compatible with scan
         mode, where multiplexed channels are expected are on
	IIO device interface.

	=> I don't find a proper way to address scan mode with multi SD
	modulator connected to one DFSM filter

+------------+      +-------+     +---------+
| sd0 iiodev | <--> | chan0 | <-> | filter0 |
+------------+      +-------+     +---------+
   |                                 ^
   | sysfs                           |
   v                                 |
                                     |
                                     |
                                     |
+------------+      +-------+       |
| sd1 iiodev | <--> | chan1 | <-----+
+------------+      +-------+
   |
   | sysfs
   v


3) gyroadc like topology: one iio device per DFSDM filter
(no SD modulator iio device registered)
     For DFSDM scale and offset, the required information are SD
     modulator reference voltage and channel types.

     voltage reference: the regulator voltage can be retrieved as it
     is done in  gyroadc driver.
     Maybe we can dropped merely SD modulator, and describe voltage
     as a property of the channel (through generic channel binding)
     This may be too restrictive if more hardware has to be
     configured in the SD modulator, yet.

     channel type: IIO generic channel binding could be used here
     instead of proprietary properties
     to describe the channels

     binding sample:
     dfsdm_pdm1: filter@1 {
         compatible = "st,stm32-dfsdm-adc";
         reg = <1>;
         interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
         dmas = <&dmamux1 102 0x400 0x01>;
         dma-names = "rx";
         st,filter-order = <1>;

         channel@2 {
             reg = <2>;
             label = "in2";
             st,adc-channel-types = "SPI_R";
             st,adc-channel-clk-src = "CLKOUT_F";

             sd@0 {    ?
                 reg = <0>;
                 compatible = "sd-mod";
                 vref-supply = <&vref>;
             };
         };
     };

     * cons
         - The sub devices are embedded in the driver and are not
         based on general device API.
         Alternatively, if we want to use standard device model
         and avoid the creation of an unrelevant IIO device for
         SD modulator, a specific type of device may be
         provided by IIO framework. This could be a kind of
         "backend" device without IIO sysfs interface attached.

     => This solution could be applicable but some details in the
     implementation will have to be clarified further.
     May we consider adding a "backend" device without IIO interface
     in the IIO framework ?
     May the SD modulator be dropped ?

+-----+     +-------+     +----------------+  sysfs
| sd0 | --> | chan0 | --> | filter0 iiodev | ------->
+-----+     +-------+     +----------------+
                             ^
                             |
                             |
+-----+     +-------+       |
| sd1 | --> | chan1 | ------+
+-----+     +-------+


Here there is a point that needs to be clarified in relation to the 
previous discussions I think.
If I refer to the last comment of the current thread, I understand that 
you were expecting the IIO sysfs interface to be attached to the SD 
modulator. (solution 2)
For the gyroadc, the channels are indeed populated by the sub devices. 
However the IIO device corresponds to the ADC consumer and not the ADCs 
themselves. (solution 3)

What is the the preferred approach for you ?

Thanks for your feedback
Best regards
Olivier


>>
>> Regards
>> Olivier
>>>> If not, I probably missedsomething. Could you please clarify this point ?
>>>>
>>>> Regards
>>>> Olivier
>>>>> This wasn't really an issue when the only values available were
>>>>> raw, but if we are adding scale and offset, they are things that
>>>>> belong to the ad1201 for example, not the upstream stm32-dfsdm unit.
>>>>>
>>>>> Thinking of it another way, we don't report an SPI ADC output in
>>>>> the driver for the SPI master.
>>>>>
>>>>> Could we flip it around without breaking anything?
>>>>>
>>>>> Jonathan
>>>>>      
>>>>>> ---
>>>>>>     drivers/iio/adc/stm32-dfsdm-adc.c | 105 +++++++++++++++++++++++++++++-
>>>>>>     1 file changed, 102 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c
>>>>>> b/drivers/iio/adc/stm32-dfsdm-adc.c
>>>>>> index 07b9dfdf8e76..b85fd3e90496 100644
>>>>>> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
>>>>>> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
>>>>>> @@ -10,6 +10,7 @@
>>>>>>     #include <linux/dma-mapping.h>
>>>>>>     #include <linux/iio/adc/stm32-dfsdm-adc.h>
>>>>>>     #include <linux/iio/buffer.h>
>>>>>> +#include <linux/iio/consumer.h>
>>>>>>     #include <linux/iio/hw-consumer.h>
>>>>>>     #include <linux/iio/sysfs.h>
>>>>>>     #include <linux/iio/timer/stm32-lptim-trigger.h>
>>>>>> @@ -67,6 +68,13 @@ struct stm32_dfsdm_dev_data {
>>>>>>     	const struct regmap_config *regmap_cfg;
>>>>>>     };
>>>>>>     
>>>>>> +struct stm32_dfsdm_sd_chan_info {
>>>>>> +	int scale_val;
>>>>>> +	int scale_val2;
>>>>>> +	int offset;
>>>>>> +	unsigned int differential;
>>>>>> +};
>>>>>> +
>>>>>>     struct stm32_dfsdm_adc {
>>>>>>     	struct stm32_dfsdm *dfsdm;
>>>>>>     	const struct stm32_dfsdm_dev_data *dev_data; @@ -79,6 +87,7
>>>>>> @@ struct stm32_dfsdm_adc {
>>>>>>     	struct iio_hw_consumer *hwc;
>>>>>>     	struct completion completion;
>>>>>>     	u32 *buffer;
>>>>>> +	struct stm32_dfsdm_sd_chan_info *sd_chan;
>>>>>>     
>>>>>>     	/* Audio specific */
>>>>>>     	unsigned int spi_freq;  /* SPI bus clock frequency */ @@
>>>>>> -1271,7 +1280,10 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>>>>>>     				int *val2, long mask)
>>>>>>     {
>>>>>>     	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>>>>> -	int ret;
>>>>>> +	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
>>>>>> +	struct stm32_dfsdm_filter_osr *flo = &fl->flo[fl->fast];
>>>>>> +	u32 max = flo->max << (flo->lshift - chan->scan_type.shift);
>>>>>> +	int ret, idx = chan->scan_index;
>>>>>>     
>>>>>>     	switch (mask) {
>>>>>>     	case IIO_CHAN_INFO_RAW:
>>>>>> @@ -1307,6 +1319,41 @@ static int stm32_dfsdm_read_raw(struct iio_dev *indio_dev,
>>>>>>     		*val = adc->sample_freq;
>>>>>>     
>>>>>>     		return IIO_VAL_INT;
>>>>>> +
>>>>>> +	case IIO_CHAN_INFO_SCALE:
>>>>>> +		/*
>>>>>> +		 * Scale is expressed in mV.
>>>>>> +		 * When fast mode is disabled, actual resolution may be lower
>>>>>> +		 * than 2^n, where n=realbits-1.
>>>>>> +		 * This leads to underestimating input voltage. To
>>>>>> +		 * compensate this deviation, the voltage reference can be
>>>>>> +		 * corrected with a factor = realbits resolution / actual max
>>>>>> +		 */
>>>>>> +		*val = div_u64((u64)adc->sd_chan[idx].scale_val *
>>>>>> +			       (u64)BIT(DFSDM_DATA_RES - 1), max);
>>>>>> +		*val2 = chan->scan_type.realbits;
>>>>>> +		if (adc->sd_chan[idx].differential)
>>>>>> +			*val *= 2;
>>>>>> +
>>>>>> +		return IIO_VAL_FRACTIONAL_LOG2;
>>>>>> +
>>>>>> +	case IIO_CHAN_INFO_OFFSET:
>>>>>> +		/*
>>>>>> +		 * DFSDM output data are in the range [-2^n,2^n-1],
>>>>>> +		 * with n=realbits-1.
>>>>>> +		 * - Differential modulator:
>>>>>> +		 * Offset correspond to SD modulator offset.
>>>>>> +		 * - Single ended modulator:
>>>>>> +		 * Input is in [0V,Vref] range, where 0V corresponds to -2^n.
>>>>>> +		 * Add 2^n to offset. (i.e. middle of input range)
>>>>>> +		 * offset = offset(sd) * vref / res(sd) * max / vref.
>>>>>> +		 */
>>>>>> +		*val = div_u64((u64)max * adc->sd_chan[idx].offset,
>>>>>> +			       BIT(adc->sd_chan[idx].scale_val2 - 1));
>>>>>> +		if (!adc->sd_chan[idx].differential)
>>>>>> +			*val += max;
>>>>>> +
>>>>>> +		return IIO_VAL_INT;
>>>>>>     	}
>>>>>>     
>>>>>>     	return -EINVAL;
>>>>>> @@ -1430,7 +1477,9 @@ static int stm32_dfsdm_adc_chan_init_one(struct iio_dev *indio_dev,
>>>>>>     	 * IIO_CHAN_INFO_RAW: used to compute regular conversion
>>>>>>     	 * IIO_CHAN_INFO_OVERSAMPLING_RATIO: used to set oversampling
>>>>>>     	 */
>>>>>> -	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
>>>>>> +	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>>>>> +				 BIT(IIO_CHAN_INFO_SCALE) |
>>>>>> +				 BIT(IIO_CHAN_INFO_OFFSET);
>>>>>>     	ch->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
>>>>>>     					BIT(IIO_CHAN_INFO_SAMP_FREQ);
>>>>>>     
>>>>>> @@ -1481,8 +1530,10 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>>>>>>     {
>>>>>>     	struct iio_chan_spec *ch;
>>>>>>     	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
>>>>>> +	struct iio_channel *channels, *chan;
>>>>>> +	struct stm32_dfsdm_sd_chan_info *sd_chan;
>>>>>>     	int num_ch;
>>>>>> -	int ret, chan_idx;
>>>>>> +	int ret, chan_idx, val2;
>>>>>>     
>>>>>>     	adc->oversamp = DFSDM_DEFAULT_OVERSAMPLING;
>>>>>>     	ret = stm32_dfsdm_compute_all_osrs(indio_dev, adc->oversamp);
>>>>>> @@ -1506,6 +1557,22 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>>>>>>     	if (!ch)
>>>>>>     		return -ENOMEM;
>>>>>>     
>>>>>> +	/* Get SD modulator channels */
>>>>>> +	channels = iio_channel_get_all(&indio_dev->dev);
>>>>>> +	if (IS_ERR(channels)) {
>>>>>> +		dev_err(&indio_dev->dev, "Failed to get channel %ld\n",
>>>>>> +			PTR_ERR(channels));
>>>>>> +		return PTR_ERR(channels);
>>>>>> +	}
>>>>>> +	chan = &channels[0];
>>>>>> +
>>>>>> +	adc->sd_chan = devm_kzalloc(&indio_dev->dev,
>>>>>> +				    sizeof(*adc->sd_chan) * num_ch, GFP_KERNEL);
>>>>>> +	if (!adc->sd_chan)
>>>>>> +		return -ENOMEM;
>>>>>> +
>>>>>> +	sd_chan = adc->sd_chan;
>>>>>> +
>>>>>>     	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
>>>>>>     		ch[chan_idx].scan_index = chan_idx;
>>>>>>     		ret = stm32_dfsdm_adc_chan_init_one(indio_dev,
>>>>>> &ch[chan_idx]); @@ -1513,6 +1580,38 @@ static int stm32_dfsdm_adc_init(struct iio_dev *indio_dev)
>>>>>>     			dev_err(&indio_dev->dev, "Channels init failed\n");
>>>>>>     			return ret;
>>>>>>     		}
>>>>>> +
>>>>>> +		if (!chan->indio_dev)
>>>>>> +			return -EINVAL;
>>>>>> +
>>>>>> +		ret = iio_read_channel_scale(chan, &sd_chan->scale_val,
>>>>>> +					     &sd_chan->scale_val2);
>>>>>> +		if (ret < 0) {
>>>>>> +			dev_err(&indio_dev->dev,
>>>>>> +				"Failed to get channel %d scale\n", chan_idx);
>>>>>> +			return ret;
>>>>>> +		}
>>>>>> +
>>>>>> +		if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_OFFSET)) {
>>>>>> +			ret = iio_read_channel_offset(chan, &sd_chan->offset,
>>>>>> +						      &val2);
>>>>>> +			if (ret < 0) {
>>>>>> +				dev_err(&indio_dev->dev,
>>>>>> +					"Failed to get channel %d offset\n",
>>>>>> +					chan_idx);
>>>>>> +				return ret;
>>>>>> +			}
>>>>>> +		}
>>>>>> +
>>>>>> +		sd_chan->differential = chan->channel->differential;
>>>>>> +
>>>>>> +		dev_dbg(&indio_dev->dev, "Channel %d %s scale ref=%d offset=%d",
>>>>>> +			chan_idx, chan->channel->differential ?
>>>>>> +			"differential" : "single-ended",
>>>>>> +			sd_chan->scale_val, sd_chan->offset);
>>>>>> +
>>>>>> +		chan++;
>>>>>> +		sd_chan++;
>>>>>>     	}
>>>>>>     
>>>>>>     	indio_dev->num_channels = num_ch;
