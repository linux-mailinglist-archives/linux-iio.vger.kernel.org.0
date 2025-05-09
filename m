Return-Path: <linux-iio+bounces-19354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C16AB09E5
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 07:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C101C048F2
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 05:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA91264A88;
	Fri,  9 May 2025 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVmdtCpt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBC139D1B
	for <linux-iio@vger.kernel.org>; Fri,  9 May 2025 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746769778; cv=none; b=Jc8yaVgNWGc75DFE28C6XWHujRJZJ22kCc+XgHmAk0uEmKlSNAeVjSQx8PzL9ZHsRKlx+Vq7WFlVmwSilq663sqvfvRjJv+OWNorv88YUlItX4ACGPvbKa9GXFUuy5XmO+DlMhkJ5gmUAQlZH3ms32bki+xyWcLsmHcJw0RTx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746769778; c=relaxed/simple;
	bh=TKoz57ysCEo9XOy8aD4ASdaGQjbcXNqZWrW8tTQuIXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs4I7eeFOS5rF85gxyUqGUTs5QgKg7Jp09vOkNQAxmhJbdZNNUBgCnqb7c9awYgkXLTYqDHW39Rjtbl5lJSXfaaEfzP/r1WjY/sL/J2OcThejEcB47IwSs3otOYaxn83DPBMGJb5QcezmEmefZorv8CFiUtdy9cwOXyYLKGki4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gVmdtCpt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso15581745e9.0
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 22:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746769774; x=1747374574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzhQr5kWEBujTn6Y48RSivQt6QyQF2sM4VOR/B62Ao8=;
        b=gVmdtCptJ0siWsvTiIsM3zu43wxT4wV8ZkkYlMPZA/j6OQEO1hx/RyaXxXZOQYOYPR
         5j0jAOJIofY9b7QTE7Wiwq9G7rpngXyKBLK4pSN8EozO6gofmvoYGNzyLrjJKwswtSZq
         7C7Qyan420KjW0wSUFX2AboKCri7q7CgIHb7JA5LGQMj7KMbbqnMnyLfU5zhj3+nIe4B
         MOI5pXvpn0QVfJ5iPlPRQh7q6+T+iHOOd5RqHF1/xqRmeVwDQ6X1V/k1OpNhNgMDFJJI
         i/Opml9oGBj4u649vrmBInss7dEWroNYoK/YtA00ceviDIoixwN0f7voOtrKjWxOJA6G
         c4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746769774; x=1747374574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzhQr5kWEBujTn6Y48RSivQt6QyQF2sM4VOR/B62Ao8=;
        b=AJ3eIAmAPPyKyWNQ5xOS0N5XU8nImMp3aQ5A3HuXx83+O/3hddi5Ol6N9QL6g+aE6S
         85g4vD6GqXHwQoKo1/6nZqdN6NYhRZCItjnqe0WoAfV1fNV5dsov35gQaIKYx0yFPfh1
         BPSTmtqUhWLjxuSfDwU6eSn6GUMfqF2VSH+5uClvaNPgbxU9b9z58TQ1sZqsk213AeM2
         Wrml6FAa8WXL825pn2ae8yXir0wqZ84Hn+V5s9XbLFekpI7HIBE2jvxIf1AnJYdN7Ruk
         oULoqXFfrjfYo7wnIiF5ZWdJ7jQCnIZ/3NyRXrAXRyIO5OewA3LdB3t4ZH2LJxNLuS7J
         eN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPfbZV5roaMHJd/kIBUCHRZFKbeWb3MZHyDeDRpMQHEO6XJ3psy7Hvzj7b9qDTtqwyz3akpbhCEyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItgVBLftkfeA42Bp+ACCm1+pCnSiA9bNJ8XNNiTd+nDAeohNP
	fOnqWEexVYCE763+iJxgLnwYrdFGsor7ag5JaQ5WAfMFPERMyHrK7I31cLs57ok=
X-Gm-Gg: ASbGncsCsbMHJ60nmBWLZU9Hzk4lLdvr3PMH2mOSzbrsDWo0qEI0IdLhqDQkY/uvIXM
	h391mHTXS4S+se8rtsCGTbQobkQBse2HBs+WWk2M5M7jzb9X+m1EP+VrNxi9/hSUmmATK6Dvk6q
	JI/Yv15gZzxVp6v7j7gEX7rS2/B7QxgwT91zqj/YfLz8zDqVU435gzhBInr/qAqsEcan2IcnXpG
	bbe4L7v8i/UHold5NsRholWk/fyABDKs15a5LmpWS+sDPQVKa6fr6nxQw39XiTlpLyRuDjANcBh
	AlZFEaBLkI8qOrSi6TZpgP7XGKlAr3J1EEjuGPYgWpxuYA==
