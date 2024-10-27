Return-Path: <linux-iio+bounces-11395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED9F9B1D74
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 12:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFF81C208E9
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8F150997;
	Sun, 27 Oct 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngRFPaqx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971413A271;
	Sun, 27 Oct 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730028911; cv=none; b=MW8NcH/6/K9/L3zEXs17zx3QcKXEDoMuqrGIyJCZOxHn3Vgu1cDT6XKcHo9XOGsTqP/Cd54jkYlYSDv/FQ5mqknbkRZQ8gkuPli7G34esFu3IIkO0eQxgAsM129o2L37c9qmnc+EYcZiD0T2Mx2jAuw90++3NSnOjyOa0IxL/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730028911; c=relaxed/simple;
	bh=JReu1xcGfgvNjfc3VfFr0yDDrk9ygK7CxuWJXwEGef4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snhJxfktXojkCbMh8dW0652ooMGT5p9Ax681S1+T91Hr/IQpNzB6LaphNCQvhHg0zooqNJEj4yZ94nUC5H7XwDJtG3AR8fJEPiuUKuacx0MmPP08kz4Oi9LYkHPVyLcrZNsMj4YRh9hREaNld+5rlIqP+aYXCKb0XttY1GeJtu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngRFPaqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5327C4CEC3;
	Sun, 27 Oct 2024 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730028911;
	bh=JReu1xcGfgvNjfc3VfFr0yDDrk9ygK7CxuWJXwEGef4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngRFPaqxBDi5khNin4veLdaGMPsxEidhCh18K4tA7kNcInRkv4vXvK5LB25e2CKUH
	 ptLkN4mruadSGsgdNpyFhRnOwN4uNT/54nFNjT0nUdRkweHucXVt0hiMOd/M/ob43T
	 PxJATbMl30tOGVQMQFfW8+BhIW+vTU+Bm/b6QiVEx1bA3XyntaevkFqYoMCBfn/KCV
	 +hox1rQE0bLbl67dRgf+74mSvdBj4wDsvxLeOCQJGjETaz80Ds+Tw22oDpziuOf/Ry
	 4msXKVIHdpwEDiezKzG9oMA1rtvop0bo9qFMJ34q5Y+A+A3z3D6vlFfIeBlZIB7hH7
	 3MWFR4SOWuLAw==
Date: Sun, 27 Oct 2024 11:35:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Harvey Yang <chenghaoyang@google.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: hid-sensors: Add proximity and attention IDs
Message-ID: <20241027113503.46113bcc@jic23-huawei>
In-Reply-To: <20241024-hpd-v1-1-2a125882f1f8@chromium.org>
References: <20241024-hpd-v1-0-2a125882f1f8@chromium.org>
	<20241024-hpd-v1-1-2a125882f1f8@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 13:29:05 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> The HID Usage Table at https://usb.org/sites/default/files/hut1_5.pdf=09
>=20
> - 0x4b2 for Human Proximity Range

Add more here from the references the above has.
https://www.usb.org/sites/default/files/hutrr39b_0.pdf

Distance between a human and the computer. Default unit of
measure is meters;



> - 0x4bd for Human Attention Detected
>=20
Human-Presence sensors detect the presence of humans in the sensor=E2=80=99=
s field-of-view using
diverse and evolving technologies. Some presence sensors are implemented wi=
th low
resolution video cameras, which can additionally track a subject=E2=80=99s =
attention (i.e. if the
user is =E2=80=98looking=E2=80=99 at the system with the integrated sensor).
A Human-Presence sensor, providing a Host with the user=E2=80=99s attention=
 state, allows the
Host to optimize its behavior. For example, to brighten/dim the system disp=
lay, based on
the user=E2=80=99s attention to the system (potentially prolonging battery =
life).

This one is a 0/1 signal if I read the schema right.  Which is also true for
the existing HUMAN_PRESENCE. Not a problem but worth mentioning in this des=
cription.
 =20
https://www.usb.org/sites/default/files/hutrr107-humanpresenceattention_1.p=
df



> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/linux/hid-sensor-ids.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-id=
s.h
> index 6730ee900ee1..8a03d9696b1c 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -30,6 +30,8 @@
>  #define HID_USAGE_SENSOR_PROX                                   0x200011
>  #define HID_USAGE_SENSOR_DATA_PRESENCE                          0x2004b0
>  #define HID_USAGE_SENSOR_HUMAN_PRESENCE                         0x2004b1
> +#define HID_USAGE_SENSOR_HUMAN_PROXIMITY                        0x2004b2
> +#define HID_USAGE_SENSOR_HUMAN_ATTENTION                        0x2004bd
> =20
>  /* Pressure (200031) */
>  #define HID_USAGE_SENSOR_PRESSURE                               0x200031
>=20


