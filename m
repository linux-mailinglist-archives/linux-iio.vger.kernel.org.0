Return-Path: <linux-iio+bounces-24523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EE7BA6E7E
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44F53ADAB0
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACB12DA760;
	Sun, 28 Sep 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/6hZ5j9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453E221FB2;
	Sun, 28 Sep 2025 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053663; cv=none; b=Ss1FCObaZSMk2tDKO02n5kJ8JD7LmMc+LgLER+/ZFWl5olX+QYIvMLc6SUSN5Y1knIcjxv3f0wLhK6Qh2sQSgfKjmBLmIz0b1IvAn5AJgMrVfnwLMlMkRsfPAfSgT4nOSkDBXUod7JL8XmBmy1tGZxrRHKdku4VGEaw+L8eiEWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053663; c=relaxed/simple;
	bh=MsdW0ogTsx+hfVtNmzcJQUMTYhEBVCWWixraqZhJ+to=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cikmnosCQUIPb+FKapMLXjqAgEjQ+tFozFAdAa45LNjLKlLXjBv2j7uSxeOwWtfR+zgHvc3yABUp8rupJYjdcDNa/dTwVkgNLqlKme3g6f3UsIg27ylpHvM044siL7f/iB5OjxGy8T9i/0RhLW3qOoM3vIIGb4W+EOa7yo3km1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/6hZ5j9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6704FC4CEF0;
	Sun, 28 Sep 2025 10:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759053661;
	bh=MsdW0ogTsx+hfVtNmzcJQUMTYhEBVCWWixraqZhJ+to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/6hZ5j9ZSx9LKmyVSE8WRnyM/Nk1c9ry6DnLRnO3bD24+kqHjzbMb6ZXCAlU5h8a
	 DmLh2Rhae2+k4hz40cL6ic5HiVVXmxCmOyvnl0U79/80kRYiiJP+yOCdz8JM4BJ+Jz
	 NhlgEdZOCANoG5LtZld4aPwZhI7CB+7YroFBv+o5nNCMu4a7Z6osFD8/+amSJm34fR
	 GyiuEt5e+TVfNUsqaNXeqxbyCrc9iNSWuxCMTEwGuPLEFuANALKz+hPz6o6f5R3L+x
	 qJA/LYjrgqSmWIdgOwQwT4O/gRb0+/0A3m39oNr7ICFwv7rSqA7PvACvmI/7HAroBC
	 d/FVl2br3SC6w==
Date: Sun, 28 Sep 2025 11:00:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Axel Haslam <ahaslam@baylibre.com>,
 <broonie@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
 <andy@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 1/1] spi: offload: Add offset parameter
Message-ID: <20250928110052.6fefd6a1@jic23-huawei>
In-Reply-To: <d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
References: <cover.1758913065.git.marcelo.schmitt@analog.com>
	<d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Sep 2025 16:01:05 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Add an offset parameter that can be passed in the periodic trigger.
> This is useful for example when ADC drivers implement a separate periodic
> signal to trigger conversion and need offload to read the result with
> some delay. While at it, add some documentation to offload periodic trigger
> parameters.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Hi Axel, Marcelo,

Is there a build time dependency on this for the ad4030 series?
I'm assuming this will go via Mark's SPI tree, so this is really a question
of do we need to ask him for an immutable branch or not.

I don't think there is such a dependency but just wanted to check!

Jonathan

