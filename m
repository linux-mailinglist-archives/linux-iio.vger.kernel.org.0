Return-Path: <linux-iio+bounces-146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E697EF771
	for <lists+linux-iio@lfdr.de>; Fri, 17 Nov 2023 19:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03BA1F255F5
	for <lists+linux-iio@lfdr.de>; Fri, 17 Nov 2023 18:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3182543ABF;
	Fri, 17 Nov 2023 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2nrMV+A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5E6D75;
	Fri, 17 Nov 2023 10:22:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32fe1a29010so1435117f8f.0;
        Fri, 17 Nov 2023 10:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700245345; x=1700850145; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28+OcoZSRZ44ezk2etv7iw/x9HVKb7PrNB7Ju/IhAvA=;
        b=Z2nrMV+AIOa/23WpeIJFqwPnRrzJozo3V4CPcM2qL/VC9P2nMLE2Gxt2V31SyqKvV8
         6JIIOKrDUGCwYooJcG1DVVd07XJJ6Fq1IB55p5mebXyx0m44lDttCK6OXAXq1uJJ8Llv
         0wN6+9DQJRJCmGEs4qhvSrFp0PfV5o38WGFTizPhiQShBKmV3svBYoDzDGl6X7w/IMPe
         Yj57mZH5rSdXuNPf4K0OR92eHqb1QtodUuAKoDe7c+BdL6ig+lCS5xhnh+7UkFKUiT7R
         8ykhTSP66Ij/z573JfjQJHu4aqTGLm49u0lf+qHjsV/55xG5FVG+dLVOUwFF+LGzgiz3
         cq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700245345; x=1700850145;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28+OcoZSRZ44ezk2etv7iw/x9HVKb7PrNB7Ju/IhAvA=;
        b=Kxx67XlKnI6ejxKHIRdsEjs6lNVognmEs8qGg18E1iCtv1Wlt1lFv48n6Yv8T/R/rm
         FpuSNGAc8hGWTAU74IPIY3PhQ7VYg/r+q6FC95dZmCu4w9SK6PMlSKjJw5HabtjWHoCN
         g/cZBqkMNL0EUdj/OEuSttLuZop5qDORX8cMpvaIHHuUJgetDTJcfb1xlS7xQdF7Caaf
         Q/RONr75FstdWJRmnANsKfK1oA9z+WPwFgSXEAW+e+j6Jf5ZIavE7t5r2R1FYVfcvwfs
         DRL/9cgGz81eWQQOExK3mAS/M5ZNNMzbXLeN0EtXyVRxZgbt86nmTrRxb2x4pkyiYfFo
         59bg==
X-Gm-Message-State: AOJu0YzAniD3RoVy5qjaMHaAuYezRDBMgIo0GT0hlKHjtaFU7G22L8JI
	wQ5IrUF+d3R7l5g+9K0XMh6v2vzjrIw8yAZX
X-Google-Smtp-Source: AGHT+IF1t7v03+Jq3PUk3N423c1v9yoSgrjMYbw6Gnps2IMI2RKxwE79ydqv/b059cua0KLz2omzpA==
X-Received: by 2002:a05:6000:1564:b0:32f:7ae7:da49 with SMTP id 4-20020a056000156400b0032f7ae7da49mr17589538wrz.51.1700245344512;
        Fri, 17 Nov 2023 10:22:24 -0800 (PST)
Received: from tp440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id a18-20020adfeed2000000b00327de0173f6sm3014136wrp.115.2023.11.17.10.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 10:22:23 -0800 (PST)
Date: Fri, 17 Nov 2023 20:21:59 +0200
From: Sicelo <absicsz@gmail.com>
To: linux-iio@vger.kernel.org
Cc: maemo-leste@lists.dyne.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	linux-input@vger.kernel.org
Subject: supporting binary (near-far) proximity sensors over gpio
Message-ID: <ZVevR_ajeB1jfDS9@tp440p.steeds.sam>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

Some phones have 1-bit proximity sensors, which simply toggle a GPIO
line to indicate that an object is near or far. Thresholds are set at
hardware level. One such sensor is OSRAM SFH 7741 [1], which is used on
the Nokia N900.

It is currently exported over evdev, emitting the SW_FRONT_PROXIMITY key
code [2].

So the question is: should a new, general purpose iio-gpio driver be
written, that would switch such a proximity sensor to the iio framework?
Or evdev is really the best place to support it?

There are a couple of people who are willing to write such an iio
driver, if iio is the way to go.

Regards,
Sicelo

[1] https://media.digikey.com/pdf/Data%20Sheets/Osram%20PDFs/SFH_7741.pdf
[2] https://elixir.bootlin.com/linux/v6.6.1/source/arch/arm/boot/dts/ti/omap/omap3-n900.dts#L111

