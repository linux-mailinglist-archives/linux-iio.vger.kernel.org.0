Return-Path: <linux-iio+bounces-15935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5F8A40863
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 13:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6C4189A17F
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D3420AF7E;
	Sat, 22 Feb 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ+qY9Sw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D92066CC;
	Sat, 22 Feb 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228040; cv=none; b=YZOtukoBnn53Q+CKS9VDlp9lKsSYKgh5tLzOs9+gf6Ep5NRzRrUt4x8azidrXxJvw1xFYma46TQUqF34hKt3l69SpQRnY5YfH+klc/TLcKO3U6glVAqczD1o2HYtyF/0ubsfFWlpz2yGFw6zophpspHdzGdEpZ6356Y0+qOkVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228040; c=relaxed/simple;
	bh=4A/d+ruyZ07UmHvK7aQI/9179lFHiYgbtkDZPsdi2xA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mL1zSjz5crf8CGycHPiMeqt8QvXrVXkhIKaFvW9Y3LKAGgADhhKTya35qA2kqZu94vTaaE/5+p33F9hDLN7owv5/IQV7a79rvUmmNgAfcFL32mPL4ndTR91cgjJGkdoU4SHZMOzboGiX5iJ2zDXZAI+qRpfJaD+lPUfRtu1997Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ+qY9Sw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D586AC4CED1;
	Sat, 22 Feb 2025 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740228040;
	bh=4A/d+ruyZ07UmHvK7aQI/9179lFHiYgbtkDZPsdi2xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PQ+qY9SwgwDn3RtaWfJ7Td+/UzH90G6AyvTpEY7UfoFmrJFzd1bjMh81Kvb36ThMz
	 hf4/IRdlsqdyTzGCcNF9H/cdJG+xhkpfz6OTBZixr2nUjq+cfv6uRBpNWYAruRKERt
	 nkp2UWu37FJacta7CJ3Cfy2kBK/V9nSsHm8ywplPAxh/MPZjYBJLlAPWtbX6Vy70+0
	 KFvk4XhPfXkIauCFyRNARxabacvocGKDC4Y4GLiDqJRX6G0d+7z+j6E01m9M0bXrQf
	 nKqWXuTuQJdhyJPiNaDhrVQC2IvksCfFBSIptcJEh5igE3gKdD9GwRYvR+QGcflTf+
	 /HwqqrAujzGRg==
Date: Sat, 22 Feb 2025 12:40:30 +0000
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
Message-ID: <20250222124030.57771b0c@jic23-huawei>
In-Reply-To: <20250217143354.0d1c4a2d@jic23-huawei>
References: <20250217105753.605465-1-robert.budai@analog.com>
	<20250217143354.0d1c4a2d@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 14:33:54 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 17 Feb 2025 12:57:44 +0200
> Robert Budai <robert.budai@analog.com> wrote:
> 
> > The ADIS16550 is a complete inertial system that includes a triaxis gyroscope
> > and a triaxis accelerometer. Each inertial sensor in the ADIS16550 combines
> > industry leading MEMS only technology with signal conditioning that optimizes
> > dynamic performance. The factory calibration characterizes each sensor for
> > sensitivity, bias, and alignment. As a result, each sensor has its own dynamic
> > compensation formulas that provide accurate sensor measurements.
> >   
> Hi Robert,
> 
> The cover letter of any RESEND should always start with why you are doing so.
> If this was for the tiny fixup you mentioned it should have been v9 and
> not have been sent for a few days at least.  If everything else is fine
> I don't mind making that sort of fixup whilst applying anyway!

With the tweaks to patch 5 and co-developed tags added as mentioned
in reply to that commit applied to the togreg branch of iio.git which
is initially pushed out as testing.

Jonathan

> 
> Jonathan
> 
> 
> > Robert Budai (6):
> >   iio: imu: adis: Add custom ops struct
> >   iio: imu: adis: Add reset to custom ops
> >   iio: imu: adis: Add DIAG_STAT register
> >   dt-bindings: iio: Add adis16550 bindings
> >   iio: imu: adis16550: add adis16550 support
> >   docs: iio: add documentation for adis16550 driver
> > 
> >  .../bindings/iio/imu/adi,adis16550.yaml       |   74 ++
> >  Documentation/iio/adis16550.rst               |  376 ++++++
> >  Documentation/iio/index.rst                   |    1 +
> >  MAINTAINERS                                   |   10 +
> >  drivers/iio/imu/Kconfig                       |   13 +
> >  drivers/iio/imu/Makefile                      |    1 +
> >  drivers/iio/imu/adis.c                        |   35 +-
> >  drivers/iio/imu/adis16550.c                   | 1149 +++++++++++++++++
> >  include/linux/iio/imu/adis.h                  |   34 +-
> >  9 files changed, 1680 insertions(+), 13 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> >  create mode 100644 Documentation/iio/adis16550.rst
> >  create mode 100644 drivers/iio/imu/adis16550.c
> >   
> 
> 


