Return-Path: <linux-iio+bounces-8295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B32A9495FE
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B68A1C21D2A
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F646450;
	Tue,  6 Aug 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEJ2BzfM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B473548E1;
	Tue,  6 Aug 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963437; cv=none; b=TPSSzpr6CWM9YLyIwUZTF0G0iQFvujEpVMJPAqwPA60Qxupr0jCsHx8CCbCgcSHgNuArKIW9t3qrnfmuuMpI72tdQouC75ubwGGs8cm3tR+8KXeldpAirE8eQWTPGLhF9znz/6PY2qicilkdkx9r3JeLTkdXvStIE8rDHMvnfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963437; c=relaxed/simple;
	bh=hHPq16rmjF7qpZCyazK2YgxI+CLfMe1lVA2E8+OXKW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxkyopKY7F5JuHlc/WRrErTE07cGJV+tQs5zEnDWJtqx0P4klH6Dh2jMI6tvtBvq2n9jswbbiv4V8kDoEtS0f7XIEBIXNIhhSJA4BmEcTzCYDXY9K1s43HSI9ljbZJRavkcI+NUvEc9orILi7PX0Iesl9Z82wCst4Mye+Bi9Vto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEJ2BzfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A82C32786;
	Tue,  6 Aug 2024 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722963436;
	bh=hHPq16rmjF7qpZCyazK2YgxI+CLfMe1lVA2E8+OXKW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mEJ2BzfM1hqzVMjRH58L22TIWZLLkn6WFWzvp+vvePVZSlKzjnbJtIcT8DHncN/LQ
	 whYRJffXlwKJ1uCurFuhUpr8UhCqS6T/GpUWWnvOUwLMXfevOTxrjigZnegrqRMsQK
	 pblaI/48lNNnwr7NPHfYGY7TqerAXXqySyWtjxs7lJX4WGpbqGf8gmeJExjlyWVYHu
	 XOaaDtGdMGNrD8tbqn1Kbzk1tzJyM08Ke+QZWEmfCX7htC/aSbhMaBuvAeDPZRY78U
	 wo2ApxO89lIN8/eunHn8xC3eYOiuHjqTOOcaj7n+60a/YXT8jqVg4O1ThzXpA9zVyg
	 DVojAVpSmDk5Q==
Date: Tue, 6 Aug 2024 17:57:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH RFC 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
Message-ID: <20240806175706.5ee7602c@jic23-huawei>
In-Reply-To: <46be10c0-7ee9-489b-afc9-0e0411200d7e@baylibre.com>
References: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
	<20240731-ad7625_r1-v1-1-a1efef5a2ab9@baylibre.com>
	<20240803153540.17627489@jic23-huawei>
	<46be10c0-7ee9-489b-afc9-0e0411200d7e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024 09:17:45 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Hello,
>=20
> On 2024-08-03 10:35 a.m., Jonathan Cameron wrote:
> > On Wed, 31 Jul 2024 09:48:03 -0400
> > Trevor Gamblin <tgamblin@baylibre.com> wrote:
> > =20
> >> This adds a binding specification for the Analog Devices Inc. AD7625,
> >> AD7626, AD7960, and AD7961 ADCs. =20
> > Given the RFC question is effectively about the binding and may influen=
ce
> > it a lot - make sure it's talked about here!
> > =20
> >> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> >> ---
> >>   .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 +++++++++++=
++++++++++
> >>   MAINTAINERS                                        |   9 ++
> >>   2 files changed, 185 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml=
 b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
> >> new file mode 100644
> >> index 000000000000..e88db0ac2534
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
> >> @@ -0,0 +1,176 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7625.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Analog Devices Fast PulSAR Analog to Digital Converters
> >> +
> >> +maintainers:
> >> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> >> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> >> +
> >> +description: |
> >> +  A family of single channel differential analog to digital converters
> >> +  in a LFCSP package. Note that these bindings are for the device when
> >> +  used with the PulSAR LVDS project:
> >> +  http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.ht=
ml. =20
> > As per the discussion in the cover letter I think the need to represent
> > if the DCO+ is connected between ADC and LVDS converter strongly sugges=
ts
> > we shouldn't represent it as one aggregate device. =20
>=20
> Just to be sure, do you mean that the PulSAR LVDS functionality should=20
> be split into its own driver and then utilized by ad7625?

I think we'd need that just to provide a 'hook' to describe the wiring.
That driver probably won't do anything other than give that information.

I'm not quite sure how it would all fit together though. Would need
some experimentation to figure out. I can't immediately think of
another bus with optional wires like this.  Anyone else have a suggestion
on where to look?

Jonathan


