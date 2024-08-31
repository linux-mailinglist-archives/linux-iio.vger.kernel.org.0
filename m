Return-Path: <linux-iio+bounces-8910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D0E96715A
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 13:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95181C2143E
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94C17DFFD;
	Sat, 31 Aug 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFYeiGEV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152B6A8CF;
	Sat, 31 Aug 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725104326; cv=none; b=CBVltLUk3cW4zeR4+tJDzmVDyTUTBXFEl9ncTgFmXJo+a6lozz/Xek6ib51aaZjNTFCHYZsncuLrgWPbMxnyytwFPnw32VScDzGpcWEVSfTETcbfkV2jyrzjy3swXlEU1xtotJ1w+3k0Q0+z2T9HyJ2Yo7keTvOQokV1+QrDA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725104326; c=relaxed/simple;
	bh=26XxgTbdOhTuCSD4I9b4ByqUILFzK3wcbjqL8EuM6gE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzRx0i2fGdxFILH+n9nox9rrdyLQs6YleAWuV+tZ7BnaMh9uE0LbFRPkC8/b/+nCfzrg491I1czhQR3ARhsj+HzH05MCtSbO65yNfU/qWonF/3jUbdzrVmlocqBY48eQ+WObS1qt/mfqo9eU6r9+xiERHzu8IgRiGvS79dXnZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFYeiGEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD656C4CEC0;
	Sat, 31 Aug 2024 11:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725104326;
	bh=26XxgTbdOhTuCSD4I9b4ByqUILFzK3wcbjqL8EuM6gE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RFYeiGEVSAqhiaBzzTBp/EqS4UZZC+5ZDB0Fb7o9UR1b9mLVzw0adrWVQkE5j+WcN
	 7Rn/k/p6WYZWv3NuoZr5AItEKO+zeBPm0fbLZOZuTftz0osl0HUCnbPbLZYa8EQ9Az
	 zbdHhFqJhLfpyjHMO3XrVAzyE42wmCMQHvL7rl8AKX944pAOLN3OaqdhdpynWSQtbE
	 QyKyLQsWiAswVKacrGmcABvt2Vf408qg7/wgFGS7SgMLhUDGC2c/xxA31HkirRA8Cp
	 6Peepq2PwJVzv/ZxEitP3KTNDXev2yC0faMq+u2Xk3b11dwK7Si+esgOPSlMc8egaf
	 eDiDba09LaSUQ==
Date: Sat, 31 Aug 2024 12:38:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [RFC PATCH 0/8] iio: dac: introducing ad3552r-axi
Message-ID: <20240831123837.26a1070a@jic23-huawei>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 14:31:58 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi, asking for comments for this patchset, that is mostly=20
> ready, at least feature-complete and functionally tested.
>=20
> I am introducing ad3552r-axi variant, controlled from a fpga-based
> AXI IP, as a platform driver, using the DAC backend. The patchset is
> actually based on linux-iio, since some needed DAC backend features
> was already there on that repo only, still to be merged in mainline.
>=20
> Comments i would like to ask are:
>=20
> - i added some devicetree bindings inside current ad3552r yaml,
>   device is the same, so i wouldn't create a different yaml file.=20

Agreed. If same device, it's usually better to keep it in one file.

>=20
> - if it's ok adding the bus-type property in the DAC backend:
>   actually, this platform driver uses a 4 lanes parallel bus, plus
>   a clock line, similar to a qspi. This to read an write registers
>   and as well to send samples at double data rate. Other DAC may=20
>   need "parallel" or "lvds" in the future.

If it is for register read + write as well, sounds to me like you need
to treat this as a new bus type, possibly then combined with a
backend, or something similar to spi offload?

What bus does this currently sit on in your DT bindings?
(add an example)

>=20
> - adding the bus-type property vs. a boolean property vs. adding=20
>   a new compatible string.
>=20
> - how external synchronization should be handled. Actually, i added
>   2 backend calls to enable or disable this external trigger.

That seems more or less fine.  Is there any control over the external
trigger?  This feels a bit like some of the complex stm32 hardware
triggers in that a 'hidden' trigger is being enabled.
If it is controllable or selectable (between say a PWM or an external
pin) then you may need to be careful how to expose that control.

>=20
> - is a read-only sampling-frequency useful ?
Yes. If it is easy to provide, it can be useful to userspace to
allow it to figure out how much data to expect.

Jonathan

>=20
> Thanks a lot for your feedbacks.
>=20
> To: Lars-Peter Clausen <lars@metafoo.de>
> To: Michael Hennerich <Michael.Hennerich@analog.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Jonathan Cameron <jic23@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: dlechner@baylibre.com
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> Angelo Dureghello (8):
>       dt-bindings: iio: dac: ad3552r: add io-backend property
>       iio: backend: extend features
>       iio: backend adi-axi-dac: backend features
>       dt-bindings: iio: dac: add adi axi-dac bus property
>       iio: dac: ad3552r: changes to use FIELD_PREP
>       iio: dac: ad3552r: extract common code (no changes in behavior inte=
nded)
>       iio: dac: ad3552r: add axi platform driver
>       iio: ABI: add DAC sysfs synchronous_mode parameter
>=20
>  Documentation/ABI/testing/sysfs-bus-iio-dac        |   7 +
>  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |  39 +-
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |   9 +
>  drivers/iio/dac/Kconfig                            |  11 +
>  drivers/iio/dac/Makefile                           |   3 +-
>  drivers/iio/dac/ad3552r-axi.c                      | 572 +++++++++++++++=
++++++
>  drivers/iio/dac/ad3552r-common.c                   | 163 ++++++
>  drivers/iio/dac/ad3552r.c                          | 394 +++-----------
>  drivers/iio/dac/ad3552r.h                          | 199 +++++++
>  drivers/iio/dac/adi-axi-dac.c                      | 250 ++++++++-
>  drivers/iio/industrialio-backend.c                 | 151 ++++++
>  include/linux/iio/backend.h                        |  24 +
>  12 files changed, 1494 insertions(+), 328 deletions(-)
> ---
> base-commit: 7ccb2c2db44572deadb795c4637273cdabbe8b66
> change-id: 20240829-wip-bl-ad3552r-axi-v0-b1e379c986d3
>=20
> Best regards,


