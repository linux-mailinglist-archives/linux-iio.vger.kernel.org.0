Return-Path: <linux-iio+bounces-15709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFBFA38680
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF13E7A355C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A640224881;
	Mon, 17 Feb 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4d1Znh9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2502206AA;
	Mon, 17 Feb 2025 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802846; cv=none; b=rph7Vdp11KH36Y0+s57ZITRSFQPi/OaAP6uO3fEqabc4EqkM9wcGMurC5QZOi0cxpKlu3LLzR/fnq7ernELOjJGBGrBKHZjknR80WtnZ4h4zfdDut1kl2QrRydV8frNe0XW4hXY1L5PpKopJyT4M8MuJVTsgYt1BG1W8J/1inkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802846; c=relaxed/simple;
	bh=XY2i7Z29CGAJyZKZqHFlYtn1pUICHedIw7cetxRZ664=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POuXV/D8i7i4d4dYy5hWn3bCJIenmY0yG9/3rEqmSIor2j2DfctZQ9EnQYKsw6TvZh84mOevCydWKoLUE/Hp/8IxwUutMt2CjOzayy/nTOCEyF4lOoswnnrZiISvkRcujPpuAojihstw1iVS/sivcy6OYiuwfLS+mXMZhZP6rac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4d1Znh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563F9C4CED1;
	Mon, 17 Feb 2025 14:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739802845;
	bh=XY2i7Z29CGAJyZKZqHFlYtn1pUICHedIw7cetxRZ664=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I4d1Znh95QpR8t2oVRecTwi1sfhGF8p51KwkAYCHatAqQH4MDa6JXDoMO7QJN+jtb
	 rYKrw40qNsLEiBA30PhBVaLjaSFgIWBoSk6i/2XJhFtITFE73U5Enc19JKuUNhtTQD
	 veLLeNB/sB/zpD8rZ1SghjKrVgBBD+gaDb/iQdj1sfBL067jccp2nIfPnumTUbY0sJ
	 qpTqCK5E5mf4fS80HoAhC937pWgPhFB0w5BKn3W1TwAWWPkp3GeBMfjCdvmROmNfgw
	 wfs8xNCe983soniHHMzo1uRJ4tRMT9VlQOkOnPwvlRCDkkPvoYtm6dHVNmhl/MdnjT
	 ltp1jGatypeFQ==
Date: Mon, 17 Feb 2025 14:33:54 +0000
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
Message-ID: <20250217143354.0d1c4a2d@jic23-huawei>
In-Reply-To: <20250217105753.605465-1-robert.budai@analog.com>
References: <20250217105753.605465-1-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 12:57:44 +0200
Robert Budai <robert.budai@analog.com> wrote:

> The ADIS16550 is a complete inertial system that includes a triaxis gyroscope
> and a triaxis accelerometer. Each inertial sensor in the ADIS16550 combines
> industry leading MEMS only technology with signal conditioning that optimizes
> dynamic performance. The factory calibration characterizes each sensor for
> sensitivity, bias, and alignment. As a result, each sensor has its own dynamic
> compensation formulas that provide accurate sensor measurements.
> 
Hi Robert,

The cover letter of any RESEND should always start with why you are doing so.
If this was for the tiny fixup you mentioned it should have been v9 and
not have been sent for a few days at least.  If everything else is fine
I don't mind making that sort of fixup whilst applying anyway!

Jonathan


> Robert Budai (6):
>   iio: imu: adis: Add custom ops struct
>   iio: imu: adis: Add reset to custom ops
>   iio: imu: adis: Add DIAG_STAT register
>   dt-bindings: iio: Add adis16550 bindings
>   iio: imu: adis16550: add adis16550 support
>   docs: iio: add documentation for adis16550 driver
> 
>  .../bindings/iio/imu/adi,adis16550.yaml       |   74 ++
>  Documentation/iio/adis16550.rst               |  376 ++++++
>  Documentation/iio/index.rst                   |    1 +
>  MAINTAINERS                                   |   10 +
>  drivers/iio/imu/Kconfig                       |   13 +
>  drivers/iio/imu/Makefile                      |    1 +
>  drivers/iio/imu/adis.c                        |   35 +-
>  drivers/iio/imu/adis16550.c                   | 1149 +++++++++++++++++
>  include/linux/iio/imu/adis.h                  |   34 +-
>  9 files changed, 1680 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
>  create mode 100644 Documentation/iio/adis16550.rst
>  create mode 100644 drivers/iio/imu/adis16550.c
> 


