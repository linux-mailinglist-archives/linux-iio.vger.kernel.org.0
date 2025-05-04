Return-Path: <linux-iio+bounces-19069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E762AA88F6
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 20:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBCF188E701
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DC5247297;
	Sun,  4 May 2025 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbczJnAe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEEF2260C;
	Sun,  4 May 2025 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746383231; cv=none; b=Q+L5UhhtCa3jd4Au7tya1B8khFt66kFpuqzZW7pCAi0eupm8DiFTqof2wjiWw9vajAVA6Rq15FRdiGCJg2X08G4pR24PpxhHEuF62Nykj2PyCHOcnlCF0xYTaoxSFgHvaH3oPRtnjsaS43b6csdsCtTA4mDf+0TSekFPvghN/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746383231; c=relaxed/simple;
	bh=GU63tQ4FgCaQDz7W9nU3sPlWrl+5HI0/rUO8dPLyU28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDh1WJH2CkRAF/ZBfBsm6RhB1W9ZBuG5YUxTOZOXjRM6Xaoz5MVzJtCeK5etDSLxC14rfKdH9dWcCEr+EnNvbxZtc9axUSte3rjV5Iyj4Xww05hk0LDgE30/GxvTm8IIhWp+k0/bktbsgjWJFP/NOiHWwZegtMBfL++iL8MqRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbczJnAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7DCC4CEE7;
	Sun,  4 May 2025 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746383230;
	bh=GU63tQ4FgCaQDz7W9nU3sPlWrl+5HI0/rUO8dPLyU28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NbczJnAe6M7TWs76X1WrxewB1xh+VhUKiBfXTK0K3hgQ2AvHEWT+adyS7pPOc0dma
	 i/6aDUILJ6XinZE6+I1S24WHNP32TfrmsjMKqx7cvFYGP/Q3rDJTPt13IirvKC1hS0
	 ENbiTKrXkAAaDsChNBO0ekvyzaFBCoYPfJgvlOCMeG1C43tnL2RMZMQanBx1OKSAPE
	 KXu0iXN7QX1fAzEqZcNcJPWqhS5Je6TDVOYWjrpB7BXg2Zu4uLD0jBWSIvpCar+Uqv
	 2QDdJGmqpDSDmThaPRODBWh5ObZW263d/ZRE47kTktKw0DEtxCiHadufw12LR3/x52
	 8nkAbQYsMqBTg==
Date: Sun, 4 May 2025 19:27:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Document SEN0322
Message-ID: <20250504192701.6ceb9daf@jic23-huawei>
In-Reply-To: <uju5lntp3hzibbrw6ej53xhgvkkpjory74l5et2jspwocuj2xr@bbterxtg3ba7>
References: <20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com>
	<20250428-iio-chemical-sen0322-v1-1-9b18363ffe42@gmail.com>
	<9463c3b0-ce67-4c67-a8e9-91b4ffd09a58@kernel.org>
	<uju5lntp3hzibbrw6ej53xhgvkkpjory74l5et2jspwocuj2xr@bbterxtg3ba7>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Apr 2025 16:45:32 +0200
T=C3=B3th J=C3=A1nos <gomba007@gmail.com> wrote:

> Hi!
>=20
> > No other properties like supplies or configuration? If so, this could go
> > to trivial-devices. =20
>=20
> I don't think so, I'll add it as a trivial-device then.

vcc-supply?

It is very common to see later boards have controllable supplies
(or someone to enable that on an existing board for power saving) so
good and trivial to support just turning the supply on when we probe
the driver and off when we remove it.


>=20
> > > +      sen0322@73 { =20
> >=20
> > Node names should be generic. See also an explanation and list of
> > examples (not exhaustive) in DT specification:
> > https://devicetree-specification.readthedocs.io/en/latest/chapter2-devi=
cetree-basics.html#generic-names-recommendation
> >=20
> > Choose something from above or similar devices. =20
>=20
> Noted, thanks!
>=20
> Best regards,
> J=C3=A1nos
>=20
>=20


