Return-Path: <linux-iio+bounces-4211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312008A37D6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 23:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D60C1F231A5
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 21:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C31152174;
	Fri, 12 Apr 2024 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dl3FSX5P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933182556F
	for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957192; cv=none; b=dQKvZb1d+mFCqV3/fq2GsLynxx5vBT3Kaqr7ufRiKreyUdkuSO0txy8XgSY+Q2aSHYW5Rns3gkICtIJsGHlXbSBAW03Vg3Ewr1RdOgryunaQER9q9JRBHXABaYRqKxtB2ey2geFDF0twUSMutc8msKoL057Isn/m4oFbyvUGfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957192; c=relaxed/simple;
	bh=TnychJnfZ1ARNa8XlNX4o7oKmSbkl+T/lHYLu9auJRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujJ7rlRLkRH7YqNbtoRl7+BPCwZyehAqRzGjLYz3ArBbMLCpzTx2BjD77HJC/lmcGB591VhyGW9RdIi1FxdPJAXWeZmpqMYaM7ZbVaq1AQMtTbMODUZqIv6jyAo8ngjybBGmHm5r2Gx9QKUn1umLM4BeKnnsxlR1apr3ORLQUS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dl3FSX5P; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so14802061fa.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2024 14:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712957189; x=1713561989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2/FnCSkb0G/WX1xU5FT6ophn/HhrSA5iG0uPSjN8aw=;
        b=dl3FSX5PFE7nKwrsizdFbp10QHI3DlMmngJLGM3HfsAtjWyj8reBVRplzP6cpnQFD5
         /Ue+dzvXbytwhixlORFE+5QWZi6k9T89JPFIhKzdfkg2ALt4rd6j+zGYPaoau0/jtNeR
         Q17yFnVk0AbyTSbHY2Ym0G0r4gmRm5xC9fsFXSJxePD158SnzsLlW1fCSoBk5ImQMTZZ
         abntmnicTLhLnHpCsYICq8I6elBKtTRtLz0v4eBlsIaFwXnxCiUVTWQ5p7J1IWQ66tQ1
         k9/SpdgFm5fqkb9fJSf5eqxOmhL84rnAe6aMBlSb1QcE/bgh5m/gaG1lI8qUQDkJVPMG
         U+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712957189; x=1713561989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2/FnCSkb0G/WX1xU5FT6ophn/HhrSA5iG0uPSjN8aw=;
        b=G5zvB2Jxf4dBIU10SE9FAPLypXk5iinql5hhqlDN0ZUtg1p6oOW84YNn+wz447fZXu
         /tCynFImmm3Xe0SJKrJjL9VUXa9ndlj/vRpTcBxFLeukeeDZrwZeLzyKPzfr5I0ijxSC
         /01EhnMpX9iBpA9N0eDsgcE3TQZOHBkwiwjPzI2P0R8Kvhm6I7WJkj6M8eu1emoiD7Va
         4oYRZN9RqWdsBp/KC0t7qRHZ/GrnYyrIBnHn8PbDofF6JjzskVW1kei1eTskXLBm//Ym
         gQAj0I3EAY6evwnRx3d5cOtxe8KkkwM2k4zS9ILeGZkKgnI9ZFEZ+S0csN9U75MzefSi
         JyXg==
X-Gm-Message-State: AOJu0YyZJBg4Fq6YITASSg9X7aSFEyDH5UoD4vyjfbVXc5MWkhBlFoe1
	SsQif4snfNU8GsTpUqCguurYg+UN49aMEoeneLJVlcLgzb6IznoQv/CJ8Rtu7PMXSVlkCJ9TjFq
	siu3Q5CtNQ/NB1Qj8A8sgIFcDrA/sWZVrIc/uaA==
X-Google-Smtp-Source: AGHT+IGTDBXy40PBbc0Sok6v9xzaHIivLOEmGwOHQlmv8Pl5J+Ds/tVLRXSLxDMTmkrMsVJ63VA+1c5LECt9e27CPQY=
X-Received: by 2002:a05:651c:1502:b0:2d8:e978:e38d with SMTP id
 e2-20020a05651c150200b002d8e978e38dmr3258335ljf.10.1712957188591; Fri, 12 Apr
 2024 14:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412032102.136071-1-kimseer.paller@analog.com> <20240412032102.136071-3-kimseer.paller@analog.com>
