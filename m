Return-Path: <linux-iio+bounces-18073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7CEA87B25
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 10:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A50A17197A
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB76D25D1E5;
	Mon, 14 Apr 2025 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a39qDegs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13E25A355;
	Mon, 14 Apr 2025 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620987; cv=none; b=Q8uUq4IPtgbtg1ShUq2Kg/KvMYjT74bRM0aM5fEzcIDwUKbOttQvcLxRyOfvG1KSQFlj6t/r4V+8o17iFkT+tYtsS9ieufQd2xKYHCt+zgKqOuzMoLtB/Kq/RSujRhzkw7YkjM7d6hinZa5cfbQT5NtREDVsXLQBOsGg5TGfAbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620987; c=relaxed/simple;
	bh=9nKetgLd1pP26byrqLLmd5uxLkuBuAPIkYK3ELpWW2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCj2TCNAjE0O0Xf5GAev8ZQBC5eSgQzn7ei4s7TeAiTjcSAg0ZnN5XUeHYYXj3wGiaLiPlev7FIg81ZT4p9FZqildr4eqFZhoYqsS9TJO55ig4hwWibgaB+hMiY7aLcsHUWRzAqum/+UNU38VDVyCr0IT8+xqGMufXUDM23cLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a39qDegs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22548a28d0cso59348865ad.3;
        Mon, 14 Apr 2025 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744620985; x=1745225785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OzwDFeJOLmDRXEsLyOKIGhS6ZtI1sECvpDeikK6v/kQ=;
        b=a39qDegsnxbSTDKKyv2CjdmGoJEG2/4iqwpP/HmS3MWDfSN1fSegcJCyLN+RL6Sm5W
         fB1N63W88FNdOa64JpesG7gqs5ZEIKz4URsIIWVnjTklp6G+5PFFAYbb0M5TqLFmVwb5
         +yjxu4yN0OeLorV8OB/+op85pGd7oKgtEgw8MmSm1jxNvK9VXYAs8AOVGk1rlz3zTjxS
         KgulEHwkN3F4IRVly76K813WvsU7Ezh/+5qVFWaHhrWJzrWMtrX2qH/JgV0Y/dSqYHuk
         Ju1dBphNH0XZVXHPRH1CJ1mi1ypJYLtdFcop1Bo7xLPcu4wydMbyVxXav8r3Zpws0MK3
         ZmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744620985; x=1745225785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzwDFeJOLmDRXEsLyOKIGhS6ZtI1sECvpDeikK6v/kQ=;
        b=rDi7UYnO7LisZBVo7lZPLAzlY+BFiPyP738gMCD9tHei09+z8CU8WR3Tr+Rj9/mxGP
         RHS7p0dwZW5YCuKxWl1vSadCEHbg9cCdp8UZhMvpH28Rw+9GZFRpwehUfaktOo5E3RXK
         bCEaCrLiJviVcZUPmMA9AiMbf+CVQkTg7wEgsowK5mJOIlXruUga55HeA+LHMsTxlXRL
         Pol1uoovJqHp9uwVFFsNy4/JfKsjVnLLvvQ7awTYs0om+HNX+r+DSL3LemWdO4WzudSq
         jFZeHZZ6NQzGgWZPiITIL4Bxx0v/lwGp3ROocGlixjXwo3DHfhfr7G8GYlPOXDOSY+Dh
         P8mg==
X-Forwarded-Encrypted: i=1; AJvYcCV0/sPhYqsPGjmJOevb5s3oiajdZcPRlw7GhbAdg5T9M5DdDWNCD+OpKm4bXHWjrg2E/DtxoXd+0Ngo@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDE26GmoyoWJbp8CAVUUV82GVGVa3Mxm0qN+NymLYebRsRyw1
	w/r3WtELfjPtusMAz9YBLJOjnhRPIVI3h5zv0+8LRiPQB0UXqMvzFzypwqDaQoSS2KHZfrrlXWs
	7uWb7q02y9hl+9ONLrfwILsK5uYs=
