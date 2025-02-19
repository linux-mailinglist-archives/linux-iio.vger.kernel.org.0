Return-Path: <linux-iio+bounces-15781-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54524A3BE1B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04D51890928
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C681E0B72;
	Wed, 19 Feb 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBm8Wdjm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAC1E1025;
	Wed, 19 Feb 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968270; cv=none; b=iXrJ/OpOYWbNDQVGdu/ZqEqRURc19MrZU/hIdPZZkkKu9k9G8YX6wPhhNIqD3vudOVIPubYgJUzs8ZJJ9MkrkG+nE4uVmnQQ96f3Ot4lkpJve3GgPwTsJ5Jd8hHkG4eAcKIimpHYQI+/OpvejRLcNerm84psoZMi1dsBm7hyMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968270; c=relaxed/simple;
	bh=I3shXO9b9Bf/a89JD+NZvm3W9P/MGQLFbKoUjj5IlzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txet8K/Ki2V+umjLgAnJNBzVGTuOw0spuTKCmvf1wDFUDVYI/a659UMOftqS9JLMEuTihDiKuYwIzvDLwlpjHnYWcoQk6xYOBSnHJdXCRU6NhpfITr0AUttbPVNIhONlt08CbbkltCOpWAqHtPXKOMadXuyxqX7A6cinb8xGc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBm8Wdjm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-546210287c1so3321515e87.2;
        Wed, 19 Feb 2025 04:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968266; x=1740573066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNzXBsdWjpLDVsAJfw/fASRvRFeX+ndkn8tRpPOZpL4=;
        b=nBm8Wdjm6B4UUIdnPkxXMm2MXCOIk6RJXoJl9aramJjfd8uLkChm8yEZPw3NiW8fYM
         t+jrrO/LiyZnFlOn+KP/YeNAVUzSs0eK3LynGp340lWyeJotu18gNL7xiy5a+RIPqHS5
         jMSRwVFcArH8OgS3Y6HuM95sM7M66r8d0jfAPUy+GvNshlxNcrk2oq9UMfQ+XHI54ZR1
         9HKf9vC9apwcHKIVY0PxT3IzLlowSUopccSS2jeo437lOFQMlaGBO9OffdE+J+4E7S7H
         v+UtkLGgl8b50PMgKvS9NM2haKeAiEndmsK/fjaebp/E+0beG+v/4mbDczZjnCWkCBuL
         TtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968266; x=1740573066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNzXBsdWjpLDVsAJfw/fASRvRFeX+ndkn8tRpPOZpL4=;
        b=tIKucsXwpLKP2U8v+MzhBwl+uqC0nJoFsvKL+q85qes7GRqQuMZqMiKR+vIUwyJGJ9
         k99e4PKVikycUYmuQD8/MTNq69voNLOvXPGyYBLZICIBhGJL8Ocd52z+c1ukfORDhZYc
         +ZoArf5Z35AyF8OIaFcejNhY2WdS5SNVLOpqhFm+CxxlE38EzkeLnmeO09H0JdxBr2r6
         FTTljsjFyKAIgvBJsvC9t9+X3UFxWkaDakM5HTpoB27DFKG8YI27XAy0eujuEMKAIqJ9
         CbFAtm5mOyZMe8jbcbPE8LvlGFp5o6jK8g/V5KwXV6JAt5/796DJ7X6KzX85ZTwworcs
         hONA==
