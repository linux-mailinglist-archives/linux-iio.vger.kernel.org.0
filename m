Return-Path: <linux-iio+bounces-3925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019078923D4
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 20:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6161F23027
	for <lists+linux-iio@lfdr.de>; Fri, 29 Mar 2024 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690F12F5A4;
	Fri, 29 Mar 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="inTMR2Ax"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30185629
	for <linux-iio@vger.kernel.org>; Fri, 29 Mar 2024 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739207; cv=none; b=KC7wwwrStQ+5PlCagmTHpCG8Dl8dI+eqaqbNUXiRjVZQpbloPrKIdDgW6H2LjZ8/36e02FVT1RiwfIbfU0LgFxFUD1um1vu4ZqdlCmrdQt0lImsg0PGdoX3rFVY53Gz521j/fd4cKMWoQmDJdhyC/dEQO/IFvMAYjDkoBFSZi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739207; c=relaxed/simple;
	bh=Lpa/0EbpcSgU2C8N8Q28pKWafOZU+ilY+53iyrQPmBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/nrKtOQsGP4IGAalYxIJv45RC4R4WA/hFSQgFkiX8ynzDMNsIo2aV/EPRC1Yk3LzlY8pI1Ffz38tMau8vVdtC9ey/lt/4Oum7e58BdPfIERYdFH4F5/JSUeg5/WsgIVF1EYpYqsrXaaFMXntuI7XmwpXHq9+xQah7HhYBhjN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=inTMR2Ax; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso26523141fa.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Mar 2024 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711739202; x=1712344002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWS9d526Zrdj4YY+GMvBiR62zSADNrt4nDy1cYfB8Ug=;
        b=inTMR2AxLSaNWuA/6Rj9p6PNAbuSpwMyPKaw2SDajZQHFSzIczBuYbYkJ9/M7+rrlh
         VNOALLkewyd2J/wdw4D/JL1rgUlIGY6R1WTHJa1001oZ8Blw16zroGQDpAuS8LVzmiSn
         sICiUEo1Afl4h4X9byMAuGU2tA+nEVdhU+Jd+cVU9xvHoUP1OKKKWLTmfzcSGnoKpPU5
         Tg4O6S6RmyTDMBFxut81hyMQ66YZuqFmuWvHorn8WsegQYxlflYXN7HMWFmK/9mNJeJE
         yC2msO8sTpoulkoNuOGSTCmms530H0Lcm+h1QZM3/4JJznHnlQA4FQAVzb0kdkBlafSE
         RDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711739202; x=1712344002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWS9d526Zrdj4YY+GMvBiR62zSADNrt4nDy1cYfB8Ug=;
        b=cb6uyian/6SQvVhRsTWuKsmUonkX8lvSYPNKDPwDDkCom17kv65Hanpw1AtzIC7CfG
         krehq9rQp0EtA4xcxYQP2kw7LN/MF+Yv7Z+LjnzgWtJz1/ZwSNNh4XzYdf9ZcJh6euHg
         j+nZH+3z5jOkxRGfcCVIdDDjhLP4mbrdy9CpzDoE9B8Ixa/UoGWoOKQQ5JJLyJIDQv1I
         bDo5JAfvPsOQxFDnNLEx2ddAm+gGufSYYNEU7DnvuhFiSt2b+MBXym4fCPraEj4AlJOt
         2AX4RDFL2P9taHtfpvB5xjPcIKApEQDm2ezYBpIGZWuchTtolhdN3sUQRkllyBLG+Xdv
         T6Kg==
X-Gm-Message-State: AOJu0Yz2sbeG+KtbyLkvs/Uo6O+it1enFxsI4NIJcZ4Tc+CE3Tjr2u5f
	mrvcjtVWbSlgJZyAb9iJ+LrnOzQg2RimvhVcq/4yfmqD7oTlp9SUtytQdHaaI1mHVK/S8XfKEZ0
	kZCL3qVGOGJBNNAyAnNAe7XZjBU18lA+OuazdqOk9Q4W/XVisY2I=
X-Google-Smtp-Source: AGHT+IEncymz1fIe4aZNkqHiPFrFp27C+k10VmKIwyn8D6GDdQiCa+4mGHs+YiOjdBifpHBiIJIOFraWKU96UpARd3U=
X-Received: by 2002:a2e:a4d5:0:b0:2d6:a244:1ba4 with SMTP id
 p21-20020a2ea4d5000000b002d6a2441ba4mr1664064ljm.33.1711739202463; Fri, 29
 Mar 2024 12:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com> <20240328-iio-backend-axi-dac-v1-7-afc808b3fde3@analog.com>
In-Reply-To: <20240328-iio-backend-axi-dac-v1-7-afc808b3fde3@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 29 Mar 2024 14:06:31 -0500
Message-ID: <CAMknhBHA3LOhZicUCG32RyiV4+OROJymzm0Qc=wqhfo3u=8vnQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] dt-bindings: iio: dac: add bindings doc for AD9739A
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Dragos Bogdan <dragos.bogdan@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:23=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> This adds the bindings documentation for the 14 bit
> RF Digital-to-Analog converter.
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   | 88 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  8 ++
>  2 files changed, 96 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
> new file mode 100644
> index 000000000000..24bcec763a9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad9739a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9739A RF DAC
> +
> +maintainers:
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +  - Nuno Sa <nuno.sa@analog.com>
> +
> +description: |
> +  The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are ca=
pable
> +  of synthesizing wideband signals from dc up to 3 GHz.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
9737a_9739a.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad9739a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

I also see an IRQ pin on the datasheet. Do we need an interrupts
property for that?

> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdd_3_3-supply:
> +    description: 3.3V Digital input supply.

vdd33-supply would better match the datasheet name

> +
> +  vdd-supply:
> +    description: 1.8V Digital input supply.
> +
> +  vdda-supply:
> +    description: 3.3V Analog input supply.
> +
> +  vddc-supply:
> +    description: 1.8V Clock input supply.

I see a VREF voltage reference input in the datasheet. Do we need a vref-su=
pply?

