Return-Path: <linux-iio+bounces-24093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D37B56869
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE283BD33D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 12:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879B25F99B;
	Sun, 14 Sep 2025 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB/Z2r8A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1706E247287
	for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757852067; cv=none; b=IWJv6g64wI5bU4qnmaum/smV7V5eAWRCRBetsyj+E8OVArwn8n7VQamrNs929ctIsbTnM5NzXFtEEXGNkjRAkAm98eBKDjYTTYbxWEKjcCkLaKi93CH13QyJ6Kqne8rggaTOJk3B2UI6QdAxdToCdkzIiYATMNmXJDp297bSwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757852067; c=relaxed/simple;
	bh=zAkRkiiSiQAUgj34uGfT/rECpdZmsr7OjRlV6ZLCxyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hplxcq5f/+dgb64zJ8g0Ue0vwXxglzZDOINJ5ODtpX/JdKPPtqRKx6FTyqFftZXY+vxPVWBkZX2M6jNH+oR+ZvWPl4FQC7Ps7vUkYorx0ntp7qqmHdYKhC4DXOokLFquXaNmPgZrQIunE8hg/4hGL9xPoEnabypqrzapr8ThhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB/Z2r8A; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b042cc39551so550346766b.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 05:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757852064; x=1758456864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAkRkiiSiQAUgj34uGfT/rECpdZmsr7OjRlV6ZLCxyE=;
        b=OB/Z2r8A5xo2vepT7jnk6VpUC1qIYwoM5I/8HXCBFy8Z32v3I6N9SLL2YJNXzCYryy
         O6VFOoGpt4epmj1o3Cf8x1ZjAItXP41g2xsFsS/MPWM9lCj15bmGzD4UoiB6XpldZdSS
         MsU0jOc77z+pTdkkIP6AFWwrSJrtw0rzLRmqJeC6HmfzTcWf0tyaNrxXzUhfS4l98Tn2
         TNv+QsvVQRcxwBejfUOJqFw/nk+aCZaSOlxPlznKh/IvGLLdJjpb3gbHUpQ4ph7lvY+W
         03TFGsG9q1tA98qbx3nQTbQxHyguZBUilwfXi2IZpHEwh1WylLLUD9tFjuhh6cUgaoY9
         JIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757852064; x=1758456864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAkRkiiSiQAUgj34uGfT/rECpdZmsr7OjRlV6ZLCxyE=;
        b=qf1oEU2TfLYzG15RLUgsPlhRsJaJIn+T02RwwbGkUkqgdyY3Zl1tueh4rnAR4SQ5MQ
         TItzbvt77g/BC/EVCUkBQ7nAbRNjiRLuvfieUqtAi/HiU2Qt/9BQcbx8/UK4sigwgltA
         DXvvt5WQVJTZWz/k5ifUAse38YNS+sm98+RW6GIw05ZzGygZEa+LDMgORS34dxlBDyVf
         HG8+UwzRsQc6CVDbaxsu4n2A2AZOhGOXdfjAwIlwFbQrqytKpQJ/4udKrqdY+esoM6Op
         QU2wi2sFp+loiSKuZU4RB650gpoKo1cDITT1YNjRcoi/Kl3QsD644EwxuAlJ7UkzZlan
         iscA==
X-Forwarded-Encrypted: i=1; AJvYcCU3HcD/Pggp5EwMPZN6IaPxinT8F5PotueT9X/HcxxxyOal9fAWf8+E1qGrsdfEBorRf98G6GfMT6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYN84pqs9vgqLeM1HiC/aKXmxXBk8IxCz0MmiPFInGv1jxYB7
	BMsgc8A0TaFbkthJTDjBW7BlXsSXh+ChGxaGY7sUT2EgF7QiGc+Rwsz08ADV3rDrVVpLJQFzFBZ
	bn/KGI7TmtzppfLOcSzmrZcmVMtFJr/o=
X-Gm-Gg: ASbGncs9TONIvyXcjOI2HX+XhdrfWdyxzoLOSd+wR/yKBOQpKugsH+/tWRrgaQ4DH6a
	PcKC0eMKGRfbJJlIyPMm5z4gJAy9hQGTvlcrmTe5uSw/yIQUn1jHtP8zASTPNQe0+7SMMulpaE2
	jdOE00hEldr+SsubJweC3089o5Sx8UnqlBisRx//0bb0Of8np4p1jcsLXoiYi49MFVY/te5M3v0
	P5UfkotNGLjGXIpSQ==
X-Google-Smtp-Source: AGHT+IHodZKToXhvftGrPhwkbA9rZagoYrw+M780Ipaw/v/nz/SPOnfBcDWaVE5LmeVvnCDbA784u9htXO5Uk2mybzs=
X-Received: by 2002:a17:907:980c:b0:b07:6444:a6dc with SMTP id
 a640c23a62f3a-b07c3878986mr931756966b.56.1757852064281; Sun, 14 Sep 2025
 05:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-9-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-9-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:13:46 +0300
X-Gm-Features: Ac12FXyh8Ic7NJuVMAf9Mx5s1rDgXXEaNIA8zCEN_ZwQM9qRpXQCwZ8FIqIa6WY
Message-ID: <CAHp75VcV2tVeYT33sLdu08vH5XHi_AgNxykMuw6oam0n0DMjqA@mail.gmail.com>
Subject: Re: [PATCH v3 09/18] iio: accel: bma220: relax constraints during probe()
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:40=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
> Allow compatible chips to work even if their identifier is different.

This looks to me like a candidate to be moved closer to the beginning
of the series (before even split).

--=20
With Best Regards,
Andy Shevchenko

