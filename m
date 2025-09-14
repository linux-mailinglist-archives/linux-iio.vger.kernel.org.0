Return-Path: <linux-iio+bounces-24091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B007B5685A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630CA175D9F
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6D25CC6C;
	Sun, 14 Sep 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUh3Ikg0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728A1F8728
	for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851837; cv=none; b=MuvcpQYHrotQjQbN43T6euhd643QgchaNwW0EIE8QsuyA1dR4PZkjjdcd/ZHdSynKVIRt4h1Q0gyB8M60WZKzFEGKabfyNjtPaBdeHm/YHtNImfBFjmZAl5d1CVMskXdBmjLDSSeCj23HYI6FsDB0cJf2LjPi7vngVOaFpBfvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851837; c=relaxed/simple;
	bh=WR0p2/RgPvOyUM5zTslfM5n5yfsushy76a4o0N0Plz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jErIi7hFeG3WSmEyDP9abHGbnlEfqNFjhUGdq4bMBX+ae+XSps5yf/mVa0+iCBmWjuN0nebHbMN+/6CWhrLNPNW9SM30Ve+mEPk9uQ7SKW3+WbCYnLr+1wvxWDjLQWTfL+BUSDAkLeTlCKOt33iY0a3fm+UxCZeGRnWOGrWX/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUh3Ikg0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a16441so494148166b.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 05:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757851834; x=1758456634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8V1jWYoxS6KjCqMGW0h9rFVxhv+t7V+9uQ0Z+ECI+A=;
        b=fUh3Ikg01TokWdb2AjlZUX65e3UaO7m7fSHIMEnWkJ/4A4NNJMGj8oYTOeApga7hkD
         C8iJe/0y43h6r5yOxq235JAGT4aDuuVwMeBCVQemLq+SLCzFvPzf0j8WLLFnTtWzAENn
         6NqaumHGj7coZ+ohivy4UxIfipmoNgMEfLlhdhc9svm8yBxRZ+AJyAAxJR1kHH5tb3U6
         1V6VSposdnnw7Tb22wROcuK+4GxMY0ZnFcuyQBkh+LHNY3EeXOQxc9EWUmfM1s7Sf8eJ
         gJHALZgr6sn4zvvc8hbeDhBrQySDTdPbzpVK5lLJOmSvd9k+IMZDM1ejLaMH5DFZQKpm
         ECaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851834; x=1758456634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8V1jWYoxS6KjCqMGW0h9rFVxhv+t7V+9uQ0Z+ECI+A=;
        b=WS7OQl/mQn01iPzBX5eMoEXmQ6QX0FWKRWM+9GzwLOCsmkk63JMFxGqPxtyiaEV20j
         HnNVdefGtLLyYE4/tNEnAeRcv6xyzpJC3De5XQYYunN1eAPEm7Qztf1Su5tVemMm8Qk1
         DxZ8XjK1sIF+l7IQHo/QDBlkqGDz8dqEKzT6sAzoF0XbdKNl71RnkAC/8GmH/je+UaV2
         sUDn05uzEE9fACr/E/YUhj5ilDCYgmVd5mzr3J98CS9+XIN3F4H6ybZ3AEfNDUwF3Wll
         qJ0GR2jlNEtnCQMJjWrORrra85lcoSLCrrmurCBGZ+YhGGwhg24pum15WG7uqfiQF/Z3
         rdAw==
X-Forwarded-Encrypted: i=1; AJvYcCU8jGjAAhzxcvmqKVn4k/AUO6vdu9oo0AOvQzC8vnL6HiPfrD6LzvzaLeu6SJEYD3C6+uEguUUvTvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxUs8j+/dmMEZiihYz6cBW1du36Arx5aMV8SyhfKalTCewaEPy
	6DaYkfNUh9BPKBkk3u6518Bzm07vPplAvy79YyhssPV7NFZONlBGHNQV+d5FOkUR4MKVlAPFfU4
	U8L8OSg5ab01oO7aBXW0kp9TgK7gMS5I=
X-Gm-Gg: ASbGncud7ME3HPwz6Zcf3pjI3ImInEW4AkCu/7Hoa+3HjGIYHav+auwUTPoE+KMIXAv
	1cWN/oO9jX+d3sSQa7ubWWYRDW6vZmOEQzp0QMUATIdVqFSSh9bnT6FBamocv8Cn7AcSTl0Guji
	4PgpUzyuMINgt3NyKkBx1EbZiyICx03C/1HQQsY+j9qhyPTt7kYPvExjoVgm77Ehu3AF7tXp8uH
	7Ha4Ag=
X-Google-Smtp-Source: AGHT+IHafPAGA9yP6ArgmvZu7js+Sx94GUncetaaxnhh2XBfbwD13eY5vhdeiFjRQnyQzIxqgylPWSadgisnMk44tnM=
X-Received: by 2002:a17:907:97d2:b0:b04:31c6:a434 with SMTP id
 a640c23a62f3a-b07c324cf12mr883758066b.0.1757851833835; Sun, 14 Sep 2025
 05:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-15-0b97279b4e45@subdimension.ro> <aMWcpxacC30ME9Ew@sunspire>
In-Reply-To: <aMWcpxacC30ME9Ew@sunspire>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:09:57 +0300
X-Gm-Features: Ac12FXxIPVN7XdFMeAMEi0Uqt2YAX-FMA_NN2-BAz1drL1DRd0TjTHA0avHr2WY
Message-ID: <CAHp75Vd4b7dMkNYWpSaUqfESaRT4Yh6UB=QC8A+p6Sq7PNKg7Q@mail.gmail.com>
Subject: Re: [PATCH v3 15/18] iio: accel: bma220: add interrupt trigger
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	"Nuno S??" <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 7:32=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
> On Sat, Sep 13, 2025 at 06:39:36PM +0300, Petre Rodan wrote:

> > +     if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1)) {
> > +             iio_trigger_poll_nested(data->trig);
> > +
> > +     return IRQ_HANDLED;
> > +}

> sorry, errant '{' in FIELD_GET line throws compilation off, will fix in n=
ext rev.

Please, slow down and test your patches carefully. If you haven't even
compiled this, I don't think it's ever possible to be tested on real
HW. So, this is NAK for the series. Also note, due to timing this will
be a material for the next cycle anyway (v6.19), so no rush with a new
version.

--=20
With Best Regards,
Andy Shevchenko

