Return-Path: <linux-iio+bounces-16207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F2A4A602
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 23:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D5F7AA3CA
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6BC1DED48;
	Fri, 28 Feb 2025 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P9EXVml5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F31DE3C4
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782199; cv=none; b=ioC8+o9pHoMMxQUaVmsjF2rqI74gst9wfJGeulyx5sffyPH32ytpMSxYbi2tv9EdxU0xMElG5Ue+ivBcE9X4AX9YbX7xu7X13OKRm9mkl09nbP2NYsHRGYl1IpQUd2rHvp/RcUmQWzJf4kmddWSamcL2Og/znwL+/WOfDAGXNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782199; c=relaxed/simple;
	bh=dj9aUqKq7K6s4IS0PgCRGxyEXLKogXQQAAAwNjRJNiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3ndCs5+SRKajkJpXF8szYsCUKKaHtKeemFqhpkb3TNq9puFbV/w0G33OY2wTtPjiGg5F6sGKa8lWOmJoSUMVgyja5Oe8zEfY5l2ouplknz71tRuVbDmESGOOS0qOucP3kpXwixHME9HJyKTKeK1Z2NIv1mDEGmjHn60c3jLvO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P9EXVml5; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fcd509468eso1170984eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 14:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740782195; x=1741386995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LxgtYWhq4VVZT74cQGrqn2Xp9MqE7TZL5iblYOskVVA=;
        b=P9EXVml5rY8bLRRb/M8X7ARx055Ghot55OhMINyh4qlZscyfQhYLJyZxDxv4eW6eu2
         q0MykSLQ/7Rey1gcHCPGWIXqGQVhjc8pl0ZEY+ORWGAdWsIPCFFl4JJWvUBt4d8esvMH
         KfGNe4zrFa3YMb1icOyyVsTBhhMGANQ2JbVJSTy7D9q7bPGGkSQDW82D7DaWF7fqf1bI
         I5OqEgV4yHzx2FPMYU/uUPP+4De9DnZv1kY573N2AZ+t0uZdiF5me6lSKOexsgFntIOd
         4ogCxsJm8fGeJe5oi4vUy4u4l9JPJkHpaLhBEU0FAYja51dylDhd2R7VJHJ1/KuSJTLz
         ISDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782195; x=1741386995;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxgtYWhq4VVZT74cQGrqn2Xp9MqE7TZL5iblYOskVVA=;
        b=B+MbVrQhW1cAzYs/tuiJ6va+F4QiqV1hYxKs7E7QXk8JL4BIbEu1U1npWn2zyupJkc
         MuxufIluWD2r4tZ9ti3EFoM/L6X3XcP0SS81B8udRJZ2v26X9zr6hbBhOM3kc0g2+oJ7
         EvkbXmWd2edLB71JkK4oqy+Dg9JYZoCBsPZ2sG31vbT0uE6hKAjKFiFtYM9029a7Fdw3
         kNTob+dzyokEoDY/qE197pjJjPH6z+hKmGe6bBReUz/87TpfJzO2BZYrqrXva67CjJM9
         2AHPGpVX2ZQA5JDiQFlMNiH35a8pS/vx6Aj8KxfdNXkosXGhnS5mg90aDpr9s1HK2wzt
         +FTA==
X-Gm-Message-State: AOJu0YxmQk86e+S97PyGQmCrpmiWLQF9b+8gTrfctFxp8sHuedxOvlYh
	vb1l823fr3f2DXVXKVcITpc6fSlV/jQGZDy2uMqNoKfSNx+Y6vD+TeV9qoeKHjU=
X-Gm-Gg: ASbGncsr/XCRlcXfr9KvsTBIwzoGKFaZZJ3q0xTiwnLGEbaw2CoHHfLOa524vQPzXF5
	Oo0bGBQ52iiFgXrcUCojJa4u1NkM1b7FZy0TuCk4eQNHTuaKpabZjHMjD0iBlRu6yJxzQ5dKFnl
	Ljqni0OJ/caAUsT9T9XjX3oHtYcYOwO/gVUmipS5VlZtWmHEVaaIaH0mjNrw3xWRP/ejZu+BZn6
	1DX/+GDLXPBNAlGqbJnUC7DkwcsjW4SUwGyJmRr1qPPk5YTlr9z9QGfIkwkaW54GKxIEanrRawd
	Qe5Xc2F3QM0hQ2qaiBl5yHyj3Ahb3u7WoP7ORsfnvfQQjz+V0LlogUWi3iYSv7HofypjzVp9mgm
	/U9j25A==
