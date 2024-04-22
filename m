Return-Path: <linux-iio+bounces-4443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5782E8AD30F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 19:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE1F1C20878
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC44515383C;
	Mon, 22 Apr 2024 17:06:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F211514E2;
	Mon, 22 Apr 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805604; cv=none; b=f+8olDwujWIr0fw6rhLFQhWBO96pFFsI1JCMBrmRQgrVvpvNwXipGHTvM+p07LI+acNC29mlwGvP9sw4OdviI4ab/cRJSuJVShEZ1yE8i7jPzjt+Eq6n8+QbT+NCsTjLN16KB1VA1WKoBpcgHqkP14+J7baJi6W5AAmH5kSAH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805604; c=relaxed/simple;
	bh=ChT6+vPumnrJM9srWy5yUNAeeCLE5XyV4GrHRpq+9qI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHiAz8yeS6ajSEw5XLhUstTlBfVFNfeh7nMVnEYbHQ7yNvNiLIITR6p9S1Pqo8LZz/Ac+mfIugZBDLeQ3sWIL2qwWBdsF82c9YnDaKkDc3Jt9p5aWDtvlFzM8tjQ7P1MUY4G7NAAmKo02mqgcfgH6E5XbN2cAPhU4CqfU5DLWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNWqt2Xlwz688p7;
	Tue, 23 Apr 2024 01:06:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5779F140736;
	Tue, 23 Apr 2024 01:06:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 18:06:39 +0100
Date: Mon, 22 Apr 2024 18:06:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hans de Goede <hdegoede@redhat.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Sean Rhodes <sean@starlabs.systems>, <linux-iio@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4] iio: accel: kxcjk-1013: Move ACPI ROTM parsing to
 new acpi-helpers.h
Message-ID: <20240422180639.00007270@Huawei.com>
In-Reply-To: <85ec0beb-9ec2-4360-8b53-fe65f8b6f5a8@redhat.com>
References: <20240417164616.74651-1-hdegoede@redhat.com>
	<20240417164616.74651-3-hdegoede@redhat.com>
	<20240420121345.26c2edf1@jic23-huawei>
	<85ec0beb-9ec2-4360-8b53-fe65f8b6f5a8@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Apr 2024 11:18:26 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
>=20
> On 4/20/24 1:13 PM, Jonathan Cameron wrote:
> > On Wed, 17 Apr 2024 18:46:14 +0200
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >  =20
> >> The ACPI "ROTM" rotation matrix parsing code atm is already duplicated
> >> between bmc150-accel-core.c and kxcjk-1013.c and a third user of this =
is
> >> coming.
> >>
> >> Move the ROTM parsing from kxcjk-1013.c, which has slightly better err=
or
> >> logging (and otherwise is 100% identical), into a new acpi-helpers.h f=
ile
> >> so that it can be shared.
> >>
> >> Other then moving the code the only 2 other changes are:
> >>
> >> 1. Rename the function to acpi_read_mount_matrix() to make clear this
> >>    is a generic ACPI mount matrix read function.
> >> 2. Add a "char *acpi_method" parameter since some bmc150 dual-accel se=
tups
> >>    (360=B0 hinges with 1 accel in kbd/base + 1 in display half) declar=
e both
> >>    accels in a single ACPI device with 2 different method names for
> >>    the 2 matrices.
> >>
> >> Cc: Sean Rhodes <sean@starlabs.systems>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com> =20
> >=20
> > Tempted to ask you to rename this to
> > acpi_non_standard_microsoft_extension_that_they_never_agreed_with_aswg_=
read_mount_matrix()
> > but meh, I'll cope with a reference to:
> > https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/sens=
ors-acpi-entries
> > and a comment saying this is not part of the ACPI standard. =20
>=20
> Ok, so I have added the following comment to the v2 which I will send out=
 soon:
>=20
> diff --git a/drivers/iio/accel/acpi-helpers.h b/drivers/iio/accel/acpi-he=
lpers.h
> index a4357925bf07..4f4140694b59 100644
> --- a/drivers/iio/accel/acpi-helpers.h
> +++ b/drivers/iio/accel/acpi-helpers.h
> @@ -7,6 +7,13 @@
>  #include <linux/sprintf.h>
> =20
>  #ifdef CONFIG_ACPI
> +/*
> + * Parse mount matrixes defined in the ACPI "ROTM" format from:
> + * https://learn.microsoft.com/en-us/windows-hardware/drivers/sensors/se=
nsors-acpi-entries
> + * This is a Microsoft extension and not part of the official ACPI spec.
> + * The method name is configurable because some dual-accel setups define=
 2 mount
> + * matrices in a single ACPI device using separate "ROMK" and "ROMS" met=
hods.
LGTM

> + */
>  static inline bool acpi_read_mount_matrix(struct device *dev,
>  					  struct iio_mount_matrix *orientation,
>  					  char *acpi_method)
>=20
> Regards,
>=20
> Hans

