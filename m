Return-Path: <linux-iio+bounces-14210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A02A0A9EB
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC82163CE4
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBED1B4F21;
	Sun, 12 Jan 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtaBDXDO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77681A8F7F;
	Sun, 12 Jan 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736691020; cv=none; b=KEJ4QP4YiRH1nkYVe6gIHm4S4htnJUcb3gbloEUeT4n4ViCbQwMbYnpmtQwfbPjfNfZk/6IP3AslfFyHE3m6g2WgLVouBscix1R3IhxTyflAQkCIOPe9YW8hul90vN6WNQRbKbCX8QUN4s7g2+EIPQEBZXrgyuy8b93xfttVVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736691020; c=relaxed/simple;
	bh=aYHSsG3xYmeih1mG+wDaAsYLRS2C5B+ZU5yYOxJJiek=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=hqANjGpOqvtiDe4TWJLIgVvUT+5cmvxe5YtS9eWh3WshQmxv15xljd3D3GCvWFJWhJComjAx+OMMMr3cQQ2ao5iyDSC6K6QWXJRH8igbMt4eMVP5GReol05BCiCQdt8LKtYII5yMaOZxxptnBWIfc8+advvj5DdTpkJhKhsOVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtaBDXDO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361815b96cso24265815e9.1;
        Sun, 12 Jan 2025 06:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736691017; x=1737295817; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7sXgfoIu2j1mJ0+2zjIB1BJERYAqB7XYR5iNgKh7C4=;
        b=WtaBDXDO9HUBP2xHsDcAaT330vLZnGYE+z4lCMdpc6hl/lpP/f9W9MWVkYWsETpv8F
         iVuRMI5joK9HegM+D91ZUxKkCb3ceZl9aEoiipCZlEjK1IVIDMx0pugXGx7xajeDjBMz
         PWxCT9RCA69LEB/8NEzQuP7onqx0ahVfOjg6dHITDUNFi6McmREXEyT7JNIvoGEFrAB6
         jVrnZ5ZKIsRGRCoF7Fa22gl/SyDmyLd8XTRCQXQJHT8VRfvxt57xoFQSvWkaz6yAWJlU
         digHqxTuUWX0yuggtDbdoRHWhh/RYpmBVkzJEmdXR5DMAW9BoliB59TpYlDK1O6FbA95
         L9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736691017; x=1737295817;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y7sXgfoIu2j1mJ0+2zjIB1BJERYAqB7XYR5iNgKh7C4=;
        b=ZqnT3biVJ+Zmni8dMua0i76XBYy1GlCjG+Ky9u5u9Y7s2DIjAh6OwpcDv2m2qeveAW
         sT/n2nZHoH8aSC0pQBWHtSBGXx6weCE+ycaYfTUTOUgxjhWAUK0hOvdNPSnnoYyBTO7J
         QF8GcYZU0qkOFJr43rhLrNSWmhx5CkYNmigWFCCya98o6t23veRlhKMxE6ntYYBPY/Rs
         2UHBL9D/njqyXStgBIi8VGY0mETGskOKDIFxMXrIowdq/HhMc3DKaDYXqe6DTqQBnvt7
         /0GSFAO2piVhnErczl2V+cTsJUFws2E0WM6HmJVA44loVnevl3h9as7+cFx3ilGfhvOK
         c6EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnivGqSxplG59eJ0FXukLarGicKuBeVK7/U3k5a/R9xJafz0nUd481MtsnACoEt6hrf5RJlTNMXvm258Jo@vger.kernel.org, AJvYcCVynRwpTrjZtOdmB+rBnffeSIXEzWadiJ+c23b6IZ97YEV1phbblMI8cFVd5grOPE/4dsh2qmNGq9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1WlB3jSZbV8rSakjwQV45IAh86iZ8m8rEiBZjFXN4zEdwNBO
	UutxvuR6tyiHls7Y6jR6jzZz7jTE8t9yR7vRuzAqLgeeg1sBVxw9
