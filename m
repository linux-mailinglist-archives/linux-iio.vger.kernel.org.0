Return-Path: <linux-iio+bounces-19862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE7AC33C5
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBF63AD9D4
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC68D1EE01A;
	Sun, 25 May 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I98iHVJL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823821EB3D;
	Sun, 25 May 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748167917; cv=none; b=pzx/8pwpy85N/YpMe58KsUrWc6l2aQ1OML7SOdnXHis29wE1AlbgxVQXu6ivAVoI7H9I3PfyB8MriG0GOOgBCd5qLRy5Ur1ukOpmMSek6dy4zTwUY1YaHsakB+nb1gD/yqFjRbi26hSs/UvrGXD/fcWLNx4MfXfm3xRLkYFLWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748167917; c=relaxed/simple;
	bh=zY1eWSeL4AHRW2dUZ8RUiOCVqHUXuW32AyfqjoIgdGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWczKe6tlkuvu+5PDZ0xrqdnkfTJGpTTZ4HwZa+pPh350g2pfvEqGy4JlWiXYDtvDK0QLnHN4x8urhZpT7zxRlXeF05kMFFG32JJsIt0a0OFW/DkpvYyrFcSVDISGfEMsZsoczutWdgCjeI1hb56a8Krb2PsuXYjKcqo1oXfpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I98iHVJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C98C4CEEA;
	Sun, 25 May 2025 10:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748167917;
	bh=zY1eWSeL4AHRW2dUZ8RUiOCVqHUXuW32AyfqjoIgdGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I98iHVJLvLOU3XpQO8hKSCKfAFsfKmm+82dC1hvdOgFhQVcWeYt8hcWCNM5F3+YLp
	 tEkxl66pvGZdAIVFxH71feWR7le0nts59en8mDbHqgrncrLp8iXIxAFQz2xWSwt8ZN
	 vZeq8QDyBPmu8SdP6IURkxAX4+14ye25oYhx1hYgPWNyvkDi8xXCBgVwa5di7+Gm+d
	 LMvDF08jiBKF6ig3uWHuHCCP5Qjsu+xoKZ6Pt8G/LeH3oIcfvCV5OWy8mmlc27wrNr
	 Yor1whSUUg1Z23465hDeqBwIB8BcOquwfUfCRJsxYNlPqxv+lDHeVAktHQdE9ETprn
	 WJLPdHfVu/xUg==
Date: Sun, 25 May 2025 11:11:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250525111148.4ca96a55@jic23-huawei>
In-Reply-To: <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
	<5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 09:33:40 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo,

A few additional comments from me.

J
> ---
> Change log v2 -> v3
> 
> [device tree changes]
> - Removed unneeded allOf.
> - Removed occurences of adi,sensor-type type re-declaration.
> - Created type for the AD4170 channels, allowing to avoid dt doc repetition.
> 
>  .../bindings/iio/adc/adi,ad4170.yaml          | 544 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 551 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> new file mode 100644
> index 000000000000..0a06258b6631
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> @@ -0,0 +1,544 @@

> +  sensor-node:
...
> +
> +      adi,sensor-type:
> +        description: |
> +          Type of sensor connected to the device. Depending on the sensor type
> +          (weigh scale, RTD, or thermocouple) the values of sensor-node
> +          properties have slightly different constraints. This property
> +          specifies which particular external sensor is connected to the ADC so
> +          the sensor-node properties can be properly parsed and verified. The
> +          possible sensor types are:
> +          0: weigh scale;
> +          1: RTD;
> +          2: thermocouple.
> +        $ref: /schemas/types.yaml#/definitions/uint8

I think this should be an enum of strings.  That will give us a clean
way to extend it for other sensor types in future.

> +    required:
> +      - reg
> +      - diff-channels
> +      - bipolar
> +      - adi,sensor-type
> +      - adi,reference-select
> +
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4170
> +      - adi,ad4190
> +      - adi,ad4195
>
> +
> +  interrupts:
> +    maxItems: 1

What if they are both wired?  At that point shouldn't software
make up it's mind which to use?

> +
> +  interrupt-names:
> +    description:
> +      Specify which pin should be configured as Data Ready interrupt.
> +    enum:
> +      - sdo
> +      - dig_aux1
> +    default: sdo
> +

