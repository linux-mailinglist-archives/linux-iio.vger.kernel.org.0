Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D36C23302D
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jul 2020 12:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgG3KTg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jul 2020 06:19:36 -0400
Received: from mailout10.rmx.de ([94.199.88.75]:48133 "EHLO mailout10.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3KTf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Jul 2020 06:19:35 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout10.rmx.de (Postfix) with ESMTPS id 4BHRGp5lxyz36vg;
        Thu, 30 Jul 2020 12:19:30 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BHRGZ0yJ6z2TTLy;
        Thu, 30 Jul 2020 12:19:18 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.117) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 30 Jul
 2020 12:18:57 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: light: as73211: New driver
Date:   Thu, 30 Jul 2020 12:18:56 +0200
Message-ID: <2665878.D8vGGo3OXt@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20200728190114.00004636@Huawei.com>
References: <20200728062831.1143-1-ceggers@arri.de> <20200728062831.1143-3-ceggers@arri.de> <20200728190114.00004636@Huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.117]
X-RMX-ID: 20200730-121918-4BHRGZ0yJ6z2TTLy-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan.

got your review nearly simultaneous with Andy's. There are many overlaps
between both. Most is already integrated, below I left only the open points.

On Tuesday, 28 July 2020, 20:01:14 CEST, Jonathan Cameron wrote:
> Hi Christian,
> 
> I took a fairly quick look. Not divided into the datasheet or anything yet!

> Christian Eggers <ceggers@arri.de> wrote:
> > +/**
> > + * struct as73211_data - Instance data for one AS73211
> > + * @client: I2C client.
> > + * @osr:    Cached Operational State Register.
> > + * @creg1:  Cached Configuration Register 1.
> > + * @creg2:  Cached Configuration Register 2.
> > + * @creg3:  Cached Configuration Register 3.
> 
> Just a thought, but why not creg[3]?;
creg[3] would be indexed from 0 to 2. But the datasheet names them 1 to 3.

> > + * @buffer: Buffer for triggered measurements.
> 
> ?  Run kernel-doc, or build with W=1 and to check docs.
I ran "make htmldoc" and enabled W=1. Are there any errors I should see?

> > +static unsigned int as73211_integration_time_us(struct as73211_data
> > *data)
> > +{
> > +	/* Integration time has 15 steps, the step size depends on the 
clock. */
> > +	unsigned int mul = 1 << (3 - (data->creg3 & 0b11));  /* 8 = 1.024 
MHz, 4
> > = 2.048 MHz ...*/ +	unsigned int time_cycles =
> > as73211_integration_time_cycles(data); +	unsigned int time_us =
> > time_cycles * 125 * mul;
> 
> This would be easier to read as
> 
> 	unsigned int mul, time_cycles;
> 
> 	mul = ...
> 
> 	return time_cycles * 125 * mul;
> 
changed this according to Andy's proposal.

> > +static int as73211_read_raw(struct iio_dev *indio_dev,
> > +			struct iio_chan_spec const *chan,
> > +			int *val, int *val2, long mask)
> 
> Align parameters with opening bracket.
Mixed tabs(8) and spaces or only spaces?

> > +static int _as73211_write_raw(struct iio_dev *indio_dev,
> > +			struct iio_chan_spec const *chan 
__always_unused,
> 
> Whilst true, what's the benefit of marking that as __always_unused?
> 
I read somewhere in the process docs that I should build with EXTRA_CFLAGS=-W

> > +		} else {
> > +			/* saturate all channels (useful for 
overflows) */
> > +			iio_buffer[1] = 0xffff;
> > +			iio_buffer[2] = 0xffff;
> > +			iio_buffer[3] = 0xffff;
> 
> That is rather non standard.
How do other drivers handle measurement errors in buffered mode? The
application needs to know about measurement overflows as the integration
time and gain have to be adjusted in case.

> > +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(as73211_show_samp_freq_available);
> > +static IIO_DEV_ATTR_INT_TIME_AVAIL(as73211_show_int_time_available);
> > +static IIO_DEVICE_ATTR(hardwaregain_available, S_IRUGO,
> > +		as73211_show_hardwaregain_available, NULL, 0);
> > +static IIO_CONST_ATTR_TEMP_OFFSET("-66.9");
> > +static IIO_CONST_ATTR_TEMP_SCALE("0.05");
> > +
> > +static struct attribute *as73211_attributes[] = {
> > +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> > +	&iio_dev_attr_integration_time_available.dev_attr.attr,
> > +	&iio_dev_attr_hardwaregain_available.dev_attr.attr,
> > +	&iio_const_attr_in_temp_offset.dev_attr.attr,
> > +	&iio_const_attr_in_temp_scale.dev_attr.attr,
> 
> These should be handled via read_raw.
Only the last two ones?

> Ideally do the _available ones via the core callbacks
> and _avail masks as well. For the more complex values,
> compute the table on first read or at probe and cache it.
The list of available values can depend on the setting of other attributes
(e.g. available integration times depends on sampling frequency).

> > +	indio_dev->dev.parent = &client->dev;
> 
> That is now set by the IIO core, so no need to set it manually.
Can you please give me a pointer? Before removing this in my branch, I need to
make sure that this is already available in the kernel I'm using (5.4.latest).

> > +buffer_cleanup:
> > +	iio_triggered_buffer_cleanup(indio_dev);
> 
> Should we not powerdown on error?
yes, we should.

> Also rather feels like we should have a trivial powerup function to
> match with powerdown.
changed as73211_powerdown() to as73211_power()

regards
Christian



