Return-Path: <linux-iio+bounces-10226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14504991E03
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411B71C20F43
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9EA1741EF;
	Sun,  6 Oct 2024 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5lNXbFe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252AB4C91;
	Sun,  6 Oct 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728213036; cv=none; b=pPuKZAppI6HIULwULJ5K+mvIOgc9L3vmT3azfYJaeT7j7pHTzatIXTX6s5QAdjRFXjKkAYG9GSTTixs9v+XR5Cpp6RhQa+A7WNzsf0Vm1ozUZx5CpiPjXoBRvoF2ZzL7dR/vX36PMquTxel7TBn5ic7A7nk7653SNBSlIz23fgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728213036; c=relaxed/simple;
	bh=DYIkOmaCZc2d0QA9SA8rQnwlSBcNSW1VWGEKoTVr91M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoBzZEEG1lGPbnd4jMTigmzWpKM+44yeFoM/Xb0CWxAWTjViVCpZwpnursO/KQjNcz4KeRyhHP9P8qztwIEuBeJIAfdxGeKnF8TdabxrrGtWmQilq/cpd9UHEV3wvHflWxb2AG0vRRLv+EN79SnuKPqIbgQ1Ysi7CDOV9El29rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5lNXbFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EB0C4CEC5;
	Sun,  6 Oct 2024 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728213035;
	bh=DYIkOmaCZc2d0QA9SA8rQnwlSBcNSW1VWGEKoTVr91M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b5lNXbFeJ/sPCXtc8MLl9kab+gSsfJroKoMyLBoT8p2BuXTsRqurNOVa4jUyXPF/N
	 ZhmzvOhOgygTucdK3aNAGfFVrn8xGZQXmxLst5hUhChEze3wv5v/+6AdOUvHEFg46L
	 r/R6TLtVI53q9ltLhXpSqU/UzIHo4WosIKZvUgmtYtCqDDj9Tyyzl3kIV4wfTbQ0tU
	 LGJ746TL9avdVP+lOafoSKNwC+i/QZipYDRjvoTg2La6W8HfPAZI1zwKV44g2QIn33
	 Whu8l+LOloBEQIEfQPaQTAPAT1xOAQQmgu/adD0BbzMAdNNB7XaZ23SUScBnAd2F6v
	 4KI7WeoEjSvaA==
Date: Sun, 6 Oct 2024 12:10:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
 <dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
 <marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
 <Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
 <Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v8 2/2] iio: imu: smi240: add driver
Message-ID: <20241006121025.50802061@jic23-huawei>
In-Reply-To: <AM8PR10MB47217960E30212DC62ED7821CD712@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
	<20240923124017.43867-3-Jianping.Shen@de.bosch.com>
	<20240928181121.0e62f0ad@jic23-huawei>
	<AM8PR10MB47217960E30212DC62ED7821CD712@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 21:44:42 +0000
"Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com> wrote:

