Return-Path: <linux-iio+bounces-24041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE0B5609A
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B1D1B23C51
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396622848A0;
	Sat, 13 Sep 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTbqaubF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601BEAF9;
	Sat, 13 Sep 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757765853; cv=none; b=bbe6aUOU6p++L4CTLYScjJKtMMlk2BiC7dKcllDC5KTV6M+q2rwPq1abosNk6cfQ1bvXscfkITiKPwiETH4p4pLeKpGOXu2X3mnBb9trcOD+QAVKHDzGzbmcrjwjVFpYBzRnYCBMIVnkcU5i1anNlHQPdc3ZgT89QoP1oy8IqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757765853; c=relaxed/simple;
	bh=rCmkDHYJzLWNF0ynhzocfkMVyfZWxwjArSYM0rxU2xM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQkzQmc+a6P7HEjf5btcSXzybXnPVH2kNWu7d7+ueiqszxP48N5YLWQGdi5bHISMd0uFOtNCUFqePSm9kXZF+HBCtrPgCbXJfhpQ5GeBLmcSJtfCi3IBCV5oYu9nowMd/xcdn6QIkId/GgSm3L9Al9pttMkiipk59pZBwgvIWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTbqaubF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F56AC4CEEB;
	Sat, 13 Sep 2025 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757765852;
	bh=rCmkDHYJzLWNF0ynhzocfkMVyfZWxwjArSYM0rxU2xM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tTbqaubFN+NGbGVtVMdBytlIsw952Yn1kOjlX/Nn5AUzai/mKF9qCh8dpoC5bPS6Y
	 5nwBbLKdjs0EKzNSiWQkelbwZKmCVK4nQAVqXdWWxdZKoU2jNgi7/2AidWDt2i7TH9
	 3D9Lv6rU0N7483fbKBHdTrrS62FmZA/YT+tZTpmp9sezRefjl4Q3CwodwNF9RSP89Q
	 sLjo4NBjVmjjM83r2EZir+kluU4LHKZg9jwiCVwnx7Q5gK2sUzqBhodVldhuLvl1VM
	 m7/gJvNHiJlybJyswuAbrvpgeGA3Btg8p1dUe2c1FGZ31fqj8EOOf3slZZLSVoKwhU
	 0Q7VOFkZVWw3w==
Date: Sat, 13 Sep 2025 13:17:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: light: ltr390: Implement runtime PM support
Message-ID: <20250913131724.111fa939@jic23-huawei>
In-Reply-To: <CAHp75Vf+9PJgR5Eev_Z+QB4cp+VMctFfqpTMWuE3VsnGpZ6dJQ@mail.gmail.com>
References: <20250909194649.10512-1-akshayaj.lkd@gmail.com>
	<CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com>
	<CAE3SzaTZ8PXM_B8FBetOTSfz2myGZ=WzPp8h2d79Q95zKLq5hw@mail.gmail.com>
	<20250910201212.5d9f57bc@jic23-huawei>
	<CAHp75Vf+9PJgR5Eev_Z+QB4cp+VMctFfqpTMWuE3VsnGpZ6dJQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2025 23:24:22 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Sep 10, 2025 at 10:12=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > On Wed, 10 Sep 2025 18:06:32 +0530
> > Akshay Jindal <akshayaj.lkd@gmail.com> wrote: =20
>=20
> > > Thank you very much for your valuable feedback.
> > > I do have a small request regarding the review process. Over the past=
 3=E2=80=934
> > > versions,most of the comments have been about fixing indentations and
> > > improving code readability. I would kindly request if it would be pos=
sible
> > > to consolidate such cosmetic comments into a single review round.
> > >
> > > I completely understand that incremental feedback makes sense when th=
e code
> > > is actively changing, but if the changes are minimal, spreading out m=
inor
> > > suggestions over multiple review cycles tends to unnecessarily increa=
se the
> > > turnaround time.
> > >
> > > Your support in this would help me address the comments more efficien=
tly. =20
>=20
> I can't always see _all_ problems at once, I am not a robot. I will
> try my best, though.
>=20
> ...
>=20
> > Andy, if you are fine with the explanation I'll tidy up the minor stuff
> > whilst applying. =20
>=20
> Yes, I am fine, go with it, thanks!
>=20

Applied with this diff;
diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 2d8449aeab18..a2b804e9089a 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -284,8 +284,8 @@ static int ltr390_do_read_raw(struct iio_dev *iio_devic=
e,
 }
=20
 static int ltr390_read_raw(struct iio_dev *iio_device,
-                          struct iio_chan_spec const *chan, int *val,
-                          int *val2, long mask)
+                          struct iio_chan_spec const *chan,
+                          int *val, int *val2, long mask)
 {
        int ret;
        struct ltr390_data *data =3D iio_priv(iio_device);
@@ -749,7 +749,7 @@ static void ltr390_powerdown(void *priv)
                        dev_err(dev, "failed to disable interrupts\n");
=20
                data->irq_enabled =3D false;
-               pm_runtime_put_autosuspend(&data->client->dev);
+               pm_runtime_put_autosuspend(dev);
        }
=20
        ret =3D regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SE=
NSOR_ENABLE);

Thanks,

Jonathan

