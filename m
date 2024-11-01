Return-Path: <linux-iio+bounces-11731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0E29B8849
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 02:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C51F2246D
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 01:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90B28DD0;
	Fri,  1 Nov 2024 01:22:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202FF4C3D0;
	Fri,  1 Nov 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424164; cv=none; b=tFJZQZg1fDGB+Ca+AHVeyZQI6/GjyIE4I5sd8jgcne8r3mBB4Mu4kXAuzW3EVc+bR2xlHp4zf8MdT5ukNnwJLLDB3aRlDOYXDx5UxCts5EUeoHx3o8ojWRcW1Gsa7tlT2BfAVZcdIS5DXFh7wTiGBzEZpjhp0r3ROmyOinLcQzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424164; c=relaxed/simple;
	bh=hhcXo6WMirpD7byS/jflVeBGqT2L3zbnR7j7Z6Wr0K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qPnbsYUPF45TM2cplCZ4ly0ZgRPfGjmEyBnC645kQnIE7Cl/sEP5YWBTCpNOgN82pk3CLaaFUCM9f/iJqQudjtTH9w9PfbksQSofSLdckynsy+4opIThIJK7Z00ygIFlYNc0R5ihT929eLc7C/LUijTBPpkdY2exDfw3kcvjKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XfjkP20Hpz20rDY;
	Fri,  1 Nov 2024 09:21:33 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AECD1A016C;
	Fri,  1 Nov 2024 09:22:34 +0800 (CST)
Received: from [10.67.109.114] (10.67.109.114) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 1 Nov 2024 09:22:33 +0800
Message-ID: <c1f538d2-718f-4606-9039-5bfaed653076@huawei.com>
Date: Fri, 1 Nov 2024 09:22:33 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad7923: Fix buffer overflow for tx_buf and
 ring_xfer
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
	<noname.nuno@gmail.com>, <nuno.sa@analog.com>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <djunho@gmail.com>,
	<alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tanghui20@huawei.com>,
	<zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>
References: <20241028142357.1032380-1-quzicheng@huawei.com>
 <20241029134637.2261336-1-quzicheng@huawei.com>
 <4760ad42ae34ea53ffb98995d65c5f1d6a6b3f9e.camel@gmail.com>
 <20241031210501.3da82113@jic23-huawei>
From: Zicheng Qu <quzicheng@huawei.com>
In-Reply-To: <20241031210501.3da82113@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100013.china.huawei.com (7.185.36.238) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Hi Jonathan and Nuno,

Thank you for pointing that out. I included Nuno's name because I think 
the final correct solution came from Nuno, and I wanted to acknowledge 
the contribution. However, I didn't realize I needed to confirm with 
Nuno before adding the sign-off.

In the future, I will ensure to discuss with Nuno or anyone else 
involved to avoid similar issues, or use "suggested by" instead. I 
apologize to Nuno for any confusion this may have caused.

Thanks for the guidance and apologize again.

Best regards,
Zicheng Qu


On 2024/11/1 5:05, Jonathan Cameron wrote:
> On Thu, 31 Oct 2024 15:20:24 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
>
>> On Tue, 2024-10-29 at 13:46 +0000, Zicheng Qu wrote:
>>> The AD7923 was updated to support devices with 8 channels, but the size
>>> of tx_buf and ring_xfer was not increased accordingly, leading to a
>>> potential buffer overflow in ad7923_update_scan_mode().
>>>
>>> Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Nuno Sá <noname.nuno@gmail.com>
>>> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
>>> ---
>> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>>
> Confusing one. I'll fix the authorship up for your analog address
>
> Zicheng, usually a Suggested-by after checking with the author if it's
> a patch in a review thread.
>
> You can't really give someone elses' SoB without them explicitly sending it.
> If Nuno let you know that was fine off the list, then just mention that under
> ---
>
> This time I'm going to take Nuno's RB as fine to indicate no objection
> to the SoB. Nuno, feel free to shout if you want to handle this differently.
>
> Applied.
>
> Jonathan
>
>
>>> v2:
>>> - Fixed: Addressed buffer overflow in ad7923_update_scan_mode() due to
>>> insufficient tx_buf and ring_xfer size for 8-channel devices.
>>> - Issue: Original patch attempted to fix the overflow by limiting the
>>> length, but did not address the root cause of buffer size mismatch.
>>> - Solution: Increased tx_buf and ring_xfer sizes recommended by Nuno to
>>> support all 8 channels, ensuring adequate buffer capacity.
>>> - Previous patch link:
>>> https://lore.kernel.org/linux-iio/20241028142357.1032380-1-quzicheng@huawei.com/T/#u
>>>   drivers/iio/adc/ad7923.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
>>> index 09680015a7ab..acc44cb34f82 100644
>>> --- a/drivers/iio/adc/ad7923.c
>>> +++ b/drivers/iio/adc/ad7923.c
>>> @@ -48,7 +48,7 @@
>>>   
>>>   struct ad7923_state {
>>>   	struct spi_device		*spi;
>>> -	struct spi_transfer		ring_xfer[5];
>>> +	struct spi_transfer		ring_xfer[9];
>>>   	struct spi_transfer		scan_single_xfer[2];
>>>   	struct spi_message		ring_msg;
>>>   	struct spi_message		scan_single_msg;
>>> @@ -64,7 +64,7 @@ struct ad7923_state {
>>>   	 * Length = 8 channels + 4 extra for 8 byte timestamp
>>>   	 */
>>>   	__be16				rx_buf[12] __aligned(IIO_DMA_MINALIGN);
>>> -	__be16				tx_buf[4];
>>> +	__be16				tx_buf[8];
>>>   };
>>>   
>>>   struct ad7923_chip_info {

