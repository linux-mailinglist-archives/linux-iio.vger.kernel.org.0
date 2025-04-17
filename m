Return-Path: <linux-iio+bounces-18192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB2A91F10
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166DF19E7605
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F36225787;
	Thu, 17 Apr 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nke/xMIM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC815A8;
	Thu, 17 Apr 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898607; cv=none; b=UPERYbK/zEXt5uOFD2gKV0eunPFZDQ1tsSSFFUy1W1tVXwA7QqUA/ozbUPb++WbdSG/sEQUfpXz5yBfRLmGqwmVG5L8evOdASY0C54joeEcHu0o9Vk0vLRF6mapdKwTHVOakdWXzAngVqYmnsMTCJ8XJZM48QeEWkYcZIVRRVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898607; c=relaxed/simple;
	bh=tg6lxn/0c6GzcUJJbLDvNAbwDc9WTI0n3YBgb+UnX+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jiils4MzWEbuLxOnhMs7mk+rW2CjgbLNFJaWhBcc44rY3v9fd9YBQvY9+Enzlm/RXHOx7GC5dZP5wJ2wzsCAxPnmfE+yM+KrkfNBg8BngpTkQvC35ft0mFB7133exCJCk3dASq1FtDcSFGRK10QBDRfNvTo6Av1HUFPbIeuNBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nke/xMIM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c336fcdaaso9437405ad.3;
        Thu, 17 Apr 2025 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744898605; x=1745503405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMBQgix4s+dpl5DKXb1+uyQirwJAQulDcZ6m/BvKdfY=;
        b=nke/xMIMNkhkkBwM2zrq0y0JR7XHSmXAKxJvYngJciAgYO3zGpSC+JubqcbH3ZpkHt
         7uDjNV5JpXLPh3Ytk3StM10VlF7fLqA7Ia+UggLYcqUrfc885IyAIZrNU53/i5mJpNPU
         X80jZtDUNbts7DgyGEVds0njtSlDgIYLx/2Y7kpVVEEbr3YN59uPKZJxrh5846g3mjQq
         Y/UjlABcjwBgnVfuIOLCM2ypu4sQuLNvJTIYIZMbwhaE2FGGrPXz5uc/PYctJ8qLjtaw
         m+yRTIPHPRILG42sokmMQR4ZeiNER8rdtht1VQ4q59zkAVrStuWtetDYnIyMz+mXG37S
         d6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744898605; x=1745503405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMBQgix4s+dpl5DKXb1+uyQirwJAQulDcZ6m/BvKdfY=;
        b=hP/vdv4DpKW/mEHNAvvdzsNzhBLwJzjHrlKrQnJa/WMgxVuXx9sEMSuCfsO2lBxzM1
         jSZRpbZiDGI/vtAokw7yjY/HeyRMI5vOPHxgDbi9PddLRjCv/b0dIgDx2uSTTG7n23Yi
         Nn/SAZyzgw9GKm1i80kgBpJYMhD7RngTM+qjR2G2zAwEUB5bTKpvG5k8pbnuX9fe5gYE
         63GNhCPVBEPv9m9i/XvBAff68Xg9fNdk7AfRrJjwehalTb31x2xUQ9t5Emk4Ld9nh6zV
         iZs70Ym4TTjMI5VZH/6ATKhReWKxXD4sMVs/ftPJ9GQ44fiBGMETTUtKBpQ+YJ0xTzTM
         VAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/pqdDbhco5F0Q3Nr8njGteM9lgkcskkKy7W15NdriQZF5+WqoQz7aMDW2Ho3lsKxmn/5kAeL/D/YI@vger.kernel.org, AJvYcCW0KaidnpciJWIgVZX06V/60XLp3bw5JrqJf0ZToLhobZ7S70jg+hT2U2WiX+FFUF+I38Eoi8YhlIWe@vger.kernel.org
