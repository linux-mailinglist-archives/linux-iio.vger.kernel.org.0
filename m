Return-Path: <linux-iio+bounces-8623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C689575BC
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 22:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8ED3B2145C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 20:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A315921D;
	Mon, 19 Aug 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxMmVr25"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC2158216
	for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099676; cv=none; b=YJss49tPO74WJf+Hpdk52d/6CtzTU/y5PptcPOV4AKtE2GFgzLoh9wDBqtqHDIEpFk2PerrUhnk32gdTQUKeiYhKoVvzm3kGoQlwzVfIrOTtH3/s44lMGAC3GioFktda/MpQWzEcZ0tUlVLxiBkTyoPMgc/KTOymqmU0w6FHqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099676; c=relaxed/simple;
	bh=T2D4ryfbzroCdtN1FKPCwgBlxjpG/gQQNZG7YCFPZ+Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAQ0UUhHd9eLXc5UAsCtU3OWDTL7zMBpOFxwAVW/Lrz/g4FIDLl3SWvqngzPCCNP2SFbqoThctFzLEj+QmyNF77qVfe7m2UUVB0vV+w4mM5IDO+7HrfTSNUWcO850PR3FjdJE0iRqfym1AZi0tAt0pKrExDuraS4oS6SIkA2hfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxMmVr25; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3718c176ed7so2156947f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Aug 2024 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724099673; x=1724704473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=887FbnROGG7RQIs9smA2yHX5eFjVKa9F7m14PXC2zn0=;
        b=kxMmVr25KaegU/9EmHKvKu70kqjEn6LID68lOwVxnIyF1c2ktZu9Q6R7LqS4gj41gU
         kBUOF5PuMXhkCDsiq53qBbf9oDQFKgCRAGHXOxgXugWl17C7OZQzrnIc0bCYFM4FOD9l
         SraPnp9I/+xz9G4t6xgRJgGrnmb7V9c/KlPMQN75aNVMgVGxw5jzpgN0n86en2mVGTJv
         +fGLRK3iGJW54VA5/7VD/QkhNM1ylmKjmntiWwYnPJhTHOchsiZPEwSpEAjcAbvuhUPq
         EKjxdMa5Im20KO4FDk6DobTpyqwh8nhNZtTY2akaJFuFpHs/FeWKxT/fXmhnaQdWoC8X
         yd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099673; x=1724704473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=887FbnROGG7RQIs9smA2yHX5eFjVKa9F7m14PXC2zn0=;
        b=TuXiiB9BUISJzAfXhfGy3etE/ezzEyaB6tDSvSoTMD0Y1z/pZISQv2S+u3RXSXvyzB
         jLthRpedMo+bjY1RHiCkMsTfcT44unFJNy0hxsnR3Kvgiwc0GioTrYMuPI5It8BTaGNU
         siBDuNp69QGWUwj0pm9MRZntqAMUvobz5MeeoYOGu5uDZAnxBySnluZd7DhnN6iH1DPm
         zn3ky/uyLkgAaxn8Uz7JYzxWiKicIJdDVYRAwwNvziNInC/HiDZtSingnMRPr3/E44uI
         JdqrH3g88EvYPSYOa2PDBozWuPekj2HOsi1wp7l0I2menrdr0FIf8urfzkr/VGHBQcbh
         lwQw==
X-Forwarded-Encrypted: i=1; AJvYcCX/gHxkrlYlJ6pkmy3iNQSuyeDv+oj1gQlG+VgTxGbZE39QMmD8OqjRxbxPg2PXI2vbYlZ+PP2T7cU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8X/8N0Gb2kXqtcWrL9UVSBPpOQU3t0ttsFiWUUi/5B46coqW3
	IRIcCadJamLcUo9X+sQ0epeV4PPC8FNtYI62PbvlSls2tlPsIVLh
X-Google-Smtp-Source: AGHT+IGil+5PPs8g3/FbZcA5HaQPSt7Ln5djUWjTvnQx6RLcI6GOoAhrN4abKuc/m0LN5rXwqsLe/w==
X-Received: by 2002:a05:6000:1b01:b0:371:8f19:bff0 with SMTP id ffacd0b85a97d-3719445235amr6327265f8f.20.1724099672365;
        Mon, 19 Aug 2024 13:34:32 -0700 (PDT)
