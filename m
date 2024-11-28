Return-Path: <linux-iio+bounces-12764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2589DB413
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 09:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3B11619D1
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 08:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4337814EC5B;
	Thu, 28 Nov 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS2ncB3z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3A7404E;
	Thu, 28 Nov 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783619; cv=none; b=KOGcIUyyGWIVPh+/GwO64wBfNMEtqYDKXialaCVhhPVbXU+Ry0P+H3rBM4VNlxrGCKuGKjUCEt6KhEvYBQzsPIEiChJpeH9KQJLw6DIXEV/MjRjn7BEVrt3q1eB/XrOpxCnrxd0d+DEJbjraOn4kwG0sLpk4yXQQK0mBBwpQgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783619; c=relaxed/simple;
	bh=frma48AJ0SUvSuy5UhykiEVuMb1wSYmkcDffGWoFnUM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aoZJGhVYLygWJkYdLhfkXiZuVaGylB1EJpfWbAsn2DZGAPRjBKLZLXrSgQm6rOmKzORTwzASvwDV+CiWHxtarirM2uZHcUrFyVeFwWWkJ6H0sZ+NICQThTR3xLBLUwns+3Ii2ZV4jg8HOfPN9J0EHWgmdOzcGGvPieXnIl/8zqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WS2ncB3z; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53da6801c6dso449254e87.0;
        Thu, 28 Nov 2024 00:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732783615; x=1733388415; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azerENWgxXyHbhyynQt03n9Ftd/1tM45tjkSffbSXWU=;
        b=WS2ncB3zKS22zk9NPs0KPbJkoUxZhzBXuw/ipSJhcJlNgDYiPWiLoo+s4j1UI5TeeB
         PaUPlHX9+pQbXdLYRHbD2mQOfY8xrRJew5leTBV5+5GznXRYIv8UtzEcjNJO6/TKmNvt
         51MajD/2EYv1BWcKUMTRKiwh1IU9LIg5tSKAD+PZKEbZP1LloTd7ofLsxDOCRWnivHvV
         sQkuLTLyDKKv2mUVy3vL0XXfJzFRUWoUrxXbNF37+tpMfmIZRnxVBx0rOVDmMklt6OQ9
         WPr7YGyFSMeNaKIog3jp1LreB3aOps8WJrrBrTDzPB4Avt0r57G8CpENXGtkjXZ71lzx
         rrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783615; x=1733388415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azerENWgxXyHbhyynQt03n9Ftd/1tM45tjkSffbSXWU=;
        b=EgavNYGr5a0GxfZMXDtI+tnNK7w/oHdbEFCheRpbn4v63ZJhxdRECTCllljK1ReuIr
         1OQgg2maI1+7KCkaV0Q+KC4EUZNrlulDzqARpUyaotxDllP8Pfi3bzOn026gE+U1D+h8
         nrv5kD6se6ysUUbQKl8DkFbKFTpRh4zGy1UYt5OZG6XP+TF6HLjKcPjfSZUnh0o7odKj
         kwca9P4QE9qHHaXRwNJKC5jFQSoldVv+GRtFYlFKUiz5v4+JXv5gF+g3eggkikeIcGFE
         mpIkuWgferJ0GV9UEs7PQI7WOYs3cfu5hx1GqjYH9QmAB1LjU+KLS4ncBN/ROKjPz8u3
         yxZw==
X-Forwarded-Encrypted: i=1; AJvYcCX7BQEAV0/jSvTqX4LLExnNqZQVjB96yM+RTjEneiyCNkCs9adKngiJoaPdwCDzNLuym6qwKWtnnBoRyK5t@vger.kernel.org, AJvYcCXeP0YoINdDNbN76ZlyfT2R8UXPdNcI22aRNvpcdmXm0aLTL4m+irP6lAorxtnBpVJUtV8U/dwzSjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+/xSCev3CjZxOIQvlagEDgCquKChTGuVeSqQPly1feXSsK77
	Ka3kTgB/kEq0vS7ZNS0WTqcbFLmCtysJiIAV7+T6/CG1bQTJdOT7
X-Gm-Gg: ASbGncsysYfutDvtEkgZhmcDkzJirh/RWApDEkfUTmAOBLAfW+xiFso6EIrkLR8TU0a
	/mxLGZzIO+IzSy2xf/lAoydoZ0MpKOF0qs4TsJph/PhOMF5oRZPaAYlA69pTT5f04AA9Xf3BK4T
	//l2bQQrw+xQqcUmXgJoxwgnFXZg95u3MNk7HPhDMcw3GmRiCA3tPKotNITIT6BIPHCVqgwuR0K
	S4Wa6M0KJQ2ZT/pAbppCyRT7D4ltY67PYCoIxhbkc0aQ7DXCGAi
X-Google-Smtp-Source: AGHT+IGly3n2VGAAg92jcqRfWaeHa+991E2ZJC4divBuKY94dlI3idhatNRwSohA/ctMs3DGRntw7A==
X-Received: by 2002:a05:6512:1115:b0:53d:ecce:361f with SMTP id 2adb3069b0e04-53df00d9e74mr3715791e87.30.1732783615140;
        Thu, 28 Nov 2024 00:46:55 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443235sm112125e87.81.2024.11.28.00.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 00:46:52 -0800 (PST)
Date: Thu, 28 Nov 2024 10:46:29 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: test: Fix GTS test config
Message-ID: <Z0gt5R86WdeK73u2@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PfNbdR7eKkIJPpt3"
Content-Disposition: inline


--PfNbdR7eKkIJPpt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The test config contained a copy-paste error. The IIO GTS helper test
was errorneously titled as "Test IIO formatting functions" in the
menuconfig.

Change the title of the tests to reflect what is tested.

Fixes: cf996f039679 ("iio: test: test gain-time-scale helpers")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/test/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 33cca49c8058..7a181cac3cc9 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -5,7 +5,7 @@
=20
 # Keep in alphabetical order
 config IIO_GTS_KUNIT_TEST
-	tristate "Test IIO formatting functions" if !KUNIT_ALL_TESTS
+	tristate "Test IIO gain-time-scale helpers" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	select IIO_GTS_HELPER
 	select TEST_KUNIT_DEVICE_HELPERS

base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
--=20
2.47.0


--PfNbdR7eKkIJPpt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdILeEACgkQeFA3/03a
ocXwugf8CPPTOxi5p3X1hzyy3yUF3B+qyYEXH1RPkkakZvTb+zmdioElfSfxbq7k
hcHIAW//5d9O71P5xEFXH8nj0MbdXPEnO+o0mZpMb3qfUrzTJ59sMAhQFF+k5LdA
x/V8ertSb9XbXX4ymO5dZ9ezpijCwC2mGxHAsX+rQEXBO3aNUz0bvtgDC5oLvoP5
0N4Rxa016RcUDOT4MBqNGyNC0tzsuUfbAAV6zuTLmykyd9ZkPbJAvvfrO1TnUvit
hK/5zsf47cOa8HRjwuRITgtntnjFbs+XtGNwaVxRjBiFQIn+3G1FQ1McsjJf4oTL
d6ZWaddsOs/0OJN6eXIK7RUG4CaaYw==
=IUNn
-----END PGP SIGNATURE-----

--PfNbdR7eKkIJPpt3--

