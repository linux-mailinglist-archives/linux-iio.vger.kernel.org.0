Return-Path: <linux-iio+bounces-20463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E67CAD5C44
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D0F1BC254D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D496D2192E3;
	Wed, 11 Jun 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UETb5HbI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F991FDE02
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659560; cv=none; b=OxtZZy4RX7bzHIRtkXGDiXDp9MkOI1IRzxIJuOdquYdqD1BZeOzIci/A3a3kuYuGAg7MZwTBBLMVN0ns+PN2h7jI55VyZDApizUwLosQBwnvBCEYk6oIl8D88o56ct1dpSUH5dDocUObJrl9U/0gPU5hcd1eLvdXZ5oR6b1kVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659560; c=relaxed/simple;
	bh=Wzj+/z2M4Hzz8e5MV0jVxRbk7VIhlc4yCIjlJ1t1k8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gORCrw1WWQ/9o8dshzPlwfnKWy3c+wpUeVWruhtToAc4MHSkMPkjxP3s28IrMjk1OqpPkpEWB/+AdqVMntZjKM+gwkdQfWKpTyr9+DK+qycvPEchDI7pqnJM+jBqFchW+TY0+hbMRskFeHqspTmk1GlAH/Oh0MOxD128Sd5iEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UETb5HbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C016C4CEE3;
	Wed, 11 Jun 2025 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659560;
	bh=Wzj+/z2M4Hzz8e5MV0jVxRbk7VIhlc4yCIjlJ1t1k8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UETb5HbIan5aW9FyHwOZvu25pes5iv8Cd6dNGgaO99YWgnh2t96R4rIBEAYZw0boT
	 Rs2Jq8vShkQxxxkLJ/cbFOytFRh6QgADanchL3rOa3JZJXXDqqkfKg1O13X0iemXcI
	 KCrcLkPTCpTUnw4jg5zA750Tc5HC/F1Y6uIDQPzatbZVuUaIntlefsVvyrC+mbuqVI
	 oygHh5vT48zN0wsQ2Q79RcBmcl4JwRxxxg8YDYzy9heycsJTDiQs5bl+NUtm4dU8Ry
	 j80ae1nLlm1rBUEdJHLwcmFTzYEXnSw5pyuTJCSBeTPgVJeWwYgieO7dytJmIJ17G8
	 HbISg0GzOb05Q==
Date: Wed, 11 Jun 2025 17:32:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] iio: potentiometer: Drop unused export.h includes
Message-ID: <20250611173233.270dde84@jic23-huawei>
In-Reply-To: <CAHp75VdxGouo=SB0JnAL6w5ZxQN0C+bBDo5Hh_k+TeoK5pD11g@mail.gmail.com>
References: <20250609070616.3923709-1-jic23@kernel.org>
	<20250609070616.3923709-2-jic23@kernel.org>
	<CAHp75VdxGouo=SB0JnAL6w5ZxQN0C+bBDo5Hh_k+TeoK5pD11g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jun 2025 12:28:40 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jun 9, 2025 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Resolves:
> >   warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> i=
s present =20
>=20
> With the given context this LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20
>=20

Picked this one up

