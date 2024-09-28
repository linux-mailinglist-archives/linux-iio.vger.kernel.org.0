Return-Path: <linux-iio+bounces-9815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE52D988FAF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D820281F89
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D719470;
	Sat, 28 Sep 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug9Lq6qL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD1171C2;
	Sat, 28 Sep 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727534183; cv=none; b=g8urXxzSAtabkxW17WOqAo7N/m875goD/fK2INDy4+K7i6iX1Bejdpx1R8P+VR0nie+oS8Wj5uNeaETVLx0lnuqGKVERbRWRE3ESdtBlZ1zaE4/URb15gA6t0CO+wLhgnMNXNZSNlYZDLex6JucYFCb1el3E5Ae4E4ZlLhaLDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727534183; c=relaxed/simple;
	bh=nRRUMseygmxYxhEF2/iockbCVkHQbD6xwG9F33DE7zs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fttDeX4qaoFa20LmS85RpRIZrtouGWYcHNaCJ8OKCmQX9SMSANXTEBydn1WenYER0T9LMS6jGd4dKUIP5qlvoEbpgxxBx+RB6H/h0S/D1Gf3G0CRiFIOiD6pTldH1ZMAfQg9HKAUuGf0QNRWmvyO+OYjBqr1xbhl+cdXNDXLMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug9Lq6qL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FDEC4CEC3;
	Sat, 28 Sep 2024 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727534183;
	bh=nRRUMseygmxYxhEF2/iockbCVkHQbD6xwG9F33DE7zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ug9Lq6qLGoBOTo3GfgOQ0/ASNDqkRfywpHGHJNm/DCdtWvpdwxFUKPwHf3+tuD1nP
	 ox5EdqvaQZ/ktBax3yv4wA0Qx+x3jck4u3TI1kcgeYRE4ucrT03yYyfiZPyeZuS4Ap
	 VxMGFW30b/NLCeH3+3Yq3vZuARkaLssmG4H7Ob+XxFrFd670GH7/MRlKuWvfxrSJYh
	 9i+PZDiU+GgbJHa+TJxOa9Dq1x/5gGwWeLdhy+AZm18oaHXpZI4lld3GgycMHpZirq
	 gmR21yh3qY7drsCi0iIuNuvBdu1QmV3ZmTdJmR3W3+S1T87/j3WGmyeIIIRsdRk7st
	 duSH7rhpYnzvw==
Date: Sat, 28 Sep 2024 15:36:14 +0100
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
Subject: Re: [PATCH v7 2/2] iio: imu: smi240: add driver
Message-ID: <20240928153614.758ea7e8@jic23-huawei>
In-Reply-To: <AM8PR10MB4721D14E9A13F1DE04FA8B68CD612@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
	<20240913100011.4618-3-Jianping.Shen@de.bosch.com>
	<20240914173229.57548005@jic23-huawei>
	<AM8PR10MB4721196E13BCDAD7ABAD8E85CD602@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20240917121301.3864a3f7@jic23-huawei>
	<AM8PR10MB4721D14E9A13F1DE04FA8B68CD612@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Sep 2024 13:13:57 +0000
"Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com> wrote:

