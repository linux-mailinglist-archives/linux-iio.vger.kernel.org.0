Return-Path: <linux-iio+bounces-17365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703DBA75B58
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654FF3AA22F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D031D61A2;
	Sun, 30 Mar 2025 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPOxEPWb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8821F949;
	Sun, 30 Mar 2025 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743355280; cv=none; b=HVY3bg1AaVurIsPfbXwZ2sWSuK6SQfV544bDyA39spKCHvfrQtJAbZ60OfL5JOZAc/nTarYf+5Lyk4m8ZzhvO5AqwQQihAq/wl1bUi/teepfyyIzKbs3iOmvsFl/vJCxHY4Osg9dZMPBFnHJ5tH3QK70TdqNUTfRFvGgv72oq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743355280; c=relaxed/simple;
	bh=mdqL5gZ5wjkKfQ4GE4hISVH6jnkTiiPUOOr9XfuvuH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D31xAq8OuRq4mbgMHd67uqdZriCtVKEp4OrgppA/m1Eaa0yFtw+BP+Ay0fSmL0DxHOcHS1z8fIylzK5A2dV7et/7aZzttOy+pY5ApnpK8dyfnWYTl7MWD38RSBsy+nohyKshZEknebqEWz22AolQrnyxExxKEeMD5nmvQ9LBHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPOxEPWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C554CC4CEDD;
	Sun, 30 Mar 2025 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743355280;
	bh=mdqL5gZ5wjkKfQ4GE4hISVH6jnkTiiPUOOr9XfuvuH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CPOxEPWbN5bzgEVSGWmKGhkxVWqQUF2hakrVXw9zfsv3GRTd4/RWZzE2BkCXzYtK4
	 Q2f+BMFnfFH3gtB9jAQySR65iBOYskPiBevoDZPJpEOb023GmemmflaUTO5+3l37eb
	 HR+wUy3F/4Y6H6J1ktVRh4YbYTGkSJeKgIrjEz69NyjJaP6iYC0saDh0q9H8wl4Ngp
	 skfvKHANop0s8TyvZ9/F9Qn2L5RYhcUoB7fczlWv6DDbSfAWiWuwgilpuMniKWZPyx
	 lfFnIwtkZP5+xIg61cryhND/qA9VK9+vF91l0qoox7SNhRJARrGLYSv04LJZRlGHF7
	 MpIClsKO7WMfQ==
Date: Sun, 30 Mar 2025 18:21:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Felipe Balbi <balbi@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, David Frey <dpfrey@gmail.com>, Emil
 Gedenryd <emil.gedenryd@axis.com>, Alexander Koch <mail@alexanderkoch.net>,
 Jiri Valek - 2N <valek@2n.cz>, Hui Pu <Hui.Pu@gehealthcare.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: opt3001: fix deadlock due to concurrent
 flag access
Message-ID: <20250330182110.5373d1a0@jic23-huawei>
In-Reply-To: <20250321-opt3001-irq-fix-v1-1-6c520d851562@bootlin.com>
References: <20250321-opt3001-irq-fix-v1-1-6c520d851562@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Mar 2025 19:10:00 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> The threaded IRQ function in this driver is reading the flag twice: once =
to
> lock a mutex and once to unlock it. Even though the code setting the flag
> is designed to prevent it, there are subtle cases where the flag could be
> true at the mutex_lock stage and false at the mutex_unlock stage. This
> results in the mutex not being unlocked, resulting in a deadlock.

=46rom a quick look I think that only occurs if the triggering write
reports an error but the device accepts it anyway (maybe a bus
error on the ack going back to the host).

I'm not a fan of this locking dance, but I'm also not keen on
touching it too much without test hardware. Let's go with your fix which
looks safe to me.

Applied.
>=20
> Fix it by making the opt3001_irq() code generally more robust, reading the
> flag into a variable and using the variable value at both stages.
>=20
> Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sens=
or")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/iio/light/opt3001.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 65b295877b41588d40234ca7681bfee291e937c2..393a3d2fbe1d7320a243d3b67=
20e98b90f17baca 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -788,8 +788,9 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
>  	int ret;
>  	bool wake_result_ready_queue =3D false;
>  	enum iio_chan_type chan_type =3D opt->chip_info->chan_type;
> +	bool ok_to_ignore_lock =3D opt->ok_to_ignore_lock;
> =20
> -	if (!opt->ok_to_ignore_lock)
> +	if (!ok_to_ignore_lock)
>  		mutex_lock(&opt->lock);
> =20
>  	ret =3D i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
> @@ -826,7 +827,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
>  	}
> =20
>  out:
> -	if (!opt->ok_to_ignore_lock)
> +	if (!ok_to_ignore_lock)
>  		mutex_unlock(&opt->lock);
> =20
>  	if (wake_result_ready_queue)
>=20
> ---
> base-commit: 250a4b882cf37d9719874253f055aad211f2c317
> change-id: 20250321-opt3001-irq-fix-f7eecd4e2e9c
>=20
> Best regards,


