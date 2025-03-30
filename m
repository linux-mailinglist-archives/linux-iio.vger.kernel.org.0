Return-Path: <linux-iio+bounces-17349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D802A75AB1
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D313A95C4
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6301D79B1;
	Sun, 30 Mar 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt/hEDQ3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374A4207F;
	Sun, 30 Mar 2025 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743349254; cv=none; b=Aog593xoCMZ08us82r6+NjQtkYNE1ofAE5LUHgjkzikeXgwn+e/kEyh2OttxPY3JncujIhMhe4KKQoHzLlH+AxTtdiIXGycVdHxNhbP70qF4kmC4uXqEEKzRFxEqasTzOSRQnNNZuJhUYrmz1YWCd335vuCYdHDFERIIzVdFRWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743349254; c=relaxed/simple;
	bh=o5SpaTSgYcyYu755v9BC1aVL+t4K3Psl2qRXXbsZIl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHCpSKp4BA4Q/oaPIDtcDtkrxevkTYaAhFzbYjF99iqKhdFAGDR8WwRQ0DRv74oegiG6Gbt6lF8zFfa2olrC58aIXX9Uebe+nrJAof9GA85aDRt8GrTK2iRtC2kLGhKSRKoOMzi33mUNPUy9xWKzHX6wMO/WjNNuR11rlxJsPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt/hEDQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3951DC4CEE5;
	Sun, 30 Mar 2025 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743349253;
	bh=o5SpaTSgYcyYu755v9BC1aVL+t4K3Psl2qRXXbsZIl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pt/hEDQ3T7uoASSHKeq5VFIPYeCRFXiW9HQWb3h72Yybh1rAq8s4kXCyA2Frz+8hR
	 GnCccz+WNE88w3HLkZgrlX2MYUAhWvkWMubAObRk6Pd5irw50UEN2YjVVeNzOHbQuL
	 GVoTufodqJAb6abfp87EaYDm2u8nqSFUt6osyttdU46/Jra1LyQY7PhgtLNWok3VWK
	 whdWpXFabfmtOm7mlDgD9SpjMiadGgAQXqaviPn/BVRybp8Ny3J/h/OGhysT24YEve
	 6Zjm1uUQKYFq0hvJelUg/0+x8O58SQTD9TUVIcIhTbKGJQZKDXn87zmPLe9Pe1Wf+S
	 GSTv/fQxu4Avg==
Date: Sun, 30 Mar 2025 16:40:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, David
 Lechner <dlechner@baylibre.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols <gstols@baylibre.com>, Dumitru
 Ceclan <mitrutzceclan@gmail.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Thomas Bonnefille
 <thomas.bonnefille@bootlin.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] dt-bindings: iio: adc: add ad7405
Message-ID: <20250330164041.2afe195f@jic23-huawei>
In-Reply-To: <20250324090813.2775011-5-pop.ioan-daniel@analog.com>
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
	<20250324090813.2775011-5-pop.ioan-daniel@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 11:07:59 +0200
Pop Ioan Daniel <pop.ioan-daniel@analog.com> wrote:

> Add devicetree bindings for ad7405/adum770x family.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Hi Pop,

One more trivial thing inline.
> ---
>  .../bindings/iio/adc/adi,ad7405.yaml          | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> new file mode 100644
> index 000000000000..e312fa0cdb05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7405.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    adc {
> +       #address-cells = <1>;

Odd alignment going on here. 1 more space I think.

> +        #size-cells = <0>;
> +        compatible = "adi,ad7405";
> +        clocks = <&axi_clk_gen 0>;
> +        vdd1-supply = <&vdd1>;
> +        vdd2-supply = <&vdd2>;
> +        io-backends = <&iio_backend>;
> +    };
> +...
> \ No newline at end of file


