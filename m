Return-Path: <linux-iio+bounces-7385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B61E92937F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 14:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DBC282F1A
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D99C433AB;
	Sat,  6 Jul 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTNGvpul"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D279461;
	Sat,  6 Jul 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720268158; cv=none; b=p7R7C5fM3KkaTjcLDEVNsm3hSdC+X5M/l2PfxZY9TP6VK4ClQ0ldFoVyunSaasrGzdFAas9uy71NwpKi9RTMOaECQJjgb0Urvz6aAgwqYwum/POYNbncGIIvyxeWslYQdXK6ICfoVxLHrk+wVyJVn+dct3kWg3kH6qeXMHNbC4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720268158; c=relaxed/simple;
	bh=ewHfk6kp7DgjzAdnMopMg8nYiloA7F7Sv9n6J0f9y8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhO8KNed7r44RXAgjd8pCJGBM3tQM5waZln3RzPKjuhwEm3xSrvYZh6qplenWT4F05NySrcghhZ2cLDMHYJbtlNEQIOrs2Fg3aZndbZmaz/tRnjt2Wd8xP2YqJBuLCF1OabN2E8lXPtV8OLFWcePqRffHbl7IoC519pSZbiY0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTNGvpul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13754C2BD10;
	Sat,  6 Jul 2024 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720268157;
	bh=ewHfk6kp7DgjzAdnMopMg8nYiloA7F7Sv9n6J0f9y8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NTNGvpul4CFL8Ua3b+uNIcisnwGPlyKW+BLn9kE6R8yn/MWemz9lq3EWzAz5h9SVU
	 FWxnZBhmfvHcWDkNBgqlwv9BtthYg4WwUTEePoY770I3ctXw16VPyTKLMgmUSjuaHi
	 8cjErYdcZIc35qEuwesnutwYjtKhG57Pfg2TQlwyCpL90BvRGwqXtYGdzWWcnq6orC
	 7BKBJC5Lh32ReUl4C1PceMPvsL/ZZWTBGd3iUoh2NB48nIdi9qSIv3bDoVQMwyTLUk
	 0GRPu4bWm0MFEDmFRCF5/fL0YQZOjowV80XbE5AQrpSk4Nw+DQQ6FMGO0KKJQE3wzn
	 olWNWrWD5ts3g==
Date: Sat, 6 Jul 2024 13:15:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, jstephan@baylibre.com,
 dlechner@baylibre.com, Conor Dooley <conor.dooley@microchip.com>,
 tools@kernel.org
Subject: Re: [PATCH v3 0/8] iio: adc: ad7606: Improvements
Message-ID: <20240706131549.1f94449c@jic23-huawei>
In-Reply-To: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 02 Jul 2024 17:34:04 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> This series adds the following improvements over the current AD7606's
> driver implementation:
>=20
> - Fix wrong usage of gpio array
> - Fix standby that was documented as ACTIVE_LOW but handled in the
>   driver as if it was ACTIVE_HIGH
> - Improve dt-bindings documentation
> - Switch mutex lock to scoped guard
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
This series is blowing up with b4, in that it is finding tags that were
not given and I can't work out why.

Tried various options but even a simple b4 am -l 20240702-cleanup-ad7606-v3=
-0-57fd02a4e2aa@baylibre.com
Is merrily finding tags that I can find no record of.
  =E2=9C=93 [PATCH v3 1/8] dt-bindings: iio: adc: adi,ad7606: normalize tex=
twidth
    + Reviewed-by: Conor Dooley <conor.dooley@microchip.com> (=E2=9C=93 DKI=
M/kernel.org)
    + Reviewed-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kern=
el.org)
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-1-57fd02a4e=
2aa@baylibre.com
  =E2=9C=93 [PATCH v3 2/8] dt-bindings: iio: adc: adi,ad7606: improve descr=
iptions
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-2-57fd02a4e=
2aa@baylibre.com
  =E2=9C=93 [PATCH v3 3/8] dt-bindings: iio: adc: adi,ad7606: add supply pr=
