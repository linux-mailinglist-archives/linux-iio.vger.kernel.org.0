Return-Path: <linux-iio+bounces-21467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A698AAFE18E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85343B4E22
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E6271456;
	Wed,  9 Jul 2025 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="U+l7Vgco"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CA2701CE;
	Wed,  9 Jul 2025 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047104; cv=none; b=cRPohmC3m87sFA/wvp1N4HGfL9YBwrF/2ZNmmpdQ7h8raBUj3Jnj1cJ6GohGxm8OX+1Nz0kYI18ZXqCk6uab7dHwAPCUmEUqeXfUb66W2t54Srmt7Kswe8gs5gAw9NenutSk7H5A1nNaoEZJLQokHMusQfLPMqIMlmVCelWf+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047104; c=relaxed/simple;
	bh=f8alaJu9QGnxkHKJvU+EAqsIi5uNm0RpUbioG++EzEo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8KHV8FcvjKPzqJsn608TXSXrB2Ok2+lhZZU2LEI5euu4yaUn00/3YGBLJ7U3ujcdB0fMLKyOe6zMycimEqUF6/Pe/6vj3PIGtNJzgJZX+u2eOVljG5z425NilPa+4npfLTX4f/caELwu/xZwtVYUmdrUG0JVI9FO0y8lxk8VcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=U+l7Vgco; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1752047098; x=1752306298;
	bh=f8alaJu9QGnxkHKJvU+EAqsIi5uNm0RpUbioG++EzEo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=U+l7VgcozOyYLykbS3qLvCc9HMc0Vi3UZsII0/jmMc/Zi+ap0gI1EonO0CiHymocP
	 UXxP29lSmf9pq6A4EEkiCvUkUADDj3RTEZUGGOSWgizh7PPvqlqyWVcjQzQwgsGQNk
	 PPwFx6W0dsQkFixQjE0AUAM11TgZVLKku2guLBx+DiHTpw5UMlx656MmCew3W92SlQ
	 geWc2sclYkS8i2pU7VWMojmRaYnLIcYHfkEPFkfxY/Y4nxDMPXCiRZyJA4MXypxmU8
	 KIXRu1J7hZ2yF7ZiZpMr1di7GIkDrN2GwrzEXVSUBPoAvlMRI1JSnsfvzfCi+BRfQi
	 6e8EbSIJULohw==
Date: Wed, 09 Jul 2025 07:44:49 +0000
To: Simon Horman <horms@kernel.org>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, =?utf-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?=
	<barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>, Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/3] net: qrtr: Define macro to convert QMI version and instance to QRTR instance
Message-ID: <X2KJB3xtnC-pWM7o5TBw6ln3ItpMwn7tdn5Z8gpZY3oW31isE8PLTX5GUbJ6HcZk_9s72jb6ImwGL-anIoto4dK1MINTxzdRKfbejp_nXcA=@protonmail.com>
In-Reply-To: <20250707170636.GR89747@horms.kernel.org>
References: <20250406140706.812425-1-y.oudjana@protonmail.com> <20250406140706.812425-3-y.oudjana@protonmail.com> <fb61323b-aabd-4661-a202-02da7da557ea@oss.qualcomm.com> <aMbAZigHiAN2xupOYs9DodY2mOdNtw_oVjOaweflgA8IoXRQ5ctoZ8GYJ8PNAKDgL4f9N_UD7tFmkePUy9BCE8v20Mae2x-eL1ZpyJEdLZY=@protonmail.com> <20250707170636.GR89747@horms.kernel.org>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 8f8894673857ba0bbc9a24fcb09c28e5f1c802d5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






Sent with Proton Mail secure email.

On Monday, July 7th, 2025 at 6:06 PM, Simon Horman <horms@kernel.org> wrote=
:

> On Sat, Jul 05, 2025 at 06:29:39PM +0000, Yassine Oudjana wrote:
>=20
> > On Wednesday, April 9th, 2025 at 3:54 PM, Konrad Dybcio konrad.dybcio@o=
ss.qualcomm.com wrote:
> >=20
> > > On 4/6/25 4:07 PM, Yassine Oudjana wrote:
>=20
>=20
> ...
>=20
> > > > diff --git a/include/linux/soc/qcom/qrtr.h b/include/linux/soc/qcom=
/qrtr.h
> > > > index 4d7f25c64c56..10c89a35cbb9 100644
> > > > --- a/include/linux/soc/qcom/qrtr.h
> > > > +++ b/include/linux/soc/qcom/qrtr.h
> > > > @@ -13,6 +13,8 @@ struct qrtr_device {
> > > >=20
> > > > #define to_qrtr_device(d) container_of(d, struct qrtr_device, dev)
> > > >=20
> > > > +#define QRTR_INSTANCE(qmi_version, qmi_instance) (qmi_version | qm=
i_instance << 8)
> > >=20
> > > Please use FIELD_PREP + GENMASK to avoid potential overflows
> > >=20
> > > Konrad
> >=20
> > Since I'm using this macro in initializing QRTR match tables I am unabl=
e to use
> > FIELD_PREP. When I do, I get such errors:
>=20
>=20
> Does using FIELD_PREP_CONST, say in a QRTR_INSTANCE_CONST variant, help?

That works, but do we want to have two variants? Or in this case maybe
I should leave qmi_interface.c untouched and define the macro only for use
in match tables?

>=20
> > In file included from ../arch/arm64/include/asm/sysreg.h:1108,
> > from ../arch/arm64/include/asm/memory.h:223,
> > from ../arch/arm64/include/asm/pgtable-prot.h:8,
> > from ../arch/arm64/include/asm/sparsemem.h:8,
> > from ../include/linux/numa.h:23,
> > from ../include/linux/cpumask.h:17,
> > from ../include/linux/smp.h:13,
> > from ../include/linux/lockdep.h:14,
> > from ../include/linux/mutex.h:17,
> > from ../include/linux/kernfs.h:11,
> > from ../include/linux/sysfs.h:16,
> > from ../include/linux/iio/buffer.h:9,
> > from ../drivers/iio/common/qcom_smgr/qcom_smgr.c:8:
> > ../include/linux/bitfield.h:114:9: error: braced-group within expressio=
n allowed only inside a function
> > 114 | ({ \
> > | ^
> > ../include/linux/soc/qcom/qrtr.h:21:10: note: in expansion of macro 'FI=
ELD_PREP'
> > 21 | (FIELD_PREP(GENMASK(7, 0), qmi_version) | FIELD_PREP(GENMASK(15, 8=
), qmi_instance))
> > | ^~~~~~~~~~
> > ../drivers/iio/common/qcom_smgr/qcom_smgr.c:825:29: note: in expansion =
of macro 'QRTR_INSTANCE'
> > 825 | .instance =3D QRTR_INSTANCE(SNS_SMGR_QMI_SVC_V1,
> > | ^~~~~~~~~~~~~
>=20
>=20
> ...

