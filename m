Return-Path: <linux-iio+bounces-24110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91B9B579CE
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 14:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7D7204A81
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9FC302173;
	Mon, 15 Sep 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="rKdo/7Be";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="rKdo/7Be"
X-Original-To: linux-iio@vger.kernel.org
Received: from h2.cmg1.smtp.forpsi.com (h2.cmg1.smtp.forpsi.com [81.2.195.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5D2FC002
	for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.195.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937839; cv=none; b=LIW5culfNLKacg3KAtPyMR8t9TxWSFITH/5hHujjhN2AkBSMakhW8a4DG+lSiG1WCpj1/++qDiCESIK+DTNF98k50cBEQJMCvXX479DfY99aaPTJE/O4Yk9lXBxCBduykM6d6VHv62Sc7nNBsuZBLbXK0vG51qh1ES4IPrOut+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937839; c=relaxed/simple;
	bh=MEDrFpWmSGHHRrAFSFVS1lqyyQEe5NpDl8F+b6E4lF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSGYQjXJ1O4zN2N8CnWxth9oWsGOz1X5daMHU+chWE2p+mroBKC1GIkrNggPmKLfJKUBGHs6+6+AV2EOkbIvA8tv17woPt9i3oYW7rE8cE2gaCjaBtnQ0KEOZkOYd+QXXNc4JZfs+jXerLUfnvMm7J0RVORNDFVmYqCjLiaYgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=rKdo/7Be; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=rKdo/7Be; arc=none smtp.client-ip=81.2.195.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from [192.168.10.89] ([92.180.235.211])
	by cmgsmtp with ESMTPSA
	id y7vvuHC3ox9qoy7vvuDsh2; Mon, 15 Sep 2025 14:03:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1757937828; bh=JZBf29cEkCNIeqmRe0o9OeELZ8/vhDKp+Yw7a6r7lYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=rKdo/7BewRk0sawwsNTJq3lX674vUq62uk/X2CG76Ena4hrCOYsjjYhJ2DPo+kgQ4
	 kS5cZljJh7b9VPHAzR/POBVfnN1zq/tn7yDJ+yGUZ+XMICOLInMP6KZe89PUvM3bzg
	 fy1xjBxA7i5NuZYMMFGx842ynDV7fhnKUq9Iz06BpM87xsqo3NZ7mHQ8WkhpnO0I7X
	 E9f6P67ac9/5J3IgHVnXddlL3qxEqD5erdO+ynMju5LIltsS1KT7FOEZq/BQUG6Q0G
	 sx8Jsw+R5RGltRy1lS8yRAfixkJ49AmQ4772OfsRZwPu+EpZJDSSrHWoiB3bHrogIi
	 mssh1Pwg3zHJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1757937828; bh=JZBf29cEkCNIeqmRe0o9OeELZ8/vhDKp+Yw7a6r7lYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=rKdo/7BewRk0sawwsNTJq3lX674vUq62uk/X2CG76Ena4hrCOYsjjYhJ2DPo+kgQ4
	 kS5cZljJh7b9VPHAzR/POBVfnN1zq/tn7yDJ+yGUZ+XMICOLInMP6KZe89PUvM3bzg
	 fy1xjBxA7i5NuZYMMFGx842ynDV7fhnKUq9Iz06BpM87xsqo3NZ7mHQ8WkhpnO0I7X
	 E9f6P67ac9/5J3IgHVnXddlL3qxEqD5erdO+ynMju5LIltsS1KT7FOEZq/BQUG6Q0G
	 sx8Jsw+R5RGltRy1lS8yRAfixkJ49AmQ4772OfsRZwPu+EpZJDSSrHWoiB3bHrogIi
	 mssh1Pwg3zHJQ==
Message-ID: <b709ac66-d0f2-4eb9-a66b-be557b4fe2be@skyrain.eu>
Date: Mon, 15 Sep 2025 14:03:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: iio: accel: fix ADX355 startup race condition
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Puranjay Mohan <puranjay@kernel.org>,
 Kessler Markus <markus.kessler@hilti.com>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
 <20250910193049.145aa79e@jic23-huawei>
 <6ee57754-4fa0-4694-b997-5f4c627b567b@skyrain.eu>
 <20250912151259.00006fd5@huawei.com>
Content-Language: en-US
From: Andrej Valek <andrej.v@skyrain.eu>
In-Reply-To: <20250912151259.00006fd5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfO0cus+o9U3qJ7CMwdIYUyCxvUKO9xSpQr1pXrfdLYxeqg4wEUuupESXrTVfKn7jfAlSeV1xurT3Kg6g6SfALlOCdzZlZul93ciUVa3Ok+t2iE00c/ud
 5qXXRAJ0PWkY3532XeVBFJ4c/RKaD2UU+aUFRkkbm1Y+yN62VimWAeqI9HdHBbGgeQwlsaC/ppe/w2dCCT6HUZuknCbDzlvnRsgqH/P5aw85WmEKl6rMZiIr
 Y+DWsbSbRu1dhZESiu2yNCVrIuua7K6PDKiGbypcpzBvj8nASPFiZy+gS0vBUW6CRCnVZGqN9o0LQZ5yO5znp+in37wqvH9bcMRw8MFzix9Xqdn4w+tFVM5h
 m9vaLcByY++sDdl0X/4gG8KL8fW7mkU5PJIiuq5lLXY0HCcDjB0=

Hi Jonathan,

I submitted the version 2 with applied your suggestions.

On 12.09.2025 16:12, Jonathan Cameron wrote:
> On Thu, 11 Sep 2025 11:33:49 +0200
> Andrej Valek <andrej.v@skyrain.eu> wrote:
>
>> Hi Jonathan,
>>
>> First, I would like to thanks for your feedback.
>>
>> On 10.09.2025 20:30, Jonathan Cameron wrote:
>>> On Tue,  9 Sep 2025 10:55:28 +0200
>>> Andrej Valek <andrej.v@skyrain.eu> wrote:
>>>   
>>>> From: Valek Andrej <andrej.v@skyrain.eu>
>>> Hi Valek,
>>>
>>> Thanks for the patch. Small thing on patch title, don't include drivers.
>>> It's a pain but you need to look at other patches to a given subsystem
>>> to find out the preferred style.
>> Valek is my surname 🙂.
> Oops. Sorry!
>
> Hi Andrej,
>
>>>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
>>>> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
>>>> ---
>>>>    drivers/iio/accel/adxl355_core.c | 48 ++++++++++++++++++++++++++++----
>>>>    1 file changed, 43 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
>>>> index 2e00fd51b4d51..5386cd4766def 100644
>>>> --- a/drivers/iio/accel/adxl355_core.c
>>>> +++ b/drivers/iio/accel/adxl355_core.c
>>>> @@ -56,6 +56,8 @@
>>>>    #define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
>>>>    #define ADXL355_SELF_TEST_REG		0x2E
>>>>    #define ADXL355_RESET_REG		0x2F
>>>> +#define ADXL355_BASE_ADDR_SHADOW_REG	0x50
>>>> +#define ADXL355_SHADOW_REG_COUNT	5
>>>>    
>>>>    #define ADXL355_DEVID_AD_VAL		0xAD
>>>>    #define ADXL355_DEVID_MST_VAL		0x1D
>>>> @@ -294,6 +296,9 @@ static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
>>>>    static int adxl355_setup(struct adxl355_data *data)
>>>>    {
>>>>    	unsigned int regval;
>>>> +	u8 shadow_regs[ADXL355_SHADOW_REG_COUNT];
>>> Needs to be a DMA safe buffer.  We can't assume that regmap will always
>>> bounce the data through one before passing it to the SPI controllers
>>> that do sometimes require DMA safe buffers.    Add a buffer to end of
>>> struct adxl355_data where you can take advantage of the forcing of appropriate
>>> padding that is already going on there.
>> I see, but I don't like extending the adxl355_data just for one time
>> usage. The suggested approach is more similar to what is done with the
>> ID checking.
>> | if (regval != ADXL355_DEVID_MST_VAL) {
>> |  dev_err(data->dev, "Invalid MEMS ID 0x%02x\n", regval);
>> |  return -ENODEV;
>> | }
> That's a single read.  Regmap always bounces those so a local variable should
> be fine. Not so for a bulk read (or at least no one guarantees it)
>
> https://events19.linuxfoundation.org/wp-content/uploads/2017/12/20181023-Wolfram-Sang-ELCE18-safe_dma_buffers.pdf
> Slide 11 (in general this slide deck is a good introduction to the fun of DMA safety).
>
> The path for a single read goes through:
> https://elixir.bootlin.com/linux/v6.16.7/source/drivers/base/regmap/regmap.c#L2779
> _regmap_bus_read() which uses map->work_buf which is DMA safe.
regmap_bulk_read is using the same _regmap_read 
https://elixir.bootlin.com/linux/v6.16.7/source/drivers/base/regmap/regmap.c#L3137 
so it should be safe, too I guess.
>
> Jonathan
>
>
Andy

