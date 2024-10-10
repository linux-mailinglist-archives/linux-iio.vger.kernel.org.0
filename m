Return-Path: <linux-iio+bounces-10400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BB6998ECD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 19:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B68A1F24B65
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655281CEACC;
	Thu, 10 Oct 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5IMkH7K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD261CEAA6;
	Thu, 10 Oct 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582632; cv=none; b=T+ttgQmrMmeAn/Z6MdFaDxBXi88Bkh19IV6EVwUhFOeqKQ75XYdpmir/KJ+0tbcE82XHxPAKGxa6TIOb0ZD7FYZH1AsC/2a0IeVZ0Of3n0N86LDmcyIsTKv484goKTIMKA4UzoJcSoxlwKkAsk+pSBdNdys4BFMy/gNIuQgWaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582632; c=relaxed/simple;
	bh=xsHdyUJogwWtEbbTNwx1Iy9nsDjG8JJvO4lc/VxzJDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQbDMbkN9CRGkkMA4FF8USMQVKEXl9YzPNHnU+D4Qiwe79fydxkSpHg1TJnQ1ODs0DqLEU7V+ugpcMPwr034oiijCQFlmNPilq39QIK+els2MHR38QYOCm/OZfCd9d/lHni3uPod0o8aas0wbOqGKm9q/FEZiSwkQceVrbHuE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5IMkH7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B5DC4CEC6;
	Thu, 10 Oct 2024 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728582631;
	bh=xsHdyUJogwWtEbbTNwx1Iy9nsDjG8JJvO4lc/VxzJDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r5IMkH7KWM5Xl3hCXpxlOHe01c/eWII5kvstSXQVk5UwsNKsChE/TIu4cE8X9a0mR
	 G5tps9qRq/pIa6fEBNoaJHn2VKe++F30YV+Ij0EX8K3OcX6tfjWyjMjM/B1zZX6Caf
	 qzS814IbUCivXTYWR4HTb7+wOaAzqGCBVyZijZllL5GzmNYSfd5spH/5oSt5tduhmN
	 WYTHAxUR0kF8pZXidWaqbCXExaHMUPkWURLb/38gXHpER2LZz54qt8ETHhTBSvugaG
	 FrfUHvI0SPVlHf5v/tz8UHm6i+sI8dqBWp65qSK+GPnEQ/jvaI7PcBVpf92bl7eIhs
	 O/ZAYAAB3dnhg==
Date: Thu, 10 Oct 2024 18:50:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Christophe JAILLET  <christophe.jaillet@wanadoo.fr>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensors: Fix an error handling path in
 _hid_sensor_set_report_latency()
Message-ID: <20241010185017.0163a5b8@jic23-huawei>
In-Reply-To: <f099a9e8e0651a8599d09a5c98f2f960f0bb3d61.camel@linux.intel.com>
References: <c50640665f091a04086e5092cf50f73f2055107a.1727980825.git.christophe.jaillet@wanadoo.fr>
	<20241005190620.5f8633a9@jic23-huawei>
	<f099a9e8e0651a8599d09a5c98f2f960f0bb3d61.camel@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Oct 2024 10:21:50 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Sat, 2024-10-05 at 19:06 +0100, Jonathan Cameron wrote:
> > On Thu,=C2=A0 3 Oct 2024 20:41:12 +0200
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> >  =20
> > > If hid_sensor_set_report_latency() fails, the error code should be
> > > returned
> > > instead of a value likely to be interpreted as 'success'.
> > >=20
> > > Fixes: 138bc7969c24 ("iio: hid-sensor-hub: Implement batch mode")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > This patch is speculative.
> > >=20
> > > The code just *looks* wrong to me. No strong opinion, if it is done
> > > on
> > > purpose or not. =20
> > Agreed it smells :)=C2=A0 But I'd like more eyes on this before I take =
the
> > fix
> > as maybe there is something subtle going on.
> >  =20
> The original HID sensor spec HUTRR39 didn't have this property (usage
> ID 0x31B). This was added by update "HUTRR59" to support batch mode to
> improve power.=C2=A0
> This attribute will not be present on non batch mode supported system
> and on supported system this attribute writes will not fail unless some
> hardware error.
>=20
> Returning error is fine.
>=20
>     Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
> Thanks,
> Srinivas
>=20
Thanks and applied to the fixes-togreg branch of iio.git + marked
for stable.

Jonathan

>=20
>=20
>=20
>=20
> > J =20
> > > ---
> > > =C2=A0drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > index ad8910e6ad59..abb09fefc792 100644
> > > --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> > > @@ -32,7 +32,7 @@ static ssize_t
> > > _hid_sensor_set_report_latency(struct device *dev,
> > > =C2=A0	latency =3D integer * 1000 + fract / 1000;
> > > =C2=A0	ret =3D hid_sensor_set_report_latency(attrb, latency);
> > > =C2=A0	if (ret < 0)
> > > -		return len;
> > > +		return ret;
> > > =C2=A0
> > > =C2=A0	attrb->latency_ms =3D hid_sensor_get_report_latency(attrb);
> > > =C2=A0 =20
> >  =20
>=20


