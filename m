Return-Path: <linux-iio+bounces-24986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3D3BD0850
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0213AE0A5
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681DB2ECD26;
	Sun, 12 Oct 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD//PR7z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E5C2772D;
	Sun, 12 Oct 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760289057; cv=none; b=JERnWFUNCC5r3WFHN/ZrhkUnsmn+NrgEDDCFRz6+ha5DNfd8P3GV+oeYsJ2nJbBfHxbGgF2F1yMbZs7j9kNc/CWTQ17G2I14FA3M1TKu/lfeL9aCv1Zm7erZw0xZZkq15/IIc1W/3Me+CvdUdGsa6ZD+1yOOyP+GtCJFlPg0Bno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760289057; c=relaxed/simple;
	bh=utBef4wbtBn4WomwxLfDwTowUkRZAmTSDksWDhDip/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gW2GDrXxlZdgLzpyGhhnYAU8A9AGo6MhJHCOD5gGvbPji9c+dqepcFwb/HRGFsZESBEmIHbZ7TwB3LiLNiNT0KL1aJVZOLzfOfIvB/G3KhXObItMRoMCeBYHOEw4DxtGPMsmsih5eKZc4Ypd67SzCSjT6ewVkhWxsQrru+6SxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD//PR7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6F1C4CEE7;
	Sun, 12 Oct 2025 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760289056;
	bh=utBef4wbtBn4WomwxLfDwTowUkRZAmTSDksWDhDip/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YD//PR7zObHa3TwUZrfBX9IeNrJDFWZGjMcSwo8n8LNYwBMZZ7oWPQyM7jIPRif31
	 qrreEOLLIafoLuujojamo+q4alGVkstEvkTQQGp3MjB0K0DwbHPUrap6+v9OrFBP77
	 rRQxZp9oZlf9x5/8uC0RVhc3L/QGSRSxP/9fxJuAawgsm6b3fIg3I/1tnKXcGkF0Cc
	 FXG+K2J2aRnQeWCN6RsU7iUnbqdRJQErOptiN4J/nT1KyZGYSInUA9loMAIeTWdiVo
	 BjetEDda15/wv3USgH5QG9pXKnysLYGcmLnEGwafQJOYthTpLgmpTl62C76rvJyIBS
	 bHDPo7Wgq83Vw==
Date: Sun, 12 Oct 2025 18:10:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt1@gmail.com, gregkh@linuxfoundation.org,
 viro@zeniv.linux.org.uk, peterz@infradead.org, jstephan@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 vikash.bansal@nxp.com, priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: temperature: Add NXP P3T175x
 support
Message-ID: <20251012181043.510976c8@jic23-huawei>
In-Reply-To: <20251008100713.1198461-2-lakshay.piplani@nxp.com>
References: <20251008100713.1198461-1-lakshay.piplani@nxp.com>
	<20251008100713.1198461-2-lakshay.piplani@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  8 Oct 2025 15:37:12 +0530
Lakshay Piplani <lakshay.piplani@nxp.com> wrote:

> Add bindings for the NXP P3T175x (P3T1750/P3T1755) temperature
> sensor, supporting both I2C & I3C interfaces.
>=20
> The P3T1750 and P3T1755 are functionally equivalent temperature
> sensors with identical interfaces and features. The P3T1755 offers
> improved accuracy(=C2=B10.5=C2=B0C) in the =E2=80=9320=C2=B0C to +85=C2=
=B0C range, while both
> maintain =C2=B11=C2=B0C accuracy across =E2=80=9340=C2=B0C to +125=C2=B0C.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> ---
> V3 -> V4: Changes since V3:
> 	  - Updated commit message to clarify the difference between P3T1750 and=
 P3T1755.
> V2 -> V3: Changes since V2:
>           - Removed nxp,interrupt-mode and nxp,fault-queue properties fro=
m DT binding
>           - Updated compatible strings:
>             - nxp,p3t1750-iio =E2=86=92 nxp,p3t1750dp
>             - nxp,p3t1755-iio =E2=86=92 nxp,p3t1755dp
> V1 -> V2: Changes since V1:
>           - Dropped nxp,alert-active-high
>           - Fixed YAML formatting, line wrapping, and examples
>=20
>  .../bindings/iio/temperature/nxp,p3t1755.yaml | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/nxp=
,p3t1755.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/nxp,p3t175=
5.yaml b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> new file mode 100644
> index 000000000000..16a01fa81251
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/nxp,p3t1755.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP P3T175xDP Temperature Sensor
> +
> +maintainers:
> +  - Lakshay Piplani <lakshay.piplani@nxp.com>
> +
> +description: |
> +  Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1755.pdf
> +
> +  P3T175xDP (P3T1750/P3T1755) is a digital temperature sensor with a ran=
ge of
> +  -40=C2=B0C to +125=C2=B0C and a 12-bit resolution. It supports communi=
cation over both
> +  I2C and I3C interfaces.
> +
> +  The I2C interface supports up to 32 static addresses and provides an A=
LERT
> +  output to signal when temperature thresholds are crossed.
> +
> +  The I3C interface supports In-Band interrupts (IBI) in interrupt mode,
> +  allowing the device to notify the controller of threshold events witho=
ut
> +  dedicated alert pin.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,p3t1750dp
> +      - nxp,p3t1755dp
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      In I2C mode, the device supports up to 32 static addresses.
> +      In I3C mode, the 'reg' property encodes a triplet of
> +      <static-address BCR PID> used for device matching.
> +      Static address is optional if matching is done via PID.
> +
Aim for completeness of description.  This sensor needs power so
there should be a regulator.  As power must be connected convention
is to make that required as well.  That doesn't necessarily mean
specific dts can't rely on fallback 'fake' regulators that get created
by Linux when one is requested that we haven't provided in DT though.

For driver side just use devm_regulator_get_enabled() and forget about it
after that.


> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        temp-sensor@48 {
> +            compatible =3D "nxp,p3t1755dp";
> +            reg =3D <0x48>;
> +            interrupt-parent =3D <&gpio2>;
> +            interrupts =3D <3 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };


