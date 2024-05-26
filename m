Return-Path: <linux-iio+bounces-9329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57D970855
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE9E1F2199A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2767173345;
	Sun,  8 Sep 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+8zlbaj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1452F6F;
	Sun,  8 Sep 2024 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725808311; cv=none; b=hlg+YvAODSIX2rpwtjWXL3+czLUUHnfRiCCHUFV6YWmFULUn671AqLSDrjSGji3INyr15SdUcnCS08qN4/uvHYr3PHAvducS3yVwpFBz9XuaYL6MPCpVEOpDpw3I92RPAhAkTw1tgO9am5Qc99SwR5ujDDkNxwWdZIqjhhDddfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725808311; c=relaxed/simple;
	bh=QIe8KVt/ilAG8cwXbz/4XojndVBSms/x1BeIQ9gBAJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmrVfDSEgKm9iMLhXHn6xrCXOE8SGVcStbXBE2rh6vKIein9S2D9/qDAMIwDEEeOt7ujU/CWI874EKoAti9wjsAaEVcAtWax4aNoXa1EV6ddUHHXkLyb/97hDHM3UA2QSr2U073mKf6jar0OYBxWDQFDosAH/ruqmEwkd8QYYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+8zlbaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E1CC4CEC9;
	Sun,  8 Sep 2024 15:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725808311;
	bh=QIe8KVt/ilAG8cwXbz/4XojndVBSms/x1BeIQ9gBAJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+8zlbajcwCINhyV5scgVMpNG3JnidbLaa2vGAn/eNQRNp+5xJ7VzZ+nnza/EhseQ
	 /v5zNjS7q7CH0S49c8v0+PAlQym4Q77vftpOyWTzrV53HUV9v1Z90Oo2+4udpgoZBQ
	 FbD5+vg51SIehSDAWhg+u0IkGkr6lO7AldGS6xS0VoJuU6UzS4jXUToSdFnfzISwhL
	 6B0FMP/D6jifsId0lS4yXFp5+AJFpDwXj0kTHsMMsdUf0ZEOEHQ2G57xEMy2v+lI1C
	 7U+j1itgESp6dLN4nxH7eObGjhR7ELNyLDdvObo6S8jrHk+hrCXNGsCg7N+c95nNIs
	 AGnoWhO90eomg==
Date: Sun, 26 May 2024 13:28:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Li peiyu
 <579lpy@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hdc3020: fix hysteresis representation
Message-ID: <20240526132844.6c3979e7@jic23-huawei>
In-Reply-To: <20240524080948.GA560140@debian>
References: <20240523114336.532428-1-dima.fedrau@gmail.com>
	<cef810ee-bb2c-4588-baec-7edfc74daeea@gmail.com>
	<20240523142849.GA558466@debian>
	<17adc0d0-55c1-4608-a4c0-93f9911296f8@gmail.com>
	<20240524080948.GA560140@debian>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 10:09:48 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Am Thu, May 23, 2024 at 05:45:34PM +0200 schrieb Javier Carrasco:
> > On 23/05/2024 16:28, Dimitri Fedrau wrote:  
> > > Am Thu, May 23, 2024 at 04:12:37PM +0200 schrieb Javier Carrasco:  
> > >> Hi Dimitri, a few comments inline.
> > >>
> > >> On 23/05/2024 13:43, Dimitri Fedrau wrote:  
> > >>> According to the ABI docs hysteresis values are represented as offsets to
> > >>> threshold values. Current implementation represents hysteresis values as
> > >>> absolute values which is wrong. Nevertheless the device stores them as
> > >>> absolute values and the datasheet refers to them as clear thresholds. Fix
> > >>> the reading and writing of hysteresis values by including thresholds into
> > >>> calculations.
> > >>>
> > >>> Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
> > >>> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > >>> ---
> > >>>
> > >>> Since absolute values are used on the device, the hysteresis values are
> > >>> influenced by setting thresholds. Is this behavior in line with the ABI docs ?
> > >>> It can be fixed by readjusting the threshold clear value whenever setting
> > >>> thresholds to have the same hysteresis value as before. See some example below:
> > >>>
> > >>> # echo 25 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
> > >>> # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
> > >>> 24.727626459
> > >>> # echo 5 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
> > >>> # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
> > >>> 5.127031357
> > >>> # echo 35 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
> > >>> # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
> > >>> 15.381094071
> > >>>  
> >   
> > > Hi Javier,
> > > 
> > > thanks for reviewing so quickly. Do you think I should correct the clear
> > > threshold values once I changed the threshold. I have an example
> > > provided where I set the threshold and hysteresis. After setting the
> > > threshold again the hysteresis value also changes.
> > > 
> > > Dimitri  
> > 
> > I am not sure if I got that right. Did the rising hysteresis change its
> > value automatically from ~5 to ~15 by just adding 10 to the threshold?
> > If we are treating the hysteresis as an offset, then it should not
> > change its value i.e. it should keep the configured value.
> >
> > Best regards,
> > Javier Carrasco  
> 
> You got it right and I also think that the hysteresis value should keep
> the configured value. The doc states that the hysteresis is represented
> as offset to the threshold, but I didn't find anything related to the
> changing hysteresis value. Propably because most devices implement the
> hysteresis value as offset !? Would change this behavior in the next
> version of the patch if Jonathan agrees.

Yes. It should be an offset.  I think you are right that most devices do
it that way but even if they didn't the reality of ABI is that once we've
defined it we are stuck with it!  Here I think the offset definition makes
sense.

Note that I suspect the hysteresis value might change in corner cases where
it's not possible to keep it constant (not enough room in the register because
the offset takes it out of range) Don't worry too much about any of those
as long as we report the correct updated value.

Jonathan


> 
> Thanks again for taking time to review.
> 
> Dimitri


