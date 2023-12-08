Return-Path: <linux-iio+bounces-753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C36380A4C3
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C200B20C29
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EB31DA30;
	Fri,  8 Dec 2023 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akAduOxG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C953F198C;
	Fri,  8 Dec 2023 05:50:29 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cec976b197so887986b3a.0;
        Fri, 08 Dec 2023 05:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702043429; x=1702648229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w05jcvJbftuz+V4PIwlumxl68ycFODGUFJ//SIJMXoc=;
        b=akAduOxGieGm14GFaa/A4ucqm7QvDyaQULiMFmh4yFOPUP3brtqVBuz27VcCSYXDF8
         bI6ZGC6czjXfWCjnpGLgwqpqoJX3noUrkQLLHM8zq3yFbA2WJVADm06I40WDiXHEqWfl
         S8eU/HGZePZSlgim66gvHu9cyIdViVB5JSEnCSXTSxC1rv4PYMc0PdyAAaLucmuzocUt
         1ct4fp3HDh9WyxyIlXb4GpKkFerXZAVx2KbGLfAU6mCiGbeezPxU2Zz28CCNkh9BNbrE
         Uj5s/JeNz8z0cmwm8p6btRYz5FaIAVKg2BL8MZoEU0Vz6tMKXK0LlwONvZPmUtRAgUoJ
         7m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702043429; x=1702648229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w05jcvJbftuz+V4PIwlumxl68ycFODGUFJ//SIJMXoc=;
        b=p2ZFSbBggPI9uAafEWJpBOEuNgzGCP8dZHwvwZyeE8dTFVJTWM7fWUZpj6mk8axlTz
         tE3IR7TJ0Rgvooqj3LTLNv1MIIa85tfJkj+Cm2bHuB8qRJKW6SqJD3bYIBZMDP4nW7Fq
         ECq1cQqvCpYDYX64hOBJ3OziqzU06fm3JoEBVi6yz+FM1NkgsUs8NagggFvn+zwdBroe
         VECMWSABK/Vx/xo7sfTrZiSAm/JOHw8Rf4a5wIaOjd6FvUnFpytALOf+4YPJyM63EX44
         g7EFVAM53jrHmlC1uHekAzTiyhphN9U3s2rUNlceXpZ0M0AHWzT4N4UPZ39v3bVY7nGf
         EXoQ==
X-Gm-Message-State: AOJu0YxJBw7Z92CQjIhGe90H3zOfFFy/bR9SO+UsF2nWQJWEXbwO0EDq
	2kX7RLGaD/d7ZzcvSB6uVas=
X-Google-Smtp-Source: AGHT+IG6p9qYniWsOOxCuS7btrPvaasfWo06OhsJ23v6Z7ooK2KImNZUSYg6Z+ZXjnX1zG5bicXbEw==
X-Received: by 2002:a05:6a20:3ca1:b0:190:55ed:c42 with SMTP id b33-20020a056a203ca100b0019055ed0c42mr39843pzj.63.1702043429043;
        Fri, 08 Dec 2023 05:50:29 -0800 (PST)
Received: from localhost ([2804:30c:95c:8600:5b2d:e35b:5f45:dc84])
        by smtp.gmail.com with ESMTPSA id d3-20020a056a0010c300b006c0316485f9sm1583704pfu.64.2023.12.08.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:50:28 -0800 (PST)
Date: Fri, 8 Dec 2023 10:50:15 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
	joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	paul.cercueil@analog.com, Michael.Hennerich@analog.com,
	lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/13] Add support for AD7091R-2/-4/-8
Message-ID: <ZXMfFxEckIm_cFPJ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
 <CAMknhBFPbAqp4-AQdmbp+VRW-Ksk1PxaLCG+3n=Zk4gyStqhgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBFPbAqp4-AQdmbp+VRW-Ksk1PxaLCG+3n=Zk4gyStqhgw@mail.gmail.com>

On 12/07, David Lechner wrote:
> On Thu, Dec 7, 2023 at 12:36 PM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> >
[...]
> >
> > I see regmap's interface for reading device registers under /sys/kernel/debug/regmap/.
> > I can read all registers but can't write to any of them unless I force define
> > REGMAP_ALLOW_WRITE_DEBUGFS.
> >
> > When testing events for this driver I often write to device registers
> > to set different rising/falling thresholds. I do something like this:
> > # echo 0x17 0x100 > /sys/kernel/debug/iio/iio:device0/direct_reg_access
> >
> > I tried read/writing to files under iio:device events directory but always
> > get segmentation fault. I must be forgetting to implement something.
> > What am I missing?
> >
> 
> It looks like event callbacks (.read_event_value and friends) are
> missing from `static const struct iio_info ad7091r_info = { ... }`.
> These callbacks aren't checked for NULL, e.g. in iio_ev_value_show(),
> so that is likely where the segfault is happening.

Hi David, thank you for pointing that out.
Will implement those calls in v4.

