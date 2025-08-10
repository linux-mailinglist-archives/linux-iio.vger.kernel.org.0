Return-Path: <linux-iio+bounces-22509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF867B1F953
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 10:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0DC7A4201
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08560230BC5;
	Sun, 10 Aug 2025 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="t3fqqPUu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D4814885D;
	Sun, 10 Aug 2025 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754813354; cv=none; b=kGnObdNd+dBRkA5xUEfClGk4S3Jfl7VAAebXr98AHMNbc28+YGe8eoBXBrq3dvc1g5MbgNmOrNuQLdIj5HX8sRckimhTmlV181W1voQgO9ab9GBelTFIaP7UTcSA92RrVtJIBCj6dGNGAmELCRDfTdqhwjE2XwCGywpFjZtABKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754813354; c=relaxed/simple;
	bh=Z4MkdGaD5yMVPCNaHWZ77bCzeRvGMa/DJf7l5HVwimc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CXunuT27LIuUmiYZ9ln4BKLS4yG7nzmYv06qdkSae8BYWa0zxjbQyxjW0PDFbGm/EB54+s7xBhiaOaz4VTppJKdR8TpfQ7hJ+vcvH+bxEo2yw1PtqQiZqkW3z2+T/WDlsKlE9hbX5kIPImayo5D2ey/P3fZem3zHO/BB/2qJ3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=t3fqqPUu; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754813345; x=1755418145; i=markus.elfring@web.de;
	bh=Z4MkdGaD5yMVPCNaHWZ77bCzeRvGMa/DJf7l5HVwimc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t3fqqPUuLhL4lWZsUFryimW0Q/ffpNkk/sHZloFLA3StWeatVsxD2Ay3ejpxL6fb
	 zJfEB0rW9hnXrqtyrvyjjWSg/w5jtu4phzGurKUa3J7kGeT+tZuu2G4fgUqIys7fi
	 tB6r0ezXG8MDLXZ70hsiMGqeLXtVsHRv6blZspyM60rmIUdvvS4cFth7E4tcwEEuA
	 4WxUDVw1Fkf7zpf/6+ovsGNv3e28kLB2bTomwLOfLOQB0eaHsUOY6Xk6j3+dtAWrr
	 Gg5ufV7BywYk35Ig0oOQHO+toYLElwctRlmuXwCzF+TBMocmekBZIdUR9Yln8yllg
	 8KzonRYCuHGSDyeXIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.214]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mrfp8-1uHTeP3Fu0-00la50; Sun, 10
 Aug 2025 10:09:05 +0200
Message-ID: <f34219ae-098f-4732-94e9-f077316d843d@web.de>
Date: Sun, 10 Aug 2025 10:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Salah Triki <salah.triki@gmail.com>, linux-iio@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
References: <aJQOmQKO219rS8ZN@pc>
Subject: Re: [PATCH v2] iio: pressure: bmp280: Use IS_ERR() in
 bmp280_common_probe()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <aJQOmQKO219rS8ZN@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AvhrCOMTUFsJvDkZwccEZtipCctmDl25pmwBYLrcGEL37WkwTdP
 glGgxe06IKKG0oEdcIoyifhS09yU+GSUX+LEsfjTna6YFvgAaV3n0TCjhyIocni/cqhkVZP
 xGSqEqX0cF4M8zqH6/Rd0u44dUHgYbGDMUJ6TGOPgThq2FrWxOqZYUhQE8u52sRjBUnc+er
 NJWrLrsTqXvwTmzmyknOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KB2oqePxtVo=;brdJLwhkwmQ7H0WmT0/Pjqfx7vH
 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

> `devm_gpiod_get_optional()` may return non-NULL error pointer on failure=
.
> Check its return value using `IS_ERR()` and propagate the error if
> necessary.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n145


> Also switch to `gpiod_set_value_cansleep()`, which is safe to use in
> sleepable contexts like probe.

Would it be helpful to provide desirable changes by separate update steps?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n81

Regards,
Markus

