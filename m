Return-Path: <linux-iio+bounces-2267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C67D984BC28
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 18:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10E1B2534C
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C7FBA55;
	Tue,  6 Feb 2024 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q2KHWi+D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A536D51E
	for <linux-iio@vger.kernel.org>; Tue,  6 Feb 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240868; cv=none; b=uCCnn/Dj8W9cedsE6Pu+t23o8BwLNKQR80gsnr2E4CeUohK/UoyfXa41HQkrjxxCydAG/U4K6UR7BeJL3w400rlctnapBUPjFWpAFLvi6gZa5X8NzJRfQaNeTuKhCFiN3eGhz7aC9SsITBtBgc3A/CKxJicASgu7RkY+FWhQR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240868; c=relaxed/simple;
	bh=BGYgn4pwip7xm8wZ1TGqp7QgodhzA/a+8J+7CXk661c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9Q6FTQEEKcI0uGaB9bcqOEeFFn5HnGHdIs6jW/j5KjwwxGRKBS/BEHWRNjCsJ3ujHKAHMyKNtGAzYGank1RVmiXxfMLIt0sZe0A2rkLGOc6ebUvVnYUxf74Pi+6xjGZqcAucqDXbEBxkDVUXnmegwl6Mx/65duV16ghJfJ2Gow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q2KHWi+D; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0abdde3easo30082981fa.2
        for <linux-iio@vger.kernel.org>; Tue, 06 Feb 2024 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707240865; x=1707845665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpmnZurxd3Ncre4ry66TEipTMru+C8BAh2dBgzUnWpc=;
        b=q2KHWi+D8V4PR1fcEWaOSe5A5t7Yz8vqIo0r97dt3T56724HpBdODA/+K27jWVhxK3
         9evQQlweEVeQ4c6wEyQisdH6DLLlhOGFS/8zGMQKB6TblOGsyI+By7r3TFSunGwyo1XT
         EpZoEqz7q7T7h4ibpqBDcz9UThNlqhh/Ozi64IrtShfURKwnKJjDsxjWKOm9Mvb8Crn/
         psmrIqlctZzgFdfaKYQsO+ZtNwKBYD3BBkWUmUZ8ygtokrbzr2wWM2RgsuFByuqcURe1
         vBpJvFvtOFq9ywddlT2vvrnbxFvjgUtaTztkyplJzdzQZCAYW2IivlHNnyetgn67zJ/V
         inzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240865; x=1707845665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpmnZurxd3Ncre4ry66TEipTMru+C8BAh2dBgzUnWpc=;
        b=ArnQ8Ow+i40Scq0S1u0HF0XZODPQ7v0YWzSudf30UkUz+DuUJwePDw8sgI7sZk85+d
         d/Eav3ApN8mfORXP1Vm/XVgIJhdz9nlca0UTp9YygrE/X5ILnC193M0J6web3MfaN9Wd
         eGTJvf93U4w+mHhsMBKmt+3onuHSIelQHemWD8PhJhSnHlUcP6JaJjSNB7uCcd33qq/1
         7RBYbFJRteRUH0PWuseCo6Z6JhcBWhvnPG5ns4adLu+VYIwTqPqt9ps0hf1Ij4+F9nXp
         PronQSjPrZ5mboDfwpC8NsQ3oCq7tgIopbhUvHMcU+1bZcse8ejh7RgIR9eCTY1Y9xv/
         K5nQ==
X-Gm-Message-State: AOJu0Yw++pKIC1QRApPhZmTxjRzMPCs7pBL7ECD49Uoh3kmSV3Z0xNJ9
	wdHHriAGKDzD9NVsbeuRIoiKydASYiRM+IWU4fvIn0nBnog/fg45V+inHog6HmTVEjp025BQy0s
	zVkm1Jd0GE/6/mMXSVKG/J1Akmy9QKHM+eARlBkHDbzdSgP1o5qs=
X-Google-Smtp-Source: AGHT+IHeO+vgPTOIdvMuGjPatUo0mlDXrgtJyq8JotpLBwIQn4VQzamYSWR9VNr613H7eBXZT5jM1Kx3+NpKtIU81Us=
X-Received: by 2002:a05:651c:23c:b0:2d0:a464:747 with SMTP id
 z28-20020a05651c023c00b002d0a4640747mr2286725ljn.49.1707240864576; Tue, 06
 Feb 2024 09:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-ad7944-mainline-v1-0-bf115fa9474f@baylibre.com> <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com>
In-Reply-To: <20240206-ad7944-mainline-v1-1-bf115fa9474f@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 6 Feb 2024 11:34:13 -0600
Message-ID: <CAMknhBGG_RS1t0OJw6_UnNQ_=S4YgN4i1YN26V8n=f9y28J9hQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add ad7944 ADCs
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 11:26=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
> AD7986 ADCs.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 231 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   8 +
>  2 files changed, 239 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml
> new file mode 100644
> index 000000000000..a023adbeba42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7944.yaml

...


+  adi,reference:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ internal, internal-buffer, external ]
+    default: internal

...

> +allOf:
> +  # ref-supply is only used for external reference voltage
> +  - if:
> +      not:
> +        required:
> +          - adi,reference
> +    then:
> +      properties:
> +        ref-supply: false
> +    else:
> +      if:
> +        properties:
> +          adi,reference:
> +            const: external
> +      then:
> +        required:
> +          - ref-supply
> +      else:
> +        properties:
> +          ref-supply: false

This seems like something that could potentially be improved in the
dtschema tooling. Since adi,reference has a default of "internal", I
would expect:

     if:
       properties:
         adi,reference:
           const: external
     then:
       required:
         - ref-supply
     else:
       properties:
         ref-supply: false

to be sufficient here. However, currently, if the adi,reference
property is omitted from the dts/dtb, the condition here evaluates to
true and unexpectedly (incorrectly?) the validator requires the
ref-supply property.

