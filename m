Return-Path: <linux-iio+bounces-26089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999CDC44227
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0903AAE1B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5A92F7460;
	Sun,  9 Nov 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrtT4hgY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B086349;
	Sun,  9 Nov 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704982; cv=none; b=mI/jfwxcJZmQFgsk1KHqx1iNk4yJam49N4ebsfus/7j8AOG+udV5NaYhF3B0q+iu02FGMMZbhHnkLbPNCU9T8/PXizENJb/bIUPR/KT2iNiIVHa9RdGN4a62zj2YLn7Ku5UwIt3YQ1kmgpa0virU7jyj25acxgpHDIQeyDEJL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704982; c=relaxed/simple;
	bh=mbzWAPQFlOl1oCaNGr40fAiemEBWBfAy+D4WRZzrm/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etEEzK9yn71zF0iqcvMXYdIAKXA/pc5sBtxPW+GatmC57APAO7GV5P7CxJZFjxJ00+U1RJnLukD/Wz1wXI0r3u5RQxBOAriNu9LW/dAryTd4a8Z8dyKHt4nL7U4k4OCfio3jO8v7SBetIymAGH0tErP6QpFIK6lOeK8FWmt1vlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrtT4hgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D73C4AF0C;
	Sun,  9 Nov 2025 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762704981;
	bh=mbzWAPQFlOl1oCaNGr40fAiemEBWBfAy+D4WRZzrm/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HrtT4hgYz2HLEe0s3c8DozNydX3tMpT+gUyr4if767s9UytolCQemWC48tsTkvvbk
	 NWLrjdvmvA/iLUO8bb61Xt2JZDBJRZsc+eDFtY+SeSOJpm0Y42zdyhy8Omig2XjPQX
	 bcstO+G/xl0wiZzMgsboWj1WzQ3aAz0UfBZwFXSELAaJXqmuYqOQtqrRhYpkpZGQf1
	 S4ovXjWkiAi1iXxMivCJ4JuRv2G/wUhSzpSbNq3jPzLkTLomyVjFtl0w6NxAVXmZPL
	 AOLlrJhnV3UB0ff6lMkeyCiDnsRK1LwP9Czc9B09dfyXwTm4k1sWl4sliAOvH2HjzR
	 9Cr/iGgHRFFjA==
Date: Sun, 9 Nov 2025 16:16:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 07/12] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
Message-ID: <20251109161614.671ab74b@jic23-huawei>
In-Reply-To: <20251104-dev-add-ad5542-v4-7-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-7-6fe35458bf8c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Nov 2025 15:35:12 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Properly separate the I2C and SPI drivers into two different drivers
> living in their own source file (as usual). So that no need for the
> hacky ifdefery.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied in a fairly manual process due to earlier tweaks. Please sanity che=
ck
I didn't mess it up!

