Return-Path: <linux-iio+bounces-7357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91EC928822
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 13:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7423A2879AF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 11:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2B149DF4;
	Fri,  5 Jul 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia4VzWAc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC93145FFE;
	Fri,  5 Jul 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179839; cv=none; b=Uc21MuxK9HNIe0KCIRlG71mHlil+iC7S7sXvRVfhMZU13qydrF4jHtKS7pEVpikT1qHOkCRZLxfvkzNbxJc61ErgY6zgu7Ci+WkZfn8tFECSFI8KNaU1pFQHMVI/XO9Q2SWroknzhRR56wAitiX4ry+N7ex1vgR5FItQkmIT/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179839; c=relaxed/simple;
	bh=bk3qLkBEIyPLDB7z1gSU1T/1fxUgl2lfuo9ssbi6J9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q4dz5kNbcvGUlJ+amv+5wgLySAgidldQoK4s5+REng8fRseBuwq7yz0Uwrk+IDLoBZ3ZDM/N1enkNP/5xUwGnfKMgfW0Cp4hoP2Os4QIja93dAeOkcussAmVOXXqcsoVmEYky6Ep3z4xnRu2vbZEuIlIU1HTdECPTFBhLqncMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia4VzWAc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426526d31a3so2829915e9.1;
        Fri, 05 Jul 2024 04:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720179836; x=1720784636; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bk3qLkBEIyPLDB7z1gSU1T/1fxUgl2lfuo9ssbi6J9s=;
        b=ia4VzWAcIkkj8I1iBPT2uu5Mc6rF2BPdTH8yYeoTxgOLviFlZBsLsUBZEpWfry3EbW
         2Fj4H5kDp8G9wzrKox4efakpy/bT6tQ5qcHbLraEoW5ZA4oVry0Od/X0cJZidfPCEVt2
         qACZUBZ6x3q9s+fCjgvYO80XU52zdycOGNRlza320ud1uLsMtz0018msebZnppu7pNrL
         wn1bsPMnmz9cqZYNCi/EjR48zXnwVLJtQE6LVVZugHK1CSvhefi3xzzmLKbTF4pLKG6L
         r7/06ijkBW+vcB7RBrsIsTDmGzE5c1UaKgpEvsOJivDtm36kl4fxrf3TRBEqezWd26Cm
         n2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179836; x=1720784636;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bk3qLkBEIyPLDB7z1gSU1T/1fxUgl2lfuo9ssbi6J9s=;
        b=paFHWpGsxtKolnIl+yVrAfBO/p13EgA1R0kJhQzcipPe8eUXh5nenYcGfkk5ZgaW29
         s4qaXrIE8Er7PorCqC1pmo+7WCkl1sAYhEogjYh00q1ahSZVA58NElms2s4ef+FnkUjd
         3Zy7jxFg77TioHi2KYfFR5NdIw5OmK+RDd7IqjqhwKbC1JBkP+VvvoCNNeQxnsjkz0B3
         54Ahy/9Ha9/yrQaVUUQkiSrMDG6qkvRdS4BcC+VYGMfFurp+wAMpWF0cA7h7wxvY82c1
         r+M/Hk7u1w6EzPWScBn4Qjoicckwu9p2r7o2J7WihphfHSNXflK4gH5+PzdhUOf1YOvA
         oYCg==
X-Forwarded-Encrypted: i=1; AJvYcCVLn3m4yyEkwBK3y5pLRbQ0qs5zaydV4UZEy/vnLyCf9EZ5h9Ut1ekPoisWVnPDH0iNKtiy6Q9Iv2kKauQIR1TVdwwmxnV/A6uMDCSj
X-Gm-Message-State: AOJu0YyjYyEzBothhfAO8cYPKDylo9PDtAFJ4HbP7vjwaX6wIPf1aqBq
	gAk3x8cACKUnW3UoqZoJ/Mdr4rUOoNCu9czAt3fyrbqYoQZz0ncP
X-Google-Smtp-Source: AGHT+IFesY2jLEXcHNAnK0re0sLVhAl9HacKcjQib3stZSiF2Cg290l5GPhc20mRgpYMZL4irPzgeg==
X-Received: by 2002:a05:600c:1989:b0:426:4b90:1e91 with SMTP id 5b1f17b1804b1-4264b901fdbmr27496175e9.24.1720179835689;
        Fri, 05 Jul 2024 04:43:55 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca5d5sm59187905e9.30.2024.07.05.04.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:43:55 -0700 (PDT)
Message-ID: <1dd2e42a27b4399d1a889dd2a794ca1761a5faa5.camel@gmail.com>
Subject: Re: [PATCH 2/6] iio: adc: ad7280a: simplify with cleanup.h
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
Date: Fri, 05 Jul 2024 13:43:54 +0200
In-Reply-To: <20240705-cleanup-h-iio-v1-2-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
	 <20240705-cleanup-h-iio-v1-2-77114c7e84c5@linaro.org>
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



