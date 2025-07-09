Return-Path: <linux-iio+bounces-21469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C19AFE2A1
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 10:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53198582104
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE5274FD7;
	Wed,  9 Jul 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/kyH0k+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399823C8CE;
	Wed,  9 Jul 2025 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049867; cv=none; b=ZzvvtMd6m5UY18htiiTpZDmaMudWDhg0rycsMBKfKDfUZi6SCkwCKp2fgDpLgpQzpUNMWAhbfVS+5eEU3yN0hKRfrl6lJvhDLhLaP417TQSkxg/YEgGHeYxzIJM1QXwrRBxnSGyihJCkky9OXwJi4r0BfNmGNBdMgyITNrIpgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049867; c=relaxed/simple;
	bh=/ZESWwyTJveRbGr5oE29xvj9PEV+f3vsHTfROkLMirQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nggmSUSARwQ+b+A2kauZYAg/AxVbqzO3MCbT2I8PnRmWTw56l38szrd05CnG01CokDYHiBdb94IoZLM8gtSKrhneTs85qx9xYTxvQpFMMXdecyDQrpOrJcF63m57JihpYBNN75wbMYoxe5scX+IVzck0VOOX7hnbdArA+NzAV8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/kyH0k+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2EAC4CEEF;
	Wed,  9 Jul 2025 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752049867;
	bh=/ZESWwyTJveRbGr5oE29xvj9PEV+f3vsHTfROkLMirQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/kyH0k+HWpffxiF3SfpqdP20X9KOdB8hawYaETGYEnQUZkxlrjWmdS/ERDyQpRYx
	 n2dS9DYUXi/9ke89e0Pi2czneorKNGp+mKdVrQqds06QZEIfSEHMjy596QjW5xYyjv
	 2RrrxglASIxVg3OmZC1ZTKSnrq0G+OdGbuhpSlQqcxatgxZ/SbBHsYO/2vatCLl+Yz
	 E+zHCFVRb00wUEYz4zj8svDY3SPG5LVx9CMcHmB1hf9pZOzRIyv0ZITJAGGL4yDpI6
	 5UlGbwlpGp3M6/RdZhtTtRLEnHtnC3VcnWUAAdi9QTGj5vux2ikBciBugqZdKv4J0L
	 HelRFwtRA2gBA==
Date: Wed, 9 Jul 2025 10:31:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, s.hauer@pengutronix.de, 
	zhiyong.tao@mediatek.com, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dt-bindings: thermal: mediatek: add falback
 compatible string for MT7981 and MT8516
Message-ID: <20250709-spectral-friendly-frigatebird-bd80b6@krzk-bin>
References: <20250708220405.1072393-1-olek2@wp.pl>
 <20250708220405.1072393-3-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708220405.1072393-3-olek2@wp.pl>

On Wed, Jul 09, 2025 at 12:04:04AM +0200, Aleksander Jan Bajkowski wrote:
> +      - items:
> +          - enum:
> +              - mediatek,mt7981-thermal
> +          - const: mediatek,mt7986-thermal
> +      - items:
> +          - enum:
> +              - mediatek,mt8516-thermal
> +          - const: mediatek,mt2701-thermal

Groups of lists usually we order by fallback, so first goes items with
mediatek,mt2701-thermal fallback and then items with
mediatek,mt7986-thermal fallback.

Anyway:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


