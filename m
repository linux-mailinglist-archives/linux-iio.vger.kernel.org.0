Return-Path: <linux-iio+bounces-11939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EA49BE350
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 10:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFEE284C20
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038EE1DD0CB;
	Wed,  6 Nov 2024 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4tFQcBG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1F1DBB19;
	Wed,  6 Nov 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887094; cv=none; b=HLOioQqb8FHwnEUUzyiLnRTMqUFqZZwNKzBX99N3vvql9Jsbh5NOkMvTDtpbD2MNDUqdd1V0hhBWrD51T6mVc3Ah0XdSnbS698VA922MA4KvNwII5EWSt5ATPDX24ZgPQTvh+a0kIQjd8ZGHN9Ke+6VyUxOovJekMCccNAl9q1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887094; c=relaxed/simple;
	bh=v8MGY8fIOjiRO62KuDPIpuuvvuGKfZqakLVcpgvfos8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/edl9fF69BfkxahyjN8dsuQFHj0b8sXsdojKU5njGuLEGH1j2yNPtBFXfc7dyafOMfzCqcpUFNIYqfiDWTYaOfOBfiAUwzNw+/k4P2IYcJWlL4Gnfszbur2taPQphq+hiK+e+27Vx6k2A0CW3+j6Sia+7CY2CUDtg5lWbWmce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4tFQcBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5476C4CECD;
	Wed,  6 Nov 2024 09:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730887094;
	bh=v8MGY8fIOjiRO62KuDPIpuuvvuGKfZqakLVcpgvfos8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J4tFQcBGImd7zjqBscyrbJmQyZBmDm9vp/5LyzdgUxK5hLHXwadxt/fGg1M0w1thZ
	 ns/NmF1+evjJkaVRvI+uYAimqkHX6aFthvTl8HBxQax5BzZ5Wt0DUrHW5zHo6L3xvw
	 bCnIf+/icPcrnEwWCUUZNydB4wfi46a7ogvDGh/I5MQLPEojIOa61UA3q/4IVUUpci
	 mdWk7nPrNxJM81fnmeWHCNjlTJc9wlUcI8fw+pULFZCY/ZX3pOM/fUR1Ru85+LcSLe
	 oNs5TnnQRGHKVXekvT1M82Pmel82WAfV6IyoFb2cXrI7qiTkvw4ehENVta550zPMOG
	 JnPo4UTF8Zv2g==
Date: Wed, 6 Nov 2024 09:58:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/5] ad7380: add adaq4370-4 and adaq4380-4 support
Message-ID: <20241106095805.0a3c49ef@jic23-huawei>
In-Reply-To: <20241102153718.6d12295e@jic23-huawei>
References: <20241030-ad7380-add-adaq4380-4-support-v4-0-864ff02babae@baylibre.com>
	<78073c49-899a-4646-a834-6d5006d59501@baylibre.com>
	<20241102153718.6d12295e@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Nov 2024 15:37:18 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 30 Oct 2024 09:32:23 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 10/30/24 8:44 AM, Julien Stephan wrote: =20
> > > Hello,
> > >=20
> > > This series add support for adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS)
> > > which are quad-channel precision data acquisition signal chain =CE=BC=
Module
> > > solutions compatible with the ad738x family, with the following diffe=
rences:
> > >    =20
> > Reviewed-by: David Lechner <dlechner@baylibre.com> =20
>=20
> FWIW, this looks fine to me and I can tweak the voltage in the docs whilst
> applying.  I'm stalled on merging this series by the fix dependency worki=
ng
> it's way into upstream.=20
Applied.  I tweaked that voltage in the docs to 3.3V as per David's feedbac=
k.

Pushed out as testing to give 0-day a brief look.

Note I merged rc6 to get the fix this was dependent on.

>=20
> Thanks,
>=20
> Jonathan
>=20
> >  =20
>=20
>=20