In-Reply-To: <20240412032102.136071-3-kimseer.paller@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Apr 2024 16:26:17 -0500
Message-ID: <CAMknhBE9XihK27pRhyPwTNM3VQX=osYdDyCmjNspz1aqe_NVTw@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: ABI: add ABI file for the LTC2664 DAC
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:21=E2=80=AFPM Kim Seer Paller
<kimseer.paller@analog.com> wrote:
>
> Define the sysfs interface for toggle capable channels.
>
> Toggle enabled channels will have:
>
>  * out_voltageY_toggle_en

It looks like there are 3 toggle modes.

Two involve the notion of "enabled" outputs that I assume this attribute is=
 for:

1. Toggling all enabled pins at the same time using a software trigger
(global toggle bit)
2. Toggling all enabled pins at the same time using a hardware trigger
(TGP pin) and toggling pins

The third mode though looks like it uses the same toggle select
register for selecting A or B for each channel instead of enabling or
disabling each channel.

3. Toggling all pins to A or B based on the toggle select register. No
notion of enabled pins here.

I haven't looked at the driver implementation, but it sounds like
out_voltageY_toggle_en and out_voltageY_symbol would be writing to the
same register in conflicting ways. So maybe we need yet another custom
attribute to select the currently active toggle mode?

In any case, it would be helpful if the documentation below explained
a bit better the intention and conditions required to use each
attribute (or add a .rst documentation file for these chips to explain
how to use it in more detail since this is rather complex feature).

>  * out_voltageY_raw0
>  * out_voltageY_raw1

I guess there is no enum iio_modifier that fits this. It seems like we
could still have out_voltageY_raw for register A so that users that
don't need to do any toggling can use standard ABI. And maybe
out_voltageY_raw_toggled for register B (question for Jonathan)?

Or just have 8 channels instead of 4 where even channels are register
A and odd channels are register B?

>  * out_voltageY_symbol

"symbol" is a confusing name. It sounds like this just supports
toggling one channel individually so _toggle_select would make more
sense to me. Are there plans for supporting toggling multiple channels
at the same time using a software trigger as well?

>
> The common interface present in all channels is:
>
>  * out_voltageY_raw (not present in toggle enabled channels)

As mentioned above, I don't think we need to have to make a
distinction between toggle enabled channels and not enabled channels.

>  * out_voltageY_raw_available
>  * out_voltageY_powerdown

Is _powerdown a standard attribute? I don't see it documented
anywhere. Perhaps you meant _en (via IIO_CHAN_INFO_ENABLE)?


>  * out_voltageY_scale
>  * out_voltageY_offset
>
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-dac-ltc2664     | 30 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664 b/Docume=
ntation/ABI/testing/sysfs-bus-iio-dac-ltc2664
> new file mode 100644
> index 000000000..4b656b7af
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
> @@ -0,0 +1,30 @@
> +What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_toggle_en
> +KernelVersion: 5.18
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Toggle enable. Write 1 to enable toggle or 0 to disable i=
t. This is
> +               useful when one wants to change the DAC output codes. The=
 way it should
> +               be done is:
> +
> +               - disable toggle operation;
> +               - change out_voltageY_raw0 and out_voltageY_raw1;
> +               - enable toggle operation.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_raw0
> +What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_raw1
> +KernelVersion: 5.18
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               It has the same meaning as out_voltageY_raw. This attribu=
te is
> +               specific to toggle enabled channels and refers to the DAC=
 output
> +               code in INPUT_A (_raw0) and INPUT_B (_raw1). The same sca=
le and offset
> +               as in out_voltageY_raw applies.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/out_voltageY_symbol
> +KernelVersion: 5.18
> +Contact:       linux-iio@vger.kernel.org
> +Description:
> +               Performs a SW toggle. This attribute is specific to toggl=
e
> +               enabled channels and allows to toggle between out_voltage=
Y_raw0
> +               and out_voltageY_raw1 through software. Writing 0 will se=
lect
> +               out_voltageY_raw0 while 1 selects out_voltageY_raw1.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd8645f6e..9ed00b364 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12842,6 +12842,7 @@ M:      Kim Seer Paller <kimseer.paller@analog.co=
m>
>  L:     linux-iio@vger.kernel.org
>  S:     Supported
>  W:     https://ez.analog.com/linux-software-drivers
> +F:     Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2664
>  F:     Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
>
>  LTC2688 IIO DAC DRIVER
> --
> 2.34.1
>

