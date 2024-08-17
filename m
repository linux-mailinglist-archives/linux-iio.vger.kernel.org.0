Return-Path: <linux-iio+bounces-8549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E750395586A
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989102829C2
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED34C79E1;
	Sat, 17 Aug 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYq9QBs5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35C621
	for <linux-iio@vger.kernel.org>; Sat, 17 Aug 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723906096; cv=none; b=An/FoHPSdmw0c+MRdBUvlOQ33JSBtE0P/kGME1IODLY3fSBrpOlS8nybf1MJZVOhl7W09frsfiLZp3u4xkAZisGvJYmPwD+AN03CnHRmws7CcRq/fzvm2TGYN2DSWlDyGCxLFglS/x/rj08ALl1nJYfQPNzLzPr7lKeJEPxWExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723906096; c=relaxed/simple;
	bh=bsMaQrIrFUsG/ja7e5R5waTIIR5r1sfk1gNOcWCDWrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaxH91LjKK+oLUw9Chx0yQEGuPg5qrcVEewJmT6OBMV4PE52Vjcsuq7TffRTt0zAByAQQSwpIxhkl5y4jCN4D7qrjFdywCV9N7FeUboeXjz12gjVkN5iUw1Driovuv+13TmLLS4dwV5IGBtJJ3ZEWdxxzPENxD1JYVMmayh4k58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYq9QBs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA81C116B1;
	Sat, 17 Aug 2024 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723906096;
	bh=bsMaQrIrFUsG/ja7e5R5waTIIR5r1sfk1gNOcWCDWrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eYq9QBs5JodoaU6R0GpCrd2SW+oTnt6oRSUze9rQfaABCQx+S31jK0iVHTUDDxQi+
	 ZPgLXvOgI1t2CKnnWrR6ewLXeEjViSUwrT+P8kVAedIxsYyaGuMWYM2E3Z7kqd5B1i
	 IpQk3TcG7BzSoxKhrUrDqI8q8xKGQPX5u1AhapAhlWEIH2Uf8b0u7eE6/Pk9atXao7
	 Qz5O6zQBMHDi0pNfjoShz7Jhkji2Ew/yEb8SK7CSodpO4sr/P+ADfRGrM4KyVJLymV
	 dfhicKEpHMOem5vtHnsDB86Gw0ab2kxwfcyo+Z11GtmQF/XjvzbHj0/kBmXgOhbgQB
	 CvDe4kbHLlM2w==
Date: Sat, 17 Aug 2024 15:48:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240817154809.6aa725dd@jic23-huawei>
In-Reply-To: <73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain>
References: <73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 14:22:12 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hello Vasileios Amoiridis,
> 
> Commit 80cd23f43ddc ("iio: pressure: bmp280: Add triggered buffer
> support") from Jun 28, 2024 (linux-next), leads to the following (UNPUBLISHED)
> Smatch static checker warning:
> 
> 	drivers/iio/pressure/bmp280-core.c:2206 bmp580_trigger_handler()
> 	warn: not copying enough bytes for '&data->sensor_data[1]' (4 vs 3 bytes)
> 

This is a fun one. 

The data is little endian whatever happens (that is advertised to userspace
which gets to unwind that if it wants to, or just store the data as is),
I think the code is functionally correct, but we shouldn't really be using
s32 for sensor_data (can't use __le32 either though as it's actually __le24
+ 1 byte of padding.  As it stands the code splats a s64 over some of the s32
entries anyway so there is size confusion going on as well.

Right option is probably to make it a u8 buffer that is 4 times larger
and fix up the code to multiple current index by 4.

That will get away from any pretence that this is a 32 bit cpu endian
value.

Vasileios, if you agree with that analysis then please spin a suitable
patch.

Jonathan


> drivers/iio/pressure/bmp280-core.c
>     2188 static irqreturn_t bmp580_trigger_handler(int irq, void *p)
>     2189 {
>     2190         struct iio_poll_func *pf = p;
>     2191         struct iio_dev *indio_dev = pf->indio_dev;
>     2192         struct bmp280_data *data = iio_priv(indio_dev);
>     2193         int ret;
>     2194 
>     2195         guard(mutex)(&data->lock);
>     2196 
>     2197         /* Burst read data registers */
>     2198         ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
>     2199                                data->buf, BMP280_BURST_READ_BYTES);
>     2200         if (ret) {
>     2201                 dev_err(data->dev, "failed to burst read sensor data\n");
>     2202                 goto out;
>     2203         }
>     2204 
>     2205         /* Temperature calculations */
> --> 2206         memcpy(&data->sensor_data[1], &data->buf[0], 3);  
>                          ^^^^^^^^^^^^^^^^^^^^                 ^
> sensor_data is an s32 type.  We're copying 3 bytes to it.  This can't  be
> correct from an endian perspective.
> 
>     2207 
>     2208         /* Pressure calculations */
>     2209         memcpy(&data->sensor_data[0], &data->buf[3], 3);
>                         ^^^^^^^^^^^^^^^^^^^^^                 ^
> Same
> 
>     2210 
>     2211         iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
>     2212                                            iio_get_time_ns(indio_dev));
>     2213 
>     2214 out:
>     2215         iio_trigger_notify_done(indio_dev->trig);
>     2216 
>     2217         return IRQ_HANDLED;
>     2218 }
> 
> regards,
> dan carpenter
> 


