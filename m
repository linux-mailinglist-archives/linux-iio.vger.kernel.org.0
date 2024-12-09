Return-Path: <linux-iio+bounces-13281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C49E92FB
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 12:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84B716436A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 11:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7452A2248A9;
	Mon,  9 Dec 2024 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Pr8+lrlu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ACC221D9F;
	Mon,  9 Dec 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745287; cv=none; b=G9lmPHAm0aq4M3vniyo4MCBgF5RIr5+qW6XhYxKrzs8+QwuGnTl3BZAz2airGCGHdjkJHfRjWXpLzHWx8OUcPkdk5hU8kRD8Ft+ZVuoRCg7hhyau+PL7Oxglbvy/l6H4WcqAWtOVOsYoNEb58U1pH5Aw0ERVXzMJXthoX9/dH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745287; c=relaxed/simple;
	bh=vKgDQVSCZiZVuUoe460Wv+0RAgKUSRH1hgoxUMIGfZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCcsq6PE+QdDATufEMnmDPb0AuMncWTWlBVAFdppFvWNc7hwiPCI7cnVqpKfSTNzSGlf3AmLEI2JaowZtju2J3/sYEdEBctpIC8Ae3tdn+aHXq8rv0pxOHDcJ0fykTLC5EeBOoNI9GS6z3lSC2lWPyB45Co9jNiQ26EQZfytQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Pr8+lrlu; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=LIpz7GLi/1VprLwmkdntmiNTbEeJvdJjxSq1eWwxCQo=;
	b=Pr8+lrlueEgW16+Qc/mVD55zRoidCDKiv6WEF7aoZ3vM7mmkRrl91QI0NFb/s4
	NpeZ765DFVmE+0bBHaMJ9WLDaYh88fq0lcJTZFhiYnReJIHR4ic92Gqxmi2R+5IZ
	DgtXGxcqKOFRhpHYbUISnC9SnB13IquQE44qCVzJrXIow=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCnTOBH2lZn+byPBA--.47585S3;
	Mon, 09 Dec 2024 19:53:45 +0800 (CST)
Date: Mon, 9 Dec 2024 19:53:42 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93-9x9-qsb: add temp-sensor
 nxp,p3t1085
Message-ID: <Z1baRpmr4MvsU0NQ@dragon>
References: <20241112-p3t1085-v4-0-a1334314b1e6@nxp.com>
 <20241112-p3t1085-v4-3-a1334314b1e6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-p3t1085-v4-3-a1334314b1e6@nxp.com>
X-CM-TRANSID:Ms8vCgCnTOBH2lZn+byPBA--.47585S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVdgAUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQiwZWdWofLmhQAAsN

On Tue, Nov 12, 2024 at 11:52:01AM -0500, Frank Li wrote:
> Add temp-sensor nxp,p3t1085 for imx93-9x9-qsb boards.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


