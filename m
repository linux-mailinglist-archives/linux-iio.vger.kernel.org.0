Return-Path: <linux-iio+bounces-13322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8E9ECBFF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 13:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E972842D6
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06095225A4B;
	Wed, 11 Dec 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiTFHF0G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A3238E38;
	Wed, 11 Dec 2024 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919885; cv=none; b=nuJkCHM4IsY4qfMQbQTnceAMj9Lpe4Douy88RIG5Y+lft0hdGonScMiouXuSvoqt6fIfmAXpI123ptltkHFveoB0n/pLTn5rXTJWLLxiVL5zdPcQuR/p5xN1cLhkAPXRBk6EfQ3lBCG4jrWdK3q9PFkGtyJPwi407McBteolgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919885; c=relaxed/simple;
	bh=Ixe+0zlB0lslc06XHD6I5fHFiNcsd+/enywfypzEH6o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rREqAlxjXHhvV7sJF+nKbafDPAu9Bh+AxEDHJoojDz5IBU91LD84p7eniMM96Bu34tXjt8v5FQdAtbTam+UO98p67pzoBYW7jn1t2ZNYBxHziA4DQVWbKVMVWiaE8fbxNby4TjKUKtGWH7cGwDmq/nGCojECcsNaIoHeEjoUCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiTFHF0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D61FC4CEDE;
	Wed, 11 Dec 2024 12:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733919885;
	bh=Ixe+0zlB0lslc06XHD6I5fHFiNcsd+/enywfypzEH6o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XiTFHF0Gio4QQBgKDhi02XZ6TrhhfqCQ4XjLKCuxPGw8w1e44rrWC56dhj2L5ClFG
	 uYA5axPUtkLuAJ1YETjMesPjrEuRNplG1r68SDUgie088ONVMUXiniZRhfAv7prR6k
	 PC8xg96LxqBzejT37TlCFNpoqcOzPVcDEcmgIQg2Ye7jNB88MbtUg0GRLMzny7S5YE
	 xXhxL3lRE2jmJTnGZtU9vtwCvKucR5rYviNGlUtgA54Dj4sENYskwh3G1o4h4fFll6
	 9V7fGE7FY74Tb35nlw51qNWXlpRtaqVITWJIt5q1HcyQsqknJmje/ZZxDRbe7Vs8w+
	 pgBk0Ivd4UKIQ==
Date: Wed, 11 Dec 2024 13:24:42 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Lee Jones <lee@kernel.org>
cc: =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>, jic23@kernel.org, 
    robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
    jdelvare@suse.com, linux@roeck-us.net, srinivas.pandruvada@linux.intel.com, 
    bentiss@kernel.org, dmitry.torokhov@gmail.com, pavel@ucw.cz, 
    ukleinek@debian.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
    linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
    linux-leds@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v9 1/9] HID: hid-sensor-hub: don't use stale platform-data
 on remove
In-Reply-To: <20241211120844.GD7139@google.com>
Message-ID: <n914pn7o-pr9n-5ss0-p744-73402nnn843p@xreary.bet>
References: <20241107114712.538976-1-heiko@sntech.de> <20241107114712.538976-2-heiko@sntech.de> <nycvar.YFH.7.76.2411071358210.20286@cbobk.fhfr.pm> <4934964.GXAFRqVoOG@diego> <nycvar.YFH.7.76.2411071534110.20286@cbobk.fhfr.pm> <20241112143732.GG8552@google.com>
 <20241211120844.GD7139@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 11 Dec 2024, Lee Jones wrote:

> > > > This change was more or less a surprise find, because I wanted to make
> > > > the platform_data pointer in the mfd_cell struct const and this the hid
> > > > sensor hub stood out as doing something strange ;-) .
> > > > 
> > > > So patch 2 of this series actually depends on this change to not cause
> > > > build errors.
> > > 
> > > Ah, right.
> > > 
> > > > But seeing that we're after -rc6 alredy, I would assume the brunt of the 
> > > > mcu series might need to wait after 6.13-rc1 anyway - but I guess that 
> > > > depends on how Lee sees things ;-) .
> > > 
> > > OK, I am keeping my hands off it for the time being.
> > 
> > I can take it now with an Ack.
> 
> Looking to apply this set now.
> 
> Ack please.

I'd preferer if Srinivas could ack this as the more specific maintainer. 
Srinivas, please? 

Thanks,

-- 
Jiri Kosina
SUSE Labs


