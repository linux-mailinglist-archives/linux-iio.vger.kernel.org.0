Return-Path: <linux-iio+bounces-8921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC89672B8
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 18:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AF01C20F5B
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 16:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9456450285;
	Sat, 31 Aug 2024 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUVW+Mq5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1121F95E;
	Sat, 31 Aug 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725122563; cv=none; b=jCakv9PTXsk4jo9NoaygFIVbLn8kvRE+VG7PHRy3M+XLqw6s+NaoEBQmFk9uwBCmuw+tflMcWS9dHV47C7U1zP1VBz9zxR5AJJuZiEfWklAFRGyMos7CBlbdTdKk3M8AwSC1yoY+1wA6lIrFRArhPHq7cFEibWL2IEpSJLqS+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725122563; c=relaxed/simple;
	bh=5nxftlw36WRCH7hhubmyp9Fr8vyJ3JvaNgYOtKPsxbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzFuYeUD7S5ZTQPVawGk+fW1hLzI3haBJKXGYwMP3clWQ+6ZKZ6CtaTOnSCAT9IoEofc+2hoMRGwJKZE5NlSZv/UoXm/94nNu3Si9w9caSYySGuLtsaWFra+oOB7HWJPuSPh3jTg05G56jhoV0y9sOdHKdZl+P2PpUBhMMSYJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUVW+Mq5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so29482421fa.2;
        Sat, 31 Aug 2024 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725122560; x=1725727360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KilWTuBK/UXyi+ZAcZMAHfDF1J3qSDvycaldNcwXGN4=;
        b=bUVW+Mq5naX3Hc1UCV6ek7QUt2QhVwtYxZ9oE3qNkf5GtVARwPoirmdjSL4U641vX+
         VGU5/QTuN6agX/vM9JLaWl1rSIfWZ25Fs8OUA0PFuEPqpjIK2XGGuCSce/3BH6cEQu05
         HitT1O31zd4dJdMGzboNB5BddLIFyHGXgdqhj4+CgDltxP8feiYyKucY9gQWYseQ34g7
         jW44Hh58ppJQXU5s/ipNfd6n4GeTJQqh4dp586vW8J0+gl8dO+zz5vekB8BmRCZUhHu1
         I2u17Ii/ItvTLyZCFyaqVAM9TbOvYx4yK/ejVbjTsYhEp48LnVkhFndK9KI4jiKCltrc
         EYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725122560; x=1725727360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KilWTuBK/UXyi+ZAcZMAHfDF1J3qSDvycaldNcwXGN4=;
        b=HA+JBud/7SIsMOjDrqyVut75l7V7+Y+7Zr21nuenAChOzHOgAF0E5XbIVHIxAP85q9
         0CEQmohBjMSqJssZJzm1FqAJ4ja/sW9AHVQIY3fqOgMvzBQ6Hot49eFOFPJjXstozEqC
         7v2hH9PAxTfqk9W4614tm47AShGNvYBTHm7wOhvvx98634UolZ3H7OF3KXywOGhI/lam
         OEjnXs+cI2Fa7yj/wxGrmygNjUYY5wg2jyH0zZB8KUws8xpzKl8zTy4xqLE0SFEu7EhS
         rix5a7JLXyR+tBYXaJ75JUxuVZTUOnCqUc/rhfBI0r5GxTZ95uL3ojJvTW9cnkyOitqM
         PqTw==
X-Forwarded-Encrypted: i=1; AJvYcCUKV+YjQnr3i4Q6DXT7MPyhxi5hMzPUwR+czHB8/5KzNvGypxi9oeaZeQGqYKcdWmcnKTRJC8xUDaHy/O0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7L+IqQprYbRei2cvPPd1BNTqD+Do27WynHJEPcZHK74rwEgMz
	P5Fl98XrkZfr+60cWsB7sMskRdlEjJlHxXwTunr7KIVmyH6703GWoLpV2Jlh2QOcdEO0jRv+PT9
	pOuXc6gq2F60tUjIG8xquawVMsrs=
X-Google-Smtp-Source: AGHT+IHShTqQnKMAWO5x4NZXqH988FKcL2DjXaOs9oI2feKR97EJ5QSw6Aq6be0ymvo9od9i6EnPnr1AN7ORfCwIAa0=
X-Received: by 2002:ac2:4c48:0:b0:52c:daa7:8975 with SMTP id
 2adb3069b0e04-53546b05e2bmr4323725e87.18.1725122559348; Sat, 31 Aug 2024
 09:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830201627.298264-1-abhashkumarjha123@gmail.com>
 <20240830201627.298264-3-abhashkumarjha123@gmail.com> <20240831134219.3d394c1a@jic23-huawei>
In-Reply-To: <20240831134219.3d394c1a@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Sat, 31 Aug 2024 22:12:27 +0530
Message-ID: <CAG=0RqLfjPF2_ebuabo0_ddvRxZkTLmKUAXQZWYHRaKxDaOkew@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: proximity: vl53l0x-i2c: Added continuous mode support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, songqiang1304521@gmail.com, lars@metafoo.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Also, consider if other triggers could be used as if not you need to
> both document why and add the validation callbacks to stop other triggers
> being assigned (once you've added one that can be!)
>
> Feel free to ask if you have more questions, but your first reference
> should be other drivers (and I hope we don't have any that do it this way).
>
I used this driver as a reference
https://github.com/torvalds/linux/blob/master/drivers/iio/adc/vf610_adc.c#L556

>
> ouch, not a write 1 to clear register?  I can't find docs, but this is really
> nasty bit of interface design if you have to toggle the bit.
>
Actually ST has not provided a register map or any application note
for the sensor.
So there's no way to cross reference. Hence I kept the original code.
But I will try to write 1 to clear register with my sensor.

> > +             ret = devm_iio_triggered_buffer_setup(&client->dev,
> > +                                     indio_dev,
> > +                                     &iio_pollfunc_store_time,
>
> This is odd.  You don't seem to have a function to be called to actually store
> the data.  Note you also need to consider if other triggers might be used.
>
> I'm not sure what reason we have to do that here though as this is a very
> conventional one interrupt per 'scan' of data device.
>
> So you should be registering a trigger, and a buffer then letting the
> trigger drive the buffer.

Why do I need to register a trigger? Would it be fine to let the irq
fill the buffer
with data as  it continuously reads it in the poll function?

So according to my understanding,
I need to move all the data reading and pushing to the poll function
and not do it in the irq handler.
Then register that poll function here during iio_triggered_buffer_setup.
Is there something that I am missing?

Regards,
Abhash

