Return-Path: <linux-iio+bounces-12195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 150F59C6DAD
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA81E1F216FE
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1C5200120;
	Wed, 13 Nov 2024 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMNItNY3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A21FE0EE;
	Wed, 13 Nov 2024 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496761; cv=none; b=hHbHe+CjqmpfFF0iArwFVDOyVnxhgYSGoXUEzHmWFgNf8V+HJZJ5fwiHOVemHU20Rmp5REjOU8kE2k0oF81ey0ZwJBqw0wdqKAmIPs6sQlTFZhpj5B49XjggSvSCsB4jeN+Fmqjl50+4QIHArsS+qnwWR+JJy4WwLRbMRi1Dwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496761; c=relaxed/simple;
	bh=LOOdznM3i9n4mU5ZxHHk01LduIN8ONdsfuLxCt5eH/s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PsgeqpCjSnKRL70hfBqQJPPhiZlY24sKCbuJ4eOLXVItL/eZS0cO6zjW9iV9jopuayTUFkPU9t+Z1fFbEdDaHtkrj2c4pCQTklsYy/xuocKHPiDn/3f2pWMl9EAS1N1jid7CIENKqIxkfbtUSr63d2zvWWjI40lwr28Z9Iz6NxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMNItNY3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so859464e87.1;
        Wed, 13 Nov 2024 03:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731496758; x=1732101558; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y75cuAIzTvPtv6bVX5R8z/XHAJCzmpIRRV9QXGCVME0=;
        b=GMNItNY3oL8l4+x+jUD786LIit4K5t/SVMaJlBxI24ogbnfWJoIbg98j5Eg2rHZvrI
         Dt7K523HwtHsPzq2zk/CTtvO6bUqeNT3L4oKstGR9EERW4K5GdWpSgdtYBnBjd5IRkdC
         A80D51oBEhzQx0Tkq7jI/qageqB7GPTJjLTbaqX/cLyVBPUYcbt72wEYAhsKeGYh7nZb
         P7qUNwGf0RArFvlTEAo1LMHY9HH+nCRlZMJ70WsMLzP3WUvahjkQXOdeYgo7i1yz8kyx
         Ik3f7xS8pAA0kIoq2M9AqczOSvNp+vzKlMkOqeietvLehxg+r6d8OqkPloGPjOFelGeu
         E42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496758; x=1732101558;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y75cuAIzTvPtv6bVX5R8z/XHAJCzmpIRRV9QXGCVME0=;
        b=iS4Do0iYgSbqnYu1M5xI/rZQzZhJhl/8ZUWfIpObTjjh7hfG/sfQVWq07s+lJHSk/N
         BDAthr7dMZA0wZb1RBoTl56EzXaRbL6drLN0Uf/DuS6ryn4Lxq8JlAqzmNU/Usft+Pgi
         NbSSTchNj88ZPeUFl5xd29dwERoxmxFnyjQWSS7pcgNzICuFV8SaCdyqrAkJBFUZyBtJ
         F858l2FwF0JXSulFz5msyD1Aw71Lg478DLpOywyy9t12OJLvasFwtlZDlUNAlHlDDcdk
         Md/utQFO4VYrGA+ls5OeA8OSq1/j099snpLSjm1l7mUq+ATajLzBJlB3iFvBKV6nuAFx
         lq/w==
X-Forwarded-Encrypted: i=1; AJvYcCUA8WPLTqgIzdUk2dqz7FaYBo6hft9+CEzndbDh1PYn7B3aYA0HFpwM2hKjZ/KlNxh28k3+vbj7+5ie@vger.kernel.org, AJvYcCWaHEphX0QvCUKtLxIYQKzSOq1r+ETyDafErqGuuhD3q2QSV0TFOOnZGZYMPYPdM0w4QgfQ2vcQRua+@vger.kernel.org, AJvYcCXEPtEv+qlkuzmW/9F/xIrjfDqzafJihVuQuT8kIjspHAA0wNkyR1ncN7e7O51ol4qMWZUkecxIL+szv6Ga@vger.kernel.org
X-Gm-Message-State: AOJu0Yzay7iTU1fPJJyWMzvr7vvqkdwwZ6oUmpE5gPOYFWpTzFHBW8k0
	Tj8oLGcrP86tUKXaTRK0K5gWZ36GN/FhsvVYf76OKGqm4Op8SxQ748hKesJl
