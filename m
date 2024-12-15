Return-Path: <linux-iio+bounces-13482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A09C9F22FD
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 10:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC96161A95
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F67E1487D1;
	Sun, 15 Dec 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8c45/Gz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C21119A;
	Sun, 15 Dec 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734255214; cv=none; b=HfuZ3eGO0wr5cw2yrMKXeKcaBlNugwy8/XKhj/s6lcRiGBqKbHKL6TE7YJ5cTWxJ926UIjX0Ajxb6+2PgniEJrhiuvR8GihZpK5o1DOTW5bxa/gBi4rBXb1UU5ztJeiZvm60TfLraEm4Pl7l6IiKPwh/aa4xGMpoAUjrTsklo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734255214; c=relaxed/simple;
	bh=AHATrrDBkkCIxWj2qXmnICQsonRJlBJhv+Ko6y9iRts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syN7/BjLRhO7qgowOn6uIamG06UWcbl4WJRH2zDjtUKVcdYxCQfUNcBRyzebJO0dSBRPJ/TgEy77np/XTQeFDck8LlLyorXevrUttyjtpCJoPQZngncWa/RSswHutxf2fDyOWZmfZp/kKsvJXN50aYkBOf22CF7rZqaTwBJnP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8c45/Gz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eed30536acso2376167b3.1;
        Sun, 15 Dec 2024 01:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734255212; x=1734860012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yoGEhpO/mToVhzTUzAP/oJgpdMQaKSKvOkjUoUvLY0=;
        b=D8c45/GzgXYyxamYdWJWIVCpaByNg6fzHJyoycihT+9W0GrSgten6pCSSM95zr3eb1
         KrnUjGJS0HmafpvXnT5NMxkcxMvmcU7m2UD3P6fUvN+VvTDq4NZG4fP2rp3R1wTu8I/U
         3WH2QnSKvLp7m5E6iWnVMJHGT7F5ty7MtQXhymXN5yb8d/SWRSDWTf7ChnE+G1s43kez
         uqNHY552QAdYHWOLJF+ITwH7BNjXebXJIvVZVF6a+u92nEbHZw4ke8gz7b+FA76OTGlk
         9L101KHIxyxLX+hpE1jbhrYEdCMifS9N2Ub8iCICyzDkFPSY+vsj4kxQ7POnt+hfyrGS
         pWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734255212; x=1734860012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yoGEhpO/mToVhzTUzAP/oJgpdMQaKSKvOkjUoUvLY0=;
        b=KwFIEAQIxlEL74gH948css+iQJOZPJMxYeVUHmlwufPbeQwQLHzxYkon94iSzD3cvg
         niKbtdwx1IBtZupHKmz3zDLn9mzLwvi91Nb5rDL1pOzF6iasUsz0PMZHsSNuCitgYz/A
         /NAbT7T3YvGqFr8VKrvharmGST6P73OIg0ODat1DTUSL6ZuOrxBtkqExsKvWEjWR+/lH
         zSvpyn0LdI8sUOrCjYYNsuJX+4pI1uOqd/cQoFKHaw6FkSOZVrGp/cGIixHsvRAH82rL
         lMggRGAOL/0fYyeg5o5Jeug0mw1Ky3+jAFH/terNdQXXyr0ZOotFOmOAi4ZiKprI2BSk
         7+MA==
X-Forwarded-Encrypted: i=1; AJvYcCW5klsMhtNfW82IPq8O0D8NJE5mnUGmRyulQTUU4YDdQgRQM9wipdzeuLe3GZmnBR4JojQFQMGgZWg=@vger.kernel.org, AJvYcCW8tbNiglTWZhvAQ/lTXiHROm5HavQ6mZBfzjC9+PhxonixS8bPf05/jHWiyc8M3BJ58ONUTkd5hmeJ/I5k@vger.kernel.org
X-Gm-Message-State: AOJu0YypafhJ7pxx9lg1WDrOQaI6RTMT/hoav7h2B2Jf1Y0Y4QthAwfU
	cb6c+e+I3QaF2Lz0OgssJQMJx1j6rXLK2YogZDqY4+uI0yxlY8aGw/DFJcwPgKMqNFYu5C0Adel
	AZBxHbN/1MG+UmcJhSoB2m8bPRRQ=
X-Gm-Gg: ASbGncvqVlb0RpcUrNunlJujqxciNW8pjCo6CgRyq1IrJOPPqHdcOaL2Rifya1nJurb
	0WGgFH4WMSc6sMQnzO9dLypU2dMk4aGhz/vCr3w==
X-Google-Smtp-Source: AGHT+IELB31JsqGONNMGOi4dAPUj6P9s6tN0wo5/x/FWIeVEuMQXrFKKyAumadwRmMgqRMSTH5YyNktjvJnsZEZlVwk=
X-Received: by 2002:a05:690c:6113:b0:6ef:66fd:1f45 with SMTP id
 00721157ae682-6f2798e65dbmr31720987b3.0.1734255212271; Sun, 15 Dec 2024
 01:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213211909.40896-1-l.rubusch@gmail.com> <20241213211909.40896-2-l.rubusch@gmail.com>
 <80b5d56d-b16f-4a93-8868-0a23b10f6ab8@wanadoo.fr>
In-Reply-To: <80b5d56d-b16f-4a93-8868-0a23b10f6ab8@wanadoo.fr>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 15 Dec 2024 10:32:56 +0100
Message-ID: <CAFXKEHbebNgDi4cieHO4DU0xO8phGcMre-FHbRGmYtMYOSmAkw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] iio: accel: adxl345: add function to switch
 measuring mode
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 12:33=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 13/12/2024 =C3=A0 22:19, Lothar Rubusch a =C3=A9crit :
> > Replace the powerup / powerdown functions by a generic function to put
> > the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
> > several features of the accelerometer, it is recommended to put
> > measuring in STANDBY mode.
>
> ...
>
> > +static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
> > +{
> > +     unsigned int val =3D 0;
>
> Nitpick: useless init
>
> > +
> > +     val =3D (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STAN=
DBY;
>
> Nitpick: useless () around en.

Thank you for pointing out. I agree. This is better just in one line,
initialization directly and no parens. Anyway, since I already can see
the patch on the iio branch, I'll probably better leave it as is for
now (?).

Question: Since I'm currently about to build up tooling for linters
and static checkers. I'm doing checkpatch. I'm running Dan's smatch,
now. I'm correcting indention/spaces/tabs by some emacs settings.
DT/bindings I was doing wrong, and just figured out why after
submitting the last patch (...).

What is the best approach to find such kind of nitpick issues automatically=
?

Best,
L

>
> > +     return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> > +}
>
> ...

