Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752DC57A28F
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 17:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiGSPBJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiGSPAw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 11:00:52 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CFC28E1E
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 08:00:51 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JDAGcF007925;
        Tue, 19 Jul 2022 11:00:48 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3hbq66vpp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 11:00:48 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 26JF0k8g063797
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jul 2022 11:00:46 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Jul 2022 11:00:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Jul 2022 11:00:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Jul 2022 11:00:45 -0400
Received: from euswvd-wpr-708.reddog.microsoft.com ([10.140.226.204])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26JF0L5E025152;
        Tue, 19 Jul 2022 11:00:40 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <andy.shevchenko@gmail.com>,
        <Ibrahim.Tilki@analog.com>
Subject: Re: [PATCH v2 1/3] iio: adc: add max11410 adc driver
Date:   Tue, 19 Jul 2022 14:59:31 +0000
Message-ID: <20220719145932.96-2-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707174739.21fe67ea@jic23-huawei>
References: <20220707174739.21fe67ea@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: aenSKUAWoxmsDFvZ8YlsOAyXTmnS6igo
X-Proofpoint-ORIG-GUID: aenSKUAWoxmsDFvZ8YlsOAyXTmnS6igo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_03,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190062
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> On Thu, 7 Jul 2022 08:31:24 +0000
> Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:
> 
> > Adding support for max11410 24-bit, 1.9ksps delta-sigma adc which
> > has 3 differential reference and 10 differential channel inputs.
> > Inputs and references can be buffered internally. Inputs can also
> > be amplified with internal PGA.
> > 
> > Device has a digital filter that is controlled by a custom sysfs attribute.
> > User has four options to choose from: fir50/60, fir50, fir60 and sinc4.
> > Digital filter selection affects sampling frequency range so driver
> > has to consider the configured filter when configuring sampling frequency.
> > 
> > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> 
> Hi Ibrahim,
> 
> As you probably expect, quite a bit of the feedback inline is about the
> custom sysfs attribute. I think we need to fit that more closely to the current
> filter ABI.  It's not a perfect fit however, but I make some suggestions inline.
> 
> thanks,
> 
> Jonathan
> 

Hi Jonathan,

Thanks for the review, I've resolved most of the items and will send v3 soon after
I perform some more tests with the hardware. In the meantime I have some questions inline.

Regards,
Ibrahim

...

