Return-Path: <linux-iio+bounces-17579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D2A79C40
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 08:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5702718943B9
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 06:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51EA1A23B6;
	Thu,  3 Apr 2025 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAJ64pjt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CD2A8D0;
	Thu,  3 Apr 2025 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743662653; cv=none; b=ceF5kbhUjpws3m4nKNFieiryPYY0QfR3DemPCO93HPuYcIlKqeAK4mTQdwpySpv5BpjmJxbXFUmsTJLzQmpg6tNOPstICEXtjgqQnC5ButDTqxLijbaj0CCzL98VSMT8AcnozZDtGWg0OMKJz9CIM7Au77lg6/XRUqocfpMd8X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743662653; c=relaxed/simple;
	bh=mUtzj5WoIbjsNCfhOOafE3B6C8E+N69MbFu/E7H+GXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk7i4K4JsdYnZ2PVcvJc3zPG9gzmC1yZYiw5AVHFv4HOinZFKs/YsmRcc26oDYtDUbvyNmPs2ObVEdBS2TrizgB9vtoEclzZj6MQPV7sNCVNNPjGstJIgQirwbfzzZVtC5hZ1Me/k/m2L+ezTuo4TEvsfcr+lvCL/Ct0yhhSDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAJ64pjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C5AC4CEE3;
	Thu,  3 Apr 2025 06:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743662652;
	bh=mUtzj5WoIbjsNCfhOOafE3B6C8E+N69MbFu/E7H+GXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAJ64pjtk2dFYzxaleMs00auuHOrjMfza6g0McmsPNOuybIW0/vHvLgxVLN5EsWoK
	 fHjQJH9q1yZP5Mt2hQZb6Em4DN0H4fpY1EENoaPsE1wdG/dUbdiK+JB2Gmi9KqYM4d
	 UfTgJLqurLOrbKsUgzd9SHxSTkGGSfAXAMg/WWsLc/bx5wjjJIXCtWjItdCeu1A0NG
	 0ArZiUXCUTG+vElBqzncKo1M9gaHoPENlyx1IE9vaZrFfu0Z2lrxVNijDktxkS+wiz
	 Xp84y43L7nYJuydAkfaU2hR/2VtvuBw1VnrAssdi+wIl6qmn6a+OwWpW6qjU2MgW6+
	 cHQntue65Lugw==
Date: Thu, 3 Apr 2025 08:44:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Message-ID: <20250403-ebony-coua-of-tornado-71d4ad@krzk-bin>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
 <20250403-togreg-v3-2-d4b06a4af5a9@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250403-togreg-v3-2-d4b06a4af5a9@analog.com>

On Thu, Apr 03, 2025 at 01:33:56PM +0800, Kim Seer Paller wrote:
> Document the AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel)
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls. They provide full-scale output spans of 2.5V
> or 5V for reference voltages of 2.5V. These devices operate on a single
> 2.7V to 5.5V supply and are guaranteed to be monotonic by design.
> The "R" variants include a 2.5V, 5ppm/=C2=B0C internal reference, which is
> disabled by default.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 99 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 106 insertions(+)

You got report about error in v2, which you did not respond to.

You send v3... with same error. I don't understand this.

Best regards,
Krzysztof


