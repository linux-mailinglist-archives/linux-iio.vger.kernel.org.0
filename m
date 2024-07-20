Return-Path: <linux-iio+bounces-7743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A5A93818C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390D2B213A4
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468A127E18;
	Sat, 20 Jul 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4ii87Cm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360912FB0A;
	Sat, 20 Jul 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721483146; cv=none; b=SXmxIpw7voOsfJZeP1D7gvyP/g6Xmy+ewk4EOm8N0Zz1aPZ/xOpoUOWwcM5rVxXp5Wrj8QbZ97GXVo8g8V2A8jAaV1pOYXyTixEvjJ99e+KgxizLVtoPVNoZ1/+S8BNVJOyqtwofE+qR9yYRQtqG/m9zs0TxaARPcHBBCAYjfxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721483146; c=relaxed/simple;
	bh=ytzf4GGGRbEDjRg3olg09Q0frEnN4rT9LciUcJ5Ecwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhHopXIbNmxXLglfu8tPXAYKPf/1Mxw7eygT5mMP++HICQg5kCemlAOLemAzwpX18SvEuJX1GDkT43SWLYeby2GPni3VnLzD3E9t2kYTpB4JI5mBSnevMP3eNbuPJUzS/tCjbTXBk6h1iN6m9ORlvQy14pHLrMLQ+TZFyuQHW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4ii87Cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2ED7C2BD10;
	Sat, 20 Jul 2024 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721483145;
	bh=ytzf4GGGRbEDjRg3olg09Q0frEnN4rT9LciUcJ5Ecwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r4ii87CmRQvaPqGsune3IICbzTgHnFOny9JQydy7How2P+o6u5PgeGVDJbOt3ZmtT
	 h68gKPlGmBi+VYAddhq0gD6CtrWV6+HbGFrNyqg5t5tOj91k4m5wH829wz0KJvZDVA
	 UlQrlAeHHcQuIm75Yvd5wp5mZpRzEVgede5SJ4Qty47TgnugsJkdV2X8KTJX1HxFGy
	 kOJ6fTyaDoA8jL8aT8RgsE8iCEFhmOzI0GRP0+fQMruZDkn5a8YqjTIxWZCRu8diJK
	 wpzSqHVVfWYGrclTcSxgF29Nb5BRz9rgphVaitYa9lj1V6mMXaUhJDKxoLrfJY0fHc
	 Va+zyv9qomDXQ==
Date: Sat, 20 Jul 2024 14:45:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexandru Ardelean <aardelean@baylibre.com>
Subject: Re: [PATCH v7 0/4] iio: adc: adc7192: Improvements
Message-ID: <20240720144538.4728726d@jic23-huawei>
In-Reply-To: <f124064c-b9cf-4460-b4c2-f918b591a31f@gmail.com>
References: <20240717212535.8348-1-alisa.roman@analog.com>
	<f124064c-b9cf-4460-b4c2-f918b591a31f@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 00:36:23 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> cc: Alexandru Ardelean <aardelean@baylibre.com>
> 

I've queued this up, but it'll only be in my testing branch until rc1 is available
so plenty of time for additional review etc.

Applied to the testing branch of iio.git so 0-day can start looking for things
we missed.

Thanks,

Jonathan

