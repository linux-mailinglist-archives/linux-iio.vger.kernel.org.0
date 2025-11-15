Return-Path: <linux-iio+bounces-26247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5C4C60A0B
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 19:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FC93B09FC
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5954306D58;
	Sat, 15 Nov 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvTSiWQQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4526ACC;
	Sat, 15 Nov 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763231516; cv=none; b=JbyhLRhHyf8GMjXvCvp/8RvoYxDmspV9Fx5OdHYmIhNiS4p5I2QsbraWEYK/p1ezthLODcMNE123caHWRN5mdBvuMSiJusiWsHNaCrGz7frtPvkj6J+llDM7AvtlomQxL+6M2h8Wk7+KIb+dweMjUhHnTJVy23cMZ6vws4XSZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763231516; c=relaxed/simple;
	bh=RnIGhODkE+8WWC4LDGM77KLSjjNYac87RXg8i6rBoAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkNZsY11UTELcysiYja47gdcV2324ywi+vSP4o3Sk1IeuQhdfebKykTNZJCB1aiRgpIGkmGw1XcmtxuY7YAptQOhnQPy3gxFfCYGuN0ze8Z+QfQsuoKCrJj+MuV/zqm1pFo/Uyvy5ssQrYp431Mc9vn/VbIntWpOb5qxrDJXWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvTSiWQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD73C4CEF5;
	Sat, 15 Nov 2025 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763231515;
	bh=RnIGhODkE+8WWC4LDGM77KLSjjNYac87RXg8i6rBoAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvTSiWQQPuyAfsz0hcIq3pHmMDJz22aoy1e6lcCL2p2Yx8TiZDIVX3O/voZhJIdj3
	 SgoGtSUHjnhLv981vuDOQd7fVZWHamVrITo4Z5f9hLUHfaaCk3vkXZkfWVkOIXcCtw
	 OeuHggt3/uRmc5JiRx3tKzmQRTynXEbUxgKHYeEi0OuVuyUnqk3/RysPdMtXkxtNlr
	 sxSPZYpplbg1Y+MtYz6fkb9w2NLSQopPxVKV3xXoqIIH+A4lhFnaNvuk+E4W3vU5Eh
	 TFh1nHlpF6+pJEbeyRXaaXAX2aMndTaJmqRmv/vdNUeJvpCfrHxT9X46gcmBCmUQLh
	 LcSTmD0i9/EWg==
Date: Sat, 15 Nov 2025 18:31:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add TI ADS1120 binding
Message-ID: <20251115183144.15b3e236@jic23-huawei>
In-Reply-To: <20251109141119.561756-2-ajithanandhan0406@gmail.com>
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
	<20251109141119.561756-2-ajithanandhan0406@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Nov 2025 19:41:18 +0530
Ajith Anandhan <ajithanandhan0406@gmail.com> wrote:

> Add device tree binding documentation for the Texas Instruments
> ADS1120.
> 
> The binding defines required properties like compatible, reg, and
> SPI configuration parameters.
> 
> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
> ---
>  .../bindings/iio/adc/ti,ads1120.yaml          | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
> new file mode 100644
> index 000000000..2449094af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
>
> +
> +  vref-supply:
> +    description: |
> +      Optional external voltage reference. Can be connected to either
> +      REFP0/REFN0 or REFP1/REFN1 pins. If not supplied, the internal
> +      2.048V reference is used.

How do you know which set of inputs is used?  Looks like a register
needs to be programmed to pick between them.

> +
> +  ti,avdd-is-ref:
> +    type: boolean
> +    description: |
> +      If present, indicates that the AVDD supply voltage is of sufficient
> +      quality and stability to be used as the voltage reference instead of
> +      the internal reference. This allows the driver to select AVDD as the
> +      reference source for potentially better performance.

This one is interesting as I don't recall anyone arguing this made
sense before.  In what way better performance?  Are their boards out
there where this definitely makes sense to do?


