Return-Path: <linux-iio+bounces-22194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949BCB18E4C
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 13:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B6BAA53B4
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 11:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73A8836;
	Sat,  2 Aug 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggyUDo4z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A52253E9;
	Sat,  2 Aug 2025 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135620; cv=none; b=hP/7y+OpbF4zzDPjeiSJ9frw8tt+lIwv7WMv1GgMN2IR+YlIJmKY/EqA4GgnApai3ERkIebJyR1HGHwEpf91JP8EHMFelPXf3pYfpnoB92Fwd6xWtN4iaUiVfW0/03zC+duMlKhJ/LFGk1p4si0RmCb7xft3MSOqcglKsHq0gfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135620; c=relaxed/simple;
	bh=6yn/aXUyYWZi7k+8rbsZqp4af3ZATvsf+SJ4nKbXg8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Etbecjo5NXweh5vrYfkOJ6eKgM1h+UIf9/g7X74ug1SXmz0fVxfIkVW4vsHrLhFBGXDPXASMc7I1D+NnQEqqHfr1sTMRijyrm6iviC9312NGIhdal1UJoGUadqLcq147Y41InrQIw/fOmXViffLYkcccl+hyeiiH4RlSDFPD8KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggyUDo4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376A2C4CEEF;
	Sat,  2 Aug 2025 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754135617;
	bh=6yn/aXUyYWZi7k+8rbsZqp4af3ZATvsf+SJ4nKbXg8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ggyUDo4zpF3YOO6DGVfn4ACoOG4ooe3iPIyQHCG4o39AREMMi2aBTbe1CH2V6J4yV
	 TfWM0HHjZ2YsPOgmmuGPibkazyTT5ccG/t2RKzvcICUO8JYJRD9p0LX2s8+cWDr6Jp
	 P2zj5tc6ND4M+8eDK1sr/9j6/qknACCvI1c7E7X9sjY7z/HKtYzHQ0Zi1ovd6PUesY
	 hQKS88H1kXXAu3F86o35W6rxW6ijH1Ut8KGneuDpFnsrEOe4mmeEgr64cMR/+FF3Nx
	 PBLtFcx1SsVpKVUw3ChB5WcnDeamLGUjqjeyrgY7pLufFfoFhJsBATVsdY0iA74ZVQ
	 9pFPijTUhbOEg==
Date: Sat, 2 Aug 2025 12:53:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-adc081c: use individual model
 structures instead of array
Message-ID: <20250802125331.37ee64a6@jic23-huawei>
In-Reply-To: <asemsswsa6e5tgpryfkfyuwkzewzzulcinaxx6kqhrhbvrih46@ykicfbep6n6v>
References: <20250721-iio-const-data-11-v2-1-c3fec12511ee@baylibre.com>
	<asemsswsa6e5tgpryfkfyuwkzewzzulcinaxx6kqhrhbvrih46@ykicfbep6n6v>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jul 2025 10:06:51 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Jul 21, 2025 at 05:12:47PM -0500, David Lechner wrote:
> > Change the ti-adc081c driver to use individual model structures instead
> > of an array. This reduces the verbosity of the code. Also, the data is
> > now const as it should have been in the first place. The ADCxx1C_MODEL()
> > macro is dropped to be consistent with similar model definitions in
> > other drivers.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > Changes in v2:
> > - Drop use of ADCxx1C_MODEL() macro.
> > - Link to v1: https://lore.kernel.org/r/20250628-iio-const-data-11-v1-1=
-268189459192@baylibre.com
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Hmm. Seems I picked this up a while back but neither replied or updated
patch work. Oops.

Jonathan