> >> +
> >> +static int smi240_regmap_spi_read(void *context, const void *reg_buf,
> >> +				  size_t reg_size, void *val_buf,
> >> +				  size_t val_size)
> >> +{
> >> +	int ret;
> >> +	u32 request, response;
> >> +	u16 *val = val_buf;
> >> +	struct spi_device *spi = context;
> >> +	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> >> +	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
> >> +
> >> +	if (reg_size != 1 || val_size != 2)
> >> +		return -EINVAL;
> >> +
> >> +	request = FIELD_PREP(SMI240_WRITE_BUS_ID_MASK, SMI240_BUS_ID);
> >> +	request |= FIELD_PREP(SMI240_WRITE_CAP_BIT_MASK, iio_priv_data-
> >>capture);
> >> +	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
> >> +	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> >> +
> >> +	iio_priv_data->spi_buf = cpu_to_be32(request);
> >> +
> >> +	/*
> >> +	 * SMI240 module consists of a 32Bit Out Of Frame (OOF)
> >> +	 * SPI protocol, where the slave interface responds to
> >> +	 * the Master request in the next frame.
> >> +	 * CS signal must toggle (> 700 ns) between the frames.
> >> +	 */
> >> +	ret = spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = spi_read(spi, &iio_priv_data->spi_buf, sizeof(response));
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	response = be32_to_cpu(iio_priv_data->spi_buf);
> >> +
> >> +	if (!smi240_sensor_data_is_valid(response))
> >> +		return -EIO;
> >> +
> >> +	*val = cpu_to_le16(FIELD_GET(SMI240_READ_DATA_MASK, response));  
> >So this is line sparse doesn't like which is reasonable given you are forcing an le16
> >value into a u16.
> >Minimal fix is just to change type of val to __le16 *
> >
> >I still find the endian handling in here mess and am not convinced the complexity is
> >strictly necessary or correct.
> >
> >I'd expect the requirements of reordering to be same in read and write directions
> >(unless device is really crazy), so why do we need a conversion to le16 here but not
> >one from le16 in the write?  
> 
> Hello Jonathan,
> 
> yes, you are right. The "cpu_to_le16" is not required at all.  SMI240 does not use the standard SPI protocol, on the other side the regmap is designed to use standard SPI protocol (by default) and may flip the register value dependent on "val_format_endian". 

It should still need to place the two bytes of that 16 bit value in the
correct order to send to hardware.  That may be handled via a 32 bit
word length on SPI though. 

>When the both work together, it may lead to confusing.  Let me make it clear.
> 
> In the SMI240, the register address is 8 bit and each register is 16 bit. We do not have any register value, which is bigger than 16 bit and need to be stored in multiple registers.  Therefore the device does not need endian. Neither big endian nor Little Endian.   To access the register, it is important to prepare the request frame according to the specification. 
> 
> A request is 32 bit
> 
> 	ID	ADR	W	CAP	*	WDATA	CRC
> 	31-30	29-22	21	20	19	18-3		2-0
> 
> ID: device id (if more than 1 device)
> ADR: reg address
> W: write/read
> CAP: capture mode on/off
> *: reserved
> WDATA: reg value to write
> CRC: check sum
> 
> To prepare the request properly, the bit order is here critical. We need to put each part in its bit position. The request is created as a local u32, with help of FIELD_PREP, we put the value of each part to its bit position. FIELD_PREP will take care of the cpu endian and always put the value to the correct bit position.  Before we send the request via SPI, a cpu endian to big endian conversion is required.

So there are two possibilities here.  Either the byte order is just reversed for the device
in which case fine as you describe or perhaps the SPI transfers should be using a 32 bit
word?  You'd do that by overriding the bits_per_word in the individual SPI transfers.


> Since the spi bus transfers data using big endian. When we get the response from spi, the response is big endian and need to be converted in cpu endian.  Any other manually endian conversion is not required. 

The SPI bus itself has no real concept of endian as such. It just sends bits in the order
it is fed them.  The device may require a particular ordering of course if we assume
it makes sense to break the transfers up into byte size chnunks.

See if setting the word size to 32 bits solves your issues without the need
for any endian conversions.

Jonathan


> 
> The SPI read in next version look like that
> 
> 1. Prepare request
> 2. Convert request from cpu endian to big endian and send via spi
> 3. Get response 
> 4. Convert response from big endian to cpu endian  and take the reg value from converted response
> As you mentioned, an additional cpu_to_le16 is not required. Since the response is already converted to cpu endian.
> 
> 
> static int smi240_regmap_spi_read(void *context, const void *reg_buf,
> 				  size_t reg_size, void *val_buf,
> 				  size_t val_size)
> {
> 	int ret;
> 	u32 request, response;
> 	u16 *val = val_buf;
> 	struct spi_device *spi = context;
> 	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> 	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
> 
> 	if (reg_size != 1 || val_size != 2)
> 		return -EINVAL;
> 
> 	request = FIELD_PREP(SMI240_WRITE_BUS_ID_MASK, SMI240_BUS_ID);
> 	request |= FIELD_PREP(SMI240_WRITE_CAP_BIT_MASK, iio_priv_data->capture);
> 	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
> 	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> 
> 	iio_priv_data->spi_buf = cpu_to_be32(request);
> 
> 	ret = spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> 	if (ret)
> 		return ret;
> 
> 	ret = spi_read(spi, &iio_priv_data->spi_buf, sizeof(response));
> 	if (ret)
> 		return ret;
> 
> 	response = be32_to_cpu(iio_priv_data->spi_buf);
> 
> 	if (!smi240_sensor_data_is_valid(response))
> 		return -EIO;
> 
> 	*val = FIELD_GET(SMI240_READ_DATA_MASK, response);
> 
> 	return 0;
> }
> 
> 
> The SPI write in next version look like that
> 
> 1. Prepare request
> 2. Convert request from cpu endian to big endian and send via spi
> 
> The critical part here is the reg value (WDATA).  As part of the request, the reg value shall be put to bit 18-3 WITHOUT TOUCHING IT. The reg value as a local u16, shall use the same cpu endian as the request. This is to keep the correct bit order for reg value and also for the request.  Nevertheless reg value is passed by regmap_write.  Regmap core may flip the reg value when val_format_endian != cpu_endian. If this happens, then regmap core has actually changed the reg value.  To prevent regmap to flip the reg value we use REGMAP_ENDIAN_NATIVE as val_format_endian. 
> 
> static int smi240_regmap_spi_write(void *context, const void *data,
> 				   size_t count)
> {
> 	u8 reg_addr;
> 	u16 reg_data;
> 	u32 request;
> 	const u8 *data_ptr = data;
> 	struct spi_device *spi = context;
> 	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> 	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
> 
> 	if (count < 2)
> 		return -EINVAL;
> 
> 	reg_addr = data_ptr[0];
> 	memcpy(&reg_data, &data_ptr[1], sizeof(reg_data));
> 
> 	request = FIELD_PREP(SMI240_WRITE_BUS_ID_MASK, SMI240_BUS_ID);
> 	request |= FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
> 	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
> 	request |= FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
> 	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> 
> 	iio_priv_data->spi_buf = cpu_to_be32(request);
> 
> 	return spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> }
> 
> static const struct regmap_config smi240_regmap_config = {
> 	.reg_bits = 8,
> 	.val_bits = 16,
> 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> };
> 
> 
> Fazit:
> 
> The bit order in request is critical to us.   FIELD_PREP will take care of the byte order (big / little endian) for us, and always put the value of each part to the correct bit position. We shall never manually change the cpu endian to each part. Just convert the whole request to/from big endian when sending / receiving via spi.
> 
> I hope this make the endian handling clear to you.
> 
> Best Regards
> 
> Jianping Shen
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 


