Return-Path: <linux-iio+bounces-13640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F279F7CD0
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F9165CD3
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F1224AFD;
	Thu, 19 Dec 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRn02WA4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430FE200A3;
	Thu, 19 Dec 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734617234; cv=none; b=VjHcDGPu4fdONL5G3Irkf1fSImqd3xGdSD9iop9GgAA6pD+LMCG+hKDCgwMIKt1/3Mx/hK44lat6HnB7uwONowln0kjh8XU/uvEcXwcea4QKdc95jublrDYtRKNWJyDQ8/0DtWxjyWUy6ZUZfgEsRwm8neIEaVtcAa7AHa/Gaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734617234; c=relaxed/simple;
	bh=GHVrL+MIV4eAIETBZcdXRVamX+uUqS73AazcUWFXO4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeXtEIrYf6a4EfdRRo4pTYxXGD1bKIui0yt4VYacP9Td7U4n00NR8976TsUHaIPtBthSGPWLvslYuu6LLN46r5xjE2ktKnfGA2NOiePwSBWTRm8x8AaqZsoS6P+Uhqhddx7e4KibMul7TjdWKDLyLWMN5NZiYOJtTT2r27HtbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRn02WA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D735BC4CECE;
	Thu, 19 Dec 2024 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734617233;
	bh=GHVrL+MIV4eAIETBZcdXRVamX+uUqS73AazcUWFXO4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XRn02WA4qy661imk3KFWeBV5aCDiC9fAJxbl3mbd8p91LLgYva/SFMFSFbat6ACuL
	 xSsGp4RdgXqqlsr4PgTGVYBKlV9R01CKU5YTvzDxbQTUcauMhnin2wkWCNYRCxzOuS
	 cjoKwUxbq5/6L7AxwOfCZmHBEy2fY1FeWm3FSsd68CEwQPghDxN717dsIIP5FPfGdZ
	 U9JfPStUKAsZonn9zKE6aS8gRi9BMXMjaurRh9HwZ5KuRTd9BlVCXbTUgHL0bRKQ3w
	 LkZ90r3DTpMJmm89+bttcOvTL7Ut9RTO0Uqjoz6bsyPGAr5/z7lOn2ar55yyVF6VNx
	 3dT1GhTK7Cvbg==
Date: Thu, 19 Dec 2024 14:07:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 ana-maria.cusco@analog.com, marcelo.schmitt1@gmail.com
Subject: Re: [RFC PATCH 2/4] dt-bindings: iio: adc: Add AD4170
Message-ID: <20241219140704.2d06403f@jic23-huawei>
In-Reply-To: <20241218194804.GA2203791-robh@kernel.org>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
	<caadb73da62e80877eab8b0287d996b52266d912.1734530280.git.marcelo.schmitt@analog.com>
	<20241218194804.GA2203791-robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 13:48:04 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Dec 18, 2024 at 11:37:42AM -0300, Marcelo Schmitt wrote:
> > Add device tree documentation for AD4170 sigma-delta ADCs.
> >   
> 
> The usual question with long lists of properties. Any of these should be 
> run-time controlled (by userspace) instead? If they might vary by the 
> user for given h/w design, then should be user controlled instead.

Hi Rob,

I took a look and mostly make sense in DT as they are hardware design
things as it's all about driving an external bridge circuit for
which there will be a correct configuration.

There were a few exceptions however hiding in amongst them!

ADCs that support Wheatstone bridge operations are probably my least
favourite drivers to review.  Very very fiddly as they have
complex (and random seeming) control functions for circuitry that
is off chip and only somewhat standard.

Jonathan

