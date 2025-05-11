Return-Path: <linux-iio+bounces-19438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE27AB2956
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF563B3C16
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789A25A620;
	Sun, 11 May 2025 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbJ3tXI4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2DE645;
	Sun, 11 May 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746976800; cv=none; b=NNfut1/EsBZgAPlZv68z6pfeoqkDAftwhcWBRZR37fYWSX0RfOCeCiwNRrk9f65jVAgjKCnts1IkEtLypT/akSlmiCh8j5Ihc5ZkcNGV76QeziyeQ0RJrn+mjm+1jIkFfZX7t2+H1Wmk9y4COLH5EdMSuDwICQ5rDbm0w5Rz+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746976800; c=relaxed/simple;
	bh=HA/A8GP89CnHack4rX1U/MIFbC/M5usm9D9sUC0jCcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/RxuH1dk55Bnmdm4HSVrcge1sFhhdDxYoZpigdc/nTVWdLMagWlAGkk3cqQ9w8PkbWhttbzcimLZvkx2IBNAvEhInFrboH3aSDhT3ZvILZMQL8iyxO3ArMbJLDPh7HcE/lOyIiGpaRH2WZoBPCXKoufZzdtZSPWXj1hV6Rmqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbJ3tXI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B53C4CEE4;
	Sun, 11 May 2025 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746976799;
	bh=HA/A8GP89CnHack4rX1U/MIFbC/M5usm9D9sUC0jCcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GbJ3tXI4QBTX63n/YjN6uLAg/z3ZyweoXoTsR3x0oVxFN1U5mZSv8SOt8zFRa/zjB
	 zX8o1JYIjPCdIxjVjJ1nTHUtdBboLy7Ru61WqzWI/CnlGh6zDWjE48mGhqoTG9oJo5
	 +bh+0O9K8IzPVcDbdAugTTJsUWBJrnIPrJDGiQue1lqxiR+wtL6x11tvmDQl9Q96d9
	 KUZBjpsunOPehBKh7fLLm+QarjNpD6eHn4rPPUlWn7CcIymriH5d0UfiHKT0hZC/DZ
	 s2ui8qBhwFAcWdYG8x33gLu5zEBNTAvqroihfncXDGYQyEkp5ikxHcjZ6ufdCnw0V7
	 xgHPajdCGzc1w==
Date: Sun, 11 May 2025 16:19:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brajesh Patil <brajeshpatil11@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com,
 dlechner@baylibre.com
Subject: Re: [PATCH v2 2/5] dt-bindings: iio: magnetometer: qst: Add
 QMC5883L device tree binding
Message-ID: <20250511161952.5e608a0c@jic23-huawei>
In-Reply-To: <20250508120846.114262-1-brajeshpatil11@gmail.com>
References: <20250508120846.114262-1-brajeshpatil11@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 May 2025 13:08:46 +0100
Brajesh Patil <brajeshpatil11@gmail.com> wrote:

Needs description. Give us a clue what the device is in a
few lines.

> Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> ---
>  .../iio/magnetometer/qst,qmc5883l.yaml        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml
> new file mode 100644
> index 000000000000..a2e6982a177d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/qst,qmc5883l.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QST QMC5883L 3-Axis Magnetometer
> +
> +maintainers:
> +  - Brajesh Patil <brajeshpatil11@gmail.com>
> +
> +description: |

No need for | as paragraph that follows doesn't need any specific formatting.

> +  The QMC5883L is a 3-axis magnetic sensor with I2C interface. It provides
> +  measurements of magnetic field strength along X, Y and Z axes, as well as
> +  temperature readings.

There are two supplies that should be listed here and in the required list
(note that doesn't mean we can't reply on the regulator framework supplying
 stub regulators if the power is always on - it just documents that the
 device requires power to work!)

There is also a drdy pin so I'd expect an optional interrupt.

Note that bindings should be as complete as possible, even if the driver
doesn't make use of a particular feature yet.

> +
> +properties:
> +  compatible:
> +    const: qst,qmc5883l
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C slave address (0x0d)
> +
> +  mount-matrix:
> +    description: |
As above.

> +      A 3x3 rotation matrix describing how the magnetometer is mounted
> +      on the device. This is used to orient the sensor measurements
> +      to match the device's coordinate system.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        magnetometer@0d {
> +            compatible = "qst,qmc5883l";
> +            reg = <0x0d>;
> +            mount-matrix = "1", "0", "0",
> +                           "0", "1", "0",
> +                           "0", "0", "1";
> +        };
> +    };
> +...
> +
> --
> 2.39.5
> 


