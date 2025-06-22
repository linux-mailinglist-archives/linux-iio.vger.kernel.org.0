Return-Path: <linux-iio+bounces-20841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6284AE2F81
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 13:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D1D188A252
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 11:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40871DDA1B;
	Sun, 22 Jun 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJEBIhFm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A77193079;
	Sun, 22 Jun 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750590831; cv=none; b=MH8uyZ3OoMJEedON2V558iDop3qCcrcUdcZIz+eG+zzvKRip8XLa8Q7tfIsHRZ+TtOM9HYANULpekX0nWCy6sVEYq0k+brUhchu99WwXBgnPuPnDL6fSkT3plZQj7S4+4t203g7Pgo8Gf3qbeDQ/z4zBc8XpdJg0d9nyZBEeEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750590831; c=relaxed/simple;
	bh=1lU7EAKnDOaqVEwcAo5V2VCVSGV+FPdJmDwtsGGAs5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUKVT24Cs3HhxZDpiMtgPppuC4cUCz+kBp+pSrhmiLlX8pyB761QfQZdxbO36ubyGuhoEO1r31TUEOTp7i6XTs6eXGm0aWYyOtgAF9w72JZSnj0G6EmIFZsmsNDi/PDtUDK65SJtb0Etrg3AFu6QJB6QeS2EIeOeNLpi7VDvoEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJEBIhFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7149C4CEE3;
	Sun, 22 Jun 2025 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750590831;
	bh=1lU7EAKnDOaqVEwcAo5V2VCVSGV+FPdJmDwtsGGAs5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mJEBIhFmLpQplqSS7rcepAw1FDVKs4WA/XmjV6z8nbBV9FfNCSYvVByZcv5VZYibb
	 2dpddRxxkBCIMPQNE/sCNi3DKK2gzImkLlsaA7WbFcFjLTjZ54TNdU0nRa7SFHBc6K
	 PPOOJJYPnn6Zm2pzLqvrPTGNGLowdd8TXEp36lC4JCSooAdjPo7KLEx7sE+whF/myK
	 J8hAR1UGwuNi2Dx9E/aSslPayFTnf03S+7mcD9JPTaqdP3tL57fWg/xSsYetVdfa+V
	 EaH03y4i/FTdNqWOc4c6Q4IE4bLYIDsxWRJZXIgw6lzr8ndJVMgJBrfCfo+62GUV6A
	 umkTvCSYcpppg==
Date: Sun, 22 Jun 2025 12:13:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/8] iio: accel: adxl313: add function to enable
 measurement
Message-ID: <20250622121342.1d2bab14@jic23-huawei>
In-Reply-To: <20250615222258.117771-3-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
	<20250615222258.117771-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Jun 2025 22:22:52 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Refactor the control of measurement and standby modes for the sensor.
> Instead of directly writing to the register, encapsulate this operation
> in a dedicated function that handles enabling and disabling measurement.
> This approach will reduce code duplication wherever sensor configuration
> changes are required. In subsequent patches, measurement mode will be
> set to standby as part of this process.
>=20
> Additionally, simplify the control mask to include only the measurement
> bit. The sleep bit governs a different behavior=E2=80=94putting the senso=
r into
> sleep mode, not just standby for configuration=E2=80=94and is currently u=
nused.
> Therefore, there's no need to include both the sleep and measurement
> bits in the same mask.
>=20
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied.

