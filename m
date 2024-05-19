Return-Path: <linux-iio+bounces-5109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F48C94FB
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375711F21950
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43494AEFA;
	Sun, 19 May 2024 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVf7AfrN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4B4596E;
	Sun, 19 May 2024 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716128570; cv=none; b=G+7A0Uu0VjBeDiyE/re4VSW+y2GygyMJYyPxbK5E8U7nB1t+UY5bui5bkz6x4wF+8D7qU0IWT91xuQMeWEWTW02FvT7Cbh7bTacP/4+5RKUJ5fjE6pvYbjtGBANlJidAuullpDWsCW32izKJwxROAfrwFHrKHo6YLUaLrWoaOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716128570; c=relaxed/simple;
	bh=HdRqtefJzU/1IVN9Z74ykRZLCT25VVz0Y8vi96reINI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcaZbNxfWWop9lGeifjXsKF4OAN70J9vasb7ZquXqPxO4RdM6Xk/82/C84Ecnn2+EOr0ZJIIdF4tgcr0NTLqP5Oa0If8QA2n1PCBYHscHJTL6pB7ZRLzRw24F6GNaBYL8lmtCLYy61nEsPd6PJYFCznaPBulLieeY5pRhmBkxB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVf7AfrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E748BC32781;
	Sun, 19 May 2024 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716128570;
	bh=HdRqtefJzU/1IVN9Z74ykRZLCT25VVz0Y8vi96reINI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RVf7AfrN63c+ptmV918ypaSyiyXchSaL6UbnE4k33z8f+Msfpc6r2NYXuJH/et5kE
	 lnsrI6d27/iYDGqIWUJKDFlWjn5bZ2sLTibUn1MdrEd2bIK5z4w9DS3/2lG2Ae/BFu
	 E3lWKZVW8ob6mMB2nhqF1P+Hu/coOjPyW4XTk05DHOnibpJB2yWfyyjNKmlFX9DoBq
	 AGRqDFFtKtGfkMGKgNjHOaoxsskQO5pSPXbPKdWY7g52rQHgyhHN1fx7JyIBx1T4zx
	 Ge7w/7eK5+kMPfGYSwZA7IZ3yTxkA9uKHqC+CHtj+8E9lXlHwfkoeDHMv0HwXGv4Gg
	 ciNkSDgbefDPA==
Date: Sun, 19 May 2024 15:22:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 1/5] iio: pressure: bmp280: Refactorize reading
 functions
Message-ID: <20240519152130.32ec84b9@jic23-huawei>
In-Reply-To: <20240512230524.53990-2-vassilisamir@gmail.com>
References: <20240512230524.53990-1-vassilisamir@gmail.com>
	<20240512230524.53990-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 May 2024 01:05:20 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> For BMP18x, BMP28x, BME280, BMP38x the reading of the pressure
> value requires an update of the t_fine variable which happens
> through reading the temperature value.
>=20
> So all the bmpxxx_read_press() functions of the above sensors
> are internally calling the equivalent bmpxxx_read_temp() function
> in order to update the t_fine value. By just looking at the code
> this functionality is a bit hidden and is not easy to understand
> why those channels are not independent.
>=20
> This commit tries to clear these things a bit by splitting the
> bmpxxx_{read/compensate}_{temp/press/humid}() to the following:
>=20
> i. bmpxxx_read_{temp/press/humid}_adc(): read the raw value from
> the sensor.
>=20
> ii. bmpxx_calc_t_fine(): calculate the t_fine variable.
>=20
> iii. bmpxxx_get_t_fine(): get the t_fine variable.
>=20
> iv. bmpxxx_compensate_{temp/press/humid}(): compensate the adc
> values and return the calculated value.
>=20
> v. bmpxxx_read_{temp/press/humid}(): combine calls of the
> aforementioned functions to return the requested value.
>=20
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied with a fix...
drivers/iio/pressure/bmp280-core.c: In function =E2=80=98bmp180_read_press=
=E2=80=99:
drivers/iio/pressure/bmp280-core.c:2091:9: error: =E2=80=98ret=E2=80=99 und=
eclared (first use in this function); did you mean =E2=80=98net=E2=80=99?
 2091 |         ret =3D bmp180_get_t_fine(data, &t_fine);
      |         ^~~
      |         net

I guess something got lost in rebasing. Anyhow, fix obvious so not
problem.

Thanks,

Jonathan

