Return-Path: <linux-iio+bounces-13846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4489FDB99
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 16:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E9F188255F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DCD166F1B;
	Sat, 28 Dec 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNOQIPvn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2A35974;
	Sat, 28 Dec 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735400930; cv=none; b=G/Lhz2Lvy2fM4Y+WkpDde+Y5WW99VmLl3wYfQcfX8ftYHVJaQKU+69MuQXnCMGvfE6HSLwR9N4PHigS/xUQEmwSZt61DbQXHHGsYdV1inlr5ytBSx90pNdlnEHtk8sKLaMdRRe77HwnsBRb3OjpxI9BJsIbi6fDSh5X7Ivs4WEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735400930; c=relaxed/simple;
	bh=Nw3L7MLQ+tyPLILkAtDl4C2iVwnfWc39qzaJyAgId8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YY9uHURiFbJfbKvmT+gbLV40jPKWvtCyeGKHWG4yzAcw9j6QoLnLNjaGNq4Mx10NK6gOxjDdwJ1q48VyiSdAKmut4e6/FO44BZz8/i4wYelZy21z4+3mxR7GLG8GOoPodLCHALd0zb4IOeva2ZmPpfsD1N5+c9Q7InBbpX2rdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNOQIPvn; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3a2f65144bso988973276.2;
        Sat, 28 Dec 2024 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735400927; x=1736005727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvgUswmxw3tDOJ/gQN+m0U9kpjr4h9l94Qnt3dvTpDY=;
        b=RNOQIPvnQedssXiylF/11Rb/fHw0cgyE70LMBsiQeQBL4mF9b5yO52xdj3MT8jCPIs
         YoSqgw1Z038wS4isUchcLVdW+SegYHSFLyHvLh3F+rj32g7w+pZPGum/YOpNu5b1S2s1
         ZYFgfz24IP2Hjm316uaF7fDG298ok6ZmMA2ZOxJ90J5syNwCoFeSs+28UHZj7nPwI/Ui
         rA9JheyJecjH3UJFoDBP1clj7/GrZ9v7jtCUSqRxQUom8qAZkxiqL8K6/U5SRBfu59EC
         N4BdqDjd1wqI7Whx8mdd9ehq9OVId1B5Psg4MYl2nwQemZ7Z4igIVZ/j9v7N1Pg4anOq
         +siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735400927; x=1736005727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvgUswmxw3tDOJ/gQN+m0U9kpjr4h9l94Qnt3dvTpDY=;
        b=Yyg7l0G8vsh0KdIzT/xBgCFPWd7y/zGzdtsbYGScYxX2NEf6pmyxewnl5cPSMaNR/0
         JQZWHKrEAS5PHNwZim/hzNHxEudczCgssD5jRNRo/+v/lp2wLpd29/Zq/DyZft2XlKZK
         1qG81HMJ9NbfZL0QLTNrJlz0AWzaEuagfKMaS9scEgz1PYWnUcHey+5xYd39o0Ayz+3u
         hAb9fU42xBPL7U6uYYbfiAJ7uOi52UmJtvdMD3Nm404gybzzx7CeFCLuWO+Jqoll6Zvx
         gyPMSaWLbxfqpKSvxwd/vZfNfhzY5YFhxPR23XrmXGZuZGBW5BAhF7dQxNxS0SJhoUK+
         PLwg==
X-Forwarded-Encrypted: i=1; AJvYcCVID5wzch9lNT9mU7w8VVGAxRE0URHEyEFOhMRdlt/bHal4mTMV45cRqo5ZadNTDN0nSejrCy2VfjbN@vger.kernel.org, AJvYcCWQbLTfpEzSqZuMK0QHsRIxOYm2ZnmtkstccYjrGN06oNFRKHGsUIwCe5GQ0mOOrEaSYY5NbN16ysETft63@vger.kernel.org, AJvYcCX9MtinTUpvtEgduetUQiYfolGefbZbxipi1k2vTIPrck8Dp8hazkQiT0xeQCzPL2Tf1lnD47MW+YKT@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEzmQ3NEdKO5Ii35zt7/GgaunXRjgt7bC6JUZsCK64Xzk9/PH
	YX15m6ddrPFP0vNvSAugDPzSznuvVT056fJoiI818jfvYxGJTcSK8CGYvrbCZfGVau7XviVxq6a
	aJiCkLN14YH4mIFkHyde0WxdqT8Y=
