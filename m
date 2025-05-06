Return-Path: <linux-iio+bounces-19208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6992AACDB6
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 21:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC1798466D
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 19:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390BC1C6FE7;
	Tue,  6 May 2025 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUz1XBpc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CF19CC0A;
	Tue,  6 May 2025 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558229; cv=none; b=apJ3rspSKpLotfTasQpFgS4qhG7GeR964yo7Zqe97fskxOZ2YO5Uq/YqK2sq/hBvUWdB+UI0mxWTH6nQT0lkyrmE1q9X00B3NeUqCbU5XW6N+WnYP6jXWaiZom7SkoKLL9I8Cn6yQqVfoQ6I5lbRycW8DKnWkS4l3Dfgr3R+G3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558229; c=relaxed/simple;
	bh=Q1Byj7KAeeQlPXBdhhBqPGFqmoaplXzgBJJcsOaiPdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOb/rH/LY7884+b49kK6Q2zfudpJqqO6Op1Uth8iYAZFZKLDG979iUba1BAtvCW5YASXdPFLlvCXKZtY8/SFIrBvZDQk8idK4t4pVouyl18EhmYfEvG+YjXuhTRX6lV7eSBlvotvdR6KcQWluZXJS5TY39qadGkcmGfNze1kaz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUz1XBpc; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c549d9ecc6so87040385a.1;
        Tue, 06 May 2025 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746558226; x=1747163026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbcd1rG8tob/mMuK+N9J6HXytcG7wJ/d0j7rgdtfF04=;
        b=AUz1XBpchuVbR/jD3hUb73vGfeOLGiVFgruPQaoI+e576PRxEjy2bfz8gj0NJ7thVM
         A8M7hlIrQFk2MTjySHY9lOEuxlyQIok+I+QvTbksforNP5g7Ev9Ho78Sya0BYUaqWiNj
         ozDXTrUMbACKYEF7i2sGlIhgoR8IKUixQTy5NFRLkS8wN5xyP+nGLZ/fta1grUA6POs1
         wCyXZDGdAmNnzgfWW1UcajFUTNvJ/maEX7QIDjUD6vVCY8o1JHrWd4f+N8Gyp1v/SE3N
         yD5z4G5aHP1He1SiZK/ywe4OYpBUUlFA7zvDY3NiCeJ+K3QVBa9l7gZnEwQR6uNDr3Mg
         35WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746558226; x=1747163026;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbcd1rG8tob/mMuK+N9J6HXytcG7wJ/d0j7rgdtfF04=;
        b=GgNUdGtLyBMdTQK8Mp0FW1wr+9a8yq56V3Ps1WxntxQPXY33uNyZYwIiX6Fs3Pf6Fi
         DzoX5DtVei5Sx4bTnE0y/1m8xNEAiPheNSef9+iUvlm1YS1PpZQ2cOxAFvrCyxqnMfW7
         Lf9Mv/vunzsdiseZsS03nCRa8uYjPBs+Um3A5lQXnfX1JGbmZ2+XZC+G1zQFOkoNi0Pv
         L0vjQ0P3dkJN3gffNWLA/n+UR5OuHrJBlUxwCI0TQ1Gkev4UsAWKJcuEqCY80VfK0H/+
         W9HC3hCS8e/bWRn9ny4h9aFXU1LF4C7GGUNKTI7dyU5MSpAVsRxHE+vSQ8WvTem7UKlW
         hdzA==