X-Google-Smtp-Source: AGHT+IHglMc5PXeg6tLCKle8mOHpTrlZYM6HMGUCQOslMx4CGkfEaUUFZfJQNKio40dcCWgADBr9sA==
X-Received: by 2002:a05:6512:2f3:b0:53d:a00d:e7b8 with SMTP id 2adb3069b0e04-53da00de823mr847450e87.48.1731496757295;
        Wed, 13 Nov 2024 03:19:17 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a776dsm2160866e87.118.2024.11.13.03.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:19:16 -0800 (PST)
Date: Wed, 13 Nov 2024 13:19:05 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Support ROHM KX134ACR-LBZ
Message-ID: <cover.1731495937.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IXXXxsnhyWpYRy2K"
Content-Disposition: inline


--IXXXxsnhyWpYRy2K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch series introducing support for ROHM KX134ACR-LBZ accelerometer

This series adds support for ROHM KX124ACR-LBZ. The KX134ACR-LBZ is almost
identical to the KX132ACR-LBZ. The differencies visible to the driver are
different g-ranges and the "Who am I" -identification register's value.

This series does also convert parts of the GTS helpers and the kx022a
driver to use __cleanup - based scoped free/unlock operations.

The patch 1/5 contains GTS helper change, which  is independent from the
rest of the series. It can be applied/rejected independently.

Patch 2/5 changes kx022a to use scoped mutexes. It can also be applied
as an independent improvement even if the kx134acr-lbz support was not
added.

Patches 3-5/5 are all related to supporting kx134acr-lbz. 3/5 adding
mechanisms for supporting sensors with different g-ranges, 4/5 being the
binding doc and 5/5 bringing the actual support in the driver.

---

Matti Vaittinen (5):
  iio: gts: Simplify using __free
  iio: accel: kx022a: Use cleanup.h helpers
  iio: accel: kx022a: Support ICs with different G-ranges
  dt-bindings: ROHM KX134ACR-LBZ
  iio: kx022a: Support ROHM KX134ACR-LBZ

 .../bindings/iio/accel/kionix,kx022a.yaml     |   4 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |   2 +
 drivers/iio/accel/kionix-kx022a-spi.c         |   2 +
 drivers/iio/accel/kionix-kx022a.c             | 129 +++++++++++-------
 drivers/iio/accel/kionix-kx022a.h             |   4 +
 drivers/iio/industrialio-gts-helper.c         |  17 +--
 6 files changed, 98 insertions(+), 60 deletions(-)


base-commit: 20fd1383cd616d61b2a79967da1221dc6cfb8430
--=20
2.47.0


--IXXXxsnhyWpYRy2K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc0iyMACgkQeFA3/03a
ocXNzQf/X2dpSevDhZYjovGLYx2Skg/ui//xCmY2mf0EH7Q0a+52gq3TKLpTwKDC
KMteEb0Z4OgueStUqKFMIl95L1JxaabcFft16cgHy2NvGOc9dHR5V/PKKjt0sVPD
siP7itWDn4L7iOJg/b5kKBcNOA/vLr2/0IeJSDtUIuTYnP6xug8SjESQJkoUknQB
53v36iIE/FsgYBPzfCwCvLk63Z14TDWWfdVYwLzsupjS5Vu0hyVTQTQSusbk5Z1w
tBwVjvYpSJsLJs/Ug2gT/lbahkXfA5tYv4sBhA++DKst+4/HIvghu5TEWlc9Q+MP
qStXmwKi9NhUsBAW2OJFgT7yo3duXQ==
=K5mg
-----END PGP SIGNATURE-----

--IXXXxsnhyWpYRy2K--

