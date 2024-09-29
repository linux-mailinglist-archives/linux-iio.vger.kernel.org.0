Return-Path: <linux-iio+bounces-9892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB589896C5
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1741C213E0
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 18:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08E54207A;
	Sun, 29 Sep 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNfGnr3S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF62263A;
	Sun, 29 Sep 2024 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727634423; cv=none; b=AHL+oQgTMHxCetcmC8vDnhlkDgTr1gCzdMQJmc7RyScXzNvFpNVIerR9xxWVtzvkk0rZw/f7Y8gglLo8OcULud7g9HfiN0NYK4BKwqPZZB6ktE60WxTgPhGcPkGqSMIzyhVQ3p5SW7aPzBVOSqZaC28EdH0HXfKrb2jp/3nd640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727634423; c=relaxed/simple;
	bh=4HgMcXMyt1xd9y+Q34ms0nKju3WVpvwFRzIISoIbgWQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3ib1SYl3PqQk4Qf/DXIHkBGuVBL/x1O2UowsGgyCZY7Fauv7t39nONfngjTIzeKnQ3JmoKeUmkKUyErTVzO+FMEvDzSCh75dwmiuc/3tJkoLfF8e6QUhNGjmyLlC0Fq3SK8raKcRHPsrZnFH7BU0jvnGOrIiy6r0Pnclj8stY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNfGnr3S; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccc597b96so2358927f8f.3;
        Sun, 29 Sep 2024 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727634420; x=1728239220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YeT6eEVeYlnUyZhHd3J725yc68DlQRaIQmtuB3sz8Ds=;
        b=nNfGnr3SRDtDVSQ1CvfojWSlU6BK3nWySpXIBod4DvD0WH2mYJfuTLoJeMsqwmw73d
         bjARBoWPiVV776F2TvDUGpuP4EVas7sronb3P1PNhsQQaRwNou8gu4y5vdSDKVzWQTNw
         z6en08lyYD8UhP/9KvUHQgjAhW1U/DYT5ftIkhnmgotyLyjxomtNeqgWIBQur9rNsVlI
         k5bhxe3BMjj8HZdAKdzpKWIe5hNTy9MIE+WW3lxlMiFFDKN5nc+K6j2HAMyLOoOdEXub
         h9+egoe1/ulhvBPPc21xxuozBs1FcpyaCUeryHzgcbHxrjzjjZcUxKUvRyUevQPya9Zp
         sSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727634420; x=1728239220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeT6eEVeYlnUyZhHd3J725yc68DlQRaIQmtuB3sz8Ds=;
        b=tnqpTyTVSOfwDjio932+DdTBF4EdE6gyE/l28XV5quqOGChlfEMaGVQMpsL2+PTTbl
         Qxpx9xQUXNN2zdpK4T5ZztwD8wYmbKcPmyVIXB46GETtoP6gfiiSaJi7JSPToZqOklLG
         ERuFgkDcPUc9OlMFwItPCvnRzouOFEZPCBL98zOGyUhN5FfoD5zdUFIgdlVFy3lHMP3s
         W0HgrGpjsJmnpuIeW37PIJT9Re88KSNTV2yDBQlOYS7Gh9PRs/JEBjJjrwBFhUJJYuxS
         Y9kKynJy9IGLshpzMCN+h1m7hb837wEV3ftTZmc9i7YsPqxpGY6y+Ubp3Z4ChWZrdJQJ
         /4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV++WGFXWB35H3vZR5ZeNsf0a/6OEcusARzV7qd2wHBu8rQAVh8GQHHZJ9hFY1MBwBQ5L+xrSkwwdo=@vger.kernel.org, AJvYcCXgjzAa2Rf3J0BWFyMf6aVu9T1YCQFsGUFkysAj9C//SKCqzQfY7azj5pvrIaDhTUCMw3zOkuqfXULF6gQh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx290WMwKiV97hvYZRHCma3VDb7/dyiDXidMxGLgkphRmsUE95w
	imMGm+cC+3irM1ZvV8xjUi5R4RiJSWlFgxQFpKNK9s+iLRnNjz01
X-Google-Smtp-Source: AGHT+IGB9cqdwAHrsFDW2jX51mn52HKuIoqz+M7Bu/Uo1NIGvFY4UV2kCCpbbaFQ1Pyj7I9rEHlXKA==
X-Received: by 2002:adf:cd0f:0:b0:37c:c830:3b6d with SMTP id ffacd0b85a97d-37cd5b10502mr6134023f8f.52.1727634419833;
        Sun, 29 Sep 2024 11:26:59 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:df60:d786:cd5:d3c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d42esm7394474f8f.14.2024.09.29.11.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 11:26:58 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 29 Sep 2024 20:26:55 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: bmp280: Use char instead of s32
 for data buffer