X-Gm-Gg: ASbGncstmrL2J/OWwmm5q4nyYu6Q5+1TaKhGQs7w3FRghhaq9BRFFcmuKZ4t1v74wfH
	YpJZ9I2/MMWXmRnMDK1Mn3A+e3FEAKGCJ6NeLIA==
X-Google-Smtp-Source: AGHT+IHdZpC1YGp93mLQ+nx/iTl6htJLNwxuarX9IUpcjwgjaaa/AKJfIzdp7YtQPJDW2ejn+6yKiANX90xRsA7PDGc=
X-Received: by 2002:a05:6902:10c8:b0:e4a:ea18:b43a with SMTP id
 3f1490d57ef6-e538c35d562mr10176626276.7.1735400927543; Sat, 28 Dec 2024
 07:48:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241225181338.69672-1-l.rubusch@gmail.com> <20241225181338.69672-8-l.rubusch@gmail.com>
 <20241228144714.2c1db6a8@jic23-huawei>
In-Reply-To: <20241228144714.2c1db6a8@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 28 Dec 2024 16:48:11 +0100
Message-ID: <CAFXKEHb8vMs_en6_iBUG37YyWn90xn8xnz2yrRMB=4rues7BuA@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] iio: accel: adxl345: complete the list of defines
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 3:47=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 25 Dec 2024 18:13:38 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Having interrupts events and FIFO available allows to evaluate the
> > sensor events. Cover the list of interrupt based sensor events. Keep
> > them in the header file for readability.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> One comment inline
>
> Thanks,
>
> Jonathan
>
> >  #define ADXL345_REG_BW_RATE          0x2C
> >  #define ADXL345_REG_POWER_CTL                0x2D
> >  #define ADXL345_REG_INT_ENABLE               0x2E
> > @@ -34,20 +59,40 @@
> >  #define ADXL345_FIFO_CTL_MODE(x)     FIELD_PREP(GENMASK(7, 6), x)
> >
> >  #define ADXL345_INT_DATA_READY               BIT(7)
> > +#define ADXL345_INT_SINGLE_TAP               BIT(6)
> > +#define ADXL345_INT_DOUBLE_TAP               BIT(5)
> > +#define ADXL345_INT_ACTIVITY         BIT(4)
> > +#define ADXL345_INT_INACTIVITY               BIT(3)
> > +#define ADXL345_INT_FREE_FALL                BIT(2)
> >  #define ADXL345_INT_WATERMARK                BIT(1)
> >  #define ADXL345_INT_OVERRUN          BIT(0)
> > +
> > +#define ADXL345_S_TAP_MSK    ADXL345_INT_SINGLE_TAP
> > +#define ADXL345_D_TAP_MSK    ADXL345_INT_DOUBLE_TAP
>
> Why have these?
>

To be honest, I'm unsure to keep this patch within this series now.

Initially, ..... long story short, having FIFO and interrupt handling
now, it is possible to apply and use those ADXL345_INT_ constants. On
the other side, having this more and more separated out of other
patches, it becomes clear there is still some implementation pending
to really use them. I'd like to focus this series rather on FIFO and
interrupt mechanism.

Especially when it comes to the ADXL345_S_TAP_MSK defines, which
probably make even less sense here, if I look at it now.

What would you recommend - Keep it? Drop it? Add just the ADXL345_INT_
fields w/o the _MSKs?

>
>

