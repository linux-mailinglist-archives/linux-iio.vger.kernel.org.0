Return-Path: <linux-iio+bounces-17308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B24A745EB
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 10:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F05117BE5C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6293020E00B;
	Fri, 28 Mar 2025 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCadBRgK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44817BA3;
	Fri, 28 Mar 2025 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743152630; cv=none; b=d/4JsMI7SuaDLzgmvsa8x/xPTyl3SefJWkjVL1yK1v0aOb55eRLgw86JnhEkZudb+DN6qPkiV8ULTxSq6skcOpHKnszLoNJoCIkUlmrCNp80Ww+moZ8rsezkGgLkcirO8nALljt/wcFw39mvftU459SDTmTNQszobEJVMQXoA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743152630; c=relaxed/simple;
	bh=aEDTsF6b80LpwVYP24qiQyXcymUJFu9eUwvRwQIaX5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9uYtQGrP9lYpG8giZKhWh1fNzHRvXBJcwJt/VVZTLbsRvgFDlEg55o1cJar10C2SdUcp5VoDjizHM0dnijW479HbpKB1t32GcBWnfPum6eOcSRZb/hhhHYNdP27cOqfmYDP16e5+Gbazr4DnG5pfKX+GkN00S0lzJdrc1xigL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCadBRgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9E0C4CEE4;
	Fri, 28 Mar 2025 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743152629;
	bh=aEDTsF6b80LpwVYP24qiQyXcymUJFu9eUwvRwQIaX5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GCadBRgKBIjyrRC8okT6tF/E7f1Jt3GyBDoWiJu5caOuVQTdPsaMt54uFveu40tN3
	 V/2/y5EiGp7TxffWc4MbPuG0Hmy94db1jYeRSYJsoUph2dIWdpf5NZjIv5Mbt6rm0D
	 rUDNrVaf2ECYtGfqCaq5ZVRhc8eezzwAqgSkY5pseS31H9ccJn4Pr8bu1pDFF5EgL3
	 YbdAgasWRZ9Uw2tvBJD6T8vsSLjxuxlGv5fb3R6K2jWlOVeV819qLTYujqllgtBpgj
	 SBDKNu3XWtzE6XaGVLkTNNhRW5dHEITOPA8woTtMTr4LJuU5GrhgPrvyt8E4S+1TPr
	 bXfTb0sKsYM+A==
Date: Fri, 28 Mar 2025 09:03:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Message-ID: <20250328090341.0d213f3d@jic23-huawei>
In-Reply-To: <20250324-togreg-v2-3-f211d781923e@analog.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
	<20250324-togreg-v2-3-f211d781923e@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Mar 2025 19:22:57 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Document the AD3530R/AD3530, an 8-Channel, 16-bit Voltage Output DAC,
> while the AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC.
> These devices include software-programmable gain controls that provide
> full-scale output spans of 2.5V or 5V for reference voltages of 2.5V.
> They operate from a single supply voltage range of 2.7V to 5.5V and are
> guaranteed to be monotonic by design. Additionally, these devices
> features a 2.5V, 5ppm/=C2=B0C internal reference, which is disabled by de=
fault.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 91 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 92 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..e581472b50048bedda7422748=
035423b9b020382
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad3530r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD3530R and Similar DACs
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  The AD3530/AD3530R are low power, 8-channel, 16-bit, buffered voltage =
output,
> +  digital-to-analog converters (DACs) that include software-programmable=
 gain
> +  controls that result in full-scale output spans of 2.5V or 5V for refe=
rence
> +  voltages of 2.5V. The devices operate from single, 2.7V to 5.5V supply=
 ranges
> +  and are guaranteed monotonic by design. The AD3530R also offers a 2.5V,
> +  5ppm/=C2=B0C internal reference that is disabled by default.
> +  Datasheet can be found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
3530_ad530r.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad3530r

You mention this one as well as a variant without the r postfix in the 'des=
cription'.=20
So why not compatible for that?  If it's software compatible with the r ver=
sion than
a fallback compatible makes sense.  We probably still want to have separate
compatibles though in case we get an errata that only applies to one of the=
m.

If they are the same silicon, perhaps with different ratings then make that=
 clear
in the description and perhaps it is fine to not have both compatibles list=
ed.
=20
> +      - adi,ad3531r

This isn't mentioned in the description text.

> +
> +  reg:
> +    maxItems: 1

Thanks,

Jonathan

