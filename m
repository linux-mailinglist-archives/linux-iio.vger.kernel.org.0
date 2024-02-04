Return-Path: <linux-iio+bounces-2159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFAA848F18
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3791C215E4
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF7A2261B;
	Sun,  4 Feb 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh22fkNF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F022615;
	Sun,  4 Feb 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062513; cv=none; b=Iivpoi6b8Kynpu02TBw6P8lxyxGeAfYyUDoiDrQhpLYqck9CLq5Odvpilq+5CTVbMSh86mZV8XRBC+KOCsoi4zgmMdLIe5nZ97hc9QI3onfyLIm5HszH4n6XfY/13V5jM3VRchD3xr4KVYU3loevN4a/PsUfGcOEwWW/FMMRJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062513; c=relaxed/simple;
	bh=5bs6AIj/VbQlAyffESBFSqyzlHKuzqTWKMvrD6Vd2bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzQVv0vS+Jda5zPZPRTaGhacLkTKUjHAfltSQ+5/aWrdy8pVB+uEvNupkr7hUSlqGPZhk0f0KxijJqPWTmC2Bv2ZQw4eYlYPvhq/zoQ3GHnbIegYCEL8mJMCdodPZhn/KElZRfkB0UTeNHmMmfKToqQk74yL6T/NzFAVfV/vmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh22fkNF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6EEC433C7;
	Sun,  4 Feb 2024 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707062512;
	bh=5bs6AIj/VbQlAyffESBFSqyzlHKuzqTWKMvrD6Vd2bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sh22fkNF+lTGtEZI1VmP+a3zhI/PU6jBoGdbDCXKzsgMbyAhXQV1ehaeJXggx2xD4
	 ZJpLmLhICCmYM6FcNQ3WSoUOxrVQdOv0aU4SuIa6zF4rIMQMnbN3srGgcTpIogJMoR
	 gBhfhudeLftTTFmy+ZtoEX4lRaequaO8VIERVBykSKOeHsMzdg51dXmsgk3ljYrcEV
	 2JbGX74eJoCIp+TWXlXvMHdfglQLWhtM2vjMhl3/W7M7pZn/tUQ6Zz2VT3BZojOXf9
	 C0BFrIyZxgtwCtpSYXrLqkVhuROP6HrfuICwChORtAnbYe+02Rfn8pxA0i6odG/16+
	 IfHAPE/MaOgng==
Date: Sun, 4 Feb 2024 16:01:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 0/7] iio: add new backend framework
Message-ID: <20240204160136.0faa3125@jic23-huawei>
In-Reply-To: <20240204145933.6f29538c@jic23-huawei>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
	<20240204145933.6f29538c@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Feb 2024 14:59:33 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 02 Feb 2024 16:08:31 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > v1:
> >  https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei=
/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
> >=20
> > v2:
> >  https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-5450951895e1@a=
nalog.com
> >=20
> > v3:
> >  https://lore.kernel.org/linux-iio/20231213-dev-iio-backend-v3-0-bb9f12=
a5c6dc@analog.com/
> >=20
> > v4:
> >  https://lore.kernel.org/r/20231220-iio-backend-v4-0-998e9148b692@analo=
g.com
> >=20
> > v5:
> >  https://lore.kernel.org/r/20240112-iio-backend-v5-0-bdecad041ab4@analo=
g.com
> >=20
> > v6:
> >  https://lore.kernel.org/r/20240119-iio-backend-v6-0-189536c35a05@analo=
g.com
> >=20
> > v7
> >  https://lore.kernel.org/r/20240123-iio-backend-v7-0-1bff236b8693@analo=
g.com
> >=20
> > Changes in v8:
> >  - Dropped commit ("of: property: fix typo in io-channels") - applied
> >    via DT tree. Also dropped commit
> >    ("driver: core: allow modifying device_links flags") - did not made
> >    sense.
> >  - Patch 7
> >   * Do not change the version string format during probe.
> >=20
> > Jonathan, the series is based on next-20240202 since it already includes
> > the io-channels fix Rob applied in his tree. I guess it should land in =
rc3 so
> > after you rebase, all patches should apply cleanly (if applying them of=
 course
> > :)). Let me know if anything fails... =20
>=20
> Given that merge (between my tree and Rob's) is about as trivial as they =
come
> I'll take the series now (rather than delaying) and rely on Stephen (for =
next)
> and Greg (once I send a pull request) to deal with it.
>=20
> It's the sort of merge that makes Linus grumpy if people rebase to avoid =
it!
>=20
> On that note, applied with those tweaks to the broken binding patch.
>=20
> Initially pushed out as testing to see if 0-day moans at us a lot about a=
nything.
Dropped again as comments in from Andy crossed with this.

Jonathan

>=20
> Jonathan
>=20
> >=20
> > (also dropped the devlink Reviewers from the Cc list as that patch was
> > dropped).
> >=20
> > Keeping the block diagram  so we don't have to follow links
> > to check one of the typical setups.
> >=20
> >                                            ----------------------------=
---------------------------
> >  ------------------                        | -----------         ------=
------      -------  FPGA |
> >  |     ADC        |------------------------| | AXI ADC |---------| DMA =
CORE |------| RAM |       |
> >  | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|     =
     |------|     |       |
> >  |                |------------------------| -----------         ------=
------      -------       |
> >  ------------------                        ----------------------------=
---------------------------
> >=20
> > ---
> > Nuno Sa (6):
> >       dt-bindings: adc: ad9467: add new io-backend property
> >       dt-bindings: adc: axi-adc: update bindings for backend framework
> >       iio: buffer-dmaengine: export buffer alloc and free functions
> >       iio: add the IIO backend framework
> >       iio: adc: ad9467: convert to backend framework
> >       iio: adc: adi-axi-adc: move to backend framework
> >=20
> > Olivier Moysan (1):
> >       of: property: add device link support for io-backends
> >=20
> >  .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   4 +
> >  .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   8 +-
> >  MAINTAINERS                                        |   8 +
> >  drivers/iio/Kconfig                                |   9 +
> >  drivers/iio/Makefile                               |   1 +
> >  drivers/iio/adc/Kconfig                            |   4 +-
> >  drivers/iio/adc/ad9467.c                           | 268 +++++++++-----
> >  drivers/iio/adc/adi-axi-adc.c                      | 379 +++++--------=
------
> >  drivers/iio/buffer/industrialio-buffer-dmaengine.c |   8 +-
> >  drivers/iio/industrialio-backend.c                 | 412 +++++++++++++=
++++++++
> >  drivers/of/property.c                              |   2 +
> >  include/linux/iio/adc/adi-axi-adc.h                |  68 ----
> >  include/linux/iio/backend.h                        |  72 ++++
> >  include/linux/iio/buffer-dmaengine.h               |   3 +
> >  14 files changed, 793 insertions(+), 453 deletions(-)
> > ---
> > base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
> > change-id: 20231219-iio-backend-a3dc1a6a7a58
> > --
> >=20
> > Thanks!
> > - Nuno S=C3=A1
> >  =20
>=20
>=20


