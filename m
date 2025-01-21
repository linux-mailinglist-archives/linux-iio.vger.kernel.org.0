Return-Path: <linux-iio+bounces-14513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA847A17A49
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 10:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0371882D0E
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C6E1BE852;
	Tue, 21 Jan 2025 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ0YBdPb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0251B0F26;
	Tue, 21 Jan 2025 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452169; cv=none; b=sZ0KY+QkGbaq4r5WkxaqQ01KqEidlBob7IAKwgR7zqZFSUsEBmqwqMOygjDe8KQVVl7cCcg99Gl+/H1M8mhrzPI3CWeoPprKaOwxl1bjLrTEMTSqgziuwTKKDz2INUfwcnIB8sq49Y7w3OupT/uci3AU6FTQcY/Kxqv6y+PLSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452169; c=relaxed/simple;
	bh=xv82Gy8srfNrSdfRWIGTWpjsRtutmqngBc7kvjsea78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa481MBLlc7A531uEwCcJsO97NJs1F5PM9/7/hjCnKY9yM5lDtXNIi+5VYVx1F7nLxWCXF42ow52zwQFw1EsacqBOvfM3X2o5FKOfn516FkgveMxxRTJ4eLgtgOdx8uJ3Rpx6xBmkLY5cOFCTv0sMelTCHarOn6CNrOQPf38nrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ0YBdPb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso38227905e9.2;
        Tue, 21 Jan 2025 01:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737452166; x=1738056966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkvB3FM1BFrlTq15XnB6ml9KIxf85scgQ/CXNm/OOo0=;
        b=NZ0YBdPbszfi1fJRQGGIY4vpCi8J844KvBm7XpZdnOoDtZOu+QQVLB33AswjZsY27c
         J6D5Ou3zjPW5eaXJ69/wQ6m+stkEfOnhhWCTDC+0U6IZv8BtM9vtoXob8N363WdgaHRf
         l1KYfc2RhrZWubyHrJtkRaWTHjk8cGgnxqW5vwpJBqn2cB0WErh8zZyHBVhqI4cUQsOG
         xYWWbDRr0JKyRha5UZzC8QO2K9t1k6QDrfhScAArbN1J5RK6NyaFRUxue8YMORXJ4W8x
         5DwadUvZB6GNRmayPOeO/23s5hfgUxCysZjdB2rojO2Bnw3VRL0T281tzFaMKyXNOxgS
         qTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737452166; x=1738056966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkvB3FM1BFrlTq15XnB6ml9KIxf85scgQ/CXNm/OOo0=;
        b=j98reqwYKLKdybF2Pj/ty4eO1DVf7i1ccZExAiIo4+H43a+CTGqkVfQOuqGouV+/65
         Bs0azgWxE3sCdfunykSd0Cawg3krUeCqyCWYNxjGH9+UaY+1uM0itHkQpWoh1Bd77Vft
         WIDldfUVDWZowacZBrhM+VN1vpk/xW0AKzf3qRdVrS6h1EL89KQWduOgKqzCcxtQsmmN
         8p/zx/vwQirDsqo1w778Aa3CQTOfxn3dJ0Zc8PoHngD8wpdH1MgdPtu8dMVqkURxRkM5
         GlXJIfGKZ9jWS3gBQwn9MVtzzCENNANlsA4VJxjJs8nHeh/dyN1tZsG2ir/p0amV2AW+
         TcLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSDhRKpzopJpxazjOUosuYQrOd9KcL7I7OtalY1qwrS807cMDESrnmzftxh4SJds+hde4p/if/MtVg@vger.kernel.org, AJvYcCXE9gfVWFtey/6iGgT5wfd0hE7KDqV79eIpC3z4wDDSb0SUni66W3iCO9xJF6rnlljYpFluaD0Voupv@vger.kernel.org, AJvYcCXcfgzSJt8L2VyOtGLJO4Lnc2xFBvNqb2rauWSJfupHqPRDzICFWlTSMjd85GE5ZfO5agGgWupehwKQAHKu@vger.kernel.org
