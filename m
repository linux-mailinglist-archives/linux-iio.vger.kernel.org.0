Return-Path: <linux-iio+bounces-16188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D897FA49A4E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 14:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C612D188C93F
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 13:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD74126D5BE;
	Fri, 28 Feb 2025 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP2cgZ2B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788D26B96F;
	Fri, 28 Feb 2025 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748456; cv=none; b=KEKKlZm0JuhDkycv9GGKcwQzBJnC8pWpehCx/y0Lrzz6V1L+0txQwyHCkW51ucuW9p2fWXB3AngraW/lNu5dS+VuRL4d+4Eq/9pzPoBhVUPvfZocDjL+vxlil7uDzjoxlRPE+hTfF32B5Gns/EStpDhIiMdGt0Nw2izf/iJ6sOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748456; c=relaxed/simple;
	bh=Yex8Ti2Ma8lpdVN84qoVtEAT9MMOpm/ggXTwi83IM3k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i6g9iPkPVsU7V0g8heqhdH+ZHTOuSxYhPtcMIyfmjk03RQ44bzCQUrQ4KT++z/PLSEgFiphl5vcnCt46vMu+u+NFCCc/tapzTth03RZ6Gwsve9+iMpUmzImdbd+HR9Fko8pTs4cxtpuo4kSfsWs5LpxqbloJl8FRIwHFZ5/7e24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP2cgZ2B; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso22488311fa.1;
        Fri, 28 Feb 2025 05:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740748453; x=1741353253; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVd/sNt48RsOOazla0J8Qt4X2Bx3rQZOQ1zMd7wjIQ4=;
        b=SP2cgZ2Bj4WHHIa9ZfxhVmg7FSFBPvv9w/yBGAKlwIRKbSBGZfLks/dbkkPgpQus+k
         K2XJGU7YNwkPkkzp6Pa7FS3QbwR0iiMMIE/vTZZ7ix5HlRaqzMF8Rv7WJGL/YjyfPA0D
         lk0RB6fPrpzBWwf3Htw/CzQIJImRFgWoZrUNKw4T+fc3G1jx+9KFNXE2yz8ueRAZiw8g
         uynXEyVPUh76AgH+SxFdFu92RAhrvEwKkIgLZ4X2vy1+QyDm0MkjoS6VCd+CzItyntKY
         XALl6Hjolb9OXi7a6IclbGip31RdJwt3nbpwwvb+FIsroF81J5MEinFiXZ6x0tlLg6Px
         lkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748453; x=1741353253;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVd/sNt48RsOOazla0J8Qt4X2Bx3rQZOQ1zMd7wjIQ4=;
        b=LMN/Yu9Aj1IDVebzFzQGnan8c+QJa0xcXyd8nHGpgr64Fa1ypzWB0bv3ReczZqXOQp
         Dg7N+maVdKKHb+bhATNMYfE8ieMRNBNlhxPqvVGJCtXqoalFgEs3L9x94O5uF5/pL0vd
         Hscp1l6uCqG5g+lSUmYiY0tPEwCRWy+H0MAmPIc7CMOzT4NGivrfo2c4Owa8VjoNSVPX
         Tiy1t78d4lqwvLNVufn77te2i/zZEIA4JrSZzyI+07V9HpJvIwhEmXU1T1Un+P4yjva9
         SEX8+WtLLzZ03pe3OnZZAo2jiN3c4bnNeyQybkXYqnzYTj05rF56dvZwSvjJF91zUPYf
         iOgw==
X-Forwarded-Encrypted: i=1; AJvYcCVsYTzIJWgRv7ALLVj4vHVXXOn1rnJJFha7Gge3cg68TpFtwLb46pGRZbjVQbRkKFL3uBq0GxDUDB6avVel@vger.kernel.org, AJvYcCXc3QAs4rR9j16oYxRucq8Bn/a0ko6Alrtk0ncDv4C993A1lpIJ+00EjZRy8v6BSVEcYKgFh4s38X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPl3LKT6RsquwV65OHzUaV+WqnDKWMaSfFu8ekHHCNm3ZW92H
	73sqctRV5p7t8ekfNtfw2ZPKJsWAk77WlsITTwgKpTgB/bdpXJ5J
