Return-Path: <linux-iio+bounces-16208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BAA4A606
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 23:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6392D189C4DA
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 22:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B91DEFC5;
	Fri, 28 Feb 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="alilDZPJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1841DED44
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782209; cv=none; b=h8A4yhJuZka6uy4JwamCUeQcgdK4bYp+z3wN0ckrFJGhYXy01xrFSVVu74492+6dpgDpC6gOQzlOYfFMNpKpIGiQq3pDFsUSHxMM5BeyRX1FHVbVZIhIVnwK8+lUTTis0Gz5k5ot3h7WWOPCabJ04CLrKO0hoSDe3KFhkcVK+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782209; c=relaxed/simple;
	bh=WjShl4asHGGb+9sZPLLkfQ2fhMhhM9eCifpjK1TQcfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reoRsBw4fSkxeDABeB/d61hlQstcl0RTu1m3DFLwaapoJDAsQt04Pt6fKJjjZTQpKhCa4tLkwq+iL9E1SC693Odb/AaTR+VZZnTudA4ZX8R7NiipNaVqSLC9V0F3mvTsTKlJHw+rtkP0wU4eU5px8gWQo7PPSQqT4WLcfRzrDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=alilDZPJ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f40ad1574fso1872078b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 14:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740782205; x=1741387005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zhpx158jJJx5wQGS8QxSe2zVZf1/q36dI/wVrjVqjc0=;
        b=alilDZPJogpT7vC2HBtz18bYmoHQ1HUTZjCSB90ELejPijhoG2cDQNE14jiHGQkFIg
         vVKBbC88m64LDuVyEzbREjS8BeuTvA6XVl630THB+K0NH3A4DfJGCF/0scdjREXwnbke
         Uq23QnVfK6y4EGWVXFYI9X9TKqPCnPEMqTLk7J2CjSKcYKIe4hc9o7DOnppSSXiKJGRJ
         hvUMJdlGTr7ESlDUlwQdVXKzY3dLj4GyreW9tu4pirPG06Yb/0VLgxLMtEiGFjRDuMjc
         cbx16S1KPkYqgDr8Ufrwz3JRTH/1z5QsvWjn3ijald0KwXIggd9xt1gkiPOvuOF63juI
         tZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782205; x=1741387005;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zhpx158jJJx5wQGS8QxSe2zVZf1/q36dI/wVrjVqjc0=;
        b=E5r5OAbQk6k4P1IlfQc4osbIBkFTCESzl1aT/6gWfHc4sa4XPjxi3H/xeSMF0pqG0V
         wIEFmTfMDpgLgMchvjEHyEJJeC1uz1tEnka0ZndQ9+ormOdFzrgatTYYPaaSkEfSymoZ
         T9a4J9N3Q3A4ugpObNCmZBVqhudbCU4y87qIEc2XqWbKfQT/hd66mn9OztGSTVKL2Eih
         6vDvdfOggfvUWsAPQQCI5cbcy5N6irDycV+vOiSoYGvRQTcJhr/7NDM9m4PoTrFmoNUt
         82u6E/vKTk2A2tYWVe8kNgh8xbOKwBkDQ6alnVgTAHrbOnIDvhOp2NcJ+1JYaD3+VLeB
         b5Nw==
X-Gm-Message-State: AOJu0YwxK5IXB5G0wjEkKLs82Ge1j+LLncfQJjWK7Ao+Z1YaMSRMfKhl
	5JLRWAkB+EPgBJ1NYLvoApF+VULFxDiHRWTDpuWwSCveg8E1hNLgTaxoCSzDfdU=
X-Gm-Gg: ASbGncuJoZCCXPM/y1fwmGXiEBJ/+RsD/xaxwas4Vv4Qak9JekUkZSufwYXbW3XHc5x
	MtMc85nYmPe8ydqZKKx3rc4DtHnok/3w+O/8ipKriG5tZtWCB81kWcLmvtrcfrSd8JQmevy8IQY
	nPbavRz9grpo3Ti8wdi5ccL9H45oEsNfLVY1EXrHG9N+lpaMb9ALn1UVyHEg6S5/+DdaGdjLyI7
	wjNPKJ4FeQAUvtnQlgR+ZisD79vADAMrqfNLj3ZY/YsWwk/pLSqutopGV2xQAcuQo/ugz5253jD
	xHpPIoVcXJ/zUvqqQNudtg66qOPPUhBJf+kBAP+/FpSbDAnRV9m41Wr0hoiqmmKEQ8qnmUk7TlL
	ED0ahDQ==
