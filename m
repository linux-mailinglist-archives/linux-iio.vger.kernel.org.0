Return-Path: <linux-iio+bounces-19549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADDFAB8CBC
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 18:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF644C71B4
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E125922F75C;
	Thu, 15 May 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpvpPDgd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65E22DFB1;
	Thu, 15 May 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327463; cv=none; b=fuJzgBWnFcwAiiyT8RtFSANWD/goyxRI9nVtXYr2FxstnApkCx9sEDgRvmNeN8APw3O3VXrE6Ner2sX8sjZ378Pj+0d2kFIP0lRCLovD4y5lkfK836iyETAl14UYKt4UnZOxx9w0SLEUc3H1B4ED4OWy04tavVBXtYACLiCGnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327463; c=relaxed/simple;
	bh=5UwQbhuNjFGZo6RKdVNTzky/Efdd8Q0+VemdjCv8GgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wftv9kzpZVPrCPkQoj4IfeZWSdwLoGuVRavALxaQpBaEueQrCQoIeLlLDDShqgtiqL3rcPB0bIqDt45zmof6HOi12boMG2vcvkc7yuJozhZvrVfujcog7RLaa4JBLiatXkiaEwpVJqv459TISSpv4P1jsgcKLmib4IH0oDOjRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpvpPDgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BECC4CEE7;
	Thu, 15 May 2025 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747327463;
	bh=5UwQbhuNjFGZo6RKdVNTzky/Efdd8Q0+VemdjCv8GgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qpvpPDgde1MeBaEmPhmrJXybCYuIJXGBoAFCjd7dWpEJDo8+yHDnecRUWARKjDV++
	 MrT/2afhjbPoIITDJU7iU2BotQmZRTr8mkE0+zmdTPNTJYvFdIMDA36C958qPIRwV9
	 u0ThZeBsDC/UEgHeuLJVYyh6WIHLdhWXr0GBpo+2o3YniXpYzrDc2anEGJm0Rb82gM
	 wzxSCbFKZExKBd4+1vbOmL8kOrXM6/txVXHUOShzaw06k/aTsBio84hQCl8APn2puM
	 bxOp+W/FldIXD1ql8amrCWEtSdGVYo2ivu09llA0RDK2uwG5rvE8JTzdCJnO3MOYzg
	 yuaRblVzvpSPQ==
Date: Thu, 15 May 2025 17:44:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?VMOzdGggSsOhbm9z?= via B4 Relay
 <devnull+gomba007.gmail.com@kernel.org>
Cc: gomba007@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: chemical: Add driver for SEN0322
Message-ID: <20250515174416.0d5c49cc@jic23-huawei>
In-Reply-To: <20250506-iio-chemical-sen0322-v4-2-1465ac8dc190@gmail.com>
References: <20250506-iio-chemical-sen0322-v4-0-1465ac8dc190@gmail.com>
	<20250506-iio-chemical-sen0322-v4-2-1465ac8dc190@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 06 May 2025 11:01:16 +0200
T=C3=B3th J=C3=A1nos via B4 Relay <devnull+gomba007.gmail.com@kernel.org> w=
rote:

> From: T=C3=B3th J=C3=A1nos <gomba007@gmail.com>
>=20
> Add support for the DFRobot SEN0322 oxygen sensor.
>=20
> To instantiate (assuming device is connected to I2C-2):
> 	echo 'sen0322 0x73' > /sys/class/i2c-dev/i2c-2/device/new_device
>=20
> To get the oxygen concentration (assuming device is iio:device0) multiply
> the values read from:
> 	/sys/bus/iio/devices/iio:device0/in_concentration_raw
> 	/sys/bus/iio/devices/iio:device0/in_concentration_scale
>=20
> Datasheet: https://wiki.dfrobot.com/Gravity_I2C_Oxygen_Sensor_SKU_SEN0322
>=20
Datasheet is a tag so no blank line here.

> Signed-off-by: T=C3=B3th J=C3=A1nos <gomba007@gmail.com>

Will shortly appear in the testing branch of iio.git.  I'll push it out
as togreg once it's had minimal 0-day build coverage.

Applied with this diff:
diff --git a/drivers/iio/chemical/sen0322.c b/drivers/iio/chemical/sen0322.c
index 088f8947083e..96c6fc1203ad 100644
--- a/drivers/iio/chemical/sen0322.c
+++ b/drivers/iio/chemical/sen0322.c
@@ -28,7 +28,7 @@ struct sen0322 {
=20
 static int sen0322_read_data(struct sen0322 *sen0322)
 {
-       u8 data[3] =3D { 0 };
+       u8 data[3] =3D { };
        int ret;
=20
        ret =3D regmap_bulk_read(sen0322->regmap, SEN0322_REG_DATA, data,
@@ -42,9 +42,7 @@ static int sen0322_read_data(struct sen0322 *sen0322)
         * but it is multiplied by 100 here to avoid floating-point math
         * and the scale is divided by 100 to compensate this.
         */
-       ret =3D data[0] * 100 + data[1] * 10 + data[2];
-
-       return ret;
+       return data[0] * 100 + data[1] * 10 + data[2];
 }
=20
 static int sen0322_read_scale(struct sen0322 *sen0322, int *num, int *den)


> +
> +static int sen0322_read_data(struct sen0322 *sen0322)
> +{
> +	u8 data[3] =3D { 0 };
Slight preference for { };

> +	int ret;
> +
> +	ret =3D regmap_bulk_read(sen0322->regmap, SEN0322_REG_DATA, data,
> +			       sizeof(data));
> +	if (ret < 0)
regmap is always 0 or < 0 so checking just if (ret) is cleaner.
> +		return ret;
> +
> +	/*
> +	 * The actual value in the registers is:
> +	 *	val =3D data[0] + data[1] / 10 + data[2] / 100
> +	 * but it is multiplied by 100 here to avoid floating-point math
> +	 * and the scale is divided by 100 to compensate this.
> +	 */
> +	ret =3D data[0] * 100 + data[1] * 10 + data[2];

return data[0] ...

If nothing else comes up I'll fix this.

> +
> +	return ret;
> +}

