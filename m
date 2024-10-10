Return-Path: <linux-iio+bounces-10395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D5998DB5
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE59E28243B
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 16:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCDC198A3F;
	Thu, 10 Oct 2024 16:43:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03F1957E4;
	Thu, 10 Oct 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578585; cv=none; b=IQBP6BZVpstZbD1DAQfgFSSJqVmj5G1wrSH5oZxua/SLSqGbJxAQRw4HE4YZOlXKJs1RXNHFygHNQNLDE9jnJtHnxyFz6zYi7lqn0uzOkQgZUSQjR95Cq50C0TEONF+As9oQFjwmKCzli05qR8KhJNHMMT3zVsN1+X90gI2fd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578585; c=relaxed/simple;
	bh=r4NtgP9B0pH09kJ7304ht3TV5b9FeLsxkrKrQhRaH1k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toS0ECZ0Ux8m3GPr6vSsplaWZUzzage7syugRwsplojxPK1DFvKEve87Wk/s3zLybozfc4uXxwJtMb4ELMNK7fgZbVONyhACjk0MFXGGmcXrrePnrY6eSBF0bOBeBql0/QwYyDBwrNC76RirY6JMcTLa4FOnV4cJIRErGP/Iz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPbBC3w18z6K6t7;
	Fri, 11 Oct 2024 00:41:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EF2A6140C98;
	Fri, 11 Oct 2024 00:43:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 18:43:00 +0200
Date: Thu, 10 Oct 2024 17:42:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
CC: Jonathan Cameron <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dima.fedrau@gmail.com" <dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
	<Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v8 2/2] iio: imu: smi240: add driver
Message-ID: <20241010174259.00003742@Huawei.com>
In-Reply-To: <AM8PR10MB47213230C6E43976AF244587CD782@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
	<20240923124017.43867-3-Jianping.Shen@de.bosch.com>
	<20240928181121.0e62f0ad@jic23-huawei>
	<AM8PR10MB47217960E30212DC62ED7821CD712@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20241006121025.50802061@jic23-huawei>
	<AM8PR10MB47213230C6E43976AF244587CD782@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Oct 2024 15:02:18 +0000
"Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com> wrote:

