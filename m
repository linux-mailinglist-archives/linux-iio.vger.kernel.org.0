Return-Path: <linux-iio+bounces-8478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA3595227E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 21:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1161F23EDE
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 19:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208EA1BE259;
	Wed, 14 Aug 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD8TtqP3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6CB679;
	Wed, 14 Aug 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723662637; cv=none; b=c13Kq1pHuvylkxutK3zyaDJYFc8iPBBK+RMwn9Tz0GaM2IqPU+AJfbKWZc+nd+3mEeuFHzJej981LTeZUMS3OoTKYSa0N3ihx01zlxmNaFLJlKUdaAocXFWj7ybuY+K4YLMRUckJIn0foNGmKteOTjqoghIFg+HpRs7TeVpzAX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723662637; c=relaxed/simple;
	bh=HZm5ZViVujSwBTW2l5YWdESNtXHh++If2Xp/kAv1ws8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxh7XPSzr0P2tgEn4v+7IfPOqmMddRqXQVProK2w1OhFfxvXA84n33vVLe6gm1vCRCJe8WIJTgD/xtnB3x+FzEo4OzY3XqPyQtO9xw/dzzzBt+q15r8QBzX4c6yXid/MaEAyZNGtPU1ccTHP/vNAi8IAu5LAm1M79KpeNG8qTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD8TtqP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA9FC116B1;
	Wed, 14 Aug 2024 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723662637;
	bh=HZm5ZViVujSwBTW2l5YWdESNtXHh++If2Xp/kAv1ws8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RD8TtqP39IUmkowESt4YC3Ty3+egkb27VM+yMqzHlMiJoq8W3X7QdX07ttomDmrQx
	 l2uAVlLH72KYirL8Ox3nWbZE/KaxddXkQ7kJDD/1wUorRHw0AR7q9FKQ8J/6Yrj+9h
	 xZaJ3vIuaf59Z8ADNQNEHi7oIONppTl+bExF5n4325gIwKBxa4VEod1cvWlJrH9vYP
	 7FKmxKbis6iMO9QadJjPK6lp00YjmdQmlfMReDwyyw9NbGP4C96JOGBbL2yCbqE7Gt
	 rUve/UFUh1aHheFuxQAsPfmyAtSjoQ6xiRKKG0sB9ywCYEuixOvQV2I7KURDB5LfYZ
	 cyDrGmrvH0o/Q==
Date: Wed, 14 Aug 2024 20:10:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>, Chao
 Zeng <chao.zeng@siemens.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add everlight pm16d17 binding
Message-ID: <20240814200946.59bd8435@jic23-huawei>
In-Reply-To: <f6476e06cd8d1cf3aff6563530612c536cd45716.1723527641.git.jan.kiszka@siemens.com>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
	<f6476e06cd8d1cf3aff6563530612c536cd45716.1723527641.git.jan.kiszka@siemens.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Aug 2024 07:40:41 +0200
Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Chao Zeng <chao.zeng@siemens.com>
>=20
> Add the binding document for the everlight pm16d17 sensor.
>=20
> Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
> Co-developed-by: Baocheng Su <baocheng.su@siemens.com>
> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
hi Jan,

=46rom a first read at least, almost everything in here
is stuff we should be controlling from the driver, not
providing as fixed values from firmware.

Specific comments inline.

Jonathan

> ---
>  .../iio/proximity/everlight,pm16d17.yaml      | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/everl=
ight,pm16d17.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/proximity/everlight,pm=
16d17.yaml b/Documentation/devicetree/bindings/iio/proximity/everlight,pm16=
d17.yaml
> new file mode 100644
> index 000000000000..fadc3075181a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/everlight,pm16d17.y=
aml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/everlight,pm16d17.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Everlight PM-16D17 Ambient Light & Proximity Sensor
> +
> +maintainers:
> +  - Chao Zeng <chao.zeng@siemens.com>
> +
> +description: |
> +  This sensor uses standard I2C interface. Interrupt function is not cov=
ered.
> +  Datasheet: https://en.everlight.com/sensor/category-proximity_sensor/d=
igital_proximity_sensor/
> +
> +properties:
> +  compatible:
> +    enum:
> +      - everlight,pm16d17
> +
> +  reg:
> +    maxItems: 1
> +
> +  ps-gain:
> +    description: Receiver gain of proximity sensor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8]
> +    default: 1

This should I think be a userspace control.
Given it's not related to proximity as such, probably=20
in_proximity0_hardwaregain

> +
> +  ps-itime:
> +    description: Conversion time for proximity sensor [ms]
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - "0.4"
> +      - "0.8"
> +      - "1.6"
> +      - "3.2"
> +      - "6.3"
> +      - "12.6"
> +      - "25.2"
> +    default: "0.4"
Definitely a userspace control.  Is this actually integration time
which we'd expect to affect the hardwaregain or is it just
1/ frequency of sampling (with fixed integration time).
Looking at datasheet it's coupled to resolution which may
make this oversampling related. Hard to tell.

> +
> +  ps-wtime:
> +    description: Waiting time for proximity sensor [ms]
I guess the above was the integration time and this sets
the sampling_frequency.  In that case definitely a userspace
thing, doesn't belong in DT.

> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - "12.5"
> +      - "25"
> +      - "50"
> +      - "100"
> +      - "200"
> +      - "400"
> +      - "800"
> +      - "1600"
> +    default: "12.5"
> +
> +  ps-ir-led-pulse-count:
> +    description: IR LED drive pulse count

This needs more information.  Why would this be changed?
Seems from datasheet that this is effectively a different
form of gain. Why would we choose one rather than the other?
Or are they both ways of increasing the overall sensitivity?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 256
> +    default: 1
> +
> +  ps-offset-cancel:
> +    description: |
> +      When PS offset cancel function is enabled, the result of subtracti=
ng any
> +      value specified by the PS offset cancel register from the internal=
 PS
> +      output data is written to the PS output data register.
That sounds like a calibbias userspace control, but more info needed.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    maximum: 65535
> +
As Conor mentioned, need to describe the hardware as fully as possible so i=
nterrupts
and power supplies (even if they are always on for your particular board)

> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        lightsensor: pm16d17@44 {
> +            compatible =3D "everlight,pm16d17";
> +            reg =3D <0x44>;
> +
> +            ps-gain =3D <1>;
> +            ps-itime =3D "0.4";
> +            ps-wtime =3D "12.5";
> +            ps-ir-led-pulse-count =3D <1>;
> +            ps-offset-cancel =3D <280>;
> +        };
> +    };


