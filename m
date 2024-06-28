Return-Path: <linux-iio+bounces-7028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F93191C627
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 20:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB4A285C3E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 18:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9FA6A8D2;
	Fri, 28 Jun 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJshG7sA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E027725;
	Fri, 28 Jun 2024 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600968; cv=none; b=lBvfimXSsOHbo/nwvkf7IeXBBXktduHbwnPRTBJyn+JRJZwQSL60s3Vk9r/CYR7FKwIzcPG8v4UwBaOAFP0po5QDMifSI9BeXUpCzr2gKKzWDAYFHMPlHxDD2JdORGRIP5bc2oWhjgjyVIFJ02r/sgzATbhrL3fUDkykiYFG5l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600968; c=relaxed/simple;
	bh=nbZ4B4IuGzfJbPVBIOmAq3RdE0TDLUZCXRFXhHZu+Og=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uo2r2P7wZAo/dLnuh+EIZwtFRgwDsDjRMdPNvaXCQJOczKO++by3Fos6ba3wEFifxYrJCK3uZihjN58Md4GJQ/vZ3klKh+clJ8mzjEQ9f/QyUMXvM37yagg15WvvJ3mx/+YcXt/FGBhqWz256ZCeLDT390fXmAggkBgc2intNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJshG7sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C38C32786;
	Fri, 28 Jun 2024 18:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719600967;
	bh=nbZ4B4IuGzfJbPVBIOmAq3RdE0TDLUZCXRFXhHZu+Og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gJshG7sAzkli8Ku4dDLbq7WqEPiAmGjfjwS28P42WdkkeNjV0Dv68mtlkPn0X5+lb
	 gEZ02GOVBsAKsO5kxHT/coAxwFlaZw2cLlsD/ov7y3OTYuEydLxB+JDNuh2cbapWRF
	 1cyXqblStMzwyVWxPEGmXln/zF4/nqXdjdare73iQaMZ7e3jiQMaH0jYHUEoE/zg7I
	 D4F3LwVxJ3UW9AAJMSqJxdOiMxwu8m8ACWjkGD9T4Tt307HkAUuqI5WNfQBLZNBPio
	 DUKs9kBsfNRZqvCfYv8kNxjk3fyxYmUFQJpBY2c8b4JdOKuT7rVL/++GMctkEX+ahY
	 4znbyfQH/3NXA==
Date: Fri, 28 Jun 2024 19:55:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] dt-bindings: iio: stm32: dfsdm: fix dtbs warnings on
 dfsdm audio port
Message-ID: <20240628195558.121de053@jic23-huawei>
In-Reply-To: <171952014620.474983.15354726969773132715.robh@kernel.org>
References: <20240618115912.706912-1-olivier.moysan@foss.st.com>
	<171952014620.474983.15354726969773132715.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 14:29:08 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Tue, 18 Jun 2024 13:59:12 +0200, Olivier Moysan wrote:
> > Fix warnings on DFSDM dtbs check
> > Unevaluated properties are not allowed ('dfsdm-dai' was unexpected)
> > 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> > 
> > Fixes: 11183ac07a74 ("dt-bindings: stm32: convert dfsdm to json-schema")
> > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > ---
> >  .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml       | 4 ++++
> >  1 file changed, 4 insertions(+)
> >   
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 

Applied  to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

J

