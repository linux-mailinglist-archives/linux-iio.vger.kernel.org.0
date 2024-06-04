Return-Path: <linux-iio+bounces-5768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1758FB681
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 17:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76534281F0B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48C81422D8;
	Tue,  4 Jun 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuD+eKfq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22D13D607;
	Tue,  4 Jun 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513471; cv=none; b=QBe/RWzCRuGMbug5chH/xM+cft3I97fpewHXYdQGSUEetxpcQg+WHqQ/SeMC+nkESkrU0Q8YNKYaM6hWSZG27flOG8M1qbwysxpOkkL733I4zX5eloq37IXSrGTjaAfe2RnfC7h1t38RDovJJeFLNvYRvKAK56xJJNrE5abFPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513471; c=relaxed/simple;
	bh=y0EvXNTCYX2JR18tw1pE2t4dZhAe7eyCQbW2UDrWLsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3ySGfCsbaLDJq4Z9ky9KirUQa7wYJSBPX9aMnSB6cI2lrRAH3WqQAUBgNvnyvLHea+9Cilt3qHzDYaBmfHC1t+pXeQ3vzW5zdoJfmfidZZ2zLFazQOYRGKdmaPhTnyKOvyTWGsJmYd2nSuGr/LwFN+s6jTGcROphWlM9j8GgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuD+eKfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57189C2BBFC;
	Tue,  4 Jun 2024 15:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717513470;
	bh=y0EvXNTCYX2JR18tw1pE2t4dZhAe7eyCQbW2UDrWLsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fuD+eKfqDs42GNyoWVKDNJ7DZd4wjUlntKzmNLRGGMgt3Kb9GlpHDwyP4V1jfJDGM
	 XRUghYRWspe5Qdu08M6y9Kq5eXSDoy5oJPd3mogEc9mvOVWH9Drv7dFRSmpqvaaTZf
	 FrxXAmdY0PgLFVAiWp3f0Urqnlnlhr24ghAbrlPfpO2+O3JP9r5wwlqwKqhGaejBln
	 gsZaF7sK26hdt85qwaBGazzIk3hKMrsZKtx2D4kiJFWeeUCkDTSLzUHZGVDP50jVLV
	 9OXGdVLLB+WmO8Ynkuc2cLuDYbNDMFr1SjRBUykIRA8EilmqWshtEAfHISrOxttl4K
	 BAAFHBE5qzh4w==
Date: Wed, 5 Jun 2024 00:04:26 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] counter: ftm-quaddec: add missing MODULE_DESCRIPTION()
 macro
Message-ID: <Zl8s-uujP1lXBAQY@ishi>
References: <20240602-md-ftm-quaddec-v1-1-1bbdf705ad31@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="95b6PXuy/W1LLJyf"
Content-Disposition: inline
In-Reply-To: <20240602-md-ftm-quaddec-v1-1-1bbdf705ad31@quicinc.com>


--95b6PXuy/W1LLJyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 03:05:20PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/counter/ftm-qua=
ddec.o
>=20
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>=20
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Hi Jeff,

Would you add a Fixes tag as well so we can merge this into the stable
trees that need it?

Thanks,

William Breathitt Gray

--95b6PXuy/W1LLJyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZl8s+gAKCRC1SFbKvhIj
K8iUAQD0WaPsQ1/zAB3wIwDz0z898/41skahP1lX0wY/Lx+nsQEA8ySLyHqHIKwM
2Cb836x0NIpN1w7mhADuAIfml7csww8=
=PzGZ
-----END PGP SIGNATURE-----

--95b6PXuy/W1LLJyf--

