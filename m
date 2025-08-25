Return-Path: <linux-iio+bounces-23263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0798AB34D20
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 22:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91F6203F51
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 20:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEB729992A;
	Mon, 25 Aug 2025 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRvpxB6a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A61E89C;
	Mon, 25 Aug 2025 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155568; cv=none; b=cHkYXBSKBBTrRIRd5mp3cV/VjwZsR2EQMkYNGzDM+QCbLYy1WBsEzZ8rfvuHOZuHJReiZmUg8sILGqCDx9z9jU4v0+3yDhAO/hyf5FDj+Mm2YXnCmhT+mU49KuWx9jdLZ5nAaYLQpY6g96BiOEfPtFWE1qdq5JH9nJlok0n9oIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155568; c=relaxed/simple;
	bh=P+f9GWoudFIxOthJoiv89uXLOQljtr15VfO53YgP3og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug3GvYgmpNesbZgr6hk1Jyptt+YWU/8xSo0UX5C8PfXzucRnN45pXyiIw1vnzTWDtoSoLkqOo3n8sz5ngMqVTOfmqqnGXyTjgaiInfR08jNy+xTaLlKQwxlik9HBO0zBOHTW2beKOQMak/RAOUpKIO50KylxtWhUaAcRij7zrWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRvpxB6a; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f499c7f0cso988419e87.0;
        Mon, 25 Aug 2025 13:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756155565; x=1756760365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEDyZPVAqJd7dy++5AJb59bf7HNDp+oeDl1YcGWBAgw=;
        b=PRvpxB6a0AOkVmZl8nWYRcAXmiBwxB+TtWm98sVGpC5ZykDZp3xzXX8MzSNu6EwhjL
         UIE3hohcYhGKUo9cpQmnlpRQSLP7CZ7HgpORafsHnCZgaEajGbj1E0QOlXxZr0AIy530
         glQ2L3Ir9uGxVuc+xfYWrn5jIb6Tvium4Q4uYHeqSv625y0q0s3UpYEYa8gZ1q1vXzEN
         MEEhsg7BIkJZdHZsElaTp5MmZoapJMCFFm86tSiINMhl+jxbEVdJv9l4EAXAUOiYLDOr
         xrvxpPhgqiTespRDwBNtYGv/v478zseBGhE/24A+NZ3vv9mMtV//uC9/fe9ut1e+JPGZ
         6GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756155565; x=1756760365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEDyZPVAqJd7dy++5AJb59bf7HNDp+oeDl1YcGWBAgw=;
        b=tdmFGEnXbg1Xg7+R5ZJvNfhppH5zA14LHHbRyDzRO4tsqTwCJhHAEG0XCCJ7NiAFiD
         yQnNREHOfTUykDM72JZ4zTQnc3dgOcrWsjhKNeX32jskLlhoZWrgLB+khTavMwWFHil1
         +Jxe/P2CyW8pBLA5USCC5aLbaf7+3FEuBkG4j6Djb7afM0wZ7Bn8A7MluugaZ1xZuawM
         m+Y+X4l4YuMIBFwAZzn30OrPFgEju5l9AcSfzdTlFX7IfomRMbklh6Mlw3034XcOUiEZ
         SDUQyCYrJciFEa4AH8zwq3P1IplTOhZG1engyyTt5md4o9BOEBAoaRdDAzjYdyeVvouS
         /Bag==
X-Forwarded-Encrypted: i=1; AJvYcCWtJwwoog2Gb43pnpKODkJbDWthdHesW01qJNLuOlXhHhMbB1+pjTV8NEdFFT/S8t20XgcTtat6yS8=@vger.kernel.org, AJvYcCXHEezEpd8yIVaZzWinoORLs0vmiBp3XkDZeVvNWaKD+4bO6mQhL57Ke5PnD4OA6CWJOk+JElF2Vh73qu2H@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxEef00Ye7zdZ1CshqHFfhDj9ZPRTn3t2lSqBYy21kGxHIZvQ
	+Wx9WR7H158TDKv6WU3Mvg0XONeMLA6e+7maxd03A1rvDxY2TUXaqcb9YuBDmHYt6EX9/2WyERp
	s8kMcfWBsrXNIgb4NhZKIUTw6XEOKvhs=
X-Gm-Gg: ASbGnct5KdxSvEtX6cA4yNpazspoL/ezIBPPeTsTFlZ0OdxCq334lEtpoc7m3AtA84p
	rRd5UcE4tTBGMkOUUcO3/NR9dM4kvuunESbCaJtiaftaViBU54dkHMM/MDSqOISTboCkkpoRwwA
	cT/jmSYHY23DK45z+SP8auJwbQ8U/+N6X1lnO2WQnTRsPZp/YFIGd7vSksfG9y2ZmHizd2Ntu/A
	hsqmU8bAErYaTdhV1DkwOxFc6IqGPtrjRqOdc74Jg==
X-Google-Smtp-Source: AGHT+IGqCPX51Ss3DOPVVuYpEQYg8NqfIXNFIutjVci2omtiLZJsnfXe8YEYi2uoT4Y/9ZKYK072kPWj6B7xClz5wN0=
X-Received: by 2002:a05:6512:1581:b0:55c:c937:1106 with SMTP id
 2adb3069b0e04-55f0d3715b2mr3714312e87.28.1756155564703; Mon, 25 Aug 2025
 13:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822180335.362979-1-akshayaj.lkd@gmail.com> <20250825152608.6468c27b@jic23-huawei>
In-Reply-To: <20250825152608.6468c27b@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Tue, 26 Aug 2025 02:29:12 +0530
X-Gm-Features: Ac12FXyCinT6t4daEAj_YSmGc2pAsrD-_LPnxBN2FPcqHRneEAD2IAxJm6uvRjY
Message-ID: <CAE3SzaR14zWWM_g-H4C76+6fBDotuAux7n2V1g94R2xLFQZOYQ@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add runtime PM support
To: Jonathan Cameron <jic23@kernel.org>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,
Thanks for your review. Please see my followup inline.

On Mon, Aug 25, 2025 at 7:56=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 22 Aug 2025 23:33:26 +0530
> Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
> > +
> > +     if (!state) {
> > +             ret =3D regmap_clear_bits(data->regmap, LTR390_INT_CFG, L=
TR390_LS_INT_EN);
> > +             data->irq_enabled =3D false;
>
> Just take an extra reference to runtime pm on enable of event and put it =
disable.
> Then no need for special handling with a local flag etc.

Consider a scenario, where the user only disables the event instead of
enabling it,
(i.e. user wrote 0 on the sysfs attribute before it was 1). In this case,
If enable means inc ref count and disable means dec ref count, then
this would lead to refcount underflow and the suspend callback will
not be called.

To handle this case, we would need to check whether irq/event was
enabled or not.
For that either we can use the local flag as I did, or I would need to
do a read and test
for the interrupt bit being set. I feel using the local flag would be
cleaner and would
require less code.
If you are fine with local flag usage, then shall I not stick to only
local flag usage?

Thanks,
Akshay

