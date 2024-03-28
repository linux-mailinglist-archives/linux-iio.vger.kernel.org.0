Return-Path: <linux-iio+bounces-3881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36DA8902D6
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8FB1F23FF8
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E67512D1E8;
	Thu, 28 Mar 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlNlRLmZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA07EF03;
	Thu, 28 Mar 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639089; cv=none; b=taXmDteo81m95Idv1cwZUFS7USAMA7T+6H/7NWbruxIalphXnWYuONdzYiph09Pulih2ncmaqzHrIjAoXiqbUy7MvuJbjr0kRqdfszb/grIqJd2WHQgqAuRXYIV/eGbIRbUfKqE7WDK47M16buwHXImrFvw/vhqd+FQZ+C6J11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639089; c=relaxed/simple;
	bh=ikyIM6Smh2EJLyOtCNeTjLiNuBbusPLjtsKm24aJkxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n9QUhvtKwNpp+wKj3bwDnh33hm56UPeY8nyBVoSEQi22sdKw4lmkDK+Vr9kt2s9pgt+mML3BxhaBTz1TIE+TZVIpuytd6uhYplTdgQnKi8T0iymAvp++MXSgRPKMaZMa9d8i3NETOQKrWsLzhuvo/vziZlRVhwHke5Ku1dqvwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlNlRLmZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513d717269fso1197537e87.0;
        Thu, 28 Mar 2024 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711639085; x=1712243885; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ikyIM6Smh2EJLyOtCNeTjLiNuBbusPLjtsKm24aJkxo=;
        b=mlNlRLmZ/B6dNSydMT5ZLvM6Tq4icAfaSBXrHpC8qF3H3lirC4xf4V8qBEmZCrF0cn
         0ZFKzliuU6AqNcfH6lZSwmo99LAFHwjzobyUyqvUwMLME8M5K3j22ARstKe8S7MVBuKO
         8wpd2e4m1WAQ9+XfGsvjeMsiAuc3+58HsMbqW9OcVAl2kFHyluwSbbIcxuA9B/yX6o5i
         cKTEHpYDc5swaDoN2aM35XwEsCkRX6nkZWa/ZkInHefGNRbm7BMU8SWvuZNEwP8/5ylg
         4LWulLNXZpkYwHxyFb2AZY2OY35Y5OuOJAq7pJSVtR6+/1p0pF5OBb7GerxXfRmxHWXP
         b78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639085; x=1712243885;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ikyIM6Smh2EJLyOtCNeTjLiNuBbusPLjtsKm24aJkxo=;
        b=dUYcCRObsSiCnQMFiSmodOKMTh7o8vD3j4lHjUHR4uaNkj6XN9k1Ih/LASnNkFmiel
         1Iuo5unFeIrfAVyrunZ66KH+SUXRJz4CsTxdVP+j6N99SwG5tP7vL3HA2avy4FEzbYnX
         o4ZYSTHYiYxysGBJVaR1EA6EPdYgtRUwMg4zAJxbqZIyHibP2Y9WT0QjY7F5Mko4v+YZ
         lMGwx0FcPiijCmKYGJygB6GPLK/bdpTZDpFAjqfJG4LADuoT+JvRM+5FSWK/IyHe818y
         pySA03sbx1j/FonoInoRm5s+/Dp9uc6Io2orWqE6pzBYKRtOS1cceamPcSKw0E9/6WqC
         57Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXyZWUMt6gfjDW2g4ikVuz9HNkE8TdvCQbLbE7ZTg3d9/tJFdZaD/OKMKDAIAFnpDTJVY+9/y55iPGOX0h+JM1q6kGzm84BU98udtaoS+u9h6rkbTxvvIAQ+N9NxSRscpdvfLxXLA==
X-Gm-Message-State: AOJu0YzFkvNBS7ZYRC0FKZvjm03OB8EDEHy1zvSSzuq3POoKxg17608c
	PQnVedkZ7r3lCePbx7AiAWyi3pTrrgey9XOFAM7H/0tYfXKFMa8F
X-Google-Smtp-Source: AGHT+IEApEjj8x7yLg1UdNvseEsXFjK4OpXQc8XbDzSW+camPpR2PUz0b8rskSWJUivQbE6VEjhqiw==
X-Received: by 2002:a05:6512:3285:b0:513:c658:799b with SMTP id p5-20020a056512328500b00513c658799bmr2010931lfe.55.1711639085048;
        Thu, 28 Mar 2024 08:18:05 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id bv4-20020a170907934400b00a4e2ad2cef0sm201014ejc.203.2024.03.28.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:18:04 -0700 (PDT)
Message-ID: <d30c43f7f9d2db5b9c0e779d99f029da1a751636.camel@gmail.com>
Subject: Re: [PATCH 01/10] iio: buffer: add helper for setting direction
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Thu, 28 Mar 2024 16:18:04 +0100
In-Reply-To: <20240328143652.068492d0@jic23-huawei>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	 <20240328-iio-backend-axi-dac-v1-1-afc808b3fde3@analog.com>
	 <20240328143652.068492d0@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 14:36 +0000, Jonathan Cameron wrote:
> On Thu, 28 Mar 2024 14:22:25 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Simple helper for setting the buffer direction when it's allocated usin=
g
> > iio_dmaengine_buffer_alloc().
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> I wonder if we should align with the approach for triggered-buffers with =
and _ext
> form of the registration function that takes a direction.=C2=A0 It seems =
odd to allocate
> one then change the direction.
>=20

I agree it feels odd but I did not wanted to include buffer_impl.h in place=
s that
should not have it :)

This patchseries adds the direction to devm_iio_dmaengine_buffer_setup(). M=
aybe what
we need is to have a non devm variant iio_dmaengine_buffer_setup() and turn
iio_dmaengine_buffer_alloc() static again. Maybe that would make things a b=
it more
consistent.=C2=A0In fact looking closer into that file, I would get rid of:

devm_iio_dmaengine_buffer_alloc() and __devm_iio_dmaengine_buffer_free()=C2=
=A0

and have:

devm_iio_dmaengine_buffer_setup() and iio_dmaengine_buffer_setup() that mak=
e use of
iio_dmaengine_buffer_free() and iio_dmaengine_buffer_alloc().=20

I think it would make more sense like the above. Thoughts?

- Nuno S=C3=A1


