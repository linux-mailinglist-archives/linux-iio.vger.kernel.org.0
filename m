Return-Path: <linux-iio+bounces-13876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B139FF8D4
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2025 12:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC673A2D5F
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2025 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943BF1B0F22;
	Thu,  2 Jan 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRNZOcdt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F41B0429;
	Thu,  2 Jan 2025 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735817516; cv=none; b=qKs/QfNPQd1gjXsS01rM9SQnqG+ChVim7GdOhnDZrdpkraTxDpOPLek3pdJR7RwLP4r3FjnExxfak2Jkb0p6xoXpuTIgUHAM1eb1sqGH9JwjYaEfYDFaTbKJd1jR4vxO099VxGxHVrciwtFGspIcjujt6BdTU8uAlzqaS9cfQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735817516; c=relaxed/simple;
	bh=Sy9qvv8oQoq/9h9qcBbWefVUptXmIhFXkPfMNNuFGtY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=UIlNykMIoVFEn4hiJVYPBJAz25aCIGv4d/LQUm80E7p3o9hvx50d11Ru11lbuBmP8AnlxrJ8MAo6KDwfBp0+XSZZvPjUJ/TLhHjigmBtFFsg4igkzUAWY9PDjouKRLYjJTTaIxGH06Ihh0yi/vf+0aEBfCP+AK01zRcBO3KdheQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRNZOcdt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43622267b2eso119171235e9.0;
        Thu, 02 Jan 2025 03:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735817512; x=1736422312; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=6wcHiBkRkYS13bhGe02lr8rGk3XbGLMMM9eQ3HQy9pc=;
        b=GRNZOcdthYgmDweW3FCjOcs1LRG4MQwbyo7astFLtv9qLjsAioHNYsPEekFFRRTcT+
         NYFmcnJx+vBFCxhnYNwWyFhBaNF/6OjdCrue5K3wzmY3UtNofyKcugWO6rN0SsGkgc4y
         5O8oIckw+JVrD3fxlCSkEz6gorKcyUR0NPseP4NDIQ8Mj8UVsySBBqJw0Q5h9Jvq+fwZ
         SVODZLh2K1BTmwVBI1NW6heyMpYyhRcW30Snp77F99wzVbVDyNPBC5a6sM7EctU//Kb/
         1vQfqqbK3xTQW5En7hAnu+7RaDusCh97Y8kZd+/jn68rO2f6sV/E0ktc3qX1PuylcQqg
         pGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735817512; x=1736422312;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wcHiBkRkYS13bhGe02lr8rGk3XbGLMMM9eQ3HQy9pc=;
        b=vsPvA5INGzafz/dzcA4o4u6Rgl2clb2fHQgdq+LKXuc0+pBW7rte2D0YPAGvncqyoe
         F3Flrx2nLUutsxOHabgIg3yL/NGHX69HZ+X45Co5YGSGlSR2s5e8XQybvWbRMmXH6vQP
         CsJdgKT/2KOt4cBwl8jtFVyCjMlGW0nP11QehN4UcwGH9qDoGg5rKxSYLH2ae9+03IrZ
         w4ek/85scBXs5OPh/eRWi75ImNpzKjCy6/F6wCm5kslXAWaU/Fe0pGBnp+P5lwwD8Ae0
         q7xIzNDJaLXtk24nrfsgpQpm0KpdY7hAK7+UUmesD0kKyYn1N3AzuSuFIOeozh4pObNl
         Gymw==
X-Forwarded-Encrypted: i=1; AJvYcCVXkEnWbq3nynlWsQG2lU6ddZSvpiDNfXaXStxX3yWXA24NVjL/icvfwY69Tb++s6HTP/WLTSRtiEM=@vger.kernel.org, AJvYcCW6Yu5VJtVA8G34aWE31NAXa0YzS/4rFdR7nVVFm+WEZgs5Q2rqMvap/45HE0VKGg5fCk3BDc3GnDMr@vger.kernel.org, AJvYcCWaCumiu4eb82vqAiQeyyrLSY/gU0U0TRCqLZ/vnPIqPreqsAU3fbJif5yvRYF8bXnasPPNy662HsfyucrD@vger.kernel.org, AJvYcCXSwQgl3D0Z9chRmLGoH82K1ffUu3X1dk8oTbr6h7oe6AabLvbjhJYv8bSIRdBm5t7BkXKmHWmHGxjV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8uPrlvwnItlf6qW6nBL0EX7lhBMoN7j4jsIQMSRwNJzl5qUuO
	dBqdfSkXKQS+e7EpjnEkAxT8S3fRbR7h2P5zgrKFNuR4x98rgFdh
X-Gm-Gg: ASbGnctmfBL84h78mCLJdNraEWAIXYDYndLNNsYp1mu2tWrS+Og7Ty0LZU7gqXuvyL0
	g3RHSzQgt+dJfcoe6rTOCNkyXxAgZ0mfoY02ec1zFWxNG0AyTinzVAD+UUD1V55LGRy1CXXHKOV
	0zSKY86YDLMbAcRjtxJWG8a2GmWQ7IXKYUvPIdq7N4Idw9cJXzHJRnWzVTiBTzOiDLREzVui6A8
	yMUnoLqtvfxBUZSTr5qLNc2QMk5oOVanAhk+T6LtmsbSGJ5e8r5MMQa6hdqu9ZR
