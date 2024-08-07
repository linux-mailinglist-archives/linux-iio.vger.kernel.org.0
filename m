Return-Path: <linux-iio+bounces-8309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE56A94AC82
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997571F22508
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2024 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1CF84A46;
	Wed,  7 Aug 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="WVUZ1oEw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D233CD2;
	Wed,  7 Aug 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043756; cv=none; b=NdB2wS7pHeYR4KWrTQFy/Vbt63xnxNiMe8UgvclG9BsBPBPGgnDVkL4ga3TT7JrtTqhBIdlwv4/Ac46bnucI4tuvgsTcPjCbb/4a9RMN8FpS+aHsbrDR8syzCRTzvczYhaj/qVUtqU9jYGi6Bzkorop9BVT58H3zPz/p2wkueBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043756; c=relaxed/simple;
	bh=fGBCywsutW3NjgrC9Ve6Qzx0bwXdOQ99qyoNgGNCcTI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PYdv89qTPQZC0+vj0IAJ8A1BB5o/FekoKhGK628esuzzmB954v+gxklRBarQQaSRdB+WLxx23WBMhBSNIAo0bksg+l00fh0XBpRi4dXgbrBo0Qx2HBw58PfBThGfoGUas+bA/Q90jxZFD8P2Vx8bnpAQDO0N3y1qqBjk2zrrNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=WVUZ1oEw; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id 5A57CE450D;
	Wed,  7 Aug 2024 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1723043746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dK78BrKy6mLK/z1CVSmRJ+MbobVrp0HlEUG5n8TM4L4=;
	b=WVUZ1oEwijeOty0DYuoRaSliKdYkd12+mmrEwx0GkRWgDPdrIqcDri69unLrul5a9SauP4
	FOXH++okSgfma1ufH5ztSLh4iMFEqHR2n19e+sgCds4h4RbAAJBK2ptRTP79yyJhTF5rRC
	qRB71Roy2W7psJBzOhbAGpXSERxAUSkzVrjxIHXU573H5ANmwWIieyhwhBs6DJgEvJkAYY
	v9r/ct7LvsqP5zfek5KlNBZ6mQ9UT74EGoKR0kn2bKHdocXibQx2XxE9Frbi7cyrOPwpQE
	lFaMGTZJM2ARFPQLMKIaWaJUECq9nrVVckihnw2nwR0vmPUSW4xw3vkqRwAEHQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Aug 2024 17:15:46 +0200
From: barnabas.czeman@mainlining.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@mainlining.org
Subject: Re: [PATCH v2 1/3] iio: magnetometer: ak8975: Fix reading for ak099xx
 sensors
In-Reply-To: <20240806171925.7c512c63@jic23-huawei>
References: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
 <20240806-ak09918-v2-1-c300da66c198@mainlining.org>
 <20240806171925.7c512c63@jic23-huawei>
Message-ID: <96c2bcfbebc9e6d97d97f32aec9249db@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-06 18:19, Jonathan Cameron wrote:
> On Tue, 06 Aug 2024 08:10:18 +0200
> Barnabás Czémán <barnabas.czeman@mainlining.org> wrote:
> 
> Hi Barnabás,
> 
> Welcome to IIO.
> 
>> ST2 register read should be placed after read measurment data,
>> because it will get correct values after it.
> 
> What is the user visible result of this? Do we detect errors when none
> are there?  Do we have a datasheet reference for the status being
> update on the read command, not after the trigger?
>> 
> Needs a Fixes tag to let us know how far to backport the fix.
> 
> A few comments inline.
> 
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  drivers/iio/magnetometer/ak8975.c | 31 
>> +++++++++++++++----------------
>>  1 file changed, 15 insertions(+), 16 deletions(-)
>> 
>> diff --git a/drivers/iio/magnetometer/ak8975.c 
>> b/drivers/iio/magnetometer/ak8975.c
>> index dd466c5fa621..925d76062b3e 100644
>> --- a/drivers/iio/magnetometer/ak8975.c
>> +++ b/drivers/iio/magnetometer/ak8975.c
>> @@ -692,22 +692,7 @@ static int ak8975_start_read_axis(struct 
>> ak8975_data *data,
>>  	if (ret < 0)
>>  		return ret;
>> 
>> -	/* This will be executed only for non-interrupt based waiting case 
>> */
>> -	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
>> -		ret = i2c_smbus_read_byte_data(client,
>> -					       data->def->ctrl_regs[ST2]);
>> -		if (ret < 0) {
>> -			dev_err(&client->dev, "Error in reading ST2\n");
>> -			return ret;
>> -		}
>> -		if (ret & (data->def->ctrl_masks[ST2_DERR] |
>> -			   data->def->ctrl_masks[ST2_HOFL])) {
>> -			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
>> -			return -EINVAL;
>> -		}
>> -	}
>> -
> This completely removes the check from the _fill_buffer() path
> 
>> -	return 0;
>> +	return !(ret & data->def->ctrl_masks[ST1_DRDY]);
> returning a positive value here is unusual enough you should add a 
> comment for
> the function + use that return value.
> 
>>  }
>> 
>>  /* Retrieve raw flux value for one of the x, y, or z axis.  */
>> @@ -731,6 +716,20 @@ static int ak8975_read_axis(struct iio_dev 
>> *indio_dev, int index, int *val)
>>  	ret = i2c_smbus_read_i2c_block_data_or_emulated(
>>  			client, def->data_regs[index],
>>  			sizeof(rval), (u8*)&rval);
> No longer gated on ret & data->def->ctrl_masks[ST1_DRDY] which seems 
> unintentional.
It is checked exactly before the measurement data read, it is the return 
value of ak8975_start_read_axis.
The read section should be ST1 -> measurement -> ST2, exactly the same 
can be found in the datasheets.
> 
> Still need a check on ret here.
> 
>> +	ret = i2c_smbus_read_byte_data(client,
>> +				       data->def->ctrl_regs[ST2]);
>> +	if (ret < 0) {
>> +		dev_err(&client->dev, "Error in reading ST2\n");
>> +		goto exit;
>> +	}
>> +
>> +	if (ret & (data->def->ctrl_masks[ST2_DERR] |
>> +		   data->def->ctrl_masks[ST2_HOFL])) {
>> +		dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
>> +		ret = -EINVAL;
>> +		goto exit;
>> +	}
>> +
>>  	if (ret < 0)
>>  		goto exit;
> 
> And this one ends up redundant I think which suggests to me the
> code is inserted a few lines early.
> 
>> 
>> 

