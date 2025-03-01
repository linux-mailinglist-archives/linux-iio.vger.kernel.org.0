Return-Path: <linux-iio+bounces-16219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDF6A4A857
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 04:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3198189C334
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 03:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA6E1957FF;
	Sat,  1 Mar 2025 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emgao7PL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A032CA8
	for <linux-iio@vger.kernel.org>; Sat,  1 Mar 2025 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740800258; cv=none; b=MiVrU2kSMyvo+Kc4Ttz3SnHFdAb+nfWPRVkykD9gU6zlNz+XUP3hGOO99NEKjm1IXzLvioBi9WiU9dKFFV/XXCqLpwQY08E5pUbolwxoAIN3O/KaA/DGDiW4o3MeDcRIYFcKON8uhXUavm/Z7qkHOcqNmF/GRkGaWdzxQxOKqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740800258; c=relaxed/simple;
	bh=cCfopytUMf3QAzoSoyq5VhDfeIggBrnnUAakUZWY4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrikYJuH1M8vSvODb6T/pISLYmTGI2WPMMNQTj0hkT70dwblvPIqGF7N0+Djdkjjc+seqoKkcwX+cYuMp2kG3pwThyPDImpgAkhDSs2slyo1WsYqZxlsB/Qzr8IaKFkQTBw0mLK2sgEiYXwWQQ3bp5yy6gxQsoONnaC0TLJgLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emgao7PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419F5C4CEDD;
	Sat,  1 Mar 2025 03:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740800257;
	bh=cCfopytUMf3QAzoSoyq5VhDfeIggBrnnUAakUZWY4Do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=emgao7PLQEIZEllDd2q6ZXI3TZ9FabPDdutWvD27wCvTep8o8rBBMr3I4Bg5A+2fN
	 /mfywzoJfdUmiNOCjFaGag/IXD5lAWn+vFUI6kf8aUxmwvFIsbP47GSvOIUCzGHEO1
	 lnbLR4Q7b4X3jQLB01SPnFBtv8KiC7UelqxCXtBbI06JfPAGuvMkk/aeaKwnTO2BrR
	 R01Wi7G7AJei7v40Dp6a1X4wErAZfiJEkHQkqNOIXdTBIytKL+Vvymo/I8X67zr8s7
	 fOOTExnQ6/1Z+e0yZjJLIHvzOR5zjN1M1CVGVrD7SHVg1NIBHCJljXLJR/t7YFi0Qu
	 kwuobFpabhLHg==
Date: Sat, 1 Mar 2025 03:37:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: replace of.h with
 mod_devicetable.h
Message-ID: <20250301033725.2718db6c@jic23-huawei>
In-Reply-To: <7416028f78ba0e10e8d1722edd67756e13c3867b.camel@gmail.com>
References: <20250218-dev-axi-adc-fix-headers-v1-1-5ddc79221d8c@analog.com>
	<Z7o62qQDyWLk642C@surfacebook.localdomain>
	<7416028f78ba0e10e8d1722edd67756e13c3867b.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Feb 2025 09:18:38 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2025-02-22 at 23:00 +0200, Andy Shevchenko wrote:
> > Tue, Feb 18, 2025 at 10:34:57AM +0000, Nuno S=C3=A1 kirjoitti: =20
> > > Don't use of.h in order to include mod_devicetable.h. Use it directly=
 as
> > > there no direct dependency on OF.h =20
> >=20
> > ...
> >  =20
> > > =C2=A0#include <linux/delay.h>
> > > =C2=A0#include <linux/module.h>
> > > =C2=A0#include <linux/mutex.h>
> > > -#include <linux/of.h>
> > > +#include <linux/mod_devicetable.h>
> > > =C2=A0#include <linux/platform_device.h>
> > > =C2=A0#include <linux/property.h>
> > > =C2=A0#include <linux/regmap.h> =20
> >=20
> > Can we preserve the alpabetical ordering?
> >  =20
>=20
> Ups, my bad. Jonathan, should I re-spin or can you directly tweak it?

Tweaked. =20

Thanks,

Jonathan

>=20
> - Nuno S=C3=A1