> >> >Hi Shen,
> >> >
> >> >I suspect I led you astray.  regmap core seems unlikely to feed us
> >> >little endian buffers on writes (they should be CPU endian I think)
> >> >so there should be memcpy() for that not a get_unaligned_le16()
> >> >  
> >> >> +
> >> >> +static int smi240_regmap_spi_write(void *context, const void *data,
> >> >> +				   size_t count)
> >> >> +{
> >> >> +	u8 reg_addr;
> >> >> +	u16 reg_data;
> >> >> +	u32 request;
> >> >> +	struct spi_device *spi = context;
> >> >> +	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> >> >> +	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
> >> >> +
> >> >> +	if (count < 2)
> >> >> +		return -EINVAL;
> >> >> +
> >> >> +	reg_addr = ((u8 *)data)[0];
> >> >> +	reg_data = get_unaligned_le16(&((u8 *)data)[1]);  
> >> >
> >> >Why is the regmap core giving us an le16?
> >> >I probably sent you wrong way with this earlier :( memcpy probably
> >> >the correct choice here.  
> >>
> >> Yes, you are right. We shall use memcpy to keep the be CPU endian.  Just using  
> >memcpy may be not enough.  
> >>
> >> Shall we also change regmap_config.val_format_endian  from  
> >REGMAP_ENDIAN_LITTLE to  REGMAP_ENDIAN_NATIVE ?  
> >>
> >> This is to make sure that regmap_write passes the reg-value to  
> >smi240_regmap_spi_write without changing the CPU endian.  
> >>  
> >Hmm. I'd missed that control.  If the register data needs to be little endian then it is
> >correct to leave that set as REGMAP_ENDIAN_LITTLE as then the regmap core will
> >do the endian swap for you on Big endian systems.
> >
> >If I follow that bit of regmap correctly it will then have the data in the right order so
> >the above still wants to just be a memcpy.
> >
> >As it stands, on a Big endian host, regmap will use the val_format_endian to decide
> >to flip the bytes.  This code then flips them back again and the value written is big
> >endian which is not what you intend!
> >
> >Easy way to check this will be to set it, on your little endian host, to
> >REGMAP_BIG_ENDIAN and see what you get in the value.
> >Then consider if you'd had get_unaligned_be16 then it would end up as little endian
> >again.  This should mirror the current situation if this driver runs on a big endian host.
> >
> >Hope that confusing set of comments helps!
> >
> >Jonathan
> >  
> Hi  Jonathan,
> 
> we check the regmap behavior with the following tests
> 
> 1. host : little endian   val_format_endian ==REGMAP_BIG_ENDIAN     regmap_write(data->regmap, REG_ADDR, 0x12AB)  
>     then  in smi240_regmap_spi_write(void *context, const void *data, size_t count)    we have data[0]== REG_ADDR, data[1]==0xAB , data[2]==0x12 
> 
> 2. host : little endian   val_format_endian ==REGMAP_BIG_LITTLE     regmap_write(data->regmap, REG_ADDR, 0x12AB)  
>     then  in smi240_regmap_spi_write(void *context, const void *data, size_t count)    we have data[0]== REG_ADDR, data[1]==0x12 , data[2]==0xAB
> 
> 3. host : little endian   val_format_endian ==REGMAP_BIG_NATIVE     regmap_write(data->regmap, REG_ADDR, 0x12AB)  
>     then  in smi240_regmap_spi_write(void *context, const void *data, size_t count)    we have data[0]== REG_ADDR, data[1]==0x12 , data[2]==0xAB
> 
> when regmap_write passes the reg-value to the underlaying spi-write function, it flips the bytes if  val_format_endian != cpu_endian
> 
> Since we prepare the request and the reg-value (as part of the request) with cpu_endian, we need to make sure that the cpu_endian keeps untouched until we pass the whole request to spi buffer using  "iio_priv_data->spi_buf = cpu_to_be32(request)"
> Therefore we need to remove the change of cpu_endian during the request preparation. 
> 
> 1. Instead get_unaligned_le16 now we use memcpy to take the reg-value without changing the cpu_endian.
> 2, we use REGMAP_BIG_NATIVE on val_format_endian to make sure when regmap_write passes the reg-value to the underlaying spi-write function the cpu_endian kept untouched.
> 
> This makes our driver be able to work properly on both little endian and big endian host. We tested the new changes on little endian host it works properly. Big endian host case is not tested yet, since today the big endian processors are almost dead.
> 
> The next version will looks like that.
> 
> static const struct regmap_config smi240_regmap_config = {
> 	.reg_bits = 8,
> 	.val_bits = 16,
> 	.val_format_endian = REGMAP_ENDIAN_NATIVE,

You say REGMAP_BIG_NATIVE above by which I think you mean REGMAP_ENDIAN_BIG
(which seems correct to me) but then set REGMAP_ENDIAN_NATIVE here.

Other than that this looks correct and thanks for working through
the test cases above.

> 
> };
> 
> static int smi240_regmap_spi_write(void *context, const void *data,size_t count)
> {
> 	u8 reg_addr;
> 	u16 reg_data;
> 	u32 request;
> 	struct spi_device *spi = context;
> 	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> 	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
> 	if (count < 2)
> 		return -EINVAL;
> 
> 	reg_addr = ((u8 *)data)[0];
> 	memcpy(&reg_data, &((u8 *)data)[1], 2);
> 
> 	request = FIELD_PREP(SMI240_BUS_ID_MASK, SMI240_BUS_ID);
> 	request |= FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
> 	request |= FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
> 	request |= FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
> 	request |= smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> 
> 	iio_priv_data->spi_buf = cpu_to_be32(request);
> 	return spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> }
> 
> Is the new version now correct ?
> 
> Best regards
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


