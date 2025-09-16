Return-Path: <linux-iio+bounces-24127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66BEB58EC6
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B60E1B25B95
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 07:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900352E5415;
	Tue, 16 Sep 2025 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="HliAC8pB";
	dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b="HliAC8pB"
X-Original-To: linux-iio@vger.kernel.org
Received: from h4.cmg1.smtp.forpsi.com (h4.cmg1.smtp.forpsi.com [185.129.138.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552831DB551
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 07:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.129.138.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006456; cv=none; b=P2SdMPHyieD8FRFlgClB28aldJf0nvlISbmVna7s1WeqIjpfvgDByjaEE7+CcbgnP+EB4XREXT0sQMAWLKKl5pYbYQdWhyD+CDYimiRvJNgHYW+D6ODO0WYGH5/Iya03WDZFUsmZVSTy7pEHnViWbF79PeYSnAfnL6CHd7Z24lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006456; c=relaxed/simple;
	bh=h9DtuxmUk/onI/LgAuJFzQS94rXz6QKAjs56cEtby44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/QXj16EYCs8c6dmUJUmQNA4p7JXr6xzgwAAQPs8cAzA/8gTo9v5OKyCvTEL6bvaujk0w9OmIlFLA8oB8HVLZQDWyRQ1BetX8W/ygP5zLESlD2KWiSKgiHGZMNM6yaZ3/7UCsNxUITYmubqza1QAJCAPvby51viClO8fgUMaHD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu; spf=none smtp.mailfrom=skyrain.eu; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=HliAC8pB; dkim=pass (2048-bit key) header.d=skyrain.eu header.i=@skyrain.eu header.b=HliAC8pB; arc=none smtp.client-ip=185.129.138.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skyrain.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=skyrain.eu
Received: from [172.25.98.14] ([85.248.43.180])
	by cmgsmtp with ESMTPSA
	id yPmYuUCXix9qoyPmZuG0fm; Tue, 16 Sep 2025 09:07:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1758006441; bh=BogOJ7ziO51gexieDipQLI137hql1B2OFvQkPhHEOJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=HliAC8pBeJy31rUiNJFCLPCUDCS1nWbxWujJCm9foSoPUPF4Ua7SkYofYY2hCh0PD
	 dDpYaY48E+rBka2c6C3R824AvEAwFzm6b4EM3y41jH5pDwUHe36WMAMMfrDcBgjfgu
	 tk9sDTMvsY6h7OayzPqZImmvf3xIWpR2wTwdJQYJ8te0RmCfmRcZWUl3UhvIhk7Iok
	 UtlJ2FPz4h0xLTCNHmERrpITKfWgNIJWe6g8ZfPrNs9zVYIJd3PmX6Ct6T81wx5ZHQ
	 M0UZ3zt6bNNcLJJvkAZJ4ozMkPfJHt8qo0tDbTeHZVeKGcOAWEB170wLqtUhG7RoVS
	 DaRuiVTQA+TZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=skyrain.eu; s=f2022;
	t=1758006441; bh=BogOJ7ziO51gexieDipQLI137hql1B2OFvQkPhHEOJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=HliAC8pBeJy31rUiNJFCLPCUDCS1nWbxWujJCm9foSoPUPF4Ua7SkYofYY2hCh0PD
	 dDpYaY48E+rBka2c6C3R824AvEAwFzm6b4EM3y41jH5pDwUHe36WMAMMfrDcBgjfgu
	 tk9sDTMvsY6h7OayzPqZImmvf3xIWpR2wTwdJQYJ8te0RmCfmRcZWUl3UhvIhk7Iok
	 UtlJ2FPz4h0xLTCNHmERrpITKfWgNIJWe6g8ZfPrNs9zVYIJd3PmX6Ct6T81wx5ZHQ
	 M0UZ3zt6bNNcLJJvkAZJ4ozMkPfJHt8qo0tDbTeHZVeKGcOAWEB170wLqtUhG7RoVS
	 DaRuiVTQA+TZA==
Message-ID: <722b91bc-fce7-4e1f-811f-aea30e130f15@skyrain.eu>
Date: Tue, 16 Sep 2025 09:07:18 +0200
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
 <b709ac66-d0f2-4eb9-a66b-be557b4fe2be@skyrain.eu>
 <20250915165313.000041fa@huawei.com>
Content-Language: en-US
From: Andrej Valek <andrej.v@skyrain.eu>
In-Reply-To: <20250915165313.000041fa@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIV1/ePIHG3xSIlhGlWEMz5YZYpKlxyxOmujlOd2H+7Zf15V5VAa1nl/+QdjlVppx3qS1BLXk4gZ+1U7RbU3CXShSGexeh7rjpNB3cRyH6IaVbw1P4w/
 PDUybwG7G//qn4m7tivQ28PCJ8TKVGSS51qVheIILllXaLMMjsCuQ3zvbli9Tbp03Mgax6KFV/yP+qmH9XTlRZlHS7Dl1MJN4YpnU7RrTsEA4T/h1JIAoHuQ
 2RA5Kefe3dSWau1c9NHoa0D07Rz1TDuP9B9bz7I5oOc8vbMpBqO59kxISePXQxplyYjIzoYfZ1sWAqabAHvgziawNt9yScird3nwXwB9zLPIjMurR9VPAahB
 NZCzuBT/aeZ7w4gAJJw73xwOcDL5ctWlrSxBKf4xpLN0IfXkloM=



On 15.09.2025 17:53, Jonathan Cameron wrote:
> On Mon, 15 Sep 2025 14:03:47 +0200
> Andrej Valek <andrej.v@skyrain.eu> wrote:
>
>> Hi Jonathan,
>>
>> I submitted the version 2 with applied your suggestions.
>>
>> On 12.09.2025 16:12, Jonathan Cameron wrote:
>>> On Thu, 11 Sep 2025 11:33:49 +0200
>>> Andrej Valek <andrej.v@skyrain.eu> wrote:
>>>   
>>>> Hi Jonathan,
>>>>
>>>> First, I would like to thanks for your feedback.
>>>>
>>>> On 10.09.2025 20:30, Jonathan Cameron wrote:
>>>>> On Tue,  9 Sep 2025 10:55:28 +0200
>>>>> Andrej Valek <andrej.v@skyrain.eu> wrote:
>>>>>      
>>>>>> From: Valek Andrej <andrej.v@skyrain.eu>
>>>>> Hi Valek,
>>>>>
>>>>> Thanks for the patch. Small thing on patch title, don't include drivers.
>>>>> It's a pain but you need to look at other patches to a given subsystem
>>>>> to find out the preferred style.
>>>> Valek is my surname 🙂.
>>> Oops. Sorry!
>>>
>>> Hi Andrej,
>>>   
>>>>>> Signed-off-by: Valek Andrej <andrej.v@skyrain.eu>
>>>>>> Signed-off-by: Kessler Markus <markus.kessler@hilti.com>
>>>>>> ---
>>>>>>     drivers/iio/accel/adxl355_core.c | 48 ++++++++++++++++++++++++++++----
>>>>>>     1 file changed, 43 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
>>>>>> index 2e00fd51b4d51..5386cd4766def 100644
>>>>>> --- a/drivers/iio/accel/adxl355_core.c
>>>>>> +++ b/drivers/iio/accel/adxl355_core.c
>>>>>> @@ -56,6 +56,8 @@
>>>>>>     #define  ADXL355_POWER_CTL_DRDY_MSK	BIT(2)
>>>>>>     #define ADXL355_SELF_TEST_REG		0x2E
>>>>>>     #define ADXL355_RESET_REG		0x2F
>>>>>> +#define ADXL355_BASE_ADDR_SHADOW_REG	0x50
>>>>>> +#define ADXL355_SHADOW_REG_COUNT	5
>>>>>>     
>>>>>>     #define ADXL355_DEVID_AD_VAL		0xAD
>>>>>>     #define ADXL355_DEVID_MST_VAL		0x1D
>>>>>> @@ -294,6 +296,9 @@ static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
>>>>>>     static int adxl355_setup(struct adxl355_data *data)
>>>>>>     {
>>>>>>     	unsigned int regval;
>>>>>> +	u8 shadow_regs[ADXL355_SHADOW_REG_COUNT];
>>>>> Needs to be a DMA safe buffer.  We can't assume that regmap will always
>>>>> bounce the data through one before passing it to the SPI controllers
>>>>> that do sometimes require DMA safe buffers.    Add a buffer to end of
>>>>> struct adxl355_data where you can take advantage of the forcing of appropriate
>>>>> padding that is already going on there.
>>>> I see, but I don't like extending the adxl355_data just for one time
>>>> usage. The suggested approach is more similar to what is done with the
>>>> ID checking.
>>>> | if (regval != ADXL355_DEVID_MST_VAL) {
>>>> |  dev_err(data->dev, "Invalid MEMS ID 0x%02x\n", regval);
>>>> |  return -ENODEV;
>>>> | }
>>> That's a single read.  Regmap always bounces those so a local variable should
>>> be fine. Not so for a bulk read (or at least no one guarantees it)
>>>
>>> https://events19.linuxfoundation.org/wp-content/uploads/2017/12/20181023-Wolfram-Sang-ELCE18-safe_dma_buffers.pdf
>>> Slide 11 (in general this slide deck is a good introduction to the fun of DMA safety).
>>>
>>> The path for a single read goes through:
>>> https://elixir.bootlin.com/linux/v6.16.7/source/drivers/base/regmap/regmap.c#L2779
>>> _regmap_bus_read() which uses map->work_buf which is DMA safe.
>> regmap_bulk_read is using the same _regmap_read
>> https://elixir.bootlin.com/linux/v6.16.7/source/drivers/base/regmap/regmap.c#L3137
>> so it should be safe, too I guess.
> Whilst true, the repeated statement from the regmap maintainer that
> is mentioned in the talk is that there is no guarantee that will continue
> to be the case :(  Whereas the single reads are fine and will remain so.
> I guess one reason for that is that regmap_read() take an unsigned int *val
> so the type is almost always going to be wrong and a copy necessary.
>
> Anyhow, the whole thing is a bit silly but upshot is dma safe buffers only to bulk
> accessors unless the ABI is ever documented as not needing them.
>
> Jonathan
Ok, I see. So can we live with the variant I did?
>>> Jonathan
>>>
>>>   
>> Andy
>>
>
In other words, is there anything pending from my side?

Andy

