Return-Path: <linux-iio+bounces-20483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EADAD5FC5
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466793AA6C6
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 20:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A09C2BD5B1;
	Wed, 11 Jun 2025 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwxT3a1D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B816289E05;
	Wed, 11 Jun 2025 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672296; cv=none; b=EAC9qK2wHv45L1VMVn9n2NkdrGJ0++FLShlMBbF6j6Rj/UJEzB6i+3psmuunCdAYoJzckoTtMZYd2x1oH6+RIQKAdF93W0Qn9vebAvVPo32avTufcSSIlEoTT8Hyr8OKZkurry3Tp7Yjrrna2SsG6WIDJjI3AnQf7Lxi60zsK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672296; c=relaxed/simple;
	bh=YltkNEdDFqNIZZD1BCXWEVlBMgaCkKwjGC0e+Su8vTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKmXvPrm7TApFsN8KFGG+iLsk72RfKQcCdfJu/X/dbt4f8s7aWyec96WGOoPC6mbzeqgX4nqsBO4KzL6cXhKSBujzw2sQPwaszxlCkuXVh9gH3bYVJqV66Ha+IBiIjtXNlMvlG9tVn50Cc0kmm2ySQHcpCfMRCpJbEU54cqeN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwxT3a1D; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70cb9ae5479so156917b3.2;
        Wed, 11 Jun 2025 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672293; x=1750277093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YltkNEdDFqNIZZD1BCXWEVlBMgaCkKwjGC0e+Su8vTc=;
        b=cwxT3a1DGb/KjBY1ql1/K0dmhF8CVbifb/r3sAkjyRHxGVHzQer92MEr8RbxHYokO1
         KdrimtLPUGoCrmQtfdAeJsCYW30bnNpYSJVj/Y4aEi7/Bh/MnPioVvHpDrHQQjb2Ewip
         OA18liD9nsVE/ZocSEJmQ2O7rCmrYK6tQ86/H2mGClRS9Fje5ccfkJiBjdkmCCSbR01H
         eQGeEvfoPr1dAFhqSrV4+8jZEoNgc9lLEjEid1kOiCljrFr4byQeaGwvCvQopnRPpWFJ
         sE0XwzHBazoxmIbEq4AS36luUaz9GYGlaOjeAUcbaeZQyOG2xOPKyuJBVV4UouALhgFT
         gw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672293; x=1750277093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YltkNEdDFqNIZZD1BCXWEVlBMgaCkKwjGC0e+Su8vTc=;
        b=XUk7Su5i0NrxN0qgQVX1mjQRd2zLCb+vT28iFDHhdhXaphcQxqnkxnThYhr2aU8ETk
         KJcPKwk3p+5/WqZCzG06Jvkt+7O7Ww118QPcaMQE+JSY2R7JoPxI9SIQck6hqujQLz+z
         WKkWS1JvkKR2ImYgE/htmFhdY319SM+/IeMjjSYCjhUzsK8YokrEn7alh+EJZYwC33mj
         hKMV91nU8J+R6/WZnCGa9ywDrJJh1zVUuTtta6XjtVaLr2xmi3Pfl+Rt0oteBpe03QW4
         HIrenngcqOy8hAup78OOJ/SBpd4oZWxfXDPIGEHjGP+kFfCPgDWJjetdAV6DjFBSTBkv
         iDDA==
X-Forwarded-Encrypted: i=1; AJvYcCU1sRZlmw2RyNBa3WmKzJiiHwl0d5KuItGOiZqB5pMN+6qyvzvxhYO3cFfy5sFxmopAP8clM7HRghxw@vger.kernel.org, AJvYcCV7qoN+H8bLBS/32iYIlKPMw8sPnKnC7cdDNV+lpte8CXvRwuwsCOHa26pSi2TBZmSkMblycR5u4qwIMdv6@vger.kernel.org, AJvYcCWDfHs73+imOhQrS5jsGEsuqSnSW2o/NQA7cPagkxxfWoIAZyU4x3menTz2PXOK48tTxQ9uYi60vWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa//uQji74bDe2wn2ifKnaKLhv0AjTLcUqR08lFAMNS1nPCR/y
	0DxsN9cL4QnBvsZILsy2b1skjNk0s2b4O/i81Gz20ilpSzLOQbgxAsDKz0eKuXzdpy41dgRZSB8
	uL4ZOQV4o5XjpPPYqBdy7vJXhjMENaJ0=
X-Gm-Gg: ASbGncvupVnl7LYmlgSNXmSzkiawpcOj8KD44nridiFlgGlhBfisbjCy92OOLluV9RQ
	cvbRoImw8/e4nxIXsOS9l8ob67wz/B+hBEOjfLbWgYENINvThmEb7Aya/Zcbb0hrfEFu46e+qv8
	PKYY6J7ft0E4eJRXTVRh4ZWrx/y9ARWEC6M2nKPqEF1Rc=
X-Google-Smtp-Source: AGHT+IFV+AO9HgYFhTTlztYTHVtM7RGHg3xnlcUOyt2aLXZS5Y8CCUoM7JVeqVNE9lcymBg1Kk4aN4BkNSC+LRfHkGI=
X-Received: by 2002:a05:690c:7242:b0:710:e860:37c5 with SMTP id
 00721157ae682-71140aca988mr30956227b3.5.1749672293326; Wed, 11 Jun 2025
 13:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <aDz5WoBFlLiRptza@archie.me>
In-Reply-To: <aDz5WoBFlLiRptza@archie.me>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Jun 2025 22:04:17 +0200
X-Gm-Features: AX0GCFtHLrO_5QUdGg4rNwkE0hGpJaZsTOIr5EFKX44lHrKyIKyEQZE7GHCLJ-w
Message-ID: <CAFXKEHZQZuKYS-DJ_KSmHzEO7OAGmKXCeEZ3VaLR-JJdb3Sw6Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] iio: accel: adxl313: add power-save on activity/inactivity
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bagas Sanjaya,

On Mon, Jun 2, 2025 at 3:07=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> On Sun, Jun 01, 2025 at 05:21:28PM +0000, Lothar Rubusch wrote:
> > The patch set covers the following topics:
> > - add debug register and regmap cache
> > - prepare iio channel scan_type and scan_index
> > - prepare interrupt handling
> > - implement fifo with watermark
> > - add activity/inactivity together with auto-sleep with link bit
> > - add ac coupled activity/inactivity, integrate with auto-sleep and lin=
k bit
> > - documentation
>
> The series doesn't cleanly apply on iio/testing tree. Base commit or tree=
?
>
> Confused...
>

I'm sorry for that. My base tree is "testing" here:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=3Dtest=
ing

Since this patch could be applied, I guess it could be a good base commit:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=3Dt=
esting&id=3Dd4d10d3535639b946007fb7ffb5bff2d878df921

Thank you for reviewing the documentation, I really appreciate your work.
Best,
L

> --
> An old man doll... just what I always wanted! - Clara

