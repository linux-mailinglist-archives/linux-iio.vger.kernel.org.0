Return-Path: <linux-iio+bounces-5665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E51B8D7C68
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 09:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7F81C21B98
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 07:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFED0433BE;
	Mon,  3 Jun 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itJLId7o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17E3FBB7;
	Mon,  3 Jun 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399482; cv=none; b=cABHJVHUsBihwDj3+sguHhECrcN4y/YZZy0vlkPmSfZ8exRkYXR/shhmMPdjhXGl1tQ2OJfUrH+dBPSLPNmjgNl5FI2r0b5Z1NDofltz5C9o0pQ2lgttZItYRRCnI2c5856CnvZIP2pPHgWH/w+TNahnEbIaqGWbPH5kIh5j+eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399482; c=relaxed/simple;
	bh=FOhXogo/ndaJHFsPJGaYQZam1yDI2Ba7KUL/q8kkfOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4QElxgWW69AWOzRWkNi4r0CmLMS1/BZeaCGeABJW1yW2B5z/z/GYtsOoRbV4xsY0MyaNufznH7lUs3VGGbWrRe0FbWwKG03gJgZjs4xpZeBSTn3o7Iu6YD6VBsjmkwiV9/B9vCtuANEH5ge+WwnkVWevM6PyttjyELYtr9yyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itJLId7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35987C2BD10;
	Mon,  3 Jun 2024 07:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717399482;
	bh=FOhXogo/ndaJHFsPJGaYQZam1yDI2Ba7KUL/q8kkfOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itJLId7oTsc8I4+W0j/LT+LHNHvYuxLUUaQSBvnt6A0xYWh08CZ25iXwjnz6QWooM
	 snTYbJ9dljJg0mh5EZP3WtA+3PoojrAqU+Iva/teaIpqs/AXQC/ix13TNbXhzUhqsK
	 gX/wBgkM1GqIdYuVLNDHuc/pbC2Oz+mGnL+PrZER11cZgMUdhYx3uTOo+iDfPU+Qg3
	 0ZF6vy/AosWzFQ+VZFq+DACbnyCKKAhTbDrvkqTZQfP19m18zjyehCdzQQwxvaConQ
	 M2fdeRMBzUpzvhwudD5WAafus8zYbs664XYhG2I/19gQGzloUUFvI+XsnwZrzxZHVv
	 DwB6xutZCt0NA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sE23a-000000004VU-3wdn;
	Mon, 03 Jun 2024 09:24:39 +0200
Date: Mon, 3 Jun 2024 09:24:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: inkern: fix channel read regression
Message-ID: <Zl1vttlXz3FRVyYS@hovoldconsulting.com>
References: <20240530074416.13697-1-johan+linaro@kernel.org>
 <20240601142147.3ac40207@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601142147.3ac40207@jic23-huawei>

Hi Jonathan,

On Sat, Jun 01, 2024 at 02:21:47PM +0100, Jonathan Cameron wrote:
> On Thu, 30 May 2024 09:44:16 +0200
> Johan Hovold <johan+linaro@kernel.org> wrote:
> 
> > A recent "cleanup" broke IIO channel read outs and thereby thermal
> > mitigation on the Lenovo ThinkPad X13s by returning zero instead of the
> > expected IIO value type in iio_read_channel_processed_scale():
> > 
> > 	thermal thermal_zone12: failed to read out thermal zone (-22)
> > 
> > Fixes: 3092bde731ca ("iio: inkern: move to the cleanup.h magic")
> > Cc: Nuno Sa <nuno.sa@analog.com>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

> In meantime, Nuno please take another look at these and see if
> we have additional problem cases like this.  Given the patch
> queue I have and a busy few days it will be a while before I
> get to it but I'll try and take a close look soon as well.

Please consider getting this one into mainline as soon as possible as it
breaks thermal mitigation, which can cause literal skin burns, on all
Qualcomm platforms (and probably other platforms too).

> Longer term, in my view the readability and chance of bugs
> is reduced, but churn always introduces the possibility of
> issues like this in the short term :(

I just worry about some of the cleanup.h conversion I've seen where
inexperienced developers potentially break tested and reviewed code for
something which is often not very readable and for very little gain.

Johan

