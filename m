Return-Path: <linux-iio+bounces-5463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC038D3CEE
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 18:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6926D2890BD
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD73187332;
	Wed, 29 May 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwqB1+e3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D91836E3;
	Wed, 29 May 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000492; cv=none; b=EbJI0sMtn92Py6Rzz6QJN7gckOpjsQaUkI/PXPJPCvHRtA0HwutBe4WyBYZ2aggBwxhR6X+c98ZPCoYJWdIFu51pu/DqOdXcsZxgsGWgRP372+3LvxUU8aA9f1/l+PCKXNtBJFiaGZSW4gFGo9LbPNan7XsMfyXXxc6+vqcThIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000492; c=relaxed/simple;
	bh=VD2gswSUfZLLqKh/tx8fNLjin9G8nLP9kZDorypk1r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbxH9cWWiJp1jcCtSSfIFwIcCIAGUTd1QRWbWZd6299ZPWg0zke8BD3ujpEDQ5Zy9VUGVGdfBUCWkV+BNchRrdozRBevnE3E7o8TW6ByF1suL8p16hHhab+FjylBDQdU4gj3pSHYZAob1apw2eoORZoFSHPVOst1ZZXBtPXHyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwqB1+e3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664D1C113CC;
	Wed, 29 May 2024 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717000492;
	bh=VD2gswSUfZLLqKh/tx8fNLjin9G8nLP9kZDorypk1r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwqB1+e3VTVgkW5jGcvDRuMF/MoxoOUBsnInvhPNLsMGm8s+HMqFcp6W/l7ET5rO/
	 1klZhKyHv0S8fFLLxejeUAjIbu0NkJ1EJJ+4p8W/nHpXul2hNinnKPU76NGo2Tn8yx
	 /y7pgd4kVKTP9MDl7/JV7kUlZ/lQwGTfIxwyNPTfjO8s5AxcRxUwVHPIqMvmCo280c
	 mIFmV/1Mx5g1LIJPZoDhGPmRBAaqVSN+MYnRLzi7rTnpQSLO3axAErhdA5AOA1VYee
	 ZdwaTZzI/ze5FsGYOD6VGCYMboLb6wR6x9YmoN67X2obMxBW35LHpqmPew7u87+umb
	 oQDtMN7N5UDVQ==
Date: Wed, 29 May 2024 17:34:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gustavo Silva <gustavograzs@gmail.com>, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lars@metafoo.de, christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: vendor-prefixes: add ScioSense
Message-ID: <20240529-greedy-paralegal-86f41c376a1f@spud>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
 <8e27c8da-d856-4fab-bb12-3af07e13838e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dv4KJo6oQP0VOAKM"
Content-Disposition: inline
In-Reply-To: <8e27c8da-d856-4fab-bb12-3af07e13838e@kernel.org>


--dv4KJo6oQP0VOAKM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 09:29:54AM +0200, Krzysztof Kozlowski wrote:
> On 29/05/2024 02:14, Gustavo Silva wrote:
> > Add vendor prefix for ScioSense B.V.
> > https://www.sciosense.com/
> >=20
> > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> > ---
>=20
> This is a friendly reminder during the review process.
>=20
> It looks like you received a tag and forgot to add it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--dv4KJo6oQP0VOAKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZldZKAAKCRB4tDGHoIJi
0s+FAP0dRDD0H+qMKCNznITN6x9gudPSI8RQYPpnS7Q6/4IErwD/Z3OlFRsCG+Es
GL0LPrYQYjEfULwIRGlArU2/NwkFygg=
=EkT6
-----END PGP SIGNATURE-----

--dv4KJo6oQP0VOAKM--

