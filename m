Return-Path: <linux-iio+bounces-16948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F86A64ACF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F85167A38
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE6235BE1;
	Mon, 17 Mar 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTMTEiay"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0861993BD;
	Mon, 17 Mar 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208570; cv=none; b=uwerHvGdRkHMUgYXCRnXAz1PfJRzZm79e1PjA82uBoDqGeqQBWqbgGjET3dwZgf/1Io7B+f0oa3k/WulQimby1mZ3pD303foQRarxal8OIOZ7TD8VkI4ihb+A4v3luwoesRBHsV5iknn0Mjvi80ir4Wch7TybKDeOEqvI3lMv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208570; c=relaxed/simple;
	bh=DHLKtqKokb5/ORaPjnoa21RvlOzXzzI+TwJQN4jKmm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKhgCSzcGFNrDoh3u35jdNaCtDKZgLs+8x23SqdHmbJRtRIAy92MnpaQjXg6hlzqVicqgAszuOztMb74KxiWBxDOuFtVRRKs4eJAaoyjYCaBjyuG93hYVFNbGVluPSlR46618iLBDskF0dbWJPAyuUMWD87ey1BYWSUtRfqm5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTMTEiay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BD1C4CEE3;
	Mon, 17 Mar 2025 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742208569;
	bh=DHLKtqKokb5/ORaPjnoa21RvlOzXzzI+TwJQN4jKmm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTMTEiayCOljtv8GLrylo8HGHweUsQRLbmaUiKxoofC4/CYB8N2vxqCoTaE1F5Z6D
	 A2k5slyoogC1NQGauUeuQTMSB4yYKO+KrpsOJqfiHJLQDZBfQdlJJCwcGRiwGzMuN/
	 Hy3m/rCrQPwnptuswFLkxHEzWN2b4U+hha7f8aEn9/uT4elbWZYqcjGej2yWiDPskr
	 WfJuU8/qfKryhJoH3KcgN5y2dWHwn7x02FTiz6DXznKfslnJBwlQwxCEw2mWVWmMT9
	 7dF9xr3GXqRs+0Na8zNmlP5ny5KLkY+VRdQ5fHl0TaTdbRdRI3msX75tfZo8dahRl7
	 bM+FkVf599Q3Q==
Date: Mon, 17 Mar 2025 11:49:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lu Tang =?utf-8?B?KOaxpOeSkCk=?= <Lu.Tang@mediatek.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Chen Zhong =?utf-8?B?KOmSn+i+sCk=?= <Chen.Zhong@mediatek.com>, Sen Chu =?utf-8?B?KOWCqOajrik=?= <Sen.Chu@mediatek.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH 5/5] dt-bindings:
 pmic: mediatek: Add pmic documents
Message-ID: <20250317-mighty-dolphin-of-downpour-e7a9f5@krzk-bin>
References: <20250314073307.25092-1-Lu.Tang@mediatek.com>
 <20250314073307.25092-6-Lu.Tang@mediatek.com>
 <SEZPR03MB6891E21CD04880AB1AC91BFC80D22@SEZPR03MB6891.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <SEZPR03MB6891E21CD04880AB1AC91BFC80D22@SEZPR03MB6891.apcprd03.prod.outlook.com>

On Fri, Mar 14, 2025 at 09:01:11AM +0000, Lu Tang (=E6=B1=A4=E7=92=90) wrot=
e:
> Update email
>=20
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Lu.Tang <Lu.Tang@mediatek.com>=20
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B43=E6=9C=8814=E6=97=A5 =
15:33
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Jonathan Cameron <jic23@kernel.org>; Lars-Pe=
ter Clausen <lars@metafoo.de>; Rob Herring <robh@kernel.org>; Krzysztof Koz=
lowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Dmitry Tor=
okhov <dmitry.torokhov@gmail.com>; Lee Jones <lee@kernel.org>; Matthias Bru=
gger <matthias.bgg@gmail.com>; AngeloGioacchino Del Regno <angelogioacchino=
=2Edelregno@collabora.com>; Sean Wang <sean.wang@kernel.org>; Linus Walleij=
 <linus.walleij@linaro.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brow=
n <broonie@kernel.org>; Stephen Boyd <sboyd@kernel.org>; Chen Zhong (=E9=92=
=9F=E8=BE=B0) <Chen.Zhong@mediatek.com>; Sen Chu <shen.chu@mediatek.com>
> =E6=8A=84=E9=80=81: linux-iio@vger.kernel.org; devicetree@vger.kernel.org=
; linux-kernel@vger.kernel.org; linux-input@vger.kernel.org; linux-arm-kern=
el@lists.infradead.org; linux-mediatek@lists.infradead.org; linux-gpio@vger=
=2Ekernel.org; Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_=
Upstream_Group@mediatek.com>; Lu Tang (=E6=B1=A4=E7=92=90) <Lu.Tang@mediate=
k.com>
> =E4=B8=BB=E9=A2=98: [PATCH 5/5] dt-bindings: pmic: mediatek: Add pmic doc=
uments

The amount of errors shown by checkpatch on this is just shocking.

Best regards,
Krzysztof


