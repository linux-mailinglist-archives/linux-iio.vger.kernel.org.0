Return-Path: <linux-iio+bounces-3994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E556F8946C1
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 23:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1532F1C21242
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 21:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C74154FA3;
	Mon,  1 Apr 2024 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U/ZvfOzH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255C535B7
	for <linux-iio@vger.kernel.org>; Mon,  1 Apr 2024 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008422; cv=none; b=MIYWkIF0NaMSYvzHcqPp2jFqmkspJR/vQ3PVaOM4Q1dzIodnt9yK7Vb65ZYmIxvEzQMbN2ZzOfTM9QVphbhn0sruVHHsNuKHxyrT6umCp3+wCh3PSCTRRvjosBXXXcnhEEHPFIsJZR6QFfitoSWvTS8IcGCY/eC7kMdWhdKIVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008422; c=relaxed/simple;
	bh=z34+oohRE4iUHQVMQSJ9zoczrBf91FvGc0eitZUf3MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIZKATtQNdt1G8GWydICX68gdmCLsXtg1l8oL0k+gY/V3K0sk5toBFFpPrE1GCvZovoIqi+mZPTb261QIaxZo6psmkJcmkHK2+R24xUG+Smc8tSSdcN377KNcUTSSzjmawQWetViQBKPTHMeD7cxueuQy+rISytbpm22brXxZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U/ZvfOzH; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso58736131fa.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Apr 2024 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712008418; x=1712613218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWmw9iAUS81y9sAEqW+BsG5yCiLMdfWvTp61OeEwAcE=;
        b=U/ZvfOzH6GPm0gSFOYH2mN9W5zDvO057pdafNgFERxFOeDIbY9EhGY4NHA6KRl6usd
         1uNoaQtDfqrBEzZUn9hooj1pUe/89E4ME6+YRPAM5hm0vYgIJ2Z9cP8sfbXgq74wjmTa
         BCgE7bojpq8cToz8kgkAhK81O6+Lgm3cTFueMGg+PUCQL/qaSSew7CNYE4B6H7hhGXCp
         tNkobpQ/Z+S8qJ0iCUXlQiL2HnweK8UxUvsVhknGYYFQg2yGpMHwxop+Jf4i1RRVM0hJ
         +/XJ/IZbm1/+VggLloG7QxrObzgML/UQA2rj22xk6OQ17ubPiX/BPCOkY8jRQxycqEbP
         lhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008418; x=1712613218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWmw9iAUS81y9sAEqW+BsG5yCiLMdfWvTp61OeEwAcE=;
        b=R1BPDtoWkyHLKDYjn9MbFNEhaqRRqjse1irpKb2afwBhcpYLyxkiDVSQclvt4ZFwaa
         xfj07kjSyBvUEsr1CISwPgl82Uz2KpPpIsYsnvn5MO2thoAjPu1Cc511ObqjpKl+km1T
         IZxD51plDr1UVtMjO9FHxDUOmxHvvBECuOA7F7Nw26eKeitHyWhw930T0nprgaPSCAzd
         rRvZUjNRUX7D8oH8+PcDhJQqlUW9M6GWXDJh3MssWf9rFXIQiw8yykcLF1zNKd7wAk0y
         5Pga3Wo/KfFoDwMrHESUP6h7OJJQex+QogiOWtAOOkFeEWMB/fkkU4KS44RFxWf3nqyI
         qmKg==
X-Forwarded-Encrypted: i=1; AJvYcCVUtC/a5R4rWKarkiENlpYKCxSCboqOaxjmW83fBf74PusgL7ynPuuOZj1obaOOHAGquaPDYId4483pe98j7yn0Iy67VBFZ8NrY
X-Gm-Message-State: AOJu0YzS93EGPEqYhXTjQ40bIJycWgpJZ++2WOvyn8RpwnQ4wrg4Od5F
	RrGR1SLQgcRrh49vFBrJmLKJTyLxkR+FPF8o7me+Ap46rFmydE6XuZPbt+BWSRn6hEFxupfd3y5
	EviP2U73HpwOgeYlWUzjPqqqhu7nVJSc7aCgV2Q==
X-Google-Smtp-Source: AGHT+IE0ZcByMuHu4xpRMUlzGI6tHp8MST9hc9+xX1jYeOSMq2j9fW14kQZcOu8vLWuWaMKFV4OtDZlj/q+O+IfV2d8=
X-Received: by 2002:a2e:958a:0:b0:2d6:87ab:2543 with SMTP id
 w10-20020a2e958a000000b002d687ab2543mr5799204ljh.30.1712008418076; Mon, 01
 Apr 2024 14:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com> <20240401-ad4111-v1-6-34618a9cc502@analog.com>
In-Reply-To: <20240401-ad4111-v1-6-34618a9cc502@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 1 Apr 2024 16:53:26 -0500
Message-ID: <CAMknhBH-YmFrqNTQCB_KafCTxEqSL+36pkE0O44NqiL89hm64Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 10:10=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
>
> The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications.
>
> This family of ADCs integrates an analog front end suitable for processin=
g
> both fully differential and single-ended, bipolar voltage inputs
> addressing a wide array of industrial and instrumentation requirements.
>
> - All ADCs have inputs with a precision voltage divider with a division
>   ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
>   shunt resistor.
>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

...

> @@ -951,7 +1117,7 @@ static int ad7173_fw_parse_channel_config(struct iio=
_dev *indio_dev)
>         struct device *dev =3D indio_dev->dev.parent;
>         struct iio_chan_spec *chan_arr, *chan;
>         unsigned int ain[2], chan_index =3D 0;
> -       int ref_sel, ret, num_channels;
> +       int ref_sel, ret, reg, num_channels;
>
>         num_channels =3D device_get_child_node_count(dev);
>

Another thing that is missing in this function both for the chips
being added here and the existing chips are channels for _all_
possible inputs. The driver is adding a fixed input channel for the
temperature sensor, as it should. But all of the chips also have a
similar input channel configuration that measures the reference
voltage. Currently, there doesn't seem to be a way to make use of this
feature. I would expect a hard-coded voltage input channel that is
always added for this reference voltage similar to the temperature
channel.

The ad717x chips (except AD7173-8 and AD7176-2) also have a common
mode voltage input ("((AVDD1 =E2=88=92 AVSS)/5)") that could work the same.

In the case of the ad717x chips though, it looks like these channels
are not "fixed" like they are in ad411x. It looks like these inputs
can be mixed and matched with AINx inputs and/or each other as
differential pairs. So if that is actually the case, I would expect
the DT bindings for ad717x to look like adi,ad4130.yaml where these
additional input sources are listed in the diff-channels property
instead of having hard-coded channels in the driver like I have
suggested above.

But, as always, fixes for ad717x should be in a separate patch series.
Still, I think adding a hard-coded channel for the reference voltage
input for ad411x chips in this patch makes sense.

