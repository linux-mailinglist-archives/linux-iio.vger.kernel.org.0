Return-Path: <linux-iio+bounces-7383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F7E929350
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 13:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154F11F22556
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 11:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5996F068;
	Sat,  6 Jul 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM8BaGqr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AF14D8C6;
	Sat,  6 Jul 2024 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720265423; cv=none; b=RsQgodnvsCD9yGJJW5kf/kpwLr8aS8LQqdpDHb+GrZn1zpyQW4uZn21wVd93BKq2UpXtihWJxOkB6NmN5t/H0S1p7ypr7TeNB8gQh/oQppBfDFQySnp6miRDayxht3l5IrP6H5ZNq6rSdfqSDDishm8cUGJkqqWr/IXY+/xF74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720265423; c=relaxed/simple;
	bh=Z4AeZKWmkQhMBOSZOPdL0EbnZ1M1sFXNHwni+p1WO50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rm4Jd6IfnBCJOU2BM7tpHFb70ElsiE2AU6mwI/4Q7KsVpe2cqn66bMNZyeTEGTk8PcToadQxuO8qTFtZQRS0efzVAVly0YNog/haQU+KFr46ereQUyRT309vyhF4EapmL1jz2zirzgrZQSewbkmafzib/8b4qTyRrO17ujLFkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM8BaGqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5F9C2BD10;
	Sat,  6 Jul 2024 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720265423;
	bh=Z4AeZKWmkQhMBOSZOPdL0EbnZ1M1sFXNHwni+p1WO50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kM8BaGqrldOAZoySYjckRgcQWQNNjxkXQeRtfERi9fhmQlACWVGe7s9fv549jQNeT
	 PRV1yKrzR8cjktX5O6+jMxPQiBg6kKjESMoxi8qXMxuDIZ4DF36M1CfVcB85tH4Una
	 Db6NqROXKu4mrWiPEm5sQPDK/xIgFV6qDyNCvHE26acb7unxRboQcJo0c7jvfk5jht
	 1v72NrhV3MBZZLNwE++k2IDhJS6BQpavK0qbVyBHluvhX+kLA3rAFu2HrFHpDWyg6v
	 QayQoFeHlVWZPlRDoeb2ypFP3xPa3M7YodswZ/XvpB7mFkQr9dAVlDTtNa4bG7o3sy
	 uR+y6KiZLsxBQ==
Date: Sat, 6 Jul 2024 12:30:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Subject: Re: [PATCH 0/5] iio: adc: ad9467: support new devices
Message-ID: <20240706123017.0d6e68b8@jic23-huawei>
In-Reply-To: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
References: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jul 2024 11:25:20 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> This series adds support for more devices:
>  * Analog Devices AD9652 16-bit 310 MSPS ADC;
>  * Analog Devices AD9643 14-Bit, 170/210/250 MSPS ADC;
>  * Analog Devices AD9649 14-bit 20/40/65/80 MSPS ADC.
>=20
> The first pacthes are just in preparation to make adding the new devices
patches..
> straightforward.

Applied with the minor tweak mentioned in thread to patch 3.

Applied for now to the testing branch of iio.git which I'll rebase and
push out as togreg after 6.11-rc1 is available.

Thanks,

Jonathan

>=20
> ---
> Nuno Sa (5):
>       iio: adc: ad9467: support multiple channels calibration
>       iio: adc: ad9467: add new chip_info variables
>       iio: adc: ad9467: don't allow reading vref if not available
>       dt-bindings: adc: ad9467: support new parts
>       iio: adc: ad9467: support new parts
>=20
>  .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   3 +
>  drivers/iio/adc/ad9467.c                           | 277 +++++++++++++++=
+-----
>  2 files changed, 224 insertions(+), 56 deletions(-)
> ---
> base-commit: 7db8a847f98caae68c70bdab9ba92d1af38e5656
> change-id: 20240620-dev-iio-ad9467-new-devs-f30e5536220f
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20


