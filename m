Return-Path: <linux-iio+bounces-14723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D5A22996
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 09:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843A63A6E0F
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BA21A23B0;
	Thu, 30 Jan 2025 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCoJs7AQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969E148832;
	Thu, 30 Jan 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738225850; cv=none; b=eim1Wdf4rkcwAbFYq6CoZhDF40csSVYgBIufu4GkyAlDOQ1pw0Cb5oUJmOoTNwZGJTC3mCmb6zHReBN/2g0X5yRkDFWqydA2HmlqBrh0/ZCbJeR+K0qID9TYRSQW4Octdmgum4p4Rokm8ryA9ybpq5E/py2FETHJDSvzb0wE8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738225850; c=relaxed/simple;
	bh=iBoVNDPKj/Gbf0c/W+t3asbzNss/FHHKnMcQ8SQIC7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5kfWiSDvBg8tlOmW6CR5Xy02AtRS7GvpYovLUXdWfoqcMsZhrhYRSb6JkKMuclk9eAflIh4B5iqFY4D7CZXlgjJz8S5oXfstlzGMRFjfIKDznVpzSqM1jRdg4DjDXojLzBDhl2eN53K0lNpGao2iW6kgj3zQn9aSBRFriDUHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCoJs7AQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso2998645e9.3;
        Thu, 30 Jan 2025 00:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738225847; x=1738830647; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iBoVNDPKj/Gbf0c/W+t3asbzNss/FHHKnMcQ8SQIC7o=;
        b=ZCoJs7AQZk/ef6DYAeKI4N6JAXlJxZlnn/9eysW7MNv5tRJlri2tg5in0btEAmslX9
         o1YxpwYJV/vdpUqBdRUCABoAkFqfN3YrjKbaaMebVeXHLTayYtVPlfgMnBCVn5gfU5dL
         sqz9bcX6SBEjU6ZynIVmYkEAYBcWrgsRPRNJ+7LSIOR/dp1zsfIRZVQaZFOmCEmXQP2p
         s94NHbupX0+4yR9/nHFVx+zec6uvFqJj1x2aV37GLCwpV3ww3lV+s6dN+WSrLfiu1sud
         29yhycpYZRQF6r99q7Lgx7KvwUP2IVWXCcQzZbOBM9lRE22R/DgpGzQlgXtspvl8ZKWE
         f0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738225847; x=1738830647;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iBoVNDPKj/Gbf0c/W+t3asbzNss/FHHKnMcQ8SQIC7o=;
        b=F+5raxYWyyHbxsyQJVAm5LaE6oxIkfihiPk6eDAonEk9ZLZr4m5WHa2oCATkqam+Q3
         JpcLJsvxaguxnrxvCovgYaZ3WzWScQgHeD/blFv8kKoqW1rNfwqAVQ+wUQ8Wd80eqW7D
         /EbMmP/bHiiOhfUCFVy07CnguIGYrqA85++RqqNDjNSXoSwkU38t3Uo11pcAbaFx7yKG
         hPZWXTZIScf3iy8gSJHaw8FZVUT2rAhAmhii5NnOLA3xOJiCOk4uQOVNwInlZSeJRxWp
         Xc8IpRqgVYqobWN5bS/Wea6SHBRK0giXMrBE/JeQn8CadP7uJ0Dx1HCNhbh9NwBiwQZ0
         YmSw==
X-Forwarded-Encrypted: i=1; AJvYcCUYXIlRtSV7EE4OzwzvB2OmUL6J2s0UlFvTq+zVzS4irVXfRRFYvgMqWe4+4zeDK+/s++UkCgdyqDL7z919@vger.kernel.org, AJvYcCWnQGaQuMpcTCqEDKKIgl9xrcyLMzmen65U+IyqG2X7Woyz/VOcFNX1tIyEkJV2iUjvox9070WP70o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmIJ08ISAQKVJlYDwnsmqam0uuMGRzhJRRRNylFpZJIdOZyX3A
	RpUPuo+bWgFdrwxWuQBz5uFub5LvFrVA5rEJAeduX91lFVju24HL
X-Gm-Gg: ASbGncscJkglpVnCBmagnTjHttMz6SL8yMgHrjVTF6sMdKMfmxwJHnV7mBshvRdUX+T
	12gJvvRY+XoeEcq1IRSOSO0kI0yhg4oXqzQXWF7UERN8wrvH0n8BdCHV+5TX4J9VZCTpd2vuVVp
	dzx7cBLIaPAHQb1fugYFnyynjVUVCXK0lfevCpRqTPxnuZ2yv25FIygUjS7e3XBdkU67ew0SrRn
	YiOUYoFpWeh6WDm7wod6Z7QOqH/RUlq0n8vJmmlFw6Jrko2xNxZh6FVTDurqfDo7ALiyBadQ6IG
	OFBhhTjFHUBDsXXUvfuN3cbOgQxK1mInFRwsTZWfzegBd14KNQ6OLUHF+oBEt0k=
X-Google-Smtp-Source: AGHT+IG5LQnrAkV7laFoY5uti4KcngXW3+Wd1vnOWp2ue0jCML1uupplCcuvj7bn12N3LoFdpRnPZA==
X-Received: by 2002:a05:600c:4f55:b0:436:51bb:7a43 with SMTP id 5b1f17b1804b1-438dc3ab675mr59301785e9.5.1738225846463;
        Thu, 30 Jan 2025 00:30:46 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc26d05sm50249665e9.12.2025.01.30.00.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 00:30:46 -0800 (PST)
Message-ID: <a63a6a52102fc918ef60ed5ced0505729387a4fc.camel@gmail.com>
Subject: Re: [PATCH v1 0/3] iio: drop useless assignment of cache_type
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>, Icenowy Zheng <icenowy@aosc.io>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 =?UTF-8?Q?Ond=C5=99ej?= Jirman
	 <megi@xff.cz>
Date: Thu, 30 Jan 2025 08:30:47 +0000
In-Reply-To: <20250129152546.1798306-1-andriy.shevchenko@linux.intel.com>
References: <20250129152546.1798306-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-29 at 17:24 +0200, Andy Shevchenko wrote:
> Default value is REGCACHE_NONE, no need to assign it explicitly.
> Fix all IIO drivers that do that.
>=20
> Andy Shevchenko (3):
> =C2=A0 iio: light: adux1020: Drop unneeded assignment for cache_type
> =C2=A0 iio: magnetometer: af8133j: Drop unneeded assignment for cache_typ=
e
> =C2=A0 iio: pressure: zpa2326: Drop unneeded assignment for cache_type
>=20
> =C2=A0drivers/iio/light/adux1020.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
1 -
> =C2=A0drivers/iio/magnetometer/af8133j.c | 1 -
> =C2=A0drivers/iio/pressure/zpa2326_i2c.c | 1 -
> =C2=A0drivers/iio/pressure/zpa2326_spi.c | 1 -
> =C2=A04 files changed, 4 deletions(-)
>=20

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>