X-Google-Smtp-Source: AGHT+IFN3MmzDNTbHTqpXUZabE7IypJM3ecDdx2I6x2htebjZZEnVw9OC67bBNq8u5CxMLqcH71Vcg==
X-Received: by 2002:a05:6808:640f:b0:3f3:dd2f:6a9b with SMTP id 5614622812f47-3f5585f4d02mr3364363b6e.30.1740782204813;
        Fri, 28 Feb 2025 14:36:44 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f5507c3fb7sm822158b6e.46.2025.02.28.14.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 14:36:43 -0800 (PST)
Message-ID: <7fb93572-3ef4-47f2-b505-669af742dee5@baylibre.com>
Date: Fri, 28 Feb 2025 16:36:41 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
To: David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-2-david@protonic.nl>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250227162823.3585810-2-david@protonic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 10:28 AM, David Jander wrote:
> The Linux Motion Control subsystem (LMC) is a new driver subsystem for
> peripheral devices that control mechanical motion in some form or another.
> This could be different kinds of motors (stepper, DC, AC, SRM, BLDC...)
> or even linear actuators.
> The subsystem presents a unified UAPI for those devices, based on char
> devices with ioctl's.
> It can make use of regular gpio's to function as trigger inputs, like
> end-stops, fixed position- or motion start triggers and also generate
> events not only to user-space but also to the IIO subsystem in the form of
> IIO triggers.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  MAINTAINERS                     |   8 +
>  drivers/Kconfig                 |   2 +
>  drivers/Makefile                |   2 +
>  drivers/motion/Kconfig          |  19 +
>  drivers/motion/Makefile         |   3 +
>  drivers/motion/motion-core.c    | 823 ++++++++++++++++++++++++++++++++
>  drivers/motion/motion-core.h    | 172 +++++++
>  drivers/motion/motion-helpers.c | 590 +++++++++++++++++++++++
>  drivers/motion/motion-helpers.h |  23 +
>  include/uapi/linux/motion.h     | 229 +++++++++
>  10 files changed, 1871 insertions(+)

Ooof, this is really a lot for one patch. Makes it hard to review. 500 lines in
a patch is much easier to digest.

But before commenting on the details of the code I have some more high-level
comments. As I mentioned in my reply to the cover letter, I've gone through the
exercise of writing some motor control divers in the Linux kernel that have been
used by 1000s of people that used them to build everything imaginable using LEGO
robotics over the last 10+ years.

From what I see here (I didn't have time to really get into the details of it
yet, so maybe missed some important details), it looks like you are trying to
do motor control stuff in the kernel so that the interface for a basic H-bridge
will be close to the same as a fancy stepper motor controller. We tried doing
something very similar because it sounds like a really nice thing to do. The
kernel does everything and makes it really easy for the users. But what we
actually found is that it is not possible to make a solution in the kernel that
can handle every possible use case. In the end, we wished that we had a much
more low-level interface to the motor controllers to give us more flexibility
for the many different types of applications this ended up getting used for.
Having to modify the kernel for your use case is too high of a bar for most
users and not practical even if you are a kernel hacker.

When writing kernel drivers for this sort of thing, I think the rule of thumb
should be to keep the driver as "thin" as possible. If the hardware doesn't
provide a feature, the kernel should not be trying to emulate it. So for an
H-bridge I would want something that just provides a way to tell it I want
fast-decay mode with some normalized duty cycle between -1 and 1 (obviously we
will have to multiply this by some factor since the kernel doesn't do floating
point). A duty cycle of 0 will "brake" the motor. And then we would need one
more control parameter to tell it to remove power completely to "coast" the
motor. I guess this is what the "basic_run" and "basic_stop" are other than
the run seems to have speed instead of duty cycle? The kernel shouldn't be
trying to convert this duty cycle to speed or have a background task that tries
to provide an acceleration profile or turn off the power after some time. Just
let the kernel provide direct, low-level access to the hardware and let
userspace handle all of the rest in a way that makes the most sense for the
specific application. Sometimes they might not even be connected to a motor!
With the LEGO MINDSTORMS and BeableBone Blue, the H-bridge outputs are
hot-pluggable, so they can even be connected to things like LEDs or used as a
general power supply. (A reason to call this subsystem "actuation" rather than
"motion".)

Another way of putting this is that it was very tempting to model the actual
motor in the kernel. But that didn't work well because there are so many
different kinds of motors and related mechanical systems that you can connect
to the same motor driver chip. So the driver really should just be for the
H-bridge chip itself and not care about the motor. And the rest can be put in
a libmotion userspace library and have that be the convenient API for users
that want to get something up and running quickly.


