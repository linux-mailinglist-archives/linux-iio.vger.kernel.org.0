Return-Path: <linux-iio+bounces-7633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696493229C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 11:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7171F2353C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F151D195B33;
	Tue, 16 Jul 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAluaaIL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5895FEE6;
	Tue, 16 Jul 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121659; cv=none; b=RLWg05haUVgN+UjXr5wIWEqq5fH/VogymWn9/mDBUtW/oGRXpNrKD+r5x9MtYn4PfmEwDcPUAmnkUlVSAKML/rPREUCUWHRg+gBjUbOCnjf5hFhug+wpgXBmW4fpUO5M6j1NjoRsv4ZWyn2CSqAEBWnyJ/g4QD/lX12Qy0jwsIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121659; c=relaxed/simple;
	bh=DeomL/J0ih7QGM6I3eGgzhI2RkGQ4kYfyHnuweLDEf0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BKSW4sxFjA7OcEwM8EO5V/BTDD0OlRkvUFukbJ3V/DRdFSnT6sCoQok3HmbBiqElcxfUQ8VXraShd4daePS7rwsNrK7aG5EZwNvjXOx4sxXbGI4ht77TTnmxmLi8QIY4WzKR7q+RU5blfnU1yJmT/dffGLRUapaaMtyQBBMAXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAluaaIL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so41244515e9.0;
        Tue, 16 Jul 2024 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721121656; x=1721726456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7BqESmx+IIydtJebt5JNYngfdr0KF7zc1P0PpXHnVk=;
        b=kAluaaILtpWcNpGROK6u0W4DAkvn3a+XJy1ty/8pUkPd4yxW7p38tgiYkxsE0ptsFb
         HMwtzqpmkLTS91uG4EagaVgEjy1OYqvPzAeR1ZPV+uDP5d9MDC2dtp87AySvSO0mbQ3x
         SjjD2/O57faE9XHaqbjYL//5//KgEWJq/UAhNrf3/a/1yObULwiPlqRDzuy7UZjnOjIr
         rXIIr8Lql+jg/arqYpU2NT4XntA4wjaAziUrfoI09jx39XzlhGNsS/lVzcErx2ZwBDfu
         TxdFmyMR8eLUfYoRcCv4X2OzhYznfUK1LZiK3IG6wW+Y3UuS7iCHFWSjtY8eIGHYflmE
         UEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721121656; x=1721726456;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7BqESmx+IIydtJebt5JNYngfdr0KF7zc1P0PpXHnVk=;
        b=ct4JfU8RkrADaPy6ZD9fL5QU19W8lbNcb6zyShca82ZW+SAalBjiY4K689Y0ciTH8e
         FZVczqG2UHQ9+r7hec0lfit1L1Ts7DoBojRPWJhAcDJ+APGzkc+ny+Uk3fOahgvSWu1w
         IGtwfboK1tQeoOJCx4lxIUf84GYRtRxPoL2lV4EBNRJnDTCtR5HEWm05itIOdsP6IOxd
         3fMRBkVm8u0072HyaoSOYATqmrdd5EZcMZxLSxTer31nKyfyj5zS64nGTlrrEGchyRgd
         K43gPq+Vv5FeWKx/dgiUx4qTU2WQjSkOStzzApzCVxA+9J3lhMJ2JF2npyxh678jit5u
         qYsA==
X-Forwarded-Encrypted: i=1; AJvYcCUUb6QasbjP6/0jf34nPRr7sR4WDOQVXI9FcF4h+4L58X9SRzUeLIPch4NMU2/N5OjXMRei1RfeJi9YtGrS91RhPZLoTd2wj71CyvxhkQIz9U1DulewSCQi+NpuRI1SsNmYf/PuYxgbd51U6QfcdO+l1eP4S9JTQsGMUf9/yvMYIk46RQ==
X-Gm-Message-State: AOJu0Yy96mqy9UJ9FMfYDxTnIGq9HnzWwaTfWvQoIAp61fgywEoupIic
	rVeEEgggxJIIklvH0pbAW04ouaZiag2ZPapYAwPGzbp/zqzkvGSZ
