Return-Path: <linux-iio+bounces-21051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A7AEC88B
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161673B77CD
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38F8222584;
	Sat, 28 Jun 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9V/D9ZQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD72110;
	Sat, 28 Jun 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126930; cv=none; b=F3ngatFLdLoFRuOSTP/nNne+H9Yfh2vVf/62hNSgZEu8cDtJp6X+c4XE0xuqNdo3ewyNBRrdhmYZhFh+aIJ5Ss74PbMexUW9JY2IdbQllxkeOC7m7Nz0INW9sHynrf84yWxi1eMXTijddZxYvBJJ0c4KTHHXlmnuHcpNEi7dTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126930; c=relaxed/simple;
	bh=zA+J8soJGRuJe42EhBKpOOKrbnaj6+KO2tFivNkqPWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbED8qvmdMwUk2FVvVhDxhQURh7EJhNZzpLn3FeHj013VzxMvCa/9Gk4mXIRY2G9Gx43vnXActbTGm078ms9Vw6QX/mOFDpz1bWnIZI+Y4c1+ISgc9jePYIqpIzqhGI21M2cESdBCPXI0KLLx9HTevz8BHfg1S9LM9IT0qzvdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9V/D9ZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCC8C4CEEA;
	Sat, 28 Jun 2025 16:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751126930;
	bh=zA+J8soJGRuJe42EhBKpOOKrbnaj6+KO2tFivNkqPWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g9V/D9ZQTdjNPok2Hh/fFvG02tFWtsMdju2pY97Rve/dF/628WsvzXex1cus2E0sQ
	 nL1QQHTMdfgQ83FPAueOdIrMtImHHjjmHEQi5UkLq7PcYbJbV0S7eGYwryOzxmPooN
	 Po1m6kEVJDaRAS/Yl86aPKraPfKbtxEOKycfFOvxfQ/09BfPbSHk6dNzgL5twjAwJ0
	 OwG8xGUyJkIwzxzLwQgmcN8O1znghn1y/9nyuCerMwiWTAOaU6bgBR/nz4i3qtSAj2
	 8p5ztyb8sFckGAk33Y3oMVW1bVLWx2sfvXanl7hRUiCdTPWMmZ3S20NQP0ZnwZhfnm
	 OHwzZ0h/yRxHg==
Date: Sat, 28 Jun 2025 17:08:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v10 4/7] iio: accel: adxl345: add inactivity feature
Message-ID: <20250628170839.482a3d63@jic23-huawei>
In-Reply-To: <aFkh-E1dG__p_G4m@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
	<20250622155010.164451-5-l.rubusch@gmail.com>
	<aFkh-E1dG__p_G4m@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> ...
> 
> > +	case ADXL345_INACTIVITY:
> > +		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
> > +				ADXL345_INACT_Z_EN;  
> 
> Consider
> 		axis_ctrl =
> 			ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN | ADXL345_INACT_Z_EN;
> 
> (yes, I see that it's longer than 80, but it might worth doing it for the sake of
>  consistency with the previous suggestion).
Hmm. I'd go longer rather than do that just because it looks really ugly.

		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN | ADXL345_INACT_Z_EN;

I don't care that much as long as long lines are justified by readability. Here
I think either Andy's suggestion or the all on one line are justified.

Tomorrow I may have a different view :(


