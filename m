Return-Path: <linux-iio+bounces-13595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 268669F5FFD
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 09:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D341D7A1B1E
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 08:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D33615990C;
	Wed, 18 Dec 2024 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRkP8sAO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE73735945;
	Wed, 18 Dec 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734509854; cv=none; b=RYnvuqmPuHAF6P3Oyh1bAh2CjFXQsGknC/AAw/OKDkpiZGafjyY51Efh3B+UCFhPVSFGwzDt+u2z0pZBNI7okT0pmBcgWwUwiKnbckbiPNEQakoxfmspLFNxKKs13Ahn8nIP00+c8K3TfA+yF6KdnW2I9v7SM9OeummTeP0AZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734509854; c=relaxed/simple;
	bh=A3T1QJ3NOU7tRQpb1lCk+AMO0Y0dbZ5rqmPUmYJPVkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XPnS2mktcoH+4N8s9J9jLg05c6bw/yhdMlN9SO0xfIl2y1uwDxZlUxVqh5aA/Rw2umlO/JRgkMVJ06b/fwxbjAbCGnvQ2cPcrQrRgo3IVpg02l/WbTQu7uo3LZxnU09HCR9Ruf3xqP+9B4YXuwDbfYTShZ58NuGQWvRD2ZQlV48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRkP8sAO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so55373941fa.3;
        Wed, 18 Dec 2024 00:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734509850; x=1735114650; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81jFL5t5nOp890xXjLKx1phRJXA10fYfBI0GOMYOfoU=;
        b=JRkP8sAOLATDTX+x1ggAGZQQcBsKDsTjubapiX2P5YOCx9KvkRg5nH6skXMK69VBol
         ep83B4pmWik5r6zkSuUdfdoGjRRlFEPQq9DbaczAVoyqM4VcObGO0DQE0T/fykK2eN0e
         l17y2AtYhkM6cXBe/+ly9vNIaZKxvdG3AiEIN7W34CeN2nq2luH2+avFkrsvamAvmodA
         BnytIfB71Gw49XQvzcDjgU5jD5mDP9YtmGTGRRgsvbFMEtrgFHJ2HbQbYrzHsMQcIczu
         HBRfYjRATKwN7ZBuG1SLdK0ncRuFh0uewUoTWgTGrpw8VO8Xy/kiGzFbK+4z+AWLAvw8
         I60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734509850; x=1735114650;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81jFL5t5nOp890xXjLKx1phRJXA10fYfBI0GOMYOfoU=;
        b=ljY+jNoDquA1Q3DfBfrTZjf9PX4i7bRK3bcDuVNxBzMsyTC1ehJilmCDH3Tsheu4Ul
         sv9EVq8yQ32P9GTcQw/PtO/aOtkX+y4mhcty1uksh4fEpM7Mflzahumeg9sCvxCRmCZR
         GWwZLIpqczJopYqHkwCuygy3ZJExGrKGt/tRnEMzzpRJCbc8A5kuE+a4h5AjBy57dDl/
         w+n2b2wVEQFKdiyhHlkGOKpMa52VMQaJvXGNu7koT4Z0Ffwjd7HauTzCjsM9J92KfdhZ
         i4gles/ovmqLpPZAPu9/RThBTMGoO4nRCxXwKD+xnAGyQPkL3i8FfFXlmGUEOB+jjhQ1
         M5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZxPCYA9qpc0YfyrKn6v3Vf4jYAqcAwNNmRlogyhi2RM6PbsUfztVHeM3jsxiTcJ8DzkafHwxZYEA=@vger.kernel.org, AJvYcCXOECRqsv8Grs0eMINPNCElMxJsNRytme57UWKY+VD1sfP9bWZraNK3AxLD+X80d54v5b2Dyw1QQMs5wrg0@vger.kernel.org
X-Gm-Message-State: AOJu0YzjD+PK7KyESSNqSKpr26gnDWpCuR/wFEgUhHjon+cvr0eY+EfE
	ZAd2cQ6lt7uaE/a1ZWcxR8fIDsknu1GAbmCoz+FSYxR+euZzz1O+fX2bpg==
X-Gm-Gg: ASbGncsAcxpHcQsWCPjdoqV9UV6bjklqLs54xaSI/QffCmt/OW456Jqh3AI1zI5Zq9A
	l4/k4yYGuMMwLsxI/GcoXS6o01mJyp68knCL+bolDMIHFyxoUYy5RZHqvHpraYf223jo0W9+Aly
	5KOss7A8rl6y3b+xb+MAl1lUUQv6b6BbURTGM2gFSbAzhXhEnS4VfeIN91PP4Q2tugL/TqD1jV/
	6g0Cg2ldRigNLxpz3z71t3FslEUpDH/WCLXNTkTIeWN+GCXTnHFSUHEEvs=
X-Google-Smtp-Source: AGHT+IHmBka3SaAX9pOO8kzFMFOYsqBj1CWgCuhmRAXDcCzNpX1EdAgNprXLy68dJzaaGCZFnnMMnA==
X-Received: by 2002:a2e:bc16:0:b0:2fa:d7ea:a219 with SMTP id 38308e7fff4ca-3044db58d55mr7076551fa.37.1734509849619;
        Wed, 18 Dec 2024 00:17:29 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441ea11bsm15229791fa.121.2024.12.18.00.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 00:17:27 -0800 (PST)
Date: Wed, 18 Dec 2024 10:17:15 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: ad5624r: Drop docs of missing members
Message-ID: <Z2KFC7ZBwmM69Qb4@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u7bg1VuWw0Nw+bUx"
Content-Disposition: inline


--u7bg1VuWw0Nw+bUx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The documentation for struct ad5624r_state contains members that are (no
longer?) part of the structure.

Remove unnecessary docs.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/dac/ad5624r.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/dac/ad5624r.h b/drivers/iio/dac/ad5624r.h
index 8c2ab6ae855b..098fb5a7683d 100644
--- a/drivers/iio/dac/ad5624r.h
+++ b/drivers/iio/dac/ad5624r.h
@@ -42,10 +42,8 @@ struct ad5624r_chip_info {
=20
 /**
  * struct ad5624r_state - driver instance specific data
- * @indio_dev:		the industrial I/O device
  * @us:			spi_device
  * @chip_info:		chip model specific constants, available modes etc
- * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask	power down mask
  * @pwr_down_mode	current power down mode
--=20
2.47.0


--u7bg1VuWw0Nw+bUx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdihQcACgkQeFA3/03a
ocXMIwf/ZElcpN+zpOb0UqBUeR/1RCb6VMoXIpHoEj5idB3GRzRA5ICP1HBPskhp
9VZXzsvaVXoSniQYDVAbn+qFZLZJhBqDlu5Z5hIgTMD7XH/nzkWOS1VxZWjMSjQz
pFoK1Xu/CnccULLXgtlQMXl657enepo5DRIREr7I62sr0xCCliJTp1ggHdqO6gjc
NgYV+54Do8Ozw4MBqCjmIiRrXOP+sPN87fY3Kq66A9oBMGpYfZpzrxlL3XDZSIFo
qh6dE/pCkGUl0K+XPt2F6ow4zvx76vFLSMmMZucnnKg3c9Tc9d5nWTEIExkvjR89
8249k/x5eCQVKcz35HWxvsJypGVumw==
=JcTK
-----END PGP SIGNATURE-----

--u7bg1VuWw0Nw+bUx--