Message-ID: <20240929182655.GB213331@vamoiridPC>
References: <20240929112511.100292-1-vassilisamir@gmail.com>
 <20240929112511.100292-3-vassilisamir@gmail.com>
 <20240929181003.26abf543@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929181003.26abf543@jic23-huawei>

On Sun, Sep 29, 2024 at 06:10:03PM +0100, Jonathan Cameron wrote:
> On Sun, 29 Sep 2024 13:25:11 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > As it was reported and discussed here [1], storing the sensor data in an
> > endian aware s32 buffer is not optimal. Advertising the timestamp as an
> > addition of 2 s32 variables which is also implied is again not the best
> > practice. For that reason, change the s32 sensor_data buffer to a char
> > buffer with an extra value for the timestamp (as it is common practice).
> > 
> > [1]: https://lore.kernel.org/linux-iio/73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain/
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Hi Vasileois.
> 
> I missed a purely semantic issue in previous versions :( 
> 
> A few other places where you can achieve the same effect with less code
> and clear casting to correct types.
> 
> Jonathan
> 
> 

Hi Jonathan,

> > ---
> >  drivers/iio/pressure/bmp280-core.c | 78 ++++++++++++++++++------------
> >  drivers/iio/pressure/bmp280.h      |  5 +-
> >  2 files changed, 51 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 472a6696303b..2c62490a40c6 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> 
> 
> > @@ -2523,23 +2538,24 @@ static irqreturn_t bmp180_trigger_handler(int irq, void *p)
> >  	struct iio_poll_func *pf = p;
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct bmp280_data *data = iio_priv(indio_dev);
> > -	int ret, chan_value;
> > +	int ret, comp_temp, comp_press, offset;
> >  
> >  	guard(mutex)(&data->lock);
> >  
> > -	ret = bmp180_read_temp(data, &chan_value);
> > +	ret = bmp180_read_temp(data, &comp_temp);
> >  	if (ret)
> >  		goto out;
> >  
> > -	data->sensor_data[1] = chan_value;
> >  
> > -	ret = bmp180_read_press(data, &chan_value);
> > +	ret = bmp180_read_press(data, &comp_press);
> >  	if (ret)
> >  		goto out;
> >  
> > -	data->sensor_data[0] = chan_value;
> > +	memcpy(&data->buffer.buf[offset], &comp_press, sizeof(s32));
> > +	offset += sizeof(s32);
> > +	memcpy(&data->buffer.buf[offset], &comp_temp, sizeof(s32));
> I suppose there is a consistency argument for using memcpy even for the s32
> cases but you 'could' if you like do
> 	s32 *chans = (s32 *)data->buffer.buf;
> at top
> and 
> 	chans[0] = comp_press;
> 	chans[1] = comp_temp;
> here, which is functionally equivalent, particularly as we are forcing the
> buffer alignment to be larger than this s32.
> 
> Similar for the other simple native endian s32 cases.
> 
> The memcpy is needed for the le24 one.
> 
> 

I see what you mean, indeed I think your proposal will beautify it a lot!

> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> >  					   iio_get_time_ns(indio_dev));
> >  
> >  out:
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index a9f220c1f77a..b0c26f55c6af 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -419,7 +419,10 @@ struct bmp280_data {
> >  	 * Data to push to userspace triggered buffer. Up to 3 channels and
> >  	 * s64 timestamp, aligned.
> >  	 */
> > -	s32 sensor_data[6] __aligned(8);
> > +	struct {
> > +		u8 buf[12];
> > +		aligned_s64 ts;
> 
> I'd missed that this depends on the number of channels.  It makes no functional
> difference because the core code will happily write over the end of buf, but
> from a representation point of view this might be
> 
> 		u8 buf[8];
> 		aligned_s64 ts;
> or
> 		u8 buf[12];
> 		aligned_s64 ts;
> 
> So given we can't actually fix on one or the other normal convention is
> to just use something that forces a large enough aligned u8 buffer like
> 		u8 buf[ALIGN(sizeof(s32) * BMP280_MAX_CHANNELS, 8) + sizeof(s64)]
> 			__aligned(sizeof(s64));
> 
> Sorry for leading you astray on this!
> 
> Jonathan
> 
> 

I see your point. I can fix it in next version!

This is a neat issue here that requires indeed extra attention since
this type of buffers is used basically by the majority of the drivers.
Some type of runtime check in those registers would have been very
very helpful, but I can't see of an easy way of doing it in the core
code..

Thanks for the review :)

Cheers,
Vasilis

> > +	} buffer;
> >  
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) may require the
> 