X-Gm-Gg: ASbGnctYRnFyLiHLwcw4/vsJ8y+vvYOp2SAhHPYU3B7ndcdfMlCCqOunFc9cIMBQ2uK
	PdK80V8HFUT3Cg3GEaCBcM3zdz8o3Y8WYSKsibw3g50qZsG6Hx79eNRvwhMmKn6ERxH8cWaX098
	JzzF58ZV42Oh3iHeVqh8p2Nh/TRLQfZsRZf6EN5F4VN/9djYFQ4Z/TDU5HpT+umrTAyZELlnLaT
	AAqFMGdFhjTQEB2CCmxT2jFXAWsW48lCqn225ggX88vIZTOlinKbdbDrUnOG/TwXUNpsd3+96pN
	HljqYi8dhoBENBYvM2KKakGzUNw/YtsCBVERBMlPj7uHQNjTw2k5HJLlgu1MxE+4147x3BwUTvD
	P
X-Google-Smtp-Source: AGHT+IFxu+wrVhfEVT8cCB0ir0iWaCgndwkZbG4SSj2thQFSs6iocsTV1JOW+m5NOZg1uWD5oxd+1w==
X-Received: by 2002:a05:600c:1d9c:b0:436:1af4:5e07 with SMTP id 5b1f17b1804b1-436e2696d35mr132043645e9.1.1736691016905;
        Sun, 12 Jan 2025 06:10:16 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-b3ae-4f78-5cdc-b04a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b3ae:4f78:5cdc:b04a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dd1de9sm112356255e9.15.2025.01.12.06.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 06:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jan 2025 15:10:14 +0100
Message-Id: <D705L20050OB.3UOW9R2QA4QA5@gmail.com>
Subject: Re: [PATCH 1/2] iio: light: veml6030: extend regmap to support
 regfields and caching
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rishi Gupta"
 <gupt21@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
To: "Jonathan Cameron" <jic23@kernel.org>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.18.2
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
 <20250107-veml6030-scale-v1-1-1281e3ad012c@gmail.com>
 <20250112131845.539ecc7c@jic23-huawei>
In-Reply-To: <20250112131845.539ecc7c@jic23-huawei>

On Sun Jan 12, 2025 at 2:18 PM CET, Jonathan Cameron wrote:
> On Tue, 07 Jan 2025 21:50:21 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>
> > The configuration registers are not volatile and are not affected
> > by read operations (i.e. not precious), making them suitable to be
> > cached in order to reduce the number of accesses to the device.
> >
> > Add support for regfields as well to simplify register operations,
> > taking into account the different fields for the veml6030/veml7700 and
> > veml6035.
> >
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> >  drivers/iio/light/veml6030.c | 141 +++++++++++++++++++++++++++++++++++=
--------
> >  1 file changed, 116 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.=
c
> > index 9b71825eea9bee2146be17ed2f30f5a8f7ad37e3..a6385c6d3fba59a6b22845a=
3c5e252b619faed65 100644
> > --- a/drivers/iio/light/veml6030.c
> > +++ b/drivers/iio/light/veml6030.c
> > @@ -65,6 +65,11 @@ enum veml6030_scan {
> >  	VEML6030_SCAN_TIMESTAMP,
> >  };
> >
> > +struct veml6030_rf {
> > +	struct regmap_field *it;
> > +	struct regmap_field *gain;
> > +};
> > +
> >  struct veml603x_chip {
> >  	const char *name;
> >  	const int(*scale_vals)[][2];
> > @@ -75,6 +80,7 @@ struct veml603x_chip {
> >  	int (*set_info)(struct iio_dev *indio_dev);
> >  	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
> >  	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
> > +	int (*regfield_init)(struct iio_dev *indio_dev);
>
> With only two fields, why use a callback rather than just adding the two
> const struct reg_field into this structure directly?

The rationale was that extending the driver for more devices with
additional fields would not require extra elements in the struct that
would only apply to some devices. All members of this struct are rather
basic and all devices will require them, and although integration time
and gain regfields will be required too, if a new regfield for a
specific device is added, it will be added to the rest as empty element.

But that's probably too much "if" and "would", so I am fine with your
suggestion.

>
> I'd also be tempted to do the caching and regfield changes as separate pa=
tches.
>

Then I will split the patch for v2.

> Jonathan

Thank you for your feedback and best regards,
Javier Carrasco

