Return-Path: <linux-iio+bounces-13391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820229EEE5C
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 16:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D88285ED1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 15:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F474222D4C;
	Thu, 12 Dec 2024 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbTyuEFz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F08215764;
	Thu, 12 Dec 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018941; cv=none; b=HaA+Qukjxt+CksE8MEAFg9MngHr9DEIG/bWnUiAbN5mefpMiuUyT4gUpViKqRQKl8gTBMuuKXzkQbpQ2TReVMvKejWffvljvMNrWwu3WylfnVWxdMtHnGe/DbTfEs29LVMg5S6Ge8wdxoWO8L3vwegDuWs55JaIPxRAVTks9uDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018941; c=relaxed/simple;
	bh=PKNBf0TCKuwNcifWvhSa7hUFVANZKsYx7vGJQEMnWHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oo3yWXeinRwcFx5xeplb7M8e7G3MBAiGur17IHghqY+fTz0AMxkQxv1xo3Dl1gnBXqk+W7RxDDLHnFCtEBbCNYbheuCrTaFPex47aPBk1zKrvx8yH5I5ar7Wxl7XTejV612SuBv5dnpAGwWlqXQpCNAjrjzZ3kMGTkgKnie8PtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbTyuEFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9073DC4CED3;
	Thu, 12 Dec 2024 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734018940;
	bh=PKNBf0TCKuwNcifWvhSa7hUFVANZKsYx7vGJQEMnWHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbTyuEFzQhdRJOmDrKJyk9vWtv59qHQf6NV5vzbP3QL+w07scAiTpND/D+fCd5C8M
	 HGFo7Zr4lA5KuhQLh7wMkG5WWx5Kwal2PKprL1LophqlY/WN+VyLBpsZN7PTE0uCjd
	 XCQ0F8h0QOZONPX2obr7xgnwPTHDCgpgZWYhjXMhHfrPQXzgzL7yfoJDVJvO65o1bq
	 w/zHPnbEtKLRQh0t0kyUZvpJsBX6ZnpdESQlKb/vt8tTSwZJc/KFJ6+Q+rhQJ5VEUp
	 PKEBQhBU2DPnV/ofyaUbQV54Hzth2cvwnkNcKOatzAiuYps8eAMqojXzk68jfIL7aF
	 PBNJQBAh1PLCA==
Date: Thu, 12 Dec 2024 15:55:33 +0000
From: Lee Jones <lee@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, pavel@ucw.cz, ukleinek@debian.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v9 1/9] HID: hid-sensor-hub: don't use stale
 platform-data on remove
Message-ID: <20241212155533.GG7139@google.com>
References: <20241107114712.538976-1-heiko@sntech.de>
 <20241211120844.GD7139@google.com>
 <n914pn7o-pr9n-5ss0-p744-73402nnn843p@xreary.bet>
 <3196449.TQGk6oTFT5@diego>
 <4s41717n-3888-os6o-384n-7678n0361r0s@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4s41717n-3888-os6o-384n-7678n0361r0s@xreary.bet>

On Wed, 11 Dec 2024, Jiri Kosina wrote:

> On Wed, 11 Dec 2024, Heiko Stübner wrote:
> 
> > > > > > > This change was more or less a surprise find, because I wanted to make
> > > > > > > the platform_data pointer in the mfd_cell struct const and this the hid
> > > > > > > sensor hub stood out as doing something strange ;-) .
> > > > > > > 
> > > > > > > So patch 2 of this series actually depends on this change to not cause
> > > > > > > build errors.
> > > > > > 
> > > > > > Ah, right.
> > > > > > 
> > > > > > > But seeing that we're after -rc6 alredy, I would assume the brunt of the 
> > > > > > > mcu series might need to wait after 6.13-rc1 anyway - but I guess that 
> > > > > > > depends on how Lee sees things ;-) .
> > > > > > 
> > > > > > OK, I am keeping my hands off it for the time being.
> > > > > 
> > > > > I can take it now with an Ack.
> > > > 
> > > > Looking to apply this set now.
> > > > 
> > > > Ack please.
> > > 
> > > I'd preferer if Srinivas could ack this as the more specific maintainer. 
> > > Srinivas, please? 
> > 
> > The patch already includes the
> >    Ack from Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > from a previous version, so I guess it should be ok already?
> 
> Ah, I missed that, indeed, sorry for the noise.
> 
> With that
> 
> 	Acked-by: Jiri Kosina <jkosina@suse.com>
> 
> and Lee, please feel free to take it.

Thanks, will do.

-- 
Lee Jones [李琼斯]