Received: from vamoiridPC ([213.55.246.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabdesm11331284f8f.99.2024.08.19.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 13:34:31 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 19 Aug 2024 22:34:09 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: pressure: bmp280: Add triggered buffer support
Message-ID: <20240819203409.GA39099@vamoiridPC>
References: <73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain>
 <20240817154809.6aa725dd@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817154809.6aa725dd@jic23-huawei>

On Sat, Aug 17, 2024 at 03:48:09PM +0100, Jonathan Cameron wrote:
> On Thu, 15 Aug 2024 14:22:12 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > Hello Vasileios Amoiridis,
> > 
> > Commit 80cd23f43ddc ("iio: pressure: bmp280: Add triggered buffer
> > support") from Jun 28, 2024 (linux-next), leads to the following (UNPUBLISHED)
> > Smatch static checker warning:
> > 
> > 	drivers/iio/pressure/bmp280-core.c:2206 bmp580_trigger_handler()
> > 	warn: not copying enough bytes for '&data->sensor_data[1]' (4 vs 3 bytes)
> > 
> 
> This is a fun one. 
> 
> The data is little endian whatever happens (that is advertised to userspace
> which gets to unwind that if it wants to, or just store the data as is),
> I think the code is functionally correct, but we shouldn't really be using
> s32 for sensor_data (can't use __le32 either though as it's actually __le24
> + 1 byte of padding.  As it stands the code splats a s64 over some of the s32
> entries anyway so there is size confusion going on as well.
> 
> Right option is probably to make it a u8 buffer that is 4 times larger
> and fix up the code to multiple current index by 4.
> 
> That will get away from any pretence that this is a 32 bit cpu endian
> value.
> 
> Vasileios, if you agree with that analysis then please spin a suitable
> patch.
> 
> Jonathan
> 
> 

Hi Dan, Jonathan,

The code was not tested on a big-endian machine so I cannot say with huge
confidence but not only it is shown to userspace as LE, I think I have seen
similar practices in other drivers as well (maybe these are bugs though...).

I totally understand why we should make it a u8 buf, and I feel it is going
to be quite trivial as well. I will prepare a patch before the weekend.

Cheers,
Vasilis

> > drivers/iio/pressure/bmp280-core.c
> >     2188 static irqreturn_t bmp580_trigger_handler(int irq, void *p)
> >     2189 {
> >     2190         struct iio_poll_func *pf = p;
> >     2191         struct iio_dev *indio_dev = pf->indio_dev;
> >     2192         struct bmp280_data *data = iio_priv(indio_dev);
> >     2193         int ret;
> >     2194 
> >     2195         guard(mutex)(&data->lock);
> >     2196 
> >     2197         /* Burst read data registers */
> >     2198         ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
> >     2199                                data->buf, BMP280_BURST_READ_BYTES);
> >     2200         if (ret) {
> >     2201                 dev_err(data->dev, "failed to burst read sensor data\n");
> >     2202                 goto out;
> >     2203         }
> >     2204 
> >     2205         /* Temperature calculations */
> > --> 2206         memcpy(&data->sensor_data[1], &data->buf[0], 3);  
> >                          ^^^^^^^^^^^^^^^^^^^^                 ^
> > sensor_data is an s32 type.  We're copying 3 bytes to it.  This can't  be
> > correct from an endian perspective.
> > 
> >     2207 
> >     2208         /* Pressure calculations */
> >     2209         memcpy(&data->sensor_data[0], &data->buf[3], 3);
> >                         ^^^^^^^^^^^^^^^^^^^^^                 ^
> > Same
> > 
> >     2210 
> >     2211         iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> >     2212                                            iio_get_time_ns(indio_dev));
> >     2213 
> >     2214 out:
> >     2215         iio_trigger_notify_done(indio_dev->trig);
> >     2216 
> >     2217         return IRQ_HANDLED;
> >     2218 }
> > 
> > regards,
> > dan carpenter
> > 
> 