X-Google-Smtp-Source: AGHT+IFZMv0uB6Kdauv0Sn4FjZMJf3VleAYBZ2v4VUWwXZVoVHVnISNAUuB4x5u5DT1HwIQpAHMq0A==
X-Received: by 2002:a05:600c:1d12:b0:426:6416:aa83 with SMTP id 5b1f17b1804b1-427ba64d454mr12536575e9.6.1721121656224;
        Tue, 16 Jul 2024 02:20:56 -0700 (PDT)
Received: from localhost (host-79-55-57-217.retail.telecomitalia.it. [79.55.57.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e9a809sm116540225e9.28.2024.07.16.02.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:20:55 -0700 (PDT)
Date: Tue, 16 Jul 2024 11:20:54 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <66963b764ac3c_706370bd@njaxe.notmuch>
In-Reply-To: <20240713112153.3576fc2a@jic23-huawei>
References: <20240704-iio-pac1921-v2-0-0deb95a48409@gmail.com>
 <20240704-iio-pac1921-v2-2-0deb95a48409@gmail.com>
 <20240707160442.6bab64c9@jic23-huawei>
 <668bec2a8b23a_6e037017@njaxe.notmuch>
 <20240708173439.000070b4@Huawei.com>
 <668cf2f3ece62_1f6ba37012@njaxe.notmuch>
 <20240713112153.3576fc2a@jic23-huawei>
Subject: Re: [PATCH v2 2/2] iio: adc: add support for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jonathan Cameron wrote:
> On Tue, 09 Jul 2024 10:21:07 +0200
> Matteo Martelli <matteomartelli3@gmail.com> wrote:
> 
> > Jonathan Cameron wrote:
> > ...
> > > > I could add the shunt-resistor controls to allow calibration as Marius
> > > > suggested, but that's also a custom ABI, what are your thoughts on this?  
> > > 
> > > This would actually be a generalization of existing device specific ABI
> > > that has been through review in the past.
> > > See Documentation/ABI/testing/sysfs-bus-iio-adc-pac1934
> > > for example (similar in other places).
> > > So if you want to do this move that ABI up a level to cover multiple devices
> > > (removing the entries in specific files as you do so).
> > >   
> > I would do this in a separate commit, would you prefer it in this same patch
> > set or in another separate patch?
> 
> Separate commit in this series as otherwise it's not obvious why we are
> doing it. In theory should be before this patch as then what you use here
> is already documented, but I don't care that much on the order.
> 
Just a few more questions about this point.

* I see 3 other drivers exposing the shunt resistor attribute: ina2xx, max9611
and pac1934. While the unit for first two is in Ohms, for the latter it's in
micro-Ohms. What should be the unit for the generalized ABI? I would guess Ohms
as /sys/bus/iio/devices/iio:deviceX/in_resistance_raw.

* If for instance the generalized ABI unit is going to be Ohms, should I still
remove the entry from the pac1934 even though it would not be fully compliant
with the generalized ABI?

* To cover the current exposed attributes, the "What" fields would look like:
from max9611:
What:         /sys/.../iio:deviceX/in_current_shunt_resistor
What:         /sys/.../iio:deviceX/in_power_shunt_resistor
from ina2xx:
What:         /sys/.../iio:deviceX/in_shunt_resistor
from pac1934:
What:         /sys/.../iio:deviceX/in_shunt_resistorY
Does this look correct? I think that for the first two drivers the
shunt_resistor can be considered as a channel info property, shared by type for
max9611 case and shared by direction for ina2xx case (maybe better to remove
"in_" from the What field if the type is not specified?).
What seems odd to me is the pac1934 case, since it doesn't fit in the format
<type>[Y_]shunt_resistor referred in many other attributes (where I assume
<type> is actually [dir_][type_]?).
Doesn't it look like pac1934 is exposing additional input channels, that are
also writeable? Maybe such case would more clear if the shunt resistor would be
an info property of specific channels? For example: in_currentY_shunt_resistor,
in_powerY_shunt_resistor and in_engergyY_shunt_resitor.

* I would go for a simple and generic description such as:
"The value of current sense resistor in Ohms." like it is in
Documentation/devicetree/bindings/hwmon/hwmon-common.yaml. Should it include
any additional detail?

* I am assuming the generalized API would have Date and KernelVersion of
today even though the original attributes are older.

* Should this ABI be inserted at any particular place of
Documentation/ABI/testing/sysfs-bus-iio or just appended at its end?

Thanks,
Matteo

