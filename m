Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ED11D6E3A
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 02:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgERAKN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 20:10:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60152 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgERAKN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2020 20:10:13 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04I09mdC067061;
        Sun, 17 May 2020 19:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589760588;
        bh=uHDWAbUPh1UGoZfwAFTrqfN3qYQnLykoq0dvdTPuMFA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hie88stxMbkiRMXvjASjMp+Rxx2NDl6Y2cpBzHn6wOflat+IURp5MOcpRSi+NtniO
         sNnbNTJzql8Zo0zC09SnTonGw/tJunXNeAwd5McnI0QhDpqde8dxx7fz+wEogb+Eic
         OrMklhQ0gapcqmkCQlWZZ+S9SgViCV130LytuZqA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04I09mMQ006889
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 17 May 2020 19:09:48 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 17
 May 2020 19:09:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 17 May 2020 19:09:48 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04I09lUg027513;
        Sun, 17 May 2020 19:09:48 -0500
Subject: Re: [PATCH 07/11] iio:health:afe4403 Fix timestamp alignment and
 prevent data leak.
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20200517173000.220819-1-jic23@kernel.org>
 <20200517173000.220819-8-jic23@kernel.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <951a305b-b3b4-6cfc-f39a-f7458dfcb54b@ti.com>
Date:   Sun, 17 May 2020 20:09:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200517173000.220819-8-jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/17/20 1:29 PM, jic23@kernel.org wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 32 byte array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data with alignment
> explicitly requested.  This data is allocated with kzalloc so no
> data can leak appart from previous readings.
> 
> Fixes: eec96d1e2d31 ("iio: health: Add driver for the TI AFE4403 heart monitor")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/iio/health/afe4403.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index e9f87e42ff4f..a3507624b30f 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -65,6 +65,7 @@ static const struct reg_field afe4403_reg_fields[] = {
>   * @regulator: Pointer to the regulator for the IC
>   * @trig: IIO trigger for this device
>   * @irq: ADC_RDY line interrupt number
> + * @buffer: Used to construct data layout to push into IIO buffer.
>   */
>  struct afe4403_data {
>  	struct device *dev;
> @@ -74,6 +75,8 @@ struct afe4403_data {
>  	struct regulator *regulator;
>  	struct iio_trigger *trig;
>  	int irq;
> +	/* Ensure suitable alignment for timestamp */
> +	s32 buffer[8] __aligned(8);


One of those fancy structs with the timestamp specified would be nice
here like the other patches. IIRC we have 6 s32 channels, plus a s64 ts.

Other than that everything looks good.

Andrew


>  };
>  
>  enum afe4403_chan_id {
> @@ -309,7 +312,6 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct afe4403_data *afe = iio_priv(indio_dev);
>  	int ret, bit, i = 0;
> -	s32 buffer[8];
>  	u8 tx[4] = {AFE440X_CONTROL0, 0x0, 0x0, AFE440X_CONTROL0_READ};
>  	u8 rx[3];
>  
> @@ -326,7 +328,7 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
>  		if (ret)
>  			goto err;
>  
> -		buffer[i++] = get_unaligned_be24(&rx[0]);
> +		afe->buffer[i++] = get_unaligned_be24(&rx[0]);
>  	}
>  
>  	/* Disable reading from the device */
> @@ -335,7 +337,8 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
>  	if (ret)
>  		goto err;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
> +					   pf->timestamp);
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> 
