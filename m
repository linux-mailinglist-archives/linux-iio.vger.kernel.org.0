Return-Path: <linux-iio+bounces-24549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C98BA81A6
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 08:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08C73C12BA
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 06:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E1525179A;
	Mon, 29 Sep 2025 06:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="HCor7W72";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="HCor7W72"
X-Original-To: linux-iio@vger.kernel.org
Received: from h2.cmg2.smtp.forpsi.com (h2.cmg2.smtp.forpsi.com [81.2.195.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18775246BB0
	for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.195.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759127075; cv=none; b=HAXYj8QXGUnlLeCI4BnFX0Dux1h5YNhkDunvsAkMhp3DkiG2c5e6h5kKngTCO7qAXCLMXfELqhCZvpeKHsVicJpO3C89rknTYIjLzB3GCbdityDq4aE/fx8zPOWoW3F9kY2KbTlBU0OjeQ/tLw78v+oNzqdY1LfwUrqAJVEc7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759127075; c=relaxed/simple;
	bh=re9IuesG0VWngK5bV6p+AyG4V3zzR/GbAZkIM5Ld1aY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iHexVJ+qC8XsVHZ1kduvJoawzV/77yr5zV6uPyTtcbrXpxsD+EwWgb8ayByfHqhCLDJACu0U1VlA5AOFxGDc/LTF9lzHr1J0TKDG14NdZbUrwS35xCKURcRcIP+R2FCkb5F4Y+UcDbFdwjDxGtHMw11V4YQITFUlXD7ghj1vgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=HCor7W72; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=HCor7W72; arc=none smtp.client-ip=81.2.195.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from [172.25.231.43] ([85.248.43.180])
	by cmgsmtp with ESMTPSA
	id 3761vs1YDC4IT3761vpKyQ; Mon, 29 Sep 2025 08:10:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1759126250; bh=8TF55Bk30BfMBV3a1mEQG7EFaq/K8fRyukbVjWW9DK4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	b=HCor7W72Wxo4iuiXKtkTle1UEZetl5JYj95Tjb5mWeCJUDr7cSHBOukf9HK3xughY
	 P+wmFXUiXD18qsCOFAIyMWlB4Jv0mp5sJ7/0xfUi2kqrscT9NDzwsAgzhH7nYo9o6J
	 mA/I/Q+DoGHYb/ZOHTuWOkW5djbNvfAOkkXmlLDJENgPbjs1/+DcKnzRzKTlmudajf
	 mmQYs+/zu5XfuA6QLck57ZmHpfhfJH7SEihk/jS0fh/kwaXW8gh426uy2ObeETJFnF
	 PxLCsyRmrg9g1D5iGU/lKay2+Knx9kxR5OS810Fza15gnPscAsRxv31h3WPW0nuj6F
	 e0ZXhglZp3DuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1759126250; bh=8TF55Bk30BfMBV3a1mEQG7EFaq/K8fRyukbVjWW9DK4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	b=HCor7W72Wxo4iuiXKtkTle1UEZetl5JYj95Tjb5mWeCJUDr7cSHBOukf9HK3xughY
	 P+wmFXUiXD18qsCOFAIyMWlB4Jv0mp5sJ7/0xfUi2kqrscT9NDzwsAgzhH7nYo9o6J
	 mA/I/Q+DoGHYb/ZOHTuWOkW5djbNvfAOkkXmlLDJENgPbjs1/+DcKnzRzKTlmudajf
	 mmQYs+/zu5XfuA6QLck57ZmHpfhfJH7SEihk/jS0fh/kwaXW8gh426uy2ObeETJFnF
	 PxLCsyRmrg9g1D5iGU/lKay2+Knx9kxR5OS810Fza15gnPscAsRxv31h3WPW0nuj6F
	 e0ZXhglZp3DuQ==
Message-ID: <e4ac030c-8ce1-4b71-9b37-a2d304defdfa@skyrain.eu>
Date: Mon, 29 Sep 2025 08:10:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: iio: accel: fix ADX355 startup race condition
From: Andrej Valek <andrej.v@skyrain.eu>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Puranjay Mohan <puranjay@kernel.org>,
 Kessler Markus <markus.kessler@hilti.com>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
 <20250910193049.145aa79e@jic23-huawei>
 <6ee57754-4fa0-4694-b997-5f4c627b567b@skyrain.eu>
 <20250912151259.00006fd5@huawei.com>
 <b709ac66-d0f2-4eb9-a66b-be557b4fe2be@skyrain.eu>
 <20250915165313.000041fa@huawei.com>
 <722b91bc-fce7-4e1f-811f-aea30e130f15@skyrain.eu>
Content-Language: en-US
In-Reply-To: <722b91bc-fce7-4e1f-811f-aea30e130f15@skyrain.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMkKS64mu5fHRpLMCFfB2/7CuxALymFqUp1oVZew5T6ef5MlNMEg5YVEhecTYH+UK+fMdXJ8vXSfKvZ5XgyCxFR3h78pHdleUdc6gCyxeEIbLHsuG767
 2V6CFElZ7PFDyzeAclNixsYtZvrdunS3UsxToVwqdK9Es2H44TbHrh9jLxFqwmHpJCc870/hE/aar0Jo6mLsE3qgNSLz0Cs/hqEgFH0QwxZ6lZ9bA23hpTmX
 82U393/KA0cCNOstivq5jpSnrP7jJITFBQ+4hrreOlKSS/mw5a2fJew3jAysmAppIXHa6JNBNTTnQXea7OY4804HPfdFNZ6wW3Qgah/9AzCxkxieV/N8+sNi
 6sET9LGeu/ngMz1tfhTUq+926u8ugbMeHIbYA2qet1a2vh0lPFc=

Hello Jonathan,

Just a friendly reminder :).

Is there anything blocking before going to be merged?

Regards,
Andrej

On 16.09.2025 09:07, Andrej Valek wrote:
>
>
> On 15.09.2025 17:53, Jonathan Cameron wrote:
>> On Mon, 15 Sep 2025 14:03:47 +0200
>> Andrej Valek <andrej.v@skyrain.eu> wrote:
>>
>>> Hi Jonathan,
>>>
>>> I submitted the version 2 with applied your suggestions.
>>>
>>> On 12.09.2025 16:12, Jonathan Cameron wrote:
>>>> On Thu, 11 Sep 2025 11:33:49 +0200
>>>> Andrej Valek <andrej.v@skyrain.eu> wrote:
>>>>> Hi Jonathan,
>>>>>
>>>>> First, I would like to thanks for your feedback.
>>>>>
>>>>> On 10.09.2025 20:30, Jonathan Cameron wrote:
>>>>>> On Tue,  9 Sep 2025 10:55:28 +0200
>>>>>> Andrej Valek <andrej.v@skyrain.eu> wrote:
>>>>>>> From: Valek Andrej <andrej.v@skyrain.eu>
>>>>>> Hi Valek,
>>>>>>
>>>>>> Thanks for the patch. Small thing on patch title, don't include 
>>>>>> drivers.
>>>>>> It's a pain but you need to look at other patches to a given 
>>>>>> subsystem
>>>>>> to find out the preferred style.
>>>>> Valek is my surname 🙂.
>>>> Oops. Sorry!
>>>>
>>>> Hi Andrej,
>>>>>>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
>>>>>>> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
>>>>>>> ---
>>>>>>>     drivers/iio/accel/adxl355_core.c | 48 
>>>>>>> ++++++++++++++++++++++++++++----
>>>>>>>     1 file changed, 43 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iio/accel/adxl355_core.c 
>>>>>>> b/drivers/iio/accel/adxl355_core.c
>>>>>>> index 2e00fd51b4d51..5386cd4766def 100644
>>>>>>> --- a/drivers/iio/accel/adxl355_core.c
>>>>>>> +++ b/drivers/iio/accel/adxl355_core.c
>>>>>>> @@ -56,6 +56,8 @@
>>>>>>>     #define  ADXL355_POWER_CTL_DRDY_MSK    BIT(2)
>>>>>>>     #define ADXL355_SELF_TEST_REG        0x2E
>>>>>>>     #define ADXL355_RESET_REG        0x2F
>>>>>>> +#define ADXL355_BASE_ADDR_SHADOW_REG    0x50
>>>>>>> +#define ADXL355_SHADOW_REG_COUNT    5
>>>>>>>         #define ADXL355_DEVID_AD_VAL        0xAD
>>>>>>>     #define ADXL355_DEVID_MST_VAL        0x1D
>>>>>>> @@ -294,6 +296,9 @@ static void 
>>>>>>> adxl355_fill_3db_frequency_table(struct adxl355_data *data)
>>>>>>>     static int adxl355_setup(struct adxl355_data *data)
>>>>>>>     {
>>>>>>>         unsigned int regval;
>>>>>>> +    u8 shadow_regs[ADXL355_SHADOW_REG_COUNT];
>>>>>> Needs to be a DMA safe buffer.  We can't assume that regmap will 
>>>>>> always
>>>>>> bounce the data through one before passing it to the SPI controllers
>>>>>> that do sometimes require DMA safe buffers.    Add a buffer to 
>>>>>> end of
>>>>>> struct adxl355_data where you can take advantage of the forcing 
>>>>>> of appropriate
>>>>>> padding that is already going on there.
>>>>> I see, but I don't like extending the adxl355_data just for one time
>>>>> usage. The suggested approach is more similar to what is done with 
>>>>> the
>>>>> ID checking.
>>>>> | if (regval != ADXL355_DEVID_MST_VAL) {
>>>>> |  dev_err(data->dev, "Invalid MEMS ID 0x%02x\n", regval);
>>>>> |  return -ENODEV;
>>>>> | }
>>>> That's a single read.  Regmap always bounces those so a local 
>>>> variable should
>>>> be fine. Not so for a bulk read (or at least no one guarantees it)
>>>>
>>>> https://events19.linuxfoundation.org/wp-content/uploads/2017/12/20181023-Wolfram-Sang-ELCE18-safe_dma_buffers.pdf 
>>>>
>>>> Slide 11 (in general this slide deck is a good introduction to the 
>>>> fun of DMA safety).
>>>>
>>>> The path for a single read goes through:
>>>> https://elixir.bootlin.com/linux/v6.16.7/source/drivers/base/regmap/regmap.c#L2779 
>>>>
>>>> _regmap_bus_read() which uses map->work_buf which is DMA safe.
>>> regmap_bulk_read is using the same _regmap_read
>>> https://elixir.bootlin.com/linux/v6.16.7/source/drivers/base/regmap/regmap.c#L3137 
>>>
>>> so it should be safe, too I guess.
>> Whilst true, the repeated statement from the regmap maintainer that
>> is mentioned in the talk is that there is no guarantee that will 
>> continue
>> to be the case :(  Whereas the single reads are fine and will remain so.
>> I guess one reason for that is that regmap_read() take an unsigned 
>> int *val
>> so the type is almost always going to be wrong and a copy necessary.
>>
>> Anyhow, the whole thing is a bit silly but upshot is dma safe buffers 
>> only to bulk
>> accessors unless the ABI is ever documented as not needing them.
>>
>> Jonathan
> Ok, I see. So can we live with the variant I did?
>>>> Jonathan
>>>>
>>> Andy
>>>
>>
> In other words, is there anything pending from my side?
>
> Andy