X-Forwarded-Encrypted: i=1; AJvYcCUHkn3KmSyDMKCOIa7glJHsQ1mXCwpKQqQA9rIzXGQqjPOnNQYxsIO3CfDdizd9OuU3lsl+qC3HxBno@vger.kernel.org, AJvYcCWb11AYjUIhQLWLjbGmRIfBJ6cAYWdK1+C6CGnZ08Xtm2rHBn1gU75Lj+LHos8IrOEJmoMDlLRj5JjB@vger.kernel.org, AJvYcCX8BBrVIt8IMzLEKaOmu3JNRroQjnBc9CJ2jkq8AaWg1/+aetEWUsi5xX7Qo1NW8m/f3VYHJb/IW7vzBw==@vger.kernel.org, AJvYcCXQk3lAH+KPwBpPDUtv8em66N1NgRkQyoEJI7989c8CL1k9LEBiguMmMBw5qTXjQEP+F4YVOBFr07ugU6L0@vger.kernel.org
X-Gm-Message-State: AOJu0YxdNPLyapIXLiMsWWRVi7YfnFtWpBtFl/MtWTm7GCLVE7itMqr6
	6Juu2EduHtloIAAeFyZwcbg0vEmPmUwit2MpHG8RZHypUpBwcTVd
X-Gm-Gg: ASbGnct1mQf2EBq4hYj15XPEDYnJWSUjwNeLnGK8ExfZhFKka6DiVyZZpEBcZ3Eh6CG
	LUck1XMjsNfWI+1Mfs02xOKm3X1h2NiyREXqWB+Foma1bR8gUgZMlB9Mh6O3K8ErYmvYaOCGBMc
	rzqy73TJNpcqu6fEJKcBKoo0WiJ+WmAZ3kT/7sa3KY/xL+MYl++1rWDGkCnDRL9rVq8rUysyhLe
	k1ygWvH+Ei/VEbfgpFaAqmQaE11SVZ498q+ZRrXfRjawC9dgx+BzpJLLjpezrPzhJRvpWMcJVv8
	ostG6nRQz0yCkuMqVp5GnDRNvDDNATYOKTT+o9ZibENzNQW6LdYcoC7X18jTN/t6OlZlvmvE
X-Google-Smtp-Source: AGHT+IHEIlJe8V/bfK8noaG+e9HbHfHlNzlivvhyYKQXTYuglrsYkBwOAV506BAus+ExuPoTrXBAXw==
X-Received: by 2002:a05:620a:3194:b0:7c5:6fee:1634 with SMTP id af79cd13be357-7caf736d415mr31893785a.3.1746558226157;
        Tue, 06 May 2025 12:03:46 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([191.255.131.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7caf75b87b7sm13533985a.71.2025.05.06.12.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:03:45 -0700 (PDT)
Date: Tue, 6 May 2025 16:03:40 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
	lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com,
	Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH v6 10/11] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <aBpdDN12wdV/gOBB@JSANTO12-L01.ad.analog.com>
Reply-To: 20250505170950.1d7941d0@jic23-huawei.smtp.subspace.kernel.org
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
 <4493dc2e3e0fb61ba3e8a0e54571998aaaaf46c8.1745605382.git.Jonathan.Santos@analog.com>
 <20250505170950.1d7941d0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505170950.1d7941d0@jic23-huawei>

On 05/05, Jonathan Cameron wrote:
> On Sun, 27 Apr 2025 21:14:17 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> 
...
>  drivers/iio/adc/ad7768-1.c | 363 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 293 insertions(+), 70 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 10791a85d2c5..e2b8f12260a5 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -20,6 +20,8 @@
> >  #include <linux/regulator/driver.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/spi/spi.h>
> > +#include <linux/unaligned.h>
> > +#include <linux/util_macros.h>
> >  
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> > @@ -77,7 +79,7 @@
> >  #define AD7768_PWR_PWRMODE(x)		FIELD_PREP(AD7768_PWR_PWRMODE_MSK, x)
> >  
> >  /* AD7768_REG_DIGITAL_FILTER */
> > -#define AD7768_DIG_FIL_FIL_MSK		GENMASK(6, 4)
> > +#define AD7768_DIG_FIL_FIL_MSK		GENMASK(7, 4)
> 
> Bug?  If so does this belong in a precursor patch?
> 

Actually not, this extra bit is to include the 60Hz rejection enable
for sinc3 filter

> >  #define AD7768_DIG_FIL_FIL(x)		FIELD_PREP(AD7768_DIG_FIL_FIL_MSK, x)
> 
...
 

