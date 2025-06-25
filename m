Return-Path: <linux-iio+bounces-20966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6274DAE90F7
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 00:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D89189D6C0
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714B42F3643;
	Wed, 25 Jun 2025 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="oDW9APQE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9AE1F419B;
	Wed, 25 Jun 2025 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750890021; cv=none; b=q7rab89RP7puqJR7ADTF1r7VSPC/Vfvn/4S/B84J8Y0dAzY1RkZ2/6G/B4T2Abuj5sCNQ6LzZvEmxMUAiUelEeQLkqyyZaqJKLSk+EatnkGZZIlAvAgNwfO0W+uActXOpqG+xaAUtBrWSjdbcyNwyJi/zyh26QWXG6bScVPj81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750890021; c=relaxed/simple;
	bh=E2X8JFzbatE1FCWlY5YF6I83d2kqH95jUGI4Wns86t8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZ2H6YvRYdwnh/8xm1U7nGmTEgGXCgqLC2iE7CXkvmZkPZdzPFGBo9O0aM/pIVueMH9t/KF1RS0vBXKG44UjEIgDgn21uFJ6Enp/6Q1wfNlOnJEQUcaM9y2HtjVrcxdipQERqLQW5+EjmLYlaTf+1PmjPlSmvwt55Tq+dG/Dz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=oDW9APQE; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1750890011; x=1751149211;
	bh=E2X8JFzbatE1FCWlY5YF6I83d2kqH95jUGI4Wns86t8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oDW9APQEaPN0TF9Pbt6GIgp1fNrQT6QgvtjS6i7PVCoh7VEIsUvk6Lt6iUCuh4C8I
	 FRi4/y3YXUj+CmU4Un++R5RuYbR1eCYa0f2ToJp7S5h/Hh+cQyRmnrja1O9ti8jDQl
	 fPkwRn6A5kJ4WJFD6fOsH0GXUgXqvRGkDfLm45m51eF0ZXp34ayUOXa3iEUhc83GVm
	 p1heVjNaZrEHpqfITArKh+T+Rw8MhUCs0ieNTG+obos1E5hkfBc+pdoCQ99ufxRYwz
	 THT+32eC163nLE44gpE5zzKvvwuGyX5aG4MeA0YRc0perPypZnqKqvBK+W9UhtyslT
	 ykjNJ1SNrQEmQ==
Date: Wed, 25 Jun 2025 22:20:01 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, =?utf-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, Danila Tikhonov
	<danila@jiaxyga.com>, Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/3] net: qrtr: Turn QRTR into a bus
Message-ID: <ZUlOGBxe4Dky-Qo1EtYMuS0kDRjYdkqex3qgSiFBkFwIdEUpHjsD2pcl3VvMPjD-ZAeqcP5P40AsSfHtv4fJ8Z8stUu4nwYFw0qt3vtf7yc=@protonmail.com>
In-Reply-To: <20250406170111.7a11437a@jic23-huawei>
References: <20250406140706.812425-1-y.oudjana@protonmail.com> <20250406140706.812425-2-y.oudjana@protonmail.com> <20250406170111.7a11437a@jic23-huawei>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: db9bb8d33409b840d6eaf22ce2cef2153ee0ccda
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Sunday, April 6th, 2025 at 5:01 PM, Jonathan Cameron <jic23@kernel.org> =
wrote:

> On Sun, 06 Apr 2025 14:07:43 +0000
> Yassine Oudjana y.oudjana@protonmail.com wrote:
>=20
> > Implement a QRTR bus to allow for creating drivers for individual QRTR
> > services. With this in place, devices are dynamically registered for QR=
TR
> > services as they become available, and drivers for these devices are
> > matched using service and instance IDs.
> >=20
> > In smd.c, replace all current occurences of qdev with qsdev in order to
> > distinguish between the newly added QRTR device which represents a QRTR
> > service with the existing QRTR SMD device which represents the endpoint
> > through which services are provided.
> >=20
> > Signed-off-by: Yassine Oudjana y.oudjana@protonmail.com
>=20
> Hi Yassine
>=20
> Just took a quick look through.
>=20
> It might make more sense to do this with an auxiliary_bus rather
> than defining a new bus.
>=20
> I'd also split out the renames as a precursor patch.
>=20
> Various other comments inline.
>=20
> Jonathan

<...>

> > + if (!del_server)
> > + return -ENOMEM;
> > +
> > + del_server->parent =3D qsdev;
> > + del_server->port =3D port;
> > +
> > + INIT_WORK(&del_server->work, qcom_smd_qrtr_del_device_worker);
> > + schedule_work(&del_server->work);
> > +
> > + return 0;
> > +}
> > +
> > +static int qcom_smd_qrtr_device_unregister(struct device *dev, void *d=
ata)
> > +{
> > + device_unregister(dev);
>=20
>=20
> One option that may simplify this is to do the device_unregister() handli=
ng
> a devm_action_or_reset() handler that is using the parent device as it's =
dev
> but unregistering the children. That way the unregister is called in the
> reverse order of setup and you only register a handler for those devices
> registered (rather walking children). I did this in the CXL pmu driver
> for instance.

Not sure I understand this correctly. This function is called for all child=
ren when
the parent (the bus) is removed in order to unregister them, so its called =
for all
registered devices under the parent. It's just a wrapper for device_unregis=
ter so
that it can be used with device_for_each_child. If I register a handler wit=
h
devm_add_action_or_reset using the parent device then it seems to me like I=
 will
have to add a new function used as handler for that which in turn goes over=
 the
children and unregisters them (we always unregister all children since the =
parent
will be no more) then I will only be adding an extra layer. I checked the C=
XL PMU
driver but I only found devm_add_action_or_reset used for cleaning up objec=
ts
associated with the device, not removing child devices.


