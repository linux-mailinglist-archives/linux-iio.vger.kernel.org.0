Return-Path: <linux-iio+bounces-6765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6637F913C72
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D33C2816F2
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302991822C5;
	Sun, 23 Jun 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKeZGhoH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E757604F;
	Sun, 23 Jun 2024 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156919; cv=none; b=npUAH8iw045cWpbFYtar2+lh5yhZ628Y/Evb2mJc3CEiTWjMwoLey46M6We0P/4aokWC6OodAXzWLvlWK1IdWcVHEojAXfHIy3jPiidUGirSOsDp5basVNioS81Ulv8Gw7IEdiWVbbQtSjnfWVGqOGEbqRTCXlcjTNdY6aJy/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156919; c=relaxed/simple;
	bh=DAbU8m8yRNPsMXhXxW+XPWmM6UebxRbt4kP8BtLSMCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOAS5kdXwrSfu7tUI2PgEDlSpUWoaf9NlEg0+7P1dDpnsdfU9Vi+s+RZoKYGyRzgDqMTnIFE7DQ7IgT7DN1g9OIhneubR1uwS/7tNaDCh0w1kSxU0tF3jg47mOtQM8C2EW9KcKII42euKsZYbwXIqHphSgOVB6IjAlFMwhMTLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKeZGhoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DF6C2BD10;
	Sun, 23 Jun 2024 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719156918;
	bh=DAbU8m8yRNPsMXhXxW+XPWmM6UebxRbt4kP8BtLSMCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IKeZGhoHQ3+rqsOQjxne/SWQ9WgF2BQjnA++bbQATtorxJAltl3Ew8DZYgGu7IEcS
	 8ymc2aMMziv+iVKdAFaDIS0yzMlCABfZ72/uSCfmjcd82ZUvzbXXersQBZLTcDh8Gl
	 QKRy24NKnRFo20rJpTfO6HYrHrbezllFIMcB2MFKVcuhOMq8r6xpl72BJMwFOYQ1iv
	 l8A/K5gKdRCFzRgdfA+Q1uTXYJ3YeguadxcesBo7Q+h08feOMTPzrOUCkVszDq1ihj
	 wwFKzbm0EAy0ZhkfNcjZ9sfAxCV9MLLTTN8/jL3BlDFvtQal1ETqdmCXjn5RUeTgzo
	 086JX8sA9N8Sw==
Date: Sun, 23 Jun 2024 16:35:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Guillaume Stols <gstols@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>,
 Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 6/9] dt-bindings: iio: adc: adi,ad7606: fix example
Message-ID: <20240623163508.4e0bdb8b@jic23-huawei>
In-Reply-To: <20240618-rack-synthetic-1d1747b34a6a@spud>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
	<20240618-cleanup-ad7606-v1-6-f1854d5c779d@baylibre.com>
	<20240618-rack-synthetic-1d1747b34a6a@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 16:10:15 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jun 18, 2024 at 02:02:38PM +0000, Guillaume Stols wrote:
> > Example uses adi,ad7606-8 as compatible, but adi,sw-mode is not
> > available for it. So remove this property from example.
> > 
> > Signed-off-by: Guillaume Stols <gstols@baylibre.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Perhaps just squash with previous patch to avoid a bisection issue
and Rob's bot failing because of this.

Jonathan

