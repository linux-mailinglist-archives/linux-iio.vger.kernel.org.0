Return-Path: <linux-iio+bounces-18711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E03A9DC1D
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 18:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51A25A613F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EE225D21A;
	Sat, 26 Apr 2025 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIk36MMw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D342CCC1;
	Sat, 26 Apr 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745683724; cv=none; b=WWzvTczXbaW2J1ghyEL9Uc41kS8OJwU7MtlNgYciG60ozuNfxvaD44vhgDL0sjci/1jZLJxS6TWSZdfD/Ckp/4eWtaaLmDhPKJwGoepxYeHXdWSghfmgdJ4b9V/YxaaUia242yqPb3W1n39tZS7ns3I7QraZyx2BO6IMo9tB8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745683724; c=relaxed/simple;
	bh=lYxdZJ9bsThFJ0RFg6NtDhY6AxAZhD7vZLMppxV1/nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXj4LTMDypRVhuJ3h9nEgJMigLPi75cZptiAZ2AzkjKIJ2MKJMsryRwD5p16ZXBXW8GtqdIKFG3aW7hfdEyLAmQOXYJj5wAC1Ix9qC4SbDq9Cg/RC/c6yp7Brf6nqjhDw4WukGJqUPtSkBUU10PK4mir6bJ33jBf03lHmmPwh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIk36MMw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736c3e7b390so3543066b3a.2;
        Sat, 26 Apr 2025 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745683721; x=1746288521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4mAH/lsHMEz1SG+T1gwKnZFAThj7zt6RFf30IeeqKo=;
        b=TIk36MMwmz+v2E6UFQAzxFq7cX9hMBh70UdRPRz+C/17QsBbadLZPsKhMeoOU7iltd
         G7ILSl0ZsDp2zMV8MgTXivy5xUSTTvPlZ+vpO368T3x3V0ur4YYr7U8n6HPObzEDXgmm
         v8rpS0xqRNHj/2fO2QPClGU2LRsTiTMqx52u8zSJkfd8GZOJxOSkWZPr8+SvGPTEbM8a
         33G+lPNMwjt0QldROwQ0sIrw/iAUqLu27lHn6cqX0w6YLSOGs+i3D0losSOcmkIM+IY9
         OfL5FYeUcaCFDl1wDwQ839B6/sYy5VDLeQOl5NigdFtbuLBdgLyLFTzMDhglc7si/Y6o
         RISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745683721; x=1746288521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4mAH/lsHMEz1SG+T1gwKnZFAThj7zt6RFf30IeeqKo=;
        b=IS6uvuSzVYv/pgpA5+LKZyXkJJQxMnNqdf5VplDuMb1A6tKq1qebqFmtu9IwoNd7+s
         sPXvju7zLpwHZ4T6NEKjE0lEV18l3c28R/0eSoCFf85onjlNZ59s0DrwrVTZHEhzSrc4
         O2F2z30AxixNZ34I8VFqYf4ZgAl0+nzvBqylK+0WCR0xuCB16+2DMl5WT3kmy5QpOVsF
         tOpuew2CcEp1B/bGFcwQmpBHMXPXEqSGnsCQ1UCDahpf3qppiCyezJGZhYfPynV4psHy
         syyf34dkTG/KPysX9oiEpp2f+GLbVqFDCVFBg+bC1KABQyx8nWbFuXgM6EKVVUlZs0Mh
         9qyA==
X-Forwarded-Encrypted: i=1; AJvYcCVeAAj2qTtuH1jhid44FcC0XyQJtPjRK+rjf617vEd5m+yOgVkj+krgtFOtjQPaMV62VfyUTmeZGrHt@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqvQPpuUHWbZwlTxIrkGQRArnF00f1vlRAKocJ/OyrmQe9tck
	LEtfGritPBGpB6Dtun9kx0cIZvheDWSWnhekT8xaE2AV4+oyz/k8RYpqE7b4CIoCNaAZ/4jJ4Lw
	vHv7u22O3ttf8s3/G0vMhEjChQO/0CrmubDI=
X-Gm-Gg: ASbGnctmS0onbTdVq8Eq7nxm21fYDOnQejQi8vp6qkOYCy89MQ6xD7+eSt+wyBgxBC6
	dxpen92W5UpdkL0nFHJapcEVl5VhbrV/7fZPA4c9TKMTrKHr2KlTR12oBsvgRq1xPTjzD8ytl15
	SRnDT8QvDI5cYFrZnalQnptz8=
X-Google-Smtp-Source: AGHT+IH7TOuxcOIb/z5KitzljdLHRideNoCVIMHCUFUT+9/jdjpi5pNY+2Cb0F4t2pofI0XIXHBG5d3x7H5a9fndRo0=
X-Received: by 2002:a17:90b:3c43:b0:2ff:71ad:e84e with SMTP id
 98e67ed59e1d1-309f7da6c4dmr9665068a91.10.1745683721337; Sat, 26 Apr 2025
 09:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423194100.53934-1-gye976@gmail.com> <20250426160308.6dbe1cdc@jic23-huawei>
In-Reply-To: <20250426160308.6dbe1cdc@jic23-huawei>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 27 Apr 2025 01:08:29 +0900
X-Gm-Features: ATxdqUFoPZsx5jx8c-1apG61PF8LuPuJtJVvUotnvnYk-FpxqJiZhSo-PBsaRfI
Message-ID: <CAKbEzntEF72o1LdHCmdV+P2NC6nQ_34nQ5Jqje3Ava+dqTtwXA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add support for Winsen MHZ19B CO2 sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Sun, Apr 27, 2025 at 12:03=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 24 Apr 2025 04:40:56 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
>
> Applied to the togreg branch of iio.git.
> I'll initially push that out for a few days as testing  to let the 0-day
> build bot see if it can find anything we missed.

Thank you for approving it.
I'll do my best to fix issues quickly if any arise.

--
Regards,
Gyeyoung

