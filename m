Return-Path: <linux-iio+bounces-9909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A1989AE8
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0F11F21BA9
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 07:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31050433D2;
	Mon, 30 Sep 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU7mh7w9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D629CE8;
	Mon, 30 Sep 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727679715; cv=none; b=TMbNSPfvgL7sP0/ZEc/Z6DWit5AQgwydCQsdi9bi/6hHikL/uewvux+BY9vGJLpnwjwB7dCYoqhog+r9Yd1gB9IEKlBDvOKbhKP7YATLPiMVGecaJMQR4eLfMlwtxs8p+lZoRXHddgSyBmcO7nHjTDKRkOuoIC/cmTlSVDLOpw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727679715; c=relaxed/simple;
	bh=vzlSPx7gNpoki8FPQD2L0+0UCwVIjFElVF3dKnbAN9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFL1tpojb+RIr/3uRlfmGWQ+Ngv9znZYUTyuICXsaIxKvJWoqfnymIT9auUanpKkhy0YAIPUwrEA38g9JwXLAu8S8f7AfYq+/xGJr6qa2lLMQOikS7tio+xBIVYqRKqGBgHT9sPiZsS7F/6VxJVsmQn4veWA0MS3rDfiVSEpPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU7mh7w9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC61C4CECD;
	Mon, 30 Sep 2024 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727679714;
	bh=vzlSPx7gNpoki8FPQD2L0+0UCwVIjFElVF3dKnbAN9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SU7mh7w95f+MELF6Bv8xThPxa2sJctpV+vUE5adaRTEFcbatpazxfME0Fc6w49WZZ
	 u++Hby/Bapl/ntcxWt60qM3L9vxG+57PpKuEnrJ8bXTL8RYzXNmZL++YpFOVkrQ6Sy
	 ZG+pCpckYkzVg40cVQ7d30MeB6XDZOJKkseJosbibRqFyLa7zAPdwPqlWXj0heOYnz
	 6j7gwvJRpPTH+V3dhYYuPj0lN13RAet87CDanmVfTCVYaqLgpBypOjv0kuKcxYDLL0
	 nJisjIws4rmUeRkmTo/XMkIfZT6PdpXYlbyHA030zhfHl02vsXOM3W22VHylHa3IFK
	 S/x1mHmhK9qzw==
Date: Mon, 30 Sep 2024 09:01:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: iio: light: vishay,veml6075: add
 vishay,veml6070
Message-ID: <xwjjlvdjtomxrxtqok7pkqwmqafwr7zkmikwuwnzusd6c4atxb@pcenm6wz2zfk>
References: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
 <20240929-veml6070-cleanup-v1-5-a9350341a646@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240929-veml6070-cleanup-v1-5-a9350341a646@gmail.com>

On Sun, Sep 29, 2024 at 10:38:50PM +0200, Javier Carrasco wrote:
> This UVA device with I2C has the same properties as the veml6075, and
> the same dt-bindings can cover it too.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


