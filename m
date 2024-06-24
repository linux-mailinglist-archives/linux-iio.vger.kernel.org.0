Return-Path: <linux-iio+bounces-6801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9924591483B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 13:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EDB285BCF
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F8137C2A;
	Mon, 24 Jun 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVbkFPZz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80F137911;
	Mon, 24 Jun 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227560; cv=none; b=moLnffQSybsfB3TAUCkYWI/wJULxUUyFymUemoBIO41JJfVDbp/DQpyOkRLWsrwD3M4Ff00NmIM7FDU3QeYH6z4/U/FhDYWfmuJMAaoQ4yIU/GjVypraL808TOyPPr5++ehMgm0dDtTNJwA5jzlcFDQDuuRl2N+6ZBT0EKp41cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227560; c=relaxed/simple;
	bh=WCd1Cno2RQmxTnVBJ8b3pjFHBUob0E08eBaiSA3RnxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvdZaNDwMdjB1bqlGhlI5BRgFAGkSgC534HXEA4z8PTgIzzs1nJDfCnEv0SxHALUw/Km9RYHfEwdOYuey4t76usDJe0vgMd7hh30j04OR+H2opRY8FSYOA1gXL4tDltK4osZ9EHRpYatJtX1pJRtIyMO/uwz/naPVka7vtA1oFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVbkFPZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198DDC2BBFC;
	Mon, 24 Jun 2024 11:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719227560;
	bh=WCd1Cno2RQmxTnVBJ8b3pjFHBUob0E08eBaiSA3RnxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVbkFPZzsj3YiQHPihR/F4Kw5iBijDZReGQ4XQRpWkOlq4JCMuLVewslnYRBC2K3x
	 mRzBeNEbNi8bsO4pdGwtvHmgtfJmz+E0WkSUwbuBjelEaDiXawmx67i0MaZ01Uj74j
	 moa1gx++S5e5A9c90/GuaXbGWLT05pSqaEmqIeSQzkPVwcEcsgm8vtj4KZsbO7vdme
	 8y7KqW9ZvPHdb9mNEzvNSpgRD7pQNX2weLh08zXjPBZayLTzYu0b0wTSvF1TJKqxsN
	 NJ1nLP/YQYkDW3PE+OFoEQhCg4I0BCnTDcRivo692+AldM3xbUf7fPBnr2XhSQkE6L
	 7X/FAPo6S2yLQ==
Date: Mon, 24 Jun 2024 12:12:34 +0100
From: Lee Jones <lee@kernel.org>
To: Philippe Simons <simons.philippe@gmail.com>
Cc: macroalpha82@gmail.com, broonie@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, jernej.skrabec@gmail.com,
	krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
	macromorgan@hotmail.com, robh@kernel.org, samuel@sholland.org,
	sre@kernel.org, wens@csie.org
Subject: Re: [PATCH 7/8] power: supply: axp20x_battery: add support for AXP717
Message-ID: <20240624111234.GS1318296@google.com>
References: <CADomA48AbhFaQ2yWpBYfsTiBLyGDMeqbNbxhU_j1Oi2DEeaxAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADomA48AbhFaQ2yWpBYfsTiBLyGDMeqbNbxhU_j1Oi2DEeaxAw@mail.gmail.com>

On Sat, 22 Jun 2024, Philippe Simons wrote:

> sysfs correctly reports the presence, voltage and current of the
> battery. Tested on RG35XX-H (H700)
> 
> Tested-by: Philippe Simons <simons.philippe@gmail.com>

Philippe, you've stripped all context AND replied off-of-thread, so none
of us have any context left to do anything useful with this.

-- 
Lee Jones [李琼斯]

