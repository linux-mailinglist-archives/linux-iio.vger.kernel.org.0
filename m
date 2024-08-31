Return-Path: <linux-iio+bounces-8920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0EB96720C
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 16:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F8DB21279
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0541BDDB;
	Sat, 31 Aug 2024 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlN7KrcQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202CCB67F;
	Sat, 31 Aug 2024 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725113252; cv=none; b=lzswMK89OavOXaDPKdBAoJuGlrZ11F/2n0uxc5Mod+E23wqWY9pN4U/T2+LHP2XQOTxg7Ve+1tXUJN4Eiy/4ZbqQgJPDvo3zUrfciwNzpPmV9Gljawzal5bXvZxcrp34vO71hs7OGzTZKzPVBGQkSnO9QfeTOY+IKPlIhCtoNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725113252; c=relaxed/simple;
	bh=/vdmoZVEwx28LixhMMtoYCBSI0UdVZq6WkEm+VOLStA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/pPVQwUKWfPoICo17j0KljOwKk9Dlg2T9cHa1vuuoFUR8J1X3cUrL3g1+dqtajaWs0X6vIggOUN5WorW5qowFp2snAHyNevUwJDXKpkfuOyTNkTq+7FOIKxVc+eQ30AiCX6wW0k2btwPNLYVGMIY9JYx34fFUrRSSHM5kdBpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlN7KrcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A9AC4CEC0;
	Sat, 31 Aug 2024 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725113251;
	bh=/vdmoZVEwx28LixhMMtoYCBSI0UdVZq6WkEm+VOLStA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DlN7KrcQ2CX9qKiczHDvzC8avGLDsRcaQj49xGEuQ6Rx1BsQ2sqxlqmd3KkAx/gRD
	 Gmf2RNhdPL31BShmTV6gc4VuQVK+opuHhzn+FPTR6EN7R00HnTsOx//4IjnMZYIgaL
	 oKqcshQqT6ZHQ/yuuTJD61IoRSsB0IQkHJ9BsrXZ/mjR5AvgmfZPoAwyqJytghwAuT
	 OrP2oJQvdryzCcwhraOQdh0lMT5cvDH1hchsX8TDu0m3tjAz4xez8e4rQieFUS0PeJ
	 Avpe1enKJIaunuoWMBYSvpJrRh57FUbt46HJ+59W3IB0h8Ip+28Pqvv0SB4+Sov1LP
	 5ZjyVc7Dqba2w==
Date: Sat, 31 Aug 2024 15:07:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V9 0/2] Add support for aw96103/aw96105 proximity sensor
Message-ID: <20240831150724.201e7d73@jic23-huawei>
In-Reply-To: <20240827080229.1431784-1-wangshuaijie@awinic.com>
References: <20240827080229.1431784-1-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 08:02:27 +0000
wangshuaijie@awinic.com wrote:

> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> Add drivers that support Awinic aw96103/aw96105 proximity sensors.
> 
> The aw9610x series are high-sensitivity capacitive proximity detection
> sensors. This device detects human proximity and assists electronic devices
> in reducing specific absorption rate (SAR) to pass SAR related certifications.
> The device reduces RF power and reduces harm when detecting human proximity. 
> Increase power and improve signal quality when the human body is far away.
> 
> The specific absorption rate (SAR) is a metric that measures the degree of
> absorption of electromagnetic radiation emitted by wireless devices,
> such as mobile phones and tablets, by human tissue.
> 
> This patch implements device initialization, registration,
> I/O operation handling and interrupt handling, and passed basic testing.
I made one trivial tweak to add static to the iio_info declaration and
applied to the togreg branch of iio.git, initially pushed out as testing
for 0-day to see if it can find any issues we missed.

Thanks,

Jonathan

