Return-Path: <linux-iio+bounces-19100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3210FAA9460
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B87D179353
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B647C2561BB;
	Mon,  5 May 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXyG+U58"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C11A2C25;
	Mon,  5 May 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451428; cv=none; b=qb7lU8/+nsfx73tWVJOgo6dl9F/+HyZqwPPwdnxrUebSxoAwKAuOlsB6YMo8EKFz8gZN3VB2ybqHGFS2LB9cZXQMMrgnyf8t/f8bJ9sy9RrIg4cr7pFR3WN5wrbzqSzDSuSS7VK+vNWvhHeTn3Dq5v5ndDAY9gTDQWPB4RUO8fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451428; c=relaxed/simple;
	bh=VKT3aBfYoXH1u6KUim8JNWjyDbLB3L+/vn7uNu6+8DA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+bnHVFP0PxW4AGpXTpnIZLMVSeOPXZjftVkoBLXElEscvmtSK8ViA7aNKJZwmkZj71jbw8N/WNXWRTvLkYqLjRQZcP+DVAEflRNAD+AdyB1wMza4I4eJxc9NUHwjzzYDN1i/MsdOlpuaVA9Raxm+kxoTqrBm3MOWCKqogvDaoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXyG+U58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0F5C4CEE4;
	Mon,  5 May 2025 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746451427;
	bh=VKT3aBfYoXH1u6KUim8JNWjyDbLB3L+/vn7uNu6+8DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TXyG+U58O2CzMBN8byeno/h7NEDMZkyU/O7G2qCRIuNeyoGG04UAWC72Rwy0SM9DD
	 4U3fpKoRNHA/IvP9jPiZZyyPjp5Eqd0cxzhzkVM+rulF/qsgM+N9WXX5sVnS5Y9mLW
	 JHf4YwJGtRiM3PHNtOdWbxPAM8KSry9g2GfKF2azEp0DpkjPKZ61ur/sdc4IKEXpCw
	 U9rfpYQiNunxn1nCH9ma7c5TiOooGRHqy5aVg7bmnWOoOKnpCQRpjN+jBFXSLur9vX
	 Mz1xHVtsYB8vB8F+nxwD8FDH61kV2pRPk6fPWZ3Zhzh/sB7N5638CKHIYKG4MsSzj5
	 JXkCa8gMamBhA==
Date: Mon, 5 May 2025 14:23:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Document SEN0322
Message-ID: <20250505142340.3c74eb23@jic23-huawei>
In-Reply-To: <vz5ndf6mojowehi5b6cz6ljsknnatxg6iomghndbt2ffdld3iu@nywmhejv6oge>
References: <20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com>
	<20250428-iio-chemical-sen0322-v1-1-9b18363ffe42@gmail.com>
	<9463c3b0-ce67-4c67-a8e9-91b4ffd09a58@kernel.org>
	<uju5lntp3hzibbrw6ej53xhgvkkpjory74l5et2jspwocuj2xr@bbterxtg3ba7>
	<20250504192701.6ceb9daf@jic23-huawei>
	<vz5ndf6mojowehi5b6cz6ljsknnatxg6iomghndbt2ffdld3iu@nywmhejv6oge>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 5 May 2025 08:32:02 +0200
T=C3=B3th J=C3=A1nos <gomba007@gmail.com> wrote:

> Hi!
>=20
> > > > No other properties like supplies or configuration? If so, this cou=
ld go
> > > > to trivial-devices.   =20
> > >=20
> > > I don't think so, I'll add it as a trivial-device then. =20
> >=20
> > vcc-supply? =20
>=20
> It has no switchable VCC supply.

Your board may have no switchable vcc-supply. In general someone else's
board with this part in use may well have a switchable vcc-supply.
Ideally the DT binding should support that and the driver should just
turn it on at probe.  A stub / fake regulator will be provided by
the regulator core so there is no need for special handling of boards
that don't have switchable vcc-supply - they will just work.

Jonathan

>=20
> Regards,
> J=C3=A1nos
>=20


