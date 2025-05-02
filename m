Return-Path: <linux-iio+bounces-18995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E543AA74C9
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A194A7A59
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6586255F41;
	Fri,  2 May 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeUdteli"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B45143748;
	Fri,  2 May 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195623; cv=none; b=tuMfF6Vm/z7dNW3IlugVwWUHfFMOV/tR4y2hnbMvqe75CZJgMNyNZoMQgSjcUSI7/cN4zbioLogqylmm38DAOOyk2eyHya5hnVLsDheBzfe2xBLhsPyJLRdEuGwao7v8iLPV9FsJNs8qs9qWv9U7hSq6U37/c/13QhSWstjJccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195623; c=relaxed/simple;
	bh=NLTkeMhO6WgrzXKTKcZReYDEkgITIo428vgJUhW3H3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRXGa0NIUknU9hrLgjOX1hXjfcghPhEbKWRybIRHnI8nAKxfRo+W13Oo2wd3VrJ4kQnV15FCtphnfoSun1s7JzMxb3eouRo2mH5nCyd6DXH8bTAoQ1+Z84B6BwDqOBoViKBqKbfXBfeNSSGfjIn+75GX6uEP3jCgHusqw4coYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeUdteli; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so3170526a12.3;
        Fri, 02 May 2025 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746195620; x=1746800420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBznP7Tph1aOC1yEisDZHDyhhKPx2aYD7F3IZneam84=;
        b=MeUdtelihIiW7jK6VQ3BdakNLhj6sU8tel9sLWhpI3857EnmYJpn4dXydND5xlLeRa
         +kP4NiiZkg3Rz16Vz421DR+Q0zc/FdAO90KYTy0iWpV09wE8w5AfpfZacmD7/hCk42Tk
         p3PAtbJkckGunbJUNjKIBcVyo8WlkwNsP9H6LP/09YrKOAPE0H9VXlU4inqROm55MkJK
         oOARoVQ/PzDvIKy399JiHNyCQ++CALEjoa7kAs6Iks1gQ4rs70gNk47zVxqyA2ae/N84
         ZTEr6dQS5srIBNmUOkC7s6/HZ/vWwXvezEhJ/Dj7zVghi6Ao9Ct7KM/WcX7hgmgBakh1
         xU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746195620; x=1746800420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBznP7Tph1aOC1yEisDZHDyhhKPx2aYD7F3IZneam84=;
        b=TmPlP3qFqDIjFM+GuM/exCPnXopIhVFWSZexvfcCgpPW4FW7nL21e5nIqMhT6x2iso
         Q12Hxg3gttQPvapdZv2OA0eduRQr0inmgx0UVt0iRj9Fha/R/9hm09x8QYbOvwfSDR1f
         RwUB3n+RdWnAhr5XfWf1LjeJY9olsByxix+FGJqWQu2c0XXb4Z7+A3uCVCnDG8wBOOzS
         ZyQlMWrgkdadhhfAPY1j9fbQeQLunfZnq3/mJlbHWSBjVRJuvWTLviuzKQVEhzRJ1RG2
         87xr4NRO1f0t71RZUsO20ioPglJTlGo4TJQlIXBw07WdVhwcKIppC/1yxYiUK+PWa3Q5
         ts+w==
X-Forwarded-Encrypted: i=1; AJvYcCVzQoTuIWtgqjnAwLcIMC0iWAHwufPOvreWU7gjRGpFT+UaW7IeM1DL+xdof+eYIuljKXt9iXpy@vger.kernel.org, AJvYcCWqcKa60nIkPURyWRjbcFeoBRA4uVYFN8pQKAZNU1qZOVxF2Ex5SzLkx4dv41vKJMYcxPpW+HLUtTx0o3Fr@vger.kernel.org, AJvYcCXEURAoypEwIueIUZtd7SKXzbm3mE1F6yybOBWoobSSadQBXRSkL/5MUaH7VUlxvvXM4kGj0bE+ILs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyki6MklKWS7sGKpxHdHsTHg3/yHGCoyWH2Es/ipQKDVHLHVZ6P
	16veIO3BSm+unfMc2QKWAdJa1XyIgfUGQ8BzX4GVEiWeLnYJDSjNMAClPEmXMb0J6CbGno9OorC
	tEqlvPx7Jdv+nXzHzxo34dGvhGAk=
X-Gm-Gg: ASbGncuH1p5s2avuxpNgWMAU3Hj1dHyFcmnzg7W3PhFTKkgajeJOAJ1UxObNoIo55aR
	kVxvlhXpuc2PIfT377p/JtGQNXLisFG2lo8eS8uQEE7ni4aIuGJkiMDGv1/u5IVa1uFm2lTUqqg
	65sXD261dntznkNamA9LnbN6XILe1SiFWonOI=
X-Google-Smtp-Source: AGHT+IEAkf/ycDiCWbKsOewklCTFld17bWKR1rodMGQzWYFUzODaDjr9UBc8HhNg5y6jON0Cog/ToOy92KeDQSJOsis=
X-Received: by 2002:a17:907:9904:b0:ac6:f6e2:7703 with SMTP id
 a640c23a62f3a-ad17ad3aac1mr225617766b.8.1746195619944; Fri, 02 May 2025
 07:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-fxls-v2-0-e1af65f1aa6c@geanix.com> <20250502-fxls-v2-1-e1af65f1aa6c@geanix.com>
In-Reply-To: <20250502-fxls-v2-1-e1af65f1aa6c@geanix.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 2 May 2025 17:19:44 +0300
X-Gm-Features: ATxdqUHWzMktixRFQSi9ASxdn1M54DmhZJXbmbJ7aBh3SxAWt_Cjs_uWdkbYa6E
Message-ID: <CAHp75VehpQdxFDXE8L0TeaOxHBTHNorOZ95rL48kQAiViAJ_zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: accel: fxls8962af: Fix temperature calculation
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 9:15=E2=80=AFAM Sean Nyekjaer <sean@geanix.com> wrot=
e:
>
> According to spec temperature should be returned in milli degrees Celsius=
.
> Add in_temp_scale to calculate from Celsius to milli Celsius.

...

> +/* Raw temp channel scale */
> +#define FXLS8962AF_TEMP_SCALE                  1000

Wouldn't constants from units.h be helpful here?

>  #define FXLS8962AF_AUTO_SUSPEND_DELAY_MS       2000

(2 * MSEC_PER_SEC)

This gives immediately that we want 2 seconds of delay.

--=20
With Best Regards,
Andy Shevchenko

