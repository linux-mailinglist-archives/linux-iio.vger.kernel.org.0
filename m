Return-Path: <linux-iio+bounces-21640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC565B03F12
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 14:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33EA17A1B8E
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E649248F75;
	Mon, 14 Jul 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="jzcKAu8l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90A1C3BE0
	for <linux-iio@vger.kernel.org>; Mon, 14 Jul 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752497777; cv=none; b=cGzpVzNzYcCXK+7DXhQYBTcxS0dPg1cPA31YGxhZwwaBt1wJ8ePU1yKEmeKC7rkG5MuBnaaBEqh8Ka6Hla69iS9Gp7LZm0s0/7/yykyp3G6B3H1+u9S4eDl8pPYY6xfifQvJlWtPNBvNF3qhoYEz4LRUpac62EekmW2eyfJaSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752497777; c=relaxed/simple;
	bh=uWeyd66yVqw2s6U3bvpYChNlWq2THyOzrEc/y3TNdcU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjGxf9wof1c6Tg4KfFn+v7uXkzFGRniF09pCEY7aFK1VT+Voalbtnp9l1+DgN9jhmhkw307NpuhrJS8t4XBn9iHc6b8VszgqfJ+G6dDvQO0kGUDmAZKIPXS3HTTVBz5EDA/PvWDmggwRK1PvE+4DLhRDwCYWEPAsX7j8+sXIrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=jzcKAu8l; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752497771; x=1752756971;
	bh=uWeyd66yVqw2s6U3bvpYChNlWq2THyOzrEc/y3TNdcU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jzcKAu8l3wVKhcLpQdZRhKqTiGjLgvb89oaSxXtZJY+0AX/BXtGJGqeT4gEV/1YOd
	 FMn2EZxsPeNbV/D221OgPl9MTcixbgOsoMDb9Yfuk2EM/g7ZHQHXY+r+Hx3KPCbj70
	 lPb06C0qSJAWkoDVMGgU1kJKXQneZlMjJsNex6jgQbXiJAemrfoAkP5gxr7zf/lbNr
	 ZJWBFxFgy998iCQ2NtYN3I0Sgj3bshiwuJVyKBJsZHrhwXbg59wjPsUQ4pa9jzrJgC
	 +Y2G3aw3OoBY6yJK7d7UzeYW+6U0XnOv7+dNV/RnjMI8MccmSlcUSRlRN+ZrrPiR8Q
	 /jsCDWwmL33/A==
Date: Mon, 14 Jul 2025 12:56:05 +0000
To: remi.buisson@tdk.com
From: Sean Nyekjaer <sean@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 7/8] iio: imu: inv_icm45600: add I3C driver for inv_icm45600 driver
Message-ID: <diu7j6qvtggayvtgrrjdavxmhvjg4jeujz7mdkf2ggzgp4grvm@qdk6vxbkhvml>
In-Reply-To: <20250710-add_newport_driver-v2-7-bf76d8142ef2@tdk.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com> <20250710-add_newport_driver-v2-7-bf76d8142ef2@tdk.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: d6e75c40345543f35d87f87d6c61368220c73f0d
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 08:58:02AM +0100, Remi Buisson via B4 Relay wrote:
> From: Remi Buisson <remi.buisson@tdk.com>
>=20
> Add I3C driver for InvenSense ICM-45600 devices.
>=20
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>

Is this tested on real hardware?

/Sean


