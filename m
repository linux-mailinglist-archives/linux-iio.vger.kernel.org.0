Return-Path: <linux-iio+bounces-27477-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C4FCF0D55
	for <lists+linux-iio@lfdr.de>; Sun, 04 Jan 2026 12:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37D9F3003F9F
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jan 2026 11:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ED728725D;
	Sun,  4 Jan 2026 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSrmBejJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239A286D57
	for <linux-iio@vger.kernel.org>; Sun,  4 Jan 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767526687; cv=none; b=l0XZ1lwrtmygFF7IN0yAXbcHRI0Hut9mHgYMlDWwRUL82KpZ0L3fo9bG8G7gJoQgcJLcQvkV+CMhH5wA7E43/9i5isJ2FpkJ0fb27tMxNhfCrs22LUL6IjaBdhKwy7FP+JjOliyDE3S3Ss5Ayz9RspxUp/8jcDUxx6fzNwY7nDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767526687; c=relaxed/simple;
	bh=zzt8nsTReCOrFFimHSYnuwYVhyLibD7TXrGiySpB+f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYLDmR7NJ/gkqOIUHaftt6XDnaUmaExwVcKJ6m+O7tSZn4Hus0VjnXE9nGqqknEV5LnK3WQEyYQy3wE2k3UoFLKmNmfT/ukZJ2K8rSJ0b3ltCiZXSKW9vETMMaAbq8L2J5J1wRT6iLFx2MtfjWSB7vJBXzJFW+L1tKtRA1UWlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSrmBejJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B8DC2BCB8
	for <linux-iio@vger.kernel.org>; Sun,  4 Jan 2026 11:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767526686;
	bh=zzt8nsTReCOrFFimHSYnuwYVhyLibD7TXrGiySpB+f0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lSrmBejJxZP8gHrW1lt8qLoXx5i5yIr8c9JjAw76JwT4w2DU5Bw/V3A8ds+61J9gA
	 qrA1BD0oGFxFt5TGFqAv6/RSxsC53w/k7B87GXnPPGu5JyBIFEy/k2xW5XqJfBLQwZ
	 s7To43MM/23LrjwnT2MHsbj2v+MNR3gch8pFv9yPYQDYuMjuaAik+CInCYu5+ZmfZA
	 x9Du36muqnYdgEnwcEtBPGE0Q2krb+xtqRR3x8L+34PJR5hQ5QQvm7VmmsMrN+wnM9
	 I2UaQA0Jag3f/lobO/fONtZhnVUHsQ9680OTtldkoKQt1MckmCleLVqFj0F055vXis
	 sgoDnkXq9m56w==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78f89501423so10866547b3.1
        for <linux-iio@vger.kernel.org>; Sun, 04 Jan 2026 03:38:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0RFQY5+NmydiYWOf7dSlyv21mRjBg7R8ZIIaNJliCVm88xwPW5VsW8VFk+OCIIKITuNRAPNc8onU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/yr7LWuCWfx37d0Wso1UWMJh/yv4hPN744EzdzgDay60WRRg
	ZjXeJnXMmTQdKynodkapRSU6cJlBXAlBkFUWSqCwRmu15t+tcObyBD/7sjRP+d6nblgWYHdusJj
	52Cev7HSCQbCgyYjp2Wfu6liwEWo6LFE=
X-Google-Smtp-Source: AGHT+IF4Orabbp+U3oU6DE4mJfK9KKnbEOxrcm3UcvoG3IBBIUd0oK3DmWjwYq82sAXiIcIbWSh2iznA2Fvf8inAirk=
X-Received: by 2002:a05:690e:b4d:b0:645:591a:cb5c with SMTP id
 956f58d0204a3-646e341a6cdmr3638468d50.23.1767526685648; Sun, 04 Jan 2026
 03:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212231203.727227-1-robh@kernel.org>
In-Reply-To: <20251212231203.727227-1-robh@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 4 Jan 2026 12:37:54 +0100
X-Gmail-Original-Message-ID: <CAD++jLkAaAH9_YdTGqHUcOp8PfW+1P=ZLZzS_QseVYWxA4kiWw@mail.gmail.com>
X-Gm-Features: AQt7F2qijkDXeXovdHRRQ5QEL33UZBQlEMiEIzun3p2-rj7cwfnP7kAmQfWhUyg
Message-ID: <CAD++jLkAaAH9_YdTGqHUcOp8PfW+1P=ZLZzS_QseVYWxA4kiWw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove unused includes
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Vinod Koul <vkoul@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Yong Wu <yong.wu@mediatek.com>, Peter Rosin <peda@axentia.se>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-iio@vger.kernel.org, iommu@lists.linux.dev, linux-gpio@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, imx@lists.linux.dev, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 12:12=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org=
> wrote:

> Remove includes which are not referenced by either DTS files or drivers.
>
> There's a few more which are new, so they are excluded for now.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Good.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

