Return-Path: <linux-iio+bounces-26897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A5ECAB714
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62A73300D430
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBD8155326;
	Sun,  7 Dec 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD5GHYkO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBB242D6C
	for <linux-iio@vger.kernel.org>; Sun,  7 Dec 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123168; cv=none; b=gVF0AWS6QR4Am2H3ebDmO8aYmTxekPUrxnB1ASa8pWETexcJIflyzFFsntyZx5IMq6/m/DMkmo2WvbckuAhGI/QBH7V6q+BwNuBPAYD0C9fbgTn1U1/30wpSYhQ4kRiDRKudWg5yXFuTQc5ZLy6ZAvlsGR/DEwNYSDos+vWAVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123168; c=relaxed/simple;
	bh=Ebs9xnJdozT9JhjRrPwwYTQ932pWegL9n1JhdAV3v+o=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:Mime-Version:
	 References:In-Reply-To; b=B/Pg1GrikFB8S+67qbXFYrvF/nqQgA0CSZvVqHutlzFnkw6IQhErmut8i7Kb5l5sSPXj0rU+94Cy5w+aUjdqBKVnFQKQPByz6ioVJ4mv50A6lE372rHNrpa8Tl+v6o2li5EA0AKZ7vL5dAfBRRp/4KjFDq0A0V79ml0AQ51G7lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD5GHYkO; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9371f7571cfso1052157241.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 07:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765123166; x=1765727966; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lAgMFlNyMLRLjBCsqD3swe1jJ7Gk8kx8vIqYEMB0v5c=;
        b=jD5GHYkOoZJtlPbwPMQxVecjjv7TiUINuO67OuNnFhhNExLfGhLcBVXCrhUWak3tO0
         dIaqi+s7rxlnhHcvAqTSU2+x6o0R0ZtWcJwYepGzuEDFuNx6n2Zgj3ldsCCcCO+o4S4G
         h13TnhN65CHJzJRILtDB5PDo6jjO/GV/owvtwN5tHUc0CBfPu5NMy8vsbRMrWyzBmyW1
         6IBy7F7IcuAf7KlFvXnR3yF4fJzkQc/UUOq16Zf824SRxM44n9OepH8t8HhlZ8mA7Psn
         EQ2TjzTi4AawbuvskfbXY8u3C6GE+WgqPgp7BqHl+Q9ogF9GsLLp4oXRitbE8/dKmwXZ
         C/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765123166; x=1765727966;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAgMFlNyMLRLjBCsqD3swe1jJ7Gk8kx8vIqYEMB0v5c=;
        b=rsNUMEPYtXIufEoZkxacfJpou4Kg7BDHzeUDIJtinT9FGebTsPi+E4UWfOOBoEa/yF
         UJpJ9Ejs1BjtaaUqeZ4ZvdXTorq2brwoipHO8tp17Ssxl8N37zgBduXwkJ9aN1NL24iM
         CvllIshlhUN689vtmAAtYsiRIu7ax7KRon8KIq5lcSBd3CeaL5SADYfB9AAUHbA9Dr0R
         KRTSGJAW+Sg45SJJ1t7+L/2H3mog+yuBziSC4NIXiQJOoaiI7Ae7J3uQXMMLv5fWXMFB
         /v6MlVcKvQ5SdRn2KewVjQMEsV4vDDHoPQ6NcV7/9VUDFOgwcYVvxOpO/Flbz/bNg+7o
         eMog==
X-Forwarded-Encrypted: i=1; AJvYcCWFti6VygM5YNE+bHPxxk/4dPorpPXkpLTgYRiFIZAS87GojUzXpQ73RcsV8zTPX1N2YewKj3dWcxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15yYyQcJ8K2gyIrk/4aho7C9fxyBmOwDcgSb5Twt143C1RHTH
	V0a+nCAEqieI3gulPJlQqgVc8lI9xVMWqdACt5dt6pvLt+1os6dDIK0Z
X-Gm-Gg: ASbGnculWr7rEhQwp0qQSTTAuTrjHpTVLEzqAjemfoQTtUnkjR6ucSAVtubLYKL+JFM
	mOa14xiBhc3sTgdAtzJZx8c/uEQ25uILUUMF0ALKFDAOWXebrAiPEOnGKc56/CbEIBG2GpOc5Mh
	oBdg9k5WN/Q7w7Wp+gPw4XY9J7uSFrq5ICTmrhRIZLyX3piGl2JACbpa5Us149GgCHchKASyAe1
	28Tvq+zvFRUNpMX99gXCkCS8N9CgLUhteBvrw06VmMpMRB5iuiUvPca0qdVEyLsq3o+s/YmRxEw
	aPmR8eREcxklU9M0MOHCpXQsEYpW5R4Jv84GkY2Rf+/vglVT4zKY3RVYjH9cIrlAlaLGpQgYwlP
	oQat1bt/ITzZTs8gkBVNYp9Jv6UE3looHFRaOpkJuyU9qRmf7rqhgGrEvAkDv4pUdnRVehtN2e2
	/0Bgw=
X-Google-Smtp-Source: AGHT+IFfxCyfUKoveUH7oGp1n4BsXKh+nrF3WusJSRi8+b035IQ1lyTlQABylKlq6X/maPcFuV+GdQ==
X-Received: by 2002:a05:6102:1590:b0:5de:8e5:222d with SMTP id ada2fe7eead31-5e52cbda9admr1225249137.22.1765123165695;
        Sun, 07 Dec 2025 07:59:25 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e510cbb3dasm4480414137.9.2025.12.07.07.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 07:59:25 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Dec 2025 10:59:22 -0500
Message-Id: <DES3XUNSY5DQ.3GYGCUOO0EVQI@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, "Lars-Peter Clausen" <lars@metafoo.de>,
 "Michael Hennerich" <Michael.Hennerich@analog.com>, "Benson Leung"
 <bleung@chromium.org>, "Antoniu Miclaus" <antoniu.miclaus@analog.com>,
 "Gwendal Grignou" <gwendal@chromium.org>, "Shrikant Raskar"
 <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 1/6] iio: core: Match iio_device_claim_*() return
 semantics
From: "Kurt Borja" <kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-1-b4a1fd639423@gmail.com>
 <9562673ef83dd73b6092b5a7d2042b380a55700c.camel@gmail.com>
 <20251206180546.2a8b8780@jic23-huawei>
In-Reply-To: <20251206180546.2a8b8780@jic23-huawei>

On Sat Dec 6, 2025 at 1:05 PM -05, Jonathan Cameron wrote:
> On Thu, 04 Dec 2025 14:23:19 +0000
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
>> On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:
>> > In order to improve API consistency with conditional locks, use
>> > true/false return semantics in iio_device_claim_buffer_mode().
>> >=20
>> > This also matches iio_device_claim_direct() return semantics.
>> >=20
>> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> > --- =20
>>=20
>> Even if the rest gets a NACK, I think at least this patch makes sense. I=
n fact I
>> would even extend it so that we have the same inline API with proper ann=
otations:
>>=20
>> https://elixir.bootlin.com/linux/v6.18/source/include/linux/iio/iio.h#L6=
79
>>=20
>> So it really has the same semantics as iio_device_claim_direct()
>
> Yeah. This was on my mental todo list. So great to see Kurt
> dealing with it! :)  These calls are much rarer than the direct ones
> so I wasn't so fussed about getting the sparse coverage. Makes
> sense to do it just wasn't high priority.
>
> As Nuno, suggested though I would like the sparse support for these.
>
> Jonathan

Hi Jonathan,

Great! I'll squash all "semantics" patches and add sparse support.


--=20
 ~ Kurt


