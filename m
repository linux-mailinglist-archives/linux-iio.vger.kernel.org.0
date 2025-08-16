Return-Path: <linux-iio+bounces-22826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FA7B28E38
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9091CE2353
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FE32E612A;
	Sat, 16 Aug 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTh3QbLY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615CB284B41
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351740; cv=none; b=tlHFYQ2dtPuiJda+Wl1YC1pgRM+bx4s1bdbymzcIEJSKk/sCVlYeOM8N9DDUr8HSe++gV0QZV2/n/Py4dUVjseuXSYt0Z13pb3UecMj54Emcrknn7yw5e2cyTY1r/N/oLPXRguaGTBkbCAtzNAgqUCn43pGvfKOsbjQ4rBa6YPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351740; c=relaxed/simple;
	bh=oo1oI8rKsuUr6O/0hsBZUwNfDT0hZGXtjVP7pvTomm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpHAar16gUUz7EDwTrti/ggEBVwV8L/PIvf3WkFPc7dFwGp6NGFjrFOuB9TixI9niIG5CbwfD3aMc/oiuQYyuREiTrVlsd8qNfjeriLMjm/BqlrYmqEEEsJgBbMsO7xqcBzaRyk6OjzGhE8xrRl8wrIspkAeDbn4IuFLyMBGgNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTh3QbLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC41C4CEEF;
	Sat, 16 Aug 2025 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755351738;
	bh=oo1oI8rKsuUr6O/0hsBZUwNfDT0hZGXtjVP7pvTomm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bTh3QbLY6AH4KZPLoGswY+FfxFL+4IPXo9kPpcY3PapG79wehsyrBMHGN9jOhm1Lv
	 BsFPZoqJW1Cz+PgY98/washJ8bK3bVN2XvTdy8FFBw+sYSmFvMOMOFwXzoJKHmuXbm
	 9p5n0FzzwpIZqFjqzIGgWY8ffauXyXpDAZkxrIwpFKkefWgyxcTLfYdU8HZXMcZEBI
	 qUVMrkZZytg9+u8nRUGtnS2qwNlhqgfuo+HY+X1z+y6TjkzJBhz4CrM+vbgQOgz9RT
	 QR3sQSiR1TQ8H69TOXg5tvM6B/GfseAWRrsaXGTyPstKWpUtfyTgVOU1X+dJacgRTF
	 dSzIkvgg7Kb8Q==
Date: Sat, 16 Aug 2025 14:42:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: dac: ad5791: drop unused member of struct
 ad5791_state
Message-ID: <20250816144211.7001b1dd@jic23-huawei>
In-Reply-To: <fbe6c762-d71a-4654-bd58-01063a036ff5@baylibre.com>
References: <20250811-ad5791-drop-unused-v1-1-3412fbf3ba36@analog.com>
	<fbe6c762-d71a-4654-bd58-01063a036ff5@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 13:36:04 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/11/25 11:13 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The regulator pointers reg_vdd and reg_vss are no longer used. So drop
> > them.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > --- =20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>=20

Applied

