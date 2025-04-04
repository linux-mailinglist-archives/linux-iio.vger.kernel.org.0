Return-Path: <linux-iio+bounces-17610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35151A7BBAF
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 13:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A0F1899795
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6E01DE2BB;
	Fri,  4 Apr 2025 11:39:07 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAF146588;
	Fri,  4 Apr 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743766747; cv=none; b=U5hjQvbG+mNfl02Ly6xapGcnrsBjkLcNPY774teUwrifYHZoPmzUG+lHJ3gDXWxqP3qWxIBlrJnGthl1FA06FiOMGfgjhq7Dh9NVdPRuqKSEEI0F0plBmbdOBeqExPggZabLHe4Ys0SoUhgxlYBXRVw9lXqcOADLHphcpR2cLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743766747; c=relaxed/simple;
	bh=Imp8bBBQ90xiZPwnn6Zjy6tbA7FK0TIXZrW0accwr+U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPLxe4lbaaOvjpj3GQwVKMegcyODtuxGCUw297pSx+eNCVONOsanh47soDVUdmVYqJ3m0Nkj13mCed3OXo2xnW7jbUeQo60reWSl2KZzuFl53AkFXy5KNMhNLQCJ5xAphIOIbAwT++Nvp6t98PO4OuYArK+coOUmhL3/JmA/bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTc3X1jsXz6M4NZ;
	Fri,  4 Apr 2025 19:35:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EB63614080B;
	Fri,  4 Apr 2025 19:39:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 13:39:01 +0200
Date: Fri, 4 Apr 2025 12:39:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: gyeyoung <gye976@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <lars@metafoo.de>, <gustavograzs@gmail.com>,
	<javier.carrasco.cruz@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH 1/3] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <20250404123900.00003147@huawei.com>
In-Reply-To: <CAKbEznv9hRhto2tF5zwrGJ=7zfT=VKq2POdWKCRgY1UjgP6pUg@mail.gmail.com>
References: <20250329164905.632491-1-gye976@gmail.com>
	<20250329164905.632491-2-gye976@gmail.com>
	<20250330150410.23b148da@jic23-huawei>
	<CAKbEznv9hRhto2tF5zwrGJ=7zfT=VKq2POdWKCRgY1UjgP6pUg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 31 Mar 2025 23:36:17 +0900
gyeyoung <gye976@gmail.com> wrote:

> Hello Jonathan, thank you for the review.
> Sorry for the late response.
> 
> > > +
> > > +             /* at least 1000ppm */
> > > +             if (ppm < 1000 || ppm > 5000) {
> > > +                     dev_dbg(&indio_dev->dev, "span point ppm should be 1000~5000");
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             cmd_buf[3] = ppm / 256;
> > > +             cmd_buf[4] = ppm % 256;  
> >
> > That's an elaborate way of doing
> >                 unaligned_put_be16()
> > so use that instead as it's also clearly documenting what is going on.  
> 
> Since I couldn't find a function like 'unaligned_put_be16',
> but I found a function like 'be16_to_cpu', so I will use that.

You can't. An array of u8 is not guaranteed to be aligned so in
some cases be16_to_cpu() will fail.

I was half asleep :(
put_unaligned_be16() is what you are looking for.
https://elixir.bootlin.com/linux/v6.13.7/source/include/linux/unaligned.h#L61


> > > +static void mhz19b_write_wakeup(struct serdev_device *serdev)
> > > +{
> > > +     struct iio_dev *indio_dev;
> > > +
> > > +     indio_dev = dev_get_drvdata(&serdev->dev);
> > > +
> > > +     dev_dbg(&indio_dev->dev, "mhz19b_write_wakeup");  
> >
> > This doesn't do anything which makes me suspicious. Would
> > using serdev_device_write_wakeup() as the callback make
> > sense?  I'm not that familiar with serial drivers but I can
> > see that a number of other drivers do that.
> >  
> 
> 'serdev_device_write_wakeup' member function is mandatory.
> If this function is not set and remains NULL, the
> 'serdev_device_write' function will just return -EINVAL.
> 
> The following is a part of serdev_device_write().
> ------------
> ssize_t serdev_device_write(struct serdev_device *serdev, const u8 *buf,
>    size_t count, long timeout)
> {
> struct serdev_controller *ctrl = serdev->ctrl;
> size_t written = 0;
> ssize_t ret;
> 
> if (!ctrl || !ctrl->ops->write_buf || !serdev->ops->write_wakeup)
> return -EINVAL;
> .
> .
> .
> ------------

Ok. So why not serdev_device_write_wakeup()?

> 
> > > +}
> > > +
> > > +static const struct serdev_device_ops mhz19b_ops = {
> > > +     .receive_buf = mhz19b_receive_buf,
> > > +     .write_wakeup = mhz19b_write_wakeup,
> > > +};  
>
> > > +static int mhz19b_probe(struct serdev_device *serdev)
> > > +{
> > > +     int ret;
> > > +
> > > +     struct device *dev;
> > > +
> > > +     dev = &serdev->dev;
> > > +     serdev_device_set_client_ops(serdev, &mhz19b_ops);
> > > +
> > > +     ret = devm_serdev_device_open(dev, serdev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     serdev_device_set_baudrate(serdev, 9600);
> > > +     serdev_device_set_flow_control(serdev, false);
> > > +     ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> > > +     if (ret < 0)
> > > +             return ret;  
> >
> > Why check return value from this call but not the previous two?
> > I'm not immediately able to see a reason this is more likely to fail.  
> 
> 'serdev_device_set_flow_control' is a void function.
> and as far as I know, 'serdev_device_set_baudrate' does not return an error.
> but I'll check again.

Ah I missed that. No problem not checking it.

Jonathan

> 
> I'll revise it considering your overall coding style guide.
> 
> Thanks,
> Gyeyoung Baek
> 
> 


