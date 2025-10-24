Return-Path: <linux-iio+bounces-25410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BCBC04EB1
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 10:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C31A3A9BED
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0DB2F99B3;
	Fri, 24 Oct 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="v3iF3RAP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23CF2F6168
	for <linux-iio@vger.kernel.org>; Fri, 24 Oct 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292582; cv=none; b=cgiFCgUlMC3NNpHVaDe6q1iQCxShxQECG8JscJIkHYUO6v563K+BcFyg8pcEmHIXPkDpSM3FI1yYQw/8PGUC+NBbQWouAzI6J2nGVu+nybki8L/tjG/FTWUa8S26stwn14gZVWs9BcpG8EPVZalCfT3XMcCHWn5opgtqEV33JKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292582; c=relaxed/simple;
	bh=nxy0zWX1h247nPbsMpYtj4rqvQKsZpsdIsqOdaa3i18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djJxZrZEHrUkPuzjEfi9p+S1v5M+tm0lbbw08ciKjttshSKlKZX87IkXOEB56vXMfwAgVZRFswJw4PJEHk+sXNc5FB31WVZuXK1X7Jd9haDNM2xLSG71Ga2rOegTkkNKwyg1DI4bzs+nsya83tnkB2KKghZfe0jlPiYMVtu77cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=v3iF3RAP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-592f22b1e49so1559700e87.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Oct 2025 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761292579; x=1761897379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxy0zWX1h247nPbsMpYtj4rqvQKsZpsdIsqOdaa3i18=;
        b=v3iF3RAPDCb1elFqO0VtoWQu+fW6ymU7UCcKEvvmYKNYTD2ooJnLd6jMbuJoUoN+Dn
         48jC0TXcnzK7hHI8l7XLLufqE40irxcJ4vQUvDf4zdOy47noMAAYnUg6+rKFE7kuW8KB
         USll7/Aewk1bIvHRDatF6iZ+ivUhLjYhiJEJEaA/t1MN12k63JvJ8Z2BqetAPfCPpfzc
         bXyJLqDmaG/v2uSkzQNDFkhtLwjQdE/QsFWa4lokn+PvuaNQ6Zeenb8G29xaiiFXP0S7
         FDqWxQyTvlalR9tZ8BC9oRxHctw1PO5qfa50RYj0lq81NdRESC/gWmdIjcg72jvCS2fV
         wJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292579; x=1761897379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxy0zWX1h247nPbsMpYtj4rqvQKsZpsdIsqOdaa3i18=;
        b=gVQDbYE+P2MakPjL8KfnDDGGUBZiaTks1r+1p0S8h4vSE2g8zNtlT21bSXzCZ+TNvd
         WB0+rm1si8zubZpfd+WIxxfL5cQ9z2TAAzHyUbrHBVl5hC8y8Omg8uxBmDKbUC+y6wfg
         hRwP4zCTBbYBgHUO3SwTsGV2kZNAh+jYs+9UXYNi2YILUo03OZ51sdWADAgByS5TeitV
         VxCf2HfFNFqm7iQg2rFEuJwoN54xz2tcOwPj0NN021WTn2SEkkx+gaEAIHpjWoif5DK1
         av32lo9v+jTftEVzJcFHrQylyQaRPOvHaZ3NHRhiHWYtg8qPB4H8PSaI2S9Jpfx1cCDs
         IFgg==
X-Forwarded-Encrypted: i=1; AJvYcCWERvn5dTXRuNGKGDHvCC/lYQQ7C7Odk5EZOpHTgXbv1xUMjLGS3FJqizEpKh8GL3e4/WvEFW7+0yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/7vS+clmx9Y8Xczp+NWg4LbQhJJw1O+u/4cvP5/jYZGn5hK8
	Y7vn1lV8r3DHa5j46+FzPZx8O1s/AzIAI83i4VpX52TJEJHQ2Nh1mLFRvS/x7+PKK4sgyg38pv8
	05dO2lI6BqDQ3Mpod+gdjdBmAtDOOLcOWbOLIDJt/TQ==
X-Gm-Gg: ASbGncvnNtSTW3t8fQAKkVzScBDG2d4rAlkqtqO39lYIZoS0Ij/aLo9uWmbbWzzxpeA
	8dNGrVS8WbbsqOITvzyFS00YiK0vEgdyLIiZKp/sbYAJJ04PKl8JWAcLXYrnARnVZSBEmYPwiyW
	ZrdRmj/gtLTpPxyVxrxLC6v9/gM2NrA9UOjJ3JT4xN0WqVtlTjolsI1EnTT+JC8BVFDV+/vBM7m
	HQy4MCa4YacyBMDICagaWWreOn7T2DPs9OIJtpJwRHMByw9ftAnUbNVOWJqZ32idna3PYlDKKKv
	kGttf/k+ajlxEzY=
X-Google-Smtp-Source: AGHT+IHSnXZ/gyOux7cXwXN4jLtleYFyXBIE1/V6t/jovl+yJ4b+HMb04wimJ5i7xVzENgmv7b2GUJ2i/5ONH7mEpKM=
X-Received: by 2002:a05:6512:130c:b0:586:83e2:2295 with SMTP id
 2adb3069b0e04-591d85525f5mr9376212e87.45.1761292578695; Fri, 24 Oct 2025
 00:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023143957.2899600-1-robh@kernel.org>
In-Reply-To: <20251023143957.2899600-1-robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Oct 2025 09:56:07 +0200
X-Gm-Features: AS18NWBwXS6t25LKJEi_UKqvj6YhljrcGI4AFOhItyKPndeRwhvu3EmnTJe9vDc
Message-ID: <CAMRc=MdE=1cPDPQwPQA6mdBkbXF2pG=oQ_oR_YuasGzaPDsKtg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove extra blank lines
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Georgi Djakov <djakov@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lee Jones <lee@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:40=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> Generally at most 1 blank line is the standard style for DT schema
> files. Remove the few cases with more than 1 so that the yamllint check
> for this can be enabled.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

For GPIO:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

