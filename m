Return-Path: <linux-iio+bounces-9692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4642597DEB5
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 22:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D764628263F
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2024 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDD743AB4;
	Sat, 21 Sep 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG35Rsjw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A921345;
	Sat, 21 Sep 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726949286; cv=none; b=g4CJO0hlCq+asgU4WBq3CT10eL9btQ9FUB8dKemZD805I3pWVdMMuNIK0F+4tqGYnxCAgAMq1ALvRhiNp8DjswTjBNCo9Qj56PTA/Z0aZNFlMzD3+Gf8Fug/0G9AKhsf0uuuxGMtdHs47uMXgHotXmW7rj77MhSN22BviZJWthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726949286; c=relaxed/simple;
	bh=zZyf+o0TLYdYH2b6DfM2gllt3YUqrIASpHYo/fi1lcU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYwklN3Z9vi0s3rT1Qh4GLqlIlN2W0NlNRpfp5nOSlIWexBSXwZDv44qUE183w3pqjS6wEYoPgPZrjW0aHNPbJ58uZ+ZgjNrPNr5EjqYoKd8ycT4pe65RNg8evGuw1BsO7GdKZWgXBY+/ym2/B7yhAozrIvjVqDSD4qxD7C3+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG35Rsjw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so27198165e9.0;
        Sat, 21 Sep 2024 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726949283; x=1727554083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd71jJ7VubsiY76w8JJjt9nFBD6IrgxryZhRWEULMxg=;
        b=PG35RsjwUzfxdrNII33ZJFCGGMex8wJWBkKdbiTxmck0eSsZVQFZeomzDAT1YKGOGP
         vvjIsaRB+kP9Z4yt2tkITZrn+p9KlS47f6rXJaUAvNe5feW2TTyTonGABGUY49BTikEW
         Vl0ZSD27DdMcTe33wyNwVUAL3nPu6obkEKu70ULbG907QsaSSVHcGRfu+7J9oPDyrPPA
         2/FYlu3Dx4MWMdL4Dt0X7kA/J4FGhZTW83SLS8II/DC9g0H1dDiV8d+3ZR0k1pumBEHD
         0woSnzyjpypg1kX/9tAmVDVJtT1Bb/M9l/8nCuKwMthfho/f/saP8rDW/sFbauz8c2cN
         izyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726949283; x=1727554083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd71jJ7VubsiY76w8JJjt9nFBD6IrgxryZhRWEULMxg=;
        b=HgLLs8peJmDrU9BSPaYPCyQYd4fJPzIXNeuqYi5zVoV7dfX/KxRKHfKrHnmtyKRq4B
         4o5FaNHoT2s6WmEVUB/VQGgrlWiAERTV8L76gkUZoW8jIL3Wklp+Lc6tYJFxJ+bvnlUw
         W51OvAvdpxcw5YunVnO0/lPdoXlo6c1Wvz+kJNIwx94yjbn73S6/8W9SzylPZ1mPGGPO
         9E2kKwjSM0fRHGWRp9jzW8TPo5ZyGGJVSgIrFmNvwwKJH9/OCj2t5gyd9UBGpTBF577s
         XdcAgL+zIjcIWQSR8p+rLe7kYbQyuGd5Ww3XtwgPqkya0gr4zXk3NJu/w74brDqpS1KN
         3nIw==
X-Forwarded-Encrypted: i=1; AJvYcCVdJmyslSDHAYzhlnG/7iJqK1QXIsjCIBraKKB2Fm3+vl+bkltsUrRxxXlgNkDK4W7Pw7oru5rEQ3I=@vger.kernel.org, AJvYcCXMWdZ/k7eW7y8E1Stqtqi4w7dhEnw2Ce1MT8vx8dVc7UYGJBivzXx8mQQ+RGV9o/SoRIueM40Ih+OMSxPf@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNAHtHZlhOGYJLr+bE0rFMTKekVDTSqKjD6C0OU+rFHq87NzQ
	XlAz6ZWWtlk1hR5xNHGQvJ+i7T8mbzXBa2qf+egcUYuQMlkzfMpng12/Pw==
X-Google-Smtp-Source: AGHT+IGvuH5cSOY7zkAbrmFHgLHAqVrwwffhfn9jVew2UIhXUWVjdWES7rp9X/ZzEgHUpW3uVKEaUg==
X-Received: by 2002:a05:600c:3b17:b0:42c:ba83:3f01 with SMTP id 5b1f17b1804b1-42e7abe8495mr55132435e9.8.1726949282551;
        Sat, 21 Sep 2024 13:08:02 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:a498:414b:b435:bfeb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e14fsm20673312f8f.117.2024.09.21.13.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 13:08:01 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 21 Sep 2024 22:07:59 +0200
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] iio: core: remove iio_validate_own_trigger()
 function
Message-ID: <20240921200759.GA400156@vamoiridPC>
References: <20240921181939.392517-1-vassilisamir@gmail.com>
 <cd1df0c5-d95f-4880-b374-a7544a323d93@metafoo.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd1df0c5-d95f-4880-b374-a7544a323d93@metafoo.de>

On Sat, Sep 21, 2024 at 12:23:39PM -0700, Lars-Peter Clausen wrote:
> On 9/21/24 11:19, Vasileios Amoiridis wrote:
> > The iio_validate_own_trigger() function was added in this commit [1] but it is
> > the same with the below function called iio_trigger_validate_own_device(). The
> > bodies of the functions can be found in [2], [3].
> > 
> > [1]: https://lore.kernel.org/all/51cd3e3e74a6addf8d333f4a109fb9c5a11086ee.1683541225.git.mazziesaccount@gmail.com/
> > [2]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L732
> > [3]: https://elixir.bootlin.com/linux/v6.11/source/drivers/iio/industrialio-trigger.c#L752
> 
> The signature of the two functions are different, the order of the
> parameters is switched. So you can't just swap them out for the
> `validate_trigger` callback since the signature is not compatible. But maybe
> you can update the implementation of one of the functions to calling the
> other function.
> 

Hi Lars,

Hmm, I see what you mean. Still though, do you think that we could do some
cleaning here? I can see 3 approaches:

1) One of the 2 functions calls the other internally and nothing else has
to change.

1) The default iio_validate_own_trigger() is used only by 2 out of many drivers
who use the .validate_trigger call. If this is deprecated, many function
signatures will need to change (swap the args) and then rename the rest.

The default iio_trigger_validate_own_device() is used in almost all of the
drivers apart from 3 
	* gyro/st_gyro_core.c
	* common/st_sensors/st_sensors_trigger.c
	* trigger/stm32-lptimer-trigger.c

So it will be less noise to change the iio_trigger_validate_own_device()
in the sense that the signature of 3 functions will need to change
(swap args) and then rename the rest.

1 is by far the less noisy as only a couple lines need to change but we
still endup with 2 functions doing the same thing. 2 and 3 require more
noise but we end up having 1 implementation which looks cleaner.

What would you say?

Cheers,
Vasilis


