Return-Path: <linux-iio+bounces-21767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A86B0AB56
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 23:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AA0AA1F2C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51142192FA;
	Fri, 18 Jul 2025 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAVdk8dE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D5C2C9;
	Fri, 18 Jul 2025 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873535; cv=none; b=c/1BqxydOGX650IPBEIJek0YXRWZ52P0JoxxadX8uTQStCurb85dTE8jGJvAjzd2v09vZQ3Q6DorCG+6vlG/CSa5/3BWE/YUfzQ3GcmdP4bxFXPV6BkfkmJ93rDTx3vQtr11Z+QlYqNjwXb+92bXFF1FKzB7uvuaVq+nMBoyBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873535; c=relaxed/simple;
	bh=fWPyLr2u0e/upu/Qc98ELRPuwmvoHvniezdOE0ovjOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQk0eeNEZQdn1kHa20DuWnc3Hfr7qgraN5iqvfNvTE7mMu3kmj1S/ZWSY8U+FVOFdY9SBTIo0+biDrLwdczSH+v37dqIM7UmVrHGYowXZ1DAwPywzlcKV1n7zHbYLaph2W3Can7PBKk+X8FtbFZ8/wRcUerOK85mOgat5K61GMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAVdk8dE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-455b00339c8so19040435e9.3;
        Fri, 18 Jul 2025 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752873532; x=1753478332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv8zMOirvwvGeIIrS8G65KegHf3y7D5W5iCC493QCh0=;
        b=gAVdk8dEoch/mt2Uu8eyZFa+lgKEOqo6h6Q/Lmzt2KYSV1TNsHSGMaPdzZ4SGKNJbL
         rf+FpHyXM6r5lDoVAzjmpsWZ2d7fFtu6QSVqgYoY1WxXIOQXy69aIAuhEnJkVv9YJ0ma
         Lw8x69cDcBwV1b0ZkaObcjNmgW6B2zTX3V0l7WAFrIIgX67Pn9tjIrLyVwsOYHcZU/E3
         6UPSNJx8U2mgnsajI0O1PniULMhuncIRiJl7UBrK3pKkcd7f4M9t9xRzPOTqDkeR+15M
         cDRrDendnfpX6DH/3kU1Y7h9U6iITTx3MNmZPoNUYn0baYPTRvekPgpxjs3GTrPDsJL0
         Pmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873532; x=1753478332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lv8zMOirvwvGeIIrS8G65KegHf3y7D5W5iCC493QCh0=;
        b=hJzyTmVBpoTkuqHA48PFxcg7kVYyAXkCNsD+IQWRH3MqQR0blgOv7K8QtoktFFw09A
         8+9Dt2Fmk1gP8HXKUn0BwInWXA9O+NEal78UTOxZvrpXzUStocAEfn9FYnryMp2p5Cwt
         OziY5VxWncmOWQndWIHMIYPuz8D4P9+/fqsM0ky1jstnQeBWpVb8XtnbRximK1O8uztQ
         8jgxvcMqHYoyraT82vxF6RUIz5uZhL/KlZclK5sLo08C5/gapeyP+ToDxmKWcdleGje/
         M2eRjrHvysRvaPaVPH2NEIEZkSyvQBbuRW1xdIh4cMhuBL9CuILsaZ3Owa5YOOzFLqiM
         TU7g==
X-Forwarded-Encrypted: i=1; AJvYcCXFx5htwTk9f+P9OGKbl/reSAhEpm5K7xBgj5HxTOuQV+LaqCIybkx0e+vsVDEunUQp7CCBYlarwno=@vger.kernel.org, AJvYcCXgYJbPRCGptMRdrYvUT21C4exN5q6UBXNxaKpBa+uwlUhJoC3q6hCxZt4oUcQhG88vYFsBUp9ard9lyyiA@vger.kernel.org
X-Gm-Message-State: AOJu0YyAoz96nk4VNcHfBsByQAWhq3d/mr1riy9uS7CCwbRePTKOmkTl
	88uJqgkJ975K0mF58rR4qqN0Vk3LbOUHjJTs56aacyQTQWCr/lCjuWfB