X-Gm-Gg: ASbGncsK3Cn7an38Res2bHEUBP/TpBcc34EiA8eDxLbEJyvepc7rwOVfSPfCJyJXVMj
	za2SuIlcz6TJzC7Wz5ng1kHqKu7p6DLITjIbaAzNQzadmoM1BPUlYIv2N53SX8d0a+MbGYrYCiE
	0EOq+5CSqKJHyit1Qs4kFc9UE4F7IMMUcqEPwI34UNRJJuRLxfN9hijwpO0sLM0hLRE8MivdRmV
	LiE/B4q/PRnzPRHabmxkMvEr8YX6zSe8Ug7AcDbD89HbCD9AG+ZOCDly+S9bhpWk84oC5dXN4eh
	nwfAfyyMUqA3KTpGubg05enVWR0BZ0tl
X-Google-Smtp-Source: AGHT+IF+FQuQyF5xVH38vwhaidGe44WwPsjwLtBRtm5sInoLCa4hX/GF7uKgDAd4md8wwhDTkA4AcA==
X-Received: by 2002:a05:651c:1993:b0:30b:94c9:cb3b with SMTP id 38308e7fff4ca-30b94c9d08bmr9609061fa.32.1740748452706;
        Fri, 28 Feb 2025 05:14:12 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b928fcd1dsm2900991fa.32.2025.02.28.05.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:14:11 -0800 (PST)
Date: Fri, 28 Feb 2025 15:14:03 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: Include cleanup.h when using guard()
Message-ID: <5b352ce7241e5904a317dd26950c7cd4daa59fc0.1740748394.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/ZDuC+u021tB27Tz"
Content-Disposition: inline


--/ZDuC+u021tB27Tz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Directly include the cleanup.h for the guard() instead of relying it to
be included via other files.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/ad4130.c       | 1 +
 drivers/iio/adc/ad7091r-base.c | 1 +
 drivers/iio/adc/ad7606.c       | 1 +
 drivers/iio/adc/max34408.c     | 1 +
 drivers/iio/adc/pac1921.c      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index de32cc9d18c5..afcea2d6d494 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -6,6 +6,7 @@
=20
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 606486c4dfe8..931ff71b2888 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -7,6 +7,7 @@
=20
 #include <linux/bitops.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d8e3c7a43678..11505846eb4f 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -5,6 +5,7 @@
  * Copyright 2011 Analog Devices Inc.
  */
=20
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
index 971e6e5dee9b..4f45fd22a90c 100644
--- a/drivers/iio/adc/max34408.c
+++ b/drivers/iio/adc/max34408.c
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 90f61c47b1c4..1c28df132e9f 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -7,6 +7,7 @@
=20
 #include <linux/unaligned.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/i2c.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>

base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
--=20
2.48.1


--/ZDuC+u021tB27Tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfBtpAACgkQeFA3/03a
ocXdMwf/UAl5JU2lJImfnbz9kvty97meOs60nveclGcLK4W28BbNuqzvJg1zlBkL
1quNf4EIIL9OKzc9EJc8Lm27vIJuefYCkB/XqFFs+lvixLZjx6T5/gXUfyBy1FyQ
8oIPexjwMqKyKqkROPF/rLaWnYmanyJ8PjQ4VdvgKtM0SQTIXhTDlGhgjJjLnKEa
8jA1hNQGVsOfZaUGWT+zc7ZiTBN8Oti0CN92loAdjcveSXcd/7pmmVFdi9B1wCcE
W+9C/k8GOJQITlFWIlpklk7O6z/Mfn3nk19GMJuZ//M1sdc+NoSGvWs4pqR+ZoxI
2DabpXjTCuTRmAzpef6WebJs52RfCQ==
=AW6/
-----END PGP SIGNATURE-----

--/ZDuC+u021tB27Tz--

