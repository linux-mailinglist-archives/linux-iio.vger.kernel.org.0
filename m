Return-Path: <linux-iio+bounces-4808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F548BBFF1
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5031F21462
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCAA749C;
	Sun,  5 May 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4Je95PN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ACF747F;
	Sun,  5 May 2024 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714902998; cv=none; b=nSUbuwwSS+4jUfMd4mAhulXEhuNSO+VOlVegyA3G7WszvLeHPHapVxbxgqaJgF2FKWX72z2+H8fKZBvh1HxmZA1k+qBsfgr+hfL2hrGFiURCMAxvJlbG42M5hlPsnP879M0lpM/H68nPwMuuD52wBKqRZ1RqcVgwvfh9SAdr/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714902998; c=relaxed/simple;
	bh=RJoEyeaNd+1gjkvT6NKFCN/wZRe/jMO30zhR/F/DOCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdnNQDhrb0hiwAUpD2+ipMILqBo9Lg3T3+z8Cksgq6on+DtO3VzTYD23roMPfTuBzXhUx34c2gDvEqGKEClwRT0sHKF0DGVrs3G099CxuxJiwyzJ2R3EpjMixF6fHwme4m+ZSOIQRPaCbMn+uwuXr4V7xJ2fZ1EhCRUm86WPcXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4Je95PN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790A6C113CC;
	Sun,  5 May 2024 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714902998;
	bh=RJoEyeaNd+1gjkvT6NKFCN/wZRe/jMO30zhR/F/DOCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d4Je95PNJBrV+V77ZFIVTwKz4lKKWNq8IFTKKunqaavSARY+bzpPmBeDoZs1qBt1k
	 QGXJ4rJIs0TL64GN4slYXusLpK/ACYVe3QfEMEf9KIxXDvFxvS3Hiu2uYOv2bbyidd
	 aPTGlucnVic5P2g+Lqz6HOgdXUQfuA4qiVaIKewLEVeSUR8jBArC3hQ0wlHXz5fLLi
	 cA/N4uLwix9MTsAfQ5QbDFapTZM7Khp9MYC1+d/I7d7mfA0q60989ysGn0sdwqI3zR
	 jZRGDOjKivbZ8aW6CkXGEgVuENTL84IT0aj2u+NzjylRybsR25HOCFDx0W+X5Gc/Ft
	 CeZS8dBHTbwaw==
Date: Sun, 5 May 2024 10:56:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: imu: bmi160: add bmi120
Message-ID: <20240505105625.5edd216c@jic23-huawei>
In-Reply-To: <6e68b278-babb-4567-a0e2-f759abb20126@kernel.org>
References: <20240505-bmi120-v3-0-15cee3d0b2ef@gmail.com>
	<20240505-bmi120-v3-2-15cee3d0b2ef@gmail.com>
	<6e68b278-babb-4567-a0e2-f759abb20126@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 5 May 2024 10:31:23 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 05/05/2024 07:36, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wrote:
> > From: Danila Tikhonov <danila@jiaxyga.com>
> >=20
> > Document bosch,bmi120 compatible.
> >=20
> > Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> > Signed-off-by: Barnb=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> > --- =20
>=20
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> Best regards,
> Krzysztof
>=20
Applied to the togreg branch of iio.git which is initially pushed out
as testing for 0-day and friends to see if they can find anything we
missed.

Note I'll be rebasing on 6.10-rc1 once available and this is now 6.11
material.

Jonathan



