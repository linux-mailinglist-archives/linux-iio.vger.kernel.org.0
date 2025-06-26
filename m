Return-Path: <linux-iio+bounces-20977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0B5AEA57B
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 20:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2874A3998
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5EF2EE998;
	Thu, 26 Jun 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmHSz1L+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA242EE980
	for <linux-iio@vger.kernel.org>; Thu, 26 Jun 2025 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962974; cv=none; b=VyvaAYt1zMkeiunwX++ao3Em8T8bJqoEay+JMNgv2fw6OtjRjJ5v4qrQWxeLvbXyi38pJsepitmSzB4g/CZ0aXpMhPJiEUFcXmfanbuLSJgpksh68y4+hLsrJH+CBMWT5D7eLKAdYsnRsTENDDT7VB/ksyDdrIhOUG7nG1+9fdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962974; c=relaxed/simple;
	bh=E+YBcEYOClsPrhsze8jM1kDInoFTWcDLPX470wIGZmo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT0aOfH7EgO3bn3ypinuQqJmRm6cxYwJs2cXfa1E7NDlSdfn65R4kM0EqgsigAVwA468K5lIdvjfX6otEt1x4c/Cufto9CHMEKVogKmdJYLMuduCP5E3BoY6AY8GRT5NphoubH8VdFJFujRDDp4vfouEyKnRy3zDV+3YBTAllSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmHSz1L+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE49C4CEEF;
	Thu, 26 Jun 2025 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962973;
	bh=E+YBcEYOClsPrhsze8jM1kDInoFTWcDLPX470wIGZmo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JmHSz1L+xliYQzs/2tdjA8QxO0b3z05N1JJCnKlHoWd6uJEj0cYwOUkJFSwW7wj9O
	 QD2/cdAEj6pPTCUYr8tx2CcBXjU+MxKOq8dRWE+NdLc3XZ5Dq+87Rn5hTxHQgrb2MT
	 u41Vn9Dr9SKTXUw8JYvBvtEL6B1CCXIP7TRUZbHQgAyda9oYmf3xJZnrrv/ZDTNTZZ
	 TF5Iskf+6wQ4ME9AXRZ5lsujmod+925cwUVcwelIB5FrnhsOnyr/QlmRWEkgFuWAPy
	 haIAdiCiz/JZWDcl8VV3e6dLdd9OdfdE+NuFhe3MyOi5bzK3F0r30/U7mrxmE/IOob
	 Kvs0S7c8hHMIw==
Date: Thu, 26 Jun 2025 19:36:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "=?UTF-8?B?Q8Opc2Fy?= Bispo" <dm.cesaraugusto@gmail.com>
Cc: jonathan.cameron@huawei.com, cesar.bispo@ime.usp.br,
 gabrielfsouza.araujo@usp.br, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: qcom-pm8xxx-xoadc: Use
 devm_iio_device_register() and dev_err_probe()
Message-ID: <20250626193606.50f88b75@jic23-huawei>
In-Reply-To: <20250625132747.104782-1-cesar.bispo@ime.usp.br>
References: <20250625101119.00003c34@huawei.com>
	<20250625132747.104782-1-cesar.bispo@ime.usp.br>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Jun 2025 10:27:27 -0300
"C=C3=A9sar Bispo" <dm.cesaraugusto@gmail.com> wrote:

> From: Cesar Bispo <cesar.bispo@ime.usp.br>
>=20
> Hi Jonathan,
>=20
> Thanks for your feedback.
>=20
> Just to clarify, the use of `devm_iio_device_register()` in this patch wa=
s based on your previous suggestion [1], so I assumed it would be appropria=
te in this context.
>=20
> I now understand there might be a risk of userspace-visible interfaces pe=
rsisting after the device is powered off, which could lead to race conditio=
ns.
>=20
> Would you recommend dropping the `devm_` conversion for now and only keep=
ing the `dev_err_probe()` change?
>=20
> I'm happy to send a v2 accordingly.
>=20
> [1] https://lore.kernel.org/linux-iio/20250607163353.47e83e77@jic23-huawe=
i/

I was suggesting the use of devm_iio_device_register()  'on top' of the cha=
nges
in that patch. My confusion here is that you've sent out code based on the
tree before that patch and hence the regulator handling is still manual.

Looking again at that patch it has a bug. Replied there and dropped that pa=
tch.


Jonathan

