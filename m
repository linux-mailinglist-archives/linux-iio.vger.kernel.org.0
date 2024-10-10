Return-Path: <linux-iio+bounces-10384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F82997FA2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 10:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B251C209DD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 08:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD141F8EE9;
	Thu, 10 Oct 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHRL7Xj5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717DBE6F;
	Thu, 10 Oct 2024 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546090; cv=none; b=dENRe6G7eMw2d5CW/JxJkJaglFYKlBdnDBPmU1GNxuG+LFFL/H7vcWrPLYrCnyI7exkDQCG6oQvdEcBEP6b/LDr2ry2jI2bwAqzwYNWdxxlKMlsUNnQZRGIhGExh2e65dS2halbvZveGf5yk7muHKhGkcb3eHINh1yLeK5Rvdqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546090; c=relaxed/simple;
	bh=s4q3+xQ++5Z8ZC4zsN61MEarWatMuJpmvRQkhMBHbGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=POgotAk9PjGdVOhKIcFvbMJ04MgkY6P/RaJMD/BXK0ih3Yf0N0RvJ854PvLQIspZ6m762F2mVXuKWeTdCy1c8uXdN3wV/vCzBFZsSt4TOZLsms51fOeyu1HxRq6eSTOkMvzPS0WJ3KB//zR69pAf21gnvvs0ouCXyIlcVWE3w6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHRL7Xj5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4c482844so164237f8f.0;
        Thu, 10 Oct 2024 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728546085; x=1729150885; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=11GHd1LUSR9eU61AB8lC+QuNmnA8MSrb3JZ4YJSSgWc=;
        b=nHRL7Xj5I2hLA/6O77qYl28xNL46Dvssr1LyOnFw1+yQFq7hfJby84NDTC1GyOnMHD
         UvOG3katBFK9Dk73dpVHhKtYCynSgTyIVT9fKlyz4A/KwI3YWIJ2xpYQedRhfnkOsQU1
         4UFwIcD+U/oosttIDQqh1W8llSjZ/QRGkjm66KnezQDa7nDW4fDP/EIk9rPDOhctiQMk
         fPq9DW606Gjbcb3Rljxe55vf2n6f4rVXHeuIz5YStzl5XcfmO9N9yKLnWxG3AFmb6uxB
         A4nzfWArtmoEdeQJJxaUlhRCNaOHW9welPKcouJOeS3kwdOw7LY6QP+aXG6j+rvOFuKh
         M7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728546085; x=1729150885;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11GHd1LUSR9eU61AB8lC+QuNmnA8MSrb3JZ4YJSSgWc=;
        b=WSxWMYzf+zVt06XG6acp8UtiPzW0sVJftUbuEk5/0mL7Asqn0W3ZlkC5XS/qJozI+5
         itnVSlEBcCnu+kWVsg1hYm9++hHEHO7nqcBr5jaI9ahgs6/X4qHVkw42MP0NR67N60fr
         /ZWWGl0xPjnlcwDTeslz4lTtYH7PgJU9R1hEg9z+P9YsiKHqvuOKT+zyg33Bmbwwrz1o
         3hCX6volhL2QK4T2RKY7ZvKk05yYR0PEZDuSkputs6mNZkubPvTUt3JjJ7BYItr7lw2G
         mwzhO/yooMXe7qGVf+2xVxt3RoMmA1nC6VmT4s9ZFjYy9iD+3tm8mwJi4Co426OvP3yV
         yKZw==
X-Forwarded-Encrypted: i=1; AJvYcCUUzV7/wOydcIGGG+6jzzIpRtQYDSQ4yEGLDBN+zGPns6V+TH7M+F5DU0euD76+SIyz2ius5V8Cjoo=@vger.kernel.org, AJvYcCXRAgpBT7lDXC1UQ0KAca2MPof8xFe30sk7hR5mz+A/N2zqECKfnVkrBUrwgQA1UEkoR5jpQjHY1sBePXi4@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnJ7J22jSUYHtYYTrzmYtBbjPlffc31Wv6p0AVs7jlsePxcNS
	nrLXEOLiVHVwIJc9Cvi+OJcWRiobqWDUbaVY8p1PVxoulJOCTP/q
X-Google-Smtp-Source: AGHT+IGL0nmo7auQ8d3+U7ew9NZlOqBcrxYDlQEr0DSn6igeu1fcpra364m4eZsMAbClUqQ6WBGoFg==
X-Received: by 2002:adf:eacd:0:b0:37d:4fb1:4faa with SMTP id ffacd0b85a97d-37d4fb15046mr269672f8f.50.1728546085031;
        Thu, 10 Oct 2024 00:41:25 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:2c2b:bcc5:835e:c2dd? (p200300f6ef1521002c2bbcc5835ec2dd.dip0.t-ipconnect.de. [2003:f6:ef15:2100:2c2b:bcc5:835e:c2dd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b2780c1sm762642f8f.0.2024.10.10.00.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:41:24 -0700 (PDT)
Message-ID: <8dffe9e084ae96a344d679f5c85113521fed3735.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad4695: Add missing Kconfig select
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 10 Oct 2024 09:45:40 +0200
In-Reply-To: <20241009-iio-adc-ad4695-fix-kconfig-v1-1-e2a4dfde8d55@baylibre.com>
References: 
	<20241009-iio-adc-ad4695-fix-kconfig-v1-1-e2a4dfde8d55@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 16:23 -0500, David Lechner wrote:
> Add select IIO_BUFFER and select IIO_TRIGGERED_BUFFER to the Kconfig for
> the ad4695 driver.
>=20
> Fixes: 6cc7e4bf2e08 ("iio: adc: ad4695: implement triggered buffer")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> I didn't see this one in the recent series with similar changes [1][2],
> so here is another one.
>=20
> [1]:
> https://lore.kernel.org/linux-iio/20241003-ad2s1210-select-v1-0-4019453f8=
c33@gmail.com/
> [2]:
> https://lore.kernel.org/linux-iio/20241003-iio-select-v1-0-67c0385197cd@g=
mail.com/
> ---
> =C2=A0drivers/iio/adc/Kconfig | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 85b82a708c36..98d441d6cc5c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -52,6 +52,8 @@ config AD4695
> =C2=A0	tristate "Analog Device AD4695 ADC Driver"
> =C2=A0	depends on SPI
> =C2=A0	select REGMAP_SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> =C2=A0	help
> =C2=A0	=C2=A0 Say yes here to build support for Analog Devices AD4695 and=
 similar
> =C2=A0	=C2=A0 analog to digital converters (ADC).
>=20
> ---
> base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
> change-id: 20241009-iio-adc-ad4695-fix-kconfig-279c9ef8d9ef
>=20
> Best regards,