X-Gm-Message-State: AOJu0YyTUis+wS8gf/qkatiX4cwTIhqsxGilWUmJbFNdkPuzFw3p5kG0
	asI7oGgVi8w2+c6HjlvE3rJTXipZ8iG5roYNd/q5ZPpvUh1B7HzpVX4a6g==
X-Gm-Gg: ASbGncuV/lC9FQnleASTDUEZaaVWo5zqF7L+YzON3n2Dh/eI4gHJYSfaOMz1XMDi459
	pRWhL7TAVPEon1loFeblLe3PCzxDd/PqsLm7VoHYvnmUYCIhyedPPuQiBy2iUtRieHVDZwrRhyz
	sA02b6qtYtClKGDWeG8JQ9FmeU/hjHssUtQ2yXQB+wyRyTZZkD3cf8mly1vHnBL7/iYB2bemar2
	ASYPhEA5hX2l0cwT+hciL15b8pOy0oFtf1VqaaL52md3EiIaoHu7/eaB1S/6w==
X-Google-Smtp-Source: AGHT+IF4I9AQcVefA/oF39uEIdF1h6n4YSH/0lVz0d8Lffi9Z+NwS2ID4VFhZha8c/LZ5yxfZRCHGQ==
X-Received: by 2002:a05:600c:3593:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-4389144eea8mr177156205e9.30.1737452165562;
        Tue, 21 Jan 2025 01:36:05 -0800 (PST)
Received: from spiri ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753c617sm233228395e9.37.2025.01.21.01.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 01:36:05 -0800 (PST)
Date: Tue, 21 Jan 2025 11:36:02 +0200
From: Alisa-Dariana Roman <alisadariana@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] iio: adc: ad_sigma_delta: Add CS assert function
Message-ID: <Z49qgvy0ZVKJ0h0W@spiri>
References: <20241221155926.81954-1-alisa.roman@analog.com>
 <20241221155926.81954-2-alisa.roman@analog.com>
 <20241222180713.64f27040@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241222180713.64f27040@jic23-huawei>

On Sun, Dec 22, 2024 at 06:07:13PM +0000, Jonathan Cameron wrote:
> On Sat, 21 Dec 2024 17:56:00 +0200
> Alisa-Dariana Roman <alisadariana@gmail.com> wrote:
> 
> > Some sigma-delta ADCs, such as AD7191 and AD7780, have no registers and
> > start conversion when CS is asserted. Add helper function to support
> > this use case by allowing devices to assert CS without performing
> > register operations.
> Hi Alisa-Dariana,
> 
> I had a look at the ad7191 datasheet. Given this description,
> I was expecting to see it do a pre pulse of the chip select to trigger
> the acquisition.  However, what I see is a power down line (which is more
> or less a chip select) but it just has a specified t1 delay before the
> DOUT will change to the state for the first bit and the host
> can start driving the clock.
> 
> That can be done by setting spi_device->cs_setup to whatever delay is
> needed.  The text is spi_device docs are a little vague,
> but I'd take it as t1 + t2 (maybe t3 to be safe).
> 
> That is going to be more reliable than trying to hold the cs across
> messages / spi_sync() calls, particularly if the bus might not be
> locked (which the code below suggests).
> 
> Jonathan
> 
> 

Hello Jonathan! I am grateful for your and everyone's feedback, as
always!

I got a bit stuck on this part. The motivation for adding this function
is as following:

int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
	const struct iio_chan_spec *chan, int *val)
{

...
	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);

	ad_sd_enable_irq(sigma_delta);
	ret = wait_for_completion_interruptible_timeout(
			&sigma_delta->completion, HZ);
...
}

I noticed that adc drivers need to call the ad_sd_write_reg function in
their callback set_mode function, in order to keep the cs line pulled
down before waiting for the interrupt (if I understand correctly). But
since this component and AD7780 have no register I just copied the
functionality of ad_sd_write_reg without actually writing anything.

Should I change the description/name to more accurately present the
functionality? Or would it be a better idea to not use the single
conversion function and write something from scratch leveraging the
cs_setup?

Thank you!

Kind regards,
Alisa-Dariana Roman.


