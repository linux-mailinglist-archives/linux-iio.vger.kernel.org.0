Return-Path: <linux-iio+bounces-25181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEDDBE7E50
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 11:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C43319C2CCB
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA5E2DAFB0;
	Fri, 17 Oct 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HUsSOCou"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303A27E1D5
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694769; cv=none; b=h5cHfKNMA3nNftk+d4JbMgbSu7TLLF+PZCdWhQZRjtwW7GhIf+v0yrq4asvSYqszARkt9unJp7pp2oHP/4acF8IBy3w/RuFSnHzn1IeXURCyzK/za/4GocDlYgwL0xbnXRc29aZXQHe7nj8FWH0iPiBXIGQrv/JmMWS0Qa0nYKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694769; c=relaxed/simple;
	bh=krtfbaJmrdnEIUPH92y+4wruHrJQ5/sEYpo+V6iCrH8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJEmQUuLPYdaLIzcSCQV5Ve3K5qzdkvr2ByAUKb2hB7S0ZiY4fvT8/OxsSWJItZJLEBfohVGinph8D1gA7ApfGZl28McbGBDs+AgHV5t2ZCvvwQSXYWhYXkVK6kPjkm4MEfsIa7Wu2XqEpOWz+7O7bXDg/yyAOOZPRdEwcVevsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HUsSOCou; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so3461776a12.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760694765; x=1761299565; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krtfbaJmrdnEIUPH92y+4wruHrJQ5/sEYpo+V6iCrH8=;
        b=HUsSOCouK5CEJwUOb8FzR6YPWH64PDiogdjXinD0WLmAHMM90Um/ZyVp89eri59uIM
         28Z/vT/SZiA8kulezgwOlZBhjsGkEONH7btpN25gHPeWxIFIrT2j9AnY6BlbBHg/ymns
         VYoX2yfMPStFvUi6VsZI3kBeI3++23Ky28FYoMjTkdBI8wsutQ8mWyQZtYW2YLycbl2A
         c+0KnLRxgDiYrvzw5YOKyfbUGcfb5IGwpGAbxgcDFzBPyF8XEXapZtIM3+9QWUI7KDAO
         SG0r3HxZ6SZ8kQg7SGeAniStddDzl7lwfaF1SIR9p1d4Uxc/e1zZ7WRQnS2ohhYgXyMQ
         vJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694765; x=1761299565;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=krtfbaJmrdnEIUPH92y+4wruHrJQ5/sEYpo+V6iCrH8=;
        b=NZhCA0ZOJ7uScUSYGG1PG6BtQtdVxYClrU5VxtkwH/XX6zMsgOEs2xLYsaRf8UBhmT
         bCPSLaR6FLgkZc1nuoHzSRLuKrrwX0mh5BQsGQ6z3tRTZZhLOhzEA9WYvZ86jkgkcjlc
         Ua2n3Ls43AKjtxx+BHrYDu5s6W7Tysp/go/ze7YAb19y0/10IMB5rJn2wE+VANxnsVsz
         mUEJAYeghNaIR8yj7KsEByJtdJBKhVJ9oDOkNnpXEZbEDPAY+jlsY32MMtcxtbIyAwe6
         I0CbhEbKjFuijbmDJUm+qsniLG21p5Lt0w/b+x81SMJUq1l3SVOqLZEa1N4ngu5hK0Yy
         6a4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/50TSWC2HGVJR6bbOVQkduH75aoJvqOpjox7MRyJAAgCjdHMkSfjQYA5Y5OY/xmBJRfOoqApAW1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+y0zrP5XeemAJVfYLXM7aT1O8dDTp0k5HTDw/o6U4CqRN7Lzf
	o+RGhkX8TIziZVr8a//aB/DkLE/EZ0jAya+PWg8dwLXxsiP5AaBUr5r4sS6NTPJHPMY=
