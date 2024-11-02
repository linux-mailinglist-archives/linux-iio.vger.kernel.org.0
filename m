Return-Path: <linux-iio+bounces-11850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1339BA145
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D661C20D06
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787891A0BE1;
	Sat,  2 Nov 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrgxVF67"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B68D433B9;
	Sat,  2 Nov 2024 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561848; cv=none; b=CyRYEtcAZyulisbrbodsPfceNnO/I8DkhXRQe7AKn6mtMtv16cQ5V9bHc6Ah0rkLnbsH5dZp7KGhVbgFx2yN6CWRvXei2wiPWLRso13blfJizqisb8U5/S3mtiCWHZcgJJwqXkp+/QI6CamFzBggWMiV/N6PVPOuELQOivS4XZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561848; c=relaxed/simple;
	bh=y4HIF/v1R+URt/KUSeF/i8MxNK8ybhm+h85nTRc+ivY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdKRVYg0Rn0RXeSwFFjNQA6MiF9scK5SBmNiirZrriqXXi2zK/pKECqeC7SnxWiaB931NLLzPGPnxrhb4LKXgJdv23y82GA+RVn8SQbWuOf616t2qSfUeBwVc5gKTfvjKjbfuhW7C7+9j67tIlwU30V3wL1rEk0K1xEBgZn6gqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrgxVF67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3609C4CEC3;
	Sat,  2 Nov 2024 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730561846;
	bh=y4HIF/v1R+URt/KUSeF/i8MxNK8ybhm+h85nTRc+ivY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hrgxVF67fuPP2897pEiPpK6JyOjLWBDvAe9kLrBWrFYg0zn0RWdx7Sn4Ha8k6hJis
	 IQ8xfvcYaBriJ+piVP1oGhLs+6Uavwubvby2PLxleXGnA+P6wpAF9NQ8maogWoFVER
	 Iq/NpFzY4WLPpLtF20Apxt9DkviLyIOuzPoMJ4nSCG10xnXJmKLJfHpxwOfBsw9ZHd
	 rwxKH4v6qbcCTIRtkd82nUZYTBtaF2X3R6DG+ed4tmky0HIGj1es2bJ/bLFDf40Yfm
	 AaGBvEGPqdnBpv/DgEBFFc2VGdRHyqWW9Vyo7LJnw+HX4z0g1XQMixJUleYoUgbyjF
	 hPIbFAGnNAYzQ==
Date: Sat, 2 Nov 2024 15:37:18 +0000
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
Message-ID: <20241102153718.6d12295e@jic23-huawei>
In-Reply-To: <78073c49-899a-4646-a834-6d5006d59501@baylibre.com>
References: <20241030-ad7380-add-adaq4380-4-support-v4-0-864ff02babae@baylibre.com>
	<78073c49-899a-4646-a834-6d5006d59501@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Oct 2024 09:32:23 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/30/24 8:44 AM, Julien Stephan wrote:
> > Hello,
> >=20
> > This series add support for adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS)
> > which are quad-channel precision data acquisition signal chain =CE=BCMo=
dule
> > solutions compatible with the ad738x family, with the following differe=
nces:
> >  =20
> Reviewed-by: David Lechner <dlechner@baylibre.com>

FWIW, this looks fine to me and I can tweak the voltage in the docs whilst
applying.  I'm stalled on merging this series by the fix dependency working
it's way into upstream.=20

Thanks,

Jonathan

>=20


