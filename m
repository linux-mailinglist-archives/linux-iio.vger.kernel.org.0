Return-Path: <linux-iio+bounces-23545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024EBB3D444
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 18:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857993B8A66
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9801FECD4;
	Sun, 31 Aug 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7sc1cCI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056A5464E;
	Sun, 31 Aug 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756656102; cv=none; b=H8C5ZiF7MG6KpauYx4rA7PLft9NTaMJg7qKkbRJc9x/gZ8UGrfVDsgS1iIdv8ofRz57IJW6NFJkhyu5kdmUkOOXuYmd4n5XlxjZD9MAFGXd8N6ok/LZpYrPd7bnA3iHJp8NCIWDlRpXmNF6cdymRR+IbKsTmYuuYPIRAA7MrKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756656102; c=relaxed/simple;
	bh=2gNH/RzO1V0JsfglSgx1jzUzgMbIO9CB7CQt5QHDaiE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5OpkdSkc8tjkQXdmtkmPa9F/o2KLxczePOdJR9LWLWFLp0pul04gv4H9EN2TliCFIuZIZagP7bIwd3UGeWWdcbYQt4oFbn8AYWd57JfqY7k1TDP3H0OYNs9ayuAoOQI4o0pO4n6xiNiZVUACISbw1z9GDbSEaJybbqJhvcO8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7sc1cCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E01C4CEED;
	Sun, 31 Aug 2025 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756656101;
	bh=2gNH/RzO1V0JsfglSgx1jzUzgMbIO9CB7CQt5QHDaiE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O7sc1cCIAJLHudpybzjPxTmNCgUawvKCj4pT2k14Rd3/tSuebiso0jIAudclYzGQY
	 fYJo+EgIK4F8eCHTtPEHTXKukpLJY4soO5jecySRSrh7Bx6UpdvGx8bR5FRjH0q+Tc
	 vfHJ93dSxmTtMK6bmRKvc2UPGFUIbyf8eheiSnuxEcUqJVbfrdB/qom5qoVaigXzgh
	 mJNRirQPnkdMv5HrHrlbDJZxDfi4fbxtOX1R1ORhsNebBrNnSmd75Nkw/96spGsxdo
	 +KE7VA9ofuhbAtuYEWBFhd98HSWkfplfzXGoq6YSIJ1pEvO7SNsr+FUDGq/9sX94RC
	 XrAcPrPhHJDaQ==
Date: Sun, 31 Aug 2025 17:01:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt1@gmail.com, gregkh@linuxfoundation.org,
 viro@zeniv.linux.org.uk, peterz@infradead.org, jstephan@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 jonathan.cameron@huawei.com, akpm@linux-foundation.org, chao@kernel.org,
 jaegeuk@kernel.org, vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add NXP P3T175x
 support
Message-ID: <20250831170127.3c7d9bf7@jic23-huawei>
In-Reply-To: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
References: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Aug 2025 16:01:04 +0530
Lakshay Piplani <lakshay.piplani@nxp.com> wrote:

> Add bindings for the NXP P3T175x (P3T1750/P3T1755) temperature
> sensor, supporting both I2C & I3C interfaces.
>=20
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> ---
> Changes in v2 (addressed review comments from Krzysztof Kozlowski):
>  - Dropped nxp,alert-active-high: unnecessary as polarity handling is imp=
licit in driver.
>  - Retained nxp,interrupt-mode: required to program TM(thermostat mode) b=
it; enables interrupt
>    (latched) mode. If not present in DT entry comparator mode is set as d=
efault.
>  - Retained nxp,fault-queue: This needs to be configured during device in=
itialization.
>    This property configures the hardware fault queue length. Defines how =
many consecutive faults
>    are required before ALERT/IBI is asserted, preventing false triggers i=
n noisy environments.
>  - The `reg` property remains required to satisfy `dt_binding_check`.
>  - Fixed YAML formatting, line wrapping, and examples.
>  - Changed compatibles from nxp,p3t1755 to nxp,p3t1755-iio and nxp,p3t175=
0 to nxp,p3t1750-iio
>    as reported by kernel test robot.
>=20
>  .../bindings/iio/temperature/nxp,p3t1755.yaml | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/nxp=
,p3t1755.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/nxp,p3t175=
5.yaml b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> new file mode 100644
> index 000000000000..4eb6fc5cb247
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/nxp,p3t1755.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/nxp,p3t1755.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP P3T175x Temperature Sensor
> +
> +maintainers:
> +  - Lakshay Piplani <lakshay.piplani@nxp.com>
> +
> +description: |
> +  Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1755.pdf
> +
> +  P3T175x (P3T1750/P3T1755) is a digital temperature sensor with a range=
 of -40=C2=B0C to
> +  +125=C2=B0C and a 12-bit resolution. It supports communication over

Wrap consistently to 80 chars

> +  both I2C and I3C interfaces.
> +
> +  The I2C interface supports up to 32 static addresses and provides
> +  an ALERT output to signal when temperature thresholds are crossed.
> +
> +  The I3C interface supports In-Band interrupts (IBI) in interrupt mode,
> +  allowing the device to notify the controller of threshold events witho=
ut
> +  dedicated alert pin.
> +
> +  The device supports configurable thermostat modes (interrupt or compar=
ator),
> +  fault queue length etc.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,p3t1750-iio
> +      - nxp,p3t1755-iio

Wouldn't expect an 'iio' bit in a compatible. It's not about what driver
is binding, it's about what the device is.

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
> +  nxp,interrupt-mode:
> +    type: boolean
> +    description: |
> +      Enables interrupt mode (TM =3D 1), where alerts are latched until
> +      cleared by a register read.
> +      Required for IBI support over I3C. On I2C, both interrupt and
> +      comparator mode support events.

What David said wrt to this. If it is discoverable from the bus type
doesn't need a property.

> +
> +  nxp,fault-queue:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 6]
> +    description: |
> +      Number of consecutive temperature limit
> +      violations required before an alert is triggered.
> +      valid values:- 1, 2, 4 or 6.
> +      If unspecified, hardware default (2) is used.

This is the userspace period control. Don't have it in DT
as nothing much to do with wiring.

> +
> +  assigned-address:
> +    true

Is there not a top level i3c file that we can $ref like tend to do for spi-=
peripheral-props.yaml?
Seems not unfortunately but we do need some sort of reference for this.




