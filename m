Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEDF61882E2
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 13:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCQMFk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 08:05:40 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:49552 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgCQMFk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Mar 2020 08:05:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 17C74FB03;
        Tue, 17 Mar 2020 13:05:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LQVffm-bFDdy; Tue, 17 Mar 2020 13:05:36 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0B565412BE; Tue, 17 Mar 2020 13:05:35 +0100 (CET)
Date:   Tue, 17 Mar 2020 13:05:35 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: vcnl4000: Export near level property for
 proximity sensor
Message-ID: <20200317120535.GA16807@bogon.m.sigxcpu.org>
References: <cover.1584380360.git.agx@sigxcpu.org>
 <5566fe01df933d3281f058666e2147cb97b38126.1584380360.git.agx@sigxcpu.org>
 <c787921f-c412-4986-14ea-e31b531d3d5b@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c787921f-c412-4986-14ea-e31b531d3d5b@metafoo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
On Mon, Mar 16, 2020 at 07:23:01PM +0100, Lars-Peter Clausen wrote:
> On 3/16/20 6:46 PM, Guido Günther wrote:
> > [...]
> > +static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
> > +					uintptr_t priv,
> > +					const struct iio_chan_spec *chan,
> > +					char *buf)
> > +{
> > +	struct vcnl4000_data *data = iio_priv(indio_dev);
> > +
> > +	return sprintf(buf, "%u\n", data->near_level);
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
> > +	{
> > +		.name = "near_level",
> 
> Generally having properties with a underscore in them breaks generic parsing
> of the property name by userspace applications. This is because we use
> underscores to separate different components (type, modifier, etc.) of the
> attribute from each other.
> 
> Do you think calling this "nearlevel" would work?

That works as well. I'll change that for v3.

For my education: Is the type, modifier policy written down somewhere
(similar to
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/leds/leds-class.rst#n44
)?

Cheers,
 -- Guido

> 
> I know there are existing bad examples of properties that use an underscore,
> but we should try to limit introducing new ones.
> 
> > +		.shared = IIO_SEPARATE,
> > +		.read = vcnl4000_read_near_level,
> > +	},
> > +	{ /* sentinel */ }
> > +};
> > +
> >   static const struct iio_chan_spec vcnl4000_channels[] = {
> >   	{
> >   		.type = IIO_LIGHT,
> > @@ -350,6 +371,7 @@ static const struct iio_chan_spec vcnl4000_channels[] = {
> >   	}, {
> >   		.type = IIO_PROXIMITY,
> >   		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > +		.ext_info = vcnl4000_ext_info,
> >   	}
> >   };
> > @@ -439,6 +461,10 @@ static int vcnl4000_probe(struct i2c_client *client,
> >   	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
> >   		data->chip_spec->prod, data->rev);
> > +	if (device_property_read_u32(&client->dev, "near-level",
> > +				     &data->near_level) < 0)
> > +		data->near_level = 0;
> > +
> >   	indio_dev->dev.parent = &client->dev;
> >   	indio_dev->info = &vcnl4000_info;
> >   	indio_dev->channels = vcnl4000_channels;
> 
> 
