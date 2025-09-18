Return-Path: <linux-iio+bounces-24238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5DB8261B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 02:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435C63BD5BB
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 00:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6A18DB1E;
	Thu, 18 Sep 2025 00:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8h0qhD0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E6155A30;
	Thu, 18 Sep 2025 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155601; cv=none; b=nmRBzwe4RGdldQpkVEqkb7CBS2qD62w1x65HhetMhWmy86+aSg6g/VRf2+EAbJR8dOYkOj+yL22u34PfPMdtGRp48dK+ytESeQUgXAQAkw1iUc5gThA5bdZ4nl2Cq83QFK1WXskAb/2VjY/saUC8klQ4Vo0vpEysH2rp+2fM26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155601; c=relaxed/simple;
	bh=o4MiQ96WpVIl3/Qfj3xSthuDSBcTfTMnLxJZvdqRB30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzHYFHgsQDghBR34CIXYPEAk1Dl96z4CQ1CYbJu4SddXh62mt2phdk89A1Kz3Cr/oZy+VE9VbJDy8d4/xTp8KM42wHjcqN7FM4nWEP7rasieU7q2CqIY4Xz23I5toENk+bJBwoJ+qivKofHeIRHWDq9I7kjUe3fDZifAt214Idk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8h0qhD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54E1C4CEE7;
	Thu, 18 Sep 2025 00:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758155599;
	bh=o4MiQ96WpVIl3/Qfj3xSthuDSBcTfTMnLxJZvdqRB30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8h0qhD0h7SOyGAepCGCQ8A7JCb6aL5xb0ZFh/PNuaawcMIGkNW2gBOw+JIY56VQH
	 SPoXT3sd13SqBqMapmOtbB2f/9X3IN7lO/8oeVgao/N11IfJN89X4ZHkWsRNctRCnR
	 bONJwguUMi9QoMDHO63xELPyHqDcseJHUsZNCBjX71T7ljz/CxY/8FH9NbXkJNlFLj
	 5pkAfqI5f1CsGCtF7RL8VXXGLfb8MPhd12JzLrHIaoCyV/y1h+VKl03FxG3OxVS1td
	 Wsc4dvej53OosOdkc/t1IRvLw0NF48H2r/FuDnzbbgmW4afN5G0s8vEo/2iahES0ws
	 J6CVvpZY9RqWQ==
Date: Thu, 18 Sep 2025 09:33:18 +0900
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: light: APDS9160: fix missing type
 definition warning
Message-ID: <20250918-heavenly-loose-newt-a416b0@kuoka>
References: <20250918-60-dt-iio-apds9160-v1-1-0bd6bcbc547d@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250918-60-dt-iio-apds9160-v1-1-0bd6bcbc547d@gentoo.org>

On Thu, Sep 18, 2025 at 05:02:01AM +0800, Yixun Lan wrote:
> DT validation will report missing type definition warning for the property of
> 'ps-cancellation-current-picoamp', explicitly add type definition to fix it.


Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

And no, this is wrong. You use some outdated dtschema.

Best regards,
Krzysztof


