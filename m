Return-Path: <linux-iio+bounces-6134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F918901ACD
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 08:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D56CB24027
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 06:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A979C45033;
	Mon, 10 Jun 2024 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQABKIef"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9FBF9E8;
	Mon, 10 Jun 2024 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999138; cv=none; b=m0/qXVdzip+C8PMPEp+NmRRON4StKjzjC1HN/2HrV5nOlKjUqzdii4X1Njmlzs4itjzha1iS3GROe1eH0ITP+GETAaKXXzwlfo9PPlkpRQGnvTsAL4X5ahX4ZupmetMcFqmI/jQ+gmWE99wQsamIb50cjkBxOyGc5UAiwH2HNmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999138; c=relaxed/simple;
	bh=5sPxgNb7QXqMc4Oi2NV5XP2Q5AV6CY3tLZJ9mDEwS6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3bu+mwEXp0Vuhyz34GeOChXlcx1eYcL5QcifHx3+OiSDYbS0gUJFUPzrCcAxh/6m4tXQN7/xeSXxdx6ANd/8ngRy/nREARb0tnXTLBbwYrcOwpF0vFbP/93miNb+9iZDaH+fpMAUA6cun5HOdN0EnroAdkHNnTpCJKyP6Eo0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQABKIef; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c195eb9af3so3038845a91.0;
        Sun, 09 Jun 2024 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717999136; x=1718603936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5ohG+dnxK58rDxnX6ohZaoZPwLRCAnxJI0xnrHXGNU=;
        b=cQABKIefVCOzXr2rox1+T8wJAh18xfy2AJUoA+oQTf8GLH5hwcDi0oqU/ZJlGbucwj
         GvC2WKZjE02ZycTGlMewXMnPjRWtT+nts2eWhAejAEeqapfov051tT5RHf4OqAncrFpf
         d06oQjjUc6ZQeU1o76qh4IY3Ze3FquNbpLAkYiDPt7eoNDZZPZsFrJMkNjp+kuzYHXpQ
         f9F+MPwSpkUWeUPrzZjZiiDxARWvpKKGknZ/yndrlSXOxQPtkrf6dW4WYeZBF7ZT/Lnf
         ODH0Icn0WXx4VpMN7CUiU5FnSd6i9kOC81+81m/CXmSilhg8Zqx7UQIpG0A852JQ72sx
         bE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717999136; x=1718603936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5ohG+dnxK58rDxnX6ohZaoZPwLRCAnxJI0xnrHXGNU=;
        b=SEzJ91oSyVLnk6puXd2Knw1bY/qnKcNXSDZlZ26OvGO9X2OyENvijuT4zY49YFlD+2
         YiP/609fGuOBO/SEyWBs2Ziwg1lfp5g4wiGJECAk90x8hjXfnGxNdtle4REBLfIp6EDt
         ZX/twdFHE9s6ZFx3/yyJKO+z7P0hZFCLXX+1kEpwyaCP0n6ENIhfc2KuD+ynrw5N/4En
         Pgxhe2DgpiCgM6h6ec7CLhAQ9098c7IkjYlvmJ8JvqggQUb0NnXVvHDHZbAlHFIjEhVn
         /e9v4tGONylfb61+1NiSVHf+PmzJHA7EDaEyYYove3R6pql5F2+YzwwndRStlHmuWrvC
         CF0A==
X-Forwarded-Encrypted: i=1; AJvYcCVCUZOIFSw9gv0Hj3xkoSLD5kXjTaKMIjZrz8+JRJM+H4Tg67ng1gZ2yVfyLDbWzYO5rav/Xr2INDW6Gt3CYiXt303M+InudIW5F0MukBD5GyUAlfVhaW2f/cV71+lDAoAdsgzPb34+m2QDC5vSf2F73d5XajzhOaTjf0iG1hmejbtY+g==
X-Gm-Message-State: AOJu0YzwzdysnL6itEOTzK5ugbDo2x+yMH+h6eKT8QPyAHOwiY0+LrWV
	EjHpNudZtIU8dVthXfKGbvbGcTWJjpbKXrNuvnstYgdelpCUce+OoLbZSQLfP+oWgP8gMo9UtRj
	ErEPqcW3weMN8cftIx3zkpIQ7sp0=
X-Google-Smtp-Source: AGHT+IGDKDQOkgqMhS7o7jBkgNM6RNRKZtE5gDaGYIq2pn1N/abNFj6XqC13hPSeaarIJCe9b88AxWZZuVUUNhIhOrw=
X-Received: by 2002:a17:90b:4fc7:b0:2c2:f6e9:54fe with SMTP id
 98e67ed59e1d1-2c2f6e95818mr2373559a91.27.1717999136165; Sun, 09 Jun 2024
 22:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606162948.83903-1-muditsharma.info@gmail.com>
 <20240606162948.83903-2-muditsharma.info@gmail.com> <20240608172227.17996c75@jic23-huawei>
In-Reply-To: <20240608172227.17996c75@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Mon, 10 Jun 2024 08:58:44 +0300
Message-ID: <CANhJrGM9czj0RL3OLCgRHEKc2QOjG9P0AZTrZxvYUk65TCpHRg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: light: ROHM BH1745 colour sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, lars@metafoo.de, krzk+dt@kernel.org, 
	conor+dt@kernel.org, robh@kernel.org, ivan.orlov0322@gmail.com, 
	javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

la 8. kes=C3=A4k. 2024 klo 19.22 Jonathan Cameron (jic23@kernel.org) kirjoi=
tti:
>
> On Thu,  6 Jun 2024 17:29:42 +0100
> Mudit Sharma <muditsharma.info@gmail.com> wrote:
>
> > Add support for BH1745, which is an I2C colour sensor with red, green,
> > blue and clear channels. It has a programmable active low interrupt
> > pin. Interrupt occurs when the signal from the selected interrupt
> > source channel crosses set interrupt threshold high or low level.
> >
> > This driver includes device attributes to configure the following:
> > - Interrupt pin latch: The interrupt pin can be configured to
> >   be latched (until interrupt register (0x60) is read or initialized)
> >   or update after each measurement.
> > - Interrupt source: The colour channel that will cause the interrupt
> >   when channel will cross the set threshold high or low level.
> >
> > This driver also includes device attributes to present valid
> > configuration options/values for:
> > - Integration time
> > - Interrupt colour source
> > - Hardware gain
> >

> > +
> > +#define BH1745_CHANNEL(_colour, _si, _addr)                           =
        \
> > +     {                                                                =
     \
> > +             .type =3D IIO_INTENSITY, .modified =3D 1,                =
         \
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),          =
       \
> > +             .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_HARDWAREG=
AIN) | \
>
> Provide _SCALE instead of HARDWAREGAIN
> As it's an intensity channel (and units are tricky for color sensors give=
n
> frequency dependence etc) all you need to do is ensure that if you halve
> the _scale and measure the same light source, the computed
> _RAW * _SCALE value remains constant.

...Which is likely to cause also the integration time setting to
impact the SCALE.

You may or may not want to see the GTS-helpers
(drivers/iio/industrialio-gts-helper.c) - which have their own tricky
corners. I think Jonathan once suggested to me to keep the
HARDWAREGAIN as a read-only attribute to ease seeing what is going on.
For the last couple of days I've been reworking the BU27034 driver to
work with the new sensor variant - and I can definitely see the value
of the read-only HARDWAREGAIN when we have per channel gain settings +
integration time setting which all contribute to the scale...


Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));

