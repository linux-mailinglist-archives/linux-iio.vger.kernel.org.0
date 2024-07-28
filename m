Return-Path: <linux-iio+bounces-7999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4535F93E5EA
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED1328329A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E9F5381B;
	Sun, 28 Jul 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otXWA9K8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0B1EB44;
	Sun, 28 Jul 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180634; cv=none; b=EeecWhOggxExngjc9emSg5iFl++7QA1xmEJ8UAVl964gCYDzwvitrkQBeyjLd44antbFXAv3UN8NUGQj1LxBiOiTAky/2IpupCbb1x1NShqOA8z4I7q5TCVOHkS6aKyIyFpqRfMr6HVe88oMeaRYwiO/12mjIevgtVzr8Kh2NA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180634; c=relaxed/simple;
	bh=ukkJD+lDuD4PxWjCXt/b16el8IK3CD/b9wegn3TnEx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxsdZM9pmWFoQYHTgizg5guXO0GfeAyQTxAgMYQtBlNdN8tCIXB6LzoptNGCYJXSGtwLuRuVIdyxqrvSIbDGsFAhg7pzH9riFMKOdII1e0Vx8fLe53FE1JKEuoNXKZQSOBzgZZOpayX1LO5PGvxVZR+guLdhsuwDsxdQXDRCKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otXWA9K8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C71DC32782;
	Sun, 28 Jul 2024 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722180633;
	bh=ukkJD+lDuD4PxWjCXt/b16el8IK3CD/b9wegn3TnEx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=otXWA9K8IhKJsRopRvEzRw2x3zcTg1hW6zS06LHXzueepiVMI+uSC7uFKAIn+JUNS
	 aBKI18YNZOQ5mLU8SPE04Xtl//1G9NBOIb5FUlG/TG0fODAGvoByWeEIU/LxjqS5Yf
	 K3hzH9ksVDmu95izyWNNROGKFN3I1ZZ3ZMz/Bi92P3QHuvz1QseOhuSXe9NUcQzl/P
	 4zAxXcOiNZmIo+9eOyPqUOj4b4okS1TEfdHjClQw/hthtnJvuCKXLoW6xrKcrNIlNB
	 KxrD3zNCYHy1dOj3SD/Kh9y90HAHh2E/83qaMHJu1V4VEjSjqXRnNVesiRhYWa/96/
	 5nZuXkG/DtnIA==
Date: Sun, 28 Jul 2024 16:30:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Cc: pd.pstoykov@gmail.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Add support for Sensirion SDP500
Message-ID: <20240728163026.3acadc27@jic23-huawei>
In-Reply-To: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
References: <20240725-mainline_sdp500-v4-0-ea2f5b189958@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 17:37:26 +0200
Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org> wrote:

> This patch series introduces support for Sensirion SDP500 in the IIO
> subsystem. The series is split into three patches:
> 
> 1. The first patch adds the device tree bindings.
> 2. The second patch implements the device driver.
> 3. The third patch updates the MAINTAINERS file.

Series applied.  Tweaks to patch 2 in reply to that patch.

Thanks

Jonathan

