Return-Path: <linux-iio+bounces-17720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA5CA7D45D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 08:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A7A16F15D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 06:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC62253FC;
	Mon,  7 Apr 2025 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaXnqCXX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2332135A4;
	Mon,  7 Apr 2025 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008116; cv=none; b=JueOrBZERqponMo1MRoskb7SopE+wnKoy/zRIdtqvNyTE8NYBbKfj7Fbd2DPU1dwdBg/dkVITHLnnjzpTQ4FliUuVMpcQxH7+5TNOnKxA0LTFEOJ6jEMlNwmsQ8VUQmSuYHlfebBZkfRJ+KOzWrL7q6vX9YQRqWPl0lvJLUXgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008116; c=relaxed/simple;
	bh=DoJUGBL2D6O/z79KhKuE6vrMJER/aoe7N3m1hEHkVgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmZzm2KtWjsqayUeWK/oFLG1fpaQLoGLD8n6PsSc4bGx/7PAbzwre7/DVm5ygCMKqFb+l0K90eFE3ErqS9qpB2bdvJQGMgoHOptrfQmGQf5Y8Bk5ENXIALeH/tSbKbP8j6k0Ge2Bn9HcLUN2U8/+I4AyenVmrf/9w2g1JEgMB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaXnqCXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35947C4CEDD;
	Mon,  7 Apr 2025 06:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744008115;
	bh=DoJUGBL2D6O/z79KhKuE6vrMJER/aoe7N3m1hEHkVgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UaXnqCXXEuagAk6jCr/F0GwOLDmfUV7bMUTYXIni82xQXgVrf4BhwaiWbAbLN8Sg+
	 BUlflqPodN6t7s4c+/7U//8mKpr5uw+/ZIvX4gQYfRIOEJnbQmPuZZKsCIaNvyQRvP
	 kdaUhAY1vfm9EqdZ74ISV4dR2Uz6ob9vMJpgNgNt94EYoNQccmNRsch+mmoiyLSY44
	 PyE/iwxHnUMDrHMgYETyKdF7rRVJ9JBsyXDsxzmu6Z8mebBMVwclqtALX4UIXmjZRU
	 1/uoxzRE5jn5Vg+qBG3Fsad0WIxhz2DHwfAfR39ma26MbFCm6f+SBZIvDOVTbTfpgT
	 Oa+41Q7J3aRlw==
Date: Mon, 7 Apr 2025 08:41:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: adc: ad7380: add AD7389-4
Message-ID: <20250407-adorable-copper-guillemot-00c44f@shite>
References: <20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
 <20250401-iio-ad7380-add-ad7389-4-v1-1-23d2568aa24f@baylibre.com>
 <20250402-winged-ambitious-sparrow-c988c6@krzk-bin>
 <847307bf-c612-475e-84bd-31efcbd7239f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <847307bf-c612-475e-84bd-31efcbd7239f@baylibre.com>

On Wed, Apr 02, 2025 at 09:39:43AM GMT, David Lechner wrote:
> On 4/2/25 3:25 AM, Krzysztof Kozlowski wrote:
> > On Tue, Apr 01, 2025 at 05:50:08PM -0500, David Lechner wrote:
> >> Add compatible and quirks for AD7389-4. This is essentially the same as
> >> AD7380-4 but instead of having no internal reference, it has no external
> >> reference voltage supply.
> > 
> > So neither refio nor refin, but your schema says:
> > 
> >> +    then:
> >> +      properties:
> >> +        refio-supply: false
> > 
> > So what about refin, which is also external reference?
> 
> This is already handled by the existing if statement:
> 
>   - if:
>       properties:
>         compatible:
>           enum:
>             - adi,ad7380-4
>             - adi,adaq4370-4
>             - adi,adaq4380-4
>             - adi,adaq4381-4
>     then:
>       properties:
>         refio-supply: false
>       required:
>         - refin-supply
>     else:
>       properties:
>         refin-supply: false

The way the if-then are organized there is not how I would expect, so
thus confusion. Each if: condition has else:, so to understand what
applies to given model one has to read everything!

And you add here second method - if without else.

This is supposed to be simple:
if:
  - model_foo
then:
  ...

if:
  - model_bar
then:
  ...

if:
  - model_baz
then:
  ...


Best regards,
Krzysztof


