Return-Path: <linux-iio+bounces-12063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F99C2C21
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 12:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76CEB21D96
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C44155389;
	Sat,  9 Nov 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbDND7ON"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6E1547E2;
	Sat,  9 Nov 2024 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731151342; cv=none; b=kEEFMye+1JOWXw/x7672JT9HKutegu4TfY0stP46R/e94/dHgGcbaWnf3sw65FIBt2W7t6t+6TRsyX3ArbrR314ZQivWU+P9DIoRnb3GUwwhV6WaAK8fJVrq32WPLk9JkroDb+umwdARmNVCrvOwCoXs/D8F6ywve2qedA0AjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731151342; c=relaxed/simple;
	bh=On7OLyIbvHvdcY/4ueFsMOMwkor9DkHgs48QxTfn8oI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKpvzZkjLwpGhdTDIgM68VGK39s6rGl6BQW+Yq/1cnZUbVWJx+Ud82iw/5Tr9MBScZGUqDnn7K0bPM4uU+huM6NGTE908d9V5eFVRsIlQNthcg36YXfZM1YGcY2ynkNn+d2pRm7nyM1VWnB3gFXa4JPFlEXLLgPtQarElpPJFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbDND7ON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF36BC4CECE;
	Sat,  9 Nov 2024 11:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731151342;
	bh=On7OLyIbvHvdcY/4ueFsMOMwkor9DkHgs48QxTfn8oI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kbDND7ONngLyyE/aBO6g+6F1pzNe0ik9jXNDu4WdDYEsqYhIr9o8L3F1ymkBaRffF
	 t+EioGaU9G7YLZBbosNnf5yToiinNDgBbXJjAC8vW36lkJ4k8rCkDe9AAVzAbxtzxH
	 A1B+Nx1agq/yqaYhwFLaDwgH4UrP5O8svNIS1aHgpWFiLSU0nbKOyxFGEobSbVfo2q
	 XaQF096genfWS5g2y34zwImd+qxwRfGkUZVeoLbczeC/gsmaMCGr37qFD+6VAS/ena
	 ggKM/A5houZLYQ5z1a7bGQMWSNeQPBBB7JeflYA8ECZO7tAuXKootlsWiqpMbGwJMW
	 oW33QvK4rexOw==
Date: Sat, 9 Nov 2024 11:22:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Darius Berghe <darius.berghe@analog.com>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <alexandru.tachici@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] iio: imu: add devices to adis16480 driver
Message-ID: <20241109112212.437a4a96@jic23-huawei>
In-Reply-To: <20241108125814.3097213-1-darius.berghe@analog.com>
References: <20241108125814.3097213-1-darius.berghe@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Nov 2024 14:58:11 +0200
Darius Berghe <darius.berghe@analog.com> wrote:

> Changes in v3:
>  - resend v2 using get_maintainers.pl script, hopefully everyone is in
>    the email list now
>  - edited the dt-bindings patch to use oneOf
> 
> Darius Berghe (3):
>   iio: imu: adis16480: add devices to adis16480 driver
>   iio: imu: adis16480: add devices to adis16480 - docs
>   dt-bindings: iio: adis16480: add devices to adis16480
> 
>  .../bindings/iio/imu/adi,adis16480.yaml       | 42 ++++++-----
>  Documentation/iio/adis16480.rst               |  3 +
>  drivers/iio/imu/adis16480.c                   | 75 +++++++++++++++++++
>  3 files changed, 102 insertions(+), 18 deletions(-)
> 

Applied to the testing branch of iio.git
Note that I'll be rebasing this on 6.13-rc1 once available so
it won't be picked up by linux-next until after that (when I'll
push it out as togreg).

In the meantime, 0-day can have a first look at this.

Jonathan

