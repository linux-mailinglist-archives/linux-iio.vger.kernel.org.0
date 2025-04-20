Return-Path: <linux-iio+bounces-18361-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D614A9465E
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 03:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A701764A6
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D89548EE;
	Sun, 20 Apr 2025 01:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0zBWXkZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB861BDCF;
	Sun, 20 Apr 2025 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745113325; cv=none; b=ROasA3rfCVi7GmS9Nt1VR6nOLZRr0RSINIQrDdgwUjmER1ShUYvNuXAezigze67vsA/VVYPSwvGMxXNhyIIGpM6VowEHk14x0mepkzvtE+78a/FwhA9SWq7R7RIbh/bbHNDT4LKJQSm6g6aHg8XhlwtMZtMTtDLjRg0flFZQcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745113325; c=relaxed/simple;
	bh=tsaCaU9Ezr0cIMp5ShIilmqtgbAZpojFeGzVG8Gx8K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYhDOf5+UKrWX81vm2Xoxczm4Ens5yubuuVX+Si+YhcHRXXvrQuCSu6Sw45n1DnNH0bW1aqU6Ay8K5BN+u5vBkq2a7tUHNfUVZxcuszEJ9YCkJjLUK8sqi5qAUPtCtC+Zm9x/hSQLYFJmLmHixcQnePbOzIfWg3VhtelZGeNb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0zBWXkZ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476b4c9faa2so37500171cf.3;
        Sat, 19 Apr 2025 18:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745113321; x=1745718121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsaCaU9Ezr0cIMp5ShIilmqtgbAZpojFeGzVG8Gx8K0=;
        b=g0zBWXkZe1v/GXvnhn19TaPvBCM9hGJe88RFTaeMt3T1FE66Ee5G9yZp4N6UBTw/1l
         tvWpeVXlQpnwfB0RIRiKqDqFB92E4OXvUGdUPj1Rli7DcVnmJH9TjwpmZteQHGdhwe43
         wIhxmCAlc99XZMJV1T/8YX31fS9DJmJ2StwOpzFURTFaloJZLZE52vhExm5SuYZeAhKN
         2lvwSZxq/yoagG59BVfS4ytwE14sFJDyuexNRfcvf/Ozu0i/jD/hmfqGDbGvyCeu4lgn
         B7lqhtfU7NAOBObICfb24bmlc16+swV4+EL7KoF9rq0VIcrIWGWDJW0b6IwZ7zKPOPb5
         cCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745113321; x=1745718121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsaCaU9Ezr0cIMp5ShIilmqtgbAZpojFeGzVG8Gx8K0=;
        b=TUGW6IhfZbKSQ2uQbEyOaqw0/BMh76W4NJdj7RxFzwcjLbJPBp5wMokZIJnjJ1q6Tp
         XVXF/RmGJMG3BRJGJngrn+yHuz14MsrVqB3GU9n37bEUl7RQRq/uyvZe2z6yEIiXYZwJ
         5wuUHZfrzf1LfS70VWDK7Z7el+qeh3nvrB76lkmMUo6Qk7pZ6YS/i/TowBzezyw4xuyq
         hThF4ZKng3yYRhhbac6JD/OIPtyF+jYtRPdlcbZS9eVIcnSJ9zsWeM+2jbae3ZWFW+3Q
         3XZmjcq+2VsowEDAtoK/yc3jtaZ7amr4Bk6nIx0r7V/yy80cS9v9mt7kIhwdsF3yUq7X
         TBjg==
X-Forwarded-Encrypted: i=1; AJvYcCXCMLfFP9H0j3FefJ4vcEhEWCshoX4I2Hnzp2h+QOALrZO1KinRjgSpaUkHVcs5J7YyLhbTnPdmp94=@vger.kernel.org, AJvYcCXZ7iggO5cAQH876SR+J8iw1ETTVahfEUKukVrkDSvb5uksOE21AJNj/DIgjJONCXjSmsiKv8b730sseFVO@vger.kernel.org, AJvYcCXhx1NV5bHezo5amSa87kpxgXCMRWOaury+E0XvpaT75EnYS1kGzcugI4COcKfH9iPmUkdqMmpA@vger.kernel.org
X-Gm-Message-State: AOJu0YznIDtWuFwhfEH2EDG1aW2D3otI7TOIzpcpweljcQEhmzxutWv+
	cUCLMntDaggyjYJvxNE7dQ/IJ6ok01MzicuRdk6OEygGPuv3c4UYZhbk/Y3MHk/iF/PAdA3Fu2L
	0D0GK9ZqXNKtmBOiq99eeOi0KXqE=
X-Gm-Gg: ASbGnctdb29xyvf7HyRq4ZCq9K3DfzN3rCKflmxWKqOU8z3keePrQKrCDDYZ1nRLu2D
	gGJLEAXI/HafC+F8nWLgNDf46QLQQ/syBj0R4TFffeKKVQew2aWmHRoQZZqdY4s9vNOvBiRCPdx
	e6PQFYRd+SlrIrUATZ9by2xnktVhKeI01eWiqMt48K/+QXnxm98oHFxO7cREEftMDs
X-Google-Smtp-Source: AGHT+IGtT7QLX+7ds1/I9qdUhstYhhVMMLe8WqSFbnO8/AS9IoKoujUwgBw1UMPZ2iNyTCzr+bpvr7+jXJuA4u176YE=
X-Received: by 2002:a05:620a:3953:b0:7c5:468b:5658 with SMTP id
 af79cd13be357-7c927fb904cmr1058657785a.28.1745113321715; Sat, 19 Apr 2025
 18:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417135434.568007-1-gshahrouzi@gmail.com> <aAQZrhBLQCa0TjOJ@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aAQZrhBLQCa0TjOJ@debian-BULLSEYE-live-builder-AMD64>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Sat, 19 Apr 2025 21:41:50 -0400
X-Gm-Features: ATxdqUGWomIPkEKnO1A5RVPhgghPnE3H_nH650MuXGIRClqT04P8Aoc0_et-9W0
Message-ID: <CAKUZ0zLMAZFHwvuqfoL6JZfphYRhtjkqOyi50_ZffbA7-4MCew@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: Use SLEEP bit instead of RESET to disable output
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 5:45=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 04/17, Gabriel Shahrouzi wrote:
> > According to the AD9832 datasheet (Table 10, D12 description), setting
> > the RESET bit forces the phase accumulator to zero, which corresponds t=
o
> > a full-scale DC output, rather than disabling the output signal.
> >
> > The correct way to disable the output and enter a low-power state is to
> > set the AD9832_SLEEP bit (Table 10, D13 description), which powers down
> > the internal DAC current sources and disables internal clocks.
> >
> > Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> Looks okay.
>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
>
> Unrelated to this patch but, if anybody be looking to work on getting thi=
s out
> of staging, I think maybe this driver could use out_altvoltage_powerdown =
ABI
> instead of this custom out_altvoltageX_out_enable.
> Crazy thing this driver doesn't declare a single IIO channel.
> Seems to be somewhat ancient IIO driver.
I can start tackling this.
>
> Regards,
> Marcelo