X-Google-Smtp-Source: AGHT+IHqvEXueQVCTasX8QfXzE6WK79uLmJfT3y2kkxzOgtoyjC6KYNPZrv39VbgXM+hrCQRR8Y13A==
X-Received: by 2002:a05:6870:a686:b0:2b8:2a9d:5663 with SMTP id 586e51a60fabf-2c1783b22cbmr3269639fac.11.1740782195287;
        Fri, 28 Feb 2025 14:36:35 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c15c1aa1f2sm902532fac.27.2025.02.28.14.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 14:36:33 -0800 (PST)
Message-ID: <09afc3cc-a307-4662-bd70-0cf83f8f38e0@baylibre.com>
Date: Fri, 28 Feb 2025 16:36:31 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] Add Linux Motion Control subsystem
To: David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250227162823.3585810-1-david@protonic.nl>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250227162823.3585810-1-david@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 10:28 AM, David Jander wrote:
> Request for comments on: adding the Linux Motion Control subsystem to the
> kernel.
> 
> The Linux Motion Control subsystem (LMC) is a new kernel subsystem and
> associated device drivers for hardware devices that control mechanical
> motion. Most often these are different types of motors, but can also be
> linear actuators for example.

This is something that I played around with when I first got into Linux
kernel hacking as a hobbyist. It's something I've always wanted to see get
upstreamed, so feel free to cc me on any future revisions of this series.
I'm very interested. :-)

We made drivers for basic DC motors driven by an H-bridge both with and without
position feedback and also a driver for hobby-type servo motors. For those
interested, there is code [1] and docs [2]. One thing we would do different
if doing it over again is use a character device instead of sysfs attributes
as the interface for starting/stopping/adjusting actuation.

[1]: https://github.com/ev3dev/lego-linux-drivers/tree/ev3dev-stretch/motors
[2]: http://docs.ev3dev.org/projects/lego-linux-drivers/en/ev3dev-stretch/motors.html

> 
> This subsystem defines a new UAPI for motion devices on the user-space
> side, as well as common functionality for hardware device drivers on the
> driver side.
> 
> The UAPI is based on a ioctl() interface on character devices representing
> a specific hardware device. The hardware device can control one or more
> actuators (motors), which are identified as channels in the UAPI. It is
> possible to execute motions on individual channels, or combined
> affecting several selected (or all) channels simutaneously. Examples of
> coordinated movements of several channels could be the individual axes
> of a 3D printer or CNC machine for example.
> 
> On the hardware side, this initial set of patches also includes two drivers
> for two different kinds of motors. One is a stepper motor controller
> device that containes a ramp generator capable of autonomously executing
> controlled motions following a multi-point acceleration profile
> (TMC5240), as well as a simple DC motor controller driver that can control
> DC motors via a half-bridge or full H-bridge driver such as the TI DRV8873
> for example.
> 
> Towards the IIO subsystem, LMC supports generating iio trigger events that
> fire at certain motion events, such as passing a pre-programmed position or
> when reaching the motion target position, depending on the capabilities of
> the hardware device. This enables for example triggering an ADC measurement
> at a certain position during a movement.

I would expect to be using the counter subsystem for position, at least in
cases where there is something like a quadrature encoder involved.

> 
> In the future, making use of PREEMPT_RT, even dumb STEP/DIR type stepper
> motor controller drivers may be implemented entirely in the kernel,
> depending on some characteristics of the hardware (latency jittter,
> interrupt latency and CPU speed mainly).
> 
> The existence of this subsystem may affect other projects, such as
> Linux-CNC and Klipper for example.
> 
> This code is already in use controlling machines with up to 16 stepper
> motors and up to 4 DC motors simutaneously. Up to this point the UAPI
> has shown to be adequate and sufficient. Careful thought has gone into
> the UAPI design to make sure it coveres as many use-cases as possible,
> while being versioned and extensible in the future, with backwards
> compatibility in mind.
> 
> David Jander (7):
>   drivers: Add motion control subsystem

Would it be too broad to call this an actuation subsystem instead where motion
is just one kind of actuation?

>   motion: Add ADI/Trinamic TMC5240 stepper motor controller
>   motion: Add simple-pwm.c PWM based DC motor controller driver
>   Documentation: Add Linux Motion Control documentation
>   dt-bindings: motion: Add common motion device properties
>   dt-bindings: motion: Add adi,tmc5240 bindings
>   dt-bindings: motion: Add motion-simple-pwm bindings
> 