X-Gm-Gg: ASbGncv3UsWprxhsrh22i5Nf/gsv+5GD9Wrd7y6nZuLWouyuztQLTcJ5y/+5aS7dmAa
	WYjAqbgCFB8N2BApGM0sZsZWxMLR51LCVglvT8akw76Ga9jkAcSH/lzC6MIlsPxRN3nVyF2tOSO
	mp5SSQt11dvU28O8ZUm+A29xk=
X-Google-Smtp-Source: AGHT+IFxTTAS8RmZE22s9C6sP6aymyZGXwoTQmLVi6hiha9wUiQfRlyLERMt+JOvNCgH9VIqpYTLLkROw/eCTmW/Ahc=
X-Received: by 2002:a17:90b:254d:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-30823639ca2mr22111008a91.12.1744620984897; Mon, 14 Apr 2025
 01:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409024311.19466-1-gye976@gmail.com> <20250409024311.19466-5-gye976@gmail.com>
 <20250412163825.250a9435@jic23-huawei>
In-Reply-To: <20250412163825.250a9435@jic23-huawei>
From: gyeyoung <gye976@gmail.com>
Date: Mon, 14 Apr 2025 17:56:13 +0900
X-Gm-Features: ATxdqUHv1TDp_wW6h3e3zVg2M2XYKKP7auZ-3JandTjQSVMOWjlQi3eMkI5YoTI
Message-ID: <CAKbEzntgn3dRgbniRRT15vN+J4BMxEQ7ObgxvwWroKD54uf43A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: chemical: add support for winsen MHZ19B CO2 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Jonathan, thank you for taking the time to review my patch.

> > +/*
> > + * mh-z19b co2 sensor driver
> > + *
> > + * Copyright (c) 2025 Gyeyoung Baek <gye976@gmail.com>
> > + *
> > + * Datasheet:
> > + * https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
> > + */
> > +
> > +#include <linux/cleanup.h>
>
> Do you use this?

Sorry, It's not used, I missed that.

---

> > +#define MHZ19B_CMD_SIZE 9
> > +
> > +#define MHZ19B_ABC_LOGIC_CMD         0x79
> > +#define MHZ19B_READ_CO2_CMD          0x86
> > +#define MHZ19B_SPAN_POINT_CMD                0x88
> > +#define MHZ19B_ZERO_POINT_CMD                0x87
> > +
> > +#define MHZ19B_ABC_LOGIC_OFF_CKSUM   0x86
> > +#define MHZ19B_ABC_LOGIC_ON_CKSUM    0xE6
> > +#define MHZ19B_READ_CO2_CKSUM                0x79
> > +#define MHZ19B_ZERO_POINT_CKSUM      0x78
> Can we not just calculate these from the buffer contents?

Yes, we can calculate it simply, (actually previous patches did it in that way.)
I'll revert to that way for readability.

---

> > +     switch (cmd) {
> > +     case MHZ19B_ABC_LOGIC_CMD: {
> > +             bool enable = *((bool *)arg);
> Given you could just pass and u16 for the argument and use 0 /1 for
> the bool.  The u16 works directly for the ppm value where needed for span
> point

I used bool type for readability, but on second thought
The consistency of using u16 type seems more important than readability.
I'll edit this.

---

> > +     st->vin = devm_regulator_get(dev, "vin");
> > +     if (IS_ERR(st->vin))
> > +             return PTR_ERR(st->vin);
> > +
> > +     ret = regulator_enable(st->vin);
>
> Don't mix devm and non devm calls in probe.  In this case you introduced
> a race where the power is turned off before we remove the userspace
> interfaces which is unlikely to go well...

Sorry, I missed the existence of the devm_regulator_get_enable().
I'll edit this.

Thanks,
Gyeyoung

