Return-Path: <linux-iio+bounces-16337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9544A4DF05
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DEB177578
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E820409F;
	Tue,  4 Mar 2025 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM6wttCY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4480B;
	Tue,  4 Mar 2025 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094244; cv=none; b=bP9Et7ko1+YIdTNNfXyxjfAw/SjMe5sslZRTReVEU/o8pJV/0+9qOIFlFwUkykeUjBsTaBK4MZCH8GVFiBpw/+S9RgT5Q/BiaZRqGDS8wbIOzSso9nCrjH7wFB3NJD8s4WDf5SSPk4P/obUe2LpEfMzvauEox8RhQCGcC1tW4CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094244; c=relaxed/simple;
	bh=azzIv3tU6f8HE2hiKpv+s7FiEV35AFhxpECvzWmLSKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djsSyw3sCxNQblaD0tTal+LTQZKfa+xmqpj43TZ3QofRnnEl/nk5HctGabByucDynUePCtq77rqXCkzMFgPEvHyyD9A0dPXuSzt5oEWiioEQjKdPcNKkaw5gMZN9s/iRpvKIqCnMZuz9zBdK0ObDQCGu1fGkKGYU5FzJtaarpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM6wttCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FA5C4CEE5;
	Tue,  4 Mar 2025 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741094243;
	bh=azzIv3tU6f8HE2hiKpv+s7FiEV35AFhxpECvzWmLSKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UM6wttCYO2sGF2PduIojI9ajTigzByJl9nrcFH/n3e7XkI7anQSZ2WJ3V4DVmrnMW
	 3/hX8lt+RyRrWBBsLp4z6wbfCNh544sA3dzZ/UHQLXEAvSJJ7TCFxVfKQz0DXTN6SU
	 eZbG8rgJ7ZkAmC/DKDSYgmUlsAozMNdKc8sWvlJgO0fXI0XlIQv84lCjQyEEK26Omo
	 gQS6juP3m+pSd7LhsmiVam+yJ7qf1PDiosnRFNl1LdOu6SD3q6OWUUBhN3+lmiSBx9
	 7/s3H/k2Tcc32gWIQyA/O19kbA0Jt/gdRX0HEe3cSR7eJsdSBUvai9EltVuu280Vzc
	 smxGucDFiUIzg==
Date: Tue, 4 Mar 2025 13:17:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [RESEND PATCH v8 0/6] Add support for ADIS16550
Message-ID: <20250304131708.1003552a@jic23-huawei>
In-Reply-To: <20250222124030.57771b0c@jic23-huawei>
References: <20250217105753.605465-1-robert.budai@analog.com>
	<20250217143354.0d1c4a2d@jic23-huawei>
	<20250222124030.57771b0c@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 12:40:30 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 17 Feb 2025 14:33:54 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 17 Feb 2025 12:57:44 +0200
