Return-Path: <linux-iio+bounces-24971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC8BD05CC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5373B3E6F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D02ECE97;
	Sun, 12 Oct 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4WLeCCI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD32A2EC0A6;
	Sun, 12 Oct 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760282656; cv=none; b=QLDF1McUpP3RHFmYGLoDIFAcBBwiTGR3QjKRuhiGuZ64C7/pGgctB3iguJ69wd7w+sDqE8CPEe/i1J3NB3mMS5dsNjSRJkw/jAoPsTVdCytKX9v4bP89gTQxiD70CUjjh3GerwDR2UNsw3OV81+2862A++ZHMjXYLuFAglOZ6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760282656; c=relaxed/simple;
	bh=QW9kjndcZ5hwS4SFKboMB9IPLORgUT3zKNX5hQwBDDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wb69+ytcOQqg3nShfNJqSuE4QnkNEziEyfIpiCqjtPFE3dSowO/9qwqX5qSYLLHTEr28KXL315tQSThFHxceOpZDqPhWhCk5OdFXm2IHtVl90wauweUzYz03Z8Ly8jYVBUoo+uqiBV5i8uW+Ii5Hr5wwuOmcwV+paHE9eVWarD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4WLeCCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FE1C4CEE7;
	Sun, 12 Oct 2025 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760282655;
	bh=QW9kjndcZ5hwS4SFKboMB9IPLORgUT3zKNX5hQwBDDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p4WLeCCIZCl8y3jjrmdIMVC3H3tYnkv1TpTmzFkGtupURuAp/+bx8LvxgIKtbIgSS
	 frI8N4nmDl1tQE4zCum263wD+SuILekrjMRynZ8rDVBuZCcQmnPLuiTtJZhTjGoTjk
	 OaLjnfFWCAZ44x5DEOIUzCfTpvLuK1KhK+AHM3ub9gKuaVD1wwWAvvAJtS/47d7Irk
	 BNO26J7x2BxObf62pLdbeoiweyvHfkS2z2b2lA9nsaVplvOR995+3YZ0itc7OWb+9z
	 rn8Dbxiui24NuOI/hqfWqjU8/JxRneKqEnl5fWlZt+97SnXd8Khzq8X+rCqawbfyoy
	 ZYm8JI74r1LZQ==
Date: Sun, 12 Oct 2025 16:24:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/19] iio: accel: bma220: add debugfs reg access
Message-ID: <20251012162405.5c0f0b04@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-18-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-18-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:27 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Allow read/write access to sensor registers for use in unit-tests.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.

