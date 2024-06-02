Return-Path: <linux-iio+bounces-5605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1678D74E0
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF92B1C20BDC
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B2D381DF;
	Sun,  2 Jun 2024 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDFyT22j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89C72628D;
	Sun,  2 Jun 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717326666; cv=none; b=idZZh7wkxQgZfNNalQeW9Rfubel9RQ+87bLCy+cTd06hACT1HKqE0xVUPRvRhlC/o88ZodaUkIotUTe3VbuFigm/TI6rRd6uRksFOnjfbg6sEzgf5fb+tHRQgWoA0V4drrxQlueATvD2StriDCV51H5UVQYxFL9P3kmXtqThlL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717326666; c=relaxed/simple;
	bh=/f1+buvY2wKNB3Djb3Xp6A4nNR8eZ/0oK02yL2xOeWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUZDPLaiJUu5B7Jwc87gqzFr0PpfNbJR0mqTQdQvYj9pf0iv3hZmBJt/zWalin7Q9nVUSSzpJbI9tkgQitBs8eOXRVEPpUMtrXlBNWGtkhfC92i49atKtiTb0/bdGHwRC+aw97m2nBdiLc124HaDzdckrAZitd/I3yAGiKKXzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDFyT22j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA938C2BBFC;
	Sun,  2 Jun 2024 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717326666;
	bh=/f1+buvY2wKNB3Djb3Xp6A4nNR8eZ/0oK02yL2xOeWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jDFyT22jbQ67clyrNrxdbhD7xaOliiWs4+SseiiLSu6Nr0PNS27VBY119EkzGc9TE
	 7Rei21olEOO6ncvQygef1eiqCLm2Fb18+625aQnIwYgXSWQUCTOuMoOhfN2QhOVOS6
	 M9wUOiqohMZ4mUpAja96KeI/BN0hfeit+8H7kiMvjZ0qqcGhXf3V0rzjWmhrdtsgw3
	 bQrFZ3QcGwVDeG4F8HGxSCFfOrcUUmMkKWk8pWVtOL6XJlcrgYKJfoR0tkAzUo0bhy
	 bBG08jKYHe0X4eFuxSClGILiZTQtGNmidUROA5tU2cGl1tM1Bm96Q3oE00TRgSevJS
	 HpzPw7jIlw/Yw==
Date: Sun, 2 Jun 2024 12:10:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Ramona Gradinariu
 <ramona.bolboaca13@gmail.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 9/9] drivers: iio: imu: Add support for adis1657x
 family
Message-ID: <20240602121051.2f322667@jic23-huawei>
In-Reply-To: <ff870fa7-436c-4ab1-9e8b-a5efcdd28c29@moroto.mountain>
References: <20240527142618.275897-10-ramona.bolboaca13@gmail.com>
	<ff870fa7-436c-4ab1-9e8b-a5efcdd28c29@moroto.mountain>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 May 2024 17:32:40 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Hi Ramona,
>=20
> kernel test robot noticed the following build warnings:
>=20
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/=
dt-bindings-iio-imu-Add-ADIS16501-compatibles/20240527-230203
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tog=
reg
> patch link:    https://lore.kernel.org/r/20240527142618.275897-10-ramona.=
bolboaca13%40gmail.com
> patch subject: [PATCH v5 9/9] drivers: iio: imu: Add support for adis1657=
x family
> config: x86_64-randconfig-161-20240528 (https://download.01.org/0day-ci/a=
rchive/20240528/202405281539.EXGy0dhk-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202405281539.EXGy0dhk-lkp@intel.com/
>=20
> smatch warnings:
> drivers/iio/imu/adis16475.c:1608 adis16475_push_single_sample() warn: mis=
sing error code? 'ret'
>=20
> vim +/ret +1608 drivers/iio/imu/adis16475.c
>=20
> c49e2871e50119 Ramona Gradinariu 2024-05-27  1577  static int adis16475_p=
ush_single_sample(struct iio_poll_func *pf)
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1578  {
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1579  	struct iio_dev *=
indio_dev =3D pf->indio_dev;
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1580  	struct adis16475=
 *st =3D iio_priv(indio_dev);
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1581  	struct adis *adi=
s =3D &st->adis;
> 8f6bc87d67c030 Ramona Bolboaca   2023-08-08  1582  	int ret, bit, buff_of=
fset =3D 0, i =3D 0;
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1583  	__be16 *buffer;
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1584  	u16 crc;
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1585  	bool valid;
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1586  	u8 crc_offset =3D 9;
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1587  	u16 burst_size =3D AD=
IS16475_BURST_MAX_DATA;
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1588  	u16 start_idx =3D (st=
->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 2 : 0;
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1589 =20
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1590  	/* offset until =
the first element after gyro and accel */
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1591  	const u8 offset =
=3D st->burst32 ? 13 : 7;
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1592 =20
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1593  	if (st->burst32) {
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1594  		crc_offset =3D (st->=
info->flags & ADIS16475_HAS_TIMESTAMP32) ? 16 : 15;
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1595  		burst_size =3D adis-=
>data->burst_max_len;
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1596  	}
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1597 =20
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1598  	ret =3D spi_sync=
(adis->spi, &adis->msg);
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1599  	if (ret)
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1600  		return ret;
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1601 =20
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1602  	buffer =3D adis-=
>buffer;
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1603 =20
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1604  	crc =3D be16_to_cpu(b=
uffer[crc_offset]);
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27  1605  	valid =3D adis16475_v=
alidate_crc(adis->buffer, crc, burst_size, start_idx);
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1606  	if (!valid) {
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1607  		dev_err(&adis->=
spi->dev, "Invalid crc\n");
> 7f174ee4adeb12 Ramona Gradinariu 2024-05-27 @1608  		return ret;
>                                                                 ^^^^^^^^^^
> return -EINVAL
I've gone with this as the fix whilst applying the patch

Thanks,

Jonathan

>=20
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1609  	}
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1610 =20
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1611  	for_each_set_bit=
(bit, indio_dev->active_scan_mask,
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1612  			 indio_dev->ma=
sklength) {
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1613  		/*
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1614  		 * When burst m=
ode is used, system flags is the first data
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1615  		 * channel in t=
he sequence, but the scan index is 7.
> fff7352bf7a3ce Nuno S=C3=A1           2020-04-13  1616  		 */
>=20


