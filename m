Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A44AAAA9
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 18:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380760AbiBERih (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 12:38:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39256 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380764AbiBERig (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2022 12:38:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A78BFB800C1
        for <linux-iio@vger.kernel.org>; Sat,  5 Feb 2022 17:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7284C340E8;
        Sat,  5 Feb 2022 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644082714;
        bh=QEWoyK3yFsNHjgF+rAM118r2fDHvCi37QKzQqkdmaYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VNo488szHj0qNAV9bK8CdNVGMP9Eh259FmqxaYJT1yZllxAwd+H9Ib2Do5erM7KWG
         6jRjra4SBrGxKA2ALL4Vaf0827yB1JMR3dg7Rff6gcE7PYDM+pXxrSrl10WHOZM2jq
         dDyvKq1pm7Lh0SznktMrVAhtl4exuzetzqPLF3BQbv0zwBUMihmOpCTjdbHE5XjzHd
         5TBux1MQgJyX/815Ampkt5ln0c9mnjiw9Esdxnr0T2xJXhWmeM9/HCh/AhDZcA1t9W
         nsZop+i6L/e64dLIcyJZJXex/2ilM9Rx0J4Cb3lPISsQIp2peT1YaOI07FQDZv76Su
         6l6chZGbD8sSQ==
Date:   Sat, 5 Feb 2022 17:45:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mario TESI <mario.tesi@st.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: wait for settling time in
 st_lsm6dsx_read_oneshot
Message-ID: <20220205174505.16e6d157@jic23-huawei>
In-Reply-To: <1643633216538.97874@st.com>
References: <6c10e1de14a42eca2d283a9df242b426e371543e.1643627150.git.lorenzo@kernel.org>
        <1643633216538.97874@st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Jan 2022 12:46:56 +0000
Mario TESI <mario.tesi@st.com> wrote:

> Tested-by: Mario Tesi <mario.tesi@st.com>
> ________________________________________
> Da: Lorenzo Bianconi <lorenzo@kernel.org>
> Inviato: luned=C3=AC 31 gennaio 2022 12:08
> A: jic23@kernel.org
> Cc: lorenzo.bianconi@redhat.com; linux-iio@vger.kernel.org; Mario TESI
> Oggetto: [PATCH] iio: imu: st_lsm6dsx: wait for settling time in st_lsm6d=
sx_read_oneshot
>=20
> We need to wait for sensor settling time (~ 3/ODR) before reading data
> in st_lsm6dsx_read_oneshot routine in order to avoid corrupted samples.
>=20
> Reported-by: Mario Tesi <mario.tesi@st.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Fixes tag?  This definitely looks like stable material to me
so we want a clear record of when the issue was introduced.

Thanks,

Jonathan


> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 727b4b6ac696..93f0c6bce502 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1374,8 +1374,12 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6d=
sx_sensor *sensor,
>         if (err < 0)
>                 return err;
>=20
> +       /*
> +        * we need to wait for sensor settling time before
> +        * reading data in order to avoid corrupted samples
> +        */
>         delay =3D 1000000000 / sensor->odr;
> -       usleep_range(delay, 2 * delay);
> +       usleep_range(3 * delay, 4 * delay);
>=20
>         err =3D st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
>         if (err < 0)
> --
> 2.34.1
>=20