> > +static int max11410_read_reg(struct max11410_state *st,
> > +			     unsigned int reg,
> > +			     int *val)
> > +{
> > +	u8 data[3];
> > +	int ret;
> > +
> > +	if (max11410_reg_size(reg) == 3) {
> > +		ret = regmap_bulk_read(st->regmap, reg, data, 3);
> 
> Ah. There is a fun corner here.  SPI bulk reads in general
> require DMA safe buffers (basically they need to be on the heap, not the
> stack and we need to enforce that nothing else shares a cacheline with them).
> Now, last time I checked regmap happens to always end up using a safe bounce
> buffer, but it's not documented as such and there is no guarantee it will continue
> to do so.  We checked this with the maintainer a while back and the answer
> was to always use DMA safe buffers with bulk accesses.
> Whilst that might have changed, I've not heard anything about it doing so.
> 

So I guess having this would solve dma alignment and the leak issue in max11410_trigger_handler
and the data field can be shared between?

struct max11410_state {
	// ...
	struct {
		int data ____cacheline_aligned;
		s64 ts __aligned(8);
	} scan;
};

...

> > +static const char * const config_filter[] = {"fir50/60", "fir50", "fir60", "sinc4"};
> 
> Hmm.  Named filters are a pain because userspace can rarely figure out what
> to do with them.  Here we have some notch filters (and we have ABI defined for those)
> but the fir50/60 is unusual as it's some sort of double notch.  I think the
> sinc4 is a higher frequency notch filter..
> 
> We need to be very careful with naming this attribute though as the ABI
> documentation system will only allow us one iio:deviceX/filter entry.
> We can't have it different across different drivers.
> 
> Hence, let's try and fit this in (more or less) current ABI.
> 
> in_voltageX_filter_notch_centre - (50 or 60 or whatever the SPS rate is)
> 
> That just leaves us with the double notch.  I'm a bit stuck on that
> one so we may need to add new ABI for it which also means adding
> enable attributes for the filters which we've so far not done.
> 
> If anyone has a suggestion for a good solution to this then let us know.
> Maybe something like
> 
> in_voltageX_filter0_notch_centre
> in_voltageX_filter0_notch_en
> in_votlageX_filter1_notch_centre
> in_voltageX_filter1_notch_en
> 
> If filter0_notch_en is set and the value is 50 or 60 then
> filter1_notch_centre_available has the other value.
> To enable double notch filtering both enables have to be set.
> 
> The side effect will be that no existing userspace will understand
> this.
> 

The thing is sinc4 filter has no fixed notch frequency, it is a function of sampling rate.
So even if we somehow do it this way, sinc4 rejection frequency can be 60Hz when sampling
rate is 60sps. This can create ambiguity between sinc4 and fir60. I think the filter of
the device has a unique characteristic to be fit into standard ABI.

Would it be a good idea to add ABI for filter type?
in_voltageX_filter_type

...

> > +
> > +static int max11410_read_avail(struct iio_dev *indio_dev,
> > +			       struct iio_chan_spec const *chan,
> > +			       const int **vals, int *type, int *length,
> > +			       long info)
> > +{
> > +	int ret, reg_val, filter;
> > +	struct max11410_state *st = iio_priv(indio_dev);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> 
> Hardware gain is rarely what you actually want for an ADC.
> It is used to describe gain for things not directly related
> to the actual measurement made.
> 
> If this affects the multiplier that should be applied to _raw
> then it is _SCALE;  In this case you will need to take
> into account the combination of this PGA and the reference
> voltages to compute the available values for SCALE
> 

This controls the gain of internal PGA which amplifies the input signal right before the ADC
conversion takes place. From this I understand that I need to divide _SCALE by hardware gain
to compensate PGA effect.

...

> > +		cfg = &st->channels[chan_idx];
> > +		ret = fwnode_property_read_u32(child, "adi,reference", &reference);
> > +		if (ret) {
> > +			cfg->refsel = REFSEL_AVDD_AGND;
> > +		} else {
> > +			if (reference > REFSEL_MAX)
> > +				return dev_err_probe(&indio_dev->dev,
> > +						     -EINVAL,
> > +						     "Invalid adi,reference value for %s, should be less than %d.\n",
> > +						     fwnode_get_name(child),
> > +						     REFSEL_MAX + 1);
> > +
> > +			cfg->refsel = reference;
> > +		}
> 
> Simplified if you rely on fwnode_property_read_u32 not setting reference unless it succeeds.
> 
> 		cfg->refsel = REFSEL_AVDD_AGND;
> 		fwnode_property_read_u32(child, "adi,reference", &reference);
> 		if (reference > REFSEL_MAX)
> 			return dev_err_probe(...);
> 
> However, this DT binding is non obvious as 0-2 are nicely labeled pins, but
> 3 is 'magic' and corresponds to AVDD.
> 
> Perhaps we want the binding to not include setting it to AVDD.  The absense
> of the property resulting in that fallback?
> I'm also a bit confused why we don't have an issue if differential channel
> and vrefn isn't supplied (but vrefp is)?
> 

Driver assumes vrefn input is connected to GND if not specified in DT.
Should we force the user to specify vrefn regulator even if the applied voltage is zero?
If so, I can also add a check for vrefn.

> > +		if (!max11410_get_vrefp(st, cfg->refsel))
> > +			return dev_err_probe(&indio_dev->dev,
> > +					     -EINVAL,
> > +					     "Invalid VREF configuration for %s, either specify corresponding VREFP regulator or change adi,reference property.\n",
> > +					     fwnode_get_name(child));
> > +
> > +		ret = fwnode_property_read_u32(child, "adi,input-mode", &sig_path);

...

> 
> > +MODULE_AUTHOR("David Jung <david.jung@analog.com>");
> 
> Why no sign-off / co-developed by tags for David?
> 

This driver is based on David's work which took place some time ago.
I've introduced a lot of changes/features and contacted him before sending the patch but
unfortunately didn't hear from him within a resonable time frame. Thus I thought it would
not be okay to add sign-off tag.

> > +MODULE_AUTHOR("Ibrahim Tilki <ibrahim.tilki@analog.com>");
> > +MODULE_DESCRIPTION("Analog Devices MAX11410 ADC");
> > +MODULE_LICENSE("GPL v2");
