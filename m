Return-Path: <linux-iio+bounces-2512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2280C852E5B
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 11:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5547C1C226F7
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E8D22EF5;
	Tue, 13 Feb 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJJQlTyx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8DB24B28
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821404; cv=none; b=fmL+leVtJHZoy5MMKKPduIYOS/KuCuge0CnevqBftqSS6OURceRp/CA2XOJImvmYSIIfNofOzF0UQhdPpjmVrWXXwm7Fs21be3W575yZN7pBCwENr4GMJT7au8BHvI1n/ZUs0rlc1zivDF7q71IeO3T/DDTaEBYKsi6mJz8Xm3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821404; c=relaxed/simple;
	bh=RYaIr0sFdcK7Z2Bm8u7ydWPqt1ZLRwxJxnJWXGIPaIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSzeAA4qyCysUiRTg171BYgpWuZzUjdTBPTmNoH/Vyij8vgdO3kg+3xZ5SmerEGO8UfjAhZh5lmZG60yDZcnii2Ao/AdWdrMjC3qeK0UkMfyBPiFvXkxc6OEE1WAKDC1bNiAHtSf9RsI1DWrN6hp3a+Uew4vDbs0M8Ht13awCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJJQlTyx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so5491170a12.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 02:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707821401; x=1708426201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8saj0DGCwXrk28dPB/mQK+6Z3EU1NXFvQZo+kiN0Lo=;
        b=mJJQlTyx+PWQv01E2YwlDkXGjYy9ogaR7eZgsyOLpYkgrd+qe4oP3VNhjPaT6T2ls3
         oo2blECxpokiPYQf30FPN1wy6v/nnzW9BJZIjIJ/nOzs7BU1kQ87h5Fb8sO2vnWViS3L
         yo3T+kZ8I11h7CeV1Tswb6+9TcQ/tOunYFe+cbMdBoMM+6mVBcuZGcGmsYqb907Jcs11
         2YLVy/6SilrhuJAaqvAbh3p3dcHiarMPInO69+YWlJ+pJYG48XDv44Bh3XkcgWT3QCkN
         XXkaPEz5ed3JVNxIFVmJ70N4oHK4apPxzo8VqiPyssl8QUdZfQLUCpNLNHSnC+7vboiU
         RO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707821401; x=1708426201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8saj0DGCwXrk28dPB/mQK+6Z3EU1NXFvQZo+kiN0Lo=;
        b=EoMDCuVvAT30PbaQgL4t/Y8S4CBDrWi+0pJQQBKQl6M2TX8yf5aXskIvGbNMhvRgeE
         cCjjx8uwFdywoiK3PryAE7EAZd4hGwrwHcUQBKmwLuSGeK8mgpVBPrKNmcl5A1P6QXoZ
         DlHwQjg/GKPXgfR86l3x3WOt9ml7wmR+/WVu24doiE7iVjBiQ0GJM0sbIKFONCyHdHK5
         /bvP/GirgfjObezSfbcaqL83IZsaUBq0jwI5/bKZIbKJTPPBwHLM0Ja8nsDkq4yTQG7l
         l02TLRfXIP2Cg/0bq6Oyiv3ey4CfrlZhsJ01WWseQSR0aDWu8NKhc+4bPBpjz2DwktKE
         m4ug==
X-Forwarded-Encrypted: i=1; AJvYcCWoGc2imNOYSMhK3DP68igkPj/GXdQs6L87SULvUwV1sL/r4A+WSi9IXr802SfNFAztDtA1KHXuydWGMvCKEAwsfhmTZ0Fr4EpH
X-Gm-Message-State: AOJu0YwpEEVecQTlqWJ8wam1+a1OIzT0qjKgaOW7AhKv3cW4cSsdA0fB
	4/yNpWw/Zh0RVtcYBp7EgxjQMcnza+apbl9r4z3WIbVWoGdcUpILtRjhW6oJkRnRcrVjcnsLAw/
	rHbx6OAYpfYKX12Il1xKXdSfX7RM=
X-Google-Smtp-Source: AGHT+IFCxKw80qXiYTh3zT8YdisCH3giPdZAS4JWQIfofui2zImgg56fPIydURYn6wO/mdjHbYWSzXj++7kxIxaZx94=
X-Received: by 2002:a17:906:4e88:b0:a3c:cbab:f3b with SMTP id
 v8-20020a1709064e8800b00a3ccbab0f3bmr2768862eju.23.1707821400708; Tue, 13 Feb
 2024 02:50:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75VfJeMZUBO0c9gr=ymee8jqu0xJQRwrg798Trrmr6ox5gw@mail.gmail.com>
 <20240213023956.46646-1-jlobue10@gmail.com>
In-Reply-To: <20240213023956.46646-1-jlobue10@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2024 12:49:24 +0200
Message-ID: <CAHp75VeBqKiEWHyRjJt62VvrGKjG9S+kgMrbYEPBap311ZtZVw@mail.gmail.com>
Subject: Re: [PATCH v1] iio: imu: bmi323: Add and enable ACPI Match Table
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org, 
	jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com, 
	linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 4:39=E2=80=AFAM Jonathan LoBue <jlobue10@gmail.com>=
 wrote:
>
> This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi323
> driver with an ACPI match of "BOSC0200".

> ---

I'm lost. You sent a lot of patches / patch series all of which are v1. Can=
 you:
- use versioning (`git format-patch -v<X>...`, where <X> is a plain
version number)
- add a changelog here (after the cutter '---' line) to explain the
history of the changes
?

...

> +static const struct acpi_device_id bmi323_acpi_match[] =3D {
> +       { "BOSC0200" },
> +       { }
> +};

Since there is a collision please add a big comment in _both_ drivers
before such ID to explain what's going on.

--=20
With Best Regards,
Andy Shevchenko

