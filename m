Return-Path: <linux-iio+bounces-19232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C6AAD8C5
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 09:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2516A3B579D
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3790227BAA;
	Wed,  7 May 2025 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XebVQJbY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60A220F5A
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603697; cv=none; b=jxE1bNJt5fdZ8jgINJ6Wn0mpRLszoGjAktEta8aBRYuwzwy4IHi0CT9xLXpJjPAtqOrngEXPdu0GN0KtKIMBr4CqzG0OUp0s+GcEhaJmRsSb4d4miBkouu9nKwScX9qUdPidasFHWAnPfRUwuzTVIID/qNb/zi6qvzvA4X24/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603697; c=relaxed/simple;
	bh=nlNFibk33ekXKB4LoLri6brIvfELZoIRxwjw3fyK/7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiS12mfzAZ13tyt2zeaQYxDRMWb/GlHAVsJkCV8B7EptLGnq+nZSwX1dBopyjCsSYRyZHZgwN9/7zWVikX7YXJ5oN3Qm1v8i1I6HP6WgZuEt+ykEGwdxsPmoOLEAtmVDxsHdCi6NTAay+YTDHQIXGhJiXH0DyrYefLocK5ymX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XebVQJbY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441c99459e9so24562785e9.3
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746603693; x=1747208493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7MzO50ennQ/hmxrQDSBIUwIrsLKUX4L+6meHxWofHU=;
        b=XebVQJbY9pjzXVMVmOOrD117UXnCpFedC2Wc9U8qaThSBBbMgDesWhX7E4tvc9KXvu
         8txrHUqvYHIUCnCR0A7EjdSIyBWzT80DkpvXxqhtKQYWWRD9tppvhECAcX/F73Os92OW
         VAYMQI1smArrVTroIPrrgmqnJ9izlUxLIDBVA911b1CzjlNjRdPQCieTHwhw/4v0q3E2
         v1ky6b7KLc63og9wH+YulPNQ+hvyak6pBPesYSebJPmWHIGUYUAVWTjg9N3nXN8XcDH2
         Y0NkeH83+cG2Kc1hKSLNxj51nnRv4pc9GbxeUIezWDk/RGMFAHQ1/DF2mMjb7mxQnwBK
         5HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746603693; x=1747208493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7MzO50ennQ/hmxrQDSBIUwIrsLKUX4L+6meHxWofHU=;
        b=Bdx79IGP6vJaSzC5Q9RRgbb0aR3eaFsrAvmh9TgnRrHJ1AWkZkAfDVd2d75iEeqgoD
         GufP+5JRCASFFvPS45wpoqa8Fvuu68dJjAaBtTjvh4X75ZaJ4beC4ppK5e408CW4tVBv
         FsbM00R8SpkKpSdeLz+TGRgtrfPRbgAr/2W5183+WkheTZQHeWwCEiIA2eLgUgqjp2EN
         wOc7YlUVQ0qEEm9wovY+E6SLqBP5pwGI4KhRetiQb8AogCbPqRqJqz5Efoa8IQYBzYxC
         463opZF7cwyLTkWrWfmliaX5mt3yVtaYFLCiYcpqOVoL4SZp6AHekeW4ngnBgzNrYppt
         uaYg==
X-Forwarded-Encrypted: i=1; AJvYcCUNZPKTNqaFn4KTi764vv1RAKa5MwkMMB+tqQ2b7drklP3oSiz58iWJNLAQxdKsFDvpHtYR6FE6HJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw721SiBATZgFy7zIOpdj43SBySpJolpZyUxcj9qKXhLOxqD1K0
	Z8zhQLguMv4H0stV0VroTmd0cAhtjb3AF7l/SliksOxVYPhwhhhJwb6nLbDboNk=
X-Gm-Gg: ASbGnctgepTwBeVvgSf8BQwDf+InJAWy4MgguOJYp2JTvHlR15kH9M1j1MEduFzzPnS
	KzccNYXQ9wtiGC0tIRXQVBR0bGRlS6flWdnWh90sXrluvlKLXb8wmnDQPrOAQQQMuPSkijmrjcK
	SjgrK2tNwBtuyaWJCKwSnAvvnRTnY658WtfQ7J4Ef4pqKEw6ebgG2HLYSI+c9VDaFbvmQoqUnIk
	4FRSm7j+uHoKEfYVZ3RIlhZTZazUF1pRlQkykGegm2ihZu4zsjs5xb8czo7XiyPNfT3BScji/Fw
	NPWNscG5+hKqWOLLOyMIDjhQPgVg/UDtINEVJCaIbhUOEg==
