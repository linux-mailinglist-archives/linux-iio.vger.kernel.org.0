Return-Path: <linux-iio+bounces-11637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E03A9B694E
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DBD1F21DE2
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDAE21503C;
	Wed, 30 Oct 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPSJb58t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C9B215028
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306198; cv=none; b=ZSUo5qv4B6aUPuT7CaMKRERFsYutTndwcEwRPsXLZEHhDBDZCtjuOZQlrANNLggycl4d7B9j/hyT7WFGwMqj6sLWuwA0rBMEO5SnGTUw5YbIhaviWi+JdfWeCW+58QjymeRVEnaTxlatJVIgoVsEglvdXKtUl1YM9q0HSwfFRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306198; c=relaxed/simple;
	bh=mcvGsAAt0BpqMl0lsLrmemSUVznYCC0gDwdN6bDmvbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdnvzLG7ply79jTpTRJ+vTASEm6uB77sLTkRiylH8j3ku3MIQVBlLbXFlGx7amJ2WlC01XFOnKjHNcyepxGseIOiasloJXWFNqJpwW54yzUH5T1Q3z7cSRPki9p110jaOwEmz7C+x7RoLQIXLg6yajP8McyxR7sPudyDGAIbVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPSJb58t; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316cce103dso84715e9.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730306195; x=1730910995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqIz+RSYKJSJYxiDVntU4na0bRDHjCVeXRo7S/VG92M=;
        b=TPSJb58tDE7wfzJP9fob+2KUfC+3qHdu+X606VUm6qcaF9opaZlY8MQUtG+Aam2D5S
         Ak6WyJytSjzcywlwNOwCiC1YOotPKDV2qe4HlH/r9oTZ90V016aZkYbfeXXOrGCqXMa2
         rv/9EhHQ8YiaZchx2aHWkeb733BKHhhQzCtrtLgbUxCeQkWyEOnSPwZuM/Yw+VH/w5ut
         1r+V1npdsqIr1znXUB1ccuvyQLBTHzWheJbY6I+yYhul7b4YnyWHoww7456CmnPu9TKx
         3bOizbKmZQeGNSc6dTNvWN274gmam4cdlHrd2M7sBhYwzemtor7M3IptJ7L3h2MjCyS6
         +opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306195; x=1730910995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqIz+RSYKJSJYxiDVntU4na0bRDHjCVeXRo7S/VG92M=;
        b=ngQtxf0yaZ/VgyQYDzKKuBewbQIUnqemZ128WIL8Xv1lmUQdBzKGBufys5vALDFJIj
         VVgnVBfuZpuwiFbLfhspcBFdPvtUMR6ZhoHnMsb6RQ+mUt6YQuv7fUNomoVTa3XGOBrr
         OGH7oKgAAy8qBGMcoNTEfzcKuKX1tR0JRaN715GJMFwYxpCiWDHwQliMK/drscUETV3u
         JddY9Z0dJLCcwDH9wxVCUIR0ELXiMCS50AQbpFxYiIu2T0CZE6Mwb8+donEQj0NwwTff
         8Z+tFaqDpG/eAVydKSgaAm67VaW0+e1Yb/mJdIA9VvvYyjfBqaJEvs53BitzBJZrCrFh
         9gaA==
X-Gm-Message-State: AOJu0YxuBJIMNxR62Of/6zspEhxuXbulDL01UdW0k/mYpBzVORXgSrC/
	kIFSge1k65VFXNgVtNvdSD50zkTY1sRwKHlXyVcbwQ545LuB1kmyelZLsQ==
X-Google-Smtp-Source: AGHT+IFrcig48O1z7h5rkpxFmp+cUsT1s6D+Z/s4NwVavR0CoK1GaTklSnZz5wA6r+tHcp3hWpOAMQ==
X-Received: by 2002:a05:600c:4ecb:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-4319ab8cbfbmr172951875e9.0.1730306194626;
        Wed, 30 Oct 2024 09:36:34 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e7d23sm25936025e9.7.2024.10.30.09.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:36:33 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:36:31 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: chemical: bme680: generalize read_*() functions
Message-ID: <ZyJgj_E3qXw-Vj2C@vamoirid-laptop>
References: <13f764f7-4cc4-4563-81f6-0393732729a6@stanley.mountain>
 <ZyIDKdX7NKopqT4W@vamoirid-laptop>
 <7c694cba-9444-415c-ac6e-458cdd600ae7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c694cba-9444-415c-ac6e-458cdd600ae7@stanley.mountain>

On Wed, Oct 30, 2024 at 01:47:20PM +0300, Dan Carpenter wrote:
> On Wed, Oct 30, 2024 at 10:58:01AM +0100, Vasileios Amoiridis wrote:
> > On Wed, Oct 30, 2024 at 12:26:13PM +0300, Dan Carpenter wrote:
> > > Hello Vasileios Amoiridis,
> > > 
> > > Commit 9b4071ab8cbe ("iio: chemical: bme680: generalize read_*()
> > > functions") from Oct 21, 2024 (linux-next), leads to the following
> > > Smatch static checker warning:
> > > 
> > > 	drivers/iio/chemical/bme680_core.c:760 bme680_read_raw()
> > > 	warn: passing casted pointer '&chan_val' to 'bme680_read_temp()' 32 vs 16.
> > > 
> > > drivers/iio/chemical/bme680_core.c
> > >     738 static int bme680_read_raw(struct iio_dev *indio_dev,
> > >     739                            struct iio_chan_spec const *chan,
> > >     740                            int *val, int *val2, long mask)
> > >     741 {
> > >     742         struct bme680_data *data = iio_priv(indio_dev);
> > >     743         int chan_val, ret;
> > >     744 
> > >     745         guard(mutex)(&data->lock);
> > >     746 
> > >     747         /* set forced mode to trigger measurement */
> > >     748         ret = bme680_set_mode(data, true);
> > >     749         if (ret < 0)
> > >     750                 return ret;
> > >     751 
> > >     752         ret = bme680_wait_for_eoc(data);
> > >     753         if (ret)
> > >     754                 return ret;
> > >     755 
> > >     756         switch (mask) {
> > >     757         case IIO_CHAN_INFO_PROCESSED:
> > >     758                 switch (chan->type) {
> > >     759                 case IIO_TEMP:
> > > --> 760                         ret = bme680_read_temp(data, (s16 *)&chan_val);
> > > 
> > > The bme680_read_temp() function takes an s16 pointer but we're passing a s32.
> > > This will not work on big endian systems and even on little endian systems, we
> > > haven't initialized the last 16 bits of chan_val so it's an uninitialized
> > > variable bug.
> > > 
> > 
> > Hi Dan,
> > 
> > Thanks for letting me know! What I could do is instead of reusing the
> > int chan_val, I could use a local s16 temp_chan_val so there is no need
> > for typecasting here.
> 
> That works.  Not a fan of the name though.  "temp" means "temperature" and "tmp"
> means "temporary".  chan_val16 perhaps?
> 
> regards,
> dan carpenter
>

That's the reason I used temp in the name, because we are reading a
temperature channel in this line.

Cheers,
Vasilis

