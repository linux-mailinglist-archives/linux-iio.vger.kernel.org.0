Return-Path: <linux-iio+bounces-9834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F97B989028
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD71628209A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E8436B11;
	Sat, 28 Sep 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8MvGkl8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D919470
	for <linux-iio@vger.kernel.org>; Sat, 28 Sep 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727538679; cv=none; b=e8OZ28xokdGi4OsAgpYjQZcQMPakwUZGMnUFw/tMrKlQuOOIevTDIwUMwAwrR2g3aXuQTFX4Z4CzmoPdm9IZZmJkrqiDffCafPecxvawD90fcBnAdi8HXTRUOk++vsWcSPcY7bOB3nmyiMdJzs3FWXqOPxcmC2RItbXLXJHXIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727538679; c=relaxed/simple;
	bh=HpEMW1MoygxRljdXodG+CRKHHTCdHnfuImg1l+DpSDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3GCHQ1icDnnhCZGCuo1pc48k3bMSbX4aDqv0ffNcyBPWFwwwgtqJ70hNU2/Q1kyIcNfo4rIawK4yDGOH0zen0RtlrXa5JEPbU26JbbBcY2NhkKuiA9xmsuMNWFoQTpFRY4G9SDQiy24X8r/xuQCGz5rxRT/O43HyS9MLBcFOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8MvGkl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C250C4CEC3;
	Sat, 28 Sep 2024 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727538678;
	bh=HpEMW1MoygxRljdXodG+CRKHHTCdHnfuImg1l+DpSDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E8MvGkl81b3q59RqG28CEz+IGCLiddLevNKig28illFcqeVDooVIJdVo6seHLDe0n
	 RSn14kHnWGrC9JQ4m8Munntadge6O2UjMb3ezZz9Hn7B3CygnQ9PD2+ZTzrgJ57mFx
	 JbesrML1/2Gwc6q2nANS5W1NcuBy4lUz+gwCfrznszeUU5z5nlkyevWgFQEOXlV2FQ
	 7TWLP7W+GGH5vFX1N+J4CMtEIZbx99QUsA9bEzmGC5zTx73zP5+x5mm6hEnkptSOJ8
	 O9/RAQJBBvAdn1KfFh/EDHueVEVqrCnSfbjZAjna2WqDQxfbuvKFFl4QY3f2MpKSoW
	 CV0QguXVYv3QA==
Date: Sat, 28 Sep 2024 16:51:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Francesco Dolcini <francesco@dolcini.it>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Drop explicit initialization of
 struct i2c_device_id::driver_data to 0
Message-ID: <20240928165112.229d2fa3@jic23-huawei>
In-Reply-To: <20240920161847.pcf73idvu455nyj3@joaog-nb.corp.toradex.com>
References: <20240920153430.503212-11-u.kleine-koenig@baylibre.com>
	<20240920161847.pcf73idvu455nyj3@joaog-nb.corp.toradex.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Sep 2024 18:18:47 +0200
Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gmail.com> wrote:

> On Fri, Sep 20, 2024 at 05:34:29PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > These drivers don't use the driver_data member of struct i2c_device_id,
> > so don't explicitly initialize this member.
> >
> > This prepares putting driver_data in an anonymous union which requires
> > either no initialization or named designators. But it's also a nice
> > cleanup on its own.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =20
>=20
> Reviewed-by: Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gmail.=
com>
Applied.

Thanks,

>=20
> Best Regards,
> Jo=C3=A3o Paulo


