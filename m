Return-Path: <linux-iio+bounces-8420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD2894EF7D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 16:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71FAB1F22636
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 14:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D0181B99;
	Mon, 12 Aug 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="LVfuYX4e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0D1802A8;
	Mon, 12 Aug 2024 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472812; cv=none; b=Bgl6HeTDnfB6Ybcm31DDL2JhnV5e9Aw9GP8EzSRMlWtDWig9iSc7cUydwpjDjOthFqwuDOnApZygavdLI0EMboguJnIkzSG3+SGP1dEy+SobdgfztbaAJH0BO/ux1YIaSGQ+8IR6AxDlX6WdQp3dGl5wqQPG27KUotiENC1rnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472812; c=relaxed/simple;
	bh=Z2HFOfjkqpuNPRU5xvNp/o/3h1cZFd8qwyhEuifTHbw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dnrj3Jm4uYd3ea9elM655J0ELneUnWA+pMBSq6WtTwrvYt8tgkfl2MFTsWuIxrqRdaMSXbOjb3eGcKhEyjeLcwkCi7tk6NNimC7qzjaXbxsu/V5gz7NeStY8WmuK+aACRsbSewwgfjqaO79DY3A5Z6TlSaZcX3Iobza3+1pg780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=LVfuYX4e; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [127.0.0.1] (254C2B9B.nat.pool.telekom.hu [37.76.43.155])
	by mail.mainlining.org (Postfix) with ESMTPSA id A955FE44F4;
	Mon, 12 Aug 2024 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1723472807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wYbV2RQjmAPfOTIkzvKNcHXOyYqFslEi5s+M+4EYXo=;
	b=LVfuYX4eCMzcsrCX55kTNFDR9vePlhb1lPilXaXF/4XGeit+PUcDYwjGcZnE8/yjzX8EeW
	Fhvrnwe7HghNEY6oXJPpfBqrhH+0+gCaxzWBIRTZZzPLiTe3Pc1FRF+As8VxHrkBmgFTST
	wp0wgEfcOCKEbjCBFoDEuQqHB//ZL0o6LlLstME+OVnlDvlB/mqMCEcD0+OH3xmd3xvmE2
	Q1txPiIjjDDthq7O3woxB3upvu89p/iR8J3GxaqOvM8x3+9b2eTYXwYmOA4IW4gy+fKSp/
	DA1nHT0uQC68iCVSOjDfVkbIQ0dJf/+zKe9xJcq8673VVdWuhERQN53ccTPSCg==
Date: Mon, 12 Aug 2024 16:26:47 +0200
From: =?ISO-8859-1?Q?Barnab=E1s_Cz=E9m=E1n?= <barnabas.czeman@mainlining.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@mainlining.org,
 Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v2 3/3] iio: magnetometer: ak8975: Add AK09118 support
User-Agent: K-9 Mail for Android
In-Reply-To: <2204a0e8-c9fc-446c-96f5-3dee1b92900e@kernel.org>
References: <20240806-ak09918-v2-0-c300da66c198@mainlining.org> <20240806-ak09918-v2-3-c300da66c198@mainlining.org> <2204a0e8-c9fc-446c-96f5-3dee1b92900e@kernel.org>
Message-ID: <D512EC2B-EB5E-416E-AB45-0893A9CA0343@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 7, 2024 8:04:19 AM GMT+02:00, Krzysztof Kozlowski <krzk@kernel=
=2Eorg> wrote:
>On 06/08/2024 08:10, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wrote:
>>  };
>>  MODULE_DEVICE_TABLE(i2c, ak8975_id);
>> @@ -1081,6 +1114,7 @@ static const struct of_device_id ak8975_of_match[=
] =3D {
>>  	{ =2Ecompatible =3D "ak09912", =2Edata =3D &ak_def_array[AK09912] },
>>  	{ =2Ecompatible =3D "asahi-kasei,ak09916", =2Edata =3D &ak_def_array[=
AK09916] },
>>  	{ =2Ecompatible =3D "ak09916", =2Edata =3D &ak_def_array[AK09916] },
>> +	{ =2Ecompatible =3D "asahi-kasei,ak09918", =2Edata =3D &ak_def_array[=
AK09918] },
>
>I think you might need to rebase on top of Jonathan's branches=2E=2E=2E
>
Which barnch?
>Acked-by: Krzysztof Kozlowski <krzysztof=2Ekozlowski@linaro=2Eorg>
>
>Best regards,
>Krzysztof
>

