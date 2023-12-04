Return-Path: <linux-iio+bounces-571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E055C80325F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 13:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB291C20A60
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C09D2376E;
	Mon,  4 Dec 2023 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQeA7YLo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5E2375B;
	Mon,  4 Dec 2023 12:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B936EC433C8;
	Mon,  4 Dec 2023 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701692375;
	bh=Fvcrfz9e4NQGCemkWVBM1zRgk03wa65KH83JIwn21Cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fQeA7YLo3GrSe21mG092HE9psRQ3BjNWbQ/RBvssCnApYD1i/z7YRLidA3pCnBEHA
	 OLENZS+FOy5GgvG8L+nKBKft+i9yGFMwqNdQsMJoJWhrTSEGT+DmT3ayr+0reTTu0k
	 9nMjrEa8nx8q3bJDkZJkfwiiY2DLQg7RyqbYz5QNFgUyhief8czFy2+UlMfRS+GctM
	 O97IrnKtf6uzMMeSjBz6BiUbTqRSIDWi4oSieTlRP6dcHlp/K9qYZIzb9qdXTkIMa8
	 pNqcugB+s4EF5cR6Gwd4JVRRKHgoHMQ5Moi+q/JILnzSMtJ8nwKO5TKE8Ix3nQiAKu
	 nmm+BgsFNlJ9A==
Date: Mon, 4 Dec 2023 12:19:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andreas Klinger
 <ak@it-klinger.de>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: honeywell,mprls0025pa: drop ref from
 pressure properties
Message-ID: <20231204121926.762cc0a5@jic23-huawei>
In-Reply-To: <20231201223547.GA2615359-robh@kernel.org>
References: <20231129111041.26782-1-krzysztof.kozlowski@linaro.org>
	<20231201223547.GA2615359-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Dec 2023 16:35:47 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Nov 29, 2023 at 12:10:41PM +0100, Krzysztof Kozlowski wrote:
> > The dtschema treats now properties with '-pascal' suffix as standard one
> > and already defines $ref for them, thus the $ref should be dropped from
> > the bindings.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > dtschema change was merged:
> > https://github.com/devicetree-org/dt-schema/commit/2a1708dcf4ff0b25c4ec46304d6d6cc655c3e635
> > but not yet released as new dtschema version.
> > 
> > This change should be applied once new dtschema version is released or
> > Rob says otherwise.  
> 
> I've made a release, so go ahead and apply this.
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and initially pushed out as testing for 0-day
etc to poke at it

Thanks,

Jonathan

