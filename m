Return-Path: <linux-iio+bounces-23009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A4CB2CBE3
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8F07B0DCC
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155BF30F816;
	Tue, 19 Aug 2025 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NROtux7W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE90030F7F8;
	Tue, 19 Aug 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627907; cv=none; b=PEGS4geApbKF1Smq/EN8Zf1bzZOB/ByW1+Gi/36J/WTFZZVnAjDav1dctVln/Q9DiLmQ/fhLc1XbnCKIqUWcKOaQlUkDYvvNNZsleJbJMrkMrkaw7bMX04N1EV31L7fjmFL5e+8N4s2JZR/rpvuiyRK3JV9P13N4k6P1FxYTT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627907; c=relaxed/simple;
	bh=l1i778jGY3f3jtsd2Bn9nvdzC1JGOOdvOQwZjo6ScQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJFBGm0tmzxWQMYVgjIjpJ25C0vBlHQJs9Xrp6V3dbiH+CT+rOuoqHM5tmvIlm4j/JzIOvdLulTLQMGg7y6W+doY69fHXYAeqsRH3QclRj+nonLAAE8cZe8R239MC6Cp2BaexFfmuwVRcdehsiVtIrlbuo/j0tu4E21WsNO9LvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NROtux7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3848FC4CEF1;
	Tue, 19 Aug 2025 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755627906;
	bh=l1i778jGY3f3jtsd2Bn9nvdzC1JGOOdvOQwZjo6ScQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NROtux7WttisI7F/LOyzvb1Knaov32l74MmD3roP6FClcDYwdXOa5uj+ia3L5u1ts
	 RBJj8JJpK5qrCFGfEKRgw8iUdb2neC9ezMbWEC4Zg/8jWHO4jakmGKwBoW3XhoE8Z2
	 D30zqFv+g5QmHg0Y75euHFKkXeIa6ZKjZF2ldGjD5ROnsWtDjA1uWNT5vvRLyH7YGQ
	 TnIRg/mHVYRnpw13x/0cBNu5HFSdRlk5qDbu2BVn/VlF0wsP0XHKmQ7Z+Wfxlb2acg
	 qp5OLpoozP1XkVPoHA6WvC/TDyMw/efvVCE44E+m4mdIrm6w+oGp2O7tAZY3niMQql
	 gJ2wLRWjmcoSw==
Date: Tue, 19 Aug 2025 19:24:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ben Collins <bcollins@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Collins
 <bcollins@watter.com>, David Lechner <dlechner@baylibre.com>, Nuno Sa
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: Re: [PATCH v5 0/5] iio: mcp9600: Features and improvements
Message-ID: <20250819192455.3d294562@jic23-huawei>
In-Reply-To: <20250819-ambitious-lumpy-hornet-bc1600@kuoka>
References: <20250818183214.380847-1-bcollins@kernel.org>
	<20250819-ambitious-lumpy-hornet-bc1600@kuoka>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 08:55:44 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Mon, Aug 18, 2025 at 02:32:08PM -0400, Ben Collins wrote:
> > From: Ben Collins <bcollins@watter.com>
> > 
> > ChangeLog:
> > v5 -> v6:
> >   - Fix accidental typo added in dt-bindings: IRQ_TYPE_EDGE_RISIN
> >   - Correct some constraints in dt-bindings
> >   - Reverse if/then for mcp9601 vs mcp9600 constraints in dt-bindings
> >   - Updates to changelog for patch 2/6 (dt-bindings mcp9600)
> >   - Cleanup tabs that were converted to spaces
> >   - Split thermocouple-type default to separate patch  
> 
> Please start using b4, so you will get changelogs with lore links for
> free and ALL your patches will be properly versioned. git can do that
> as well - git format-patch -v5 --cover-letter, if you don't want to use
> b4.

Second that.  This is what it looks like in patchwork that I use
for managing reviews / merges etc.
https://patchwork.kernel.org/project/linux-iio/list/?series=992678

version number not easy to find as it gets dropped from the series title
and is only normally listed for the patches. 

> 
> Best regards,
> Krzysztof
> 


