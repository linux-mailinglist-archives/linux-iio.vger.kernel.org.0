Return-Path: <linux-iio+bounces-6088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3DC901531
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 10:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B611F2184E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA9A1CD0C;
	Sun,  9 Jun 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DymMK0mF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6231C698;
	Sun,  9 Jun 2024 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717923261; cv=none; b=NGbn18/9FCwGOEw+G6A00fYbgBv2njTF4egb7HvaWX1PWEhkqAr30IBLY6H7HO0L9NqC/f7fWXIyY4DnEr3sgfIazPiT6wUA4OvjEb4ie0Am2QUQRIDmJsciFUtdSFcsx85qKMZnxIW/EmkzACUqk/0oCtj/VJzU/9/GnFx0njM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717923261; c=relaxed/simple;
	bh=7inD+T7vfVhaoZ68VEVW45ZwOQzy3PyFZWcOhMOCrL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTxLMqTdkHvtIM6hbopTqHNKUDSqAXhd7sovhmsXd+WKrIA9ypcpkNjSvQvBvQZGsEya5Z1TySfUippa8SA5eHGU+CJ633tycNAKriC+VuP4TdfzG/V7xRGODH1KwHrL+6EY+cIUB5grvbWh1X1Bcsq8KmuSZap/roPg6V7hTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DymMK0mF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F1CC2BD10;
	Sun,  9 Jun 2024 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717923260;
	bh=7inD+T7vfVhaoZ68VEVW45ZwOQzy3PyFZWcOhMOCrL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DymMK0mFuoCRfNAhDmK1mA1ir9w7YoRCpDc9iYfiqGKeAeK9ZlLckD5Pjbqiii7/W
	 v7dYqIm22MtyWEsZHIdIBKDGhouc/oC/a2ht8NA2nKc8CwyCDagKs9bYz4XErnXOj5
	 +FwQJHG2wxVCF7lR8MqUGUGLpTSYX3TsToYCKDGRpL3I8YSmLhSDBR6Jpzn9r+JM9r
	 7Z7GMTJ/uGWyigqEWFL02qNmjDZgCI3BP2oVfvho0gDGQHewU1gm1YexEsEGIfK/xB
	 0eRsXc6Qua0od3ietulWXHbk5sZ0sB9N1rNoMJ4COsZOZPReJ0th9xqCZM5yrQr9eL
	 lpt2ePD5di4ug==
Date: Sun, 9 Jun 2024 09:53:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arthur Becker <arthur.becker@sentec.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH v4 2/2] dt-bindings: iio: light: add
 VEML6040 RGBW-LS bindings
Message-ID: <20240609095339.71cf9a78@jic23-huawei>
In-Reply-To: <f86a8de8-126b-4582-8fac-a5e273851cab@kernel.org>
References: <20240604-veml6040-v4-0-5a4d59597874@sentec.com>
	<20240604-veml6040-v4-2-5a4d59597874@sentec.com>
	<e740deb8-e412-4913-9a79-59ad8e117d53@kernel.org>
	<ZR1P278MB11171DD79D5A09580FEEF4A181F82@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
	<f86a8de8-126b-4582-8fac-a5e273851cab@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 11:05:43 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 04/06/2024 10:59, Arthur Becker wrote:
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> If there is any resend:
> >> A nit, subject: drop second/last, redundant "bindings". The
> >> "dt-bindings" prefix is already stating that these are bindings.
> >> See also:
> >> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> >>
> >> Best regards,
> >> Krzysztof  
> > 
> > Oups! I had read that part of the documentation but forgot about it...
> > I'll think about it next time.
> >   
> 
> It's fine, no worries.
> 
> Best regards,
> Krzysztof
> 
I dropped the extra word whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to take a look at it.

Thanks,

Jonathan



