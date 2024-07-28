Return-Path: <linux-iio+bounces-7998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C7B93E5E7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768091C20C62
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7276EB4A;
	Sun, 28 Jul 2024 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+QAy/dH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614847F6B;
	Sun, 28 Jul 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180585; cv=none; b=IHfCDUqIp2gv5T3L8vcLfiWKsklK7N8ZjD4EYXqt3QU7vbR4sZhEEPxPI7ER4zREKqMXjwoSDj90+Rw2vbq0vEuLNjovqm31HNaDzzd0SuqXFJWUS09MDMUCHj0M9aLfNKcwGzkW2nP2HRiQ6SaFoyeKN8LTzoqHp6CUsNsl/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180585; c=relaxed/simple;
	bh=KMq+FgXoj4NvdR8ebchxV97fWBZs8p3cgBYXpPvYHDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jESEBETtbvdi4gX9MN1LuFWO29YMZkrGw2N0nAS1/RvNKNvvW2odDWrV/tX0RGZ/6NIsvqnwbYRLsasUeTaLis0+VhIEeWoIUVyE7jljUoI+eQmOzWXSdysZhrCOt1ePGOQAfDl9SlkZotUpo063BTszeH62csFfQkkPntapxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+QAy/dH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D0AC4AF0A;
	Sun, 28 Jul 2024 15:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722180584;
	bh=KMq+FgXoj4NvdR8ebchxV97fWBZs8p3cgBYXpPvYHDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V+QAy/dH1eMB0CddycNqLslSsKubv/AfUPiqz4EjLTittbGcusn7572lfL3pmt2at
	 TY+ysF1HClTBUXLgXv5MAQtpLYQVgwRWoiL+dHM4bQR6JQnLPl0nmLBTtQjwWwk9IN
	 OPzotWp/Ro8stp3jliDKH9ekWu552iEbbdydiIueRX8wI8skrBdknsLdD6+s3aZx71
	 0OrEOYGfxyj9+2pHVXYUOiC9gB9xFJ4xkN2fuqKKxSijxcr9txzENLFa8WKRlFUw5m
	 F9NbZ7VHH3yeeKBKyQpTYZXcjY9nF3J0Sr23Xu0b+dvMmWlMttb4zZeO0JiObfUFgA
	 EFjO27XAElOGA==
Date: Sun, 28 Jul 2024 16:29:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: pd.pstoykov@gmail.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <20240728162936.2866e7e3@jic23-huawei>
In-Reply-To: <f3772311-baf6-4d45-8678-83ff248dcbf0@linaro.org>
References: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
	<20240725-mainline_sdp500-v4-2-ea2f5b189958@gmail.com>
	<f3772311-baf6-4d45-8678-83ff248dcbf0@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jul 2024 11:12:45 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 25/07/2024 17:37, Petar Stoykov via B4 Relay wrote:
> > From: Petar Stoykov <pd.pstoykov@gmail.com>
> > 
> > Sensirion SDP500 is a digital differential pressure sensor. The sensor is
> > accessed over I2C.
> > 
> > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> > ---  
> 
> > +
> > +static const struct i2c_device_id sdp500_id[] = {
> > +	{ "sdp500" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sdp500_id);
> > +
> > +static const struct of_device_id sdp500_of_match[] = {
> > +	{ .compatible = "sensirion,sdp500" },
> > +	{ .compatible = "sensirion,sdp510" },  
> 
> Drop, why do you need it? I asked about this last time. Also, your OF
> table is not in sync with I2C table, so this should raise questions.
> 

Agreed. I dropped the sdp510 entry whilst applying.
Petar, if that is wrong for some reason we are missing, then shout.
This won't go upstream for a little while yet so we can always put
it back again :)

Jonathan

> Best regards,
> Krzysztof
> 


