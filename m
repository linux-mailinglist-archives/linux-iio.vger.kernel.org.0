Return-Path: <linux-iio+bounces-1451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DE88264D9
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jan 2024 16:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D208281CA6
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jan 2024 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03A13AD2;
	Sun,  7 Jan 2024 15:54:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C113AC7;
	Sun,  7 Jan 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <jic23@jic23.retrosnub.co.uk>)
	id 1rMVNb-00GNl5-Tx; Sun, 07 Jan 2024 15:48:04 +0000
Date: Sat, 06 Jan 2024 17:53:30 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Mihail Chindris <mihail.chindris@analog.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_01/13=5D_device_property=3A_Add_cleanu?= =?US-ASCII?Q?p=2Eh_based_fwnode=5Fhandle=5Fp?= =?US-ASCII?Q?ut=28=29_scope_based_cleanup=2E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZZlu5fTW27Tx3drB@smile.fi.intel.com>
References: <20240101172611.694830-1-jic23@kernel.org> <20240101172611.694830-2-jic23@kernel.org> <ZZlu5fTW27Tx3drB@smile.fi.intel.com>
Message-ID: <305F62D9-8410-4F2F-9411-5A7395192789@jic23.retrosnub.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BlackCat-Spam-Score: 10



On 6 January 2024 15:16:53 GMT, Andy Shevchenko <andriy=2Eshevchenko@linux=
=2Eintel=2Ecom> wrote:
>On Mon, Jan 01, 2024 at 05:25:59PM +0000, Jonathan Cameron wrote:
>> From: Jonathan Cameron <Jonathan=2ECameron@huawei=2Ecom>
>>=20
>> This allows the following
>>=20
>> struct fwnode_handle *child __free(kfree) =3D NULL;
>>=20
>> device_for_each_child_node(dev, child) {
>> 	if (false)
>> 		return -EINVAL;
>> }
>>=20
>> without the fwnode_handle_put() call which tends to complicate early
>> exits from such loops and lead to resource leak bugs=2E
>>=20
>> Can also be used where the fwnode_handle was obtained from a call
>> such as fwnode_find_reference() as it will safely do nothing if
>> IS_ERR() is true=2E
>
>=2E=2E=2E
>
>>  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
>>  void fwnode_handle_put(struct fwnode_handle *fwnode);
>> +DEFINE_FREE(fwnode_handle, struct fwnode_handle *, fwnode_handle_put(_=
T))
>
>In GPIO we have something similar and PeterZ explained there why if (_T) =
is
>important, hence this should be

I can't find the reference unfortunately=2E=20

>
>DEFINE_FREE(fwnode_handle, struct fwnode_handle *, if (_T) fwnode_handle_=
put(_T))
>
>or even
>
>DEFINE_FREE(fwnode_handle, struct fwnode_handle *, if (!IS_ERR_OR_NULL(_T=
)) fwnode_handle_put(_T))
>
>as we accept in many calls an error pointer as unset / undefined firmware=
 node
>handle=2E

The function called has a protection for null
 and error inputs so I'm not sure why extra protection
is needed?

J
>
>