> > Robert Budai <robert.budai@analog.com> wrote:
> >   
> > > The ADIS16550 is a complete inertial system that includes a triaxis gyroscope
> > > and a triaxis accelerometer. Each inertial sensor in the ADIS16550 combines
> > > industry leading MEMS only technology with signal conditioning that optimizes
> > > dynamic performance. The factory calibration characterizes each sensor for
> > > sensitivity, bias, and alignment. As a result, each sensor has its own dynamic
> > > compensation formulas that provide accurate sensor measurements.
> > >     
> > Hi Robert,
> > 
> > The cover letter of any RESEND should always start with why you are doing so.
> > If this was for the tiny fixup you mentioned it should have been v9 and
> > not have been sent for a few days at least.  If everything else is fine
> > I don't mind making that sort of fixup whilst applying anyway!  
> 
> With the tweaks to patch 5 and co-developed tags added as mentioned
> in reply to that commit applied to the togreg branch of iio.git which
> is initially pushed out as testing.
> 
Another tweak:
0-day/ coccinelle reported:
55be950cfc6031 Robert Budai 2025-02-17  1024  	.self_test_mask = BIT(1),
55be950cfc6031 Robert Budai 2025-02-17  1025  	.self_test_reg = ADIS16550_REG_COMMAND,
55be950cfc6031 Robert Budai 2025-02-17  1026  	.cs_change_delay = 5,
55be950cfc6031 Robert Budai 2025-02-17  1027  	.unmasked_drdy = true,
55be950cfc6031 Robert Budai 2025-02-17  1028  	.status_error_msgs = adis16550_status_error_msgs,
55be950cfc6031 Robert Budai 2025-02-17 @1029  	.status_error_mask = BIT(ADIS16550_STATUS_CRC_CODE) |
55be950cfc6031 Robert Budai 2025-02-17  1030  			BIT(ADIS16550_STATUS_CRC_CONFIG) |
55be950cfc6031 Robert Budai 2025-02-17  1031  			BIT(ADIS16550_STATUS_FLASH_UPDATE) |
55be950cfc6031 Robert Budai 2025-02-17  1032  			BIT(ADIS16550_STATUS_INERIAL) |
55be950cfc6031 Robert Budai 2025-02-17  1033  			BIT(ADIS16550_STATUS_SENSOR) |
55be950cfc6031 Robert Budai 2025-02-17  1034  			BIT(ADIS16550_STATUS_TEMPERATURE) |
55be950cfc6031 Robert Budai 2025-02-17  1035  			BIT(ADIS16550_STATUS_SPI) |
55be950cfc6031 Robert Budai 2025-02-17  1036  			BIT(ADIS16550_STATUS_PROCESSING) |
55be950cfc6031 Robert Budai 2025-02-17  1037  			BIT(ADIS16550_STATUS_POWER) |
55be950cfc6031 Robert Budai 2025-02-17  1038  			BIT(ADIS16550_STATUS_BOOT) |
55be950cfc6031 Robert Budai 2025-02-17  1039  			BIT(ADIS16550_STATUS_WATCHDOG) |
55be950cfc6031 Robert Budai 2025-02-17  1040  			BIT(ADIS16550_STATUS_REGULATOR) |
55be950cfc6031 Robert Budai 2025-02-17  1041  			BIT(ADIS16550_STATUS_SENSOR_SUPPLY) |
55be950cfc6031 Robert Budai 2025-02-17  1042  			BIT(ADIS16550_STATUS_CPU_SUPPLY) |
55be950cfc6031 Robert Budai 2025-02-17  1043  			BIT(ADIS16550_STATUS_5V_SUPPLY) |
55be950cfc6031 Robert Budai 2025-02-17  1044  			BIT(ADIS16550_STATUS_CRC_CODE),

this is duplicate.  I dropped this one.

55be950cfc6031 Robert Budai 2025-02-17  1045  	.timeouts = &adis16550_timeouts,
55be950cfc6031 Robert Budai 2025-02-17  1046  };
55be950cfc6031 Robert Budai 2025-02-17  1047


> Jonathan
> 
> > 
> > Jonathan
> > 
> >   
> > > Robert Budai (6):
> > >   iio: imu: adis: Add custom ops struct
> > >   iio: imu: adis: Add reset to custom ops
> > >   iio: imu: adis: Add DIAG_STAT register
> > >   dt-bindings: iio: Add adis16550 bindings
> > >   iio: imu: adis16550: add adis16550 support
> > >   docs: iio: add documentation for adis16550 driver
> > > 
> > >  .../bindings/iio/imu/adi,adis16550.yaml       |   74 ++
> > >  Documentation/iio/adis16550.rst               |  376 ++++++
> > >  Documentation/iio/index.rst                   |    1 +
> > >  MAINTAINERS                                   |   10 +
> > >  drivers/iio/imu/Kconfig                       |   13 +
> > >  drivers/iio/imu/Makefile                      |    1 +
> > >  drivers/iio/imu/adis.c                        |   35 +-
> > >  drivers/iio/imu/adis16550.c                   | 1149 +++++++++++++++++
> > >  include/linux/iio/imu/adis.h                  |   34 +-
> > >  9 files changed, 1680 insertions(+), 13 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > >  create mode 100644 Documentation/iio/adis16550.rst
> > >  create mode 100644 drivers/iio/imu/adis16550.c
> > >     
> > 
> >   
> 
> 


