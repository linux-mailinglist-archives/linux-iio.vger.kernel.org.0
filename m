Return-Path: <linux-iio+bounces-18140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2EAA8A5E8
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 19:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D3F47A35F3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7947220681;
	Tue, 15 Apr 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLqeV8/p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C9721CFEF;
	Tue, 15 Apr 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738999; cv=none; b=oF0EqV4FEhp41ZBWAW8mgnWUsY3p9jqo6oG/yN2eMYV4rPWXOFzXdlvF2NldvrR9RECIHweOGAoeG4Zu/R7lF2ghtw9l3raK72ftIZPvLBQ/B9Bs/IRVh+I49nS25MppuCgz7CKbTUuaAtIDM28VtH4Pbi2+Kv4RQf7JlIO5/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738999; c=relaxed/simple;
	bh=MZpX8K8RPGoeYtDre0iPD/x52v3l39wJKs+1j5c64rU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OU24MR66mdQmmbNquot+q/Ryulfvn3Lh3z30TcavcygrMgfejsxf13kxvD2s9O8lJ66hk1d4DttPAGDXGlQqxio381ik4nQSqPqPvJeOUMiL7EUU2GpoF3OeLySJ+GpzlEaczXFK3NznM47jYsSOjnEzC14oSXENSopWvphuPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLqeV8/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57321C4CEE9;
	Tue, 15 Apr 2025 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744738996;
	bh=MZpX8K8RPGoeYtDre0iPD/x52v3l39wJKs+1j5c64rU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PLqeV8/pcDJ0QsLmOFRdEmijR2wHdPnmbkwvweLobQzj8gLE9qNZyLTAL136b8KMz
	 ALVuzWvMzX3NHxQ05S+FkFz0vfBj7fSa6TBDdRjx3wH7sLAmCpHtnxqbKF4J1L6Akl
	 Js0yQnvT6OsvQZOIItFkryUF6IMFyKOLQEB1/bT06OmC/EKCdsckkUVz3IKjSD9tRq
	 Dulf58HhBjZqSp5xIZEyNOH7xtaTMPAFLXw1YMnR1FuBn1A/zeFFvcWcQcLBGaz29v
	 fPMiYJ9Q9hdvOnOGfKx1uMLLMD9qRaZ+4pr0JsTy2BP87pQhiAkz411Z/Vi3RKanXL
	 86IeDuMXGBrzQ==
Date: Tue, 15 Apr 2025 18:43:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/2] add support for MCP998X
Message-ID: <20250415184308.2deb6d3f@jic23-huawei>
In-Reply-To: <20250415132623.14913-1-victor.duicu@microchip.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 16:26:21 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> Add support for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.
> 
> The chip is capable of monitoring temperatures on four
> external channels and one internal.
Hi Victor,

This gets the standard question for a temperature sensor...
Why IIO and not hwmon?  Good to have that info in the cover letter or
patch description.

I'd normally moan about the wild cards even though they are only
in patch titles, but meh, the datasheet uses the wild card
so we are probably safe for a while at least!

Jonathan


> 
> Victor Duicu (2):
>   dt-bindings: iio: temperature: add support for MCP998X
>   iio: temperature: add support for MCP998X
> 
>  .../testing/sysfs-bus-iio-temperature-mcp9982 |  17 +
>  .../iio/temperature/microchip,mcp9982.yaml    | 182 ++++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/temperature/Kconfig               |  10 +
>  drivers/iio/temperature/Makefile              |   1 +
>  drivers/iio/temperature/mcp9982.c             | 794 ++++++++++++++++++
>  6 files changed, 1011 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
>  create mode 100644 drivers/iio/temperature/mcp9982.c
> 
> 
> base-commit: 31c52fe3b2efeebfc72cc5336653baaa9889b41e