X-Gm-Gg: ASbGncsMc9Zu5NYsWCBlx02GsOd0vQuBtPB050ZsWdxECDLp9yNZrWreFdtLwqo/CIb
	c84wTOZxv3mcGyaAwCiXrGssAC1ZNO1a0pSDjlwX1EVeG0OjatypFX5z30X5/JNNRujvgazldgs
	VPQCU/DvVVw65toGRdO5D8qnuTt1cViGt14S8IH88PXhIPhO/YLxXG0m8SkY7Gvdu+JDnfX1Qo5
	zr9u6ITo7IH0KsYiyfsGTihUoGgSatBbRLMTKijY/6kmSwAsfdHFnVoKneN4QgYTfxFW42uA1Dr
	3Bp6t2t0nYPEzeTwC8X+fiYSYSUfeaoPAMS3RHgwSzvWAi438fXiBdB0Kad5FFuVODhBiOjmOIw
	NmEUHQNwWc9a3Yz3+ZQ4Y/vmqzVT8RUv+4Tt53qfCwDXTESJH2hFQ+ruEUJHHpnT3YGWDeUcLGa
	qHmD6TiRcmIVwXLC7B+AsqWcFB3ljWVkFMIpZRvXQPWOAkzmsO4GsQ
X-Google-Smtp-Source: AGHT+IGWZep8ffF+F1GgQnRzfhXT0oTDdMxpNqX0rCxoli2ly79a6bIfyF/nMfUOmRjBANPF1e7aSg==
X-Received: by 2002:a05:6402:3485:b0:639:f548:686e with SMTP id 4fb4d7f45d1cf-63c1f580d94mr3023847a12.0.1760694765206;
        Fri, 17 Oct 2025 02:52:45 -0700 (PDT)
Received: from [10.203.83.121] (mob-176-247-25-234.net.vodafone.it. [176.247.25.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c25273f36sm1728474a12.25.2025.10.17.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:52:44 -0700 (PDT)
Message-ID: <2bfbf4f61119e3f4f52bf591a49a565314ae03e7.camel@baylibre.com>
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: Fix measurement unit for odr
 struct member
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 17 Oct 2025 11:52:37 +0200
In-Reply-To: <aPFR7r-aHtURsWtD@lore-desk>
References: <20251016172122.1220332-1-flavra@baylibre.com>
	 <20251016172122.1220332-2-flavra@baylibre.com> <aPFR7r-aHtURsWtD@lore-desk>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-+iXbUeoPTGzOPOYfkFqi"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-+iXbUeoPTGzOPOYfkFqi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-10-16 at 22:13 +0200, Lorenzo Bianconi wrote:
> > The `odr` field in struct st_lsm6dsx_sensor contains a data rate
> > value expressed in mHz, not in Hz.
> >=20
> > Fixes: 290a6ce11d938 ("iio: imu: add support to lsm6dsx driver")

I just learned that odr values used to be expressed in Hz in past versions
of the driver, so the right commit for the Fixes: tag is f8710f0357bc3
("iio: imu: st_lsm6dsx: express odr in mHZ"). Will correct this in v3.

> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
>=20
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>


--=-+iXbUeoPTGzOPOYfkFqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmjyEeUACgkQ7fE7c86U
Nl8V+Av/ZXdMSbKRnicFYABf1qs538aQeaxDMJqplKf0znbJk8e/kGEpVHGEUoal
jHPORWlP9xA1t2VkYqvI1O1XYYjNR6EjLlHX69eytqSvl1mKD1ZbGmQPcs4ZoO3y
S1xG2weO4AdheIbjV2kDYKzHA6oBYHJZhoM8WqFIASLA1q99nd8eAbqtCFAv/mQA
A5uZCzNVrm6JIB/8pJG73URHMoLCkQzcPNcow2Ijo2GfvgAS1UBIk8Q61E54EbO7
jMTRH9kZn7x26Ddr2CgupoARic6YPt+qp8G00RG5XPR6Vf4kAG1Gel5fzr2YZtJw
Al3ceuFX2XMIisBWm59LaQPuelwgLTnqcmYfCwZgL+CDAy65lqgQ8j83koo4aAhG
rTKoQREYyrnZE62PDguK9KE7iXlv2WeygRXCDiN4HvWO1YxJ4a8qFOQFhrB0bEeu
w851JSiEqBNu2SMNN8iJKt7HwZDMrdy1mHek+lp6KbL/fFZRk/2CnfT+DO9K0Qad
rfmIqduW
=PYbM
-----END PGP SIGNATURE-----

--=-+iXbUeoPTGzOPOYfkFqi--

