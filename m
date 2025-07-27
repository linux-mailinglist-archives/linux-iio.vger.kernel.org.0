Return-Path: <linux-iio+bounces-22066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F585B131B6
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 22:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73143B30F7
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 20:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0D22E406;
	Sun, 27 Jul 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffIxfZMB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C30CA5A;
	Sun, 27 Jul 2025 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647801; cv=none; b=J5Qer9wFQ3jnkpXKIBIi/XZojQY2Pze3SoVDBijFtvL96IMQXZPVccO371SpQsDXXajyOVwUgMSxcQ/ZLFWEHbIWz64cbdTEaZ358EmIal+29jlyQqMWPov+GRpw+0X4rjJf/iqy7GrljU8ANDe2au74K3IJEMkkweY+JwZYNmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647801; c=relaxed/simple;
	bh=zTI+m2gbv755Jnce3o0F9JrJ/qQ5pDwGgCbSbClzslU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5YBfSOCFd1wrLBuJN4lfuaJfaN7gQNmc/giTdooJjtY1i1269mbKh33vRH1lJCtWD9P0cA8DaZByT/JNPRviOCePKh369jWVK9SJTBGYMx24I9TdnXobFwNDIlaufVRHQLiYGPe9jkqlNXeQJ5LU7aOqlD4j73Faz6YHzOM6Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffIxfZMB; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32f2947ab0cso32044791fa.2;
        Sun, 27 Jul 2025 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753647797; x=1754252597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mITD8Au8r7SVTIND0jj8e9ZKk75KzPqbbBviF5ibXqM=;
        b=ffIxfZMBQ2+6qom6de/6ori8G3gfVNdOLpYwX75WPO64cY61vuHvDks9k7Uqesrvsg
         qeoLwOf6bqMXyaugHAcdWLqVagcHpQ2SleKu4Pc/VN69Jn66vIwFcsboBLg3M4XLEdMj
         j2Y1uIgFmiyCIcafWYJan4UCtgDlUAf9jKEOxm+ky2OKUr3OE3EsJSfh9SFCoijH3wiL
         hnewcmeeCFuRHmGIjhAQo8UNYY0TKT6sYP0qU+Wb05t8TLPRra4S+ZHtwaTs2hyASrpB
         VT72OCZMifGnLfiRLT/BIyUQBqerO6T5MsljIgBOC76wYsKnunSHrnjA/h547d1ZtVF6
         RGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753647797; x=1754252597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mITD8Au8r7SVTIND0jj8e9ZKk75KzPqbbBviF5ibXqM=;
        b=ERY0fVXSp32RqOkD8u9578u3su3nYasc7a9zSHErKX5yRDAXMhy0wrdpc8vm5gfF2h
         LpEMuz2e3ojhInGYC4ZidNrifNkGiN+XsLffBuoHvMo2APCBBEeN1m5GCxJpcabzFgZV
         S/LXrBFCe79QteMpsy8MMMGVdJ1NELGKicVJGCZg/TPCwsiykH1LaTajaYE18KuQ8sXK
         FNJgjgdUDbp2C0i2Zll6Us27PFsw88szW3FERHE/L1hVqws+tvChQbpPF3EOYPdAacT1
         U0a6FCL8ihhyMPfGut9dc3H7+WUDPkWzkL83NcTr7q+DQyAYUCgdzJmhDuevFU5rJ5cj
         5LIw==
X-Forwarded-Encrypted: i=1; AJvYcCX3uEackjjsPfxLpwKxfrYuwE+8sCoOtvQsPvLgNXLXhEEJIzj1jTu5t9zp9FqtQ+XCRTWHosvnM+GdLGhk@vger.kernel.org, AJvYcCX4+7mM3/EPumS8esFH1IelCt92P47YB74od2CXhdFhXZLbgEsrourKMiN1NlNkpxwRTw7DYyAnJwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLA3hsCk4GL0LmWvUzbm4vM5leE2KScgAx79coM0XrcIj5s3S
	3+UHmrQlihYi+AzpGw3d9ay2D5h/R311UgE+N7wZ19JraTLWEYxr2MOUAknghBkPesI3dyCtomY
	8tPbXXLGFn3bUuAD5ZdAwS2Q4QXpulT+WI6+S
X-Gm-Gg: ASbGnctAbNmnkj947rpOf1uwNkn+7TXwZIwQbk6ZnLrL0/0Y+WCjQUTcjLT9MluABiE
	W7zQAo60bc3IJ4uH2lzmj0hUri4hJnRu0bCCEIBytGowTIcz/WMG2noWIkDBqdyS69iWjJUhq14
	pekhHcky0vg5z91I1CSfwhc1eP6nEzl6zkxKhjn6qKrNSqjkn/bCr9yai8re2feXzYNFDz/bS4o
	JlEE0UlEamIIImT9rt4wZIFwE5peZL5cqL6sBw=
X-Google-Smtp-Source: AGHT+IHZb9FWBQnMJSHlpnKvwX3pJwhBiE/qbr8+HAA9ggtjn2kXkB1qt1aHpT628aPzLr7Qc+nbWSr3HawKqxtVp8w=
X-Received: by 2002:a2e:bcc3:0:b0:32c:e5b4:a225 with SMTP id
 38308e7fff4ca-331ee752479mr34285171fa.28.1753647797249; Sun, 27 Jul 2025
 13:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724143945.636380-1-akshayaj.lkd@gmail.com> <82bd5d44-a23d-4d49-a79a-b6792e62bd62@linuxfoundation.org>
In-Reply-To: <82bd5d44-a23d-4d49-a79a-b6792e62bd62@linuxfoundation.org>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Mon, 28 Jul 2025 01:53:05 +0530
X-Gm-Features: Ac12FXxVxCX1_3bqOR9MqVjkuhVAzWP7hJIllxIz03ch0-trFMmYS88E9jwBF-8
Message-ID: <CAE3SzaQSHEQ7b2AaJyEiq+vVzMLAS-KZw7Liwkn7odPDW50F8w@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Add debugfs register access support
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 3:29=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 7/24/25 08:39, Akshay Jindal wrote:
> > Testing details (done for v2):
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > -> Tested on Raspberrypi 4B. Follow for more details.
>
> This is way too much testing information. Summarize what you tested
> instead. It makes it easier to see the results as a summary.
>
Thanks Shuah for pointing this out. Will make sure summarized testing
information in the upcoming version/patches.

On 7/24/25 08:39, Akshay Jindal wrote:
>
> Add support for debugfs_reg_access through the driver's iio_info structur=
e
> to enable low-level register read/write access for debugging.
>
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
>
> Changes since v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - merged the regmap_range of LTR390_UP_THRESH with LTR390_LOW_THRESH.
>
> Changes since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Replaced _[0|1|2] macros with a respective common parameterized macro.
> - Retained base macros to avoid churn.
> - Swapped regmap_write with regmap_read to avoid negate operator.
> - Simplified debugfs function by directly returning return value of
>    regmap_[read|write].
> - Replaced [readable|writeable]_reg with regmap ranges by using
>    [rd|wr]_table property of regmap_config.
> - Updated the testing details with v2 changes.

Dear Maintainers,
Is there any feedback on the v3 patch?

Thanks,
Akshay

