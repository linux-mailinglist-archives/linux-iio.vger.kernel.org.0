Return-Path: <linux-iio+bounces-15915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF41A3FA64
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 17:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13C442003A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC93C2139DF;
	Fri, 21 Feb 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnTgXy6m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3E2135D8;
	Fri, 21 Feb 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153556; cv=none; b=JXFwj6AY16XHv1oaZ7iC6gxFqyx4B52f23THE/SRFqWZ2u5ZMkbxLXL8YdP1919Y5s+hVfcRgg6aOiORKxh3nybFYBaEfYaFanaVI3zBeFDlHZz9Bzy20ffzYSEoskUpHALyVMQN+EtapaUsJumdS7mm+XQEPT4M605fJONDv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153556; c=relaxed/simple;
	bh=6gAzAohx7VpJB3yz5hch1DConeYB/R3aq6rfiP6O4HU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8pfXDxOz3SdH3a45qcsclcbSQtUeA1AGSo/zOykg3z1H9AcPbcXEYJ7eGurYzpmEEYq7JF5LhfhMAxdGaoTCccyDBv1NBXjL79ysKEk7FQV6VIDqRkr4fKABX1DhKCHbki8lUTPOLPWTEL6jsVitctvzEkNDlfTPvb6L2ESs/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GnTgXy6m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso14157405e9.0;
        Fri, 21 Feb 2025 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740153553; x=1740758353; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gAzAohx7VpJB3yz5hch1DConeYB/R3aq6rfiP6O4HU=;
        b=GnTgXy6m5VOKnuvBwfsw6Avt69lUTzLI3yY1hAvAmJ44wSktQ8j0Q6W3hdWMMLZBSe
         6JOw0YyJNb+wLr0t3bxzPpqnT3c/IK5AT9po4/HVFoiXKez+Znm/lQy9wr1OI/GFt8NK
         GgTaCpN7kkcd/ALsXCwd+2MnkJBicqqha7vEf60AKI6DnzWcPoptqaskCaZ5gpqtCYfv
         EMfBP0yKymLWmV/BuoOi4P9oK0vF2KxpLZ7Xa5M7435jSqt1fU4PTHhBMfeob6SARfgi
         F9xjAAQLjHrq09+XwBVJZ+TAEF7NNMS9jsyzs8YAiiu+WfcIaZJHm5ExtfYQHtvfGNrh
         0m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153553; x=1740758353;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6gAzAohx7VpJB3yz5hch1DConeYB/R3aq6rfiP6O4HU=;
        b=bNIRH9wp+08D+qoQQkb1TXRHI52q3W8h0+nrJcdDx0gX89RWrrN9y4raFKYN0G2xRK
         CNV/MuFrc0VysNI8Od/pVdoN3wUxvL+9XpvDYaHTZ8Ye79bwYnwpH6DaTHX9QX4Lj7R1
         kfhLsqztLFSkICroep7fcna3I0iU36E8ruAgtET2DksHWOqWLoKvUVFnFnOeAaOrpWsC
         lgMFvPhtTxmPolW74U++6lOqGojxF6q2LgkMtqN3mzJE0JywbkE2t0Gj8Ug/nqVIUVqc
         +Vyhpm7znA0QKf/Encl3Hc8P1R5pzGiTHgo1Rx2xwi4zHAlsmar/brOsaK+rHUVTOOZL
         GwlA==
X-Forwarded-Encrypted: i=1; AJvYcCU9qbZ4qOfq/HA7xSyUnHoHJJivT8muKMPuRAa4PlN9kPVu5rp7eAQahPM6rp+ajYQZvgwE21DcAC24VbTq@vger.kernel.org, AJvYcCUeXY2fnjpoSGRgschbZql8KYBixFvx3sakb87GFALZBM1jU+iEm67MhQJy95sqARBx+vistSVxZOOi@vger.kernel.org, AJvYcCV2VFSNyokN8NLAqapeTFWDT+GLSOlryItTG/M5j+MQ1dHvEF40J9n9FAInuHTL/A7MYcSrEn2jgurg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzai8hhFvJ4pLuhC/N9VzV5ZvtQEt5VzTPWY4uewHoKj1N68oqv
	6BF0dUMps2sa0XiTNClFi6fVZtpcinfsOcaJpb0iTLbi4tJfgoM3ngVK3X1F
X-Gm-Gg: ASbGncsYQYGrXgX+WDqT22DErP73PQsuwT/EguLyKpEe0ejqDXaYl+pSQevK8nN9S2R
	sF6GSQ7vvdIkS8YktTGvkLA2VkZvXQGBkS3yNBxbRYLSvtAmJg8zNskqyIjDiQ3jYTAX5azIlxx
	CTnvHoO4/XFreN/Nvxh1UUXhgCmB1TT9ZO1rqlNdwXgPNC9xrJfGujlnTf4VzP6fiqS79QrfrsO
	RMz4aXzA3qlGgau9JcboLjC1plCsLhtgnqW5fkbgQYJ1Tqc63YrQ8LK8kT8afUB9QF2qcNw0Ibm
	mO4k1cyIIm27j62/ftTME9STwAgFHttrvLy1S0+gPuV9E/QNHR8CyBxXke/ECjxCiR0NU0g2JA=
	=
X-Google-Smtp-Source: AGHT+IGyo9LXSYGZVER0mW6Wzsx9Ag/v+n4mPHyB14QgX9y4EtaMRhXzFOub0TOfQJf7va5afRLzuA==
X-Received: by 2002:a05:600c:198f:b0:436:1b86:f05 with SMTP id 5b1f17b1804b1-439ae320521mr32165805e9.11.1740153553011;
        Fri, 21 Feb 2025 07:59:13 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d510bsm21116065e9.9.2025.02.21.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:59:12 -0800 (PST)
Message-ID: <8595146558aba261658cb5b311fa87ead3dbf71a.camel@gmail.com>
Subject: Re: [PATCH 05/14] iio: backend: add support for number of lanes
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, jic23@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 	linux-kernel@vger.kernel.org
Date: Fri, 21 Feb 2025 15:59:16 +0000
In-Reply-To: <13c5e420-a3ca-468b-8810-3528b24d8664@baylibre.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
	 <20250220135429.8615-6-antoniu.miclaus@analog.com>
	 <13c5e420-a3ca-468b-8810-3528b24d8664@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 14:20 -0600, David Lechner wrote:
> On 2/20/25 7:54 AM, Antoniu Miclaus wrote:
> > Add iio backend support for number of lanes to be enabled.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> This is why I was pushing for a similar function to be an iio_backend
> function in [1]. :-)
>=20
> [1]:
> https://lore.kernel.org/linux-iio/94efa413-5fa9-4014-86c2-331442e9d42e@ba=
ylibre.com/
>=20
> Not sure if that changes what we want to do here, but just pointing it
> out as a similar case to help us decide what the most useful generic
> function would be for this.
>=20
>=20

Hmm, yeah, I guess we could have them both in this interface or the API
suggested in discussion you linked (is octal spi a thing?!) even though it =
gets
a bit confusing in the AD3552R case where we have the other interface for b=
us
related things.

- Nuno S=C3=A1

