Return-Path: <linux-iio+bounces-17477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F65FA76896
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 16:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0D8C188716A
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C90D21638D;
	Mon, 31 Mar 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsKpsuVi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44250226D18;
	Mon, 31 Mar 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431790; cv=none; b=j/b6DpUja7NGaLThNdWzn4aW06KTd7M/Qli2KjaalxVo75/gh6nSLbseNHaQHGDItwHaThJ7ZXFgSJ5OzcxhcXfLTkTvpD185B5kjkWrEE8kxdX8MGVubwWBxHgb/8/S7PB8vXYgm9S8NWqQLQdD9WwN/2yHLlN44VPtMs3hd70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431790; c=relaxed/simple;
	bh=gTkTfbAuq15gZso4bpVxix7pTVeRXjBC1DNAQ66niYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaeJkqpBWZz2wOn5Fv6ur35udlMf5c8e6Op54ljFOeGDUZHM+xGnX7za2Hj2nexlToI1vQwFnnrMCQT2ZOim3EN6mSanmduwbcz++m/5L+Z1d+a5skZ6ZAQmpYnqtm4dyKcEhDWhGvVQgUzkLghS6bmH9OlpVmmfgjB5c7ORBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsKpsuVi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22438c356c8so89169235ad.1;
        Mon, 31 Mar 2025 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743431788; x=1744036588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LL7vG5/tQduxfNKHAQVZyLzm1JLahcZCX114BxDCx+0=;
        b=PsKpsuViUPfVz1pb/zh4b9Rxy/1yAcVAXqGkVNHbbDR5gwb+WocyC3Iyywp2MpkWpk
         Guj96vteHH79jRob2QKr2/w0xxgYIvG45W85O3slsGu4TfS5xvbj7+np5YgcktgoXn9+
         TalIFLhsFZd+d3xF1t2LFI2tPOadRHm7w8w/JGY2Ve7u72w296YkVBCBXXRvVOHAbZk5
         K8lkXnrbgW22NB8RoyVkS8mhd9Pd5QMPW6okbCWYSgKvTAydp/cAZO6/GsO3cJBAgvEK
         q7bHvJbpJ1fPUQVcjxyr48ox/8TbhqV7LIOD3sIPYr+lCY5AFglUxmaOk+V7o3x52fCb
         cK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431788; x=1744036588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LL7vG5/tQduxfNKHAQVZyLzm1JLahcZCX114BxDCx+0=;
        b=qBMSA8F0dvRAvMhR83o41E68dOPKoui/f/Kp7k7Do9uOb5v+8HZWsmk6PikqAbEg8O
         3pxNbpCBB1onvBoWHJFtzaIX5zC3L88dgn/qG+LRxybfACvKTm5JJHkHv9PegzASZxIU
         k/ikSuuELsjRy+DpdFsLcTwIgsDhnguAsHmHbAJT+93THAA3+nQP5k56tOo6z+kgyi/5
         C6WN5psVrlhKNrlz0ktjjoBg6djiagBVNVQxlXH4h+hPe+K9Mx6Hvxaeg4uQSy7l+kaI
         yt27ZhXq1z1B5MSnuIJeu5m21j8g38u9r6LJePC7hM6ihn9UVjHbS6zJnBi4sWNp/CVN
         P8mA==
X-Forwarded-Encrypted: i=1; AJvYcCWPaXhUa3499Xe9B2xoevUrqPcQhTh1Hc1GojttHITU823k1/VkdFnA8D1bZj1rf1dwE1LDrkGrIQp4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1vAArDTkWKOWXEobIX3VeCO3m+LoBXl42I5FIL/HmdIPTDF1L
	ixTjcfpq7cxMwDFqysQCUoiYiWtE7WkTbN3ePLk4uXrxysyWk7g14Er53Mv/BJCrn1OPDE6SAct
	iLT5AXVs+vQI1jgHAKDg6WCKzpCc=
X-Gm-Gg: ASbGncvFQzm+JuQq3k3F/0B1LyE5B75FdpBJYTcUn4YLKnAiVzvdgvh1zfSsqyKZUZ7
	e0SB0eSx18dYKB+f6XaTnM53a0fXPbwWPw2/vGVQWGYMwQ3KxXQxIArK88yJmqQ9kP6CCbZ2Lgs
	MZ9REOOMNUfe6v7dd7kEfAhRPnQFk=
