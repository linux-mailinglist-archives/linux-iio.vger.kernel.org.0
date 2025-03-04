Return-Path: <linux-iio+bounces-16328-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B24A4D9FF
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 11:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F783A4134
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95401FCD11;
	Tue,  4 Mar 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRwk3ZPY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CFE1FC107;
	Tue,  4 Mar 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083534; cv=none; b=qDRAq9wvDmsjahSFOagwdPMkLOJUxbT2akXz7MXwc/FuVlMHsQW1XKsZpsuHAPQt6pXa1vnlUX8qw2Yfs6cXQnCmq+q9LFJsQwudhWdzNacah3XHoFPu0ayoKKnLi5k8/DB04B92Qx2x5I58rmrBy8NJj9rBKE1RZklk44N+xKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083534; c=relaxed/simple;
	bh=US24++JqmjXV0mttrUPY2QvIqdLYwAQ0fJFwmF2h1iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlXrXSn1PgNhAgpWl4qr9Fptv8s3Ax4A123S9k+ODVKPl7/ZDvTum59AIfVkZw70wmAq02x8ywDXjitv2m5q0gdNCo4p16+Y9JP0rVeo2xg6dnx3vHkaKxXlaABFFeLixbNv9UJ6Ixwggkp/zkCxyQePJU4QmgM+rkqz5tyVoxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRwk3ZPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B9CC4CEE5;
	Tue,  4 Mar 2025 10:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741083534;
	bh=US24++JqmjXV0mttrUPY2QvIqdLYwAQ0fJFwmF2h1iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dRwk3ZPYwAxWAV6U9csf40AiEHopJoeD26ORP3qPEHlojXU/Hqz/f4BUtXX0WKzjQ
	 Ho0GYe6lKZUdZ2N3ZLmtyCAZs6/ijv+r3jzKA5rk8eHddV9J9ty8n/DtdzeJfr525A
	 Boj4mz/mwN0kuOdZC7MeKiDHIiO85tlCunzm6MkZblDI6kUJlmLztTeiZR/70SUv0V
	 YvgDQqmnqFWwecKGKIzEn7JnKWBs9V4ifas3YiQlPcGD/aoK8y7Qh3rM6/JB4Es75k
	 Mdcs1fEIJB2dvKdajjPTRYd/u4rH1dp2ROgBD5G8xOWl+9rlvCxUen92bGNT/o/FEu
	 FumwBhup4TRqg==
Date: Tue, 4 Mar 2025 19:18:49 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v6 2/3] counter: microchip-tcb-capture: Add IRQ handling
Message-ID: <Z8bTiTWa11iqxUnH@ishi>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
 <20250227144023.64530-3-csokas.bence@prolan.hu>
 <Z8alaOTjZeRuXnUI@ishi>
 <9fcf9cf4-ba02-4583-9e14-bd650dbe32ee@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7g4U+VYmFuSmHd1m"
Content-Disposition: inline
In-Reply-To: <9fcf9cf4-ba02-4583-9e14-bd650dbe32ee@prolan.hu>


--7g4U+VYmFuSmHd1m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 10:57:05AM +0100, Cs=F3k=E1s Bence wrote:
> On 2025. 03. 04. 8:02, William Breathitt Gray wrote:
> > In theory, the error code could be something else if of_irq_get() failed
> > for any other reason. Handle all those error cases at once by checking
> > IS_ERR(priv->irq) rather than just -EPROBE_DEFER. Then you can just
> > return dev_err_probe() with priv->irq for the error code.
>=20
> Yes, `of_irq_get()` can return an error, for example if the IRQ is not
> defined in the DT. In these cases, we just don't do IRQ, but still allow =
the
> device to probe. -EPROBE_DEFER is special in this case, because it signif=
ies
> that there *is* an IRQ to set up, just not now.

You're right, that makes sense. Thank you for explaining.

William Breathitt Gray

--7g4U+VYmFuSmHd1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8bTiQAKCRC1SFbKvhIj
K1K/AP9CBln2kj4VmHF/sMQlwpaOMV7DLh7MzYGOOQ838jE/VgD/UIhocl5J3TIg
+n7JyYuGK8FXUplttva0FRj47UXfoAM=
=E6wR
-----END PGP SIGNATURE-----

--7g4U+VYmFuSmHd1m--

