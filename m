Return-Path: <linux-iio+bounces-574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85126803467
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 14:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DC9B20AD6
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 13:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7D24B3C;
	Mon,  4 Dec 2023 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lusMszvt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BAE2207D;
	Mon,  4 Dec 2023 13:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508F4C433C7;
	Mon,  4 Dec 2023 13:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701696077;
	bh=og9sXh9fou+NX+Bifv3X2abKGE4BOOuoOZUaxM9idpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lusMszvt6XaQO9ZkC10D8tXjZBj+MgSBGuZYVve+u30P7IEzp3+xCQy/fHFAjiba9
	 9Rdj53LnWPqR3m31fn39dErrJaEGTZICY78dFlCs+MzC495mXhCez8UuWf8JuieqSm
	 ZxGOEi+o6UYQB3w3kDkbr97BJ/FWLeu2ovhvWXRKZ17QrzAc6C0IdGwu6YUpmVY0nq
	 RqYUgTV9qW2ai2ZcEUafQrbnkankogCKORehXZo0rIYStMvZeifS2+gO86/+Bpfytc
	 r+1rfpzO809o6zgDR4UgGeyC62B6KOBMBbAvMcT0+/Xy94TZXg2KrMWiUjwEoAvkaa
	 Hoh2BKBGSGQFw==
Date: Mon, 4 Dec 2023 13:21:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/2] iio: dac: ad5791: Add support for controlling
 RBUF via devicetree
Message-ID: <20231204132107.3fa75bcc@jic23-huawei>
In-Reply-To: <20231129-ad5791-michael-stuff-v3-0-48e192b00909@analog.com>
References: <20231129-ad5791-michael-stuff-v3-0-48e192b00909@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Nov 2023 14:03:51 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> Simple series to add support for an external amplifier to be connected
> in again of two configuration.
>=20
> v2:
>  * removed .yaml suffix from commit title;
>  * Don't use commit/patch in commit message.
>=20
> v3:
>  * Be more imperative in the commit message.
Hi Nuno, Michael,

I don't suppose you fancy also ripping out the platform data support as a f=
ollow up
series?  I doubt anyone cares about it any more and it would be nice to cle=
an
that up given you are making changes to the driver.

Applied to the togreg branch of iio.git and pushed out as testing for all t=
he normal
reasons.

Thanks,

Jonathan

>=20
> ---
> Michael Hennerich (2):
>       dt-bindings: adi,ad5791: Add support for controlling RBUF
>       iio: dac: ad5791: Add support for controlling RBUF via devicetree
>=20
>  Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 5 +++++
>  drivers/iio/dac/ad5791.c                                  | 9 ++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


