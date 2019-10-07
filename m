Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCC3CDE9B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfJGKDO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 7 Oct 2019 06:03:14 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:46647 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfJGKDO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 06:03:14 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 11D0EFF802;
        Mon,  7 Oct 2019 10:03:09 +0000 (UTC)
Date:   Mon, 7 Oct 2019 12:03:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 4/7] iio: adc: max1027: Prepare the introduction of
 different resolutions
Message-ID: <20191007120308.29fba70d@xps13>
In-Reply-To: <20191006112236.481102f8@archlinux>
References: <20191003173401.16343-1-miquel.raynal@bootlin.com>
        <20191003173401.16343-5-miquel.raynal@bootlin.com>
        <20191006112236.481102f8@archlinux>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

> >  
> > +#define MAX1X27_CHANNELS(depth)			\
> > +	MAX1027_T_CHAN,				\
> > +	MAX1027_V_CHAN(0, depth),		\
> > +	MAX1027_V_CHAN(1, depth),		\
> > +	MAX1027_V_CHAN(2, depth),		\
> > +	MAX1027_V_CHAN(3, depth),		\
> > +	MAX1027_V_CHAN(4, depth),		\
> > +	MAX1027_V_CHAN(5, depth),		\
> > +	MAX1027_V_CHAN(6, depth),		\
> > +	MAX1027_V_CHAN(7, depth)
> > +
> > +#define MAX1X29_CHANNELS(depth)			\
> > +	MAX1027_V_CHAN(8, depth),		\
> > +	MAX1027_V_CHAN(9, depth),		\
> > +	MAX1027_V_CHAN(10, depth),		\
> > +	MAX1027_V_CHAN(11, depth)
> > +  
> 
> Modify this a touch so the macro for MAX1X29_CHANNELS includes
> MAX1X27_CHANNELS.  That way each macro's name matches what it
> does rather than the 'additional channels' for that device.

Sure.

> 
> > +#define MAX1X31_CHANNELS(depth)			\
> > +	MAX1027_V_CHAN(12, depth),		\
> > +	MAX1027_V_CHAN(13, depth),		\
> > +	MAX1027_V_CHAN(14, depth),		\
> > +	MAX1027_V_CHAN(15, depth)
> > +
> >  static const struct iio_chan_spec max1027_channels[] = {
> > -	MAX1027_T_CHAN,
> > -	MAX1027_V_CHAN(0),
> > -	MAX1027_V_CHAN(1),
> > -	MAX1027_V_CHAN(2),
> > -	MAX1027_V_CHAN(3),
> > -	MAX1027_V_CHAN(4),
> > -	MAX1027_V_CHAN(5),
> > -	MAX1027_V_CHAN(6),
> > -	MAX1027_V_CHAN(7)
> > +	MAX1X27_CHANNELS(10)
> >  };
> >  
> >  static const struct iio_chan_spec max1029_channels[] = {
> > -	MAX1027_T_CHAN,
> > -	MAX1027_V_CHAN(0),
> > -	MAX1027_V_CHAN(1),
> > -	MAX1027_V_CHAN(2),
> > -	MAX1027_V_CHAN(3),
> > -	MAX1027_V_CHAN(4),
> > -	MAX1027_V_CHAN(5),
> > -	MAX1027_V_CHAN(6),
> > -	MAX1027_V_CHAN(7),
> > -	MAX1027_V_CHAN(8),
> > -	MAX1027_V_CHAN(9),
> > -	MAX1027_V_CHAN(10),
> > -	MAX1027_V_CHAN(11)
> > +	MAX1X27_CHANNELS(10),
> > +	MAX1X29_CHANNELS(10)
> >  };
> >  
> >  static const struct iio_chan_spec max1031_channels[] = {
> > -	MAX1027_T_CHAN,
> > -	MAX1027_V_CHAN(0),
> > -	MAX1027_V_CHAN(1),
> > -	MAX1027_V_CHAN(2),
> > -	MAX1027_V_CHAN(3),
> > -	MAX1027_V_CHAN(4),
> > -	MAX1027_V_CHAN(5),
> > -	MAX1027_V_CHAN(6),
> > -	MAX1027_V_CHAN(7),
> > -	MAX1027_V_CHAN(8),
> > -	MAX1027_V_CHAN(9),
> > -	MAX1027_V_CHAN(10),
> > -	MAX1027_V_CHAN(11),
> > -	MAX1027_V_CHAN(12),
> > -	MAX1027_V_CHAN(13),
> > -	MAX1027_V_CHAN(14),
> > -	MAX1027_V_CHAN(15)
> > +	MAX1X27_CHANNELS(10),
> > +	MAX1X29_CHANNELS(10),
> > +	MAX1X31_CHANNELS(10)
> >  };
> >  
> >  static const unsigned long max1027_available_scan_masks[] = {
> > @@ -181,6 +171,7 @@ static const unsigned long max1031_available_scan_masks[] = {
> >  struct max1027_chip_info {
> >  	const struct iio_chan_spec *channels;
> >  	unsigned int num_channels;
> > +	unsigned int depth;  
> 
> Could we use the channel real_bits field instead of replicating the info?

I'll try. Indeed I would prefer not to replicate the info.


Thanks,
Miquèl
