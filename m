Return-Path: <linux-iio+bounces-25800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD4C28E72
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 12:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A8B188A058
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBCF267B90;
	Sun,  2 Nov 2025 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vONUFMFD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3043712D1F1;
	Sun,  2 Nov 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762084077; cv=none; b=gtKeANrLCnGbMQGV7Xwye/7sOihKkM+jElGIXJP3YGV00JrMCzVz4XtoB7QFgCMEefL61SY+JSqD+vg808rf/4ICnrrLUDwsUkRj3z/FMvPZrfsDorAne75Pj1EiwcGzun7eq2S5LB9yZR+O5n3UlYyszmkD0w8L13TziEuvL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762084077; c=relaxed/simple;
	bh=KO/jjXTKZVsrw6rCyoErvTVk/A4+o+Omg76KyraJmGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fl2y4z9x8TEufSZv39f4kd+M8RjtJF6/ENyUYJcjAM/kCZBObxEdminSGN07/vnVsA1OByvGgSjBQIMRvx8My8/CRJafpoc+oHV11tJaLg41VJenF60ykWEbRkRYtOmEdB7Dg6YE1fnNTJPPPSAERnhvvTqlOgM+gmVEkeW6JiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vONUFMFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A72C4CEF7;
	Sun,  2 Nov 2025 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762084076;
	bh=KO/jjXTKZVsrw6rCyoErvTVk/A4+o+Omg76KyraJmGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vONUFMFD94gmqI+BBnwZYmyqRc0SQOqvxiYa4hfaa3nFdqCZXkeNuWOI8JAYcLFAm
	 SJ+5zNWokriMhORoIQLFjJpMw2DgLvoedr9g5LkmtCeGQbxel5NkeLsL43ETYXNXwe
	 W4g5mQI6cNtXKtQq6GANilqX5fMH0szKCkjKLHKxz939xHdI6rktLayxQDI2M2Pa5Y
	 i3L2KGtAlTkDSMTl+V8Ra0FQWi1aiFaaFuuU43VIffxfDp3rCaOD7x2nJj8tKFebzd
	 zPHWWKW7fa4M8btqmNzkqIvf/3S4AzCQZlD3KgCxA/E+UpYDhRKDKdNsmCMl3mXhkp
	 oXYpHIT/9piOg==
Date: Sun, 2 Nov 2025 11:47:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Zhiyong Tao <zhiyong.tao@mediatek.com>, kernel@collabora.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Add compatible for MT8189 SoC
Message-ID: <20251102114748.5b0b6da9@jic23-huawei>
In-Reply-To: <20251029-mt8189-dt-bindings-auxadc-v1-1-cd0496527a70@collabora.com>
References: <20251029-mt8189-dt-bindings-auxadc-v1-1-cd0496527a70@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 15:52:53 +0100
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> wrote:

> Add compatible string for MT8189 SoC.
> The AUXADC IP in this chip is fully compatible with the one found in
> MT8173 SoC.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
This had me confused. I tend to review backwards in time so
I picked up Jack Hsu's equivalent patch from the 
[PATCH v6 00/11] Add mt8189 dts evaluation board and Makefile 
series. v6 being posted a day after you.

Thanks

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> index 14363389f30aef85c596251fca0fe800200e2b41..d9e825e5054fe51c4010fc8a97af05c7639d4753 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
> @@ -42,6 +42,7 @@ properties:
>                - mediatek,mt8183-auxadc
>                - mediatek,mt8186-auxadc
>                - mediatek,mt8188-auxadc
> +              - mediatek,mt8189-auxadc
>                - mediatek,mt8195-auxadc
>                - mediatek,mt8516-auxadc
>            - const: mediatek,mt8173-auxadc
> 
> ---
> base-commit: c9a389ffad27e7847c69f4d2b67ba56b77190209
> change-id: 20251029-mt8189-dt-bindings-auxadc-89ad9e0a7834
> 
> Best regards,