X-Gm-Gg: ASbGncttCjH1lVbABOETt9CTLiY3xSS4jxzcmYzDPfMWHcCjkZEUlxf9CQ1K94Hshw8
	g/+o4PJZQ4JveQ9y8y9cBz9NWg/sh1V/A+zS9klnJHaSQm+/HP9QN7nO8Y1fFFWWgZmITK4yL9C
	YT/O+QWT2CZbsLiRv2MOoeS9tMm+Hy83+jZ0Eeh6E/Rb/0BnLhg2c4XR0ZjpOXTsqBzS2HtZl8R
	5Xe+/L41iiwylBHYjyxyiIDN6JlRuZjm5SupZcNv8tC3pthaNaRpBJd/cYajnBesE+S1hFBVlVA
	tB4OCK46WZ8uaR6nJqztx8J6xxEvDYVSGUnITgDvSbVwoc0FV/mDAQd6ZxXwpu9uOHj8GeQwTaK
	4ESWxLLpemHD++/bYAHt8PYIs7lSGxfJZTA73Pk3mrz7HfxKfbFpQAulJ9VAwCgXRfQNRgK8=
X-Google-Smtp-Source: AGHT+IHLW11lHbgsOO5isXja+wIRHQxH3gL8kHNDXGYklnoRUieezkTgOpouBBwFNC5AerCk31FDzA==
X-Received: by 2002:a05:600c:a316:b0:456:2066:5747 with SMTP id 5b1f17b1804b1-4562e3411b3mr117824475e9.10.1752873532053;
        Fri, 18 Jul 2025 14:18:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c308sm88278035e9.30.2025.07.18.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:18:51 -0700 (PDT)
Date: Fri, 18 Jul 2025 22:18:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: isl29501: use scan struct instead of
 array
Message-ID: <20250718221850.614d05b3@pumpkin>
In-Reply-To: <20250713150445.3965931c@jic23-huawei>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-7-v1-1-a3f253ac2e4a@baylibre.com>
	<20250713150445.3965931c@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Jul 2025 15:04:45 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 11 Jul 2025 11:18:13 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > Replace the scan buffer array with a struct that contains a single u32
> > for the data and an aligned_s64 for the timestamp. This makes it easier
> > to see the intended layout of the buffer and avoids the need to manually
> > calculate the number of extra elements needed for an aligned timestamp.
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> Why are we using a u32 here?  It's a 16 bit
> read in that isl29501_register_read() call
> and storagebits = 16 in the chan spec.
> 
> So to me looks like you found a bug for big endian platforms.

Maybe not - it looks like there is a read on one place and write in another.
Both are passed the same address.
The interface looks very strange though.

But the updated code is writing uninitialised stack.

	David
 
> > ---
> >  drivers/iio/proximity/isl29501.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
> > index d1510fe2405088adc0998e28aa9f36e0186fafae..0eed14f66ab700473af10414b25a56458335b381 100644
> > --- a/drivers/iio/proximity/isl29501.c
> > +++ b/drivers/iio/proximity/isl29501.c
> > @@ -938,12 +938,15 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct isl29501_private *isl29501 = iio_priv(indio_dev);
> >  	const unsigned long *active_mask = indio_dev->active_scan_mask;
> > -	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
> > +	struct {
> > +		u32 data;
> > +		aligned_s64 ts;
> > +	} scan;
> >  
> >  	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
> > -		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
> > +		isl29501_register_read(isl29501, REG_DISTANCE, &scan.data);
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
> >  	iio_trigger_notify_done(indio_dev->trig);
> >  
> >  	return IRQ_HANDLED;
> > 
> > ---
> > base-commit: f8f559752d573a051a984adda8d2d1464f92f954
> > change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-7-880ddf1d3070
> > 
> > Best regards,  
> 
> 


