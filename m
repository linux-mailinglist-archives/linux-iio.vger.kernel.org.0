Return-Path: <linux-iio+bounces-8891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ECD9659F1
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 10:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D46C1F24484
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCF016DED4;
	Fri, 30 Aug 2024 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCXsHsJq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3C1531CD;
	Fri, 30 Aug 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005800; cv=none; b=eB1plt6f01JkHu1eWjk9RpP1GbPJWSwcjUXdJmkRfkJdh/KLu1NcaZP6sx5yOWSpTSSn8yErkHWtke9N36quFlmaxdUXYIXDnwRQGFI9qbbxXeBvX7g6Sr3izr0S3kZFUc4mewok8QHTcxRP34BenCzLP8nLNFuv6bOHDCBZulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005800; c=relaxed/simple;
	bh=MG9+FSOwpHPPAIZp15fzWWgzZZG7+ro0BmYE/pM5Kvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv6MDdRmQ72kOg+C/tVbsEkvwCirlm7bDBa2DCB2VihmXsEPeH49yLAoOzE9UodoFa/D+FXUpIBXR0TChjCAqo/OAQdwkPnS01BlLwqFfzVfqfx+GsFR9f9OHePtz/Vc5o/qaEjWjn778KpJg/+lsWHAWO5YvmKVGxCHMGxjgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCXsHsJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC71C4CED3;
	Fri, 30 Aug 2024 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725005799;
	bh=MG9+FSOwpHPPAIZp15fzWWgzZZG7+ro0BmYE/pM5Kvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LCXsHsJqND33H+cT8yoYbcXxjUARgjBG94mxukWpolQ4HzYDeBtotYMJekZe/Tf3S
	 zW3UE61X5FtKEtq/LAVYgGyT6da8F1mA6swt5npu5+WLPK4zNO4+IuSMcGjuQrSYhJ
	 c9OBv1EP/5g3jvJpy0RumX0WOQu+RK6n1DnjeMeFkjJdYpkxANxiAeQ1LkEIOk9zdk
	 VUsSEVDCYItvgqhRUD9SHd5Rx2BV054E2rLma2k0R6q8qNiwSBYk7+w+NCm5r7ShYP
	 kj4wsQ3HgOIkSN0tDkhuPx1a3TA9U7BpI0H6iV+TQcqxXmOBq+lXFwurlHtV36NDgk
	 RJRwOJwp/acNQ==
Date: Fri, 30 Aug 2024 10:16:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
Message-ID: <lets4c46zg4rzfqrjakeby3oa3zhxh4nyfcg4vxhfnufcpaxak@xmzdwb47xhx5>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
 <20240829-stopwatch-morality-a933abb4d688@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829-stopwatch-morality-a933abb4d688@spud>

On Thu, Aug 29, 2024 at 04:46:59PM +0100, Conor Dooley wrote:
> On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add bus property.
> 
> RFC it may be, but you do need to explain what this bus-type actually
> describes for commenting on the suitability of the method to be
> meaningful.
> 
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > index a55e9bfc66d7..a7ce72e1cd81 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > @@ -38,6 +38,15 @@ properties:
> >    clocks:
> >      maxItems: 1
> 
> You mentioned about new compatible strings, does the one currently
> listed in this binding support both bus types?
> 
> Making the bus type decision based on compatible only really makes sense
> if they're different versions of the IP, but not if they're different
> configuration options for a given version.
> 

Yeah, in general the parent defines the bus type.

Best regards,
Krzysztof


