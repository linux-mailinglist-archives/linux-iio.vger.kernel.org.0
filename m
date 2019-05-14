Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0E1D091
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2019 22:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfENU0C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 May 2019 16:26:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbfENU0C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 May 2019 16:26:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EKHJZw001237
        for <linux-iio@vger.kernel.org>; Tue, 14 May 2019 16:26:00 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sg4h50ess-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Tue, 14 May 2019 16:26:00 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Tue, 14 May 2019 21:25:59 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 21:25:57 +0100
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EKPu0G54526016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 20:25:56 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56A796A04D;
        Tue, 14 May 2019 20:25:56 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A34CD6A047;
        Tue, 14 May 2019 20:25:55 +0000 (GMT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 May 2019 20:25:55 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] iio: dps310: Add pressure sensing capability
To:     Jonathan Cameron <jic23@kernel.org>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de
References: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
 <1557344128-690-4-git-send-email-eajames@linux.ibm.com>
 <20190511104822.304a1ead@archlinux>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Tue, 14 May 2019 15:25:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511104822.304a1ead@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19051420-0012-0000-0000-0000173672C8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011098; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01203343; UDB=6.00631627; IPR=6.00984265;
 MB=3.00026890; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-14 20:25:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051420-0013-0000-0000-00005744174B
Message-Id: <d865007c-2f60-4a04-fd1d-404ee4819f52@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140136
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 5/11/19 4:48 AM, Jonathan Cameron wrote:
> On Wed,  8 May 2019 14:35:28 -0500
> Eddie James <eajames@linux.ibm.com> wrote:
>
>> The DPS310 supports measurement of pressure, so support that in the
>> driver. Use background measurement like the temperature sensing and
>> default to lowest precision and lowest measurement rate.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Hi Eddie,
>
> A few comments inline.  One is around how you might look at adding
> fifo support (pushing to an IIO buffer) in the future...  The IIO
> data model isn't as flexible as this device can be, so we may need
> to put some restrictions on combinations of options.
>
> Jonathan
>> ---
>>   drivers/iio/pressure/dps310.c | 331 +++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 307 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
>> index c42808e..a7ee28c 100644
>> --- a/drivers/iio/pressure/dps310.c
>> +++ b/drivers/iio/pressure/dps310.c
>> @@ -11,11 +11,11 @@
>>    *   c0 * 0.5 + c1 * T_raw / kT °C
>>    *
>>    * TODO:
>> - *  - Pressure sensor readings
>>    *  - Optionally support the FIFO
>>    */
>>   
>>   #include <linux/i2c.h>
>> +#include <linux/math64.h>
>>   #include <linux/module.h>
>>   #include <linux/regmap.h>
>>   
>> @@ -29,6 +29,8 @@
>>   #define DPS310_TMP_B1		0x04
>>   #define DPS310_TMP_B2		0x05
>>   #define DPS310_PRS_CFG		0x06
>> +#define  DPS310_PRS_RATE_BITS	GENMASK(6, 4)
>> +#define  DPS310_PRS_PRC_BITS	GENMASK(3, 0)
>>   #define DPS310_TMP_CFG		0x07
>>   #define  DPS310_TMP_RATE_BITS	GENMASK(6, 4)
>>   #define  DPS310_TMP_PRC_BITS	GENMASK(3, 0)
>> @@ -82,6 +84,8 @@ struct dps310_data {
>>   	struct regmap *regmap;
>>   

>> +
>>   static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
>>   {
>>   	switch (reg) {
>> @@ -253,24 +387,141 @@ static int dps310_write_raw(struct iio_dev *iio,
>>   {
>>   	struct dps310_data *data = iio_priv(iio);
>>   
>> -	if (chan->type != IIO_TEMP)
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		switch (chan->type) {
>> +		case IIO_PRESSURE:
>> +			return dps310_set_pres_samp_freq(data, val);
>> +
>> +		case IIO_TEMP:
>> +			return dps310_set_temp_samp_freq(data, val);
> This may need a bit of thought if there is any chance we will later support
> the fifo.
>
> The IIO model is that of scans that read all channels at each 'trigger'. In
> devices like this which allow for different sampling rates for different sensor
> channels there are two options.
>
> 1) Don't support it.
> 2) Deal with registering two separate IIO devices and do the demux in the
> driver to the relevant one.
>
> All depends on whether there is a substantial usecase for different sampling
> rates or not.  Here I suspect the answer is not.
>
> The complexity is that, you then need to work out how to 'upgrade' the
> interface when buffered support is added. Obvious options are:
>
> 1) Refuse to move to buffered mode if the sampling frequencies are different.
> 2) Force the slower channel to be sampled faster if that is possible.
> 3) Change to only having one exposed sampling frequency at all - the problem
> with this last one is that it changes the ABI for existing users.
>
> It may be no one ever cares about the fifo mode though as high speed pressure
> measurement is 'unusual' ;)


