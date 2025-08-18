Return-Path: <linux-iio+bounces-22931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A04AB2AE1A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C5117A65A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506325BF14;
	Mon, 18 Aug 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqUuMkXO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B712341AB7;
	Mon, 18 Aug 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534381; cv=none; b=PhZRKmJVvuLMxLYS6IxUTnwJClsJApjZXT4bHhutkAi3sJWWNL/v8cPHXwJs5Q/FsWJoGnelCZtbwzSw0dG4MfqSptPA0SJEx4Rt8OMqCEva80QGp7/sy2xO36IyFDXkTNWQ9IB7v9/uO7Z0rvnCpiQPrtowAGHQcYGY6HVQjyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534381; c=relaxed/simple;
	bh=APdl5faZY1oEATLYG+gq5DSifCWCBA1q7CvenTvx6Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qhMfC4x0oYEztORKrbR1Xlu+XxudGuyz7KDFMavgSF9JORZvLMMcZFb4OgyHd4cenJTgdkjdue/x2vz44qHmb/zdbEVkf6HWbVFEoViOQhflH9dG/tdAK28wkqKdut+Rt5aq/0mqboiomqzA+Va0wDIhp7CrtkL34qRoei/ssK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqUuMkXO; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cb38a9247so4211114fac.0;
        Mon, 18 Aug 2025 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755534376; x=1756139176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Uq5jnw/Lhc+0zIwh+dD6DKndxhgIBat8Is0nxBAXJc=;
        b=QqUuMkXOZ9K5amnLH6hCLoz/B+VmCB3Xv4Akw+3E4LPhsgj7XEuIUzWelEofNDflB3
         uFL9qkjYDkDMW4xZPkMwUhNqpNrRkDnITj+aSGopsMbXtYRUaC9zZguY6d/+nX2ZXRBr
         dlFMOhYkWytGuJkKFBu7C31BvH31YdBWK+5gWQ9DWtNjr3NsGb50hZDUI4fYkVhEP1bD
         61SmbHfBGabny2Yw8F4W4UgTwc0hRSg+jGZm1luoSaUkTc7RTLSCT5J9RIh6LRDx32bk
         woNKxY+n9t9l4PQTdEuek0QOhpG9HyHTck8SoUc4UWSANtC6+oY2HZKudr+yQMQsUjtR
         9KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755534376; x=1756139176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Uq5jnw/Lhc+0zIwh+dD6DKndxhgIBat8Is0nxBAXJc=;
        b=qO5x1e2DtR09RxBbvK99Csmbgi5udSdN69y9uO2BLd0auaQIlWJsJAatRzOZAoBa64
         RPeSY8hGd/QaMr1ZKLGfsh/VGsMTpLVhWZrn7rU3WX4WNZX5LpsSaVFsOj65Watsl7zR
         g0ex8cW321XkKhmTKZ+UYQZPxICCgjCcWo5b2INUIyDWzvwCuYwkC7NJmFL6jdgNACNK
         KCCCUFCNc027QHFpQmXWJS3Qzv+/66ahMQtUjttomil12o+7OtxUgMc03f5rrdeyzP+j
         izz6cffg62hzGkLAiIrK8UpQnQDyOYY4MpkpHhNolqyWoWyW2boYDABMpwm18VfvK3dj
         Nehw==
X-Forwarded-Encrypted: i=1; AJvYcCUlJ2UO36M9f9RVgtwEQ4CCd1e/49CnkQXO2KUmxgl8TtP8QBjKPUmaUdoRb/kGBJkAXbtvI4P6GPFrjWYR@vger.kernel.org, AJvYcCWOoO171cn4IshAVSIzExiPBqgCumxVPAi/zte1pprSTeCTXjPV/melxWMj9C3jUfDudmSQ4hO4qKjR@vger.kernel.org, AJvYcCXAOslNQ8dQIrt64JS+xYBxXHO+/6vouGW3gfv1+u+lvBWgme85W2sGKXD0fNZ60gC/fBPi4NZl8GDU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0V6dHCkIkKHxB0XA5T0xr2GyKSXyE3tf3Fw4fWLfc9Ua19q2o
	zgWrZaoyBMC/DMJZOh8pwHT/AJn3JfUS7vKxs28Q1isAZRcLjVwXS/EiRAfPzwv7hGHm9HwJzVq
	v02RrdXIP/vOEA623baSUK7+rSS5B3g4=
X-Gm-Gg: ASbGncsHMSGyMJxyjPr7Bw8X+DYEbCcojQ3bpE72Pf4E7vbESEnsUoKcogl7YwQpuvl
	yWIx7wnZs8nCNpAkIJSbonrDtkcz9PdXOcFOW+8qthSOLJO0RtQfI6H1JmKe9+Xt/Zx/V9WLLXn
	pCRrqllsnWtsha0YTSnWWFIQlo73C/E50Oc9fQ3kyu4Y76Zt1d8mUaLpJmb5yCLZjIKR3L/JZYQ
	6RtiMVhOw==
X-Google-Smtp-Source: AGHT+IEq2WvQQ991FSCv+T5quHdn4PcvxPtmjqMquN7v4COvtMpgVWGT2Ky7f6GMOtY3143kopGkJTC+BeLj/MDl95o=
X-Received: by 2002:a05:6870:d38d:b0:2eb:ace9:197a with SMTP id
 586e51a60fabf-31108175a11mr175532fac.5.1755534376550; Mon, 18 Aug 2025
 09:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0ece8b0e-6c20-42ca-a3a6-4c35ee2be07b@kernel.org>
 <20250813084444.1842413-1-y.alperbilgin@gmail.com> <20250816112307.642ea373@jic23-huawei>
In-Reply-To: <20250816112307.642ea373@jic23-huawei>
From: Alper Bilgin <y.alperbilgin@gmail.com>
Date: Mon, 18 Aug 2025 18:26:05 +0200
X-Gm-Features: Ac12FXzWtkecyGRys29s7MrB8QliK-RRpXPtDqp53P7buPJTUuahxpULRldwl0A
Message-ID: <CAGgmJFtdnq5WgewdJYwW5+K-KTQ4yU1AKrXpov_QieJWqEKrnA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: ltc2497: add docs for LTC2495
To: Jonathan Cameron <jic23@kernel.org>
Cc: krzk@kernel.org, Michael.Hennerich@analog.com, andy@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, 
	krzk+dt@kernel.org, lars@metafoo.de, liambeguin@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com, 
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan and Krzysztof,

Thank you for the detailed guidance on the fallback compatible.

On Sat, Aug 16, 2025 at 12:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> Is that second byte optional?  Figure 3b seems to suggest so but I haven'=
t
> taken the time to read the rest of the data sheet.
> If it is never written does this new device function as backwards compati=
ble
> with the LTC2497?
>
> If so a fallback compatible is appropriate.  This is used when we have
> new newer DT against an older driver that doesn't support new features.
>
> A newer kernel will match on the new ID and hence provide these extended
> features you have here.
>
The second I2C command byte is indeed optional. If it is not sent, the
LTC2495 defaults to its standard mode and functions as
backwards-compatible with the LTC2497 for basic voltage readings.

The new "lltc,ltc2495" compatible is therefore needed only to allow
the updated driver to identify the chip and enable the temperature
channel.

I will rework the patch series to reflect this.

> Note this discussion should have happened before you posted v2, let alone=
 v3 and v4!

My apologies for the extra revisions and discussion on this topic.

Best regards,

Alper

