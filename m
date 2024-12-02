Return-Path: <linux-iio+bounces-12931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6069DFC30
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 09:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238D1281D35
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9134A1F9F4D;
	Mon,  2 Dec 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICVvm8AD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C162940F;
	Mon,  2 Dec 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128943; cv=none; b=FS4b1Pu1BOIl2ZKPoX+zEXXoRlL/DLW4l+DCv310os8bLYJT5piMcnYExerWnO2BJIrYwzdjS9RGaYpKjUt0Vgo6I7XJxjQIM6yKiQ1QeT2p2Soh8jfFJ0E1d47xuMQcOW9pBMuakRyPruOMXBH/yL0OhZ0FuU5g5O0GMnz95uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128943; c=relaxed/simple;
	bh=jvw4NMlQuSYcbtZv2pdkObPtl2PPN5dj3HzQ5Xt5lQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxjKY6Ld89x0Q0wFvU1UU2ffA9wm3rKNK6TIytpQzFEnohgMIoowC075Nfh8cGpyGmpHBMaarq90Gt6N+97iKD5SOkISYLa4ryuK2hi48wmaRHdX5IyPo1d0PhODT6FMsA06Wr+8kghNrrUBMMM16m1Deh0aq2E1ddNcnWBDeHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICVvm8AD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425C5C4CED2;
	Mon,  2 Dec 2024 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733128942;
	bh=jvw4NMlQuSYcbtZv2pdkObPtl2PPN5dj3HzQ5Xt5lQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICVvm8ADhEEBTR6ymUUKGvswcAw/0Cph4xmEG4gtYcWK/Cqwx2bdqWGr63yIwx8Oa
	 tKN7EgSZd8mmMu90icSBi6fFQV/LSTCFfgn3166Sc6zCq/w+axiIpZ0IgFbhrAZQIm
	 KXBxK4L6fAVOfanv1wM6Z8yCxa4DB+FN6v2D4FzXqaUfuiUEwdqavEslPNSNzCJEm1
	 wi0CVPG1eJ02YgXx6ItIST1GzKQT7bzGVTvDZOlYyacmR7sRxxRS55Vy5cHtT81CMg
	 /frSM1pgtkhksgyljl4HO0FvkrGNY2Eq+a/WiPmI8hLNc+xmXAp1z1Qkzlr2aMF/Au
	 /9n+8i8MszBTw==
Date: Mon, 2 Dec 2024 09:42:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: Add AMS TCS3430 color sensor
 bindings
Message-ID: <yecs5hpvwjyregqjoj7rm2i3bslztmcea423comlmbmn6bygub@4l4i3bbea3ka>
References: <20241130174239.3298414-1-paulk@sys-base.io>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241130174239.3298414-1-paulk@sys-base.io>

On Sat, Nov 30, 2024 at 06:42:38PM +0100, Paul Kocialkowski wrote:
> The AMS TCS3430 is a XYZ tristimulus color sensor.
> 
> It requires a VDD power supply and can optionally support an interrupt.
> 
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> ---

Same comments as with other patchset.

Best regards,
Krzysztof


