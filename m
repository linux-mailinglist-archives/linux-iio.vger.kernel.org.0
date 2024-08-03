Return-Path: <linux-iio+bounces-8206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E6946A35
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 17:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DBB1F20FE3
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6A15382C;
	Sat,  3 Aug 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdfnJzAr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114014EC4D;
	Sat,  3 Aug 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697217; cv=none; b=iiykT4m2AdGLROU096HOcJvwjK1YucDyOAFdly80OfnlpNTwCV8RwwDWT8cC5gDTRzim/ITl0fWEPEQepYyaAap1BCh3ONIym/lBIKcl2kP4m/3nSwwfWOWpFquIUldMO4znosET5pcwFlsmLkBEuS3EeG5UjRSZTTZ+5/glnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697217; c=relaxed/simple;
	bh=QjzDaMy/OSCFU3P4C6AqUwIq/XqmUUf1FqNdRrisg8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxHZHUw/9VO+GQh8XLN0rsJlUPVAliuwPd4BDN0Bdqy5hdm7fL7F9onBVDLcJpd6Y+hWa7jHqmeX4y4iJh6KhPNRM1oyARTHyY9AwEqEduGRMGx1vMpLb7niPEPAXxrq1vwThOPWJWjQpjy1WJQOwE/w0JeXVYKFN8hamTJ96Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdfnJzAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F27EC4AF0A;
	Sat,  3 Aug 2024 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722697217;
	bh=QjzDaMy/OSCFU3P4C6AqUwIq/XqmUUf1FqNdRrisg8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hdfnJzArdm6GoEn7Ic0Nd5vNJ5yQ/BZV8hW/80NoU/QxVlyKSW+SB4Ot3XoN0AIuu
	 4DwgKfpH0Z6acX6W/krkY1Di3rQFaxrXGpli0DIa8EmZs9+6rRdRWSb8ITA0IdkCi8
	 SCS/Bgf89D3r2UczN81hgV1Nn74tGXDVEwhakObnRhOg7Zs2HjGQQjLw42SjZl/op2
	 ORydfwY33LHzhI/u5N4/PmcTr3QXhgXt5yzoVXhdPfdfRGSrIoqisnC57zfhwiK9s0
	 mdvo78GiSnYq2q1fDtBrDoBMz1FTrRRrK9w0qEvCB46h0xpOc2TLwggCaMwzdpmpID
	 qVjRtfsugX8cg==
Date: Sat, 3 Aug 2024 16:00:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] docs: iio: new docs for ad7625 driver
Message-ID: <20240803160008.5761c636@jic23-huawei>
In-Reply-To: <20240731-ad7625_r1-v1-3-a1efef5a2ab9@baylibre.com>
References: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
	<20240731-ad7625_r1-v1-3-a1efef5a2ab9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 09:48:05 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add documentation for the AD7625/AD7626/AD7960/AD7961 ADCs.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
LGTM.  Includes some of the detail I'd like to also see alongside that
RFC question on DCO.

> ---
>  Documentation/iio/ad7625.rst | 91 ++++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                  |  1 +
>  2 files changed, 92 insertions(+)
> 
> diff --git a/Documentation/iio/ad7625.rst b/Documentation/iio/ad7625.rst
> new file mode 100644
> index 000000000000..61761e3b75c3
> --- /dev/null
> +++ b/Documentation/iio/ad7625.rst
> @@ -0,0 +1,91 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +====================
> +AD7625 driver
> +====================
> +
> +ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, and AD7961
> +devices. The module name is ``ad7625``.
> +
> +Supported devices
> +=================
> +
> +The following chips are supported by this driver:
> +
> +* `AD7625 <https://www.analog.com/AD7625>`_
> +* `AD7626 <https://www.analog.com/AD7626>`_
> +* `AD7960 <https://www.analog.com/AD7960>`_
> +* `AD7961 <https://www.analog.com/AD7961>`_
> +
> +The driver requires use of the Pulsar LVDS HDL project:
> +
> +* `Pulsar LVDS HDL <http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html>`_
> +
> +To trigger conversions and enable subsequent data transfer, the devices
> +require coupled PWM signals with a phase offset.
> +
> +Supported features
> +==================
> +
> +Conversion control modes
> +------------------------
> +
> +The driver currently supports one of two possible LVDS conversion control methods.
> +
> +Echoed-Clock interface mode
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. code-block::
> +
> +                                                +----------------+
> +                     +xxxxxxxxxxxxxxxxxxxxxxxxxx| CNV            |
> +                     X                          |                |
> +                     v                          |    HOST        |
> +          +----------------------------+        |                |
> +          |      CNV+/CNV-   DCO+/DCO- |xxxxxxx>| CLK_IN         |
> +          |                            |        |                |
> +          |                            |        |                |
> +          |       AD7625         D+/D- |xxxxxxx>| DATA_IN        |
> +          |                            |        |                |
> +          |                            |        |                |
> +          |                  CLK+/CLK- |<xxxxxxx| CLK & CLK_GATE |
> +          +----------------------------+        |                |
> +                                                +----------------+
> +
> +Reference voltage
> +-----------------
> +
> +Three possible reference voltage sources are supported:
> +
> +- Internal reference (only available on AD7625 and AD7626)
> +- External reference and internal buffer
> +- External reference
> +
> +The source is determined by the device tree. If ``ref-supply`` is present, then
> +the external reference is used. If ``refin-supply`` is present, then the internal
> +buffer is used. If neither is present, then the internal reference is used.
> +
> +Unimplemented features
> +----------------------
> +
> +- Self-clocked mode
> +
> +
> +Device attributes
> +=================
> +
> +The AD762x is a fully-differential ADC and has the following attributes:
> +
> ++---------------------------------------+--------------------------------------------------------------+
> +| Attribute                             | Description                                                  |
> ++=======================================+==============================================================+
> +| ``scale``                             | Scale factor to convert raw value from buffered reads to mV. |
> ++---------------------------------------+--------------------------------------------------------------+
> +
> +
> +Device buffers
> +==============
> +
> +This driver supports IIO triggered buffers.
> +
> +See :doc:`iio_devbuf` for more information.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a90972e1c5c5..97c9b03e1cf0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1268,6 +1268,7 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
> +F:	Documentation/iio/ad7625.rst
>  F:	drivers/iio/adc/ad7625.c
>  
>  ANALOG DEVICES INC AD7768-1 DRIVER
> 


