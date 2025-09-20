Return-Path: <linux-iio+bounces-24319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A33EB8C6C3
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D907E0449
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8258A2FB091;
	Sat, 20 Sep 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5MTR39o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9321E5213;
	Sat, 20 Sep 2025 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368032; cv=none; b=pPBl51Ge3FpCIjjorxVdPd5V7KQ5YXV6cg7VXHs/kloqLYxYMh6UdaddSl2MedxIdFLtf3W/mCg+yKgfPk0MPvc03QvLh+9LwaVW0sZbOmFtjKph2y0b+wNcfzptVs+cQuH5MDecZdix6yhw9o0ticx+qLT040C/lCcPVudLH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368032; c=relaxed/simple;
	bh=5oKaAyIfDbfN4oIwDxNdn4sdEmPGeHjHCUSfIsQsjCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2nDU7zPYLWR3Wtp59clDkhz2iFTUxzpaKcmUXnYfi1qtamQsFyYd4ZfsIRpIKyvQOyvVuVyDtpuP9wqbFfUV5YanyoWFcR+Yun86EQsvkZ3iH4jAhwfU+dyUtZo6Ez7YlgkROJFILb3JgzUk0RYoUDsrnjxY8cx7tfbDHHpYEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5MTR39o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C0FC4CEEB;
	Sat, 20 Sep 2025 11:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758368031;
	bh=5oKaAyIfDbfN4oIwDxNdn4sdEmPGeHjHCUSfIsQsjCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p5MTR39oi36TPPP+ihRxqinyXWMj9xhV5AyizMmf2uNSTULMsJogoM1lcieBL8TuQ
	 DrM7mxskvn8DOZ72bw/Dhd4xbNCRhPivl5jdzOu1VYKSQiW46wajMyYG4zuAJzx8r0
	 ojsvYHhI5K3SU6XNligZxEO3qwbSj/Pmf1uQnZq0nFzG8Pf1lvBR5Jv9MsPVKz10Io
	 /KdQ80l8V6KlaaomtECJSo9jrjR+UlFLifsMHG7R/IwjYqgELV9udMrmzqdUchDu0k
	 9AVGl+9ng6svzm891NaPzUdb0W1DiJcgKF4MuLxt7qhAqiq5P6V9PNy98DW/mPAUmW
	 2afzVgtM87/XQ==
Date: Sat, 20 Sep 2025 12:33:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marius Cristea <marius.cristea@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for Microchip EMC1812
Message-ID: <20250920123340.1b1d03be@jic23-huawei>
In-Reply-To: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 15:21:56 +0300
Marius Cristea <marius.cristea@microchip.com> wrote:

> This is the iio driver for EMC1812/13/14/15/33 multichannel Low-Voltage
> Remote Diode Sensor Family. The chips in the family have one internal
> and different numbers of external channels, ranging from 1 (EMC1812) to
> 4 channels (EMC1815).
> Reading diodes in anti-parallel connection is supported by EMC1814, EMC1815
> and EMC1833.
> 
> Current version of driver does not support interrupts, events and data
> buffering.
Hi Marius,

For a temperature monitoring device like this, the opening question is
always why not HWMON?

There are various reasons we have temp sensors in IIO but mostly they are not
described as being monitors and this one is.

IIO may well be the right choice for this part, but good to lay out your
reasoning and +CC the hwmon list and maintainers.  There is an emc1403
driver already in hwmon, so perhaps compare and contrast with that.

I've +CC Jean, Guenter and list to save sending a v2 just to do that.

Jonathan


> 
> Differences related to previous patch:
> 
> v1:
> - initial version.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
> Marius Cristea (2):
>       dt-bindings: iio: temperature: add support for EMC1812
>       iio: temperature: add support for EMC1812
> 
>  .../iio/temperature/microchip,emc1812.yaml         | 223 ++++++
>  MAINTAINERS                                        |   7 +
>  drivers/iio/temperature/Kconfig                    |  10 +
>  drivers/iio/temperature/Makefile                   |   1 +
>  drivers/iio/temperature/emc1812.c                  | 792 +++++++++++++++++++++
>  5 files changed, 1033 insertions(+)
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250805-iio-emc1812-e666183b07b5
> 
> Best regards,


