Return-Path: <linux-iio+bounces-24771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ABDBBD948
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 12:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4733B9E63
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B1821FF44;
	Mon,  6 Oct 2025 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="q2QPr9zv";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="q2QPr9zv"
X-Original-To: linux-iio@vger.kernel.org
Received: from h2.cmg1.smtp.forpsi.com (h2.cmg1.smtp.forpsi.com [81.2.195.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3A21CA00
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.195.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745034; cv=none; b=n57nxB9S+hvuL4cO4AONLKywOz50FKLad+q+ZrKT3UK2LhxcR9SQrFVO0NBKXpbZcevo2N671ztdkSoLfxFvirW0trTsv/jaCwnETqA2BfRsPAFLJklh03f1K9wnedLjwUlpXjKaBEdvAFVrV0eq6UK6YuOrU3CNJBAgVbajY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745034; c=relaxed/simple;
	bh=D+h+GfPBBTeXmE4aj8R7jjAc5w+AO/ix3gaSoNvTwXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7IUh7L4WPZIAJMFz45IK3/wsRv+Az1Qy44FW9PftdrHj4Az54X7WJJ4OBoyEyJjEFJWa3pnZrXy5gBwqVlGUOoQx/2M8ZnC7CUEgb4mnH+8SgaWExohd/DG63e1jbSPQCflhc5nxu5XOML6NKyaXIhqdEc0EwNWOMp3KNslyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=q2QPr9zv; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=q2QPr9zv; arc=none smtp.client-ip=81.2.195.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from [192.168.10.89] ([92.180.235.211])
	by cmgsmtp with ESMTPSA
	id 5i4EvhBNwx9qo5i4EvCqiJ; Mon, 06 Oct 2025 12:03:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1759745022; bh=A2JZctlLRHMkF9I76HZLZPOnZ+YBqrBrIomsoeA5sms=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=q2QPr9zvisk4bt2YNLUeC72QpImy01U4sRono8rt/p8l6hSnV/2j35JJY7VX04CP1
	 IBqXa3PVT+H0scDesXQ3ASi4VCp+6LGlgurOzQovk/LSJWiJiw5N0z8AsQh3dVskQ5
	 01lg/0cLyAIYlUwxuhTgsdBrmCF/aQftIfbns6fU0YWuBlsdExCIUjuJ/9gskzIsWG
	 +T6tBxMOYmb4gsGmk6KUfb/TzomU4afFZaJy/1N6JMGLovKnbB14VHOLJ4zrYisTbB
	 9PH0J/Apn661jbs0Qwq6odcsrjUfV+vASyrFRe12N2VjlggYwlIcoXG9Q54gEV8IWo
	 0DwGXIVIlKBtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1759745022; bh=A2JZctlLRHMkF9I76HZLZPOnZ+YBqrBrIomsoeA5sms=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=q2QPr9zvisk4bt2YNLUeC72QpImy01U4sRono8rt/p8l6hSnV/2j35JJY7VX04CP1
	 IBqXa3PVT+H0scDesXQ3ASi4VCp+6LGlgurOzQovk/LSJWiJiw5N0z8AsQh3dVskQ5
	 01lg/0cLyAIYlUwxuhTgsdBrmCF/aQftIfbns6fU0YWuBlsdExCIUjuJ/9gskzIsWG
	 +T6tBxMOYmb4gsGmk6KUfb/TzomU4afFZaJy/1N6JMGLovKnbB14VHOLJ4zrYisTbB
	 9PH0J/Apn661jbs0Qwq6odcsrjUfV+vASyrFRe12N2VjlggYwlIcoXG9Q54gEV8IWo
	 0DwGXIVIlKBtg==
Message-ID: <d18192cf-6a6d-499a-baa9-6ad4823ec149@skyrain.eu>
Date: Mon, 6 Oct 2025 12:03:42 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: accel: fix ADXL355 startup race condition
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Puranjay Mohan <puranjay@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 David Lechner <dlechner@baylibre.com>,
 Kessler Markus <markus.kessler@hilti.com>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
 <20251001143702.587073-1-andrej.v@skyrain.eu>
 <20251004164732.3d70091c@jic23-huawei>
Content-Language: en-US
From: Andrej Valek <andrej.v@skyrain.eu>
In-Reply-To: <20251004164732.3d70091c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKQzblwYuWCqFm+xRc3T/jqFVi0orXAVZ4wt9B62ABPuaVTJLIrXJDD//k28dFi0PiZzarAzDy7teJi5ky1BXTa5UyIZkwdsOdDsy/ACwaREEsGzeL/g
 oy5R2xQGtDZFaf+lFvhLo+nsWPn+8nrHhVLpjmMqxCkMjtjy1lmxMEGcjpuQQKGJRklx1tvnnkn9uvitZHuDs+5E+MZrkiHiOyKaXXeohJo6/MLQdNJBRFZ1
 NMRo97Mk+KcY/hrQ3cqfYvImP8aP+PqJ9vnGk9K5HbamlpZ5SvcykHOlboLqXEbvzDwa9ywq6bUmvC5Yv0mYQ5xqHW2KdLKnXCTX0dU8I8nptrhvABzmabCE
 UoDMbczfUEtQ4i4/ala4GeevriZP5gxoT2d4hkij2qbE6n4PVQvKtjbc+B4S6ExG9qi00cYVvikJnnjhn1KFFKdpwo9nkQ==

Hello Jonathan,

sorry, I didn't want to make something misleading.

On 04.10.2025 17:47, Jonathan Cameron wrote:
> On Wed,  1 Oct 2025 16:37:02 +0200
> Andrej Valek <andrej.v@skyrain.eu> wrote:
>
>> From: Valek Andrej <andrej.v@skyrain.eu>
>>
>> There is an race-condition where device is not full working after SW reset.
>> Therefore it's necessary to wait some time after reset and verify shadow
>> registers values by reading and comparing the values before/after reset.
>> This mechanism is described in datasheet at least from revision D.
>>
>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
>> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
> Hi Valek,
>
> One process thing is to not reply to an existing thread with a new version.
> Whilst it seems nice and tidy when we only have one patch in a series, it can
> get very complex to read if we have deep threads with many versions being commented
> on at the same time.  Also tends to end up way off the top of the screen in
> threaded email clients.  Hence this is about the last patch I'm replying to today
> just because for once I've more or less caught up with all my IIO related emails.
>
> So just send a fresh series that isn't in reply to anything.
>
> Mostly good, but can you reply with a fixes tag and are you fine with me
> adding the error check I call out below?
I tried to follow the thread and always use the first message as 
reference, but it failed somehow. Anyhow I send a new patch without 
following the previous stuff as requested: 
https://lore.kernel.org/linux-iio/20251006095812.102230-1-andrej.v@skyrain.eu/T/#u
>
>> ---
>>   drivers/iio/accel/adxl355_core.c | 41 ++++++++++++++++++++++++++++----
>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
>> index 2e00fd51b4d5..782085d74ab8 100644
>> --- a/drivers/iio/accel/adxl355_core.c
>> +++ b/drivers/iio/accel/adxl355_core.c
>> @@ -56,6 +56,8 @@
>>   #define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
>>   #define ADXL355_SELF_TEST_REG		0x2E
>>   #define ADXL355_RESET_REG		0x2F
>> +#define ADXL355_BASE_ADDR_SHADOW_REG	0x50
>> +#define ADXL355_SHADOW_REG_COUNT	5
>>   
>>   #define ADXL355_DEVID_AD_VAL		0xAD
>>   #define ADXL355_DEVID_MST_VAL		0x1D
>> @@ -294,6 +296,8 @@ static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
>>   static int adxl355_setup(struct adxl355_data *data)
>>   {
>>   	unsigned int regval;
>> +	u8 *shadow_regs __free(kfree) = kzalloc(ADXL355_SHADOW_REG_COUNT, GFP_KERNEL);
>> +	int retries = 5; /* the number is chosen based on empirical reasons */
>>   	int ret;
> 	if (!shadow_regs)
> 		return -ENOMEM;
>
> Whilst very unlikely to happen we still need to handle memory allocation failure.
Sure, added.
>>   
>>   	ret = regmap_read(data->regmap, ADXL355_DEVID_AD_REG, &regval);
>> @@ -321,14 +325,41 @@ static int adxl355_setup(struct adxl355_data *data)
>>   	if (regval != ADXL355_PARTID_VAL)
>>   		dev_warn(data->dev, "Invalid DEV ID 0x%02x\n", regval);
>>   
>> -	/*
>> -	 * Perform a software reset to make sure the device is in a consistent
>> -	 * state after start-up.
>> -	 */
>> -	ret = regmap_write(data->regmap, ADXL355_RESET_REG, ADXL355_RESET_CODE);
>> +	/* Read shadow registers to be compared after reset */
>> +	ret = regmap_bulk_read(data->regmap,
>> +			       ADXL355_BASE_ADDR_SHADOW_REG,
>> +			       shadow_regs, ADXL355_SHADOW_REG_COUNT);
>>   	if (ret)
>>   		return ret;
>>   
>> +	do {
>> +		if (--retries == 0) {
>> +			dev_err(data->dev, "Shadow registers mismatch\n");
>> +			return -EIO;
>> +		}
>> +
>> +		/*
>> +		 * Perform a software reset to make sure the device is in a consistent
>> +		 * state after start-up.
>> +		 */
>> +		ret = regmap_write(data->regmap, ADXL355_RESET_REG,
>> +				   ADXL355_RESET_CODE);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Wait at least 5ms after software reset */
>> +		usleep_range(5000, 10000);
>> +
>> +		/* Read shadow registers for comparison */
>> +		ret = regmap_bulk_read(data->regmap,
>> +				       ADXL355_BASE_ADDR_SHADOW_REG,
>> +				       data->buffer.buf,
>> +				       ADXL355_SHADOW_REG_COUNT);
>> +		if (ret)
>> +			return ret;
>> +	} while (memcmp(shadow_regs, data->buffer.buf,
>> +			ADXL355_SHADOW_REG_COUNT));
>> +
>>   	ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
>>   				 ADXL355_POWER_CTL_DRDY_MSK,
>>   				 FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK, 1));
>
Now should be everything fixed, hopefully... .

BR,
Andy

