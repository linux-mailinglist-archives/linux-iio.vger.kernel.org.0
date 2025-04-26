Return-Path: <linux-iio+bounces-18681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DACCA9DA5E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 13:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66DD81B6712B
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84D22A1E4;
	Sat, 26 Apr 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiUuYBqZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9972224B08;
	Sat, 26 Apr 2025 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745665833; cv=none; b=YbyMo89nfkGkp33UQruwAbN53wgvP2qcuVGh25BTmsGqUDtXvRMaaiZgG3M+AMTgo6yxrNeQGvu6TsqZ7mmpGXcToMUu4ZC8vgGXlml4woW+XQZ/AeLTAzjF8+cQgRFek5ssOOc/noL3NRU8MSD1hilRoJjJe6gTdYgCkIOqV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745665833; c=relaxed/simple;
	bh=zkUhhV2V3LwDUCcvnbTX0131Q47zFhSElgLFaUOth0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CD5TgWfttuM9XxOcikPdRUUaqxvQ4+ZJ2u1d1iuVfNTQSx1UosGlLA/jsC3wpIr8iF2Qla3TbIsylb7+hS5Cgdg9tO1HcUebii9aUccsULqjrJSvGu0475NgmYT+e1yoE1GL6fCjAFkRUX46wdv0/uRVeXbsZAQW/Cl3Uk8rIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiUuYBqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C443C4CEE2;
	Sat, 26 Apr 2025 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745665833;
	bh=zkUhhV2V3LwDUCcvnbTX0131Q47zFhSElgLFaUOth0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eiUuYBqZS8YVb1rlnlWQv/ZjcuH27pLtIjpPDWC0wyklIksMe5g2rNWRjRqZtogfX
	 oeM4XVphZ5P1X5+FqgMiW771q3s5Xb+NVfQl3Qr8yANDhYjtxQguZwGmnP79TCR0B0
	 pUy72FuPZK+ydO46njSxQN/NV0G6CRbQiqA5ipxyvxOjp9hKUKBDlhBBgGkTC0LzYz
	 1IhA+moo1GC0WSd8gmWHFEpRcfdG28ivNig8XDhbeE7TRQotByQ38y6y3eA9KYIx2q
	 hJxy5y8zLTo4axVi2qMjxxSjaeXaUQlyjng4LwpSqlmns7q72KpjhOrU9UBpF5nCcw
	 OZDREywwEajMA==
Date: Sat, 26 Apr 2025 12:10:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: surajsonawane0215@gmail.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Add sharp,gp2y1010au0f
Message-ID: <20250426121024.3384f49b@jic23-huawei>
In-Reply-To: <20250425215149.49068-1-surajsonawane0215@gmail.com>
References: <20250425215149.49068-1-surajsonawane0215@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Apr 2025 03:21:49 +0530
surajsonawane0215@gmail.com wrote:

> From: Suraj Sonawane <surajsonawane0215@gmail.com>
>=20
> Add Device Tree bindings for Sharp GP2Y1010AU0F optical dust sensor.
> The sensor measures particulate matter concentration via infrared
> scattering and requires:
>=20
> 1. GPIO for LED pulse control (280=CE=BCs pulses with 40=CE=BCs delay)
> 2. ADC channel for analog output measurement
> 3. Power regulator (vdd-supply)
>=20
> Datasheet:
> https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au=
_appl_e.pdf
>=20
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
Hi.  Quick process thing.

Even for a small series, please use a cover letter to provide:
- a short intro to the patch set=20
- A nice name for patchwork and threading email clients!
- Somewhere for people to give patch set wide comments / review tags.

With git that just means passing --cover-letter to git format-patch
+ filling in the resulting file.

Jonathan