X-Gm-Message-State: AOJu0YyYB40qTES5xf3LYoOCHStVo1B1QcqxNSBt5aVdc3ErEmAbRt2h
	tXrQ0tMNwRT51oeevaNawZYpuMKJNR/Gy83z0VsSMSuGaO+WxM8epeYvQTytVCQ3zDVboVavHq4
	pnFE9xkU5cRvhVuvQ15855vTaSvzyLNRw5nw=
X-Gm-Gg: ASbGncuQ1Eb4oEzbvUpllAIlQuUcqOSTBdbV45ueXQOi/zVl6jmAOJ8LgrCu+8ugSjx
	uaOMbALjogQF7xjeokCA5sgf2k13/b2iYEwXBEDNEEB+PvjSmgLjE93jVPdcV6Y1GYX5ryyxfIV
	BC8e2LxGgN/2RpUIoojAzfSSY1QbHqZu6N1Q==
X-Google-Smtp-Source: AGHT+IEV2fdOUDM3sM0hXryldyDa5R/A4Uznl5LLKsrpLk/SGGGDAbM3DkEno/Q1/YHBq/9Xozp3jhL1BsKIDkglZu8=
X-Received: by 2002:a17:902:f687:b0:215:b9a6:5cb9 with SMTP id
 d9443c01a7336-22c358c5000mr103419095ad.5.1744898604830; Thu, 17 Apr 2025
 07:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409024311.19466-1-gye976@gmail.com> <20250409024311.19466-5-gye976@gmail.com>
 <CAHp75VfMHdw-6vrELbjjD3T323uDz7U9wRP5YSk2jZ26wBuLTQ@mail.gmail.com>
 <CAKbEznsVxexdrXX72G-tCUHjznx6na1h8MrCFPKrHd27GXht8A@mail.gmail.com> <CAHp75VeU5sERbVz-4OxkJNC-pjT3B5AvfAMj09LXd6v4MdeDeg@mail.gmail.com>
In-Reply-To: <CAHp75VeU5sERbVz-4OxkJNC-pjT3B5AvfAMj09LXd6v4MdeDeg@mail.gmail.com>
From: gyeyoung <gye976@gmail.com>
Date: Thu, 17 Apr 2025 23:03:12 +0900
X-Gm-Features: ATxdqUEWCL5Fochja0JDCfqpeHB-AUD1oUKGdsUZbhhiH8kAXes1kXqCzWAejmQ
Message-ID: <CAKbEznvXdfszfiuXma_GWhYLwj7mR_WX_H4r6iHZWKp2=41tJw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Tue, Apr 15, 2025 at 2:21=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> > > > +       /*
> > > > +        * serdev receive buffer.
> > > > +        * When data is received from the MH-Z19B,
> > > > +        * the 'mhz19b_receive_buf' callback function is called and=
 fills this buffer.
> > > > +        */
> > > > +       char buf[9];
> > >
> > > Should it be DMA-safe?
> >
> > I'm not sure if I understood your point correctly,
> > This code isn't DMA-safe. I'm currently understanding why DMA-safe is n=
ecessary.
> > (but actually other drivers implementing 'serdev ops' use non-DMA-safe =
buffers.)
> > I will verify this part and then send the next patch.
>
> Because some of the UART drivers may enable DMA by default if it's
> available and your code won't work on them, right? But double check if
> serdev makes it DMA-safe before use.

It seems that the serdev buf doesn't need to be DMA-safe. I looked
into the PL011 driver as an example,
which uses DMA, and found that the data received via DMA is firstly
stored in the buffer within the 'uart_amba_port' structure, and then
copied into the 'tty_bufhead' within the tty_port. Later, in serdev's
receive_buf(), it simply copies from the tty_bufhead to into serdev
buf. So I think there's no need to consider DMA-safe in the serdev buf
itself.
would this make sense? If so, I think there is no need to change the
code related to the buffer.

Regards,
Gyeyoung

