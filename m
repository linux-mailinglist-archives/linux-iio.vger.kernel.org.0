Return-Path: <linux-iio+bounces-19142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA74DAA99BF
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047F71887C9B
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200A02690FB;
	Mon,  5 May 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+nrjSCD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A518C322;
	Mon,  5 May 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464028; cv=none; b=e2eqjUrID2ZynWSYHnnGn+WXp/tl8324/dA/XLTF1P0rwKwQinBRBmm9iWb5gVM0/01f/M5C5y9fBIrZGFdqSJ3EXMolk+MgjKdEqBCf6mxxP9KK0mGBBGPH3Fe+HPmxzXw19WhGyTnWS5UnG3kMm/uJcvRluYxk3KoxXYfR3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464028; c=relaxed/simple;
	bh=Nt9TcqO3UcWxGX1SmSKh3T9F59jPsuN5c6SX2ZcbeOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLlG0xz7c1SX0hGOVI3pE8aIqSFraI42b0b/rgOGH5Puv5mN0zwD9n3H5qU+CVq2V6U1VM2jZxbQ/qeVpTNsJEYFUAjaVuLRm3g8aF7UJ5wM+bT25Yc9vkyEFbRRPe4JbKqC30ot9yKRo4ohD7yjtNosFyuE12i/Yh8WFqCYotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+nrjSCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F4DC4CEE4;
	Mon,  5 May 2025 16:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746464028;
	bh=Nt9TcqO3UcWxGX1SmSKh3T9F59jPsuN5c6SX2ZcbeOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O+nrjSCDS7LvZr7nbKa5xKwL7YW9HZec0XBroINpabVtDhcuYDtAeTw0TGAUsRRdt
	 NkChCiTJviMHlFRbXtZGRcNIKEz8lxgG9c11I/F97BOOW/rBF4/7Xxp2gQOnmy7YNd
	 o8MF1/wPv47ufRTyz8SCC66lVYbW/rv4MB8gy+B7qfwdU7P715/MtD+uxKtqRrL94p
	 wiAntoLCorGkY7ROr61JHvQiyX+dPysGNqq0dOZTVHhAZJ3o/tJO29A2ME9tUaH5Mr
	 HNI/QpbZqEdwIj5SMn0mDFhiTjmZCEGf27r/nT0O9TxHKKOFdGBUybkwK6EJm66K7O
	 bQN9UwhYWGrYg==
Date: Mon, 5 May 2025 17:53:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: gomba007@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: trivial-devices: Document SEN0322
Message-ID: <20250505175340.00b6861b@jic23-huawei>
In-Reply-To: <3d42e605-2526-4eb1-b222-6552629333ef@kernel.org>
References: <20250505-iio-chemical-sen0322-v2-0-217473983b42@gmail.com>
	<20250505-iio-chemical-sen0322-v2-1-217473983b42@gmail.com>
	<3d42e605-2526-4eb1-b222-6552629333ef@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 10:16:06 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 05/05/2025 09:52, T=C3=B3th J=C3=A1nos via B4 Relay wrote:
> > From: T=C3=B3th J=C3=A1nos <gomba007@gmail.com>
> >=20
> > Add documentation for the DFRobot SEN0322 oxygen sensor.
> >=20
> > Signed-off-by: T=C3=B3th J=C3=A1nos <gomba007@gmail.com> =20
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Best regards,
> Krzysztof
>=20
Hmm. This is fine I guess, but I'm never sure how pretty much anything
justifies being in trivial-devices.yaml given they should all be full bindi=
ngs
and almost anything requires a power supply :)

Maybe we should let there be a few standard supplies for the devices
in there in the same way a single interrupt is allowed?

J