X-Forwarded-Encrypted: i=1; AJvYcCU7lEpqxmX7bj4faG74YfUWZ07XQNO27UK32kuLTiM6EUjEIys1oyjnkTa1biS/rzQcyY+hnan9jsz0O5P1@vger.kernel.org, AJvYcCUfaPKuzxH1OLETCUY1fO95aogA9pCAeEtTmAIybE3+2AUUGxLpFFtbJpuvGBdfrLejYCO3GnFYRb3YhQJ7Bmsaru0=@vger.kernel.org, AJvYcCVjtGhjZ5A29r522F2ro3L0Vm28/89xWdJGE5jFA8NrFrVm5chiUArgsoFg7gwcldxWPG48eMnezn94@vger.kernel.org, AJvYcCWXk/k7Bgl2N49VSQU9UkuOzZ0qIpbTkxgw1zZ2GWce7+4mqSg4pniiFawaw6hyJh+7veIFN1pSxunn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw1cqZ+krJlFq/iVaRR+slOgwVAYq1bKmjthg35nIIBcNPC943
	CZ7stdNtXcTQo4qMqp7XBMlA6EdufeTs0Ch7XNXwO56v1xt989x4
X-Gm-Gg: ASbGncvcBV/HEhES7EADwOpDRdS/SWs8J6d1gvfeqpaKL3V8hOGqt9I94nsPY2oQigd
	rKMioS2VUIc6gX0kpTBnPHMSdPj3PEGKrsf+kJlqQdi8P5yb7rn9T88AnSF0dPsgPX4+cyTHUr/
	FAtUXzY+XiQcXsg+Ve8/dueUy7Slgq22FW6hBhf9WM/+VzG1h+dASGu1nWWQt8T75jqiOfkP4LH
	/HOaEhQ3LWWU7Wdv7fO/uB128RN+c5tmG32ngKK7ffzDPYvS4crO/HoDdYugD5qubeeXDWPvyJq
	LV6Nu0TKK4B+r94jvWk++A==
X-Google-Smtp-Source: AGHT+IGbVYVIJzf3Ky5RtSpHDBC96A6gAGmLe92KwdhKJGUa87dA9Nei6u7W+ae65z5/SkdH7rRhrA==
X-Received: by 2002:a05:6512:114e:b0:545:b9a:b4b4 with SMTP id 2adb3069b0e04-5452fe8fd01mr6567349e87.52.1739968266349;
        Wed, 19 Feb 2025 04:31:06 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461cfe3a7fsm1193290e87.34.2025.02.19.04.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:31:03 -0800 (PST)
Date: Wed, 19 Feb 2025 14:30:58 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v3 4/9] MAINTAINERS: Add IIO ADC helpers
Message-ID: <65fa17207c7c716d66efb95733e6a37512465605.1739967040.git.mazziesaccount@gmail.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x07A89EJB3DmszZV"
Content-Disposition: inline
In-Reply-To: <cover.1739967040.git.mazziesaccount@gmail.com>


--x07A89EJB3DmszZV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the IIO ADC helpers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
RFC v1 =3D> v2:
 - New patch
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a87ddad78e26..bfe2f53fa74d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11099,6 +11099,13 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/iguanair.c
=20
+IIO ADC HELPERS
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/adc/industrialio-adc.c
+F:	include/linux/iio/adc-helpers.h
+
 IIO BACKEND FRAMEWORK
 M:	Nuno Sa <nuno.sa@analog.com>
 R:	Olivier Moysan <olivier.moysan@foss.st.com>
--=20
2.48.1


--x07A89EJB3DmszZV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme1zwIACgkQeFA3/03a
ocU7HwgA0cGcPRNsovTvGC4vVEpqkMwltUbKNh1IXuvWu9i//o8vPhyV16w0TJ1q
qXjZOjCBIzR/Gh0OORKYMUYpGOlunAk49/h1mv5EeKEbg9H5buLgthjE7aBj1O48
fhz+HOVKIUJY9y7IkFjtVLqR6pHJfAjpqZ8HuubNkEKHegztdPvE8VjhB/4HDrxO
GAgNaEuUevO9/7tBnDLyr1qpo6PkVkIZqAziP0ApIdf7l8hlmabuc4XYpvu4U6xZ
pOpexx7LK7PCUUoaTXZX2sWrIxoEEQiM75Q5PPZvPvzftLgrCeDWy0u3syV9AO/J
p3ZuHFMAMr3oTFvth9KbobVJNmSfPA==
=TOaW
-----END PGP SIGNATURE-----

--x07A89EJB3DmszZV--

