Return-Path: <linux-iio+bounces-13219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7268A9E8574
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 14:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327D12810DF
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 13:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5414B077;
	Sun,  8 Dec 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kijKEmnP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375F1E495;
	Sun,  8 Dec 2024 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733664480; cv=none; b=Bh86tEcO4NWrkatvn90BMjlTS2Zey9tjvAMnPtPqSpjhZbfln41OlcpnSfJK1m9aAWylY/Nt77IcqBZmB1HEMXkch3dso/AzlhN7BE2zhVLjFGq9Fp2Eu8eVA9T5j72coLRI4oTu/Yt33YYpg3CuiKHmG1AVs4JS4xoNTFZsS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733664480; c=relaxed/simple;
	bh=VtiUYaZOtfn3CVsyx6pJoC1eY5GRj47I+wtdrvDdkFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo3pb/1OfN8d0RfmJUbJizUDi32niZzwQfJWEiiISlo+nOguTFxlAPyckjRyxdEwo6ucY5Y816rbdS8aM92D1Ha9W/bDED/ZPneToCNxj0C5upBUMAHWYlW+4rF+FVKpy8BomQQVuiMzO10CiRWHS4xXwyKjvoXljbrTXKARO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kijKEmnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1274C4CED2;
	Sun,  8 Dec 2024 13:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733664480;
	bh=VtiUYaZOtfn3CVsyx6pJoC1eY5GRj47I+wtdrvDdkFM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kijKEmnPXqw2ggfg9alGMCn9+jgEz0Z4SUwlStOyFOIdNDNLtRqsIbJTn7I7nYXua
	 XIDVYHP/o1SgjZ/EUmZBqFEokvR+ZW4L92THqvjpR2nSL9BcxQL6xSCM0oWvGMFip9
	 bXj0J32qLCatHJ4pnVOW1tqZ8D06Fl638LPj5JwRe0SYCp//vDlbMeOOLkO62WezjG
	 LyEJhZ5T1O6z0jmQf8odoMwwO+bzjeicJckINByxXgLmuEJ747BsOeifpVjUF3dd9g
	 dRi/2kpj6oZYpgM6rxFPvtIwpwLZvMy2HqxF5n+ECVWf4qtzbyBttTdwW2B8/x0F3W
	 nv/uFHTI5MQ8w==
Date: Sun, 8 Dec 2024 13:27:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 02/10] iio: accel: adxl345: rename variable data to
 st
Message-ID: <20241208132750.24ff93b8@jic23-huawei>
In-Reply-To: <20241205171343.308963-3-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-3-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:13:35 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Rename the locally used variable data to st. The st refers to "state",
> representing the internal state of the driver object. Further it
> prepares the usage of an internal data pointer needed for the
> implementation of the sensor features.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Applied to the togreg branch of iio.git. Initially pushed out as testing
to let the bots take a look.

