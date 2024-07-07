Return-Path: <linux-iio+bounces-7414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEE39298D0
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3181282BA8
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 16:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD29C3FB94;
	Sun,  7 Jul 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsNPscDZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921082261D;
	Sun,  7 Jul 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720369286; cv=none; b=MWQJ+pxh8PpDkn3Yz6MFP+mlbMELeObEFr0L+6lxycUXKi0LLTKhq3l0AjXfqsNQu9sMUlNeA2/62f1pLA34NeZ4WJcxFVtyVbmx4NJXA5LfeAORgWDTKavhQQpdM1kxbjdhxgDOtiS4/b5ZVsVIDy5Iucsuy416UcK8erC7Jk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720369286; c=relaxed/simple;
	bh=31LG3ypuK+FI1GLHPt7RsbkvRYW3TKqnQ7rUf3WR0nw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWBRFhpc9QmdGdWx9ZLHIwNnRhjfrPP6Nx4bcwv6M5qENayzT/lT10PQQXUr6eHjjN/kcwJOQoFxy482V0bmpwACMEOeRH6/F7GX0iNH9vYTZv+PXQH5ixdC8Kgn8Z9BUq17UsRYqh0tjcuqHF0YDOYLV6VpJrceqFKy01OAQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsNPscDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4800C3277B;
	Sun,  7 Jul 2024 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720369286;
	bh=31LG3ypuK+FI1GLHPt7RsbkvRYW3TKqnQ7rUf3WR0nw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MsNPscDZsfyjcuwPtVCHSjPp7fwBekvv/2s88hADa1BcYjfDFQMhWNdVdbWNM/wyc
	 Yd9K43C4Yk3S2mG2O1h8bzzy3W5rc8vMLQprTjPA+hZuim6QojfSdIqaj6TKhJNS07
	 U3qAv+gOPlmztnyyyT6nTeoMmOG3WjZyaWtUNlZP2rCaoWXnriNR2uQJAuvcCjAcyC
	 zkkV8gNrRf+SpUfCl7cfs+Cko+70EXNmOL8a4oIW1OtovswP6sU8/mCxS+ASpVBX2k
	 OHHeU8Rg2ct8wZ6ZtV6Kgvat0vGBqRqUBgNgEQy7sjm58wKD8eVnAegCgWj/Cj31sw
	 LpSeXgLG9rXoQ==
Date: Sun, 7 Jul 2024 17:21:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v5 6/6] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Message-ID: <20240707172115.5146e6f0@jic23-huawei>
In-Reply-To: <20240702030025.57078-7-kimseer.paller@analog.com>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
	<20240702030025.57078-7-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 11:00:25 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> LTC2664 4 channel, 12-/16-Bit Voltage Output SoftSpan DAC
> LTC2672 5 channel, 12-/16-Bit Current Output Softspan DAC
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Looks good to me.  No rush though to get those last few DT
corners sorted as this is now 6.12 material anyway as I probably won't
be sending any more pull requests until after rc1.

Thanks,

Jonathan

