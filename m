Return-Path: <linux-iio+bounces-16672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F360A59564
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8D53188F235
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638FC229B36;
	Mon, 10 Mar 2025 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT9xXHO/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107B2288FE;
	Mon, 10 Mar 2025 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611443; cv=none; b=BU2dPw7PxhMwFH3wUN1s7G6baoXCz7AQOaYxixH9O0iSjWConRpvWIydguFrjs+O7gLZ2q8+Ko+rzgVx2hFMuDuIYuDJa6U6V7ijOHcZFn9hD4eOH4aK6CVt8S0cb75R0+L+TN77xOaRQ8ZehGqtthJ0aMmsYC7f9w8GoRs3tyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611443; c=relaxed/simple;
	bh=sMXdNxRRfg/fbzE8vDaVeHyv/dnOPma1VyMfUU/zCUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K64fqRj7dD4LCr1KrzpNyG58h51s1iKe6G7nYlylbGsafZ6JNgbJYs/fVFAyhTTRAOHmf0HDCI3hrWCKKkhtdCXxykqFr/w2Sg7iJFFHBzAHCBJJHq5yEhX0Dr2s9Mb2hz41vvxSxKy/iPGPyiLtEns8S3nNvXYlFzcRxLfCl1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT9xXHO/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54943bb8006so4698813e87.0;
        Mon, 10 Mar 2025 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611439; x=1742216239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kKCGiwBsQG2cP1CSIcQO9Xbqf5ENeMe4ur7bqwzGKXA=;
        b=hT9xXHO/NtP3blH/SNqKxSvnug/5jeqJUj6k2iVr/hbivheU18OO/ApkEJ2qGy7+Eb
         //SXilaKbvCzuNqNOkUusJEbLI7XrFZCSLkCnWfDd1Pd7cNkr+5sbvBOaBr4utGFtvdH
         J2Q+tpDjyBK2a0j+0wya8iCq9/E7QkwHAVh7PxcIpYcwLN+qpepWdMbuHutmumMwxI9y
         XFIRIPLDdbX77JTnAA5Rl12oABmzlxYKM+EbeVe/EFU0gqTaFN4IKixoX8SQrM6aZ0qN
         6KoSKo/djWPkJ1y+9frf5ctZYoDYtNbZM5tHE+cPC/A9lcLMo6Ib3flZiCZQt/yQn4Jp
         V0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611439; x=1742216239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKCGiwBsQG2cP1CSIcQO9Xbqf5ENeMe4ur7bqwzGKXA=;
        b=QwR/gGOug6nqZHcN6YaibOt3Y2b8fp4f4x4f7jCf5eXi+5rWIATbU5DvbhxfZnedIo
         1H3Jk89GQ0sFvwunqWQzRZxUZhwjotJdjy8EVlJqvCCcpXwAh3forIFisncBL0G8rq/j
         djKMQ1H1GDRGzAL+gx6MsxbI0u1zgQNTbOT6RhWDrmLdC9J/pyiLe2LoRrkczXTh6oej
         nNwoKXQaWbWqn+Dd0MwSmDZAwbOtvX/pHLvCaxuuy8lZD9EH3pSTuitYIAR4n9JsYWZz
         0OIiGfIzcoxjk0wXUiuB54HvCfibywYXPAt6McKfaQAgvF6yoJLv/VprRG0ULYkaA73O
         4FxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA8PTKuFtzNVGpttfkBizHEDTs4oNWV9E2oCIdF8PF4uMYEtuekE6NMGfsvHFKuO2Kb+OkDl9XVSI=@vger.kernel.org, AJvYcCXml+jFNuqsmAD4PqqaOeEWziZxugIh7724ECYq3CLmq1qpvb5NSxankCQw4gxErRrSKq/OoaUSIlrv+/Yu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdcv02o7nnB08xQscIiD85ihaVEEq0bFCFQ0wYrE2q+MIvjkh4
	OqG06fQ0V03bN1zO55CENHocMpJphSdRJHpLdTlPi73xYQveCvQt
X-Gm-Gg: ASbGnctWoz0i+dcU8JI7EH7+AGsk3hcmv5ZdNHKmxwCxTXU88iwtkD6SepjJdjJaexO
	AsKvfo3cIin2b9LZAZ3f5Z1CIq6uwxzt8H9jHR6jOsN4m6awMVuDT+HwO1hQhKZggjUhO/isb0V
	XAk/I/4xearh3U8ERJ+dvEbcm3ry84+M+zPMUnJOeU0dplcSYkhbuJ4RQHHt2kP/gsIjuytlLCi
	0oCMdwhWBZDCSmWDiuR1w3i+/3QACp6Gh57Cem0cNGz+pVSb29szJwfzTvHKdRaA7tzm30FRdzM
	W9jXiNySw4qLwGAbVQQ/onqd7UK9v/75nEl8lDnnDlQCg0nAt4o=
X-Google-Smtp-Source: AGHT+IE0v4h2aUzbrn054EYyKpH0FnyPlWUg09b7UthxehadMhYvI/Go7bkEArxeYeoJqRsUAh/cyw==
X-Received: by 2002:a05:6512:ba6:b0:549:5b54:2c6c with SMTP id 2adb3069b0e04-54990e673f2mr4654645e87.23.1741611439351;
        Mon, 10 Mar 2025 05:57:19 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae58e4fsm1466750e87.82.2025.03.10.05.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:57:17 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:57:11 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v6 08/10] MAINTAINERS: Add ROHM BD79124 ADC/GPO
Message-ID: <cd33ea014cafbbd02f53778c36c557893b67b1db.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5/nIcMrwpyDg/MCj"
Content-Disposition: inline
In-Reply-To: <cover.1741610847.git.mazziesaccount@gmail.com>


--5/nIcMrwpyDg/MCj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ROHM BD79124 ADC/GPO driver.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision history:
v2 =3D>
 - No changes
RFC v1 =3D> v2:
 - Drop MFD and pinmux drivers
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b96fb864227..2e4416b59930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20547,6 +20547,11 @@ S:	Supported
 F:	drivers/power/supply/bd99954-charger.c
 F:	drivers/power/supply/bd99954-charger.h
=20
+ROHM BD79124 ADC / GPO IC
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Supported
+F:	drivers/iio/adc/rohm-bd79124.c
+
 ROHM BH1745 COLOUR SENSOR
 M:	Mudit Sharma <muditsharma.info@gmail.com>
 L:	linux-iio@vger.kernel.org
--=20
2.48.1


--5/nIcMrwpyDg/MCj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfO4acACgkQeFA3/03a
ocXcMAf8C8ku/Qre/bfJx9NqWPNJGxOTiw3ghIfo6zrOTdVDoxRG8Y2KtZ7MXaNa
PbioFSASZN6wLicu8e7yejJsUG8xMGzg4jzuFpP9lS5MFXxBxO9yGUPaShVFRvmo
a4sIjZ8gjUVCaVNBivNguXau6XVBtJGwGkH8d4NX41ba2XYaZNSswArKIaeBJH6a
jMcjVa2o+zcyg/zuE84nK2MX/hNs1Z7IqKLE6bXbrz2KlD1fq2h+Z+vPRZIo0GyV
M6xfsxto76aE9idyNUeQ8yblqr8EIM4wX/TsQZ1vaKcNL2EmnIhjsRCmOm3JkMiG
9YAxVJE9LK8XSYIle9A4na6QQIbgqQ==
=/zFu
-----END PGP SIGNATURE-----

--5/nIcMrwpyDg/MCj--

