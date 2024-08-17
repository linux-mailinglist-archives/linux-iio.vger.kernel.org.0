Return-Path: <linux-iio+bounces-8537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E859557F5
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0960EB21E18
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7981514C8;
	Sat, 17 Aug 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="VHRad4Xd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7AD14F9FF;
	Sat, 17 Aug 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723899532; cv=none; b=oZMk7H2pDRSH9tUVaEju9OufQvQgQgZ532rS+WQy3ManmmIUowHIa9uAbvPsxwA6keNbDj47TOQmPKsyLyFAnBZH5Sic68xOSAehgLkO0PEqeJpQg0TczuWTpSuhg6cjT5n7U/xgJj0R56CgB8mNa/1spcoyAJDvwmC1tN4N7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723899532; c=relaxed/simple;
	bh=mqTy7GWX7rzXkBMSQRJPizJCFX4QZSZlTrvfnOmKcTU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jBQsUmUY8fP3QDlCkUrra1hbb5ekdIzWqGX0MQd3N34b7thFBx3J7bD0IZsOsbKNOqBY5pURfOPU63/J0gppIVE5lnMrau0Yas5w1z5pKxWkiOIvfphhEZaSeoWTawumXsuca3Gq6L60ydM5IfzF6wurucR8seBHdN8TPFjHZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=VHRad4Xd; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id 9DEC5E44F4;
	Sat, 17 Aug 2024 12:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1723899522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+B5RmOjlkNNPTiGhgAcbMh56LNwdC0DpmSCaHxQDzw8=;
	b=VHRad4Xdvz+yHFLVcT5FZJ11lwcy0sLHyljr3c0D9P4cXKs+b+jz76P3oqi+NcT1+nyt42
	fU0lwmJpH2dbN9w3KlZZHn19nBafREAUHyDY+w5Uqd5Cq28nflfSh/DgDpts65h5i6HKaW
	aWzwn1e+NUoVPKuD4SH6Bv2fz+B/RDVOWWOyZPUmGXJ0X0CMyKcIuvexgcT3FTxwNv+DG1
	ayPPXLvG8Fn38OtTBK/VwVpTAVb1vUi/NEXgm8RH9eUGvJl6aAedVwNUpiLPVJI3YlFG5l
	Cy5NVUd3OSvPFj9tChLzc626LNYGQXglDyDGxGUohIEZC6nVDRyJ9LC8ChzAug==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 Aug 2024 14:58:42 +0200
From: barnabas.czeman@mainlining.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@mainlining.org
Subject: Re: [PATCH v3 2/4] iio: magnetometer: ak8975: Fix reading for ak099xx
 sensors
In-Reply-To: <20240817132641.2902418e@jic23-huawei>
References: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
 <20240809-ak09918-v3-2-6b036db4d5ec@mainlining.org>
 <20240817132641.2902418e@jic23-huawei>
Message-ID: <a7da0c7296188542c14a54985995a8fa@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-17 14:26, Jonathan Cameron wrote:
> On Fri, 09 Aug 2024 22:25:40 +0200
> Barnabás Czémán <barnabas.czeman@mainlining.org> wrote:
> 
>> Move ST2 reading with overflow handling after measurement data
>> reading.
>> ST2 register read have to be read after read measurment data,
>> because it means end of the reading and realease the lock on the data.
>> Remove ST2 read skip on interrupt based waiting because ST2 required 
>> to
>> be read out at and of the axis read.
>> 
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> This still needs a fixes tag to tell us when the bug was first
> introduced into the driver so that we know how far to back port it.
I have got some test results from a device with ak09916 and that was 
working
without the fix so it seems only ak09918 is strict about ST2.
In theory all ak099xx should work like this so:
Fixes: 57e73a423b1e (iio: ak8975: add ak09911 and ak09912 support)
> 
> One other comment inline.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/magnetometer/ak8975.c | 33 
>> ++++++++++++++++-----------------
>>  1 file changed, 16 insertions(+), 17 deletions(-)
>> 
>> diff --git a/drivers/iio/magnetometer/ak8975.c 
>> b/drivers/iio/magnetometer/ak8975.c
>> index 6357666edd34..f8355170f529 100644
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
>> -	return 0;
>> +	return !data->def->ctrl_regs[ST1_DRDY];
>>  }
>> 
>>  /* Retrieve raw flux value for one of the x, y, or z axis.  */
>> @@ -734,6 +719,20 @@ static int ak8975_read_axis(struct iio_dev 
>> *indio_dev, int index, int *val)
>>  	if (ret < 0)
>>  		goto exit;
>> 
>> +	/* Read out ST2 for release lock */
>> +	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
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
>>  	mutex_unlock(&data->lock);
>> 
>>  	pm_runtime_mark_last_busy(&data->client->dev);
>> @@ -746,7 +745,7 @@ static int ak8975_read_axis(struct iio_dev 
>> *indio_dev, int index, int *val)
>> 
>>  exit:
>>  	mutex_unlock(&data->lock);
>> -	dev_err(&client->dev, "Error in reading axis\n");
>> +	dev_err(&client->dev, "Error in reading axis %d\n", ret);
> 
> In most of the paths above there is already a detailed print. I'd not 
> bother
> adding the return value to this one.  It just adds noise to the patch.
> 
>>  	return ret;
>>  }
>> 
>> 

