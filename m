Return-Path: <linux-iio+bounces-12179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D01FE9C5A93
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 15:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8854F1F213E1
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD662003DB;
	Tue, 12 Nov 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g10uLWKn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A441FF02D;
	Tue, 12 Nov 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422259; cv=none; b=ODAhOCfakVy3lIz+A4/KnrF1qFKuiEvsAWhpogR3jObx/pgHVIYWVAb/J6uA2PONLQ4aDJEYCuun/RovxGpK3UccavIY6RlGmWWHjrYvF4itwAJq2GaUo27Opg/qsgYl7Fk2H9SMp7GdBlq063iIM8nGAF+7hqs98PcegN98Kos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422259; c=relaxed/simple;
	bh=yW75lJPp4kqCgCVPMkIbHw2p/49v6BgJKGW8dcF7ODw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpX8Sj2EcJgbkTCPRWfHTJAHVH34zYXNyXRLUoKeRR+FKXqdaiY3SQgAlH0cpy43C4CeiNYMgL/ypB/4qYveWu7PELEQ3+VHyGTZamIJjnALhXfrbavXB2IaICAnJVoiaiVjEvz+Dm0BY3/fzu0zGkLhd5HrM3x7ciDzY5on7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g10uLWKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614C8C4CED6;
	Tue, 12 Nov 2024 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422259;
	bh=yW75lJPp4kqCgCVPMkIbHw2p/49v6BgJKGW8dcF7ODw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g10uLWKnMoNs8UBqNHWcGrgdFo2m2PeXfTpO5UC9XQTIoFUcEsj3IY5u3+5ybgzCp
	 GwHzpvY8kxER14I30jltzkbfM01s2SLLvSrUoc9ZCd81AKxJJnXSmBsnD0D5lJwwYZ
	 4ynd1xeQEFia4kPiBk92ofykCyf7yp3dsojpsHWkEdIoFEbNCjGUJ/n2IKjkflaHPq
	 8V+c3lMxepIlwBUy1XOERaOsQSwogtCCJNZGs7mXLIbzmpGbS3qUEEgKVrCF1b4S4z
	 9rAnGcwHL6gUWUkKPNh67Tkg42dJENV5bwX7Y1I/T5STRR7Qe0qREvnIBoBc0vO2Qb
	 FTnqEQxf40XFA==
Date: Tue, 12 Nov 2024 14:37:32 +0000
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
Message-ID: <20241112143732.GG8552@google.com>
References: <20241107114712.538976-1-heiko@sntech.de>
 <20241107114712.538976-2-heiko@sntech.de>
 <nycvar.YFH.7.76.2411071358210.20286@cbobk.fhfr.pm>
 <4934964.GXAFRqVoOG@diego>
 <nycvar.YFH.7.76.2411071534110.20286@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.2411071534110.20286@cbobk.fhfr.pm>

On Thu, 07 Nov 2024, Jiri Kosina wrote:

> On Thu, 7 Nov 2024, Heiko Stübner wrote:
> 
> > This change was more or less a surprise find, because I wanted to make
> > the platform_data pointer in the mfd_cell struct const and this the hid
> > sensor hub stood out as doing something strange ;-) .
> > 
> > So patch 2 of this series actually depends on this change to not cause
> > build errors.
> 
> Ah, right.
> 
> > But seeing that we're after -rc6 alredy, I would assume the brunt of the 
> > mcu series might need to wait after 6.13-rc1 anyway - but I guess that 
> > depends on how Lee sees things ;-) .
> 
> OK, I am keeping my hands off it for the time being.

I can take it now with an Ack.

-- 
Lee Jones [李琼斯]

