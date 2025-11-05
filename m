Return-Path: <linux-iio+bounces-25909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B1EC350FF
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B88E6348870
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 10:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6692FFF93;
	Wed,  5 Nov 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbU0x/kM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948E299AB3
	for <linux-iio@vger.kernel.org>; Wed,  5 Nov 2025 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337785; cv=none; b=SlPQJJJl+4GqdkFytS0yKI7cbRz31vMNRBVuNdKjMnJXQ4oTpvrJG3zfagAetNu9567vHURapaKmSkD2xOUuwlx2ilCplyR+0fXOW/4xJLoYMwZJhC4McUv4p/Hz1lZwFVncYMp51cbJ4uQPBESH51Et7YDvteKRgIkmKTZGzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337785; c=relaxed/simple;
	bh=o8q8eHDOchVGcfDlePXk+hD6Np8WGRhU4jrr7Ucvbcg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4dr4kMzei4yRXY2ruB8EN888eW7NUhiUtKkbJ7BBXyxiFnM1DtcSqgIYQ7Wcb0P59bt+cAOtONEdR3JoU19+5lzVlxlGNwoxkOxpjCDG0Oe6GkJAYC7BcXF7ILt87mMJlM1gyTJ4pQV48vAhUfsPwlnZAb+/5t6f00t0DsXqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbU0x/kM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c7e0282dso3571844f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 05 Nov 2025 02:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762337782; x=1762942582; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o8q8eHDOchVGcfDlePXk+hD6Np8WGRhU4jrr7Ucvbcg=;
        b=mbU0x/kMB1aySzc0xzuEM5FuSE1snAnaK11Z2damf3P85NbMgCZdPa5UzmFYVRRegG
         th9L0SAbRWbwMoSbSjn+bSd4+PXZydLiBhklusF5fjFTzMmFUkZ3oVPnx+19zqNo5aMl
         JX5fbq6k3vaBuS24JBljGn8tGVdrReOMnfTgI26CxMqZTaMo0bXOcugppjMLSrkaijU9
         G+VW9EaiTMyvEmZOeu+bj11+t1uKDEd2eIJbNdKyrs002m/QeQsxMjb61ID9dgbjH5et
         PioEQPCP9pN01dzuAdzzyKo/aajNCU4KU5NOz/1P2s/J95hpGqaploBtJWMG5umacdC2
         LnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762337782; x=1762942582;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8q8eHDOchVGcfDlePXk+hD6Np8WGRhU4jrr7Ucvbcg=;
        b=hbU4L62PS/JbY3u6h5QZPwA+//mMIB0dIO9Nbomi5y/+E29geQfb07i5GFybWk27kH
         y6G7CzvKU2y9CWJntg6vn0l3RoKgGwykSJPZnm+1nqKInDzZssM2B829oTlP67IfF5yQ
         vAPp2gQLGMlZ3MGpYbin0vPWT5r/DIy/DSBOQqnshvgF299OvoFOnsD0D/o+3RCy3obS
         IaScy1rFDcaDrlVRq2u+3anXjtzOYabntlkJ//YpUj7QzY6x4SHMxN41DKpNVV1dDjTN
         nNRC/lKGtmg+fn3yQRq5zQDp1vbl/i5mR5V+9qzZSBlyolS099ttprCWifNJ3J9WJQKe
         sVuw==
X-Gm-Message-State: AOJu0YxPo0PZPajec6nN0yFFlPXZqo8VMnvP/QqZzyJ5I2Hbr3UoSSIk
	5Aa3v8vndSI7YS72fY8nWMFbXkFh3ZZlOZ9mXTaWuA88UtM+XaL4zVA/
X-Gm-Gg: ASbGncs3xs6bnzIrEHgUkV2xM1XUgQv9rnTwlMqkrME2t1rVmkJY+jrnI1ckys1M7kv
	5iO0KxZAxBwrruFpdfx7qPqtzmd/KzukrjEbTMsEqbJQspX9Ov+lN0rK7j1wfDhHsfsOPvec9qT
	8qMLWYYvvaqj5k/YFLpfNrzz7riR9URegDivbVbh0GyZmcUPtms3yNsU4dI1oscBnRMalUkzULW
	L1C4NKROrExVVtjcVkS6HvRWmPKIusHYiHyj7Q2eex77gr6N4qZbeO2NTi8JCmpqTVtUkfS8xCA
	6XMNjRpmSsYwqnyQMPsbwtlTXTpc7XFLi8IJxuoNol427PhwtkEsMPJI9oqPg6sXeIrLC9Sge45
	FIJWACoXnlvIF239W4R/K6x0C/H4V4+IF85DO1i4rjAgWlRWkbHgHx+dJBtFX4b4doE6OX5m4hn
	/Dkb8780CR
X-Google-Smtp-Source: AGHT+IEcYoNlOVReU2YdkRKw+el9w65GlaEGkVjAXyNIxaDkcpqgMt83AXD2Voio5N3cYobsRku+Vw==
X-Received: by 2002:a05:6000:26c1:b0:426:d81f:483c with SMTP id ffacd0b85a97d-429e33088ddmr2183737f8f.33.1762337781952;
        Wed, 05 Nov 2025 02:16:21 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fbd1csm9667564f8f.38.2025.11.05.02.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:16:21 -0800 (PST)
Message-ID: <039e8f13b876928ca331a5f698aa6c7ca2a5ec5d.camel@gmail.com>
Subject: Re: [PATCH v4 00/12] iio: dac: ad5446: Refactor and add support for
 AD5542
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen	 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Date: Wed, 05 Nov 2025 10:16:57 +0000
In-Reply-To: <aQpGVYlOcYkSuIRo@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	 <aQpGVYlOcYkSuIRo@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 20:30 +0200, Andy Shevchenko wrote:
> On Tue, Nov 04, 2025 at 03:35:05PM +0000, Nuno S=C3=A1 via B4 Relay wrote=
:
> > Alright, what was suposed to be a simple one liner patch ended up being
> > a full refactor (modernization) of the whole thing :). I think the
> > changes are anyways fairly simple so hopefully nothing was broken.
> >=20
> > I'm also aware of the checkpatch failure in Patch 7 ("iio: dac: ad5446:
> > Separate I2C/SPI into different drivers") but I'm really not seeing the
> > added value of adding the kconfig help text to the core symbol.=20
>=20
> I don't see any major issue with the series, just a bunch of minor nit-pi=
cks.
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>=20

Thanks!

If I do need to re-spin, I might get some (or all) of the nit-picks include=
d.

- Nuno S=C3=A1