X-Google-Smtp-Source: AGHT+IHV4jPTiUqrXA+3RgaNsECQZU0VOfvJYgGlt1bAEMcUljMwbh7ep6IPt0Qu2f8zTyeQYe/uOQ==
X-Received: by 2002:a05:6000:470a:b0:385:f092:df2 with SMTP id ffacd0b85a97d-38a221faae4mr33240914f8f.34.1735817512042;
        Thu, 02 Jan 2025 03:31:52 -0800 (PST)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm37384777f8f.30.2025.01.02.03.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 03:31:51 -0800 (PST)
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
 <1535049f-1e4c-446b-8070-6f51877b2649@gmail.com>
 <20240608141832.7fdc9eb8@jic23-huawei>
From: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To: Alex Bee <knaerzche@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, wens@csie.org, ee.jones@linaro.org,
 sre@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, lars@metafoo.de,
 andy.shevchenko@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
 michael@walle.cc, samuel@sholland.org, linux-iio@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/13] Add support for AXP192 PMIC
Date: Thu, 02 Jan 2025 10:44:16 +0000
In-reply-to: <20240608141832.7fdc9eb8@jic23-huawei>
Message-ID: <cItZox1cacPR8zQiMUpDztLjYyVXenxO@localhost>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Alex,

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 7 Jun 2024 17:12:51 +0200
> Alex Bee <knaerzche@gmail.com> wrote:
>
>> Hi Aidan,
>>
>> Am 17.10.22 um 01:43 schrieb Aidan MacDonald:
>> > This series adds support for the AXP192 PMIC to the AXP20x MFD driver
>> > framework, including support for regulators, ADCs, and AC/USB/battery
>> > power supplies.
>> >
>> > v6 is a resend of v5 from July -- the patches haven't changed at all
>> > but I've rebased them on the latest git master branch.
>> I'm not entirely sure if I've found the latest version of the patches - at
>> least b4 didn't find a newer. It looks a lot like only mfd and usb-power
>> patches have been applied for some reason. Are you planing to resend the
>> other ones?

These patches were part of porting Linux to a music player I had, but I
lost interest in the project and I'm not really paying attention to the
mailing list anymore. As Jonathan already indicated, there were some
cross-tree dependencies on mfd, and I think on regmap-irq as well.
I didn't realize at first how much of a headache it was to deal with
these things. :)

Eventually I resubmitted the mfd patch separately and did the same for
the USB power patch (after removing the mfd dependency) so both of those
got merged. Didn't get around to doing the other patches unfortunately.

Regards,
Aidan

>
> This was delayed originally by a dependency on a header in mfd and that is
> obviously resolved now.  I think everyone was expecting a resend
> of the series or for Lee to pick up the dependent ones and so we all
> stopped tracking it.
>
> Anyhow, I had the two IIO cleanups already, but I've now picked up
> the 3rd patch (where the dependency was) as well.
>
> Thanks,
>
> Jonathan
>
>>
>> Regards,
>> Alex
>>
>> > Aidan MacDonald (13):
>> >    dt-bindings: mfd: add bindings for AXP192 MFD device
>> >    dt-bindings: iio: adc: axp209: Add AXP192 compatible
>> >    dt-bindings: power: supply: axp20x: Add AXP192 compatible
>> >    dt-bindings: power: axp20x-battery: Add AXP192 compatible
>> >    mfd: axp20x: Add support for AXP192
>> >    regulator: axp20x: Add support for AXP192
>> >    iio: adc: axp20x_adc: Minor code cleanups
>> >    iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
>> >    iio: adc: axp20x_adc: Add support for AXP192
>> >    power: supply: axp20x_usb_power: Add support for AXP192
>> >    power: axp20x_battery: Add constant charge current table
>> >    power: axp20x_battery: Support battery status without fuel gauge
>> >    power: axp20x_battery: Add support for AXP192
>> >
>> >   .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
>> >   .../bindings/mfd/x-powers,axp152.yaml         |   1 +
>> >   .../x-powers,axp20x-battery-power-supply.yaml |   1 +
>> >   .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
>> >   drivers/iio/adc/axp20x_adc.c                  | 356 ++++++++++++++++--
>> >   drivers/mfd/axp20x-i2c.c                      |   2 +
>> >   drivers/mfd/axp20x.c                          | 141 +++++++
>> >   drivers/power/supply/axp20x_battery.c         | 142 ++++++-
>> >   drivers/power/supply/axp20x_usb_power.c       |  84 ++++-
>> >   drivers/regulator/axp20x-regulator.c          | 100 ++++-
>> >   include/linux/mfd/axp20x.h                    |  84 +++++
>> >   11 files changed, 856 insertions(+), 74 deletions(-)
>> >

