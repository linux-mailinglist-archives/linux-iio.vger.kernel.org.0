Return-Path: <linux-iio+bounces-25536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD033C113E7
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 20:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5E425609DE
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853D32862C;
	Mon, 27 Oct 2025 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4wgkenP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD03277B4
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593439; cv=none; b=LFndHDOufujBHigQDs1t62JzArzwPjWb7F8PbiFo8h3aMpTrgZGktviA/HQKCdrf2HvkaRP/daF9XmdhqihoDLiBMBZVvjv+HThMmjV3WiqvOFxA8EiJ+dzC70AAE8TcjwMO9xS0Q5O419vDo9ex/s0AKdJcnPk/4HOUpU67Hmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593439; c=relaxed/simple;
	bh=Nw/EC4BDxEdLzlg8/9tOSmc+lQtWTOG1wUVvZBCUOO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qlv7o49hA85mtVGqbwe+owiBPqPcMqIwJP+GetImvlO6YuQvq4ZDef6rwr55D2mpDv6gUI64qAYxz4ldrLYHE6vDw3sxUqBBizbg9DFtLdhD3oyA84NiK1QVcCy/iFr5KZ3m3lS25MCvbFy6fLOay8xjhqchiwZxXBchlVRxqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4wgkenP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso3985048f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 12:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761593436; x=1762198236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfEgFrMFSQT2jieK7pepMP8G7R1y/5//r9L5wGXCKUI=;
        b=G4wgkenP75PGAi8cLTJP3agdhbsxhk0wYjAT7KAV8TjgUr1b/TEg0bXlM5xWvLbm5l
         rDO6Bqe1W0PvuOIO8+313PmUZoVoghSYubLpX5ZPhFQk7YTbIhmoWnSBsgC0+p1lM96R
         Slhw8kvcUA4Vtxm9jRd1YE2cKXSULwmPg9dCqyjQGFMrudxFqmlkk/sOrey7J3xLo15u
         v+Hbza8EYWdiLGIkEpS7xs/yTqkzXsCFj41+3bTbzGYfXH1o5zegsC9j0YnK7rlfGLmz
         MOpsm28h+L0iJHfkCiwGlJv0T1JRauOkMl8QXD8smPTE2F1FJgWe3dWxjKZPqemd53dT
         i+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761593436; x=1762198236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfEgFrMFSQT2jieK7pepMP8G7R1y/5//r9L5wGXCKUI=;
        b=cTpW5ETPYPWqmrdwsoOuQnl/8hY+I+mh1MwU/GH6heNo8C07Yk3cOLGZAI4zeu+uGB
         jnGCFhtQhZ5VGxvukNy8Z19JtWPV4s+D4CXjyVUnT3vx+o2AyyAuFAD9uZ7O0wN0h0KW
         zeF3Hk7AMX95rLrNk/pKKb50mUSaNi+c3+YD43TubqRmAN0y/tAkP3v+xkk9a0T3OTte
         ahdfVDbDDaZgF4MNvsY0N+zKlCC645a+EkOunJOCQwn1vPMX+S+ieyd0BzG2F8Hkbxx7
         ZZsR2Agnwp3prTVchayQl9AoC0HEzysBPId4Duq2UqcHppgI+TXIRKye7PtcmyO8hpqM
         erLg==
X-Gm-Message-State: AOJu0YyZpL7F34LyIGzoAakliFbXEAvxJiGeHugvtkyPrqoloUp70172
	3DJpT3zxAVZob0WqXREQdBGKsq6BZyMemV4pQa7d3cXxg+R0zohI3sWh
X-Gm-Gg: ASbGncsS6A7P0M36H9nZZvHo39Cro8q+df4upmukaI/m+J1MhHKV9USuTh3fy6QTqO0
	fCnEO1lqiicS3HDCfdAHIqp9INi9V1QneXeFCeiugdE6xTVY6uBldvmJ1kSZeamQKyXpD8VhsAL
	xkSdCpZ914noeUkA//Abh0DQkPKJr64rxYpwbb9bANYC0WHGoMObak6pDMGEbXa2kMIKJU8tJ3F
	eGI2ET1yB+447I5B+0oC9HNgpXQmAl6/l+NdiS0rbUGSevBkf+45PC7AHjgUErX9ajsC7Yd5BLt
	wxmkYuNDzGrp+CJbepIEd8A9VR2k7b/xLSWDkE9CoceMWzertJ9jw2tzlcznQsCwNuTQm7wlJLt
	g8/4oJ47PiQSatoqyzA7xaQgmJ1pdlGllfxM+BNjHUXL0hRAQKRet9e9sZFUHxqX74hFtkuhgOI
	eDrO1uKJmifegXijbRaJPRbs4qVK7SPGKWjpm53OaE5IKb6nRfv2oh
X-Google-Smtp-Source: AGHT+IGtEr+9CIcpzVVArHnTXR3tT6CiV2LiHYXcwwmfckLKMvIkaTwS1E1UtslWxI222jO5QieSoQ==
X-Received: by 2002:a5d:5f54:0:b0:425:70cb:9ba8 with SMTP id ffacd0b85a97d-429a81b1f42mr540100f8f.1.1761593435800;
        Mon, 27 Oct 2025 12:30:35 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e3201sm15950022f8f.47.2025.10.27.12.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:30:35 -0700 (PDT)
Date: Mon, 27 Oct 2025 19:30:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: Re: [PATCH v1 2/6] units: Add value of =?UTF-8?B?z4A=?= *
 =?UTF-8?B?MTDigbk=?=
Message-ID: <20251027193033.69728215@pumpkin>
In-Reply-To: <20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
	<20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2025 15:34:51 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> There are a few drivers that want to have this value, and at least one
> known to come soon. Let's define a value for them.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/units.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/linux/units.h b/include/linux/units.h
> index f626e212d4ca..82bdc2041328 100644
> --- a/include/linux/units.h
> +++ b/include/linux/units.h
> @@ -21,6 +21,9 @@
>  #define PICO	1000000000000ULL
>  #define FEMTO	1000000000000000ULL
> =20
> +/* Value of =CF=80 * 10=E2=81=B9 */
> +#define PI	3141592653LL

Is that the right value?
IIRC the next digits are 58979 (I used to know the next few as well)
which means it should be rounded up.

	David

> +
>  /* Hz based multipliers */
>  #define NANOHZ_PER_HZ		1000000000UL
>  #define MICROHZ_PER_HZ		1000000UL


