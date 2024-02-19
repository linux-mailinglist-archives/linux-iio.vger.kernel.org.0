Return-Path: <linux-iio+bounces-2797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7261385AC58
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 20:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121D21F23857
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 19:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA0353E39;
	Mon, 19 Feb 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XLmyjSXV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5B53E1B
	for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372038; cv=none; b=Ch94T1d2PEEx4o9Wq8po/ZF07igLhwHyNcGcFWqzFxnN0o8fXj8NjqBmNx8rJhJXEd42ydw/O9p29lPDmnk+flHsG3MI/CCQKYzA7UjnPFo4wMyv75xoUGaGdJ+chPgrruM+jDx0+k5YqzNEtEZlHeGzQgBM+ZkZhaHoAVdlNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372038; c=relaxed/simple;
	bh=DUEcOGJ/rk/h3tWGjgVTrpMETTt0JGs4Wy0hdmAe7hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwkF3yHSYXL2NvvLGtkvxr+JPowXDBLcZPjwx+dqgqDeNAY83OkZUqRH9vRS0RXtOx46Sm4WJBjpJvRi7xDDYHjesHJYs78CYthLkDVgckUY4TwWEbfUnaCLSqQQQ44YoVWb/ii23ZGEz9qxaiR94eLq8gl8OK91YBLueBdN/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XLmyjSXV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so11016671fa.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Feb 2024 11:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708372035; x=1708976835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUEcOGJ/rk/h3tWGjgVTrpMETTt0JGs4Wy0hdmAe7hc=;
        b=XLmyjSXVo+QrZsw56/6y5wko9M58YoqckmwPn7YSTnJ/wx3/+LSB05Ry8C67muEgAn
         OSsjHKYvLcBbwIm+e399HA5BszIw5pfaJSIl+Ytmj4z1Z3V+3tyGLOydXaOThogoIN5D
         RGTBfPSy8u5LOp5PBxalDAGEvB+XiFv/pW2ZxbQVFLhVmA9icDJn4PsJV4McbvOPtOlN
         mSbLDBxE9q2d9HZ6Lc1bHmwhStHXAa3n56ngTYxuoPhIg6gjQ+jSWWTP0ttZlo3E0QM4
         jSHXRu2CMe8NO5BIxeJOfZevdGQOXv5H+9tTze39y/fkMOMpCfrnE+8EzNZef6TePogp
         yuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372035; x=1708976835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUEcOGJ/rk/h3tWGjgVTrpMETTt0JGs4Wy0hdmAe7hc=;
        b=oJ0YTlwhBeopMZPktub54dZbaiC64gsBU/QwGA+FW5zuBL/OAXsmTgIltD10/SZIUc
         UM7D3PSxuCfYiWG2ZlDlbouQ+dUP2SRHBhxLOAAEooKbxHynDY4hZexTZu9LVpD5MAzE
         Vn+4IX3dfIVTJRLujwMDd3owycoD+Ums8msgKx408tsAF61vWMbKi68zUUhG2fJnVoMJ
         MFx5+0Vg788PVEHe3J4pN7EoCbftvKhNIovH8xIphtECsE+D12GNINglTmF7LsUHP0rm
         r7dRdHAhnxAqt+qaC01vzIhETRMMz45B6Q5D2mbYaq/B1PAu4pekvTKwrMnPKuM1Xo+U
         4WxQ==
X-Gm-Message-State: AOJu0Yz+nfu1qWCQwIEtHGNVEXiG8042lSGyJhI9bJC/TeugVZNLmoFd
	6CFHejPLfqBb49IZbiXFjVkkq+w6cNxQVtJc4Dk/FRlCLWhH2gxgVZkczvzPZ6DX/i+L3MvDhx9
	hoVvFmpVamMrhVb28Lar22C3uKhplySTnD5imdsRckd9fv7w6Tzs=
X-Google-Smtp-Source: AGHT+IHE5s1bWp7Lf0AEexy1WLGcMX0Xnpkd5+kSp3lWcLT3lfjbcJg3I29Wo+/9DZEaxxVZN3gD4R3V3ERbgvjwPck=
X-Received: by 2002:a2e:7202:0:b0:2d2:3a8e:e2b4 with SMTP id
 n2-20020a2e7202000000b002d23a8ee2b4mr2113220ljc.42.1708372034915; Mon, 19 Feb
 2024 11:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com> <20240110-ad7380-mainline-v4-2-93a1d96b50fa@baylibre.com>
In-Reply-To: <20240110-ad7380-mainline-v4-2-93a1d96b50fa@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 19 Feb 2024 13:47:03 -0600
Message-ID: <CAMknhBGkUP2Tdze5Fa_0qTcCP_OgcTxtczKYZiH1icfuTAEe+g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>, Julien Stephan <jstephan@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 2:29=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:

...

> +
> +/* fully differential */
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7380_channels, 16);
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7381_channels, 14);
> +/* pseudo differential */
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7383_channels, 16);
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7384_channels, 14);
> +

Similar question to [1] in light of [2]: Since AD7383 and AD7384 are
pseudo-differential, should we handle them differently? I.e. add
aina-supply and ainb-supply DT properties for the negative inputs
(typically a V_REF / 2 supply) and remove the differential flag from
the channel spec.

[1]: https://lore.kernel.org/linux-iio/CAMknhBH2Pqa9xpPxnTCxJegVTbOG-QDeJA4=
YrQUPfj+hfSs73A@mail.gmail.com/
[2]: https://lore.kernel.org/linux-iio/CAMknhBF5mAsN1c-194Qwa5oKmqKzef2khXn=
qA1cSdKpWHKWp0w@mail.gmail.com/

