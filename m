Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635CB2D9037
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 20:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgLMTfU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 14:35:20 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:37243 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgLMTfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2020 14:35:20 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B61F8200003;
        Sun, 13 Dec 2020 19:34:36 +0000 (UTC)
Date:   Sun, 13 Dec 2020 20:34:36 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] iio:common:ms_sensors:ms_sensors_i2c: add support
 for alternative PROM layout
Message-ID: <20201213193436.GM1781038@piout.net>
References: <20201209234857.1521453-1-alexandre.belloni@bootlin.com>
 <20201209234857.1521453-6-alexandre.belloni@bootlin.com>
 <20201213172042.76b2e028@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213172042.76b2e028@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 13/12/2020 17:20:42+0000, Jonathan Cameron wrote:
> > +/**
> > + * ms_sensors_tp_crc_valid_112() - CRC check function for
> > + *     Temperature and pressure devices for 112bit PROM.
> > + *     This function is only used when reading PROM coefficients
> > + *
> > + * @prom:	pointer to PROM coefficients array
> > + *
> > + * Return: CRC.
> 
> That's a bit confusing.  Perhaps return if CRC correct
> Sometimes CRC is used to refer to particular bits and sometimes
> to the check (i.e. whether it is right).
> 

Roght, this should have been "Return: True if CRC is ok."

> > + */
> > +static bool ms_sensors_tp_crc_valid_112(u16 *prom)
> > +{
> > +	u16 w0 = prom[0], crc_read = (w0 & 0xF000) >> 12;
> > +	u8 crc;
> > +
> > +	prom[0] &= 0x0FFF;      /* Clear the CRC computation part */
> > +	prom[MS_SENSORS_TP_PROM_WORDS_NB - 1] = 0;
> > +
> > +	crc = ms_sensors_tp_crc4(prom);
> > +
> > +	prom[0] = w0;
> > +
> > +	return crc == crc_read;
> > +}
> > +
> > +/**
> > + * ms_sensors_tp_crc_valid_128() - CRC check function for
> > + *     Temperature and pressure devices for 128bit PROM.
> > + *     This function is only used when reading PROM coefficients
> > + *
> > + * @prom:	pointer to PROM coefficients array
> > + *
> > + * Return: CRC.
> > + */
> > +static bool ms_sensors_tp_crc_valid_128(u16 *prom)
> > +{
> > +	u16 w7 = prom[7], crc_read = w7 & 0x000F;
> > +	u8 crc;
> > +
> > +	prom[7] &= 0xFF00;      /* Clear the CRC and LSB part */
> > +
> > +	crc = ms_sensors_tp_crc4(prom);
> > +
> > +	prom[7] = w7;
> > +
> > +	return crc == crc_read;
> >  }
> >  
> >  /**
> > @@ -535,6 +577,7 @@ static bool ms_sensors_tp_crc_valid(u16 *prom)
> >  int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
> >  {
> >  	int i, ret;
> > +	bool valid;
> >  
> >  	for (i = 0; i < dev_data->hw->prom_len; i++) {
> >  		ret = ms_sensors_read_prom_word(
> > @@ -546,7 +589,12 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
> >  			return ret;
> >  	}
> >  
> > -	if (!ms_sensors_tp_crc_valid(dev_data->prom)) {
> > +	if (dev_data->hw->prom_len == 8)
> > +		valid = ms_sensors_tp_crc_valid_128(dev_data->prom);
> > +	else
> > +		valid = ms_sensors_tp_crc_valid_112(dev_data->prom);
> > +
> > +	if (!valid) {
> >  		dev_err(&dev_data->client->dev,
> >  			"Calibration coefficients crc check error\n");
> >  		return -ENODEV;
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
