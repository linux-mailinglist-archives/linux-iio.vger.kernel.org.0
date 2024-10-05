Return-Path: <linux-iio+bounces-10191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3919918CB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F6B1F22318
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE4158D79;
	Sat,  5 Oct 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gY0w0qb7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC41F1B813;
	Sat,  5 Oct 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728148941; cv=none; b=BK29aeazLj1fVt4klJG3dS49usbgvmBqHdRkwSw/Sni2E5K2zGXCj4Go7ltSbFX+UWifhrAMuRLXnMyQoYnlsac98nH2YoyTc9bTExbbec4srJPA/DCd99t3bzwFJq3pTbsmUdzqk1Fdy4yi/sV9tfhFj3Ke0hSTEsWwmAcztZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728148941; c=relaxed/simple;
	bh=cZQhzQ8xqo318yu/emtXtLqZ5fEjjQ6rdT9qdr7KDQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVsXla6z1fhR3GF2iEqQik+7+UF9cXpI9aKKfpRozUwQ2MD5tO+MtslEQ0kxsRANVPxz6bGxLkiZDpfJ/UeDzrM0j6QWAKFbirHpm34izASuQEGzd0TtiesDTwTLWEpIr++Hc/yMsN7dCYKZ8mLEKmXLcFNl4fCWgJf4wgqNj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gY0w0qb7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52539C4AF09;
	Sat,  5 Oct 2024 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728148940;
	bh=cZQhzQ8xqo318yu/emtXtLqZ5fEjjQ6rdT9qdr7KDQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gY0w0qb7uHsjmUHlSejBR9QaLw35BUTl+N7CfS2cznG9/0BxTLvksIukMRJ4T0Qvo
	 c5aUsy0Nb1XaXNAyKbE27o3hO0lxxMT5SpxWwuSR5R7Ns9asDZ8f/q7acMBgjOD765
	 N33u8romM73cV/VJH9StiZckN6WFA0P1cmQ8/RM2bzj9gsd1v/4gKcQSOe32NEFwnU
	 sYVIs/Tn3jTkBHgC/OHBSXmk4+CI7XIDZ6Jlr9EQnKdX+zMBlDru2BFdLtmvQYWEjL
	 05E7tc+2Rm+LdjwlXOvKfwWfuRbzUI4ktKgLWE5aU1AhXLMnXM/jI5Xdswvo/900LZ
	 rVYwlcxTquslA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso43387771fa.1;
        Sat, 05 Oct 2024 10:22:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwof//2taoFWE/8titOPTaA7JxWziI2JUcae/JtrHgzYovQsaMZpe5BVTKDU+/AW/3jpTotZR+Nz+g@vger.kernel.org, AJvYcCWgfuPj9f/GsNa079QSb9hAIDm1ulCWet9DlL0/7LgZhtyAxYRJ9pmytkJbhyBgeWb1b/EFGJGJYwBvyR3+@vger.kernel.org, AJvYcCX4yiD8yOBEW+uFH+oh+qdBguK3TICy7nA6xBUIAOkqOkzAr0oiMilG5vNR77T7qVRrm6xNxW3x7ewE@vger.kernel.org
X-Gm-Message-State: AOJu0Yya5nACMwSeBwQSwpLTLB1A0M9t7P/21CbFqNdVzd8UWSV3k9Jh
	ejVbAynQpnHbZ4+ffw24KMgp/PaQBkbViyQlfFcA7+3CFqFhTBYuS4DcGNPKGj0BMc6nIrBNQ8c
	NLlhA+cxYhN9tz83StpkEjewZkw==
X-Google-Smtp-Source: AGHT+IEkIALnm4TU9C7kUuAvqgFDGfN6VVJD5C+uOtNSWQooIat8FYeM2U9J7vVeXnj98GXOlvgCFtzDj41ASUeVOhE=
X-Received: by 2002:a05:6512:3b09:b0:533:4785:82ab with SMTP id
 2adb3069b0e04-539ab84df7amr5417854e87.1.1728148938658; Sat, 05 Oct 2024
 10:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
 <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-3-ceb157487329@baylibre.com>
 <172799847830.1778120.2943655597402379925.robh@kernel.org>
 <744n6dut2ayboh6gilavqy65bgljmu5sz5embvtxcq5v4fhp3f@pfud6d2hiplo> <8faf440b-2ea0-45f3-aa87-db303dc8d6fe@baylibre.com>
In-Reply-To: <8faf440b-2ea0-45f3-aa87-db303dc8d6fe@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Sat, 5 Oct 2024 12:22:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ0QNkd+nre14d-OpsB3BQdx1oq7dFKC2cHwO3+ab3J3w@mail.gmail.com>
Message-ID: <CAL_JsqJ0QNkd+nre14d-OpsB3BQdx1oq7dFKC2cHwO3+ab3J3w@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	Mihail Chindris <mihail.chindris@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 8:26=E2=80=AFAM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On 10/4/24 2:33 AM, Angelo Dureghello wrote:
> > Hi Rob,
> >
> > On 03.10.2024 18:34, Rob Herring (Arm) wrote:
> >>
> >> On Thu, 03 Oct 2024 19:29:00 +0200, Angelo Dureghello wrote:
> >>> From: Angelo Dureghello <adureghello@baylibre.com>
> >>>
> >>> Add a new compatible and related bindigns for the fpga-based
> >>> "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> >>>
> >>> The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> >>> generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> >>> mainly to reach high speed transfer rates using a QSPI DDR
> >>> (dobule-data-rate) interface.
> >>>
> >>> The ad3552r device is defined as a child of the AXI DAC, that in
> >>> this case is acting as an SPI controller.
> >>>
> >>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> >>> ---
> >>>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 49 ++++++++++++=
+++++++++-
> >>>  1 file changed, 48 insertions(+), 1 deletion(-)
> >>>
> >>
> >> My bot found errors running 'make dt_binding_check' on your patch:
> >>
> >> yamllint warnings/errors:
> >>
> >> dtschema/dtc warnings/errors:
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/iio/dac/adi,axi-dac.example.dtb: dac@0: spi-max-frequency: 66000000 is gr=
eater than the maximum of 30000000
> >>      from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552=
r.yaml#
>
> I think this error is just due to patch ordering. The patch
> "dt-bindings: iio: dac: ad3552r: fix maximum spi speed"
> should come before this one. (In general, it is always best
> to put fixes first anyway.)
>
> >> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/iio/dac/adi,axi-dac.example.dtb: dac@0: 'io-backends' does not match any =
of the regexes: '^channel@([0-1])$', 'pinctrl-[0-9]+'
>
> I've seen this pinctrl error pop up a few other times.
> I don't really understand it since none of the bindings
> involved reference pinctrl. Maybe an issue in the tooling?

pinctrl properties are allowed on any node and so the tools add the
property pattern to the schemas. If that wasn't the case, then it
would be the same error, but just list the channel regex. Perhaps not
all that useful to list regex's that don't match. In any case, the
error is simply that io-backends is not defined as a property.

Rob

