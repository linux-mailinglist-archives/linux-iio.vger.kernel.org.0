Return-Path: <linux-iio+bounces-26869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE8CAB4D7
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 13:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A49E33005093
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926E32D7DCF;
	Sun,  7 Dec 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezaNlSHX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E719F137;
	Sun,  7 Dec 2025 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111592; cv=none; b=HcoTNzQaizhE9j56XiXoauNNBLecFa5U1BkaPIJfAaIRDErxVWF9H+Uh/fMxsTqHrNIQZdMx+kJW5AaxtUZpO4haUbqfWPgddbp05UUFpmt/VOinJRvxafQFJcMxtIq0R2VrBMmYTt1AMnnzmGOsrs8unpTOopnAx/NQ55RbIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111592; c=relaxed/simple;
	bh=wlwFOLybU7M/idGP2NbqZBrcGPsdwoeze2WwfbPVysM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPwnAVdVtve7MNnBphc9b4LBUdIo0jhtcPypJUyVi0Gmw433S01NOMa98BZR2UDwWAbb3kSHupR4NsLV15xzc/YHq3IYEBVs9tPU3IjDISFxmR5hm4zMkvvNy0wppQHeFeHLZgSsXidsRl8kTpPHccJT8fjF66gg/sxW0w2zWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezaNlSHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D265CC4CEFB;
	Sun,  7 Dec 2025 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765111591;
	bh=wlwFOLybU7M/idGP2NbqZBrcGPsdwoeze2WwfbPVysM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ezaNlSHXZjk73vFlt9Apj+XuFpyUB/2MRq9VxuyR9zQ9kTqoLeItv/3uiot1OUbzB
	 W1XMuyG1oqafPgAKbXEzNgqHR9FM9vf3l03gMRoX0njh+w4sjY3zXMNMirA0Wilkzh
	 xpb3e+SvDPoBzj3MV/qqvHN1989UfBfBAI0tmjK2AJflBlZzjqXGlG7JdhYAnl3V4F
	 CTnKMuKTat8ogfRUwrnMqAgR9ixxwCCXUEI/PjM5T8qsH2LtgJ8h6UkldpN9CJWE+2
	 DPd51wmCAaZQyb/b4pZgnnRZIKUADPOBWUZqF38IKQRi/3pTXinQ+REVdV6EdvFNEi
	 CI558VSUPKX5w==
Date: Sun, 7 Dec 2025 12:46:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tomas Borquez <tomasborquez13@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 1/3] staging: iio: ad9832: remove platform_data
 support
Message-ID: <20251207124625.5db016cb@jic23-huawei>
In-Reply-To: <aTRYsueq31e3CtYJ@smile.fi.intel.com>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
	<20251205202743.10530-2-tomasborquez13@gmail.com>
	<aTRYsueq31e3CtYJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Dec 2025 18:24:18 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Dec 05, 2025 at 05:27:41PM -0300, Tomas Borquez wrote:
> > Remove legacy platform_data support as there are no in tree users and
> > this approach belongs to a long gone era. The policy decision on what
> > to output is a userspace problem, not something that should be provided
> > from firmware.
> > 
> > The driver now initializes the device to a safe state (SLEEP|RESET|CLR)
> > outputting nothing. Userspace can configure the desired frequencies and
> > phases via the existing sysfs attributes once the device is ready to be   
> 
> Tailing space on the above line (and the only line with this issue).
> 
> > used.
> > 
> > Original discussion started here [1].  
> 
> The change LGTM, Jonathan, can you amend the above and apply it?
> (Yes, I have read the discussion about removal the driver, but meanwhile
>  the change is good on itself even if we are going to remove the driver.
>  It just makes an additional harmless step in my opinion.)
OK done. Small side note. If adding comments to link tags (e.g. the [1])
then use #[1].

b4 otherwise picks the thing up as two link tags. At least I think that is
what caused:

  [PATCH RFC 1/3] staging: iio: ad9832: remove platform_data support
    + Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
    + Link: ... [1]

Looks like something stripped the extra space anyway when I was applying.
I didn't bother to check what.

Jonathan

> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 


