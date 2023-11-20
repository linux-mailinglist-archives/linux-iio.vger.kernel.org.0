Return-Path: <linux-iio+bounces-200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247D7F1C02
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 19:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4386D1C20E96
	for <lists+linux-iio@lfdr.de>; Mon, 20 Nov 2023 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE74330649;
	Mon, 20 Nov 2023 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="ftbWuwQ/"
X-Original-To: linux-iio@vger.kernel.org
X-Greylist: delayed 16026 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 10:09:53 PST
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA392;
	Mon, 20 Nov 2023 10:09:53 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id D1B3128EE6F;
	Mon, 20 Nov 2023 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1700503792;
	bh=LAFXLq3/2bPSJVSGrZJXAK3KfpKXjURErrX2KJDn7BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ftbWuwQ/1BA0zapxaTXhWOtIhfDasAIA3YZy2Ar/iAlmFXXhrD2C1Te7dwvg4zsxl
	 tNwwDpV6gnCszrwkLBA5jDyFwpLFuCWMjfnKkOFYPh9Nfj1Xl4ifyPDsIdnbmnyOS6
	 DN3v8EHJITfQfDtRq4GburYlV99Kt0vbQefgXMPM=
Date: Mon, 20 Nov 2023 20:09:50 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZVug7k9pJHksjOoz@sunspire>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
 <20231119134939.GA8784-robh@kernel.org>
 <ZVpswo3MSScT43Bo@sunspire>
 <20231120171903.GA2318732-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120171903.GA2318732-robh@kernel.org>


hello!

On Mon, Nov 20, 2023 at 10:19:03AM -0700, Rob Herring wrote:
> > first off, installed packages. the first 4 are not part of the 
> > official Gentoo repo, so I might have prepared them with missing 
> > options if any where not included by default.
> > I know nothing about python.
> > 
> > $ equery l dtschema pylibfdt ruamel-yaml yamllint jsonschema python 
[..]
> > [IP-] [  ] dev-python/jsonschema-4.19.1:0
> 
> 4.18 and later are not supported.
> 
> Apparently behavior we relied on in pre-4.18 was "wrong" usage... 4.18 
> also makes rust a hard dependency. That's a problem for any arch without 
> LLVM support.
> 
> Installing via pip will check this dependency.

I confirm that installing ver 4.17 of jsonschema fixed all the exceptions.

thanks.
peter

-- 
petre rodan