X-Google-Smtp-Source: AGHT+IG8K2Nu/Zd4CwKspRgTw5GwWv53wxpk8uGABxFhRnKMUv2tQbcK8YUcazno4+NcSqjDcdbYqg==
X-Received: by 2002:a05:600c:3ba1:b0:441:d446:b636 with SMTP id 5b1f17b1804b1-441d44e479dmr15763115e9.27.1746603692649;
        Wed, 07 May 2025 00:41:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441d43cb5ccsm22224525e9.1.2025.05.07.00.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:41:32 -0700 (PDT)
Date: Wed, 7 May 2025 10:41:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: pressure: bmp280: drop sensor_data array
Message-ID: <aBsOqAI0efLHGbeA@stanley.mountain>
References: <aBoBR5D1UMjsSUfZ@stanley.mountain>
 <487c81af-6604-4881-ae78-2d41ce23396f@baylibre.com>
 <aBpWXB8c8RSjYBtD@stanley.mountain>
 <FA0C8BC9-FD7F-44B7-A4A8-EA5E5BC6C8C7@jic23.retrosnub.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA0C8BC9-FD7F-44B7-A4A8-EA5E5BC6C8C7@jic23.retrosnub.co.uk>

On Wed, May 07, 2025 at 07:35:27AM +0100, Jonathan Cameron wrote:
> 
> 
> On 6 May 2025 19:35:08 BST, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >On Tue, May 06, 2025 at 09:25:00AM -0500, David Lechner wrote:
> >> On 5/6/25 7:32 AM, Dan Carpenter wrote:
> >> > Hello David Lechner,
> >> > 
> >> > Commit 4e6c3c4801a6 ("iio: pressure: bmp280: drop sensor_data array")
> >> > from Apr 22, 2025 (linux-next), leads to the following Smatch static
> >> > checker warning:
> >> > 
> >> > 	drivers/iio/pressure/bmp280-core.c:1280 bme280_trigger_handler()
> >> > 	warn: check that 'buffer' doesn't leak information (struct has a hole after 'comp_humidity')
> >> > 
> >> > drivers/iio/pressure/bmp280-core.c
> >> >     1225 static irqreturn_t bme280_trigger_handler(int irq, void *p)
> >> >     1226 {
> >> >     1227         struct iio_poll_func *pf = p;
> >> >     1228         struct iio_dev *indio_dev = pf->indio_dev;
> >> >     1229         struct bmp280_data *data = iio_priv(indio_dev);
> >> >     1230         u32 adc_temp, adc_press, adc_humidity;
> >> >     1231         s32 t_fine;
> >> >     1232         struct {
> >> >     1233                 u32 comp_press;
> >> >     1234                 s32 comp_temp;
> >> >     1235                 u32 comp_humidity;
> >> >     1236                 aligned_s64 timestamp;
> >> > 
> >> > There is a 4 byte hole between comp_humidity and timestamp.
> >> 
> >> Yes, this was the intention of this patch.
> >> 
> >> > 
> >> >     1237         } buffer;
> >> >     1238         int ret;
> >> >     1239 
> >> 
> >> ...
> >> 
> >> >     1279 
> >> > --> 1280         iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
> >> >                                                         ^^^^^^^^^^^^^^^^^^^^^^^
> >> > So I believe it leads to an information leaks here.
> >> 
> >> Aha, so we should e.g. do memset() to fill the hole first.
> >> 
> >
> >That works, or you could initialize it with = { }.
> 
> I tried to track this down the other day.
> What are compilers guaranteeing around
> that vs { 0 }  and holes?  The c spec has only recently standardised on { }.
> 
> I'd love to stop using memset for these.

The rule in the C standard is that if the initializer sets every struct
member then it will NOT zero out struct holes.  But if there are any
unset struct members then the holes are zeroed.  So = { } will always
work.  You really have to try hard to invent a scenario where = { 0 }
won't fill the struct holes (a one member struct with a weird alignment).

regards,
dan carpenter