operties
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-3-57fd02a4e=
2aa@baylibre.com
  =E2=9C=93 [PATCH v3 4/8] dt-bindings: iio: adc: adi,ad7606: fix example
    + Reviewed-by: Conor Dooley <conor.dooley@microchip.com> (=E2=9C=93 DKI=
M/kernel.org)
    + Acked-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kernel.=
org)
    + Reviewed-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kern=
el.org)
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-4-57fd02a4e=
2aa@baylibre.com
  =E2=9C=93 [PATCH v3 5/8] dt-bindings: iio: adc: adi,ad7606: add conditions
    + Acked-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kernel.=
org)
    + Reviewed-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kern=
el.org)
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-5-57fd02a4e=
2aa@baylibre.com
  =E2=9C=93 [PATCH v3 6/8] iio: adc: ad7606: fix oversampling gpio array
    + Reviewed-by: Conor Dooley <conor.dooley@microchip.com> (=E2=9C=93 DKI=
M/kernel.org)
    + Acked-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kernel.=
org)
    + Reviewed-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kern=
el.org)
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-6-57fd02a4e=
2aa@baylibre.com
  =E2=9C=93 [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio state to matc=
h the documentation
    + Reviewed-by: Conor Dooley <conor.dooley@microchip.com> (=E2=9C=93 DKI=
M/kernel.org)
    + Acked-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kernel.=
org)
    + Reviewed-by: Rob Herring (Arm) <robh@kernel.org> (=E2=9C=93 DKIM/kern=
el.org)
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-7-57fd02a4e=
2aa@baylibre.com
  =E2=9C=93 [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to scoped_guard
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-8-57fd02a4e=
2aa@baylibre.com

Take patch 7 for example, I can find no record or Rob or Conor replying to =
that
or giving tags on the cover letter.

The only local parameter I have is to change the link path as you can see a=
bove.

Tried it with b4 0.14 and master as of today.


> ---
> Changes in v3:
> - Remove the two first patches that were already picked up.
> - Add styling corrections.
> - [Patch 6/8] Improve commit message.
> - [Patch 8/8] Replace every scoped_guard by simple guard.
> - Link to v2: https://lore.kernel.org/r/20240628-cleanup-ad7606-v2-0-96e0=
2f90256d@baylibre.com
>=20
> Changes in v2:
> - Change scoped guard to guard(mutex)(&st->lock). This was tested with
>   Rob's bot condition, and seems not to generate warning anymore.
> - Reorder the commits for avoiding bisection issues and respect commit
>   priority rules.
> - Add vdrive-supply to required properties.
> - Separate cosmetic changes from content ones in dt-binding
>   descriptions.
> - Move maxItems changes (and plural in descriptions) to the commit that
>   adds conditions.
> - Link to v1: https://lore.kernel.org/r/20240618-cleanup-ad7606-v1-0-f185=
4d5c779d@baylibre.com
>=20
> ---
> Guillaume Stols (8):
>       dt-bindings: iio: adc: adi,ad7606: normalize textwidth
>       dt-bindings: iio: adc: adi,ad7606: improve descriptions
>       dt-bindings: iio: adc: adi,ad7606: add supply properties
>       dt-bindings: iio: adc: adi,ad7606: fix example
>       dt-bindings: iio: adc: adi,ad7606: add conditions
>       iio: adc: ad7606: fix oversampling gpio array
>       iio: adc: ad7606: fix standby gpio state to match the documentation
>       iio: adc: ad7606: switch mutexes to scoped_guard
>=20
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 123 +++++++++++++++=
+-----
>  drivers/iio/adc/ad7606.c                           |  47 ++++----
>  drivers/iio/adc/ad7606_spi.c                       |   5 +-
>  3 files changed, 115 insertions(+), 60 deletions(-)
> ---
> base-commit: 340fa834ae229a952db04a57ed13fd5d35d75818
> change-id: 20240416-cleanup-ad7606-161e2ed9818b
>=20
> Best regards,