> >> >> +static int smi240_regmap_spi_read(void *context, const void *reg_buf,
> >> >> +				  size_t reg_size, void *val_buf,
> >> >> +				  size_t val_size)
> >> >> +{
> >> >> +	int ret;
> >> >> +	u32 request, response;
> >> >> +	u16 *val = val_buf;
> >> >> +	struct spi_device *spi = context;
> >> >> +	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> >> >> +	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
> >> >> +
> >> >> +	if (reg_size != 1 || val_size != 2)
> >> >> +		return -EINVAL;
> >> >> +
> >> >> +	request = FIELD_PREP(SMI240_WRITE_BUS_ID_MASK, SMI240_BUS_ID);
> >> >> +	request |= FIELD_PREP(SMI240_WRITE_CAP_BIT_MASK, iio_priv_data-
> >> >>capture);
> >> >> +	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
> >> >> +	request |= smi240_crc3(request, SMI240_CRC_INIT,
> >> >> +SMI240_CRC_POLY);
> >> >> +
> >> >> +	iio_priv_data->spi_buf = cpu_to_be32(request);
> >> >> +
> >> >> +	/*
> >> >> +	 * SMI240 module consists of a 32Bit Out Of Frame (OOF)
> >> >> +	 * SPI protocol, where the slave interface responds to
> >> >> +	 * the Master request in the next frame.
> >> >> +	 * CS signal must toggle (> 700 ns) between the frames.
> >> >> +	 */
> >> >> +	ret = spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> >> >> +	if (ret)
> >> >> +		return ret;
> >> >> +
> >> >> +	ret = spi_read(spi, &iio_priv_data->spi_buf, sizeof(response));
> >> >> +	if (ret)
> >> >> +		return ret;
> >> >> +
> >> >> +	response = be32_to_cpu(iio_priv_data->spi_buf);
> >> >> +
> >> >> +	if (!smi240_sensor_data_is_valid(response))
> >> >> +		return -EIO;
> >> >> +
> >> >> +	*val = cpu_to_le16(FIELD_GET(SMI240_READ_DATA_MASK, response));  
> >> >So this is line sparse doesn't like which is reasonable given you are
> >> >forcing an le16 value into a u16.
> >> >Minimal fix is just to change type of val to __le16 *
> >> >
> >> >I still find the endian handling in here mess and am not convinced
> >> >the complexity is strictly necessary or correct.
> >> >
> >> >I'd expect the requirements of reordering to be same in read and
> >> >write directions (unless device is really crazy), so why do we need a
> >> >conversion to le16 here but not one from le16 in the write?  
> >>
> >> Hello Jonathan,
> >>
> >> yes, you are right. The "cpu_to_le16" is not required at all.  SMI240 does not use  
> >the standard SPI protocol, on the other side the regmap is designed to use
> >standard SPI protocol (by default) and may flip the register value dependent on
> >"val_format_endian".
> >
> >It should still need to place the two bytes of that 16 bit value in the correct order to send to hardware.  That may be handled via a 32 bit word length on SPI though.  
> 
> 
> This is the most confusing part.  During the request preparation, we focus on the bit order not the byte order. We need to bring the 16 bit value in the correct bit order, to the correct bit position in the 32 bit request. This is automatically guarantied using FIELD_PREP. FIELD_PREP shifts the data 15-0 to request 18-3. We shall never manually change the byte order of the 16 bit value. The byte order (of the whole request) becomes important when we send it over spi, which will be explained later.
> 
> 
> >>When the both work together, it may lead to confusing.  Let me make it clear.
> >>
> >> In the SMI240, the register address is 8 bit and each register is 16 bit. We do not have any register value, which is bigger than 16 bit and need to be stored in multiple registers.  Therefore the device does not need endian. Neither big endian nor Little Endian.   To access the register, it is important to prepare the request frame according to the specification.
> >>
> >> A request is 32 bit
> >>
> >> 	ID	ADR	W	CAP	*	WDATA	CRC
> >> 	31-30	29-22	21	20	19	18-3		2-0
> >>
> >> ID: device id (if more than 1 device)
> >> ADR: reg address
> >> W: write/read
> >> CAP: capture mode on/off
> >> *: reserved
> >> WDATA : reg value bit 15-0 
> >> CRC: check sum
> >>
> >> To prepare the request properly, the bit order is here critical. We need to put each part in its bit position. The request is created as a local u32, with help of FIELD_PREP, we put the value of each part to its bit position. FIELD_PREP will take care of the cpu endian and always put the value to the correct bit position. Before we send the request via SPI, a cpu endian to big endian conversion is required.  
> >
> >So there are two possibilities here.  Either the byte order is just reversed for the device in which case fine as you describe or perhaps the SPI transfers should be using a 32 bit word?  You'd do that by overriding the bits_per_word in the individual SPI transfers.
> >
> >  
> >> Since the spi bus transfers data using big endian. When we get the response from spi, the response is big endian and need to be converted in cpu endian.  Any other manually endian conversion is not required.  
> >
> >The SPI bus itself has no real concept of endian as such. It just sends bits in the order it is fed them.  The device may require a particular ordering of course if we assume it makes sense to break the transfers up into byte size chnunks.  
> 
> 
> Yes, the device expect that the 32 bit request will be sent from MSBit to LSBit. Which means the ID shall be sent firstly, followed by ADR, W, CAP, *, WDATA, CRC.  If we consider the 32 bit as 4 bytes , then the MSB need to sent firstly, and followed by the LSBs. From this perspective we can say that the SMI240 SPI protocol requires big endian. On the host side the request is a local u32 (4 bytes). To make sure that the MSB will be sent firstly we need to convert the request to big endian before sending it over spi.

Understood.  Try a 32 bit word size for the spi transfers.
I think that should make everything work without any
need to make it big endian.

Jonathan

> 
> Best regards
> Jianping Shen
> 
> 
> >See if setting the word size to 32 bits solves your issues without the need for any endian conversions.
> >
> >Jonathan
> >
> >  
> 
> 


