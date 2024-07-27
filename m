Return-Path: <linux-iio+bounces-7956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A593DCC6
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 02:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8191F24025
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA7F110A;
	Sat, 27 Jul 2024 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQxbbwb+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938A139F
	for <linux-iio@vger.kernel.org>; Sat, 27 Jul 2024 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722041681; cv=none; b=FLWqqfq6Fz9F83hk7BNTOH/B9TLm1ro9BGWjgf1CNYGhnPol3Ijax6GDaYyHGC2F9XfqyTbUuvi57jaj8j/UM9TeXFNbDcdUbCO8qbKNN3RufsDo5hJi8xKMGFGGJGUH+Dyts5xk1Oi4UM2jPONYoTIEp03G+ENrW9OSWsS1dvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722041681; c=relaxed/simple;
	bh=bu4mDSABSKnKtbO4yWpjRm5cVW597hRAWEtorXMEaPc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Rach8tW+tQoSC92RmA33dO2I5B/RqgeX3Jr9gGPnwc1vSB/j+dqrRG4Ugv/C5acMeyXfrWcShVuJoBf/0+GFcYC9BovYnQcpYRfkl49r62LSV15NwEPpB5xTvlqQUfEDqjDhv/XB8jKdfPcD95fA7xlxTW98RQzJP/uWKlBPCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQxbbwb+; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so25165031fa.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 17:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722041677; x=1722646477; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pTlxOKp4rxTDPEkCoAPcLXRu9yi9zO/O/GrVEtx61Jw=;
        b=HQxbbwb+tYCqzcqufCOV92aUO7PNyR6vhtYVhM4vkjx4OnTK6Vc8xwFTtjU+gACAVT
         BMgGoxbpJh6+OEtNm/MEj85VLJ8Gebti42Db67grxhxEOWY97/LOQ+dAKYxf5JAGiEWV
         doPD+65jE26RMihifJFGHpPpiqgn2yEcyL9qCVW9E2Rl5wGLUjk9tBEgK5DLRmqC/VDy
         YAld7g+wcvZl9I5fJe8CAVnTnD/ov0ZP1uyJE1j1OCY14O/DSTcO58n47SgtmSasz6KK
         zXFZePBiaMsek5bA3RTVtqOvqpg4PavwNhD3lZ7kBo/iFyV02szR41osaeL/zbY/4Bcs
         YMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722041677; x=1722646477;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pTlxOKp4rxTDPEkCoAPcLXRu9yi9zO/O/GrVEtx61Jw=;
        b=QlXvYkBMYMvqWA4z0OPFbeL84WhsSlwhL45OqkT6E0nJJ5zlWj/ZWaqFrIQeXq6MPv
         buWOAvO3xmxZG1hNA08NMTr/tmQxPWgM5iC0O+cBldGRv07uwaiH4DI1SFPS6+XUxHyS
         CN+SZMHK+HaoeI3N5+68t1AUCE80r4/+eRMpZgKh+Ixrfea0PMvMRz+9HQ/y4RoBdzCR
         8yS/JWPljGfzy5cq0X+xSTM3zICgE9GDx9eCDGFIrmlhHnIa5eE0HITJq9ttSszevK6S
         bG7NzgsLVupgf0g1n+IVqlim4UJdABnVrQT/nHTJJdwd/gcOEx7pq3tIOC04rb9QpZhR
         HJCg==
X-Gm-Message-State: AOJu0YwbNDdvn0xpXCNmQIpFXGZAuEPp2SgZX9bP8lGXjzb80177IZK9
	dQOlXEARr1X5rZCAuEndp/pOm30chfS8BjCMysIjXfYK/DVhowBctsAUkUIlvcSbE7E+ppIedgu
	OxNRt9VhCPNTxSZlXNcvurfilydtog1Ta
X-Google-Smtp-Source: AGHT+IFAHH/Nt2U4Gi4dkzxtkDWlryXdHrlbiFW/y8xUifkWis8iC2T+FXrXkbSRaqjzR/pw/wNjR1F1bw2T7E0bIDY=
X-Received: by 2002:a05:6512:68e:b0:52d:3ada:4b6b with SMTP id
 2adb3069b0e04-5309b269a7fmr1314493e87.1.1722041677309; Fri, 26 Jul 2024
 17:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Reichelt <chris.reichelt@gmail.com>
Date: Fri, 26 Jul 2024 20:54:26 -0400
Message-ID: <CAJHAb7rOaxNo+r=GQ=P=-7jqM8jNuVJXbSki59PP6LUQ1pQNLw@mail.gmail.com>
Subject: iio: dht11: support for more accurate DHT11
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Apologies if this is in bad form - it's my first kernel mailing list post!

I believe this is a question for Harald.

I am working with DHT11 temp & humidity sensors that fail the decode
logic within your driver.

The sensors I have came from two sources - The first from a 'Sensor
starter Kit' for arduino, the second was a batch of 5 from a random
Amazon seller. They all show the same behaviour.

Despite what the spec sheet says, it appears these temperature sensors
are providing accuracy to 0.1 degree which almost always fails the
check on line 155:
} else if (temp_dec == 0 && hum_dec == 0) {  /* DHT11 */

I can see from the dmesg logs that the driver has correctly read the
chip, the checksum has passed but it fails decode because temp_dec is
not equal to zero. The dmesg log from reading
/sys/bus/iio/devices/iio:device0/in_humidityrelative_input while
holding my finger over the sensor is as follows:

[ 3457.203647] dht11 dht11@17: Don't know how to decode data: 50 0 22 2
[ 3467.936584] dht11 dht11@17: Don't know how to decode data: 57 0 23 1
[ 3472.435984] dht11 dht11@17: Don't know how to decode data: 62 0 23 8
[ 3476.841252] dht11 dht11@17: Don't know how to decode data: 64 0 24 1
[ 3480.583614] dht11 dht11@17: Don't know how to decode data: 68 0 24 4
[ 3484.515841] dht11 dht11@17: Don't know how to decode data: 69 0 24 5

Has this been reported before? I can patch the driver locally easily
enough or bit-bang in userspace, but surely other people must have
stumbled upon this problem. Would you be interested in supporting
DHT11s that behave in this manner?

Cheers,
Chris

