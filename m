Return-Path: <linux-iio+bounces-6904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084DE916D31
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB79128C6B9
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68402170824;
	Tue, 25 Jun 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfxKrQVm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C28816D4D7;
	Tue, 25 Jun 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329693; cv=none; b=iEgj5mfva85FQ48dOwhmd1L/mpJ36/iSRDbfCR+wgnghBJl2YjxRCqGNeBLFUOZGuYfG00CpVOwiwSBxwV3wJAwmaL4GgX2KAmcTgDauzfrAilbZloGmxCYgS5EPmWeKtMLJyNriGy+mQZr3y6eO+aDCFrOXa3zlqg/vXvszV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329693; c=relaxed/simple;
	bh=gTk+23CWObg9MzmcWZm2zgAuR93E18j1kHQXDncw/IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKH80D59xxPnfJsZJAJa4a8Knn8yIveOMUr4HEcpPnEkWkwPTfCWhPbVT3HOuunu6s17IunIaLyM0eI6kQnwhUUMiSh4BTwSAyP81NhmoA+NGyn/beHH5oPZdFCFqUqc1k8n7R45eD4HKNoEWaYdT6eYChOBX9hAFyJ5BPCHyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfxKrQVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C156C32781;
	Tue, 25 Jun 2024 15:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719329692;
	bh=gTk+23CWObg9MzmcWZm2zgAuR93E18j1kHQXDncw/IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfxKrQVmEXHydhg2JMRrdJksEl6mtPFVm1kZLokSsoYnP1rNV8IlH9tx2fSogMisE
	 sMhyI1skUjSjWMRGDKZOZUU3pmObIITZ3DV08N2h52FUWpdbmXwCI41ac5XGRepXCJ
	 FOKhc+aDyTX//lJwTg1QTqpCY8G952KcXyhiLJ6V8Kbxb6zVPT2ZNjDNd6dHSyE3d7
	 lBtROSdEWVmX5N2XvRvbMaapRSw60+4yn2KmbeNJEwKEJjpvE1Ujrb01qr4yGvPaip
	 PAX/e/YH22qMIFhmpVFmYXuqG2pcEJrKBopcQ5UaRRksqi0xDDHwr5WBvg4GPmugr8
	 v9jmL1plGrtxA==
Date: Tue, 25 Jun 2024 16:34:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: fabrice.gasnier@foss.st.com, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: add sigma delta modulator
 backend
Message-ID: <20240625-babied-skies-0722dbdfc524@spud>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
 <20240625150717.1038212-6-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="koaKMre3ntrtIL26"
Content-Disposition: inline
In-Reply-To: <20240625150717.1038212-6-olivier.moysan@foss.st.com>


--koaKMre3ntrtIL26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 05:07:13PM +0200, Olivier Moysan wrote:
> Add documentation of device tree bindings to support
> sigma delta modulator backend in IIO framework.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

I don't review bindings for a job, I can only reliably get to look at
my mail queue in the evenings, please give me a chance to reply to you
before you submit a new version.

> +$id: http://devicetree.org/schemas/iio/adc/sd-modulator-backend.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sigma delta modulator backend

Same comments about filename and title apply here as the previous
version. "TI $foo Sigma Delta Modulator" and drop the reference to back
ends or the pretence of being generic.

Thanks,
Conor.

--koaKMre3ntrtIL26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnrjmAAKCRB4tDGHoIJi
0sNBAQCP50UL3FxvbZG06MZSx6eP+Y3JyhmEoK0Mk9xWXPPCzgD+OeI3SdHYwF20
IctMHlmMqzaZ5Wbb1FsV3kP+AprUiww=
=bzse
-----END PGP SIGNATURE-----

--koaKMre3ntrtIL26--

