Return-Path: <linux-iio+bounces-19045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD93AA876A
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F80B18962AF
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D551D79A5;
	Sun,  4 May 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAtNS0yb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41B14A82;
	Sun,  4 May 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746373751; cv=none; b=R/OPFEFX0S+UC5B6Y1fgS1Lc5fsQCGZ2MD7SKRvGwQLhpDDwQZ0BngltZnC0ZysH3iemaTQH23ksyB7VO0cI3DmiZ6oL7ky0AEDJnh/mFEAH3MrM1LjPYBNWjtM6J/7QnZESA26cxWkRDVGHO18Bx7w2dIS693PTjNxR7COibNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746373751; c=relaxed/simple;
	bh=k/No9hzdA98pPC4TTn/gupUgQ9kiIcx6rpf26CHoipc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcEnYUy/uIara1V6R/HT5w5DqJTkfFos0MXYUikgOqiV7tMu8WE7dDIpDhY4Zzk7r0vcWzLgwnGZx8QM4crD95Hjq/Tr78c9+TsnaLIxbgqJL/nheN4eQlUYRteVC+UZXfjt3XWBPEKq6qt3tBCq42zN6GZtH6S6I0uylVQOJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAtNS0yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C518C4CEE7;
	Sun,  4 May 2025 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746373749;
	bh=k/No9hzdA98pPC4TTn/gupUgQ9kiIcx6rpf26CHoipc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CAtNS0ybXrn/1EsY6+k9DeGLA3XiueD9n6R2BASQdMgLfD4/zlInQTeBEEg0mc4Xm
	 RsJXrJz7jUj27Rxm1n0NlRAzkJAJbnKNOxBc+cANYs6ck79ERlh+PNp6rAinMQX7AU
	 ei5gKbrBc2o++JyX5wA6pX4FppsLJzSAatYu/z7NQqw1LP//gtQwdRhHAFXk43FuJT
	 YM2zucPVoB7MLsvphpE9PNyEB3owLlvMSmxGoWCwptwlXLpm8z8b+3TORAVuby5j5G
	 GcdGC87mCjQ+FQedz8M0BA3QQ2NDHoOs5othqY6AztNCZYvqXuGjZRg/5wOQNrnXLs
	 yRgsVsyoBnVUw==
Date: Sun, 4 May 2025 16:49:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: fxls8962af: Fix sign temperature
 scan element
Message-ID: <20250504164902.69901e8a@jic23-huawei>
In-Reply-To: <aBYgtRyJQXGWDgHl@debian-BULLSEYE-live-builder-AMD64>
References: <20250502-fxls-v2-0-e1af65f1aa6c@geanix.com>
	<20250502-fxls-v2-2-e1af65f1aa6c@geanix.com>
	<aBYgtRyJQXGWDgHl@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 May 2025 10:57:09 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 05/02, Sean Nyekjaer wrote:
> > TEMP_OUT register contains the 8-bit, 2's complement temperature value.
> > Let's mark the temperature scan element signed.
> > 
> > Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
> > Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>  
> 
> Sort of nitpinking but I think the commit description could be more assertive.

Agreed.  I might have just tweaked it to
"Mark the temperature element signed."  + some of what Marcelo has below.
but given Andy's request on patch 1 means you are probably doing a v3, please
tidy this up as well.

Thanks and good catches on both of them!

Jonathan

> The main idea is that we want to make the scan element signed because the
> data read from the TEMP_OUT register is in two's complement format and not
> having the scan element marked as a signed number may cause it to be mishandled
> and miss displayed. Nevertheless, I do think the patch is good so
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 