X-Google-Smtp-Source: AGHT+IGlJyjo3MoLYPD+8SnXoFUWfJ11tIPZgwrK3/nAD/W6esWQ0uf6k+jpoLlbVmTBtEyoFWX+aQ==
X-Received: by 2002:a05:600c:34ca:b0:43c:f8fc:f6a6 with SMTP id 5b1f17b1804b1-442d6d37115mr16446285e9.9.1746769774579;
        Thu, 08 May 2025 22:49:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442d6858626sm17749105e9.27.2025.05.08.22.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 22:49:34 -0700 (PDT)
Date: Fri, 9 May 2025 08:49:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	linux-iio@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [bug report] iio: pressure: bmp280: drop sensor_data array
Message-ID: <aB2Xam2JQ_eU9Bat@stanley.mountain>
References: <aBoBR5D1UMjsSUfZ@stanley.mountain>
 <487c81af-6604-4881-ae78-2d41ce23396f@baylibre.com>
 <aBpWXB8c8RSjYBtD@stanley.mountain>
 <FA0C8BC9-FD7F-44B7-A4A8-EA5E5BC6C8C7@jic23.retrosnub.co.uk>
 <aBsOqAI0efLHGbeA@stanley.mountain>
 <b85aa946-aa5f-40aa-8d22-19a9d916f5a0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b85aa946-aa5f-40aa-8d22-19a9d916f5a0@baylibre.com>

Let me add Kees to the CC list because he'll want to know this as well.

On Wed, May 07, 2025 at 08:33:07AM -0500, David Lechner wrote:
> On 5/7/25 2:41 AM, Dan Carpenter wrote:
> > On Wed, May 07, 2025 at 07:35:27AM +0100, Jonathan Cameron wrote:
> >>
> >>
> >> On 6 May 2025 19:35:08 BST, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >>> On Tue, May 06, 2025 at 09:25:00AM -0500, David Lechner wrote:
> >>>> On 5/6/25 7:32 AM, Dan Carpenter wrote:
> >>>>> Hello David Lechner,
> >>>>>
> >>>>> Commit 4e6c3c4801a6 ("iio: pressure: bmp280: drop sensor_data array")
> >>>>> from Apr 22, 2025 (linux-next), leads to the following Smatch static
> >>>>> checker warning:
> >>>>>
> >>>>> 	drivers/iio/pressure/bmp280-core.c:1280 bme280_trigger_handler()
> >>>>> 	warn: check that 'buffer' doesn't leak information (struct has a hole after 'comp_humidity')
> >>>>>
> >>>>> drivers/iio/pressure/bmp280-core.c
> >>>>>     1225 static irqreturn_t bme280_trigger_handler(int irq, void *p)
> >>>>>     1226 {
> >>>>>     1227         struct iio_poll_func *pf = p;
> >>>>>     1228         struct iio_dev *indio_dev = pf->indio_dev;
> >>>>>     1229         struct bmp280_data *data = iio_priv(indio_dev);
> >>>>>     1230         u32 adc_temp, adc_press, adc_humidity;
> >>>>>     1231         s32 t_fine;
> >>>>>     1232         struct {
> >>>>>     1233                 u32 comp_press;
> >>>>>     1234                 s32 comp_temp;
> >>>>>     1235                 u32 comp_humidity;
> >>>>>     1236                 aligned_s64 timestamp;
> >>>>>
> >>>>> There is a 4 byte hole between comp_humidity and timestamp.
> >>>>
> >>>> Yes, this was the intention of this patch.
> >>>>
> >>>>>
> >>>>>     1237         } buffer;
> >>>>>     1238         int ret;
> >>>>>     1239 
> >>>>
> >>>> ...
> >>>>
> >>>>>     1279 
> >>>>> --> 1280         iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
> >>>>>                                                         ^^^^^^^^^^^^^^^^^^^^^^^
> >>>>> So I believe it leads to an information leaks here.
> >>>>
> >>>> Aha, so we should e.g. do memset() to fill the hole first.
> >>>>
> >>>
> >>> That works, or you could initialize it with = { }.
> >>
> >> I tried to track this down the other day.
> >> What are compilers guaranteeing around
> >> that vs { 0 }  and holes?  The c spec has only recently standardised on { }.
> >>
> >> I'd love to stop using memset for these.
> > 
> > The rule in the C standard is that if the initializer sets every struct
> > member then it will NOT zero out struct holes.  But if there are any
> > unset struct members then the holes are zeroed.  So = { } will always
> > work.  You really have to try hard to invent a scenario where = { 0 }
> > won't fill the struct holes (a one member struct with a weird alignment).
> > 
> > regards,
> > dan carpenter
> > 
> 
> I was curious about this too and came across a blog post [1] that claims that
> with clang compiler and certain optimization levels, { } and { 0 } still aren't
> good enough, which is why I went with the memset().
> 
> [1]: https://interrupt.memfault.com/blog/c-struct-padding-initialization

Huh...

"Strategy 2, explicitly setting each struct member".  This isn't
"supposed" to initialize struct holes according to the C current
standard.

It's discouraging that = { 0 } and { } don't work.  -O1 is not supported
in the kernel so that's not an emergency.  I don't know about -Os?

regards,
dan carpenter


