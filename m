Return-Path: <linux-iio+bounces-19437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE8FAB2951
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC6A3B329A
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9440F256C97;
	Sun, 11 May 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF3h1kVQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEA42049;
	Sun, 11 May 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746976604; cv=none; b=bU/Mxw3aHvp12NlodmU0e/MuBtkGMkPB/UVUEcDsVS17yy0+05AubB39WLVw1PSuOZSO5vo9t5TMjBlQKc3qyqtFoBepVQClZmTaPeq4M+5uzAZKKl0gJzUT1myaumwVVQjn0tkTcIE57CtiWm54OWxfzyO+P2hlcqPoVlvpjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746976604; c=relaxed/simple;
	bh=TT5hMsouAJmOe04s9T7yEjGcvwsNPf0Xkjodo18zh5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+aox/sSohhasYfy6iYDJANUBUd3fwO3P55dDkMhanCDP8Hn+su9hBORQi6L1jWPjoHsR34CWZ4f2qHaUZQsvPomfv5p0uWXlTU5mYK8cMFBXFbyN6G472seS3v0JqD3YKxGrZ38PnlcaBGJ4ppRa62MhHnf2gvsg//qrl0fb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF3h1kVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FB4C4CEE4;
	Sun, 11 May 2025 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746976601;
	bh=TT5hMsouAJmOe04s9T7yEjGcvwsNPf0Xkjodo18zh5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tF3h1kVQFZm5yIk0NhHt2jJ4u4hct/hcK6evP0GcSzJ/khA/p+OgF25B4BHlJtIiN
	 rh0aEQPGgfTr+29M5P/FgbdWmStsoK4k/gMt+1DuUauRP+G41zqksKyS6r2Gm0WjyY
	 VGATQbOdr1oKfwNtVcoIJ+NsGquG7QwrWiYRPQddJtGc2a8hMdEzFJhjcT9HSzOfQv
	 65cAln8pE+QT78CzmvskjrNQLHObSWUbd+BvK1KdmMfh2p85Tv16R5MevzsZw03CLp
	 nmz4Xl0zV5ZllrFqlgxhAy+x1wMRC+JMfDgUoJmX41DUGuGy84BmSYgomEJiohC0FR
	 1hf5t1xqrMibQ==
Date: Sun, 11 May 2025 16:16:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brajesh Patil <brajeshpatil11@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 marcelo.schmitt1@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v2 0/5] iio: magnetometer: Add QMC5883L driver support
Message-ID: <20250511161633.29abebef@jic23-huawei>
In-Reply-To: <20250508120822.114060-1-brajeshpatil11@gmail.com>
References: <20250508120822.114060-1-brajeshpatil11@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  8 May 2025 13:08:22 +0100
Brajesh Patil <brajeshpatil11@gmail.com> wrote:

> This series introduces support for the QST QMC5883L 3-axis magnetometer,
> a magnetic sensor with I2C interface.
>=20
> The implementation follows standard IIO conventions and includes:
>=20
> Patch 1/5: dt-bindings: vendor-prefixes
> - Adds 'qst' prefix for QST Corporation

Make sure patch 1 also goes to linux-iio@vger.kernel.org as otherwise
I won't necessarily pick it up with the rest of the series.

Also I think the threading is broken.=20
If you are struggling with an email setup, the b4 tool can be used to
send via a web gateway with the correct formatting etc.

Jonathan



>=20
> Patch 2/5: dt-bindings: iio: magnetometer - Adds QMC5883L bindings
> - Adds compatible string and required properties
> - Includes example device tree node
>=20
> Patch 3/5: iio: magnetometer - Base driver implementation
> - Basic register access via regmap
> - X/Y/Z axis and temperature readings
> - Triggered buffer support
> - Initialization and core functionality
>=20
> Patch 4/5: Extended sysfs attributes and configuration
> - ODR (10-200Hz) and FSR (=C2=B12G/=C2=B18G) control
> - Mode selection (standby/continuous)
> - Oversampling ratio configuration (512-64)
> - Status monitoring (DRDY/OVL flags)
> - Available scale and sampling frequency attributes
>=20
> Patch 5/5: Advanced features and power management
> - Mount matrix support for orientation compensation
> - Power management (suspend/resume)
> - Control register features (soft reset, pointer rollover)
>=20
> The driver has been tested on a Raspberry Pi 5 and all features have been=
 verified.
>=20
> Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>


