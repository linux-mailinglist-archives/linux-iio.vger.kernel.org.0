Return-Path: <linux-iio+bounces-18976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E32FAAA6E0D
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DCA1BC66CD
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2722CBFD;
	Fri,  2 May 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMYtrvdz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD522D78B;
	Fri,  2 May 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177920; cv=none; b=oyXqNXJVzqp+vR7mrghG4s/VAsjaS9xyx/MwmdOpzvnBM2u726IyoXF6fIOyVgEE79BQAYl5IweINxyhZCsoHHcCqG/VnvebWWrrMfsTAFh7dk4yInuGTemyddzT2nBHlFALevomTbHD3SGZRGIwkHvQlfd57DEg3PuD28ap9ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177920; c=relaxed/simple;
	bh=6q6hCP/w+PMu5oMDcYrXYJBpy4Q+Ne5Kza1OqgsuBZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YET4A+gDQcpfTwgClB/q5blW/GzL8+HdygioT4/Q7/mATp4tVWFlouH/lK2QTlrgtx0UmDdtQUs6eJiTWOxkbK7f9FyzNZE9txcJ4GUwVsdmfVolA2V4SDEv5bbpUWZOIyluwC6uH89WWo6boT7s+fz/tQppBvjshUqoBvP0Bsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMYtrvdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52B3C4CEE4;
	Fri,  2 May 2025 09:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746177920;
	bh=6q6hCP/w+PMu5oMDcYrXYJBpy4Q+Ne5Kza1OqgsuBZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pMYtrvdzA59Nxhg7pLZBk751ciPkwbE6G2BV+L426NiTNOaEqwqUC11Fg9UNTwo7Z
	 wI95b6iO0KWel8FW0t6P49QbIm0Gvb6vevwKueo2XpE6NI3nSwLUUnkuWCTSi55b/H
	 wA6EiCEXEwke/uIh9TRXhI6P4fQiP3cLqAuuAHrraqT1e19ykZqO/XH1/6SwUpPGS+
	 k0rjMMmSlx9C9hRaCGNIsTm8AVzCVY0JvxGHS9vilZT2srvaLMTWcDOlFP2V8Pbyoi
	 vbiiWo3Vo5hEkxubhoYXgJJK7MULd3cWGMyk5HBlHTiDeBD+dXL0hbw6bGPUyyZZ5U
	 oLpw41AIgs1uQ==
Date: Fri, 2 May 2025 10:25:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 andy@kernel.org, dlechner@baylibre.com, matthias.bgg@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, nuno.sa@analog.com, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, zhiyong.tao@mediatek.com, kernel@collabora.com
Subject: Re: [PATCH] dt-bindings: iio: adc: Add compatible for Dimensity
 1200 MT6893
Message-ID: <20250502102510.05a37520@jic23-huawei>
In-Reply-To: <174527153072.2973088.9157423165074778113.robh@kernel.org>
References: <20250416120235.147889-1-angelogioacchino.delregno@collabora.com>
	<174527153072.2973088.9157423165074778113.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 16:38:51 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Wed, 16 Apr 2025 14:02:35 +0200, AngeloGioacchino Del Regno wrote:
> > Add a compatible for the Dimensity 1200 (MT6893) SoC; The AUXADC
> > IP in this chip is fully compatible with the one found in MT8173.
> > 
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >  .../devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml      | 1 +
> >  1 file changed, 1 insertion(+)
> >   
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 

Applied.

