Return-Path: <linux-iio+bounces-7358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B30E928824
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 13:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DF9286188
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 11:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981D1487D8;
	Fri,  5 Jul 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcktEEkP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5D14659B;
	Fri,  5 Jul 2024 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179940; cv=none; b=nNHvtUGFCocCecsVh68eJTFoK6LOY+egc/2+qNGCj+JNLw2UXpD5Pf7zgDj7OdbNVemkrah9RVMKkp631F+D706qRmDuUIiG9sfa3o+TJcAHmTPQZYPkwNHVbH65EuoLLriSfBakn+uIAA8xFxIef2gcbsvtCjPmbYvQpQoEjFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179940; c=relaxed/simple;
	bh=bk3qLkBEIyPLDB7z1gSU1T/1fxUgl2lfuo9ssbi6J9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ohJJnaE1Wt5Ff/j7Yyey2xHywGxc6FyRwqZCcLQi4aym1fbHQqpEmCktDax92cvzZy6szv9zp46G2SJvZnPDX1VaOsEN4U7/jTLzFGE6KVmVdvTkijwD9v0WrAah0y+YjtNtQb8e3fJVGo6EBNSR3iYMtAb4KTV5NKKlw5fMXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcktEEkP; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so16533321fa.3;
        Fri, 05 Jul 2024 04:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720179937; x=1720784737; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bk3qLkBEIyPLDB7z1gSU1T/1fxUgl2lfuo9ssbi6J9s=;
        b=NcktEEkPqCP12vMWkKitDOSW/2UraZOU6pWYyHNitjW+/SobqJMcaKtJ3p/ZoGW75Z
         stxrQnISoV27yEZT2WcMdTW5Z/e6pB3UsRpwOU86OVfMDZe0fmmiL3cQBA89HwNL/Qbg
         VbIXQoLbaL8LWwYisR3xtaqQOZAHkgocVAz839DpZF3Vhlfle10Bfby8yE1KXldt6V0A
         CciUEm2x9LaTU9fvH1STO/iqw3WmPgm3rkYfA0ZOAKDHUbtmtT0M83zle2Yv4dcjcKzQ
         +nOoK4zycLeizPMR/99iRVSJ7TOJWoziFfUAWbGEUAltpbvdTBq8xoJCg2h8ds/H3Ryb
         /k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179937; x=1720784737;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bk3qLkBEIyPLDB7z1gSU1T/1fxUgl2lfuo9ssbi6J9s=;
        b=bMbUbVmXoypqmTeCBD7pHa0Wh7Ys9/zLOiwQRo+O4ImwtmHoa5NN4jBqqjW4slYZX5
         fLKUMhnoeqGUu2X4+3xFEOcvlA0N9WSEkoivAl1u8AY8IxY+FFBYNJvkE/0hukxWZj9P
         JuCd9MqISEmR5svLrc0sDQ+1fOrHm64lNtx0hJr6J52aNbhnZ/tk5kXuclsWX0f425Z6
         N2jhjdWvCtozQUhIK93GfrISJAR4gpHKqeYBdfU/1X+/c6BG0TBWdkqavUz8bQJ1DOC3
         FcnnROpa3qBgSQ+0pLmVKfJK1Oq4XmVb119dFVlX2LC6KFyltj28SPigMkFldeJjgMjs
         B9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU0QBwXkkrZJdvEc3wLHEHVLqCJJhrXlW3LRE9TVzzrUBjT7ZX7NvJe/wkgOtkbdAYIngSLmSiid4gR1zdnWpEburBL+FQx9NPUQ2gw
X-Gm-Message-State: AOJu0Yxu3H6PERmz1lGgSB/6N+EUezwkvp5F0gvIukNim7d1ksf0N/4M
	OvqeU0qnWMpt3/q/Lj6h3xNS+JuKdeki/fR9uGc9dd+m/4rhi8uU
X-Google-Smtp-Source: AGHT+IEwO1eutKdgDmrzLv1pT3tcJkCP4rgFN//lUN1pr21x/OyBkPLP7VV/vwv0JiiSni3QfNE10A==
X-Received: by 2002:a2e:a497:0:b0:2ee:8777:f868 with SMTP id 38308e7fff4ca-2ee8edc2deemr28599761fa.35.1720179936416;
        Fri, 05 Jul 2024 04:45:36 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21cbb7sm60483875e9.26.2024.07.05.04.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:45:36 -0700 (PDT)
Message-ID: <577f07db3484347499dc676b867b8255be0dbb51.camel@gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: max1363: simplify with cleanup.h
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dan Robertson
 <dan@dlrobertson.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Oleksij Rempel <o.rempel@pengutronix.de>,
 kernel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Date: Fri, 05 Jul 2024 13:45:35 +0200
In-Reply-To: <20240705-cleanup-h-iio-v1-4-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
	 <20240705-cleanup-h-iio-v1-4-77114c7e84c5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-05 at 12:40 +0200, Krzysztof Kozlowski wrote:
> Allocate the memory with scoped/cleanup.h to reduce error handling and
> make the code a bit simpler.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>