Thanks for the comments Jonathan. I will follow your suggestions 
throughout the driver.

The sampling rates are a bit confusing for me, and I haven't looked into 
the buffered mode at all. Are you saying that in the current form, it 
won't work to use different sampling frequencies for the two sensors 
(without buffered mode I mean)? I haven't noticed any problems in my 
tests. I'm inclined force the slower channel to be sampled faster if 
necessary when buffered mode is implemented.

Thanks,

Eddie


>
>> +
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +
>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> +		switch (chan->type) {
>> +		case IIO_PRESSURE:
>> +			return dps310_set_pres_precision(data, val);
>> +
>> +		case IIO_TEMP:
>> +			return dps310_set_temp_precision(data, val);
>> +
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +
>> +	default:
>>   		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int dps310_calculate_pressure(struct dps310_data *data)
>> +{
>> +	int i, r, t_ready;
>> +	int kpi = dps310_get_pres_k(data);
>> +	int kti = dps310_get_temp_k(data);
>> +	s64 rem = 0ULL;
>> +	s64 pressure = 0ULL;
>> +	s64 p;
>> +	s64 t;
>> +	s64 denoms[7];
>> +	s64 nums[7];
>> +	s64 rems[7];
>> +	s64 kp;
>> +	s64 kt;
>> +
>> +	if (kpi < 0)
>> +		return kpi;
>> +
>> +	if (kti < 0)
>> +		return kti;
>> +
>> +	kp = (s64)kpi;
>> +	kt = (s64)kti;
>> +
>> +	/* Refresh temp if it's ready, otherwise just use the latest value */
>> +	r = regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
>> +	if (r >= 0 && t_ready & DPS310_TMP_RDY)
>> +		dps310_read_temp_ready(data);
>> +
>> +	p = (s64)data->pressure_raw;
>> +	t = (s64)data->temp_raw;
>> +
>> +	/* Section 4.9.1 of the DPS310 spec; algebra'd to avoid underflow */
>> +	nums[0] = (s64)data->c00;
>> +	denoms[0] = 1LL;
>> +	nums[1] = p * (s64)data->c10;
>> +	denoms[1] = kp;
>> +	nums[2] = p * p * (s64)data->c20;
>> +	denoms[2] = kp * kp;
>> +	nums[3] = p * p * p * (s64)data->c30;
>> +	denoms[3] = kp * kp * kp;
>> +	nums[4] = t * (s64)data->c01;
>> +	denoms[4] = kt;
>> +	nums[5] = t * p * (s64)data->c11;
>> +	denoms[5] = kp * kt;
>> +	nums[6] = t * p * p * (s64)data->c21;
>> +	denoms[6] = kp * kp * kt;
>> +
>> +	/* Kernel lacks a div64_s64_rem function; denoms are all positive */
>> +	for (i = 0; i < 7; ++i) {
>> +		u64 rem;
>> +
>> +		if (nums[i] < 0LL) {
>> +			pressure -= div64_u64_rem(-nums[i], denoms[i], &rem);
>> +			rems[i] = -rem;
>> +		} else {
>> +			pressure += div64_u64_rem(nums[i], denoms[i], &rem);
>> +			rems[i] = (s64)rem;
>> +		}
>> +	}
>> +
>> +	/* Increase precision and calculate the remainder sum */
>> +	for (i = 0; i < 7; ++i)
>> +		rem += div64_s64((s64)rems[i] * 1000000000LL, denoms[i]);
>> +
>> +	pressure += div_s64(rem, 1000000000LL);
>> +
>> +	return (int)pressure;
>> +}
>> +
>> +static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
>> +				long mask)
>> +{
>> +	int ret;
>>   
>>   	switch (mask) {
>>   	case IIO_CHAN_INFO_SAMP_FREQ:
>> -		return dps310_set_temp_samp_freq(data, val);
>> +		*val = dps310_get_pres_samp_freq(data);
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = dps310_read_pres_raw(data);
>> +		if (ret)
>> +			return ret;
>> +
>> +		*val = dps310_calculate_pressure(data);
> This is rather far from raw :)  It might be better at this point to just
> go for PROCESSED and apply the scale in here.
>
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = 1;
>> +		*val2 = 1000; /* Convert Pa to KPa per IIO ABI */
>> +		return IIO_VAL_FRACTIONAL;
>> +
>>   	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>> -		return dps310_set_temp_precision(data, val);
>> +		*val = dps310_get_pres_precision(data);
>> +		return IIO_VAL_INT;
>> +
>>   	default:
>>   		return -EINVAL;
>>   	}
>>   }
>>   
>> -static int dps310_read_raw(struct iio_dev *iio,
>> -			   struct iio_chan_spec const *chan,
>> -			   int *val, int *val2, long mask)
>> +static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
>> +			    long mask)
>>   {
>> -	struct dps310_data *data = iio_priv(iio);
>>   	int ret;
>>   
>>   	switch (mask) {
>> @@ -279,7 +530,7 @@ static int dps310_read_raw(struct iio_dev *iio,
>>   		return IIO_VAL_INT;
>>   
>>   	case IIO_CHAN_INFO_RAW:
>> -		ret = dps310_read_temp(data);
>> +		ret = dps310_read_temp_raw(data);
>>   		if (ret)
>>   			return ret;
>>   
>> @@ -312,6 +563,24 @@ static int dps310_read_raw(struct iio_dev *iio,
>>   	}
>>   }
>>   
>> +static int dps310_read_raw(struct iio_dev *iio,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val, int *val2, long mask)
>> +{
>> +	struct dps310_data *data = iio_priv(iio);
>> +
>> +	switch (chan->type) {
>> +	case IIO_PRESSURE:
>> +		return dps310_read_pressure(data, val, val2, mask);
>> +
>> +	case IIO_TEMP:
>> +		return dps310_read_temp(data, val, val2, mask);
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>   static const struct regmap_config dps310_regmap_config = {
>>   	.reg_bits = 8,
>>   	.val_bits = 8,
>> @@ -393,6 +662,13 @@ static int dps310_probe(struct i2c_client *client,
>>   		return PTR_ERR(data->regmap);
>>   
>>   	/*
>> +	 * Set up pressure sensor in single sample, one measurement per second
>> +	 * mode
>> +	 */
>> +	r = regmap_write(data->regmap, DPS310_PRS_CFG,
>> +			 DPS310_CALC_RATE(1) | DPS310_CALC_PRC(1));
>> +
>> +	/*
>>   	 * Set up external (MEMS) temperature sensor in single sample, one
>>   	 * measurement per second mode
>>   	 */
>> @@ -402,16 +678,23 @@ static int dps310_probe(struct i2c_client *client,
>>   	if (r < 0)
>>   		goto err;
>>   
>> -	/* Temp shift is disabled when PRC <= 8 */
>> +	/* Temp and pressure shifts are disabled when PRC <= 8 */
>>   	r = regmap_write_bits(data->regmap, DPS310_CFG_REG,
>> -			      DPS310_TMP_SHIFT_EN, 0);
>> +			      DPS310_TMP_SHIFT_EN | DPS310_PRS_SHIFT_EN, 0);
>> +	if (r < 0)
>> +		goto err;
>> +
>> +	/* MEAS_CFG doesn't seem to update unless first written with 0 */
>> +	r = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>> +			      DPS310_MEAS_CTRL_BITS, 0);
>>   	if (r < 0)
>>   		goto err;
>>   
>> -	/* Turn on temperature measurement in the background */
>> +	/* Turn on temperature and pressure measurement in the background */
>>   	r = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
>>   			      DPS310_MEAS_CTRL_BITS,
>> -			      DPS310_TEMP_EN | DPS310_BACKGROUND);
>> +			      DPS310_PRS_EN | DPS310_TEMP_EN |
>> +			      DPS310_BACKGROUND);
>>   	if (r < 0)
>>   		goto err;
>>   
>> @@ -424,7 +707,7 @@ static int dps310_probe(struct i2c_client *client,
>>   	if (r < 0)
>>   		goto err;
>>   
>> -	r = dps310_get_temp_coef(data);
>> +	r = dps310_get_coefs(data);
>>   	if (r < 0)
>>   		goto err;
>>   

