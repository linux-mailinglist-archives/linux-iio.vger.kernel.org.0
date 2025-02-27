Return-Path: <linux-iio+bounces-16158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964B9A48AA6
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 22:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8752916B908
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 21:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCC1271275;
	Thu, 27 Feb 2025 21:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUOO1z1E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC31A9B2A;
	Thu, 27 Feb 2025 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692183; cv=none; b=Z7RW3pS+Lgl6CvyOaYeNIAqWrhC7oXv1eHR38eso6HEzbAjycLC9fXwE1u7oyH3oOLfakFC/TYJGYBxQVXhd3b4I2Zm9owB4CWy/r84DFCA1ch5Ovf2aQLHhJFEA5KwpKFr9b6rH1f7ffZbW+45ho4KNnmsrRaubJg/qGPiqiys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692183; c=relaxed/simple;
	bh=aT6LCpQh/DUk/4C5yjN5YoQwJQsJ0wDh8MPAiZ/0uSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUV8Xmk0ZI8FPbf7zb1O/sNScipQF5NZpTlPV5RD28UIyYJpzhqxGMqHoM7SyYxRsRCYneY8p/7fsfInMOWYahEAygsoBK0csIoE6IAaIFbp93xoWVjXypCP8vYVFVijor1MsXrk1nIQ4hVNnx+3R35LWt0CKS65GeREwcELEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUOO1z1E; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8a2fd46ddso11196d6.1;
        Thu, 27 Feb 2025 13:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740692180; x=1741296980; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHhkYScYoArvR/F5m50Hw9t1PzuS3cNkRvx1BFjMwv8=;
        b=gUOO1z1E/WmMZ6Sv0rKm4tPGXcFaWEHTA+6q8Sx47AI5JdUfU3/55zPM8mSq70l2P8
         BuO7nf76QbTwodNfV4TOxKLQqi49RpEChpX8Xiwy+40C1AIjco/UwYrxR04lAN+ruMlS
         uWHqkf3vNpaXaeIApagiAUynRRJpiyhMw/E1212pCT5Drd51nRUh9F7TfeX8CyHUO8Z7
         4n2IND2wXG6Api3Q228BL6nL+j9bZOo2pPut3oYfBO/LMbBV/Ezf7hJDm/oiD4gG92+W
         NH0hqu30soGnLtuCYn4XcEjOUfrH68J1DmcxA5V47TtGaPQBy6/Y0IQ8bNR3N0NgfVs9
         hsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692180; x=1741296980;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHhkYScYoArvR/F5m50Hw9t1PzuS3cNkRvx1BFjMwv8=;
        b=GTPVOAQR2pEo9K6UUhEL1oOfpX4TEuD2Iey5zKo0sRJZ8buQJHpsytNv8CHa13BTEJ
         bJP+N4ZWP/3iOq//si2ZjwNP1zYTdPDnvs3jesZipBHOck4NXTGOjZGmDFSUYNu4VtLe
         Ld26zFI7baHhUy41CYthfXqAxH98a9p3nSG/Imzu3Eii+/izB8OC6pblzKOs20g9Gym9
         2qT+e3iGDgYCNxhwpkfbWTNKFIGmDAzkFTjL/I2zrGaQrYOXntamGTb0m0m4HW3UwtW+
         V9F4Vn2WKer8x5zv0e+/eT1DZCrN9pGlhJp6k+lFjAToCJwMVBj0r7aHj9weKTBdlfSs
         waNg==
X-Forwarded-Encrypted: i=1; AJvYcCVkUSrUCgVrTdjkd43B2rUOBMjaH+pl8JI3JrvCis0O36JOgLa7U7TmQrFpvsJxQzqACcRY3DtJZPtk@vger.kernel.org, AJvYcCXTfCLj8/JQBhP4pEtnwpDdLuzlsS+hnYb2mDf05qsZT7K1HQybVts4uYuhr+xoLOLJ6F1qEi37jGLk@vger.kernel.org, AJvYcCXkbrz3miSpjbqLNsQDutQa3s6EbyLwRdxz3LRDCLXjE9sx+q+eQh+6UVfZVpWserC0W5Ey9qmiQGl4O978@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUn0QwBzi+34uhsL1gEu0e81mTYq18W1MpLvQvrUOKmlGbSZP
	DJTG0lsnzZY8JPAwac+O0HMKl2EUfTiFe0IPD5JxLtt0Sruu9Mxa
X-Gm-Gg: ASbGncsBGx9F9YKMm6GtXFKM3/oYvCuB4lanSK4SqiCZOJojGtWnwvlskKMtWW43XtC
	qQG8sxL7lNrQK8+6+Wum8cCBVXy38+amqzBIZ4Lp3v9ttDe/B1q++xra/r0/f/XQwOXoNB9cz21
	lkQHw1FpTzMCMjdF+EzLqg0ScxCgDTyL80F7tegdSxWTmGm+1+o+zhSfKOonMxym64dXhFO1+vh
	XLvMeBnWlkL22EyjQguVah1Aeh/R1kNq+/lDapDbcn94OB6pFSYm5X80HHg4Kenk/ob8pKk+5kL
	Kor2lsTXHx4u09o2ayv5PY95AF1h2+yDbLo6LQaroZhqEVE=
X-Google-Smtp-Source: AGHT+IHR/OUOc/tEgpDCPTt9nKJHRGg4bGS409xWq/BFnfnsG9F5vT8dzLfgr1Z6oagPe3mr7gB/Zg==
X-Received: by 2002:ad4:596c:0:b0:6e6:5bd5:f3b5 with SMTP id 6a1803df08f44-6e8a0da79bcmr5186576d6.8.1740692180311;
        Thu, 27 Feb 2025 13:36:20 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897653799sm14308416d6.33.2025.02.27.13.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 13:36:19 -0800 (PST)
Date: Thu, 27 Feb 2025 18:36:15 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller
 support
Message-ID: <Z8DazwTguF/gfKW1@JSANTO12-L01.ad.analog.com>
Reply-To: 7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
 <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com>
 <7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com>

On 02/20, David Lechner wrote:
> On 2/19/25 2:34 PM, Linus Walleij wrote:
> > Hi Jonathan/Sergiu,
> > 
> > thanks for your patch!
> > 
> > On Wed, Feb 12, 2025 at 7:20 PM Jonathan Santos
> > <Jonathan.Santos@analog.com> wrote:
> > 
> >> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> >>
> >> The AD7768-1 has the ability to control other local hardware (such as gain
> >> stages),to power down other blocks in the signal chain, or read local
> >> status signals over the SPI interface.
> >>
> >> This change exports the AD7768-1's four gpios and makes them accessible
> >> at an upper layer.
> >>
> >> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> >> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> >> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > 
> > Is it not possible to use the gpio regmap library in this driver
> > like we do in drivers/iio/addac/stx104.c?
> > 
> > It cuts down the code size of simple GPIO chips on random
> > chips quite a lot.
> > 
> > Yours,
> > Linus Walleij
> 
> I think the answer is "no" since we need to hold a conditional lock
> while accessing registers. Namely: iio_device_claim_direct_mode()/
> iio_device_release_direct_mode().
> 
> Unless we add some extra stuff to the gpio regmap implementation to
> add optional callbacks to call these. Which could be worth it given
> that quite a few ADCs provide GPIOs like this.

Since this patch set is quite large already, is it worth to do this
here? if you say it is necessary, i can try this.

> 

