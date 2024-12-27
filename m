Return-Path: <linux-iio+bounces-13818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09A9FD24D
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 09:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F5F3A06A2
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D69A155326;
	Fri, 27 Dec 2024 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlEK0OA7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21FB1876;
	Fri, 27 Dec 2024 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735289853; cv=none; b=L8WMRtZGQWp1mTA8zJ+8mpTP//ji5S1IAI06nl2DjnVGZ9r+5RlIo7HwLetIGiAhHdCWFAQ6wy8MetCdoVOts/nW7rc+mBRJyRoyOHgVOrPXehO0Jv7ldfUCbgUneEpTM7l2ilCjfgkaD77vmTAceQvHpmz0Us8QrwmYBc3+e5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735289853; c=relaxed/simple;
	bh=nOAawsn1brLm/z9JCvu8un0aQoCK7ypk8m80UQT6TbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn+6gLbze5KEm1ZjywdZiMkgMZgP3NhDuBUuFKGtxwNxiSGqiHdnIdrV1UkuEwz1yljCbVG7H4q2Gw8Xi/yqnqeQaIaKGtxeoErC/X5Fp1bceI3h9H3h+KjQkjHr0XrfT6w1kxvZjLNa19ZZtsYHPjXYEHletWKbKT3aAsD+9nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlEK0OA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88229C4CED0;
	Fri, 27 Dec 2024 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735289851;
	bh=nOAawsn1brLm/z9JCvu8un0aQoCK7ypk8m80UQT6TbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlEK0OA7H2qm3i9mh4kuTT1gT5JInQQPrrHE129Nke6tF7m37t00ZlsqWJefP/MRZ
	 W8hTZAktgNrgGZ2k8OrHuQr+FLbUvjRsBHBFJUOzAhIIuqDRrj0cA0og+Sfyts00fb
	 LYKbZxgOhkjTg79yryhbrJt/wCUe79yPF7ePGWAOjUFirbp5C9XMA5eCb0Whs4wuqj
	 5j5bBAjvNdHyRBHZvgDYBPZfUvPTbl0ZjBXRW/a40+3iyyKoD2xqLjYSY6XwykzL47
	 UWbpLKIw0dUhvdJ9IMv9A1Mi+7E7fy+dY+zBd5RCa53dZDRS/3pNTftgPtiwV/GUju
	 +rwgmDaa/9DEw==
Date: Fri, 27 Dec 2024 09:57:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org, 
	Detlev Casanova <detlev.casanova@collabora.com>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add rockchip,rk3562-saradc
 string
Message-ID: <5gq6yd5kwu6xhbuhrg5nmgl3llgkrqw2qvuschj5yjctuiqzoz@p6rol75kvrfc>
References: <20241224094042.3816483-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241224094042.3816483-1-kever.yang@rock-chips.com>

On Tue, Dec 24, 2024 at 05:40:41PM +0800, Kever Yang wrote:
> Add rockchip,rk3562-saradc compatible string.
> The saradc on rk3562 is v2 controller, with 10bit width which is different
> with rk3588.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> index fd93ed3991e0..da8bc6f50a32 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> @@ -16,9 +16,11 @@ properties:
>        - const: rockchip,rk3066-tsadc
>        - const: rockchip,rk3399-saradc
>        - const: rockchip,rk3588-saradc
> +      - const: rockchip,rk3562-saradc
>        - items:
>            - const: rockchip,rk3576-saradc
>            - const: rockchip,rk3588-saradc
> +          - const: rockchip,rk3562-saradc

This makes no sense - why suddenly 3576 is affected? Nothing in commit
msg is explaining this.

Best regards,
Krzysztof


