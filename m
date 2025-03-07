Return-Path: <linux-iio+bounces-16522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E1AA56942
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100667A3D88
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F082721A44C;
	Fri,  7 Mar 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0cShVDer"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FDB192589
	for <linux-iio@vger.kernel.org>; Fri,  7 Mar 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355136; cv=none; b=I3whHEvUXt1Cli4JJKrszOA6NF3jwPeelmwdah5/ioQTNogF1w8iemUBEOxbPlaXMLfxcbUe3PIVt7dMN/59mPaD7476IBkI1za0gtGg8TrgpOl1Ry9hhclGx7pP0MK1X/2DAnsh75UmxBxS+F/qWkYX3wO7IgcT/rJ+LbrecrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355136; c=relaxed/simple;
	bh=0TFrNUave7u0c/TFcLUTVj6EnbOoF9/okdBtc8ZpfRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsoGf2TVHm9T6sSryPQQ9cIIOEHjh209jIKuZv7jyKJpXWtjXsPLCu8iu1hAiwTPyKXkdVkWqY/t6pkekknpMxTWzqXVV8q6jAqwnzCmhfYnymi4q+ttZTei1Zl6Pu7CAE3D5wYjMnrb3fmdUex3EDx8IZGLL31/w+czq4nUyws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0cShVDer; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso8724661fa.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Mar 2025 05:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741355133; x=1741959933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TFrNUave7u0c/TFcLUTVj6EnbOoF9/okdBtc8ZpfRA=;
        b=0cShVDeriLRrwT4wUp+Mr7DxhRumgDMo3z5AUUN/isi08PFbQyVe6kyBpuw1YLA0Oh
         7IQ9T9xR+s+8gtIFA6hHBNJK4f2VBnMnC0248BRwyGv0tPp0Cefrk6x6mwgY9wS2LY7m
         MA7tOU9bPLClp2pYfd+0vP6u4IuS9aJZW9GhQ8FY4P3kC6W9UgVFUEBJFWC0BRi3VrU5
         2H83BfQNVlIZh464+AblSBgJrrmkB3rTDByU+WT02h//DN0DVWppHG/HR0t8U8ppC7sc
         VcbWgTe4RVPr4ghqckOsPA1XLShhPDa+Zvvav445cyerOOvNqrCBL2d3hguLCm8XbQiw
         odqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355133; x=1741959933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TFrNUave7u0c/TFcLUTVj6EnbOoF9/okdBtc8ZpfRA=;
        b=iShpD9D7pHgtqWzeeTbfrpxFFL5dKh0hZHuZ98F7aRDg68TmkZ/Lx+iwDwY9Gmxq3J
         juuUZTYsXe6SbVMLdoRhAJQFYTr7V+xbdAuLR5uuB5BMOL/E7Z1V7vohXIMV6jOaWm+C
         yCdZYHJ6ab04ZNlQmJRiCEhk2WiMZbhloKAt7Q9cBT6eXnDiXRbZ9DlRYH8HaA8vuNBw
         KtocNg+BxT+FbldtanZeemB1sfodCvnvzQtL/noJ3oBdzjKyivPZrKOuuSQSj8PTwCG9
         FyzoSO5FGIOIGNbwDkGnzLd1LEefPTwL0wfPWb7EajWTq/8DIAkYxghqoLyMsZHl2QK7
         7nYA==
X-Gm-Message-State: AOJu0YxpX+8sYS3tKROPb3dMy4JKsjTTtRW7KHIP/fmyWwokQNclA217
	Vh9Sqtoaan5bkw3fRJZ6dgkAaqEujEshiTeqUi9c99oTMxuu6JORLKxogrWMw9zmECIbTDS1Rp8
	J+DYnbtfhr5opei1AIKpUeKZl2vEacB99IzfnIA==
X-Gm-Gg: ASbGncu0Um3A4FQQdWDYe2FxtSIzsZrvid74aUyOjpuF6us24sj9eoe9KBoqcy0+kQM
	1u6AoJM+Roak66zif+e3MoAlBNn5cernScu8aFt3xVDD25Krqvt9swc/yvR0kk9Vmv8/HHQpPat
	c0fAvARGC0yMlJbpKyzGKosBagdCWsJhWLGEPKjJx8TxqlVd3mzMW6Te0x
X-Google-Smtp-Source: AGHT+IHCHWdcrf+CS34Y1FeHjxgNuNdVmDEgpUXU6Qys+5+tGGxXxtTXUnsy+/28mQy/IygcRJFkYAAqwSVuG2rzZoE=
X-Received: by 2002:a2e:8819:0:b0:30b:e73e:e472 with SMTP id
 38308e7fff4ca-30be73f011amr23073541fa.14.1741355133270; Fri, 07 Mar 2025
 05:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741268122.git.Jonathan.Santos@analog.com> <efdbddad734021f38a43cc9d101a22424e71dcef.1741268122.git.Jonathan.Santos@analog.com>
In-Reply-To: <efdbddad734021f38a43cc9d101a22424e71dcef.1741268122.git.Jonathan.Santos@analog.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 7 Mar 2025 14:45:21 +0100
X-Gm-Features: AQ5f1JoTCLJx2G8kFEf7gAq4XDizdZoV-M-jLWjt5ZT4aPIJLHyyF3f0r8-4KBQ
Message-ID: <CAMRc=McTdmgRhzN-tLdxvUXnxRVE7AiFDUJWPnnHC-pnfZc3uA@mail.gmail.com>
Subject: Re: [PATCH v4 12/17] iio: adc: ad7768-1: Add GPIO controller support
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org, 
	lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com, 
	marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 10:03=E2=80=AFPM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>
> The AD7768-1 has the ability to control other local hardware (such as gai=
n
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
>
> Add direct mode conditional locks in the gpio callbacks to prevent regist=
er
> access when the device is in buffered mode.
>
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

