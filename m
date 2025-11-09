Return-Path: <linux-iio+bounces-26088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24668C44218
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5E02347366
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E59E3009E3;
	Sun,  9 Nov 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBLwlYhL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831A3009D5;
	Sun,  9 Nov 2025 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762704842; cv=none; b=Xavg1Aw0+QyP+n5IKPBH/LuDgdDbsBc+L0LeNVycH/WHIV7ov9HPSbprpHogbQT3knrMXq38VDuthy1sJBNjDi271RiU/Ab53s3FT0XkFB7tLeOGrVvJcYlgLmMkcHfsqYX5KFOVTQwyQV7Q2akILrGfcR4fUMH2Ez8gA7D1Zb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762704842; c=relaxed/simple;
	bh=TKdImny5B3JXh8fsPCk86DfTcaPYrn55DpLH2FY9rcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdUtLb3aLKuFEmtqINZU/FToxhWV8hwVy8nNua1apHoUH+224n5FZVz+x/OAGAgQ3yeb6ppjiTqVCBVD2aNKhWwS3GzSwA2d6htxc1mTgB1TV7SDS2Ue+njimEldn2J1Vyp8Cr57NOs/oDzVkMllBjY3S5T2C8PHzzwYJmBPAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBLwlYhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0CFC4AF09;
	Sun,  9 Nov 2025 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762704840;
	bh=TKdImny5B3JXh8fsPCk86DfTcaPYrn55DpLH2FY9rcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gBLwlYhLSbgP9Jg68riZIEu7tBl++Diag7OCdMBIdttlSW/JjniECdl7VIIqkMAwg
	 bVOAvHXKJJ428vY1l6iUkpa8RIrchcos2FxqCKJrSv6vTajwWqQ2bYziKGHZvuNw//
	 vrymsO0V9KAS/Be3KYPvZAcLIk3SqEjTmIqxdsSCZ6gwm1+LhS7zernDvkXn+QCb9h
	 9fcsRdf4w1S+ubtWoCcVU2zPDsMt+L0LhSzPwf6jdAxvZ8U24T4rZ5Zvq9DMqgxTWV
	 NudzxKdWsHL3fbtyAvWDgQi58hzgzE92J7NZIODyM1xwtupBthXH83YwhXeXnZILZX
	 z1oZ1G9TlSoFg==
Date: Sun, 9 Nov 2025 16:13:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 06/12] iio: dac: ad5456: Add missing DT compatibles
Message-ID: <20251109161353.3346aab0@jic23-huawei>
In-Reply-To: <20251104-dev-add-ad5542-v4-6-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
	<20251104-dev-add-ad5542-v4-6-6fe35458bf8c@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Nov 2025 15:35:11 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Add missing of_device_id compatibles for the i2c and spi drivers.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.

