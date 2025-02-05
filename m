Return-Path: <linux-iio+bounces-15024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EDAA27FDA
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 01:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7F71887A7D
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 00:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DE553BE;
	Wed,  5 Feb 2025 00:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aORGDcQS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB925A65E;
	Wed,  5 Feb 2025 00:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713647; cv=none; b=aU4FP7R3oGWMFo9D8QgNlni9B+en680VvJeD/E4Jm8s2rxIJAvVKgSk1RT6jLNznDv598DqsZOtNfEAq8w693S362CU0fDXe6b5zSY0gOJ5fVHedvyzSbsb9dVkoMOxDefjGZp230+By/H2wHFbIEh2vFqzxL+qmgFjpql7DdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713647; c=relaxed/simple;
	bh=4Nd8zkIFo+tzIlu+MtfTED8nED3c+ndCBfj7taqna5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDKY2KyozSOPWhWzh4GyCa4ofVYpxMuU3REfUj84AvjYHTVXnK9C28mVkoAiH6eASlfMVnwEtKCHQZ/b/4cHEH+wscTadDT7fC/lxXhf2UkShrJDpoobgq5w+DpTqMgDQiBr746OfhXsKVsyQNriMtdLZni7JKyyOTe98nIUcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aORGDcQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F40FC4CEDF;
	Wed,  5 Feb 2025 00:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738713647;
	bh=4Nd8zkIFo+tzIlu+MtfTED8nED3c+ndCBfj7taqna5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aORGDcQSqOG6EIfi3tvCAq7oMs4ru9E1QvEnqHZmnnl3CtK98qQAg4ZatwXtAWXjV
	 PqDYyI7DaRQteyPE2398JPTR07YkrtwdrOv+Eq2426kBz0CRWfogGU2xtY/kkKSD6r
	 2ieqdxM0HbPhRA5rmmmbTE8e4lAuGmWkpecOS3aOobH4GitMupKrSyt7Hm0Idu6cIO
	 5zLNKZ4f5PLyNZ9jATGzxV6QahKwtT/xKBvwVTCbWGGV54BQI3getRxmmGly8Je3QJ
	 YFaCJJgtcaPUycEAV3AkW1NdLwfeAi+EXBbfq+0F3BFGVnYFY++wv2VBYqjk9ux4lh
	 bYDbdihl00oIQ==
Date: Wed, 5 Feb 2025 09:00:43 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Bence =?iso-8859-1?B?Q3Pza+Fz?= <csokas.bence@prolan.hu>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v2 1/2] counter: microchip-tcb-capture: Add IRQ handling
Message-ID: <Z6KqKz3YDQypxgok@ishi>
References: <20250203162955.102559-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8lN0NPUSkqhcUrXT"
Content-Disposition: inline
In-Reply-To: <20250203162955.102559-1-csokas.bence@prolan.hu>


--8lN0NPUSkqhcUrXT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 05:29:52PM +0100, Bence Cs=F3k=E1s wrote:
> Add interrupt servicing to allow userspace to wait for a trigger event.
>=20
> Signed-off-by: Bence Cs=F3k=E1s <csokas.bence@prolan.hu>

Hi Bence,

Thank you for the patches. When you submit the next revision, please
include a cover letter as that will make it easier for us to separate
high-level discussions about the entire patchset from any individual
patch in particular.

Regarding this particular patch, update the description to mention the
specific types of events supported by this (i.e. Change-of-state and
Overflow events). Even though you expose the capture data in a
subsequent patch, you can push the Capture events in this patch so that
we introduce all the supported interrupt events at once.

Thanks,

William Breathitt Gray

--8lN0NPUSkqhcUrXT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ6KqKwAKCRC1SFbKvhIj
K8yjAQC1lN6++3uASijjfZxAf8Pql7nv0XxqlRvX3ZF0WeMs2AD+ODgK8IcKjycD
CLDCfn8zbJyteMJjJTcJW0uvh2INkwg=
=fnvp
-----END PGP SIGNATURE-----

--8lN0NPUSkqhcUrXT--

