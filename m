Return-Path: <linux-iio+bounces-9803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E05A9877D1
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 18:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B07B1F274CE
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95403158D6A;
	Thu, 26 Sep 2024 16:48:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DA3F9D5;
	Thu, 26 Sep 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369313; cv=none; b=enIQoxzLjNheILMUryjQPpGjKgivkui2Cr0eGL0CfVkFolLP0GVeyhRPK2kIeYI5uQwgYiqu9icz9Kt/bx/x2PhMzdb3gcvXIJrDegNX0ezU5a2Pyrzgi3snPI8/nV7DT0VVzbmixSXoJAQ2j0QzXF+iLRrc88SCueFvAP3zpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369313; c=relaxed/simple;
	bh=3iLcjQkH5GQa4HPTVULpyY5LszmMUqJ2M/ZQuLeKLO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6AphV5wlmiuqusKH0It9J+AwGGGFfTUQA7NMEqFovQA9ZM9d9egHe/aZEjjDzytcyZH1zzep87wRYnzL4+Dw2vRLaPVG1/EppseX/O/TNk0xDHOFF607B9cS5KDKUbGfVT0/NvxIfEMm2I00w/+n64FKDZQ2tMYkSqzpN1pHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5365928acd0so1684738e87.2;
        Thu, 26 Sep 2024 09:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727369304; x=1727974104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HubwtGXoHYycyyJ/DTpsXcKHTqyuvb2GHfcFka+zhbM=;
        b=LBkyu3Gg0uM6YdFdsbSOwur6pUFRR0OULLgvCBJk0hVZaGjGA40AqkUa/1uI1+itVZ
         qHO/f6Pl327lRzF/hj/2is0birFqWvA9vD5JmDfOx4YJCbFnzV1O9hRt/yFC6hGml7Mb
         fHcKdgRojD2P4QAzIsHnW9HU7Ap1hNeGHajtpDivW0KSJJDbfg8M+dDs24gRV/xAaQVZ
         VrkyYv0wO8vrflz+h2d6R2wb3bWj/bE3haPSePQZ6M4WHoGFD19c2I9f7wo4MNrQ9zZ5
         If1bFMa8DdS6SAza94aPP5lgIMWFVJNWKs3GHlRs5wfbT6Y5gq7W5FlObA9KESZ6U3Tg
         N4xA==
X-Forwarded-Encrypted: i=1; AJvYcCU25YmfI/m0XckkPMjvxQYfFoICp31eTY7QnkfVU4h/bO7pqdeWe0Np+3TlNmKbujMJS1IP/yNEMzOL@vger.kernel.org, AJvYcCUvdJCevN6xUsUGEcpN0b4z4v7jjNatdmoE/ti8sSPGd5HfeAlcsOSyC2uodfHv0tJ4hyYWln6moSkOb5VW@vger.kernel.org, AJvYcCUyq/WNVOQoCHLolsExfpDBqoK19Oj+w35qim35ViN5XKSsQX0I9BIr3Rw4KDVx++Ii4SSUYHUecK86eyfB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Z8gYuknn/ATfNpfUUuFTq2xc6d+2Y1ZUKfOMMFicn3y32PUW
	ziPu5laVW/uQxM45BqZOURwN2tAAcJ9VcPLKKIqX44xDg3P73AChw0dSv+rI
X-Google-Smtp-Source: AGHT+IHzRpb+jWUFNDOOJweADrvwEZ4tOVH5Bif7f2NJyV7NMSRk9/3D3CkpA3Xd/63dJW1HWfcyvQ==
X-Received: by 2002:a05:6512:1046:b0:536:741a:6bbc with SMTP id 2adb3069b0e04-5389fc43ff8mr213060e87.28.1727369304112;
        Thu, 26 Sep 2024 09:48:24 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a0432525sm8394e87.145.2024.09.26.09.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 09:48:23 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f77be8ffecso14330001fa.1;
        Thu, 26 Sep 2024 09:48:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUm6S9C/NYVMNyOQe3O2Bh6ALT8HtmnDAC/R0911lFBvsIYAdgk4B0XCcTp8iZEBlJEkPkU0odsqs8jCFSZ@vger.kernel.org, AJvYcCX+YrFlyZol9t+nmkdTZ/Ex5IwkOVae658UATVoPUnHFf6CI8iEOLyk8U1Ny64VNkoFG28Rw9yS8/dz@vger.kernel.org, AJvYcCXKlJMg8aLxj2OW+D9ug1oNEKw4vopGZ8osXUReTldmHOxIMJOaQxi7SDGeUqRxprHTszC3gTIN5L5HyvkA@vger.kernel.org
X-Received: by 2002:a2e:be93:0:b0:2f4:f279:36d3 with SMTP id
 38308e7fff4ca-2f9d3e3b935mr2254021fa.4.1727369303029; Thu, 26 Sep 2024
 09:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
 <20240926-iio_device_for_each_child_node_scoped-v1-3-64ca8a424578@gmail.com>
In-Reply-To: <20240926-iio_device_for_each_child_node_scoped-v1-3-64ca8a424578@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 27 Sep 2024 00:48:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v673tM84R=ixndabTmwane_dC+bu5YbNKHi1i+sd+tJksA@mail.gmail.com>
Message-ID: <CAGb2v673tM84R=ixndabTmwane_dC+bu5YbNKHi1i+sd+tJksA@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: adc: sun20i-gpadc: use scoped device_for_each_child_node()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:08=E2=80=AFAM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for calls to fwnode_handle_put() in the error path.
>
> This prevents possible memory leaks if new error paths are added without
> the required call to fwnode_handle_put().
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/iio/adc/sun20i-gpadc-iio.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-=
gpadc-iio.c
> index 6a893d484cf7..136b8d9c294f 100644
> --- a/drivers/iio/adc/sun20i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun20i-gpadc-iio.c
> @@ -155,7 +155,6 @@ static int sun20i_gpadc_alloc_channels(struct iio_dev=
 *indio_dev,
>         unsigned int channel;
>         int num_channels, i, ret;
>         struct iio_chan_spec *channels;
> -       struct fwnode_handle *node;
>
>         num_channels =3D device_get_child_node_count(dev);
>         if (num_channels =3D=3D 0)
> @@ -167,12 +166,10 @@ static int sun20i_gpadc_alloc_channels(struct iio_d=
ev *indio_dev,
>                 return -ENOMEM;
>
>         i =3D 0;
> -       device_for_each_child_node(dev, node) {
> +       device_for_each_child_node_scoped(dev, node) {
>                 ret =3D fwnode_property_read_u32(node, "reg", &channel);
> -               if (ret) {
> -                       fwnode_handle_put(node);
> +               if (ret)
>                         return dev_err_probe(dev, ret, "invalid channel n=
umber\n");
> -               }
>
>                 channels[i].type =3D IIO_VOLTAGE;
>                 channels[i].indexed =3D 1;
>
> --
> 2.43.0
>