X-Google-Smtp-Source: AGHT+IEl+3TwIlPc8xntIMk5HRocdNKS4IRtch/DXwy3r5uEzJLN0+htJhvRxRWs9ReXWP1XEPGgVZVSs0C5mlQO3WM=
X-Received: by 2002:a17:90b:2801:b0:2fc:ec7c:d371 with SMTP id
 98e67ed59e1d1-30531f79fe9mr13283832a91.3.1743431788183; Mon, 31 Mar 2025
 07:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329164905.632491-1-gye976@gmail.com> <20250329164905.632491-2-gye976@gmail.com>
 <20250330150410.23b148da@jic23-huawei>
In-Reply-To: <20250330150410.23b148da@jic23-huawei>
From: gyeyoung <gye976@gmail.com>
Date: Mon, 31 Mar 2025 23:36:17 +0900
X-Gm-Features: AQ5f1JoZbFBHT33j6UAwVVBPHIG8N5B-wGlpOGkmQfVIjzjGWmYYS66YbuYl89g
Message-ID: <CAKbEznv9hRhto2tF5zwrGJ=7zfT=VKq2POdWKCRgY1UjgP6pUg@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, lars@metafoo.de, 
	gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Jonathan, thank you for the review.
Sorry for the late response.

> > +
> > +             /* at least 1000ppm */
> > +             if (ppm < 1000 || ppm > 5000) {
> > +                     dev_dbg(&indio_dev->dev, "span point ppm should be 1000~5000");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             cmd_buf[3] = ppm / 256;
> > +             cmd_buf[4] = ppm % 256;
>
> That's an elaborate way of doing
>                 unaligned_put_be16()
> so use that instead as it's also clearly documenting what is going on.

Since I couldn't find a function like 'unaligned_put_be16',
but I found a function like 'be16_to_cpu', so I will use that.




> > +struct iio_chan_spec_ext_info mhz19b_co2_ext_info[] = {
> > +     {
> > +             .name = "zero_point",
>
> This is custom ABI.  Before we consider that in detail we
> need documentation in
> Documentation/ABI/testing/sysfs-bus-iio-mhz19b
> It is much easier to review ABI with docs.
> All 3 are direct commands to the device, so I've no idea from
> what we have here on what they do.
>
> Superficially this one looks like a calibration control.
> There is existing ABI for that.

 I did it arbitrarily. I will refer to the documentation
and rewrite it to be as compatible as possible with the existing ABI, thanks.




>
> > +
> > +static void mhz19b_write_wakeup(struct serdev_device *serdev)
> > +{
> > +     struct iio_dev *indio_dev;
> > +
> > +     indio_dev = dev_get_drvdata(&serdev->dev);
> > +
> > +     dev_dbg(&indio_dev->dev, "mhz19b_write_wakeup");
>
> This doesn't do anything which makes me suspicious. Would
> using serdev_device_write_wakeup() as the callback make
> sense?  I'm not that familiar with serial drivers but I can
> see that a number of other drivers do that.
>

'serdev_device_write_wakeup' member function is mandatory.
If this function is not set and remains NULL, the
'serdev_device_write' function will just return -EINVAL.

The following is a part of serdev_device_write().
------------
ssize_t serdev_device_write(struct serdev_device *serdev, const u8 *buf,
   size_t count, long timeout)
{
struct serdev_controller *ctrl = serdev->ctrl;
size_t written = 0;
ssize_t ret;

if (!ctrl || !ctrl->ops->write_buf || !serdev->ops->write_wakeup)
return -EINVAL;
.
.
.
------------

> > +}
> > +
> > +static const struct serdev_device_ops mhz19b_ops = {
> > +     .receive_buf = mhz19b_receive_buf,
> > +     .write_wakeup = mhz19b_write_wakeup,
> > +};




> > +static int mhz19b_probe(struct serdev_device *serdev)
> > +{
> > +     int ret;
> > +
> > +     struct device *dev;
> > +
> > +     dev = &serdev->dev;
> > +     serdev_device_set_client_ops(serdev, &mhz19b_ops);
> > +
> > +     ret = devm_serdev_device_open(dev, serdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     serdev_device_set_baudrate(serdev, 9600);
> > +     serdev_device_set_flow_control(serdev, false);
> > +     ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> > +     if (ret < 0)
> > +             return ret;
>
> Why check return value from this call but not the previous two?
> I'm not immediately able to see a reason this is more likely to fail.

'serdev_device_set_flow_control' is a void function.
and as far as I know, 'serdev_device_set_baudrate' does not return an error.
but I'll check again.

I'll revise it considering your overall coding style guide.

Thanks,
Gyeyoung Baek

