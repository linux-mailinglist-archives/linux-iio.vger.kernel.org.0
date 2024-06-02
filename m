Return-Path: <linux-iio+bounces-5629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544778D75A4
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1025B281AB7
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ADA3BBF1;
	Sun,  2 Jun 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJZn8weN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120320332;
	Sun,  2 Jun 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717334189; cv=none; b=WunRi6Ttmybj+3XtqV4UfieALH+7IdV31hAyiDJOMfueBNZBDITjWGJ1VdGyPVSDIA/DgS67yHNX4+qapzbnX0UyhIFqnJa3B1xaxuNeAcyLwAI7AF52X2orDVopRFb4oCMZwinDm1r/DK4fdnjJBJkKPbjcoAqLvKHQX234am4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717334189; c=relaxed/simple;
	bh=sMoLJgsY5K1mUSz3ID00IiiWFHacvr2ikiivAX13VPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqPdLTnXGSMubKM8sIF1ehaVzMfvn36x5ZwF2bZKnfvAS0ak6Uyisq72fyuNJ5Mr4fr/Za4gk/98zy6uhMcN3Lhf6yWjFkc3s5JDtqac/MaRaPdHDrJswaRw+BYv7fSU1Yall1lETc3LdIvsEsqB+XwstZIDTdOzVTyQ1NX+Mjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJZn8weN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93BEC2BBFC;
	Sun,  2 Jun 2024 13:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717334189;
	bh=sMoLJgsY5K1mUSz3ID00IiiWFHacvr2ikiivAX13VPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mJZn8weNCvjbfN+1TSoVRtblasNGkYTG3BQ5zM9q1fPPCRwyaF0w7Ht4abA/WQr3D
	 2DExzZT+KsjAjDWYZUIPRJI1uPr/3uKKEiju22E6lvBGPddZf9fveBZMBpSlSOJ/Lo
	 V5v6XcHAcoOxfmHDo2wRgSH/5qMYI5bxjdfO+OuTyGjJWiYvLOEvEiTZ0EOfMvQuAb
	 Pw3dpGrIsB64XuKdcY6tXILCI2A6wMduN8hT/U108hWf2v9yCwxACx1SFT3i5Ak5Nh
	 aGtGZN5sNb5JSrt8eJUtzsPO1OZsVS3AK5dlUaIWvCJS8xlyzlRnlUetdo5xaLonsY
	 nfggi06cwZ9tA==
Date: Sun, 2 Jun 2024 14:16:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arthur Becker <arthur.becker@sentec.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Message-ID: <20240602141617.533558c4@jic23-huawei>
In-Reply-To: <ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
	<20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
	<e47de936-8cb4-4cef-a346-74835767e203@kernel.org>
	<ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 07:23:03 +0000
Arthur Becker <arthur.becker@sentec.com> wrote:

> Thanks for the Review!
> Right, I wasn't sure if and how to add the veml6040 to the veml6075 dt-binding file.
> I'll modify that the next time I make adjustments to the driver.

Hi Arthur,

If I read the above correctly you are hoping this merges as it stands and
we come back later. If we are going to combine them long term, 
I'd rather we avoided the churn and had a combined DT binding from the start.

Jonathan

> 
> Kind regards,
> Arthur
> 
> ________________________________________
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 27 May 2024 18:31
> To: Arthur Becker; Jonathan Cameron; Lars-Peter Clausen; Rob Herring; Krzysztof Kozlowski; Conor Dooley
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> Subject: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS bindings
> 
> On 27/05/2024 17:12, Arthur Becker via B4 Relay wrote:
> > From: Arthur Becker <arthur.becker@sentec.com>
> >
> > Device tree bindings for the vishay VEML6040 RGBW light sensor iio
> > driver
> >
> > Signed-off-by: Arthur Becker <arthur.becker@sentec.com>
> > ---
> > V1 -> V3: Addressed review comments (v1 of the dt-bindings was sent
> > along with v2 of the driver but not in a set)  
> 
> It's basically the same as veml6075, so should be put there...
> 
> Eh,
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 


