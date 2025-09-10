Return-Path: <linux-iio+bounces-23968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABADB52248
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 22:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A11C866CD
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E392FB62B;
	Wed, 10 Sep 2025 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCc3TpYH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB702EF661;
	Wed, 10 Sep 2025 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535902; cv=none; b=iPDTsuP1eJ6iN641EWfDXCHs34Z6lDuFe7R3/NEYqkVKDPn8hB/Jw/YOnHzwUT9gfwvoktW+PEC1qqmIaEiwI7dS8RO+ryQbrVBkptWCuR7ecJQEusMLcV8V00MVZA21yWxnY82EzAxBX0SO9LsQbEDSD/UBEuUbfGfpurxrRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535902; c=relaxed/simple;
	bh=LN/Pm2aI3unWGjOpaEmse7ymvqMA+LS9/qIBzvcXW8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=app4mfwjiuBHvdg32cdH8uIs9FVxlty0ezpo/SPNZgR3iHX0ULWSNpXVMsbv75Wj0SCKaa3219YQfYpUsXH2GTzeItCebdy7e6Hgcg+7BKO3yWGKek3pWCBWCKTdjuDHCfgSDHmaF4YnwKBtF2ZU5SyOtWY8Z4i9Ng2hd2xkfiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCc3TpYH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78ead12so1023200466b.1;
        Wed, 10 Sep 2025 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757535899; x=1758140699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN/Pm2aI3unWGjOpaEmse7ymvqMA+LS9/qIBzvcXW8s=;
        b=LCc3TpYHIO97dd2ysGPeYxDZfs7kZ3vcV6yxhLXmyIcKp2Q+aS/sXBvbm9jW5CuO6Z
         wXRDWeUKhFDiSq8kkHJAxQt6CM6KHPRtZFq9QOgXq7YkwqI7z4NRukU+PwG9UtwkrJma
         TFAV2cfndlfTDm7E4g67xEZ4m2B9a+JWg4gysK8aWY1sBJLXaxsV+PQse4bBDu5rSZyH
         KdqqTv5GqKV1DRP0+zE/JeUwLphCv0EzpPaPz62V6Hbh0TuuL/pGMWB6PdueSSfl6NBN
         F8GE1uFEIM9DnVpFawvqScJtt/jbgRW30S5+sLR67dHDG4lKzRuIu8AFiGfZP+DYiWFY
         nChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757535899; x=1758140699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LN/Pm2aI3unWGjOpaEmse7ymvqMA+LS9/qIBzvcXW8s=;
        b=VKalyUMUL/OzBWW0G3ezHFdo5LdB9GWucpmwcDChYigav2lxjwAxnheziSXnjNIyFp
         /9dq4bnRwvbMSEujgxLn77YX1T2Pf8OMBCh18Box5+q06vUpH6xolyyQggnVcAOOmDx1
         E9ctZ7/Wcn0ZMGVKv6ELVo0DG7aGlgQEgz0DnvmAawVhynr8IXPOf3o9e6BIKII/gLvR
         k1bsJAf1qfcy9IkDrPgd6QBRnivzXqQn/RrCXJ890XYZ1uhgA0bUgGqPSyBns7X3uv5m
         GmGheuEVmFN6VWbH3t3v8Bu61rl3zIDZyEkPVGUHYvwCZMSRMwhNQejMi0cSAJUlEc8L
         34zA==
X-Forwarded-Encrypted: i=1; AJvYcCU6nnRj7k59jYqDmvQkB99X/kRCP7Kd9pltRTVipXPMAhH+HFDJvtVtRPKNCdFTuBScWZwDZ9sI884=@vger.kernel.org, AJvYcCWl2U4xsAsC8inFOI9AxotBlzsi4VeuwWmFIdQB29hNAZZgpK4ZqizQYFNeLmzOXJPPp/A3fYYNyyS6+X0G@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8FKsY3QD3rugaz4sd0uTMy+T8rs7EO7b5YPKZ/7oY7syMSUn
	ZwxeOKTYlnJ5cMsOMEtqzVXyc3vZT4b0l61EmoJYdPY2kRPScelnahWxIc+LUCCgZWjZpWVPJy0
	NUttmUpIlQtO0qnmPrnU2CBgNIAyUf28=
X-Gm-Gg: ASbGnctRDCDY7J5Se64I6kk3tqfRvzu2qOfV3VOm6GPkjoqYNgQTJwTgsDGFlXjcVQC
	32XzWfaSn6iFd3vbcEgiMpzvs5ghpkOvJ3h/PJ2U8YEGHrq+2gNL7+DjyjS1w9pqahSBo535oCv
	s3s8BkDgr7so/5bu8SXRLva8JaUTwOkkiITbWHkEFWSBj0NH/r+lbfqBeXvPqFVjV/LM4ESa+uP
	UcKbcM2vHlyeBh+Kw==
X-Google-Smtp-Source: AGHT+IGBsTe8YlXdloB6d1QMc4VNEWTut14w8qqlJ9oDkQ88tR0CVNqgs5k9wYhiqlwu9RRj7n4D3wOUrVlpb/uhwiE=
X-Received: by 2002:a17:907:9721:b0:b04:241c:e70e with SMTP id
 a640c23a62f3a-b04b1452820mr1737673066b.19.1757535899125; Wed, 10 Sep 2025
 13:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909194649.10512-1-akshayaj.lkd@gmail.com>
 <CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com>
 <CAE3SzaTZ8PXM_B8FBetOTSfz2myGZ=WzPp8h2d79Q95zKLq5hw@mail.gmail.com> <20250910201212.5d9f57bc@jic23-huawei>
In-Reply-To: <20250910201212.5d9f57bc@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Sep 2025 23:24:22 +0300
X-Gm-Features: AS18NWBK41AZZ2Dj4c-vwky0-M0fZ_qHwr0WtyVqNC3GsukO78bcqi7Ubbo6Tfg
Message-ID: <CAHp75Vf+9PJgR5Eev_Z+QB4cp+VMctFfqpTMWuE3VsnGpZ6dJQ@mail.gmail.com>
Subject: Re: [PATCH v7] iio: light: ltr390: Implement runtime PM support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:12=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> On Wed, 10 Sep 2025 18:06:32 +0530
> Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> > Thank you very much for your valuable feedback.
> > I do have a small request regarding the review process. Over the past 3=
=E2=80=934
> > versions,most of the comments have been about fixing indentations and
> > improving code readability. I would kindly request if it would be possi=
ble
> > to consolidate such cosmetic comments into a single review round.
> >
> > I completely understand that incremental feedback makes sense when the =
code
> > is actively changing, but if the changes are minimal, spreading out min=
or
> > suggestions over multiple review cycles tends to unnecessarily increase=
 the
> > turnaround time.
> >
> > Your support in this would help me address the comments more efficientl=
y.

I can't always see _all_ problems at once, I am not a robot. I will
try my best, though.

...

> Andy, if you are fine with the explanation I'll tidy up the minor stuff
> whilst applying.

Yes, I am fine, go with it, thanks!

--=20
With Best Regards,
Andy Shevchenko

